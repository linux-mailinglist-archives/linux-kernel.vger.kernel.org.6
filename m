Return-Path: <linux-kernel+bounces-200562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C88FB1BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FCF1F257E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9CF145B15;
	Tue,  4 Jun 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quS5XTwL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8289A143C6B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502668; cv=none; b=fmqqqHcqBfcCeYgiNIStNH7i2Celvq+LPShUG086H/7kktMF8T912rkDCm/Rliyc6FOX/DcoHQ9C+bNHbmj6Lge2RM19yM5FGkYl/0TNPiTub2e5ivSPg+Tr+b488BSPjTENgCpW2RRg06nhdkNvMi3Q41Yy3RmTFY5L8OE+Bbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502668; c=relaxed/simple;
	bh=/kneteCPCpqHlp9tXjC2t5lBUf7lcFi6dbTAQMTLDqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz3lw90ltAObGTK7Bzp2QIBqmf88whV8JKkLUsWxXOW4tAqtkRscTr28w4nQS4FUFBR6P4E0EcXjYgHPGtY0av9372ZJVH0b3fXVZ9RtcaB+7i/Wjbg2dFfqwHctDUrDkOkBs6hpnaqs9vxzDA9BUslUOvTQgZ97AaCCgiX6MkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=quS5XTwL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a634e03339dso608016266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717502665; x=1718107465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7MvGhNWyMWyPK2L4bZ4MqGt4IE97x5CMmdDQFmH1Pbo=;
        b=quS5XTwLoovDQQk8lRofvaEEtIQeVcljE91pzNdLoFbXzFDQbjZYPdh8etavmMW6Us
         Td1ToP1EAKwz8Da55CbUg4A21bbehX2XxAuGg1fy7kxWB78+hFc0riE8KtI2HPysAOSU
         d/7u2RakClgN6jZSBLWW46uKDWC6AaKUvL0ECBOJWWGjFqJPwjZN/WoWr/lHe1UzJDui
         siiyJ2ozlQVCL8wpII/FnR8kRMZ8djXXMDjTdrA019en4WVHCyphYpSRoXWNhIzQLUrw
         7qk0B9EBbv3+8Avo0yWv5u/IW/Aqxa275hHrw/Kq4vMj3GRhTxnDV2kcoR8xpIKazt1S
         tTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502665; x=1718107465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MvGhNWyMWyPK2L4bZ4MqGt4IE97x5CMmdDQFmH1Pbo=;
        b=SBvpY4YlEsqn9x00dKhCt6JRYL27gtff2qM+hx3NRubxmvZsoRWvWw3fIGP1ukh9z1
         J7TLCc76fIHhciW5yj4BkE4pWYK+VKEW7YO8c0CjeggzLJIo2UhZpdCoMUllqwKo2Wts
         bXoZJqTZ336aJAj8yHCmiX7FTgzaLO08784GK0j9GCgHlOYOUnY4N73sKSMpdrS7IJrC
         KQUn4fRuuLb0VMZWro5pYQFxFnqKnc0vyvOdrFzyOm7lFbAc+TNvizbG4FKSDAmQQgeN
         mHm0Ff2GLu6FIbSkZMd8DUwHp4BCWNkmrwqD/dKfhRXH/41HlX6HboxgaHJX0mkN1cm1
         pr2w==
X-Forwarded-Encrypted: i=1; AJvYcCUQs6tdZFdmunGOxQUBaXnW2Q3m3icoVRysa4zYEplqivvNsFeWtq7pDZUp/gKFk0UUE81N73CGZJ1CX7Uef30j1P9soxZ9aHOIrK3A
X-Gm-Message-State: AOJu0YxgmgA4A4t0ioV3dkDMBgfFI/C5fRJqLHFkfrLEfTtmSTIwG4Nl
	CRxEf/Kuji9PDrSRMjvqhwbdG2TtwPq7YAPzlLxIMLDoNdLfRTx/vSIKvQ263cc=
X-Google-Smtp-Source: AGHT+IECAlsltuVi6m26ltiIWvGYFVpqO3x1P3yYUSdWLABarTbzVL5ur/8K36xQS27mfUaezyvswQ==
X-Received: by 2002:a17:906:e241:b0:a5c:e16a:2d12 with SMTP id a640c23a62f3a-a682204963fmr653331066b.50.1717502664844;
        Tue, 04 Jun 2024 05:04:24 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b143ce90sm487613166b.182.2024.06.04.05.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:04:24 -0700 (PDT)
Message-ID: <09e6dbe0-d748-4333-b05b-32e96f96a2f6@linaro.org>
Date: Tue, 4 Jun 2024 14:04:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100: Fix PCIe 6a reg offsets
 and add MHI
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rajendra Nayak
 <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-x1e80100-dts-fixes-pcie6a-v1-0-1573ebcae1e8@linaro.org>
 <20240531-x1e80100-dts-fixes-pcie6a-v1-1-1573ebcae1e8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240531-x1e80100-dts-fixes-pcie6a-v1-1-1573ebcae1e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/31/24 19:00, Abel Vesa wrote:
> The actual size of the DBI region is 0xf20 and the start of the
> ELBI region is 0xf40, according to the documentation. So fix them.
> While at it, add the MHI region as well.
> 
> Fixes: 5eb83fc10289 ("arm64: dts: qcom: x1e80100: Add PCIe nodes")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

There's a lot going on... but I suppose the change reflects the commit
message and that I suppose reflects reality

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

