Return-Path: <linux-kernel+bounces-436342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60649E84A7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECD61884B5D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6519D1474CF;
	Sun,  8 Dec 2024 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0IH9upu"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176113AD22
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733657239; cv=none; b=QbmdAFI0JivVHF/ZhykO6zlAOf9DmdhCyUmquz1t72PWynv/QHb5izE6vmEX1FHnVNxE0iY1WEup5GwG+0fW5At51K7QhmHeCsYBxxXzl8+/dWq0G0u+GuTxF01X1EHXBRfBWRPmSeN8oMf3tZdJWi8nvG6yK7M39/8lGQX85kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733657239; c=relaxed/simple;
	bh=f0Jo04c/T2mEssbQZfNecevl2eZUZV/9cEdpBG53Pu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t35LnFSh5SAeDn+ZRKaP5OJGN64qwtkbTUX4EhQIdggqfXiGX7KWfJ2AuXNWzt93MlrYD6vHoqDc0lp8sJr+XzNujxI9tlmM6v6NkxBQygj+2eitQCbsDXTS/SEYj3OFexFy8odo9YdsnIGtAjjyvaSJJGc+O4BbLpdHXFyBaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0IH9upu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e87b25f0so2621339f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733657235; x=1734262035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsVvC94nl2+83Y2oLBYdgCRMUN1ZyQsu5kZ8QEDXwqU=;
        b=V0IH9upuOgAkkRZjlkrU0Dmw5gHwzfLvi74Ag7cMDEC3L+crwxac+Uwbm0K9st8szB
         cR2jFbISYyTNWCIOPwaUCEegR8zhm/BIap/bIJLGMPkVEHldvE0igGZIT9NDx5O5HV0g
         tqdeTtwpUCuhPZtaHDa+S+FCW6C74+zJPKgZMuR/xpkJ6TSkME0qI5n6KxFKpvH2TW+2
         G938cU4p6LbaiUT/s6LM9tX2kh5W51ln4kuECy6D/e/ScPfMVDLpPMrm4/JQ26mV9dK+
         a13oofKQ6pRpR0sDAbLKoh6RtYx+ZnhwUL+jdwu/nZtiRJiz4Q4bAl0xGYdEp3+VZ9VY
         NZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733657235; x=1734262035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsVvC94nl2+83Y2oLBYdgCRMUN1ZyQsu5kZ8QEDXwqU=;
        b=gVKzUVR9oJm3tmHf0AG43i/nt/xh8/jKrfsXcbKt/ffilBJIJBKozggMvbBoz+1kHv
         42KzzC1kJuDXi5EM2oRqBROv8d1Q+Oy9zc1B4wYTj8V8BeeoBiJZRqohr18atj+6ktlH
         33QWFm4laW1Ie9eFTgojBuwMP0F0+tb7pmFve2W/QWX0w147oKQbHxBRnX6egmzpq8IJ
         4GbTUHnKJSf4yT6FMAXqZifDXBEIbl1sMZBHpQkLYWUD7n5sLMnCdxDOfFCZWRgZrL9B
         YltIpovuQpm39M/OWYWjNX7TVr+zhSTeui1cEJ7jPyZfviEyWUWQATNNHpnjSyqdrUyS
         V/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1e60Ve7kNYovVkzRhekh1KigdSHGebBAAeZ5KErblrMyKY7NrhWyFzMNtfWqeFWlMxBXVwUPHYvdIIkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEs++mNDUYNzD39LDEPK5zgQR9VUD02JQdfdjnIbxHN190AyRu
	Svd0dJUTI1kLWr+VVTKy6oNPHvKnpWGuJaDalh7jD2GbzpzWafpqb6nvlLYjj38=
X-Gm-Gg: ASbGncuZUstbhoNKfWuZFLvmlAc8ovWQoiNZ01glW3RmDiori8oNwdRmlo9WI14psKH
	mBF387tr1lx3CgfUW14U0CSa/Oc/mPVVQWyA6zPzxdkRv/w/aGN+0XuCBtiCd5l8ssp7Agllk7p
	Z+qjfCPBRPIuzsqGhEDdmVRPwRSwt4PEYAua57n9BqUPr7EBH/Xbe72arrv+vPE2S3ynjSdb/Sk
	CPP1ri557+41X8tpJFL8kzO1zbst6ubsBQe+KIQOWiRLPSfI6GetoD2FLHpjxM=
X-Google-Smtp-Source: AGHT+IH//Ct388igxpj5Bg2HRBO2RyulR3RmoCk+xAmpaxF9sT8ZNwoRAF+tNrtLfoOXVJ033QX4iQ==
X-Received: by 2002:a5d:5889:0:b0:386:3d33:a61a with SMTP id ffacd0b85a97d-3863d33a7d8mr433893f8f.27.1733657235343;
        Sun, 08 Dec 2024 03:27:15 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4008sm9654693f8f.22.2024.12.08.03.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 03:27:14 -0800 (PST)
Message-ID: <fd8538b6-4c9f-411c-89db-6936ebed7464@linaro.org>
Date: Sun, 8 Dec 2024 11:27:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Add sm845 named power-domain support
To: David Heidelberg <david@ixit.cz>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241208040055.30509-1-david@ixit.cz>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241208040055.30509-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2024 04:00, David Heidelberg wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Declare power-domain names "top", "ife0" and "ife1" eponymously for the
> power-domains TITAN_TOP_GDSC, IFE_0_GDSC and IFE_1_GDSC respectively.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git ./drivers/media/platform/qcom/camss/camss.c ./drivers/media/platform/qcom/camss/camss.c
> index 67fb11cbe865..62c556c4fcf8 100644
> --- ./drivers/media/platform/qcom/camss/camss.c
> +++ ./drivers/media/platform/qcom/camss/camss.c
> @@ -927,6 +927,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
>   		.interrupt = { "vfe0" },
>   		.vfe = {
>   			.line_num = 4,
> +			.pd_name = "ife0",
>   			.has_pd = true,
>   			.hw_ops = &vfe_ops_170,
>   			.formats_rdi = &vfe_formats_rdi_845,
> @@ -954,6 +955,7 @@ static const struct camss_subdev_resources vfe_res_845[] = {
>   		.interrupt = { "vfe1" },
>   		.vfe = {
>   			.line_num = 4,
> +			.pd_name = "ife1",
>   			.has_pd = true,
>   			.hw_ops = &vfe_ops_170,
>   			.formats_rdi = &vfe_formats_rdi_845,
> @@ -2647,6 +2649,7 @@ static const struct camss_resources sdm660_resources = {
>   
>   static const struct camss_resources sdm845_resources = {
>   	.version = CAMSS_845,
> +	.pd_name = "top",
>   	.csiphy_res = csiphy_res_845,
>   	.csid_res = csid_res_845,
>   	.vfe_res = vfe_res_845,

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

