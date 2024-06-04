Return-Path: <linux-kernel+bounces-200545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939108FB17B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1681BB22D01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E1145B01;
	Tue,  4 Jun 2024 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcalEGgD"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502D145A0E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502129; cv=none; b=fsoZ/n5XLqcZxqc6bIQhTD3mPTO+Li+CYDRgjg0xKm27sXAlpE/hLfYFa2IfA3Pm727npkZK4kjVZVQF/BTq0lw1znedVoAIlSvvhxH5pSv5geYcJJjGO9ovJemYvGqvaD2D32ZmcPasXifNjGDM4bNXr1Swx8bfM5ZePtMGrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502129; c=relaxed/simple;
	bh=yf+ydN+R982IdKmF4n3pntMyWNKFqfXc2Wo1bpcEdxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgbfowFfReBrntCjUoLeTzt42B4B8b5cVXAUI/nM8GnooemDq7NABzyEb+JsRaR9nAhLuCAJ5hRuICydEh3Japy6FJQ6nYrVeHmdnXLBORkBCHItKUrE6UMHHOzhoKsFmfvKKmzAbQfPD2FB4I4mBDdpa7DGujTfGX3QK7Orcv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcalEGgD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68c2915d99so96624766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717502126; x=1718106926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6VdsvIa8zMQRCvSPBfH+t7XShyheFf7xCTS+iDnU7A=;
        b=RcalEGgDgrN/x75cijpLoGLQrTHBTXBlPsq/r99yaX5Rx4DAsxs6XsUamB7Ezjrbqs
         l83HWWwBZI5A63n49YJvih+DZVClNKXrNTd63pprl1p7gmQGeLsc20DRqVpRAHwtKbVG
         TVUJWeNuDWtp/DzGbHesmxCaC7wTdut3YKo/qjlZQWpowEMKJ9bfm+MDYQ1OkkoyfrPi
         i22tYEGAcHXpPCFIKoyMGoCfkIyRbPGSaB6o8Si9MYHI1DoHzi+eTv/O7Qtzc5wUkNer
         nAzGLX1Zq5FhQX81IfWQlVssBabOz77dfz3V0lesuiJmxm8v9n6WYTn4vA0sDM13QmU8
         wrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502126; x=1718106926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6VdsvIa8zMQRCvSPBfH+t7XShyheFf7xCTS+iDnU7A=;
        b=C+mb01IiH6Q/vLKjF/M03Ji29w6Hya8eEgXUlFKW2ZWtmfXBYd9nnbhUSHDd+HdUYG
         X6FOF6YOdt3N79BAhEokNPGEtT67+HgR6PGkiqHzMoq8pWRYGaqVbc4rNM/qkJIcIMmE
         3BmdJFpN9lPLaUnKoPpOmKuhQG/OeJ/vT8qHioACDQYPWGc512XVXbx3HmUZspROAamb
         /O4c3/EwQ6zg9jiCgDxAgVlEQE1wYwvyLwaUaQOMmVG8T+38A0u2FLE0AHTU/It9lGMg
         aXUqrSU7qU5ieIHKcO/KfbJOzALlgLFCeRykXWWgGN/WApCzluS7yt5IYgm66YmUx/ZQ
         Gk5A==
X-Forwarded-Encrypted: i=1; AJvYcCXwFh92NycATEuIGrWTwOmjMeuTS8ly6HBwR4EYV6U6OjqWF4oxElOb+hgPRHv4RhgG6JiW5+cVfyUF0chKapWzOpZQ1IcmmDzy0Qg5
X-Gm-Message-State: AOJu0Yyn4ZXWtXgqLQ53qF2gKoIc23tGeIOu+xQBujfvaeBHMohHxDHu
	PFDCwfObrlfWWAgHcWStxWqd595eqcwugnt0W2Au0qYjx8RBfqAer6xQVr7RmYE=
X-Google-Smtp-Source: AGHT+IFPMPPfIGwe+ITg80ybaKWLNAXwRZnyLNcFGdUR3AZt9Bjo6BQS8NFYbo5uuwNUOn4vIHjZ3w==
X-Received: by 2002:a17:907:914e:b0:a68:9621:a93c with SMTP id a640c23a62f3a-a689621ab6fmr500481766b.8.1717502126376;
        Tue, 04 Jun 2024 04:55:26 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b0795942sm489469666b.181.2024.06.04.04.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 04:55:26 -0700 (PDT)
Message-ID: <49fe3b01-4f00-4ffc-80cf-2a0add1ebaad@linaro.org>
Date: Tue, 4 Jun 2024 13:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/adreno: Add support for Adreno 505 GPU
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Daniil Titov <daniilt971@gmail.com>
References: <20240604-a505-v1-1-82ee1c04d200@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240604-a505-v1-1-82ee1c04d200@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/4/24 02:20, Barnabás Czémán wrote:
> From: Daniil Titov <daniilt971@gmail.com>
> 
> This GPU is found on SoCs such as MSM8937 (450 MHz), MSM8940 (475 MHz),
> SDM439 (650 MHz).
> 
> Signed-off-by: Daniil Titov <daniilt971@gmail.com>
> Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
> ---

This all looks very good, just a nit

[...]

> +		/*
> +		 * Increase inactive period to 250 to avoid bouncing
> +		 * the GDSC which appears to make it grumpy
> +		 */
> +		.inactive_period = 250,

Are you sure this is actually necessary?

Konrad

