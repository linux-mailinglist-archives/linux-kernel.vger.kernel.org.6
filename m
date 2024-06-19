Return-Path: <linux-kernel+bounces-220517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574A090E2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF42B2172D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAAA57CBE;
	Wed, 19 Jun 2024 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGaCCvhw"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B81E495
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776463; cv=none; b=ZKtUJzvidLggPoaUpUZ8mYYFyqliDbGXFmlpG571+8CwD1JEPzcHClsVfUG4m4CDtrgMkAofmsZBQvZhDfOt0AAQe/OeWj9OOwQk6jsN+LgzCO1FAw+VhWXRBBgEZbiZxaHvHmy+HbVxixWrF5JBNDS5LoYxLdC9SQUi+/WPQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776463; c=relaxed/simple;
	bh=xOYfKC7x1f7MOk8Ias00jg528XPj94C8ZBy3M7DGp3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7jtLR3UqhZlf29R9+HYU8ZS61N2riKbWUWdP6mQwMYLoK9CH66OhyYT3IMCnmDNJEdJTXRJBSFg5DAzeJYqgT6cWSKxLuAnMyTToo8DYHcOuXbsJ7NNcC49vX/9Llklj5nZV/J1BM2iMH2FXBYL6NvRQtRBhwg66mx3LL7Fn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bGaCCvhw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebdfe26242so70000261fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718776459; x=1719381259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zbb3AdzpgpdI2v4admBCiUEhCPrZrmyT2XlknjcdUs=;
        b=bGaCCvhwnxn3KZtbbvG+SFICM3kiFVQoI9g1MXpslvL9OTzbiai6fc5G+VjMCMUTxt
         v2uPvUWd+atyG01SjUTP+uQSLjHE0MLVpfZwsDx8hV6IGluZD7nlJWwS4FQxOsiH35VP
         qMsZIIeJ0kNKMYuECoj3HkRPUmS7fp6Tlm38z25dq8RWlVMCQg4QDpWpw4QyL0juLeZM
         mIvrczyROgDSLqY6xlELqAnQUAb/ivmgVITr/sXmQrXFm+JHJBKx1k4PRGkIvzRpJjxn
         +6gInQxbUemAqfqi69hnJHIFMhQgzZ59DZnytErBx2lmLrfS1P/20Yl13vFRzutY5Sn5
         KX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776459; x=1719381259;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Zbb3AdzpgpdI2v4admBCiUEhCPrZrmyT2XlknjcdUs=;
        b=Sygc6USFSlcrm47c1dldS9r7q+A5uZa7qkKC6Ry9Y5arUjXtNlpw7YLMLlkYCkJyWH
         9KM4Sghwgb7DoxTRYdyiYmIF7LACxJn3VPxRUWpsAq8U/Q3/eZkH1avZDjj5AlBGDh9c
         famLyYIp/a2Uv2/CP6+lHoYesFQ9jbBbjzujfC2ZgbWejzQQNeY7CWevQaWJdj+8oHOi
         NzffmIAfIAOwJ5t3PuFn/fED/ALH5gDm2od6o8ic4b53muidz6b7xkByFojtIUyhPsB+
         Mow31zoVKh8hxTpD8xI/IK2EJHURV+8eO2qMvcSHr+fGKpGGp+kkq9vb3P01cLF3QbVF
         JISg==
X-Forwarded-Encrypted: i=1; AJvYcCUsXwBbUe9Ee2OPvwDiS1DwLptlwek91uO/vro1+a4s+Wx8fqVBr/8NiJiQY+6Zlz0vvJfUfqfSCH5i0em5l+TjFQ4hd7ekKHJU0jo3
X-Gm-Message-State: AOJu0YzwQXZCQaiNCqNFzsFWC3B9TG45chSsSdAhMRWvxVKfgQ3a0VG6
	q37X1rGJhSXKoz0AcS8ul9v25etICbCSQYTZ8XJqXEQ8GG8mR9QgoJd93kl+y94=
X-Google-Smtp-Source: AGHT+IGO1ardrGOl9U5SR0idjsp68kHISPfvoQYmKJNLRVzL27btVMIvaH8JZk53p5P7UFMqXg72uQ==
X-Received: by 2002:a2e:9690:0:b0:2ea:853f:18e4 with SMTP id 38308e7fff4ca-2ec3cec095emr11756211fa.13.1718776458836;
        Tue, 18 Jun 2024 22:54:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422869d4f2esm253264665e9.0.2024.06.18.22.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 22:54:17 -0700 (PDT)
Message-ID: <4cdada61-3861-49e9-b8a4-bd08f8435da8@linaro.org>
Date: Wed, 19 Jun 2024 07:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ti: fix dtbs_check for some syscon bindings and DTS
 node
To: Jan Kiszka <jan.kiszka@siemens.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Andrew F. Davis" <afd@ti.com>
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <ebc4274e-14d3-4b47-b8b3-9a0083118d52@siemens.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ebc4274e-14d3-4b47-b8b3-9a0083118d52@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/2024 06:58, Jan Kiszka wrote:
> On 18.05.24 22:07, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> I am in the process of fixing syscon/simple-mfd bindings (to be posted
>> separately) and found set of issues in TI looking independent of my
>> series.  Please apply via TI SoC.
>>
>> Best regards,
>> Krzysztof
>>
>> ---
>> Krzysztof Kozlowski (5):
>>       dt-bindings: soc: ti: am62-system-controller: add AM62 syscon
>>       dt-bindings: soc: ti: am645-system-controller: add AM654 syscon
>>       arm64: dts: ti: k3-am62: add dedicated wakeup controller compatible
>>       arm64: dts: ti: k3-am65-mcu: add dedicated wakeup controller compatible
>>       arm64: dts: ti: k3-am62a: use a specific MCU controller compatible
>>
>>  .../bindings/soc/ti/ti,am62-system-controller.yaml | 77 ++++++++++++++++++++++
>>  .../soc/ti/ti,am654-system-controller.yaml         | 60 +++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |  2 +-
>>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi        |  2 +-
>>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  2 +-
>>  5 files changed, 140 insertions(+), 3 deletions(-)
>> ---
>> base-commit: e032bb82c315d2317a80506195d16ce4308d8cf7
>> change-id: 20240518-dt-bindings-ti-soc-mfd-ac211578d7a5
>>
>> Best regards,
> 
> Good to see progress here! Helps us finding our own issues while adding 
> things to the affected targets.
> 
> But you didn't address this ones yet:
> 
> .../arch/arm64/boot/dts/ti/k3-am654-base-board.dtb: scm-conf@100000: compatible: ['syscon', 'simple-mfd'] is too short
>         from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
> (plus our IOT2050 boards, all via k3-am65-main.dtsi)
> 
> And a number of other boards seem to lack adoption of the new wakeup 
> controller binding if I get this correctly:
> 
> .../arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
>         from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
> .../arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
>         from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
>   DTC_CHK arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb
> .../arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
>         from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
> .../arch/arm64/boot/dts/ti/k3-j721e-sk.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
>         from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
>   DTC_CHK arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dtb
> .../arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
>         from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
>   DTC_CHK arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb
> .../arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dtb: syscon@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
>         from schema $id: http://devicetree.org/schemas/mfd/syscon.yaml#
> 
> Forgotten?

There are just too many warnings to be fixed.

Best regards,
Krzysztof


