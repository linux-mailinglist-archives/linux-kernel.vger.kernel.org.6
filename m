Return-Path: <linux-kernel+bounces-219492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BEF90D39C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4262853DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC7E185E54;
	Tue, 18 Jun 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIAamhF0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5608157E94
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717929; cv=none; b=W2hjq42Q/umUvi7PwHW/yo+Zy9jVqohqmb1a/713uTe5O/5fK1TK5ojMiVatexjFWAg/yod8T2jochRZ1rAn/qVUBx5XO5Gk8MHO1Cz6tHUw00TRRVBfXn3GaGc062/jKaATEcjkVs19BllW9jJ00Ke2rCtb+xigoFyBD1N7Anc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717929; c=relaxed/simple;
	bh=ZXkUgUNTrV2Fb75kL30lUgvJVNwEi/AAcntzHmWItcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C691oOCrg0FA95jYKWd4staVroQubFOTNncUpz+qnP0/vS3ZIbAo34qd/MBE2OoBHYl5mV+tbV/6Sw4fJ4PlsxLVkJXDKPxS9w7FvNleHh67IW6Bqwr7eyTEgeOsJC34PAhcqjTcKlORkMfJyh45CK8AxeuRpWiJXi7WDcXV1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FIAamhF0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52c525257feso7052235e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718717925; x=1719322725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ro2D1q0Iet+JsxqYv5jvanxXyaHmbiQwWFVhwfDlws=;
        b=FIAamhF0V9693BMdus4wQuGNWEmIOyfMJ/Odz0QiAdEzJwrz3GyHrD+4tyBCMwXRXV
         8VlgHOUl3b0QmmGwqIM0biPJ+s2WC/ibIWJbrURUsdm6d25h80/JxaTFEBX82b0WK6Fv
         ZvvA+Pl0YcIAXUz1kXpOW42PqxyTs3WKYUhoABQxe5w2SrmcbpqvlzoIkiFBpwL034N1
         b427WaGr9dfjcoEwyr0hskfzytmjCcEZ96MIYiHZpsYhzYqOCy8dTrKCp6DKFoAhwEly
         SpHmOcMDX9CiWGiC8iY9TEx3QN2O7vRfLT5ozhMLetR5U+y3kWYwr54d85n9Bt315HZT
         nW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717925; x=1719322725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ro2D1q0Iet+JsxqYv5jvanxXyaHmbiQwWFVhwfDlws=;
        b=fiqYoZy9lXOnrf64nhjOAMpaZxu8juyzUrHSfauiy0YqSWhlO6bQ1N7HHRxOxV1DhG
         MAPRde2THr7jTPWBNdUG7aG2AHrHFEqZjMLhYL3TSgNnSC9fhwVdChUgrOM2Xy1nMU13
         qCfYU/0v7lqh+UfqxXXoEZLGwx25dQysHI/oMlXy6ZHT1hELWpRSKPA5nUA0QJB853yw
         Gu8sA7ErgIzd6EnJR+yHq0EdWl6QPDRkuwqUMoTE3kCrFqSPkHijFvAHJXYKJu5FAINP
         35Qv/je7FVydbyQmMWutnhcjXcpJBWaGpxxZ8htd2Oopx4L8RgLeAijTnQh9sBJx/2hJ
         xkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEW7AtJUyhlcJKEAEgWe/FosXsoqoVpya515X3P1cPaE3FkvdNDFuxHM/s89WhzbxZxsO9TyUsLNSwKdklb3Pu8l83oFE+jivs8lT3
X-Gm-Message-State: AOJu0YwKtKM9mlHTgCaWVpZdEtc2tu47NvVqkmzNa7c7JpTTDfDhKpsu
	hOxadLstiFEQINC0cT+1n2rihP5DRE5NgIexnhunF3VGHue8LZ6I8intzocs4xQ=
X-Google-Smtp-Source: AGHT+IF87ZxV1Eqx7KyoE3WteMFt56EssikJPs0A4NGrSgdY3b3dUyfEiaDVHF88FgnOxhFSt2XIWA==
X-Received: by 2002:ac2:57c3:0:b0:52b:c292:f7c with SMTP id 2adb3069b0e04-52ca6e9886emr7565855e87.62.1718717924535;
        Tue, 18 Jun 2024 06:38:44 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cbc12bc4fsm627269e87.292.2024.06.18.06.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:38:44 -0700 (PDT)
Message-ID: <e5b7a888-8ca3-463a-a2de-cf719e58d7a0@linaro.org>
Date: Tue, 18 Jun 2024 15:38:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] arm64: dts: qcom: sdx75: update reserved memory
 regions for mpss
To: Naina Mehta <quic_nainmeht@quicinc.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, manivannan.sadhasivam@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240618131342.103995-1-quic_nainmeht@quicinc.com>
 <20240618131342.103995-4-quic_nainmeht@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618131342.103995-4-quic_nainmeht@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 15:13, Naina Mehta wrote:
> Rename qdss@88800000 memory region as qlink_logging memory region
> and add qdss_mem memory region at address of 0x88500000.
> Split mpss_dsmharq_mem region into 2 separate regions and
> reduce the size of mpssadsp_mem region.
> 
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> ---

Alright, we're getting somewhere. The commit message should however motivate
why such changes are necessary. For all we know, the splitting in two is
currently done for no reason, as qdss_mem and qlink_logging_mem are contiguous
- does the firmware have some expectations about them being separate?

Konrad

