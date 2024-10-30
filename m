Return-Path: <linux-kernel+bounces-389689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878629B6FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B645C1C20F55
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F551E3776;
	Wed, 30 Oct 2024 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oFtFiI+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A4E1925AE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328011; cv=none; b=cvxM77XjE4riT51DMPxRqQ7XOAI2L5qSd1zpBkzTeUOT91gADLprYbup0bMNxoTJHZiMMtpm+4VPQKkofuFQEzPNPjcuUdY7gNJNs2XMOKGkFZMCDo+VFfE3Op0zbzfRp8OQzUjgmnPHwztgrtX/NXoUi2TSdJ7fAYyeD4pO+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328011; c=relaxed/simple;
	bh=kmCaiCfNFt5CSiEveVa8DQBup2LvPrDutJeolCsC3M8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KU1YSZykpm7wml8/W7RpOBDC04VsArY34owL6DwzCIKg1aAR9lZ+R/awynjyvT1j+b/D/Sq5dq0qmf+lJ8Yp56cMRrf0woACsmSxJbw9IclMwWnW4XnjIRg0hoqOuzEE+XAvzLCdr5ZEsrdCOqyUtyKlUvEoLGiBjRZpRyN6zE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oFtFiI+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2871DC4CECE;
	Wed, 30 Oct 2024 22:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730328010;
	bh=kmCaiCfNFt5CSiEveVa8DQBup2LvPrDutJeolCsC3M8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oFtFiI+gpzy/m62bJXxU3w7RSV8rT2AdnnEXeM8Ivol9gyRxSuLbDP89Wh35G4Et1
	 dq9HZ3zK17/mJbsx2q09n/7GOA/Na+1/wWw+S6tiA2Ogw6LaxARNNh8nzDmGfrcK62
	 RsDi9zouag5yRTWN9YzvoMRF661bhOmFQsZXB/b4=
Date: Wed, 30 Oct 2024 15:40:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marc Dionne <marc.c.dionne@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Vlastimil Babka
 <vbabka@suse.cz>, Marc Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH v3] tools/mm: Fix slabinfo crash when MAX_SLABS is
 exceeded
Message-Id: <20241030154009.16b693b53b3c00d2439fd854@linux-foundation.org>
In-Reply-To: <20241030133208.41061-1-marc.c.dionne@gmail.com>
References: <20241030133208.41061-1-marc.c.dionne@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 10:32:08 -0300 Marc Dionne <marc.c.dionne@gmail.com> wrote:

> From: Marc Dionne <marc.dionne@auristor.com>
> 
> The number of slabs can easily exceed the hard coded MAX_SLABS in the
> slabinfo tool, causing it to overwrite memory and crash.
> 
> Increase the value of MAX_SLABS, and check if that has been exceeded for
> each new slab, instead of at the end when it's already too late.  Also
> move the check for MAX_ALIASES into the loop body.
> 
> @@ -1240,6 +1240,8 @@ static void read_slab_dir(void)
>  				p--;
>  			alias->ref = strdup(p);
>  			alias++;
> +			if (alias - aliasinfo == MAX_ALIASES)
> +				fatal("Too many aliases\n");

Again, this is not correct.  It has a potential off-by-one error.

If at this point, (alias - aliasinfo == MAX_ALIASES), we *do not know*
whether there are "Too many aliases".  Because the parsing might have
reached the end of input, in which case we're fine.

A fix for this is to check for an invalid `alias' immediately before we
use it, as I described in the previous email.


