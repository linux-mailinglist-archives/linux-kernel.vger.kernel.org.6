Return-Path: <linux-kernel+bounces-310941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5775A96831A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A6F1C225C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B41C1C3F14;
	Mon,  2 Sep 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgpFQHIC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E91C2DB2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268975; cv=none; b=KK8WWiY16m8kYDK07wc409APdrjtp4Jvaxp4WgKD/+v+eCMx+c8dlPut0k7GQW69L1kE5oD3ycCUq/m465uizMGuGyNiE3nzs6EmIR9OWy3tLyTvf+XP/rni5TXqsgMmcsvqZ+PwPshwSs4/D3fDRvjHVCiM+YnWRrxx1S48dF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268975; c=relaxed/simple;
	bh=wTXjzMm1LaXvc6LZZwsmTnZ2rjRxz8FNqEBBjV5GM5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ0LQz+ZSwri3D1BnuULIjqwXzNWbkYltzfeZBPVni29lQMDSZrlFC0nfcAVWJTDrrl5SrJ/12RAkZajktSTng5ukAX9TpCpmzqDi5Lrf8PZJjV+KLJSzZrOEg5ZRwq2lXh/ILWN64zfAG83ToUC5KGfdKXD8mcRYM7AbRNBy9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qgpFQHIC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42c828c8863so8051605e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725268973; x=1725873773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo9xRnJdvUPVCwcTQSc6bKjRX1ZXMbBoRKEkXONSfNg=;
        b=qgpFQHICt2VF2XelYEYJhzIyz+d9Yjm+LW73DITwSP4QOOQ7slbzs/hrzqIFRPE/3C
         G8bDp5nF8FUasQow9USAbNcgvISXVIitTVV/nbZ+Jn5vFEI3TuG37daLMBzU90bGGZIa
         0J0jI+XSV1P7D8IF7QH9YGvbwDtjY3NbX5pO+xXH0vWuHmijVTBINaqfS990Xus70kB4
         smC712yLBrFYhGnJAOnrCpjgxURLeuIIoLnevreAXEh60sXu1rIwwzZlEg8c7ZbU2CNP
         OH0AAQlIczFO/K5pOcmyAHd4Lgu4j8EizA0QHibebDLlMJJj/6332uKvM5/DeKEy1Plt
         MzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268973; x=1725873773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo9xRnJdvUPVCwcTQSc6bKjRX1ZXMbBoRKEkXONSfNg=;
        b=C+JAYkhWZ42qaiGsVIsNCCrgg/aDqvVmOvl6kaNvrMG4an5YUIgjWkgYD+De08JHDP
         sLoMbrr2EuedzZPeYUN8DvjQp5w5zF9+Gs/mtH0Q8GJUxd0LQ2Rct3j9ot3Gc/GhXuv1
         gjIwgByQVFX0sPZ3LfTz7v1mA/7AVYzKL6VrBBY53bVjCT/T75ZmuGdWuFdmGRPAyQ0Q
         WS2NkBKwhmn4CacuprBVblgLzAXQVvVQ98scsKNWoBKjI2BjlY1wNuzpjH+9B126LD7n
         4k0FxW9JrFjTJcN8L10icDbyu294bc6oIxgohGYy/Qw7EalJA8qYLCay6oYco9thosBa
         fxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQI02gTWePKIuY4kHqMH/pttUK9Lr6699bzeyoz9zNl3rQq6xkhwvL2RJvuzF7Z7+GKJfwLdwGJg1DDW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo7qrFxgcDu8bA1QheAjX8JAqFT9kylSwRMuskSVlQq2FK+2df
	jfs4tsZpiI7mHZJT760/p9vdS+xIzDPoHI8PELVS5v+oPsPM6eQ50EpBEHxGuVg=
X-Google-Smtp-Source: AGHT+IF2gbQEyM2KIz31TtTPfHNgiRlJUVBglGH3hjJxPTZSWs56UQKIWHzmRWcrPQDNaxXj4vwmzQ==
X-Received: by 2002:a05:600c:1c07:b0:426:6b92:387d with SMTP id 5b1f17b1804b1-42bdc6377efmr55810205e9.21.1725268972166;
        Mon, 02 Sep 2024 02:22:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6df92f1sm131711915e9.25.2024.09.02.02.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:22:51 -0700 (PDT)
Message-ID: <9fd1fa22-caa8-47d1-a576-2cab2c65a4dc@linaro.org>
Date: Mon, 2 Sep 2024 11:22:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: qcom: Add missing iounmap() on errors in
 msm_dt_timer_init()
To: Ankit Agrawal <agrawal.ag.ankit@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240713095713.GA430091@bnew-VirtualBox>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240713095713.GA430091@bnew-VirtualBox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/07/2024 11:57, Ankit Agrawal wrote:
> Add the missing iounmap() when clock frequency fails to get read by the
> of_property_read_u32() call, or if the call to msm_timer_init() fails.
> 
> Fixes: 6e3321631ac2 ("ARM: msm: Add DT support to msm_timer")
> Signed-off-by: Ankit Agrawal <agrawal.ag.ankit@gmail.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Applied, thanks

Sorry for the delay. In the future, please send to To: instead of Cc: 
for the maintainers

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

