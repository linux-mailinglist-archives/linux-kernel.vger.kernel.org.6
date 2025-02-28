Return-Path: <linux-kernel+bounces-539002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BBCA49FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0759E7A3AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D540189B84;
	Fri, 28 Feb 2025 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VMh90KSX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7511F09A8;
	Fri, 28 Feb 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762213; cv=none; b=nbTt348Y1N18UBwCOInVpXg1sGTIcLp5ygXFcgHx+QMiKyx6/gmd7zPpPbyNGRns1LwWPFhEfm206dhfZWNe6Ew1lx1LPFYCNspdC7cNUAgyvdl1B9gCpesRSOWTgv2HIQme5mpYM/9YX3wwZjIPizoYZPql4XHn/yqxKmrdDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762213; c=relaxed/simple;
	bh=87MeIyTnCh42lvIVh/gUDVDz6THw0IS0/ekXuG8Yp9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dg9ApH9dC4RZtjJVBToMovEANUek0FxT0aUE2mAVJONJTH+APzpCrG9lHUJ4UWulfoyNIbySoPqyw4obn/P5jIeadF4pXdEnr5gVyrS0rk8jYxiqA1QuZGN9gBPdWBTOd4ayjptAUHWplO2bji37iSQXtzWksMg9y5sWf4vhH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VMh90KSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB13C4CEE5;
	Fri, 28 Feb 2025 17:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740762212;
	bh=87MeIyTnCh42lvIVh/gUDVDz6THw0IS0/ekXuG8Yp9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMh90KSX/qkhcZk//yf1Huc/CHYyS1ct0ZwCI1hUItnPu0xfocWwEeJhWKUlxrUsc
	 m8lMS5KZQQSRVSlWmu5pjWAyYbWZXtIvVxf6NQGADM8nf8CwyHh9dWbAP7CHtBeiMy
	 UhadyHL0qs1ei5gL7x9GZ3PM0UhekqSBq5I/txXc=
Date: Fri, 28 Feb 2025 09:02:10 -0800
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "castet.matthieu@free.fr" <castet.matthieu@free.fr>,
	"stf_xl@wp.pl" <stf_xl@wp.pl>, "b-liu@ti.com" <b-liu@ti.com>,
	"johan@kernel.org" <johan@kernel.org>,
	"heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"valentina.manea.m@gmail.com" <valentina.manea.m@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"i@zenithal.me" <i@zenithal.me>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] usb: replace strcpy() with strscpy()
Message-ID: <2025022833-unawake-barricade-7bb8@gregkh>
References: <DEF7EF73-12C4-4F30-BC14-DD829F0C6884@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEF7EF73-12C4-4F30-BC14-DD829F0C6884@live.com>

On Fri, Feb 28, 2025 at 03:07:03PM +0000, Aditya Garg wrote:
> From: Aditya Garg <gargaditya08@live.com>
> 
> The strcpy() function has been deprecated and replaced with strscpy().
> This patch shall replace it in the whole USB tree.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

As the two functions do different things, are you sure it is safe to
just do a search/replace here?  If so, you need to explain that in the
changelog why this is ok, and if not, please document that as well :)

thanks,

greg k-h

