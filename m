Return-Path: <linux-kernel+bounces-424873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8A9DBA89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034CB281CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520811BD027;
	Thu, 28 Nov 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkUF91ZK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91BD1B85D3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807996; cv=none; b=E5OSd2v0qMGQx5N/zGnDo6fcQ39PDNt6JYCDFazrhgLAczFLaFuZIjSmRWrKkztDI84YWaHI9XMSf7rp2ZjQ6GdY5o8VPm9/Dd3A/4P12Ns/qIfYEKxvHTl9xHXqFl5BSJ4ShK52Tr79nXp4siP7Z7PydOTGaa38vjZ0Rcfj9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807996; c=relaxed/simple;
	bh=dx3goeI8+PmUxdVOKxTaj371TsZOSoYSr4uocxe6Z8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSU4W1heTYBe4v4gP5gjrgeHsXHWB0ILh4ai2w3HrBWNq1/5mzra+/s1UebIf6E5KJPmk5E8a44cmy/p49bppmS+zM73d3Ar4VfN9gznROM1eEEcOGRLwEc5WUAN5roNByZLixi++Syv/FXh5+yNOXeCBlWvT0o6nxDyvh2XbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LkUF91ZK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434ab938e37so6109095e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732807993; x=1733412793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b10DWlFGhowRIZrTbsC3lQ8oGfF6ijd4eqGNQhzz/3w=;
        b=LkUF91ZKeuFzUv5JTlDdnEcfthD2KjEJ1gExOnRfYGGBY9pcHNgz2ovMtF/XqwhDw6
         57yUVpE7HYdml7SHWtRW/ALP5h4EXZM5o6b7CQVx++GxrAZbVnnommoNrkVf7lvcqZrU
         gfZgVdvIdxIA9L+75Dnkgl9yU+9JXP+ttb3UPitb1tPx5CR0ogUzH4k5+yh6LmAWSXkR
         xpo1QuMZQ5AJ8SrH3YH05gmKQXrGJ+mN5oH6eDUR60lmV1S+8cGoIpTYXbNDELQCn4yi
         cfRb+ys6OgkJz3oeF8afeCwUHpBK1iJ3mSCvFag9GfWdM0m46MZGKlZ/w+ojaUcTbGk2
         cjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807993; x=1733412793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b10DWlFGhowRIZrTbsC3lQ8oGfF6ijd4eqGNQhzz/3w=;
        b=AdYMIs8Yu7HlvlhWKdSpjNWFrFFUZBDn6ft33cZTx0xN5CvS1lLMu9e6PemriyfIb/
         /pHVj0pMHVZS1HxF1SlZVb4GC15c12Qgmty5mTTHeUrkEdfwjUu1PnhCLbRitnYYy/mm
         1yq4J3OGICEBxMXdZzFQYwpRom3Lec435FpTBmzWlQOpHrUXFyFlMfgsCfYOSr0VEJaP
         p7Hq+jKrHOc5stEteJnje16Bb6A/3a36HcINU/mrMe3sFi30lF7ionT4Ui/jCNvWB1mX
         JDPsn53hbSAujf4NqpJ2WVGSpyr1kvM4+zA9WyzgMd53SOdd+N3K8FBCLX2YxbWG5j9s
         jNbw==
X-Forwarded-Encrypted: i=1; AJvYcCXxicJk50qpkXv8+YA2op72PJmwhoX3+1B3piPaJdBfEG7VIBSz0MncDVCqazc7qnMDgqq8FcT0DixDV5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfBwJqEJQlLS1nOLG7tXaDvaq41jKlYqhsjyhteuWYBa8ulY5
	ZpohSf2z29+xBi2uIIliI/ygLgjuAEFO7U0cd1Pil6p+14jICJYhiCvjrl7SpeI=
X-Gm-Gg: ASbGncualxwfA0BLTsqb5EHMOK1ln8vymt6vvUDic8QOM0EnshKNQeLPoz0FBeIg54r
	p2QVnTAIhv9qZticLkPbpvykq6X4gn07NfXDMwB0mfK828Tcl4kv3bbvtqj96s9tUsy31mfFu1P
	CvJgh3lz3vPkY4+U9Nh7jvgJfUVOVYFGRFV/OfKK+gbwZoj11D0IAgEtY6NLUtzNIA5pOA82eLf
	vZGrSAwK8pWsAD2iH3X7GRbdXVR6OLCqffIS1f8QFaNs9FbNgerxzclzWCft8A=
X-Google-Smtp-Source: AGHT+IHhe6rWMKeZvorX4t+eGWKL0ZIgBhqqLgt6DS02uIjaCP6eA7/zHMLPK/b/0LdU32MW3mQTLw==
X-Received: by 2002:a05:6000:4818:b0:382:5af:e990 with SMTP id ffacd0b85a97d-385c6ee221amr6272363f8f.49.1732807993306;
        Thu, 28 Nov 2024 07:33:13 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a4bbsm1923305f8f.48.2024.11.28.07.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 07:33:12 -0800 (PST)
Message-ID: <0d74695a-b28b-4cc6-884d-6756f58f8be4@linaro.org>
Date: Thu, 28 Nov 2024 15:33:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] media: venus: hfi_parser: add check to avoid out
 of bound access
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241128-venus_oob_2-v2-0-483ae0a464b8@quicinc.com>
 <20241128-venus_oob_2-v2-1-483ae0a464b8@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241128-venus_oob_2-v2-1-483ae0a464b8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/11/2024 05:05, Vikash Garodia wrote:
> There is a possibility that init_codecs is invoked multiple times during
> manipulated payload from video firmware. In such case, if codecs_count
> can get incremented to value more than MAX_CODEC_NUM, there can be OOB
> access. Reset the count so that it always starts from beginning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_parser.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 3df241dc3a118bcdeb2c28a6ffdb907b644d5653..1cc17f3dc8948160ea6c3015d2c03e475b8aa29e 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -17,6 +17,7 @@ typedef void (*func)(struct hfi_plat_caps *cap, const void *data,
>   static void init_codecs(struct venus_core *core)
>   {
>   	struct hfi_plat_caps *caps = core->caps, *cap;
> +	core->codecs_count = 0;
>   	unsigned long bit;
>   
>   	if (hweight_long(core->dec_codecs) + hweight_long(core->enc_codecs) > MAX_CODEC_NUM)
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

