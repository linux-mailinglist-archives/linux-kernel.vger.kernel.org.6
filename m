Return-Path: <linux-kernel+bounces-396554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC689BCED3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F89B283807
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984771D8A08;
	Tue,  5 Nov 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="BY8VnCCf"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72711D88C7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816027; cv=none; b=NZfeO6ON/5u4vUnl7Eji84oBDTpA6X0P2HO0BmcBANaiqr+Xp5mmUcZdAsD29UfevEQ3D9pZvW2qKxWkzNFxc1cR//K8Vmml2IHLDwdgCSA2ZGdipNvPrIgUFx8HhhPuCGYVhLLx/k8UGysArJ2izJJ0HBOqcWynPfL8J5sMjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816027; c=relaxed/simple;
	bh=tounGA2esR/I0Qx0gP0xNm3ep/qLgCuQd4RYHr4tj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk6D5tJl8ol54XvSc5Mst6nkz67c9EwThxjoH40bG9HLWcVGvEMp5397hhD5jcd+O8yE20lj4nIu8z5D2zAj1r0CmGr0rDaJAkOMghveX2R2bAhgzRkZ4CCTGjus3aEUWSlOEF1qysHOhcW2kZ7lmF66A0kychBtUVK+2cnNXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=BY8VnCCf; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b14f3927ddso423417685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1730816025; x=1731420825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDvNb87s9KcM7r3rmGm02Lgs00JVk1L5xBACfLVxSx8=;
        b=BY8VnCCfAjHP0hMi+ft8oXBHiepkJcbfP8SYTvdbatCSpi1at4Oogk8jv78XkWASNR
         QfzLhTLf7sY1W9bJSi49bbl+kEDFCKSJryIYZQjQnoeB+yJT379sKd2Wvmym9Cg+1x6j
         L/7XXAaH/A/Ra5gnc3QLAkF/vRDMZWbJEmBHCSr2F0OgZg3y4rcTTy1Dvw1KXBHbdGKH
         VH79ngMFUZA9g6WV4RfUmWM3tmcogsS7T1ellQ7n2qPVZd1pe39ZRpv5xQP4X09vB1GB
         h+A8HIHjCcVb0EaR4+Oj35i1W2jW7bjEzr4xlFgjc7m6GV2lLiCEoWod+ckI68P0eyrB
         bnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730816025; x=1731420825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDvNb87s9KcM7r3rmGm02Lgs00JVk1L5xBACfLVxSx8=;
        b=QFZnGOnByjz7srAPJugygz5GhK/0GVekUSAe9qfhdDpwisR6/zwWJtj/2QitbxnUHl
         inTEHib+Zdz6hGkjlgl264+IbCgOh0Pc4xiX7CRLRxPY+3Q8BgS2nGxE7icFWZD0WNo3
         xrviavpS4qCKMLKrAq23DmeLSTR8rpPmBB4vyIV/z/IT+DmUtrtKQ78m12AAblP/66SQ
         HiJFLY2TJZhcluFOVCIn7URAG55gMwO2goO4o0CCFf+ijSgVEKXv0EDO5ZXiff1DWtxA
         q3IUWx3jMpLJQcwnjnMcqAKopOomei6EDYGnLLLXBCmj6cy5unkLfAPH01mkrl1PSWnr
         hmFw==
X-Forwarded-Encrypted: i=1; AJvYcCW1MxCuwVqPBpFS7s1ksoUd4JL6OCvC/UAikRhWB/nd0T7XNT+HxBfZbfYCFN6QEtbEMr2YHW2uhJ1a2Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18eLpZYLR9vuslgu+GCfFbbtoBGRZ2uT11Lb63irIRKnRv5jZ
	nq0aaCuc1ZKDBsDMlDsORI3b5hr9BUese3udj6K20GaNPxuO8aJd/KHnxWCb/Q==
X-Google-Smtp-Source: AGHT+IEeS3YQUgZzUmSS5oJ/G5Rru+wFnAHqViIxjS3AoWTOSVHCZQPx2yiQXOuxQ7lVPzKmAArePw==
X-Received: by 2002:a05:620a:1908:b0:7b1:5f49:6bf7 with SMTP id af79cd13be357-7b193f5bd5fmr4527852385a.56.1730816024762;
        Tue, 05 Nov 2024 06:13:44 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::dc3c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39eb799sm522324485a.15.2024.11.05.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 06:13:44 -0800 (PST)
Date: Tue, 5 Nov 2024 09:13:41 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-usb@vger.kernel.org, mathias.nyman@intel.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: quirk for data loss in ISOC transfers
Message-ID: <9265b40f-b803-4dd7-b6df-3e8cb510b07b@rowland.harvard.edu>
References: <20241105091850.3094-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105091850.3094-1-Raju.Rangoju@amd.com>

On Tue, Nov 05, 2024 at 02:48:50PM +0530, Raju Rangoju wrote:
> During the High-Speed Isochronous Audio transfers, xHCI
> controller on certain AMD platforms experiences momentary data
> loss. This results in Missed Service Errors (MSE) being
> generated by the xHCI.
> 
> The root cause of the MSE is attributed to the ISOC OUT endpoint
> being omitted from scheduling. This can happen either when an IN
> endpoint with a 64ms service interval is pre-scheduled prior to
> the ISOC OUT endpoint or when the interval of the ISOC OUT
> endpoint is shorter than that of the IN endpoint. Consequently,
> the OUT service is neglected when an IN endpoint with a service
> interval exceeding 32ms is scheduled concurrently (every 64ms in
> this scenario).
> 
> This issue is particularly seen on certain older AMD platforms.
> To mitigate this problem, it is recommended to adjust the service
> interval of the IN endpoint to exceed 32ms (interval 8). This

Do you mean "not to exceed 32 ms"?

> adjustment ensures that the OUT endpoint will not be bypassed,
> even if a smaller interval value is utilized.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/usb/host/xhci-mem.c |  5 +++++
>  drivers/usb/host/xhci-pci.c | 14 ++++++++++++++
>  drivers/usb/host/xhci.h     |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index d2900197a49e..4892bb9afa6e 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -1426,6 +1426,11 @@ int xhci_endpoint_init(struct xhci_hcd *xhci,
>  	/* Periodic endpoint bInterval limit quirk */
>  	if (usb_endpoint_xfer_int(&ep->desc) ||
>  	    usb_endpoint_xfer_isoc(&ep->desc)) {
> +		if ((xhci->quirks & XHCI_LIMIT_ENDPOINT_INTERVAL_9) &&
> +		    usb_endpoint_xfer_int(&ep->desc) &&
> +		    interval >= 9) {
> +			interval = 8;
> +		}

This change ensures that the interval is <= 32 ms.

Alan Stern

