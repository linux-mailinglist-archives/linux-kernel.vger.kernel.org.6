Return-Path: <linux-kernel+bounces-186625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF338CC690
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C3282B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5862714601A;
	Wed, 22 May 2024 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEy4071S"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9823CB;
	Wed, 22 May 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403739; cv=none; b=gbO1UXI+nr18CSZemGhjhTPa2D+X7lEsrOOuEDj5ecFgC28sTTGoIrsjULBpwirk4haIvaf+HCkHToMdnhgLSYpV4LuvA9Jz3HN1GvzOx/4OEo9XxUKixRbxa582XLZGW4Ahsy9av01UcjfYp8z9q7ZlLG3hMD/uAgMEbAJPYlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403739; c=relaxed/simple;
	bh=oDR35NfNsRBH2fJ/xX+R+OSAGEUDe+MKHboG8nW8crg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo71Rr5WgAmazweCjqAsEfqC6qj5I4pq6wFwN9+B5Tsm4MbPSr+wgldjJ32sWf7Bz4i+JQqiVYTq6zT7d/obq4MJjWkWRTIXApQdK3b4NXr63jzYvmKS5K/0VclCTNtRxwnimkeR4eC93+XiSPbwBtlnq8vUZv2HGCyW0DSQkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEy4071S; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e6792ea67fso84164881fa.1;
        Wed, 22 May 2024 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716403736; x=1717008536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTzDmERoVHEg6js4vRxidK21RXEZ4WiJHQmiaHh1F4s=;
        b=MEy4071SPVz7gVoH1xigDk2BN9ZW2hu4JXnzkFA9Rp+7SYKqkMuJmdKUTtLPwEe8Jz
         bu0YP9cntN8VM04v3viZLIqkf3dXNXhl5WOF2PtxYdUAfuzgDm03mzws+bm4ouOIS/2u
         m2123+axOf5aNEkbnqwTAZTbxUvgZTed90WUHlNsc7pza0L0GN1RFWcqIJFu6mst2fIx
         O+gNc5jLnE9p2BO2F8CbL6t0qMMv4D/kp0xMoKW7vgKHnes361UJ8mi3uBv81PAQuf9+
         dMpglePw+TOLkxNCtVvlV2bH3M4BDJlGQzwXtw0/1TPEHqOS+GQhHU4g+g4qbISfzOFf
         2TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716403736; x=1717008536;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTzDmERoVHEg6js4vRxidK21RXEZ4WiJHQmiaHh1F4s=;
        b=m3cKCTMZZDl8bvqiA/mTKU+TiuR7zq/0cdavU8dzCcCpC4J6SfFyM4eD0txiIdycOo
         O6gHJVY9nmNcX7pHFs62p3myoMke+Q4x7DV3CKB+SKd8/gC1kz7KrrV9EX+WootzccsY
         0b8BsrE179DRv8GNt5FRujrJDLtKvdVloSEg7LpfGXevc6GLkYDM6c7+5o8dW4+OXhav
         9GFu+NZW3uL5QRh5d9VvAGdsaEiXdfJ+8KaH3MnzpIXy3YOtkwzqVrTeJD899A/LAuj/
         Z4fbN9NmHBLk9JfKFO2UNEoAYo1LJdLCn1n71rHvIvU5Qnsm1ZiRo+DfH4eL7DX/x0Np
         w3/g==
X-Forwarded-Encrypted: i=1; AJvYcCVzRhyMMGHYewzBcQoPOY3I3rlQNWdjJ3/AcpkoA/vgCLPLOe1RJVX/8SgO7TgM7q5QFLteSvDPgObnObN0iK52c6wMnQD/OMU1uyk6ZCvB5ZrkxKneWx9RVUXUAIl4CIC5Xa5vEHMHqfIX8al+ISlU7HGXFdJjqER94s8/cUuf0zesfimi
X-Gm-Message-State: AOJu0YzctEWg163dlGRuLodpg7dmY5aGlUjD+lvG+jtIO/kRILJINdEt
	1ijrYnlbo7fRVyI7ACMFsx06fWf5FfCktdQTu31oV420rdoMN1b2
X-Google-Smtp-Source: AGHT+IHVOa4KArOmWO1iKvBvgvxFQ+i+ezI4L0bfGrkS09VtQN+XR7jRD5LAMkItjfmSkvlNNtymIQ==
X-Received: by 2002:a2e:be06:0:b0:2e5:87c1:e845 with SMTP id 38308e7fff4ca-2e949650e42mr19384361fa.48.1716403735959;
        Wed, 22 May 2024 11:48:55 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-124-88.kaisa-laajakaista.fi. [85.29.124.88])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d18344f4sm40455991fa.136.2024.05.22.11.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:48:55 -0700 (PDT)
Message-ID: <bcbe109d-5974-428d-b74e-c29bec9f68b0@gmail.com>
Date: Wed, 22 May 2024 21:49:41 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Mithil <bavishimithil@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lopez Cruz <misael.lopez@ti.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
 <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
 <CAGzNGRm5i8zvnXiPzMg5=+tr9oyBcRA8LFvnmgGzE=MzSNTXug@mail.gmail.com>
 <e384272a-4dfe-4653-8983-6426f8803c84@kernel.org>
 <CAGzNGRnsmRWzimUX5tEC2-Y44aa4i9Lbdp8YJ+oneV4ujs4qBA@mail.gmail.com>
 <CAGzNGRmTR_nK0SoWG8uqDfRzDShs7sR+Mc+44__SBi0CR5LKEg@mail.gmail.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <CAGzNGRmTR_nK0SoWG8uqDfRzDShs7sR+Mc+44__SBi0CR5LKEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 22/05/2024 20:47, Mithil wrote:
> My apologies, misunderstood the error.
> Proposed changes for the next version,
> Add dma, dma-names, reg-names properties, and do the changes in
> example (rename node to mcpdm since it is different from generic pdm).
>   reg-names:
>     items:
>       - const: mpu
>       - const: dma
> 
>   dmas:
>     maxItems: 2
> 
>   dma-names:
>     items:
>       - const: up_link
>       - const: dn_link
> 
> examples:
>     - |
>     #include <dt-bindings/interrupt-controller/arm-gic.h>
>     mcpdm@0 {
>       compatible = "ti,omap4-mcpdm";
>       reg = <0x0 0x7f>, /* MPU private access */
>             <0x49032000 0x7f>; /* L3 Interconnect */
>       reg-names = "mpu", "dma";
>       interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>       interrupt-parent = <&gic>;
>       dmas = <&sdma 65>,
>              <&sdma 66>;
These can be in one line to make it nice and tidy

>       dma-names = "up_link", "dn_link";
>       ti,hwmods = "mcpdm";

The ti,hwmods no longer needed since the sysc conversion

>       clocks = <&twl6040>;
>       clock-names = "pdmclk";
>     };
> 
> Remove ti.hwmods from required since some dts like
> omap4-duovero-parlor, omap4-panda etc do not use it which causes
> dtbs_check to not pass.
> 

-- 
Péter

