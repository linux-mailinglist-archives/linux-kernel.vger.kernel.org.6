Return-Path: <linux-kernel+bounces-365274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9869A99DFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 214DCB227C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4A11741EF;
	Tue, 15 Oct 2024 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jy/VDftk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2D189BA7
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978817; cv=none; b=gU37wzMvzrV8YC1EgIikJw6IIDwXve4VjFTO5cANZ4UaK+KvEkLZuZBoOzs0Adtgln9i1S+oZpk85pMyrVzm8afBKGqXDssokKcRPlgrqYVOclpXtArx4etZl/I3OBwNrtbX1spfLhFB9VwYjTptW4s29YfJ+zOfC/2f6ivZ1Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978817; c=relaxed/simple;
	bh=gEzB43kTLte51hWQZRf/Rhuu5Z6lImp7sPcVeziROcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFhLvIitEeBAZegFhYhcfOg13Rf+BP62mX0rJ6YsESlXY+r35J+qRprlSGP7IYob7Mde9CQmXrIu1M8MnsY+GdOROyNiJ6luSJ+ttfF0S9LwQmh9FvEKY2nwTmv9zY3KeP9Rj2a0s7yCNXbhDvi94Uj9ZYMstexJEKMhnp4PQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jy/VDftk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C6C4CEC7;
	Tue, 15 Oct 2024 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728978816;
	bh=gEzB43kTLte51hWQZRf/Rhuu5Z6lImp7sPcVeziROcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jy/VDftk8Rbx4rIfW/YhieYqU8ilZ43U2XpZzMwSmW85IB4lp9biRAkVdJf+Tl6yO
	 +9D07/oOIsR3mA/EHjbnhimkAR10TS20emawDvU1JezOeaiWQVCqr5kOxBe+X4QTje
	 pwHgMLAjRu0tOl5lNem2QhFJffdZBro2qG+j+gew=
Date: Tue, 15 Oct 2024 09:53:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vimal Agrawal <avimalin@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, vimal.agrawal@sophos.com
Subject: Re: [PATCH v2] misc: misc_minor_alloc to use ida for all
 dynamic/misc dynamic minors
Message-ID: <2024101548-effects-sulphuric-f3a3@gregkh>
References: <2024101416-scouring-upbeat-b658@gregkh>
 <20241015070226.15790-1-vimal.agrawal@sophos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015070226.15790-1-vimal.agrawal@sophos.com>

On Tue, Oct 15, 2024 at 07:02:26AM +0000, Vimal Agrawal wrote:
> misc_minor_alloc was allocating id using ida for minor only in case of
> MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
> using ida_free causing a mismatch and following warn:
> > > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > > ida_free called for id=127 which is not allocated.
> > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> ...
> > > [<60941eb4>] ida_free+0x3e0/0x41f
> > > [<605ac993>] misc_minor_free+0x3e/0xbc
> > > [<605acb82>] misc_deregister+0x171/0x1b3
> 
> misc_minor_alloc is changed to allocate id from ida for all minors
> falling in the range of dynamic/ misc dynamic minors
> 
> Fixes: 0ad35fed618c ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
> Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
> ---
>  drivers/char/misc.c   | 35 +++++++++++++++++-----
>  lib/Kconfig.debug     | 11 +++++++
>  lib/Makefile          |  1 +
>  lib/test_misc_minor.c | 67 +++++++++++++++++++++++++++++++++++++++++++

Cool, thanks for the test, but shouldn't that be a separate patch?  That
doesn't need to be backported anywhere :)

Can you split this up into a 2 patch series?

Also, you need to fix your "From:" line, it does not match up with your
signed-off-by: line :(

thanks,

greg k-h

