Return-Path: <linux-kernel+bounces-394392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BA9BAE61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8181F234A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD4F1AB6EA;
	Mon,  4 Nov 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ussFzAc1"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEB619D8B2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709820; cv=none; b=atoQvG8qYBunXw0V3Y7L7sWtvLQLQYSCQhxnYQthMqgmOKPMjW1IUSlTVCzPHgz2BcRwIZ5STbt1ntbnWMuyWMAbIWCErnG87uC6go+e81gzRIsuZ8VtBVvczg3i0/O1Fl9FonPVAdr2xOhBuzNV4Vr6354DgILSyYOhtCwWx9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709820; c=relaxed/simple;
	bh=H6+7n6GItmZK1OTaix+oW7p6zjCT1F+cbCg+29+lQaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5TvUM7Paz3zQbYvJk0iQ96dPfFxnx+R2eZSO29lqOWUWMUfEsf+T40OWYICaKpFVtEtJ3VoCG7HsM+1ahbCZ3mEvqE3tM4u5nkAO8SSXbfvzZdonGirQh2QNpbGGNHLs7Ny+AecagpczMM8PCvKKywS6yGuT9T8okkwrDnU0+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ussFzAc1; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3635570f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730709817; x=1731314617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mzcZ40JgGm44C7M2p4ensyZcq29vuN3HSXmBxErva0=;
        b=ussFzAc1M3k70XdCjhHKLV7EeujOj2GmsByeMv+XQnWXpo35Be9nZ/oR1nJFHfgIgA
         tO7kDf3DsSj7Cd45v7j+o14bs7ZyoXWudnIIK0+1PJ8FWusOGxevhXR1/EkOAji/iFtG
         Id5Djbfgc/4UHULZElbL9SqYPzV/H6hPOIX7f8Cix+GqZ1NTTqSiHGwdQKopP0tw6KIz
         3huKS/fyrrHS/WIBqK4Yuv8QOYP3x3YudAQ2CsRk84a/2dmMn5l+/PT+THhWCLQ6hAAl
         hi+oi4P9oUA/MxHqrXN7tReALMgw9Tw05kD6396iyFySm83NpeAnvbPtRtE5r5T267Vm
         iNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709817; x=1731314617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mzcZ40JgGm44C7M2p4ensyZcq29vuN3HSXmBxErva0=;
        b=fvHJsFRVcT/CQRwiNg+xWbzhCdShXiGQhiGDMimsiic6eRC6WhQtfwwtz4eBfkAK3A
         SeoBsvlFK9A7Ayiq+dtiPysxvkPJIuRCtB4Ldm6+YGYR81ktojIpsOzKHHupZbu5aFNa
         +ugzhBkGiEZ+1kO+ykJkgq8WEBw+3b8JiaiQJpxc2hTkyjfJrnAHB9qkOUzjo4XwYdto
         ICFRF955VU8mntBfnW5Y9QMwszw1oREwmrqxztcs6jl6irEhQHqOBqjCws0KHWLYwF/A
         Olr/qDA5lDM9kWwwJK/RtA2GJ6PCrzEoDKB+EI+IqJtE2ML7WgCThS2hQJLjGxJ+Pas5
         KZdA==
X-Forwarded-Encrypted: i=1; AJvYcCX70k57BtJqAU4OHu5OV+IYcmtMkClabaQbEDCEjDQNccf1ErocIEvHqVw5IQ4g1qeg4ZGhqo8A/L19aL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytL9Ttk5uRvDQpaohmy5vm6dUWlMtRKJSI4TOJdMxseuCj4TG/
	3nvD8As61CxQhVUjegQd7PyaVkXLGLdUbUJjIvHO5CX3fiTopQKNb6VcqfxriODIJAWBC6MJ1U5
	5
X-Google-Smtp-Source: AGHT+IH4gn7Kr6XDNOtojQ9jzVG+iu2feJjnJyfKdYBnr/oKuNjDRwhQLv/fQ/43mkl4gpiiDrmIoA==
X-Received: by 2002:a5d:5a13:0:b0:37c:fbf8:fc4 with SMTP id ffacd0b85a97d-381c7af3be3mr13124947f8f.59.1730709816810;
        Mon, 04 Nov 2024 00:43:36 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113de0esm12595552f8f.85.2024.11.04.00.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:43:36 -0800 (PST)
Date: Mon, 4 Nov 2024 11:43:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 05/11] staging: gpib: Remove GPIB_DEBUG reference and
 update messaging
Message-ID: <4c4aba7e-c873-4a93-9311-bd2e2bbcd8e8@stanley.mountain>
References: <20241103212617.13076-1-dpenkler@gmail.com>
 <20241103212617.13076-6-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103212617.13076-6-dpenkler@gmail.com>

On Sun, Nov 03, 2024 at 10:26:11PM +0100, Dave Penkler wrote:
> Change pr_alert to dev_alert
> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>
> ---
>  .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 69 +++++++++----------
>  1 file changed, 34 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> index 4c580137043f..796c3a5be545 100644
> --- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> +++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
> @@ -68,11 +68,8 @@ MODULE_DEVICE_TABLE(usb, skel_table);
>   *	      At module loading:  modprobe lpvo_usb_gpib debug={0,1,2}
>   *	      On the fly: echo {0,1,2} > /sys/modules/lpvo_usb_gpib/parameters/debug
>   */
> -#ifdef GPIB_DEBUG
> -static int debug = 1;
> -#else
> +
>  static int debug;
> -#endif
>  module_param(debug, int, 0644);
>  

Put this in patch #2 instead.

regards,
dan carpenter



