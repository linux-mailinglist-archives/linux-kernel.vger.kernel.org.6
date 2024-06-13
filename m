Return-Path: <linux-kernel+bounces-212743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3990906590
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351281F22545
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588713C8E3;
	Thu, 13 Jun 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zISvuQ+Q"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422A136660
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264913; cv=none; b=ojcBfq0ZhECIBtCr+p+dWhzbrsTyhkd58fyRHLj4DaRGSrltm7flDoGXrmhrJ9P0PBuPNkvyzYAfB6hm7a+Zkest0IG9nBFjaqnVQd7u9qMHb8Z6XfrYRJK9fxlk9r5gvXwEEOMc9Afc4PMD+yNBcr//OjutQkDlxMWbwbL+VOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264913; c=relaxed/simple;
	bh=4WP+wvpQcfDeRRO9xJK0LLuMXzp+fXt20Q5xyse7NL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcZb2FrDNu2/sIfXqiFJEeHMWkNjnfy3lIziB/UdQX1nPbuo0CyKZvjm2DFcrpubj86n8ZoEJ3S++tRVssEWNwIsliICt8HzDJDkhwu220q8b8H2HDksS6yEkFgUJL639HH/ehuQZR/2OxCCJg+CUV1QppoqmVOgDtFDD5bO6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zISvuQ+Q; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc1261f45so835196e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718264909; x=1718869709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdTreM/4CjpbEldQaCtjNolTelGaHpzCWji9mFlJTjk=;
        b=zISvuQ+QH3dIVH/kACxiA8chwONrMKFXwjbzldw/Kzk9J9tu4S2ulbvMGBIVDkXtBi
         Qoph+vHwIfGjSXDs/mRZHYVhW+VsqTrfhN8MEpQHhrwxlN7s2Y8hksZ1IBsKFqv79Pqz
         I/UZ2efQ4ii8Ol2QoUX7jJPOG34IwCCaSkQJhlJwTFpeRkmSCVtdLz7Ps0Nd18oHYBV2
         2REY65RllXcfht70RNv0bV6wUvhT8pRVB7kigkEhbeTScnYbxRQhMXVaNWEJNdaKb9PA
         rK8ydZQKCdr9Tw/6HFQ6CXhG0Ui1eV7qNi9h6Z28AswVdrJtYCYusdMC5oPbttJiZFui
         8dxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718264909; x=1718869709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdTreM/4CjpbEldQaCtjNolTelGaHpzCWji9mFlJTjk=;
        b=HAgQwpc+bMcpuSPAPAdn8P5u+Hq6Qw1Xd4le2893sJ7E93h8Kjo8WdyIAjpnPQBzqf
         cl+Ie6qtVjzP0ohevSoK1FT9+He6iPReXc8713Z87ot+IncLK7YDZjP6M4lGno8TRs41
         AeRGSWX06PRs2fW0KyPNNctRviEXO/ymLpWot/sCSye5ujzZ8JTWOHlblumQP6hpCcFM
         u+97XFZQRYZbOM7DtX91XKMfgYzUoRA4rTS+Hxz/kqjHkfhUYY/DbW2D/C1U8HdLZH45
         ceRw0b7KuqYKtVvwrtXVLp4xxo0bMQ1zT5E2tHnSasg7a6K56aPHYJjMSzCRJ5C84i6E
         TWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVawCpHoiSoUCR9gu4PENMYTUKKsJ6FocLke5zjPcVNpjkRWc4tOdepAeCMdRkvCM1IbhrDFAlMNVSCWV7J7dJaq9M+Kjj7vT5CC90l
X-Gm-Message-State: AOJu0YwB0xG6uGAkRCFMXxKMf0AemF0SQEKIrsS0cQl1GOTTC7DnTqYS
	fVeK8RRFHVQShHs1dLncoG2O07rGz8Azr6Q0GEi02hrQCS0KjPO0LkY/VS4s1QA=
X-Google-Smtp-Source: AGHT+IF2OVDFCqDLMt5hgTHiYYN2fy6FsGkyibfB0dHYIVclAaNr0xSF3MvK0gmdm1UmC+fM9//mUQ==
X-Received: by 2002:ac2:418a:0:b0:52c:86de:cb61 with SMTP id 2adb3069b0e04-52c9a3b7977mr1991716e87.10.1718264909540;
        Thu, 13 Jun 2024 00:48:29 -0700 (PDT)
Received: from ?IPV6:2a00:f41:900a:a4b1:c71b:4253:8a9f:c478? ([2a00:f41:900a:a4b1:c71b:4253:8a9f:c478])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca287aaf8sm115607e87.194.2024.06.13.00.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 00:48:29 -0700 (PDT)
Message-ID: <2b39d763-5b79-4b21-85f9-22fee9f87468@linaro.org>
Date: Thu, 13 Jun 2024 09:48:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: qcom: motorola-falcon: add accelerometer,
 magnetometer
To: Stanislav Jakubek <stano.jakubek@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZmWMh6fuLasvGkR/@standask-GA-A55M-S2HP>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZmWMh6fuLasvGkR/@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/9/24 13:05, Stanislav Jakubek wrote:
> Add the accelerometer and magnetometer that are present on the Motorola
> Moto G (2013) device.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---

[...]

> +&blsp1_i2c2 {

Consider setting a clock-frequency = <>

With that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

