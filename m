Return-Path: <linux-kernel+bounces-219174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8B90CAE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A291F233F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6CA14882B;
	Tue, 18 Jun 2024 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqbhC4hf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C821487E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711642; cv=none; b=dOkn/z+iLMJZ1uj92Zd1svdcbXG+7LMb0z6q9kyCDoSdwWb50c66sXKmh3OZldpu2+1Kfw36u5kNr7b6h1YoqY993h49DsaiGX5BkkldIut9KXXLMelIvWxqf2L7ahrEzG4Vz2NfW7qQCXH/eQ/U5CBDay0kqlICeoAIiWoUpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711642; c=relaxed/simple;
	bh=B5uTvNOzDIfP+9r55UmyGlGOEn/VaHyTyNKLYbpEPY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqxN4X6bhyJ8U+v8I5CXuO2k3BiiJ+XmJVLL+tvwZskKWYzknBPrXvcuc6JEWjy+XDRghNkwWGPa/7kyB6wAUcKrjuggTENlWmRCtzg/0RHWTInxHSRBVscu6ewNlZFaVQsIDf5VQJHUH194tk3Poc+a9Jtg4IYO7SAAD5XVTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqbhC4hf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295e488248so5874929e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718711639; x=1719316439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tb4Y+tgvYIekmwgd2j/b166JURC40YeXenLXo1ek4Io=;
        b=rqbhC4hfUJHA6iziWG/S/IhE5ziSLaAf5hAku1dnt+ZTzzkKipD05SyM+zLSWcBO1E
         dHNN/gryVT4N0RncWGAwpHz/Ci+HJLx3ItkVBVgoSdVgB9FD8MbFRf1dj/fjH5GXCTk0
         OJtzJdHSpfJrgiAv7Px7w+86E3MNuI+oTHmqT9RwhMX/BWu9UfSswNIKP0IAwF5O5wNE
         eZ8HD1H5d35k49t0NcTP5Rzp7YuQDhyAN27bz8l9TjymkXFseANlfZ9Hhzpj6lI30LtB
         QrKyyqQGbS3n7hWSeu+MW331f3Kph1KWnoAD3pRHvS9OFckgHmSDnpdm0HbtsbAaQDB5
         AtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711639; x=1719316439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tb4Y+tgvYIekmwgd2j/b166JURC40YeXenLXo1ek4Io=;
        b=Ji4WUpUTgbgROB3yFIcDBLRnPablZVEtepSEMm4rTiPTCWGW+TuVJExnPIvThwYlMS
         T/I0NcJ96nseQX9UFbBY2Uazy+/8RL1sOPTE89+Yw8eQ8nGYpDW/HvQIvmqt00B4INLI
         YZpS8qVLggl+Y0+CKjfT0xzIigt57cQBf4qIzmRuozjUzUEgRUm04W1ZDScx4A5LW4hE
         3wKndvU7T7qd+NePSos2X3a35c1Hl8k+Smlp+U9CFm2DpZLzBTRAbuHxil6IZiBSXIdX
         6vm6WBUlX7xNorwNZBYMmFdLDz6z2kgMx6ymAURKysNZcui6DkxrGyyARiYrBVGm0GpI
         P7kA==
X-Forwarded-Encrypted: i=1; AJvYcCXCpuKBkJrRpAB0hUKvuS6CVR3b002ipPgbhDHoiJTFuThG5ns+uhjbx+w0ocEqamVK4dQhqL/ynG38oiEdkL3KQsysGg1QGI0zGNPI
X-Gm-Message-State: AOJu0YxKph7Q03JaeMDclKE01zr4fKD0IcEcDMyp7zmG9OIB0s12yGB1
	+jmCwf5Pwn0f7f1MLpXcf8Fd6RM5ZmFNoVOeKwCrF2W49ybVCXrbZ7xUBTEIaRA=
X-Google-Smtp-Source: AGHT+IEm2lPBaiFzDJTF0bUUyOHM9kY5vHY1/j588hgq3qPc6kUxcMPDuRk4JmYqiTnOUP6eqQBGtA==
X-Received: by 2002:a05:6512:3995:b0:52c:a809:62ef with SMTP id 2adb3069b0e04-52ca809636fmr8462175e87.0.1718711638986;
        Tue, 18 Jun 2024 04:53:58 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28880d5sm1488372e87.254.2024.06.18.04.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:53:58 -0700 (PDT)
Message-ID: <5d415130-f744-49c3-be8f-4d2b32618544@linaro.org>
Date: Tue, 18 Jun 2024 13:53:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: dts: qcom: msm8926-motorola-peregrine: Add
 accelerometer, magnetometer, regulator
To: git@apitzsch.eu, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20240617-peregrine-v2-0-c8835d2da7af@apitzsch.eu>
 <20240617-peregrine-v2-1-c8835d2da7af@apitzsch.eu>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617-peregrine-v2-1-c8835d2da7af@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/17/24 23:22, André Apitzsch via B4 Relay wrote:
> From: André Apitzsch <git@apitzsch.eu>
> 
> Add the accelerometer, magnetometer and regulator that are present on
> the Motorola Moto G 4G (2013) device.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

