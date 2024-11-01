Return-Path: <linux-kernel+bounces-392602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C319B9610
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21371C21C70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE21CCEE2;
	Fri,  1 Nov 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="XxGOKzte"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F91CCB5E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480296; cv=none; b=nIwiuND2gUOClrC1XWH+KXmgJxfWC1le20rJ5NgkjMlTErfBYx6gPiJPLGLbTXxQOctet4pDhlNG6gqzDs+ZtyTu3NkiQJIVUYV0Ipngjmqii2b0AtBZHXni0rlESWAFBXsT91fSX8CVms0pGBuVb+ObNkrMxw7xhcGxlyC/nxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480296; c=relaxed/simple;
	bh=5ua0i6SRNpuWEK/yWQUjFdR/CAmilD3VbEcQ5chLct0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RARgEc8duLBkdVISK2CzgCX3f17RcaWo0FKQGrq5mLNEJZVCJn4tmd2Iv04lv7xeMqSVBt3kPQyN0gjJyGiD1Qc/uX6KI0qMhRfsSdPlpxrCZTkAHU1R0p0A+1dTi8K7GjDYF+pq0l+YICyu6aCM63ZuUUvu2v+55FRqRp+cyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=XxGOKzte; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d50fad249so1504970f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1730480292; x=1731085092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZ42MofQarYX/wWDjy0bAGDnZUGwKJjh02fFI2gvDOk=;
        b=XxGOKzte2GreuSasFfcz+SMQk67oNGk2j86i18F7r/haUAr6/C+oHLCoI6EjcFnR/B
         7rfGVijVIxJN8SPIJ4hvdxKdt4jL/neBDznKJ+KsRyJux+SlLAgcHU+olmY9WZOxnXv9
         ZvspF0ddh1BT3qGn1cqFdHzUGomxpzW0HGWgQevjoNOg+7jHRM/SAUHBmhfoN9NBOA+L
         7qsOZyHCwuN5TS9fMnFFW8KiKI4IpFh3yqXcAbeyKjASOFr2lBFFLb6D+eMPrjkenGo6
         Fn1krqGvRZ0SelJZuETD/p8A81ePRkpwb6/u5Nbgx5o4C7Kw9EQrRUsaAP0hymihokYg
         jNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480292; x=1731085092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ42MofQarYX/wWDjy0bAGDnZUGwKJjh02fFI2gvDOk=;
        b=gJwVIB4wqLg38wgKYcAuEZJXH2aI8TWx1kfHvgYDR0f8QiDBZ/01951KWbUqf5kcEP
         MUmTLSXpQ+BGFF+KXSzPebZ1kcsE7Ns5IxWZdsRsmvFjhTvdY1WlegPZS2sM+RJfvM+R
         QzbmJ8+ito+ED4asYBqxFkanq5CD6bvUnBLpu/kTrioQIckq0K28gY8D251Bk7Gn977f
         CTBJnAnLio+s+bcZOQmQYcoOgmxEFC0ll7WcapOsPDDiQm61ONaXp8cut4tW7N3yb89i
         7BblmsuYkHFbBJO8kZXcZ8R9c511zk85EmE4Yv81ZUNJ1H3s/PM9OQIOOJqEVs6ZguF2
         F6rw==
X-Forwarded-Encrypted: i=1; AJvYcCXt1hIE5tdQTHT5Tc4ii9gAaPsPiUp68C2bVaGkZE2Aqlq3fLqHfaqf73iAlvr5UEI9CeF+v8qt41pxhf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/+QicpzysycoXjhP8Gd8uEcD5uXrn1RYh+Mt3JcGVTs8bB5U
	Sint34b9GV2qO+JqT4dUTPXeDcRNvmf0Nxh+VeOmWtSED3ffT29kDGuOc5e1WI0=
X-Google-Smtp-Source: AGHT+IHAa9n0wqCDn1QohNNd+/WglbGtAr9r8mfa5nPglSkmQfcoBT7474Lu9a4Ebh5JwKugHCwsiA==
X-Received: by 2002:adf:f18c:0:b0:374:c621:3d67 with SMTP id ffacd0b85a97d-38061137930mr17850679f8f.24.1730480292095;
        Fri, 01 Nov 2024 09:58:12 -0700 (PDT)
Received: from [192.168.0.35] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e771sm5706776f8f.81.2024.11.01.09.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 09:58:11 -0700 (PDT)
Message-ID: <0a6ee450-6582-4d00-aa8d-9a5c0f2547a5@nexus-software.ie>
Date: Fri, 1 Nov 2024 16:58:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: camss: vfe: implement pm domain ops for v4.1
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241101-camss-msm8953-v1-0-4012559fcbc2@mainlining.org>
 <20241101-camss-msm8953-v1-1-4012559fcbc2@mainlining.org>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20241101-camss-msm8953-v1-1-4012559fcbc2@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/11/2024 13:47, Barnabás Czémán wrote:
> MSM8917 and MSM8953 has multiple VFE power domains they
> have to be power on/off explicitly.

"have multiple VFE power-domains"

> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>   drivers/media/platform/qcom/camss/camss-vfe-4-1.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> index 1bd3a6ef1d04d8610fd1bee0c22cdbc147c98de5..9a9007c3ff33b40f4c88cd30283f0ad42f8e8d00 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> @@ -938,7 +938,10 @@ static irqreturn_t vfe_isr(int irq, void *dev)
>    */
>   static void vfe_4_1_pm_domain_off(struct vfe_device *vfe)
>   {
> -	/* nop */
> +	if (!vfe->res->has_pd)
> +		return;
> +
> +	vfe_pm_domain_off(vfe);
>   }
>   
>   /*
> @@ -947,7 +950,10 @@ static void vfe_4_1_pm_domain_off(struct vfe_device *vfe)
>    */
>   static int vfe_4_1_pm_domain_on(struct vfe_device *vfe)
>   {
> -	return 0;
> +	if (!vfe->res->has_pd)
> +		return 0;
> +
> +	return vfe_pm_domain_on(vfe);
>   }
>   
>   static const struct vfe_hw_ops_gen1 vfe_ops_gen1_4_1 = {
> 

Otherwise LGTM, once you fix your commit log add.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

