Return-Path: <linux-kernel+bounces-442447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02549EDCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 02:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE399188A238
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F53307B;
	Thu, 12 Dec 2024 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uc9uDMOI"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2418AEA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733965623; cv=none; b=pTsySLsgyoEbNnrVnnHxOt0fMO+0peX1K+Whl26dkRcSv0COfHlhAWg0S9uFdNZQVZiAZA+yJL/sRUe0kwEzh/AenX6PX4EpM5cawdJ6rPtuTQqjafslgDCy2wjEbjdlGD3i6H1br2T6XsU7PYgpwG5/Kan5/5hfu1NWf0X4zCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733965623; c=relaxed/simple;
	bh=gJ1t7jFV9t3JAZ44S7dAGAuFRDkQYiEA9nywpShlryo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3ZMyc09Gf16Fvha7jer6Z3KH7lGUrupJf/ZnMBr6366EP4EwgTwB45aL8avl0jkEbpo38nM5L88JLkKhfqy5kNGqU5AhIAqg61OADSVT6DNop1tuW3s+CvV3HPHR9dw6pAeK8zsTm+PTU9Xa6Q4hbYXcg6SeoKciwD5geDw8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uc9uDMOI; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54019dfd6f1so12014e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733965619; x=1734570419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+woOY8TwWcN5XSeyhfjDCS7hZ8p+Y2VZWaYuLrMvp8=;
        b=Uc9uDMOIf0vUP6Sc85rbtXLFe7SF4L8WzXyRw/Iu6d+pXwtE53Rz0U0wT/JnlWupVe
         Klrz7h16ibZsLx3E2u8wEMAszOfBiT96jWzU/Jfsi4rS37SsG12qh+ghFsiLCTXqLlx6
         83hzhGzBGvtAe9M9+BOGjg8peGvedyd+7GpRWo00GIf86WvV78M29Z2DLGaY6nD7zLFQ
         V+ehlEHRVOBTZ8ZpxmqWpsVpmmUSmbnpzgVG6PYSQGp2Y39ac30xPFpJgxF9RZf8CQX5
         JYVsr9ssh46tlYnXZi/NwaedwE3zQ7KzqpQbbAR1U79kUYARG4CrbOU5vwORbtTcnsbG
         41Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733965619; x=1734570419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i+woOY8TwWcN5XSeyhfjDCS7hZ8p+Y2VZWaYuLrMvp8=;
        b=lmHRRwwloxfaVAlXJYA4kwOkNIH9ec0QreL4MCaiQTI9SMgm9JtcRqZvSkPM/AiMmH
         1RO01uA4jh8Il2QaM4HENjsIEPle6OwWdSY6wPsQacD7z9UJG2XKsYwFA8vSppHV28g5
         JiT6k3Jml/YoC8TQCFX0EX7nJeKJ9FLf9dDr8+Ww5Ylsn5OULk0tE7+LaiysFJL/Wiyp
         60wdMU4gKrxPUDMUTn/8ozxXz8mBl9x95A8k5338y881OxDMTdR0U4fKYutd+8LYEff4
         Ut5pIh2GB9/hLI6FI7Va6884KAWj0OCevwSFdSzWsLpSROEi7e4Y2P33twLyMRGhcteh
         Osuw==
X-Forwarded-Encrypted: i=1; AJvYcCVcJonSueovy0MlieQKNwlr9tsRc3i/QK+5J3b+BOxwewx/VQ7K7k6+pP7sCsn9MOd5/WiURKbhQdj7go0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRBojWxMt3Qvg/3OlhBOh44R4Ueb6WupPH3P+1ScagDjTYOADj
	ZFBDE5zBIxgDw1YdURskGALW0OmgZ0RcsJerwYOj5LLWGSog26/L7IjuTg254Qk=
X-Gm-Gg: ASbGncuai/KjWvV4K05G6RXaOHYOO04uAoK2jBd2jBUpps8T5RHzf1EXrx5YADSt3XO
	YX0D4xONV+dN421kGverbkVqYMlETd0/hGK2NUPYp2qo4i2/EPFWjVwpRNGkWM3FBO5HJTGzLcq
	yHjuSElq+3KTqhi+orgWwqUfopZyk4PhNInJctwhjxK7DulkSr6fvQLEURglvnsCW5ilUSER2g+
	W1E5sWigMM83+/GRg81IUZDvghSqB8XdS1vMF7NCPPUfZIJ3WCfjnWiOIlLd3+xPwZ6Pz8Kqs03
	hYI1+yglXuj5dWyYZGkv94sxlzxVrWiL
X-Google-Smtp-Source: AGHT+IGYDFFDuvEn3S5kjDIQpMD7AfzDjFeKfQ1ro/dx9kV4l9MhXuvGNQD+2H1a8bnVqwoSvbDeaw==
X-Received: by 2002:a05:6512:2207:b0:540:2f74:e826 with SMTP id 2adb3069b0e04-5402f74eb92mr149898e87.5.1733965618907;
        Wed, 11 Dec 2024 17:06:58 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2297441esm2191877e87.61.2024.12.11.17.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 17:06:57 -0800 (PST)
Message-ID: <79fc669d-999f-42f3-948a-ee5f3a91ddfe@linaro.org>
Date: Thu, 12 Dec 2024 03:06:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/16] media: qcom: camss: vfe: Move common code into vfe
 core
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-9-quic_depengs@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241211140738.3835588-9-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Depeng.

On 12/11/24 16:07, Depeng Shao wrote:
> Some v4l2 buffer related logic functions can be moved to vfe core as
> common code, then the vfe driver of different hw version can reuse them,
> this also can avoid adding duplicate code for new version supporting.
> 
> Suggested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> ---
>   .../media/platform/qcom/camss/camss-vfe-17x.c | 112 +------
>   .../media/platform/qcom/camss/camss-vfe-4-1.c |   9 -
>   .../media/platform/qcom/camss/camss-vfe-4-7.c |  11 -
>   .../media/platform/qcom/camss/camss-vfe-4-8.c |  11 -
>   .../media/platform/qcom/camss/camss-vfe-480.c | 301 +++---------------
>   drivers/media/platform/qcom/camss/camss-vfe.c | 276 +++++++++++++++-
>   drivers/media/platform/qcom/camss/camss-vfe.h |  57 +++-
>   7 files changed, 376 insertions(+), 401 deletions(-)

I've spent some time on regression testing, and bisected that this particular
change breaks TPG on SM8250 (RB5 board and navigation mezzanine), but in
a different way than in v4 or v5, namely frames are not captured at all.

This change consists of multiple logically independent parts, it would be
good to see them split into separate changes and get the regression fixed.

This is a massive and a functional change, since it causes a regression,
it might be better to make the change non-functional.

--
Best wishes,
Vladimir

