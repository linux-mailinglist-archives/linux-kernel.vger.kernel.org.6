Return-Path: <linux-kernel+bounces-357037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5001A996AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1384628A4B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91B1A0BCF;
	Wed,  9 Oct 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PLThz6j6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE43198A2C;
	Wed,  9 Oct 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478081; cv=none; b=eNZxB3ndaOCkgs58jX0bcAkjUqVGQoDChM2EBeNdmHIqENUJXjLQ81RQpXcie82hD9Ms3lMb0BbCfCqK1jvgE9j/AWr1lOiJwIDotHv+KiS8JGjdI9OTL8d9pl9TKTyK9DGuRWg9p5A82KB3hgoTs8o5eqaxTzGaP5QKW9drezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478081; c=relaxed/simple;
	bh=+HguAvEf1eo7PO/l+X4lhcbN9ZQ2VAGHrjY78y4xrYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk0nxTqkAjBIjqLzrp6qDE2cky5+COBIvqS7Pf0gQ4OAHYV+37FuWwidTVuyqJohwqYhTKTlPcRaYUjcjOGxtG+/0im1uVgnWedJC16xioMad+evCrSsCLVLY5aWT+Bh2iNherm5njljDCQklMjPK9xIQNxV55Uw1d5gsUE1PYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PLThz6j6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6948C4CECD;
	Wed,  9 Oct 2024 12:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728478081;
	bh=+HguAvEf1eo7PO/l+X4lhcbN9ZQ2VAGHrjY78y4xrYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLThz6j6AVgANqQ7xmjefYsemRF10hj1Jts9voUxI6z9gTF1FNOBv1ALmFl2Z0Nbd
	 yWvLKeWyNriF452ndnVH4wJRHExPsTcPqCj9BWKRn4eopSopLnwg55PgMnsALmSWOe
	 AJTCdWQXqWcJDUc/X6LbfF3F3awm4iomXWylrptQ=
Date: Wed, 9 Oct 2024 14:47:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com,
	stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com,
	yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com,
	perex@perex.cz, tiwai@suse.com, tj@kernel.org,
	stanley_chang@realtek.com, andreyknvl@gmail.com,
	christophe.jaillet@wanadoo.fr, quic_jjohnson@quicinc.com,
	ricardo@marliere.net, grundler@chromium.org, niko.mauno@vaisala.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, badhri@google.com,
	albertccwang@google.com, quic_wcheng@quicinc.com,
	pumahsu@google.com
Subject: Re: [PATCH v4 4/5] xhci: sideband: add api to trace sideband usage
Message-ID: <2024100935-resonate-aneurism-b330@gregkh>
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-5-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009054429.3970438-5-guanyulin@google.com>

On Wed, Oct 09, 2024 at 05:42:58AM +0000, Guan-Yu Lin wrote:
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -84,6 +84,10 @@ struct usb_hcd {
>  	struct urb		*status_urb;	/* the current status urb */
>  #ifdef CONFIG_PM
>  	struct work_struct	wakeup_work;	/* for remote wakeup */
> +#ifdef CONFIG_USB_XHCI_SIDEBAND
> +	/* Number of active sideband accessing the host controller. */
> +	atomic_t		sb_usage_count;

It's a reference count, use refcount_t please.

