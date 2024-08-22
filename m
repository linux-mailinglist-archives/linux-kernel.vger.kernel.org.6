Return-Path: <linux-kernel+bounces-296947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1495B0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5979284108
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587D16DEB4;
	Thu, 22 Aug 2024 08:54:54 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E917A92F;
	Thu, 22 Aug 2024 08:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316893; cv=none; b=GuOluf3QDBZZpYf432yN//3/Y1wETgY5OAG8sByxk8M1IF/s8W6Q+52VRwS4QM3PmKQoTBtwTDAzwnAYQH4G/GgYAQ6/NA2yvW8hZgxtoMlBeFzGXiuHBMiepDI0NWHZTy7EWW7w+d7XBN3Y6cLsSI2DYGWJhd3HV5GGBB/yf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316893; c=relaxed/simple;
	bh=YvkOKgd+0I4EuyEY3UCMOPtUUmQAaoAvJr0BVcmT8cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6Ics7VNNGTuDrj+5iBTeVgu9g8qRATv0mItJKsCn0T7IcTfNuVWSvtQsrIKKEps1ruxOIqNJTVwl/r8dynaQNnZ7BNA/Ifl7fn7+m/GRnpdjh6u8JeHhEHN2z1NLx+3I1DfIURlvtWAu6tPfHC95LxEIOArnDg5xuRZM91iySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sh2m0-0002Cm-00; Thu, 22 Aug 2024 10:02:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 64DC2C0899; Thu, 22 Aug 2024 09:58:29 +0200 (CEST)
Date: Thu, 22 Aug 2024 09:58:29 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] MIPS: cevt-r4k: Don't call get_c0_compare_int if timer
 irq is installed
Message-ID: <ZsbvpWxnCRTfWsAL@alpha.franken.de>
References: <20240813-get_c0_compare_int-v1-1-a0a1b007d736@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813-get_c0_compare_int-v1-1-a0a1b007d736@flygoat.com>

On Tue, Aug 13, 2024 at 10:59:08AM +0100, Jiaxun Yang wrote:
> This avoids warning:
> 
> [    0.118053] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
> 
> Caused by get_c0_compare_int on secondary CPU.
> 
> We also skipped saving IRQ number to struct clock_event_device *cd as
> it's never used by clockevent core, as per comments it's only meant
> for "non CPU local devices".
> 
> Reported-by: Serge Semin <fancer.lancer@gmail.com>
> Closes: https://lore.kernel.org/linux-mips/6szkkqxpsw26zajwysdrwplpjvhl5abpnmxgu2xuj3dkzjnvsf@4daqrz4mf44k/
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/kernel/cevt-r4k.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

