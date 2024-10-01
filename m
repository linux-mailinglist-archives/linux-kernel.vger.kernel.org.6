Return-Path: <linux-kernel+bounces-345990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CAE98BDE8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E21C2857DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35991C4624;
	Tue,  1 Oct 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="eKD1ssUu"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DAE4A21
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789752; cv=none; b=bGhv3YIG/0Q4GTgwg67Xxq+77b++wcV49LKKd3YS99Yw0YdOn2FlgfJXjQAYREjjMyMGHFC9nUGFidaIqIWHLsobPWUjkFXjfYP++inBzseExv3tvnx1INeP8uUiZM3Fom4YW3mSzbY2B50HEacL8dNXpJqisH/iY4JJ1bjTYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789752; c=relaxed/simple;
	bh=U8pY5rep/DxZyRN/3K4NlXXTJfyp2pzoEXOGBzwi//k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/NI150o+ymVt4LC3oiPAHTflHA4G4Cb/wyx8x0el4G4L21l4Ia5aRYedcF0VG75RTzObGXKhEEHI+wbyl2BS5PtdbyjQ2t3HquM7aW+TioALYFZJPgegN4ammmZ8ox/trKeA5QwjsSkJAX/V7bORnz7HthfWjp7meSL0QhGJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=eKD1ssUu; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-45cac3368f0so21058231cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1727789748; x=1728394548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BEopdWMDpCRUeGsoK3NceMIpTW9rD6Z+uCQDxg21ocg=;
        b=eKD1ssUu9Jf1OhaTfX7uJKOQ369znCxtHihp8TRH7o2YecD2LMwusjAxFCM++TR6fb
         Iwq6Xk8MVgldFaYcuvAyhvHMAlmfYNmxxyzWZC0hnywIWKjC9uRMMezifc4hzwjfD1pR
         TsLjjEVwjG0wZcwQ7Fl3oETtmZhg86wu1DaVdDZzpqg8QgP0RlRI+aukTeSxTrBJFrLW
         9tOkQnN/n6LxU48/hOpKGGzUjUxsS5n+eBHDhNPnA03zWf8SLfweL8SWnpLXzq45+puj
         lU9bDu79DGZxepxFTWy4CPOvo3GmzurVZZ9YO3DiuNZ8gRimEoIwkR2Gq70+hednY/Of
         9yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789748; x=1728394548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEopdWMDpCRUeGsoK3NceMIpTW9rD6Z+uCQDxg21ocg=;
        b=Kf3fCyZCUaw/NNHeDhCUucfBtRckugJtb+Vamh++BAmDi0JQGlNfFQoGpNBOnJqlpW
         dp5SuyXnhqSmESr8QWNXnGxcjhwSbvjIl3OVLN0tX5i5MHytPpL/fQja7ixYYcuymHun
         DFa/NZgttDxl+ejxYa471+bsdem4WZzpqiTJo5+51lI87fN0j6T6MibazCpMrcnXbsbj
         1QdDaSB7j4YnEIFIJX35KuZIF929/lf0GKhKCMRgXi0guVwxNF4X/LFPEhDoD+UupJsU
         GSlbQyiMOnVZmVXY1boFFtouR2kASdIJjW60uiDdjA/tJtgf09vpL3ClL/8LdXIhzGai
         2jhA==
X-Forwarded-Encrypted: i=1; AJvYcCXwKwl+e23XvOY8RqxYGxYjmEIQ9a9vKRfy79ijzw5DULsPKpjNiSoNRXO7sNtlunOvpTZdZ28IbkdPY0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5x4/PZiCVfL8OX1sO+xloh6+9cBGN1VMqAl0cSIZwuDdiFk/
	NxcBegqO3UALGqXLRLgIJvVvs9yEynHdDpaelvjyEpwgxrlr/vA7sfKTE50+QQ==
X-Google-Smtp-Source: AGHT+IFhon3dVznzTI1PMzAnQix3pUVNFQbs135O2xwWuH6/TZXs3oH4K63Bz/B0EV10SolMHOyrOA==
X-Received: by 2002:a05:622a:4b0f:b0:45c:aa3c:6b21 with SMTP id d75a77b69052e-45caa3c6bcdmr179463541cf.19.1727789748037;
        Tue, 01 Oct 2024 06:35:48 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::5638])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d7aad57c5sm4079281cf.63.2024.10.01.06.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:35:47 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:35:44 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: ignore bogus device raised by JieLi BR21
 USB sound chip
Message-ID: <5d5c516e-ad45-4533-912a-80cdf85aaed1@rowland.harvard.edu>
References: <20241001083407.8336-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001083407.8336-1-uwu@icenowy.me>

On Tue, Oct 01, 2024 at 04:34:07PM +0800, Icenowy Zheng wrote:
> JieLi tends to use SCSI via USB Mass Storage to implement their own
> proprietary commands instead of implementing another USB interface.

What a strange thing to do.  I wonder why they chose that approach?

> Enumerating it as a generic mass storage device will lead to a Hardware
> Error sense key get reported.
> 
> Ignore this bogus device to prevent appearing a unusable sdX device
> file.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/storage/unusual_devs.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index fd68204374f2c..e5ad23d86833d 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -2423,6 +2423,17 @@ UNUSUAL_DEV(  0xc251, 0x4003, 0x0100, 0x0100,
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
>  		US_FL_NOT_LOCKABLE),
>  
> +/*
> + * Reported by Icenowy Zheng <uwu@icenowy.me>
> + * This is an interface for vendor-specific cryptic commands instead
> + * of real USB storage device.
> + */
> +UNUSUAL_DEV(  0xe5b7, 0x0811, 0x0100, 0x0100,
> +		"ZhuHai JieLi Technology",
> +		"JieLi BR21",
> +		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
> +		US_FL_IGNORE_DEVICE),
> +
>  /* Reported by Andrew Simmons <andrew.simmons@gmail.com> */
>  UNUSUAL_DEV(  0xed06, 0x4500, 0x0001, 0x0001,
>  		"DataStor",
> -- 
> 2.46.2
> 

