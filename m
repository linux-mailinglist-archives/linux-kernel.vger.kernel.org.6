Return-Path: <linux-kernel+bounces-219449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA38E90D38C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46D3B27CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1551AD9E8;
	Tue, 18 Jun 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pWXtEdL+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6051AD4BF;
	Tue, 18 Jun 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716846; cv=none; b=BBCCOEktjwXKM043JB8REIzknqVnMLqmLfrmhMOdth6hPmyHRVX0h5mrs/Jv9UCtN58ecItwMrayoMp00e+ZwKuc99/X1DXIKOpdx5SyD9eTdrpg8zcPc6xT/bdToc/46vVds+P5lAyXWYo6KOEJDRxDUV+ByqP39jqDrSf+j4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716846; c=relaxed/simple;
	bh=Qp7CM6iG5kz1apRwYVuMOrXU7YUSRpdnOK+KIpu+IfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfHkpEFZ2DoNXpGcUlnbeRIqWkHBaRGa52LnB6X0iHaD5A63yG3uJ+gfAdeKS8bTd0ZKq4/pFlzqaIG9Jiv5jGqLQd+fC8Bi2SufhhoFVjuPn2MMQIavcsy8CPs1bxZ822RWvVJYVWOsFbLLXNT0OaX5wKlLcP1nwnu2Sg8Mysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pWXtEdL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E428C4AF1D;
	Tue, 18 Jun 2024 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716846;
	bh=Qp7CM6iG5kz1apRwYVuMOrXU7YUSRpdnOK+KIpu+IfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pWXtEdL+ROtNJD/V6HrgwGTvypKlp5/8Z9Ww4dubowcTM1sOxGEJI8mwcqarzIno8
	 1SFtTuAO2HBgsRHbtN7sAl49xiFTT+HvSTrJZ1ehK+jflnhcUot9f4NPykjLwrzSxr
	 I37DKzh71NN0P8l8y+0uLtUuXGdRTHGJ3d6YVLTg=
Date: Tue, 18 Jun 2024 15:09:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	linux-cve-announce@vger.kernel.org, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52685: pstore: ram_core: fix possible overflow in
 persistent_ram_init_ecc()
Message-ID: <2024061823-employer-stylist-2505@gregkh>
References: <2024051752-CVE-2023-52685-64c5@gregkh>
 <87jzjeojwp.fsf@mailhost.krisman.be>
 <2024052811-cornfield-monday-8bb9@gregkh>
 <202406171413.DE595AF@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406171413.DE595AF@keescook>

On Mon, Jun 17, 2024 at 02:17:49PM -0700, Kees Cook wrote:
> On Tue, May 28, 2024 at 09:01:13PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, May 27, 2024 at 08:32:54PM -0400, Gabriel Krisman Bertazi wrote:
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > > 
> > > > Description
> > > > ===========
> > > >
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > >
> > > > pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
> > > >
> > > > In persistent_ram_init_ecc(), on 64-bit arches DIV_ROUND_UP() will return
> > > > 64-bit value since persistent_ram_zone::buffer_size has type size_t which
> > > > is derived from the 64-bit *unsigned long*, while the ecc_blocks variable
> > > > this value gets assigned to has (always 32-bit) *int* type.  Even if that
> > > > value fits into *int* type, an overflow is still possible when calculating
> > > > the size_t typed ecc_total variable further below since there's no cast to
> > > > any 64-bit type before multiplication.  Declaring the ecc_blocks variable
> > > > as *size_t* should fix this mess...
> > > >
> > > > Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> > > > analysis tool.
> > > 
> > > Hi Greg,
> > > 
> > > [Cc'ing Kees, who is listed as the pstore maintainer]
> > > 
> > > I want to dispute this CVE.  The overflow is in the module
> > > initialization path, and can only happen at boot time or if the module
> > > is loaded with specific parameters or due to specific acpi/device tree
> > > data.  Either way, it would require root privileges to trigger.
> > 
> > Normally root privileges isn't the issue, as many containers allow root
> > to do things (including loading modules, crazy systems...)
> > 
> > Anyway, I'll defer to Kees as to if this should be revoked or not.
> 
> It's a module parameter or device tree value that is at most INT_MAX or
> UINT_MAX respectively. Also, it is bounds checked against the buffer
> itself:
>         if (ecc_total >= prz->buffer_size) {
> 
> So even if it wrapped around and got "too small", there's no damage to
> be had here.
> 
> The worst case is that the ramoops info goes missing because pstore
> refuses to do anything with the bad value, but pstore can be disabled
> way more easily than that, by design.
> 
> So, no, I don't think this is CVE worthy. I took the patch because it's
> reasonable to try to get the math right and provide better error
> reporting.

Now rejected, thanks.

greg k-h

