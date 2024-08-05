Return-Path: <linux-kernel+bounces-274146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2429473F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862EAB20D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E9113D882;
	Mon,  5 Aug 2024 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RvPHWVkY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122263A;
	Mon,  5 Aug 2024 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722829171; cv=none; b=dxXxnQyu2njODYSYENWzyz/9nsDVaJa9/PfR3TXUH6MoWGtaPdibB+qkXMPO477aVd9lW8RhS3bQo/0mK6rCV1sX7B2iOrbXYHLZorpGjNfhexrzOYVhh2sHrQk9kjktCbrmr5sPXly3FAHIM8cADfIuljPBAl1BdQz61mrD00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722829171; c=relaxed/simple;
	bh=W9OgSc8zRD0QqOtJlIQmXEXSGBgulR3Zniq5OCwAQBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X84Wf5uhK8JjDm7gfgt/9IzgqO+Qs4vEHNoNJQbHjmivKKEu2HYuYxV3/VWXsin9vful36bImwYivSVf2IAJS6FnBEQARlpA+k4eJgFzz568W0JjjEB97H2fW04x9zo1wqFMLasaasKLcPbob+wlrEeNR29OkoUxSFdeu+flmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RvPHWVkY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UWhQXaGJVQ5iefoGfd01HT6OELclsgGumxbhqvyIOP0=; b=RvPHWVkY9OMjCqupoV3iXsElLZ
	4svu7dHCocBQKxPpPahVu2aFeNccwaqG9R4w1G0QqG7gUndalrUmbJCiJhsplFBm9wgDL+EpKcHEZ
	smDx+X1Thri8UZSmBwJdjmuo+Einvp+DpH2sgVQQXVx4gWyIEFwaXlWwNDyu/gwy8kFjR1xij6OMr
	8vUfndnRh6RzM6/bRn3AwAMCdbyVPVG8UOhbgmu7A9lNpuTIOTxaDtrMGDrGOhSQ/yxIyftjNsHCc
	ldXyd8eKiVcpA2vIYXfd7mH3XYMCHuC3j9PweuvuvxuJCxqcTkIIho4p2o0por5U7LMqqy3caCEwA
	QslwtWcA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saoZ7-00000003oEK-3eu8;
	Mon, 05 Aug 2024 03:39:21 +0000
Date: Mon, 5 Aug 2024 04:39:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: crwulff@gmail.com
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Cercueil <paul@crapouillou.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Farman <farman@linux.ibm.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Jeff Layton <jlayton@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Sands <david.sands@biamp.com>
Subject: Re: [PATCH v4] usb: gadget: f_fs: add capability for dfu run-time
 descriptor
Message-ID: <ZrBJaW_EwNf_T_WZ@casper.infradead.org>
References: <20240805000639.619232-2-crwulff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805000639.619232-2-crwulff@gmail.com>

On Sun, Aug 04, 2024 at 08:06:40PM -0400, crwulff@gmail.com wrote:
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index 44d73ba8788d..91f0f7e214a5 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -254,6 +254,9 @@ struct usb_ctrlrequest {
>  #define USB_DT_DEVICE_CAPABILITY	0x10
>  #define USB_DT_WIRELESS_ENDPOINT_COMP	0x11
>  #define USB_DT_WIRE_ADAPTER		0x21
> +/* From USB Device Firmware Upgrade Specification, Revision 1.1 */
> +#define USB_DT_DFU_FUNCTIONAL		0x21

This is the only place in the entire patch where you explain what "DFU"
means.  Is this really such a well-known acronym that it doesn't need to
be in the documentation or the commit message?

