Return-Path: <linux-kernel+bounces-209603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCCC903851
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1964B28972F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30E1779BD;
	Tue, 11 Jun 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkAi0XCZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E714E2CC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100136; cv=none; b=m0OrHbVTAHmy+to4OgIkAUpaEUqBXcDHDeVTUjpXiXJwCWno5ye26iGlkU0jOZJXWVkI/eUApT9XumedNiFcTnA63UcJDeMIcosb//ZIWIRLQ+sIphXPfQLYhfjQxByS61zMwulh5PTqZusfX7NQ5Cuu1/OhQ1ml6KHK89sbIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100136; c=relaxed/simple;
	bh=hSVWSwArmmkzeKKyieCdRmhcvRs/KXgmVg4cdbQtpiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrOTaUw40entM6HsWUfuDGrGn2aOleb3FdUggdfvIe/TxGjBCpcQGZRckd+HIhwNduuQU550BREDeLG+FmjQRRog2wxXgomlT7jtn4JZeTddWn5wOCvATlg5WRIvDpdt8AkHoUDOLyplicmJX8UvupSVxF99MP/6dcMDRhClclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkAi0XCZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718100133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybrwft53atk6SF7ZUqNAnkZ2feuXIglpHBR+lKADkBw=;
	b=EkAi0XCZz8HkCGQYuiCRnd8kOo+6nJXtlyD/7ql5k7GqTWkHuB7gP8wab6xVJkv8DC2A19
	vah18IM5n/mUCFdVhpod6S0UKRTws7p5aLYywkekm9PldBmq0vA9Rl+X+G1LTxgFcjD4ZE
	qUamNLHOEttxfUgHRhW7Bo3H1GONZOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-G6r88qlePDescpvp6BFsYQ-1; Tue, 11 Jun 2024 06:02:11 -0400
X-MC-Unique: G6r88qlePDescpvp6BFsYQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f2760ab86so1249659f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100130; x=1718704930;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybrwft53atk6SF7ZUqNAnkZ2feuXIglpHBR+lKADkBw=;
        b=iuKM5aeMnZCynU0LnGr7gM4h/Hz7F4sJqWN7Q7wp0MfHcskGWwscyWgyrLhm4UbDX8
         s8Qwy8aeq8Uiy7kWyJn4IK/P+DNOClLiAM5h/M0lYHjQoifVu2QnyoiK24ESa7AyTw4C
         o7IJx8qp6IJHOlgN7QP2QE3V7MucGI1HnRNGA9EbdUCIrHPH0b9Ov93hMUwe/ph2dAVz
         6hSA5ISR8FPU4qFsYwSjiz0ZuMoIEr0UBfnMRtFIddnjCo/mKpG1NrCZ1JNWphKoWfsv
         BC1Tv3sV9Xd8hbbnRRRLfJm0FuYURxSVkQTbXfFdkcpsMlyThuAQ+YBjzsWDSMwNmP6G
         9Zgg==
X-Forwarded-Encrypted: i=1; AJvYcCWY991ZqCOham7ccxJgoz4gbF3Ip+NG7NT7dn0i47EcHj+6Myjj1c790WH8CEK1Bbtsv0iMFeTNpS/bmAsXfvpmXcfVwQw42r17a4ny
X-Gm-Message-State: AOJu0YwxcuzXWjneexSVwSVGnkKjVP2APRy7enKKqqTy6YdwVdAeQMgn
	p0R0Lz+ThtYAE6gARlS9vNyuwFD5A2CEgv2yItsYLkCpMmAGVHn6f3VJ+v+9EBRx/fVqrlYMgRA
	AF+svJuOBfQLkfWrp9ulH6iFD8S1Ykry2zWSpacCKcXNYgG/hkUFul8yGBbAMHQ==
X-Received: by 2002:adf:e3c5:0:b0:35f:1f06:3d9d with SMTP id ffacd0b85a97d-35f1f063df7mr5752578f8f.70.1718100130585;
        Tue, 11 Jun 2024 03:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKZL98uEunjHgV1dVr0GvsBw6dhzSAWM/mji33SSRAXlWoRbiGLGcShOXcwnVxfeWG9h8t4g==
X-Received: by 2002:adf:e3c5:0:b0:35f:1f06:3d9d with SMTP id ffacd0b85a97d-35f1f063df7mr5752550f8f.70.1718100130173;
        Tue, 11 Jun 2024 03:02:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e991c9sm13431003f8f.70.2024.06.11.03.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 03:02:09 -0700 (PDT)
Message-ID: <de79f41d-3a9b-4f15-b270-246af8b4c5b0@redhat.com>
Date: Tue, 11 Jun 2024 12:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/nouveau: remove unused struct 'init_exec'
To: linux@treblig.org
Cc: daniel@ffwll.ch, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kherbst@redhat.com, lyude@redhat.com
References: <20240517232617.230767-1-linux@treblig.org>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240517232617.230767-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/18/24 01:26, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'init_exec' is unused since
> commit cb75d97e9c77 ("drm/nouveau: implement devinit subdev, and new
> init table parser")
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Danilo Krummrich <dakr@redhat.com>

To which series does this patch belong? Need me to apply it?

- Danilo

> ---
>   drivers/gpu/drm/nouveau/nouveau_bios.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
> index 79cfab53f80e..8c3c1f1e01c5 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
> @@ -43,11 +43,6 @@
>   #define BIOSLOG(sip, fmt, arg...) NV_DEBUG(sip->dev, fmt, ##arg)
>   #define LOG_OLD_VALUE(x)
>   
> -struct init_exec {
> -	bool execute;
> -	bool repeat;
> -};
> -
>   static bool nv_cksum(const uint8_t *data, unsigned int length)
>   {
>   	/*


