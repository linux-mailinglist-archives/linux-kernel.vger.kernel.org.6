Return-Path: <linux-kernel+bounces-563698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D8A646CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B957A2BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23221D5AF;
	Mon, 17 Mar 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2dt3s+9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2127156F4A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202936; cv=none; b=khpFuERP/EXJX+9U58v/UqAgXb+UeFI8zjvhZ3jCHfhxLbsT/eRFdyJYW/01pvx98fbWPclUeTL4facImg9BqiohZj/KnlXm/tkUBFY4wqggI0a3h5kKri0XUIeaZNbg/c+6vDFxfcEfpIqa6UcWA+1ggE6zBR31bbCKhH2eXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202936; c=relaxed/simple;
	bh=FHNqXu2dQ3pTCBVNV+M5h/wjy6YBF9vDSkYSySPJ06U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eobLluIYbKRfW089TYs4xiZl+5a/qkOyQftU9Iw9u5tMhzFpcrt/Gpg+JkKL8QKnk29RsUPq48R2DQmubY0zxDD6mc/asFGhlFV023nUAiB17yUgVYikNzGPo4k9nMtddI21++kCBBs1g3OtK9iJG+z0nchn57fEx7SGXzeFeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2dt3s+9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742202933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIAAOpiRs4TxQJqO3H8zMcg5EqmQaISUPGVnUqQhVH0=;
	b=c2dt3s+9CJ8JD0FKht79XpudQlWYdxowsLdrt+1Dfg1CwLZkNLvlwiAEZWU7AWrbv3ImDI
	WGs3Iq8LVhDXbRaK/NuLJZN8mt6cYj+G+ajrPt8q3f4wqoma5Gvpw/yfUIywoM6o9CUZtt
	uv45L6VCL09SIWD+J6FYeokuuo5ksFg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-yOimzO37PpOI2BPCRZukww-1; Mon, 17 Mar 2025 05:15:32 -0400
X-MC-Unique: yOimzO37PpOI2BPCRZukww-1
X-Mimecast-MFC-AGG-ID: yOimzO37PpOI2BPCRZukww_1742202931
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ab76aa0e72bso338662266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202931; x=1742807731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIAAOpiRs4TxQJqO3H8zMcg5EqmQaISUPGVnUqQhVH0=;
        b=GalrTZWW0t9QDMAsb9bcTeERPh1v218vdYhp/0p6w7Ky8hcRQj1FaIQUwmVVk7r2IY
         G4clGy1vCFMjlnCmSYxoqVzo140rCSGeicoHRWLv5oVjA3hP+z8qwrgLy4CtXOZeaLYT
         HIROQ943hY188/l0LatREgOL3u6eQd0O4KI7hNKWpy5N5Q0h0uvS1Kh5/Nn8Rsg1bn79
         1LXXaFnsnXZl6NTptUOULJc1ua4pajVOpMI+5dKU7bq6QPFMTQAc3tqJRXRDNijRv5Xr
         VRSSeA/xM5NRxBW/TuysoXEc5vV0btfxu/IwacugHXmDsoVwDxPVlnuG+ygwdjn+xvD9
         t3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWCxc44/FxX5uFyFAnP4ZD83J+lsc5MmlYeZNQoB/+55z3dVY1HJk+sWxGwdRioN4Cb4vOSsqKdgMGR+c4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhr1YFvFAyWxq59gdLzgKMAH1relAlZkYedE0LI0BloEF3ncsP
	7S+moQK+c34ZeKLsITOSXgSRTEPofTu5HkoudhoR6pdEuxnU6osp8UQ8zM1FCT+gGWYjUXXfI37
	cR94fD3e/julmcsPyNFgUsu1WdF6ormbtHSrPhRyy2SQWcdEXdVa++UWTymqmVw==
X-Gm-Gg: ASbGnctrMKFar9P1CUOeNlpRMFWStMqREjpr3wzeN/73M0I1IYKv3JF5WYq/iQTiLAx
	mrc+hVOB/dOX44Une8zNL9me1TU4kzmu9V3MPfVbQR4UMeN17wcbHprUWOsHirUf09YgX6P8RHk
	i6wB686ZntoO7NQSRGFB2XXfQRyoWBo/Y9nsFHUlBVq1+uMjjk0hs91PG2/7bz42/eU+IABT6YM
	lddbV5EsPo8/i+2qXFScmQXh8sLnIXaW5J2LlKtb2qse6dmGKOEJBl8j7xK2fGV/JoaKqcu7qgL
	pfHZVxuaoBGEA7unPBU=
X-Received: by 2002:a17:907:6ea9:b0:abf:4da0:28e3 with SMTP id a640c23a62f3a-ac330263cd0mr1145881966b.18.1742202930792;
        Mon, 17 Mar 2025 02:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVgEQXboyYbKmNrxQ7JHNVXHwE52bzpv/usHr3Z/ihOWkRD9dFEsRbbwPj02jUfIcYiqzTjQ==
X-Received: by 2002:a17:907:6ea9:b0:abf:4da0:28e3 with SMTP id a640c23a62f3a-ac330263cd0mr1145879566b.18.1742202930421;
        Mon, 17 Mar 2025 02:15:30 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9d12fsm627043366b.163.2025.03.17.02.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 02:15:29 -0700 (PDT)
Message-ID: <bce3cdbf-2056-4735-9c6e-d67e0cd1dcd4@redhat.com>
Date: Mon, 17 Mar 2025 10:15:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm: panel-orientation-quirks: Add OneXPlayer F1Pro
 quirk
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
References: <20250222164321.181340-1-lkml@antheas.dev>
 <20250222164321.181340-4-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250222164321.181340-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 22-Feb-25 17:43, Antheas Kapenekakis wrote:
> The OneXPlayer F1Pro has a 144hz 1920x1080 portrait OLED panel.
> Add a quirk to correct the panel portrait orientation. In addition,
> it comes with a red limited edition variant in the Chinese market,
> so add that as well.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

drm-misc maintainers, I'm dealing with a huge backlog of
patch-review, bugs and other work.

So I would appreciate it if one of you can merge patches 1-3
into drm-misc.

Regards,

Hans

> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 1378690b7287..f08cdc81dd9a 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -467,6 +467,18 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 mini"),
>  		},
>  		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1Pro"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
> +	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) LE Red variant */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1 EVA-02"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
>  	}, {	/* OrangePi Neo */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),


