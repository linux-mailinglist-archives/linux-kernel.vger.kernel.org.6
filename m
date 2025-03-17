Return-Path: <linux-kernel+bounces-563707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7BA646F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9AC16B2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4F92206AF;
	Mon, 17 Mar 2025 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwmRv/d/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6D156230
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203255; cv=none; b=Cj6CVwxEuuNA6od56aDyYrs6+GfrX/ilEHiLc6m6WEQrm2KtaY9YH1O63PutCo27VkqSE7A9N7E5Mal4DUpLZHPZ3NsXqh1ybNOo6DuxqzBeEIKKdfTIfJHm7rL1KktSYAkMYEKg944RhybJhZlPWw7rBKCT1QRlSOCFp1x09K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203255; c=relaxed/simple;
	bh=Q/+AHXQipPI9pdeVK9yPvcZHvPRhgGkv0v9BH7Pp1j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWRpQwvPpSiSZ5yGmwbsjECXSNMRWPsic+bWTeIHuGTiHH9svbPH+Xx0/GeB7cYPUIwcHEkJbPAN7oapSY39qz+osdxTjjf/R1v3yE7n4+f4GeSNDANzt3kDrhlxL9SsQllsjopgiWBwcE9Vf7CbLpkOYaCsSIAXk7tqoZtofSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwmRv/d/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742203253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQAYtZ2CgxPyvA949q/2IqdYnbjoNl4FrlqvLUk18K8=;
	b=LwmRv/d/xIFgVXHGrucb1vLS6iHuwq60u1cDXk7/AiluzndvjKGLyPhokgOKL34vuttHIs
	hCyLIrbODAiyYY9f2Y3bwF72T/3+0zVusF4PpUsx5s9yI87yMaOk0J/UQIxzGYw2zmW0Q1
	NipJG4dtUBSkWBj8H7v1M0163azXKb8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-279Wvfj4OLGqv7iILYK8Fw-1; Mon, 17 Mar 2025 05:20:50 -0400
X-MC-Unique: 279Wvfj4OLGqv7iILYK8Fw-1
X-Mimecast-MFC-AGG-ID: 279Wvfj4OLGqv7iILYK8Fw_1742203249
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so491731266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203249; x=1742808049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQAYtZ2CgxPyvA949q/2IqdYnbjoNl4FrlqvLUk18K8=;
        b=BHk6uXMGdV4JfG4g013WDZIfMyQ06UBgCRQ+RbAeQrnjqNzPj1HYzIIAyFY9GSlLrL
         hFQPJqqlHc8A99L06q0W7rJFwVM/QP0mN729Ts30u3VPYOlR92McL2kVYYsp4T96fXjW
         VzX+4yCxJDF3WcKLcNrQzSrXds/BsIqlgKMK58uXUq2vH8cenIS0LAEa18RLNdoBgguM
         vben3dltxCkrCxojBVFZhnKNE+j0YA1PufO2DFW6YilpZ0M/rwr6SbRzAmlx6jXsbScf
         BvEa1bfeSEFrU0PqIJBsimQM34fY6KTrJy8gURo6FvoqEulBYfOW4WsLDaJ/CKyoopK5
         LmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9kIaeguBgwWndUG7y6I1E+niJ10T+421p7qrsa8DtoooEhskVCJ6gitka+YzeUhtmKerbc/5gtJNsKn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzpbPoP59pyp6xcHoqCbw1GHN/YlnoXQDmva9JUoUEHAwL3d6j
	VQhSXHkIaXyEvkEMMisSV/qV7f72xcXqDbCLRLQNCc3kEHCdhUg50b1Xj+WLzi8t/xk7Irp5NYA
	A4u2hyz4yjV63qsc3aerLYnojEjsPElnl0WwTAATbSglHVkXHuueU2nhoxM4sWoJ7jbnjgMY8
X-Gm-Gg: ASbGnctli879nB9ZcioZJ3ES7Ak6aHlpapv8CQ+XHUX3E7YJXwYJ4BD+yfM4ZMgADbd
	bHaLVcTBsWgrMM58LmjTl6T6egdpxjmvgpPBnaq+mNNCqEa6hHzFTLdbFhcJZdLBB2ADk2Qdn8G
	kpFbrh2vViv2u/aj2B2PLzX00kfksiwn7Jizzuac6iq9ZGZzIrttJeWCGvVH2wFevnSNayn6Y1e
	KYjA7gYX2Rda8JjRv2MnMMPDWrxogNWGxrE2bres9I9ony2jEYYKo/Y1dl7ZG61zrPQ/rIEp9n6
	MvbJhSL+SQ6cahY2mV4=
X-Received: by 2002:a17:907:7d87:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ac330398078mr1211678266b.37.1742203249021;
        Mon, 17 Mar 2025 02:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB1+oHBvs7PLecMQRxLRVqXxUJqML6+iLCfi91FLVRX4dLs4qw1VqVUoq/BmyEZsMcQH+KkA==
X-Received: by 2002:a17:907:7d87:b0:ac1:f5a4:6da5 with SMTP id a640c23a62f3a-ac330398078mr1211676066b.37.1742203248622;
        Mon, 17 Mar 2025 02:20:48 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a3e0e4sm635730966b.136.2025.03.17.02.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:20:48 -0700 (PDT)
Message-ID: <65813e62-aa0f-4167-83c1-49200fc4ca20@redhat.com>
Date: Mon, 17 Mar 2025 10:20:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm: panel-orientation-quirks: Add Zotac Gaming Zone
 quirk
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
References: <20250222164321.181340-1-lkml@antheas.dev>
 <20250222164321.181340-6-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250222164321.181340-6-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-Feb-25 17:43, Antheas Kapenekakis wrote:
> The Zotac Gaming Zone handheld features a 1080p portrait OLED screen.
> Add the rotation to the panel orientation quirks.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index f08cdc81dd9a..bbbe707f541d 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -479,6 +479,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1 EVA-02"),
>  		},
>  		.driver_data = (void *)&lcd1080x1920_leftside_up,
> +	}, {	/* Zotac Gaming Zone (OLED) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ZOTAC"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ZOTAC GAMING ZONE"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
>  	}, {	/* OrangePi Neo */

The entries in this list are alphabetically sorted. Please post
a v2 (of just this patch) with this entry moved to the end, just
above the special "One Mix 2S" entry which is at the very end
because its DMI matches are all "Default string".

Note another entry for another Zotac device, with a board name of
"G0A1W" has been added in drm-misc/next, so please base your v2
on top of drm-misc/next.

Also the freedesktop.org infra is currently being migrated to
another data center, so the drm-misc tree currently is not
available I think.

Regards,

Hans




>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),


