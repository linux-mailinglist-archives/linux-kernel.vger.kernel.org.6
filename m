Return-Path: <linux-kernel+bounces-269964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4859943962
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71554285B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDB16DC33;
	Wed, 31 Jul 2024 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bovWnuJ3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80116D9A1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468492; cv=none; b=cq5Ef1LKfllsmiDAMJCdHpWrBUpfrjMFzqfYxBbT0YMfhn8GYy5RWyF58KJ8mFR/BjcXgUrYxCyXjdFpTK3sBy8wvjmI+fsO2Wf2UpJmQojiqN3vDR/ATs3zv0gTM0ctpoyJ3faOhGhJMLTfLia0kkYlOzcymuIeZJgDlaZlF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468492; c=relaxed/simple;
	bh=d6AdsipEk4MLXXiJKWtkXUBzwbCvfSMjpdsOlyih8do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUmaF+5wAz7ttKxoIgOcXgPhQk5LZfgupYQeCCDiWSQvgO+3FOuwLm0YaVKUdbL41Lw8FDbiAK5ObVUcygc0U1T0iBHHyaeOvxmPPmPGQZnjYSCIUmG6eyCz3xAGYIMAVzhp/2/YgS/xlEYqTOZHVBh1xEJ0pbEz7BQSLF3PGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bovWnuJ3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efa98b11eso1115998e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722468488; x=1723073288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqHZocMKxa/Ko3Sh++uN9uzIJCUlsYXXKu9+HbfCVaU=;
        b=bovWnuJ3vZyq8Ub/XiRUeIjzciYuh84UqnqVB6vo3eDAY7o5w+ZFL+M8CIV2YeSxHB
         ghbYTKSawcFzwBlCQa9bam9kyU8Ih+fkCjNpl8cFn/jJKFTf77OpaLjQZAEQr5ikl+lp
         cQmUqFjGWh8EZqoq/XJtUMrBCptcLAFAC8IojUM7raH1Yw4i+fEJieNaVtORIDHAMiz/
         pINUEjQqe2o2bi+thvm2o3JzUqVHcB+iVYcv3AnYSuPDzMzGBVBZGBfiUTkpsY0/zpKT
         R7sdfnpydgXLJH7AMG+0xyKQA3BbbQnIxlxO12coKnM/3B2IxJVAOKmE0rd228q1qGxA
         0POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722468488; x=1723073288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqHZocMKxa/Ko3Sh++uN9uzIJCUlsYXXKu9+HbfCVaU=;
        b=WybNQA0S1B9xibCd0fkYKIDL5PbvxaTmdyCbGqSvt87TXTfHPiPkA1T42wFGsRIXPL
         9DpTmkGvO2s2nS0l10PAXAOoaFtBYsTcsHpph/B2EketSFS26XQNBKobH++GN52x9hVV
         zndeyGdPzOoWln+9wkj3KdP/Avk6ydtg5ffZJBpH60zyHIrSQBl6NBml5wzFOUU2dEnB
         5imkV1OmxvHy/mcJAnCPI9j7KTJ1zxPY+EOZyN/QsJAhkGMSdq5yp//2WwxNnR6LFN9c
         iU2srDbUvmE5Ove0Lt7hwQilz22XGOWfr4qpl/PSHmeWb/3RORTWnlzOE3Sp5XYw6q9p
         zn3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFH9fLdQpc05aZuwi2dRUqd8qp/uWhPwoKgP7wycBpw0n7erkO8XTRrNtkxvtToCnEURWWDqj6a9ojcNDM6EW1e27pNcfIa5G/ecpu
X-Gm-Message-State: AOJu0Yzu5bhqxlj2QSQT4kPu8axMZD2ZgjlK13GDUkRYSbdBRsyO83fW
	87B9qU7mfpCuvoNGcV7VGdf4gH+y2ney894Qj1F+ww3klOy8f68P4HUa2aLOAWw=
X-Google-Smtp-Source: AGHT+IEVnR6j3jFdtxUJKU/Jgck8FoyZtrhc91nFNQC6ya9loWcYJtZmkKE5MgCmxbWf3QzYhLwxmw==
X-Received: by 2002:a05:6512:ba3:b0:52f:e5:3765 with SMTP id 2adb3069b0e04-530b61f6825mr144386e87.6.1722468488246;
        Wed, 31 Jul 2024 16:28:08 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd12b4sm2401016e87.102.2024.07.31.16.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:28:07 -0700 (PDT)
Message-ID: <e051ad29-fc96-4d6c-9e4c-be46feb189ce@linaro.org>
Date: Thu, 1 Aug 2024 02:28:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] media: qcom: camss: csiphy-3ph: Rename struct
Content-Language: en-US
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240709160656.31146-1-quic_depengs@quicinc.com>
 <20240709160656.31146-4-quic_depengs@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240709160656.31146-4-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 19:06, Depeng Shao wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> The existing structure captures the configuration of CSIPHY lane registers.
> Rename to struct csiphy_lane_regs to reflect.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

