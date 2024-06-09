Return-Path: <linux-kernel+bounces-207510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F0901838
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 23:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668C11C20B15
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BEE4CB35;
	Sun,  9 Jun 2024 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SBXq32p6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562D18C22
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717967023; cv=none; b=YjKqFvHzwfPJ6qYwPVepRwvDRbINlHwC+3gZFV2u/dzwuUFqFiHjmj6u7CH7F+Ru9yKeNkqlgxYPPM7CEEaGXHbc/pgvqhT2N1CU6LliIutTkiZEKISxY1ZXRPEmqmcvyFCWcWUhvYmgEtjImTqO/xAg+t1KFN1FfLXtD87lzJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717967023; c=relaxed/simple;
	bh=snGphHJUe+ClJG+1JDmteR989lcPQOPpXI409fVQX/k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=arFHS/Y6YHtc/1wOoI0jyFWoGOuXwVDiT+2L9jSPdHuMtC/WEWhrByU28wcDzSSUMNKiO/KpPP0eMC4FUS+myUEultY27ZxwvzQMxaO8hrU2xz6hVu4RFZ4to22wX3D0FddxAr1JmTDY1PFNoILjJgHJZi2L2EV/URN0/cBgFmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SBXq32p6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9DDC2BD10;
	Sun,  9 Jun 2024 21:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717967022;
	bh=snGphHJUe+ClJG+1JDmteR989lcPQOPpXI409fVQX/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBXq32p6H/7ickhuNrFoO3gEgYoIeQr/pyGqeAlzxFbLQs0dYYgvFWKSlKBAmWrNW
	 tAQAhRjTr7ccttDKE4J431j2piTjr3rapCyiYmk8guXH/h5Fm464h+l7JwRXF899D9
	 M8Qxasm9kxcjCRR8T+iPNYtCo/ZPzpWPxDbaocpM=
Date: Sun, 9 Jun 2024 14:03:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Leesoo Ahn <lsahn@wewakecorp.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] mm: sparse: clarify a variable name and its value
Message-Id: <20240609140341.14ba3a1c62029771d60059ed@linux-foundation.org>
In-Reply-To: <20240608152114.867961-1-lsahn@wewakecorp.com>
References: <20240608152114.867961-1-lsahn@wewakecorp.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Jun 2024 00:21:14 +0900 Leesoo Ahn <lsahn@ooseel.net> wrote:

> Setting 'limit' variable to 0 might seem like it means "no limit". But
> in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBLE'
> enum, which limits the physical address range based on
> 'memblock.current_limit'. This can be confusing.

Does it?  From my reading, this meaning applies to the range end
address, in memblock_find_in_range_node()?  If your interpretation is
correct, this should be documented in the relevant memblock kerneldoc.

> To make things clearer, I suggest renaming the variable to
> 'limit_or_flag'. This name shows that the variable can either be a
> number for limits or an enum for a flag. This way, readers will easily
> understand what kind of value is being passed to the memblock API and
> how it works without needing to look into the API details.
> 

I think I'll cc Mike and run away ;)

