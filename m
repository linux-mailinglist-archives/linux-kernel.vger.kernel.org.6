Return-Path: <linux-kernel+bounces-389734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4FF9B7091
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6928E1F21E12
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B661E5710;
	Wed, 30 Oct 2024 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0IlHqw4n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D31CCB53
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331329; cv=none; b=gAVG8CuDYyxmxgaM9wNmC8onJ9/dgaqRL8UkhIMAWzWxhtzrRI/Z8HF3CZaFK5/7Xykrt9ReXT6vzvo7PbqT9A1+szqQDgLO/UCs3UCdoWqf+7Sc5/9YkbLryF0Vob2UQB1qHoSOgrbdX2zHaYeRMJ3JqumJUX5QIw/MtTIQAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331329; c=relaxed/simple;
	bh=VGb5+kePxnHAvj2Y4Su4IxNhTPMs61I7pCNndF/7rro=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lJSbfMEKswn5mkAE6PSwkLHJqqu5CDgCDXRMgOyJmgUl31uVmc9hfLXWA/1BGrEacTosJPFoRCghY0wpIM5nUQhlnowS2A0yuitA0Uc3nGveuIlgLOjTy8O9Io0ADp1PI57q2G8SQ+eKe2TjGUQE8c2pBmABECJLK2IVAvhPpGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0IlHqw4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDF9C4DDF9;
	Wed, 30 Oct 2024 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730331328;
	bh=VGb5+kePxnHAvj2Y4Su4IxNhTPMs61I7pCNndF/7rro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0IlHqw4nFE6qsPCwf3chn/p4mvn+U9vIdjmV5C9hblndTnlFrfwdH7koPJFJQP5SS
	 HpGKAUnVPfqd1Qq2hbGhLoligRwcdeBfgEDix5qEyxWqlT95gkQ/H9vZCCaaehW8Ce
	 6tI4iwKa8pKYimEsWjEs8IRlW43ygoit9QoCxvlc=
Date: Wed, 30 Oct 2024 16:35:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mengensun88@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 alexjlzheng@tencent.com, MengEn Sun <mengensun@tencent.com>
Subject: Re: [PATCH] vmstat: call fold_vm_zone_numa_events() before show per
 zone NUMA event
Message-Id: <20241030163527.cc9075a4aeb60448873aea73@linux-foundation.org>
In-Reply-To: <1730277457-22725-1-git-send-email-mengensun@tencent.com>
References: <1730277457-22725-1-git-send-email-mengensun@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 16:37:37 +0800 mengensun88@gmail.com wrote:

> From: MengEn Sun <mengensun@tencent.com>
> 
> NUMA events will only be folded from per-CPU statistics to per
> zone and global statistics when the user actually needs it.
> 
> So, we perform this folding when reading the /proc/zoneinfo

When proposing a fix, please always fully describe the
userspace-visible effects of that fix.

> Fixes: f19298b9516c ("mm/vmstat: convert NUMA statistics to basic NUMA counters")

Since v5.14.

The information which I requested will help others decide whether
earlier kernel versions should apply this fix.


