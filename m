Return-Path: <linux-kernel+bounces-219618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21190D59A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69312283362
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA8C1891C8;
	Tue, 18 Jun 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkkkRR7x"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80C16D329
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720650; cv=none; b=p+coYWleX6TFYgvpd2rtxwFfXV5zl6MlJ37OHfSk5Tq99gHpkjBA/J3nxVoB9X3PtWZFVnBZ+fd4h3+SiicJ+JOFcBjrz/7PlljrY29TeRp/xYrZLcTXTHmuys/+4oDEMJ+OxeHzrTwHAEPdt0qdrxJecBHw6Xiix/EhkVRkVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720650; c=relaxed/simple;
	bh=EKwts7PirqeXv8GCmsKD14CTWAvJ5DcMwJMZ4Q/8iFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYZLBHERBgKlnhk4ndKW/+UfPApSqwLds4EIBbW354sH7FJc6Co+zMi8jQHgCiF9IcgwYZOxem+ZQjoez8LemcxNS/e7XYo9KEaeTNclsuE1IOgdtNduCfXPg5yPn2f2L4u+TOmGhU+jHHIS2mE5fa4nj/dGNjAG7IOOus4OMjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dkkkRR7x; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so6828097e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718720645; x=1719325445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9L4PU16nfN2XQvEI7canBzFWJ5IZWFKBrB7QE7CDcc=;
        b=dkkkRR7xzTTNmR8H1BsizA+7zIa4y+TpjDbozsqQ4xLCSI6kkYBvGdBV4W96BO8GQO
         o/kpxQEKaK/G00YbhxQeWMlDxurcoSVyXt7aO9CGs/pLi6n2enj95vPVcjtDvL8mwQhU
         7GSQEXIZy5WqR+DsiEWE8/MjyIQS97NNFHHjvreki35Ggw0Qb/lErW+6fVQTjY+ML7Ol
         xdnQOfDlaspBRpwapK17MGujCAZWjGjuissVGQj/ovEAFFhzaE2bN8Uledl82qjTO97h
         gXaSJsv2mOVWDUR0loqPYceamnXO/9hAo+b3SXa4CZTeymHkFkcFvDLqZTMDhVzrhr7u
         LmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720645; x=1719325445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u9L4PU16nfN2XQvEI7canBzFWJ5IZWFKBrB7QE7CDcc=;
        b=NYql3jQKgVTj3k115/cjOs1T4PvD/cvSYfFuAugAgvUXFtdJhOJGZQSjdEeGNDTHg7
         99vi3ZPhZSblbJ8nQPUX3FOUKan9U5aqaOV7coNoG5bl6FoTL6JrsNFfxhU2E62MPqeY
         v6eAenPyzKl/7Pv4TXWrg+aIm/i+GCtQo/z2RhNLU7OAf+MnHgUQBvTdLBjsv+z1r5zy
         Enyzh63K1AlqfBkFOpC1euksboarAuB/7uTfqDW3EqXJDTcAD6An5Qxkneq4jeWeLSGJ
         Fi8xByfM/RuWVhQJm2M/7X4NcN83Bo6QRFaDijkC9CGCzJ08hqpt3UgMIF0ut6RKup70
         xb1w==
X-Forwarded-Encrypted: i=1; AJvYcCU/lpovwlrNyGGFI5xUWhJmqbfjlS47iiHjxYNU5gL8xQzqzbm8AUCC0RVMVQpgwAdOs3f8hPe//CDYkGVnSBY0EeCOZkikbr1fUR5T
X-Gm-Message-State: AOJu0YyeXVUQWjFJeMOq7XksQ5HgiC4x8FwphSiI52qXbLuXol17IVdP
	IBILBkh1DNeTJQK8PxQwR3Eg+xGx95fnqWmHIcd2M1TEzn+ol5BENF2ThRKe6dU=
X-Google-Smtp-Source: AGHT+IGtvNk8n9VRov10JBLuOpddIlR0ZD+NTpYkW/xoyHqQ3CBv06dPLM664Q2AuPsGRorl4CI30A==
X-Received: by 2002:a19:4317:0:b0:52b:e7ff:32b with SMTP id 2adb3069b0e04-52ca6e67557mr8965479e87.23.1718720645462;
        Tue, 18 Jun 2024 07:24:05 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287b34csm1510198e87.199.2024.06.18.07.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:24:05 -0700 (PDT)
Message-ID: <2dc3d7f4-1d7b-4aae-90c9-508cbe277a35@linaro.org>
Date: Tue, 18 Jun 2024 16:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for
 qcm6490-idp
To: Elliot Berman <quic_eberman@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
 Melody Olvera <quic_molvera@quicinc.com>,
 Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-4-086950f650c8@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617-arm-psci-system_reset2-vendor-reboots-v5-4-086950f650c8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/24 19:18, Elliot Berman wrote:
> Add nodes for the vendor-defined system resets. "bootloader" will cause
> device to reboot and stop in the bootloader's fastboot mode. "edl" will
> cause device to reboot into "emergency download mode", which permits
> loading images via the Firehose protocol.
> 
> Co-developed-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Shivendra Pratap <quic_spratap@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

