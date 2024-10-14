Return-Path: <linux-kernel+bounces-364842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C06D99DA18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E95E1C21133
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DCC1D5AA4;
	Mon, 14 Oct 2024 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="puq9HXMR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8517BD3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728948343; cv=none; b=c3FtIDjy+5/RiPOpO45vhihoGsd6Ks9GDhoezQ/u+E1xZ9ImiwHuYfnp94GimcvKh1v0nJFMyca+AQGFRjMuK1QVWfUno4uxLtsWb93QHZfTe1T18AUUca5QjTFgGM6lysiac7Z2wC2G2Glb1GtGWjiUP7NuRa0rYHnJpOLmX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728948343; c=relaxed/simple;
	bh=48/1tWpBNpcNkABxREGCkw7ozjYcqY+qcl5lrHfD0uY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jwrShzD6OwR0xwbAfAYd9bKlITNSjHl7mct2kqV9I0EjzUrl/fJ9tVSTm1YerkcWs+eoKlEl+Gcd0/aJkkRhY29M5wuqhJex2cSygbNkDed9e0Yahsyt6RONhs3szlqXqg3/ZY8EsYUJOyaL+CMP7RXJquzEv2QctUSrJhtC3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=puq9HXMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A16CC4CEC3;
	Mon, 14 Oct 2024 23:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728948342;
	bh=48/1tWpBNpcNkABxREGCkw7ozjYcqY+qcl5lrHfD0uY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=puq9HXMRl5VMF9cVvtRHVU08G1XuO/JjTgHJrBbT+N3q2LWjoDvzRBX8uNu5WnZX+
	 GLYwI4z8wvLGlKFeRn8si4CiuF1JsF9ug8SRaGkBtnU4lS2DuRjk7DHfbqJcnVaE44
	 p001S+ueiRDyWIay86xzrmqS4O5s8nGVRoWt5lC8=
Date: Mon, 14 Oct 2024 16:25:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Xu <weixugc@google.com>
Cc: Yu Zhao <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mglru: only clear kswapd_failures if reclaimable
Message-Id: <20241014162541.a3049d0824a2f9b22221c17a@linux-foundation.org>
In-Reply-To: <20241014221211.832591-1-weixugc@google.com>
References: <20241014221211.832591-1-weixugc@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 22:12:11 +0000 Wei Xu <weixugc@google.com> wrote:

> lru_gen_shrink_node() unconditionally clears kswapd_failures, which
> can prevent kswapd from sleeping and cause 100% kswapd cpu usage even
> when kswapd repeatedly fails to make progress in reclaim.
> 
> Only clear kswap_failures in lru_gen_shrink_node() if reclaim makes
> some progress, similar to shrink_node().

That sounds bad.  What triggers this?  Can you suggest why it has just
bee discovered, after 1.5 years?  And should the fix be backported into
-stable kernels?


