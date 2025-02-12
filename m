Return-Path: <linux-kernel+bounces-510263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9BBA31A70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BF3A5A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67DB79EA;
	Wed, 12 Feb 2025 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMoxpFTI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E82AD5A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319843; cv=none; b=OmWoR1oxLvF50ACleUJn3QT98s2xVQsWMlW8TgvLaxyeCDA1Irl4lzEwGKJTCcqF4vFhpR18uzKbjQl9Bhj5578S0sC0XK3x2qEZRo2RH78MhIWHuucfnV7cUsi1AeQTSf4N50x5DhA4aAnW8jyleS4+pSTydSTMpIc2ZHFCp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319843; c=relaxed/simple;
	bh=MMNIfstKpT3Xv+vjrM+xLax3j160hMjGDMFsgx2aZZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ha6adk8Fa3wn7ulAVbrH8MOby8CgynGB7wU1HI38O8zBphYOfyssKl5e9TN52WL24SbQVsfHV7MxTVVSF6glTLhigZh3qGTnOz2z/b+64N06o2LA6u0Gxkq6vdzrAJBKSbkDATR5NUt/i74nTDt0mSfZwOtdExaYWZRgmDIxEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMoxpFTI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dc9f3cc80so1787328f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739319839; x=1739924639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfGDmNVScHcIIXsQGynSfUjulJw6pyhwlJ38vLwzZWk=;
        b=WMoxpFTIr73AN2BB4dxNfqAYPuDXPgwIoKsUoQlE7yqaKEcwWyYWw6QSFK7DKwc3ub
         pnoa5I/kJUxdjrSj13jEfJrrE8eDbryizcfhPjsplswbje5dA4G+ShvRo2vf2tIz5DQq
         tMQRyE4iibPNhyQygG3cINM+ynyvrhSvvaKgkh9s7NHmyJyYDmKXQBMLcUjB+cgajm3X
         sLCO4J1mR2rmgC/bGWK9sxYTbtfI872QFEUbEC37096AeqCYe3Y5SNjvbjlymOmp+GGL
         IAebTvxfG7qppsOO9i/CmEbH5xvlld44vsJ6ai8lHoyRCBO/JO2y/7uGAeOtBt51GxvS
         ziMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319839; x=1739924639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfGDmNVScHcIIXsQGynSfUjulJw6pyhwlJ38vLwzZWk=;
        b=R8rS/Qq9bpZEeX0gAMrMkxM+PSzTHEHTZXI0eV0tI8bEczRSDPr/iOuBDPcCfFmChM
         g9LPk9gfTd5vG3cU2+Fdxa8U89qXv5WEzLhQ7xE1jbq3J5furSePymvRzMNUKwVEAa1W
         /0dZLzLI4fTMDu+vh9ldub6Hkve1bb//vvD+7/FuBHTLZgMK8uSmnpbWx3puaqCJpfds
         1mmg9DsKrz5jkftMGmWX/FX5BO7XAK1ANmheKaZGGPYV50BwKj9jYrNbPAaT8Ggq5Vza
         dOlukMQP7/xIhrAgYbhhyOH8XGsu9yBCzwL7SG361NoMyf6Q3OlevrSmVHjmRyqpvJv/
         YN1g==
X-Forwarded-Encrypted: i=1; AJvYcCWYUc0WKgAZ9hGGEkS238RxE3caaoisYXiixnErgMtU3nECnbiN5wTis5N4/nTgJeGi/vPsnJPwW5NY0IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BrueFMH8kzPHa/Q2L2ECMzUwrRa9TW5QV2u4IDJkVMDRH3UD
	eTVoWRPzfA98+4HlelR2Qrvd7Kk3CGVxIIDCHdHCF2AdRKXh3Jjeec1AQyg0AH4=
X-Gm-Gg: ASbGnct247ajgjwQ+q2/wFUZwR2YtogSdU6a+IRyrzE50vxk0jQeXq3317sE4YWAQIx
	Ki70B9R6nqAesIzCdCqjeplDkCVLmwGn+VvgHoHtRZLbwpGBHMfTFkma/nHbcejizRQAn+8pURC
	qcoq+axQ3S3QHx9o2LdKLSbE6vnQ0HpkOIWbg8jePP3fgYVsiP9JqhyE5ofeCTVYIvdrklrRVze
	7mEtsgSoU6I56j1Cs9RvwSIC+Vixu219ay5nS85r4DNPw2W25BWwQwEdsdCpZGONNpgpYDZr1ju
	86Oo6GXPAJKavwsYlWBcUkBhxeXOVth4XIVTgMB5zgR+koPgXY5GejYazw==
X-Google-Smtp-Source: AGHT+IFu89sJVtv0ICMn6U0AgL7LBis+tuWkq5wW4VledUbDa+V9LIa1AQ9mV/LDKZLoabTxS2lvoA==
X-Received: by 2002:a5d:5f50:0:b0:38d:cbc2:29c3 with SMTP id ffacd0b85a97d-38dea28d03bmr739530f8f.33.1739319838684;
        Tue, 11 Feb 2025 16:23:58 -0800 (PST)
Received: from [192.168.0.156] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcf35b15bsm12517006f8f.64.2025.02.11.16.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 16:23:58 -0800 (PST)
Message-ID: <8d05999a-b623-4a3e-b611-3f917cb46b82@linaro.org>
Date: Wed, 12 Feb 2025 00:23:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Venus driver fixes to avoid possible OOB accesses
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa
 <tfiga@chromium.org>, Hans Verkuil <hans.verkuil@cisco.com>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250207-venus_oob_2-v4-0-522da0b68b22@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250207-venus_oob_2-v4-0-522da0b68b22@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/02/2025 08:24, Vikash Garodia wrote:
> This series primarily adds check at relevant places in venus driver
> where there are possible OOB accesses due to unexpected payload from
> venus firmware. The patches describes the specific OOB possibility.
> 
> Please review and share your feedback.
> 
> Validated on sc7180(v4), rb5(v6) and db410c(v1).
> 
> Changes in v4:
> - fix an uninitialize variable(media ci)
> - Link to v3: https://lore.kernel.org/r/20250128-venus_oob_2-v3-0-0144ecee68d8@quicinc.com
> 
> Changes in v3:
> - update the packet parsing logic in hfi_parser. The utility parsing api
>    now returns the size of data parsed, accordingly the parser adjust the
>    remaining bytes, taking care of OOB scenario as well (Bryan)
> - Link to v2:
>    https://lore.kernel.org/r/20241128-venus_oob_2-v2-0-483ae0a464b8@quicinc.com
> 
> Changes in v2:
> - init_codec to always update with latest payload from firmware
>    (Dmitry/Bryan)
> - Rewrite the logic of packet parsing to consider payload size for
>    different packet type (Bryan)
> - Consider reading sfr data till available space (Dmitry)
> - Add reviewed-by tags
> - Link to v1:
>    https://lore.kernel.org/all/20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com/
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
> Vikash Garodia (4):
>        media: venus: hfi_parser: add check to avoid out of bound access
>        media: venus: hfi_parser: refactor hfi packet parsing logic
>        media: venus: hfi: add check to handle incorrect queue size
>        media: venus: hfi: add a check to handle OOB in sfr region
> 
>   drivers/media/platform/qcom/venus/hfi_parser.c | 96 +++++++++++++++++++-------
>   drivers/media/platform/qcom/venus/hfi_venus.c  | 15 +++-
>   2 files changed, 83 insertions(+), 28 deletions(-)
> ---
> base-commit: c7ccf3683ac9746b263b0502255f5ce47f64fe0a
> change-id: 20241115-venus_oob_2-21708239176a
> 
> Best regards,

I think this series is ready for merge.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

