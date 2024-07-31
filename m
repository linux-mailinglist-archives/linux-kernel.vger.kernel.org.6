Return-Path: <linux-kernel+bounces-268690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D6E9427E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4295C289097
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0C1A71EE;
	Wed, 31 Jul 2024 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E0+y9l3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BD1A6183
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410891; cv=none; b=uuEa6VIXHajlQvheXttOwgHtthbcp9dBnndO1e5e1Ucju5XBm2i29Pos3p6odox9moNaLT5Do+oaLRUujAAQ1XhLe92icqYS/7sbS31IbPi4ztHOwOaWrt/w2bRNr9Auk4WWSGPTVcML3DmN243vEgUuUG0jZ4AUbTgoG+0UMro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410891; c=relaxed/simple;
	bh=6eqmBNhcLynfcEW2143HtVFyoEHwITDJeK6g8eQYW8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfnOTZH9dB3NQoYi/DGyOdIM6EC/hUdrr6RHrph2RuHUutN4OPNXz0NW7+hLMbSNFmjcMIlMUgozknxI+C2zrp6G+TSMNOma5RFfGbAimeMCPdTb55jZUm37KNwKDIx2e9z36WXOU4NI3WgdS53BCV4OnsWlgX1Ox5kdn3iDq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E0+y9l3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF5AC4AF0B;
	Wed, 31 Jul 2024 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722410890;
	bh=6eqmBNhcLynfcEW2143HtVFyoEHwITDJeK6g8eQYW8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0+y9l3i7qSBOavYU163IwTOng2saPewGPoNbQLYzgs/DtTfKMCTbaX5/Qif9TqOt
	 lyEKP4ZKS6omJAeEVjgZ45EDXL+0J+b7A6+RAR+TSknc6QCcEflHHFVJPbDOelk4yF
	 UvR7x0AKKPnAFMqqZq515ibyAoz13XW3yMtAoGtU=
Date: Wed, 31 Jul 2024 09:28:06 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: [PATCH] usb: gadget: uvc: Fixed the abnormal enumeration problem
 of mobile phone as UVC camera.
Message-ID: <2024073138-bagged-squander-bf66@gregkh>
References: <TYUPR06MB6217E6066E3A74EDE86FED1FD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB6217E6066E3A74EDE86FED1FD2B12@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Wed, Jul 31, 2024 at 06:48:57AM +0000, 胡连勤 wrote:
> From c464558a70e1ca36c0e4bd0a121fb50565b44610 Mon Sep 17 00:00:00 2001
> From: Lianqin Hu <hulianqin@vivo.com>
> Date: Wed, 31 Jul 2024 14:21:52 +0800
> Subject: [PATCH] usb: gadget: uvc: Fixed the abnormal enumeration problem of
>  mobile phone as UVC camera.

Why is this in the body of the email?  Please fix up, and also, properly
handle this being a new version of an old submission as the
documentation asks you to.

thanks,

greg k-h

