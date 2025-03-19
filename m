Return-Path: <linux-kernel+bounces-568553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8DA6975E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90749171A86
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391791E22E6;
	Wed, 19 Mar 2025 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaVVn3EJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16321FCCF2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407256; cv=none; b=LQfAQhZzSGQFho8HojpGiRuYO4NKUb28scVGb0MggI1PrudmWepOYHCpxfua7TRo5/M4s6ovUkI9Jmj3re7+G6L80JkDV0rzoEdMVAr4PFWpy6HxnMtAYIscIU+JBYYd07palZeCm8/5H/JLZbMN7+2Scon7r5g4vPumVApxqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407256; c=relaxed/simple;
	bh=MyGuRyQlDt+foSD6CeJddJn3OL0fjbCOG+6NlRxWHHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acG0XuV1FyYgTrxeMeyk2e7SG0Lo9qZJwNQmXmrq6ceAPEq0ISpR+cgWnpdxEyzFg+xI1SXXnbCs5hXBeSFKm8QX6KIlbKqZriQW2QE0/npXr9yX1uxE+oCmYDh7tb2l7+WTaex1IUSeQ08xHRreV87qNYIUs+Fw9qTmzNokqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IaVVn3EJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso34018365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742407253; x=1743012053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rEfxvBCDj+OUf6/+Bbrxfwwkqzx6X/wza22OdnfwyY=;
        b=IaVVn3EJ07saxjGiHiWtvGjXIF/qaa3WjClDBp6ylHibk4GkapEP+mybG6d1sDf6Dx
         KxPmFfnTzHnbrW8rGvo4LTexhNVDI1MR5FPvcg5Auxike2KywKBf3nuA/kREU7L84fk5
         6l+sy9jDzedPo/5ghDrqZNNVCwEb04nF3lyZXv1d3M6PqXBwXeS4/9JzU+2aSa9/258e
         TQhNAFFNs9ClowK7BRpJ7yjcOGh3YhL5OjJQW2BQLK/44maAkkt9zrGXb3bYlOZeRPOg
         C5GxSCoa2OMpiN70ZY5H5KO4tB+E99z/wO/vi2h7Xwv9+cmCLmYSm3HSqr5YGG8LM5IE
         m6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407253; x=1743012053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rEfxvBCDj+OUf6/+Bbrxfwwkqzx6X/wza22OdnfwyY=;
        b=jY/5EoDoiTjIGrY1eifN4+sIZH+uvZsp3IR+m3aqcG/1v09aOoYK2b00GhThW6dgNo
         /aRlxxF9Q14MB5WO3tvR+PK5nhGTBwX54AHRHXCT8q5RXNIjJqGEHgIdAgGzIOWdHLSu
         5y16ldUY691SionRKL64NoIzbkVDZhlB7uOg8o2c49RWAy2N1On9KgIop2A75ZqbN7yK
         NgCqqFqvzB7qz8BlKgQuAugAq+4znrdO6BrvuNQWMipWJ2tWtFXosH2U5Z4sfebz/TgA
         AO2C4Xe5YK9RXnTTwodt30uoOnirhB/dEyM3z/c0P2Xnxr49ad9Kn7Mhs1Fwp7hFP7YV
         4F7w==
X-Forwarded-Encrypted: i=1; AJvYcCXiNntsysn6OAbThYQ3xRyR+P2Ua4Nux9Gdt7YJ/UFJVuSQbAVrb9XRW8wPtLPRxFGcp5KIXxeNGCGUjkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4H84MOT7snJxK2oygHt9obppN9XVvxYg0ixppgR5qAcNgecFp
	2oHx3GYaSY9FEQFYeGU9HxntCwxnz/7wBz/RqD4OgJBO4GMgZ7taeuYreKJQPYk=
X-Gm-Gg: ASbGncshdOmkzlhKwnLp8ekjPq/fdr5npXetG/tuz8PZVnhT6Zehq+Twj3DecVooSJD
	QsfgaMJeUUSEVTWehv024OTabkhfO5tz+5PWtlV1famjbQwwDhOjCe4sBZv9yJ2MoFsXbQul0vg
	xZ2YiQ6Qu1zt2Jbqglq9QseKf7RDLw1YlkJbODlgIbx4t2co/rZkVVn8ZxikUjp9uP1kiaqkCYe
	q8hHQZlkVu3J1SMuSSVs5ZucZ7+Jn3m7BuIFsfwUQ7AkHmtaXf0H+SaJAtbxpP/5FwGOn6bI98m
	G2R5c16aggPUyRmLCBFuPZgHOzytz4AVjir9nYK3iN3wBtMJ+7vPKh4cYZ+YOK8=
X-Google-Smtp-Source: AGHT+IFbFV/3Qs4DOHIi0NIjAkZVN8cQrhEL50TvwHlsiVaJpE49IvMubk5v6WpuWc3f92V/RIBWeA==
X-Received: by 2002:a05:600c:4208:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-43d46deb26dmr19657885e9.12.1742407252904;
        Wed, 19 Mar 2025 11:00:52 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbb7sm22140437f8f.92.2025.03.19.11.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 11:00:52 -0700 (PDT)
Message-ID: <938cb09f-3fb1-4daf-802d-2d95222f30db@linaro.org>
Date: Wed, 19 Mar 2025 18:00:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: wcd93xx: add bindings for audio
 switch controlling hp
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 andersson@kernel.org, lgirdwood@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, dmitry.baryshkov@linaro.org,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 johan+linaro@kernel.org
References: <20250319091637.4505-1-srinivas.kandagatla@linaro.org>
 <20250319091637.4505-2-srinivas.kandagatla@linaro.org>
 <4ie22uuz5tpg77jto3c3hec6lhonr44hrjda7jk655axlaxvba@u3atd4gcyghn>
 <660115f1-d1fb-4fd7-a453-e8c177be9eed@linaro.org>
 <51dd7cb2-0c22-4043-b3a1-fa8410903cbd@sirena.org.uk>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <51dd7cb2-0c22-4043-b3a1-fa8410903cbd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/03/2025 16:03, Mark Brown wrote:
> On Wed, Mar 19, 2025 at 03:59:23PM +0000, Srinivas Kandagatla wrote:
>> On 19/03/2025 10:01, Dmitry Baryshkov wrote:
> 
>>> Is this regulator supplying the codec or some external component? In the
>>> latter case it's likely that it should not be a part of WCD bindings.
> 
>> This is regulator powering a mux that is driven by gpio which is part of
>> codec binding. So I would assume this will fall into the codec.
> 
>> Where would we fit this if not part of codec?
> 
>> Unless we mark this regulator as always on.
> 
> I would expect that the mux would appear in the DT and consume both the
> GPIO and the regulator.
Yes, its doable, so we would endup with a mux driver consuming regulator 
and gpio and move the gpio handling in codec to move to use mux control.

Let met try that and see how it looks like.

--srini


