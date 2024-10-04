Return-Path: <linux-kernel+bounces-350443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D581699053C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F79B2216E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6E2139C7;
	Fri,  4 Oct 2024 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBv+U54w"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420E1BC59
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050599; cv=none; b=CEdu9TCPI6jMVH7e16+zuV+Je0j491e9pbwNbCTIBaKtWtWm+FVcqe7DjNgvAb2epRFO0CTR4BeiwIXR7RQ10Yr9F/coma6QNSWaLAwUr7RUMnEE7rcCPRPR55d0wMdO4U6vEIcPvF0efhA6taua3/K/xxnOodjZ9oKavVgdGBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050599; c=relaxed/simple;
	bh=1B+aLBB/7mIN4X6mAJ8p98Fe3N9VGt+iHqXpKDTOH20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdovZZv16hfNfagf+FM7lUWvcXgDKE7Zjq5R7IQ8c+KcvbUozAng7brmoxz7FwGkkKvpnmswNJEJfKEEKm/+PHvAP4HnCkN4ET6EjUPQPq19elTtZJWJnWaHMU9tsK5nIZVsxgegB7IHr885MFjeohCC3oTENE5KpbyKaOIf6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NBv+U54w; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb3c6c353so3439875e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728050596; x=1728655396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pnxsjnImSXP50urNMtsVeihD7bSIh2UkDDi2APLl0HE=;
        b=NBv+U54wr0pN7vxbSaBCCZJVvz0o0MJpYjzz36DZXK7FiSjElLHuvtbzIJQxIRh8PI
         8KGzrBhgA4xrLp7H5hGfSB2srzRnKx+/7Qz4TinSIGszrjagGiXmRzB6pr8/mnzOuEDC
         1GUe/1AGlNhFWXULep/GnxyErmuN/MhMRHMqsDy4DiFujJ1gjqg89r6fjOzRtQhNClm2
         /Vofell4eEIZe2RHliTz+6XPSrdPDLIp++4Jh9/FieytonUEqWigEeA3mV4LAvWlHF1a
         /7E6JUexyuCZpxfrdV2kB/V/WqG7E6VZMIR9pO0E3I90OKT83DMlUdyfkU9YyP5eQD9h
         NI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050596; x=1728655396;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnxsjnImSXP50urNMtsVeihD7bSIh2UkDDi2APLl0HE=;
        b=e/zEpzJsQKw6xTgIJ8SPQ5h/Vj2qkJ6ecw9kmhCMAzqhGHunT/RrIIkDnQQ7dW10TG
         dTdzpVpqzRGZUe8nRtI01y3HVsBlTER6oE5hlqYvG1xmC7iJIRg78gRJ+Ai0UYJnynQD
         1dSx16zpkXIIGLSAvZUk3f0j+MsdeBY9oksSP2dbZmXbgkhBzGTDWl7ndCIHZ8xh95gx
         6XYRpuQ0etjdKjvhBQz0iK7ohkGd9Er2FbB9jd5LnoahygOXLEWh1eXjtian1OM7MNrr
         rCwqOY4U3fGHSrWoFD/UwFcsPvdIc1rvABhhub8wo0NRpXHV8V0nLNtQynkIZ5dhB+t+
         DLpw==
X-Forwarded-Encrypted: i=1; AJvYcCXjUtxF9ySo8S2yLlOGHsb04bI5OnmZopX0n8SzKPytJjYGRO1upOFrVQUjCZkwKKbnKPp+EjrdzL3K6pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7P3/zXhB4imQzL2efVdREV2dkFphdrdHRhVRMqrPRvwkgOYi
	cMEanuT9rk+2i/do9jgh8qAjcVQosHfOuqA0BMgRvtOPnDWcHW+z/LNRWZuh2nI=
X-Google-Smtp-Source: AGHT+IHaWKSjUm6lwgpn+mit8juYgmJRe+AhJCh8ZFSxezo3Xv8tjeftf/+tnnVfwmGd9VMGRqgKzg==
X-Received: by 2002:a05:600c:1d1f:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-42f85aee60bmr9823775e9.5.1728050595997;
        Fri, 04 Oct 2024 07:03:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4affesm16502885e9.47.2024.10.04.07.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 07:03:14 -0700 (PDT)
Message-ID: <664a3cc0-8274-43f8-88e7-fff7b650205d@linaro.org>
Date: Fri, 4 Oct 2024 16:03:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Advice on adding support for Qualcomm IPQ9574 SoC Ethernet
To: "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>, Jacob Keller
 <jacob.e.keller@intel.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vsmuthu@qti.qualcomm.com,
 arastogi@qti.qualcomm.com, linchen@qti.qualcomm.com, john@phrozen.org,
 Luo Jie <quic_luoj@quicinc.com>, Pavithra R <quic_pavir@quicinc.com>,
 "Suruchi Agarwal (QUIC)" <quic_suruchia@quicinc.com>,
 "Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
References: <f0f0c065-bf7c-4106-b5e2-bfafc6b52101@quicinc.com>
 <d2929bd2-bc9e-4733-a89f-2a187e8bf917@quicinc.com>
 <817a0d2d-e3a6-422c-86d2-4e4216468fe6@lunn.ch>
 <c7d8109d-8f88-4f4c-abb7-6ebfa1f1daa3@quicinc.com>
 <febe6776-53dc-454d-83b0-601540e45f78@lunn.ch>
 <6c0118b9-f883-4fb5-9e69-a9095869d37f@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6c0118b9-f883-4fb5-9e69-a9095869d37f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 15:06, Kiran Kumar C.S.K wrote:
>>> The MII Rx/Tx clocks are supplied from the NSS clock controller to the
>>> PCS's MII channels. To represent this in the DTS, the PCS node in the
>>> DTS is configured with the MII Rx/Tx clock that it consumes, using
>>> macros for clocks which are exported from the NSS CC driver in a header
>>> file. So, there will be a compile-time dependency for the dtbindings/DTS
>>> on the NSS CC patch series. We will clearly call out this dependency in
>>> the cover letter of the PCS driver. Hope that this approach is ok.
>>
>> Since there is a compile time dependency, you might want to ask for
>> the clock patches to be put into a stable branch which can be merged
>> into netdev.
>>
> 
> Sure. We will request for such a stable branch merge once the NSS CC
> patches are accepted by the reviewers. Could the 'net' tree be one such
> stable branch option to merge the NSS CC driver?

NAK.

This is not needed and cannot happen.

Best regards,
Krzysztof


