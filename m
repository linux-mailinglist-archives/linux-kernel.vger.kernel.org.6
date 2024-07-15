Return-Path: <linux-kernel+bounces-252626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78193160D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F371F23252
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF6418E754;
	Mon, 15 Jul 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPN3t8Hj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD21836D4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051214; cv=none; b=pv4M0NzSCLt3aQ8cmUi+8Fsd4IosqtmSIBDUX3N2nduTWVd436JTFK3EcEcVuLjGjBem5gPqxl292N2s5FbYP9CbNDzC+LHrk7oRZtnKd98oXgHAkv4vUQBUzNT38JwqOqi7HMZbmgAskKitugtXY1znt27IpFOO7qBb+4PniVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051214; c=relaxed/simple;
	bh=5YFvN6vO7i0p+y5wTdOdsTbEoLA21enc5/UJS5B38ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p5MS4uoWXvceCle8R53vQO5b0h67q462WFG3JQiQNpSsyB5M6Qh4DdAtx8hCUJe8dFi9Q32M/pOrnN2hXMXIiGVMBbgTgCk5WSHZj4QgvdjUij4zrs/kT37i+37dODAD/0HU1pU7oIMJeSDIF0FMhT+8zFJojGMUtutxXePCIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPN3t8Hj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721051212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQQM2Vgmnkg0Q/ZG925IrQsyn3iBSHAJuJ8Uk6m4Psg=;
	b=SPN3t8HjsAZotg+KKTr+taqcYI0wfOU9gph1MNfgnWU2y9/9MB/MGWeJn+iYPGJNlv6TrO
	rQT6QJX8gn3r9zw63fO88CsPI6Y9yCZtBbvq6N1SrXwdVxW/vSOwcBip7CR7WgUDtvw+sd
	blol4JZ/fxM0s4KDnCX13us3qMuNPE8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-q1jEcMtjMeu25ueRYo5qMQ-1; Mon, 15 Jul 2024 09:46:47 -0400
X-MC-Unique: q1jEcMtjMeu25ueRYo5qMQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so4100309a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051206; x=1721656006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQQM2Vgmnkg0Q/ZG925IrQsyn3iBSHAJuJ8Uk6m4Psg=;
        b=KNToPbqtzNX5Lle/U6uYBWLlYo7VcvBFIjR/jaWQGE29KR6nFnHHrMpoXB7LoUWgMc
         OQNntr6caCiEHbBXOSW834weDTDc7pyQDh08n9PXLqoxwHr1yntN5FTy/wTs7zGsxKyq
         Zp47Ik1Vd73MHc+Gf7tHOIJNbqz8AiM363Hxn+fi629s5TWaKOryFzpOSnjyL2R7IMgq
         J2JGb1UV9aYkMBcGL6lxWVtZiCZarPnthnk6v64qxLCCHMcmESkXUQqFDg9oCgExK8E2
         ycbHI2dIzcjtu3jRjVlqkNYpvKHj2X7aIXeLZNIdoJVHhna0sbVl6h7Xmlu5g+5ihRZu
         ToRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbt3JoB/gsuVH70ch4sISOvfTPSmxQVm/+cQZ045gaJL11nL/6FaP/T1WM6ynltDe/pkxjqJJm9yXkXREI5wckG8IcT1F7vBffQitq
X-Gm-Message-State: AOJu0Yxc4N9QgkfFacvzG6b0/fd1+LpGTQ9z0jirQB+V4ZpQaThdZB6u
	mFzk7EqFaNSpJAcwYdEzElCx4PiP1kSi6h32wbV4kkQ3UVAoxZRs503vFYru+mYnTma0YKzrL9k
	4yfrtiwYVK7Ucl7hfaX8+ztKcIzy0Wu+g+FCMq2sEP0kQ14gO6cEVdUrU00h9Hg==
X-Received: by 2002:a05:6402:40d2:b0:58a:d4f4:e866 with SMTP id 4fb4d7f45d1cf-594b9b06ceemr15731990a12.6.1721051205937;
        Mon, 15 Jul 2024 06:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSHFUvMvX6VcA8ROFee0QQTz/GhPiB3M+stkDjPDyUX2+yHI+VQz5H5iEVM8mnZ1l5PRL0wQ==
X-Received: by 2002:a05:6402:40d2:b0:58a:d4f4:e866 with SMTP id 4fb4d7f45d1cf-594b9b06ceemr15731968a12.6.1721051205496;
        Mon, 15 Jul 2024 06:46:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59cfa5dd20esm1640184a12.40.2024.07.15.06.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 06:46:45 -0700 (PDT)
Message-ID: <afc7f155-9442-4603-b276-78f3df1f2b8f@redhat.com>
Date: Mon, 15 Jul 2024 15:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
To: Philip Mueller <philm@manjaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240715045818.1019979-1-philm@manjaro.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240715045818.1019979-1-philm@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/15/24 6:57 AM, Philip Mueller wrote:
> This adds a DMI orientation quirk for the OrangePi Neo Linux Gaming Handheld.
> 
> Signed-off-by: Philip Mueller <philm@manjaro.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I have pushed this to drm-misc-fixes now.

Regards,

Hans



> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3860a8ce1e2d..903f4bfea7e8 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -414,6 +414,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
>  		},
>  		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OrangePi Neo */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
> +		},
> +		.driver_data = (void *)&lcd1200x1920_rightside_up,
>  	}, {	/* Samsung GalaxyBook 10.6 */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),


