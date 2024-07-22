Return-Path: <linux-kernel+bounces-258830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AF1938D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025E71C23D39
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4E216F836;
	Mon, 22 Jul 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bh92uaSd"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016C16F831
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642640; cv=none; b=T5jeBJ8hXFtvsh+UmvsXRbFbLCn1+xMjm8UoRCNVRRp5ORPWBjcWnbyw71OU0I0+Xe/QorfdI7psOoIgc/j9BDG4SzKUtUDKJ/vlZoYoYeC/NMDOUNLy4IFD6vTEPfO9k8DovSR0UWbt5uob8lGXPzS4xQcZtq06Ek56GlgQIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642640; c=relaxed/simple;
	bh=+yqwB+J4lF1iTPgk4wAMNeWaAHDloGbcs7yxPgw2kag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UbJf8PomjKSXHbNMzpHO1PR3bhPOewgfLwa1azpX6bM6W8RQydCEFDcQCzsO4p/HTrFRnXcM/Io4tZ8nRtOlOFRTVmoCxeZyq4AotFe0iZiYHIGiX4Lc/Hftowd1b+dDN2L9V/jNeeaZ3y2ozmx4hQTskhjp3Of8OETwNWkZ87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bh92uaSd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ef95ec938so1834992e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721642637; x=1722247437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YcWQjPxERZiMRCxvpCOlXCb2irsnAwF97zzYAGwzhA4=;
        b=bh92uaSdyOnQUB/asxHeFw8XSlnr+B5FIe/jbHXmTEIyF1GtoYOC2TfhmJDi3s4INd
         J2dJDUw7echdI0HrQAq1+x2vJkYirz6K8KEBI4cME7g97dC8PSYlT1OBM0NZHKoW3oH1
         px1JLRkWTZcEMwWGCEiDqoDnl2pc9tjIRjbNHCSePn2xla6BIEqGmIctL1Vu6y5m3KE5
         o/fJl53iJmPFpUMq/uRLqzcYaIkvIcFC7D0//nLyNkyYXKrw2SyIy7c6rfLycp1o81bl
         zthciPwii2SQ+TydjEIE1HV2oc6SfvnOEmtmBa32Sxd7rG9ZXM+iKssGLnJ+Oc8AefNE
         bw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642637; x=1722247437;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcWQjPxERZiMRCxvpCOlXCb2irsnAwF97zzYAGwzhA4=;
        b=sxyROJNvzENAM6TDhu22anN9/g/Xp+9aiW8KKR+HddEcQbaXAnIvBdXEdLVFcHOx9J
         zHPx+TNqexkzt18rosRffeU0B0xrHWkuIOgx6VG0oFX8ybnqhT3iSJFskF1S2PZjjnUj
         GEYjZR7p12hQOhQu+aq8UCFNya8HIujBvjyGt1C+rEzsQgCXCrpe5qr0fiXEe7FoA1yk
         nwsQFO4d2XLYIb50PmuStJS5l94Eez05kX731+VgEARqwCkbXNtbKoC8ls4xSI73H0wn
         wagz/EEjt+L8tfgN/r1ShaiH+78bxJsApD/VBMaMwLtwz2TSMiMsKxlWrdTvf39GGosP
         CJ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKvDAJttlyC+1a5JKv9EH2wkuvsOFCrgfHPM6xFsIeBRTbQsYXpBAwOHiigIqzcPFAn80ThstzXeEYGmD8ukCuYDl723E5bRUEHpwE
X-Gm-Message-State: AOJu0Yzi9GESZdo96/0dDa1RXqcvqg/WeYSen0QZQ3b6uGSqgXV9MASA
	wLqTsqdvAUBj1vcjLb8TJzSXpTx3dg0qUcvQJC5XL9PyFnfc3jDamLW4XCjSCxNZRoJ7XhopDpo
	O
X-Google-Smtp-Source: AGHT+IETGYu0JoZ4FwcDdkmlxRBqu4xokOBwGf2k5AOcqjHSR7nKbcnACZ9r8l29raHsoSWhsFmWpQ==
X-Received: by 2002:a05:6512:401b:b0:52c:ebd0:609 with SMTP id 2adb3069b0e04-52efb64cc14mr4335102e87.7.1721642637257;
        Mon, 22 Jul 2024 03:03:57 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785f26sm405042366b.6.2024.07.22.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 03:03:56 -0700 (PDT)
Message-ID: <a9c862de-dfa8-4f3d-b21f-944c61cd0da4@linaro.org>
Date: Mon, 22 Jul 2024 12:03:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] arm64: dts: qcom: x1e80100-yoga-slim7x: fix up
 PCIe6a pinctrl node
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 Xilin Wu <wuxilin123@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722095459.27437-1-johan+linaro@kernel.org>
 <20240722095459.27437-11-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722095459.27437-11-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 11:54 AM, Johan Hovold wrote:
> The PCIe6a pinctrl node appears to have been copied from the sc8280xp
> CRD dts (via the x1e80100 CRD dts), which has the NVMe on pcie2a and
> uses some funny indentation.
> 
> Fix up the node name to match the x1e80100 use and label and use only
> tabs for indentation.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

