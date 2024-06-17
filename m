Return-Path: <linux-kernel+bounces-216806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7FC90A6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94A01F24F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB1969D31;
	Mon, 17 Jun 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qInNYKXm"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C817FAD5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608593; cv=none; b=igSC1RVSPVufExeySLlVWkI0ZOzO+EM6G6kf+IUGsj4egJ9meVkJ0bAEQiHPnpTBywaM60a6eANaESI6qlpiJfVs4oEqc4rbfZv1s/GJNytJVzhJKCOi24qDOtUIQHiI8RuZCLQqT7qL2Mu4XqjVy/sbPgXJ09jz39UFwcFLKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608593; c=relaxed/simple;
	bh=bPW+cY98TVGEQ8oYbU5+kTB5r2TuPe/4Gj4MB1VB0zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biiP5Isp0xPXp3L7+0fh/bYEjrn2gumsoehclbssX/QxwwPWITduEVYqYTTFI5XPq0oJlTTk3dsnES3NvyNJkyXoc7USfj+J9smQs/WAGUYiJMVD3KaWLvSpqoTtjCwTdr6M59HZbArkfc/9sQ9K6F63Thiwht8Dl87DRqwi3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qInNYKXm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec0f3b9bb8so24960691fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718608590; x=1719213390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOtB6hLjDe2q1k9n9j8GrerUfufcZavMvVvl5T64NeQ=;
        b=qInNYKXmUySA4K0m8LtV38DyPSDUkYGLMqol4vqFb88MpFuep57Wy6s59OmVGIrTJK
         K6ljKXYq2ZtceNnnHBcN1lgR6BIjpZMuCpRI3W+oFZaLgZOj/DYjeVi+eOdafjp8lm+H
         mJMT2fQYtf9mJu+eReVr2PB4a90f/7cmvkQG4i1VnVv82OJLTpUHtEKG7bkyMfhfe0Dv
         aAacgr4Z40cyPpMrZHtXAFVIHBdURY+hGJCyqd89W4ql4MssiQfh6pJLSzq4rq2Dr0YL
         lOJ03rVV111VVij1AP3I4MKBpTV3IG0cg8EiXimG8nzQ9RypILkNWUyRT/bPmdrUbn8W
         1ldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718608590; x=1719213390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOtB6hLjDe2q1k9n9j8GrerUfufcZavMvVvl5T64NeQ=;
        b=DnQsvAduTYbWApvmKIrlwv54R0ZXMDRK0nRMCUjJuTvwMNWJMkMOZfGvphByfljUUG
         I1BQP6FoF9iF4/e3qAm8c6dZMPKMrJcj+MCe3CVcfgo+vGgapTiR7XDi84zna2x/Adrr
         hgEjgWfof9RXG80rwBFt03P2L2uDKf9USm19j2rwQwdCpYVh41+6ItI4IgAFbL861IP1
         Oyigs8jydw+2KN32ci+3vyMcbbUT77ej5ZDg+P2jt6yBgb1Y01ObuX6H/dTFzrr2f1mJ
         RQAa319HrFaNa2o24KYficeMZ/yjLMaP8ksI0vnBjuNsJ3kpnz0I+JVFH+vVCqInUi27
         GQZg==
X-Forwarded-Encrypted: i=1; AJvYcCUS1i29WTIVOa5JdRiHALpcgCVRdhEk3ajcKdP5C0Ch1t1skDuH4+J0eexTHB/nnVG/n2coiiEvxX0QQodli/W0NsH3oRV/2a6Ku4SO
X-Gm-Message-State: AOJu0YwnIPHcRJn6EeMCJCFf+9Ur1IIHeiHFM3UygiVYCkAuTEeD7zu0
	ixWja3C613/G06jxekW1NNhifNjp/uEW3k/P99nWwxcrts4EorT+LhwvDA2FqnA=
X-Google-Smtp-Source: AGHT+IHlanuvFDHlcHk0QHuwXweE3e5izwPD+BY+hJiW1cVcoATK8SU76Wd3c4dYNArqQvVGdfRmkA==
X-Received: by 2002:a2e:a0d0:0:b0:2ec:30cd:fd7a with SMTP id 38308e7fff4ca-2ec30cdfe89mr4497991fa.49.1718608589940;
        Mon, 17 Jun 2024 00:16:29 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750acf32sm11244173f8f.49.2024.06.17.00.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 00:16:29 -0700 (PDT)
Message-ID: <c882bac6-9cb9-4ba2-9bc4-967c03fcb031@tuxon.dev>
Date: Mon, 17 Jun 2024 10:16:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] dt-bindings: mfd: renesas,rzg3s-vbattb: Document
 VBATTB
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, geert+renesas@glider.be,
 mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 alexandre.belloni@bootlin.com, magnus.damm@gmail.com
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240614071932.1014067-1-claudiu.beznea.uj@bp.renesas.com>
 <20240614071932.1014067-4-claudiu.beznea.uj@bp.renesas.com>
 <936beb9a-2701-476c-8f5a-4b6b06d4f87d@kernel.org>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <936beb9a-2701-476c-8f5a-4b6b06d4f87d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.06.2024 10:38, Krzysztof Kozlowski wrote:
> On 14/06/2024 09:19, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
>> +
>> +maintainers:
>> +  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: renesas,rzg3s-vbattb
>> +      - const: syscon
>> +      - const: simple-mfd
> 
> No, mfd does no look good. That's not a simple device anymore and you
> claim here child does not need vbat bclk, power domains and resets? That
> would be a big surprise, although technically possible.

I wasn't sure how this MFD will be received by the Renesas maintainers so I
kept it simple for this version.

In theory the VBAT clk, power domain and resets are specific to VBAT module
itself but, indeed, the child cannot work w/o these.

> 
> Please clarify: which of parent resources are needed for children?

VBAT clock, power domain are needed. Reset, too. In the current
implementation the reset is deasserted though parent by calling the
syscon_node_to_regmap(np->parent) in the clock driver.

> 
> ...
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/r9a08g045-cpg.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    vbattb: vbattb@1005c000 {
>> +        compatible = "renesas,rzg3s-vbattb", "syscon", "simple-mfd";
>> +        reg = <0x1005c000 0x1000>;
>> +        ranges = <0 0 0x1005c000 0 0x1000>;
>> +        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "tampdi";
>> +        clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>;
>> +        clock-names = "bclk";
>> +        power-domains = <&cpg>;
>> +        resets = <&cpg R9A08G045_VBAT_BRESETN>;
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        status = "disabled";
> 
> Drop

Could you please clarify this? Would you want me to drop the full node
(same for clock-controller node)?

Can you point me an example that you are thinking about?

Thank you,
Claudiu Beznea

> 
>> +
>> +        vbattclk: clock-controller@1c {
>> +            compatible = "renesas,rzg3s-vbattb-clk";
>> +            reg = <0 0x1c 0 0x10>;
>> +            clocks = <&cpg CPG_MOD R9A08G045_VBAT_BCLK>, <&vbattb_xtal>;
>> +            clock-names = "bclk", "vbattb_xtal";
>> +            #clock-cells = <0>;
>> +            power-domains = <&cpg>;
>> +            status = "disabled";
> 
> Drop
> 
>> +        };
>> +    };
>> +
>> +...
> 
> Best regards,
> Krzysztof
> 

