Return-Path: <linux-kernel+bounces-256845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CCB937126
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE161C212A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECB8146D4C;
	Thu, 18 Jul 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IOP7tBAV"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C62146586
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345927; cv=none; b=ETdAJRH36d7vtYlh6A2WquzqX6vpQml0/MMbwHsJetD6owTu2r9Q829ZafjsBmH0AQWAyZ+T7dBNHsZTE9IB2jUYZaxvw+R+rA2WlSlGzVIbkkkoR1kJf/SVmpVRnMZnNSHEsc/MCI+HxOhVRZI7cPQzkfLbIDQZWPychhWB9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345927; c=relaxed/simple;
	bh=mdmnaCDZYFykkp8P60f5Qr3sXWLsG8Use+1CQ/rGOoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+kPcXJMoat/FkMaAIOm+Zsjona0Rc+AYZQ/ycQ3KB64frba/JgG7xIRWbSCxYnfh1bESqncmjUZtQPoJKyB5Y7bzTQx/3vEdtBTBWWVD4WAIG0Tlt2Nd6AQeYqWGBS9FuOGGb8x3izbirHIuEIRO2JaOlpk2i5iOmepfHbskZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IOP7tBAV; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-807687b6652so61670239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721345925; x=1721950725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nvIns0vPchcCSpiwT/Cr//HZT6luVmkYPX5bZikjiSM=;
        b=IOP7tBAVjmmCqM0yaqd6WfKf+8TaOMn7Atn/jNRHw6uRu4xx8y51lqDiw7oUYjbzGN
         tuxFudCtAWiWSzLQz/7rHJN+QslwE5Y2jGcSdZo8RuaqiX3OZKUabiapY3ZS+IcuoPav
         dfgopp4MLYKKswU3+icsygWxBkVpmIPgOg/KfvXtrvtmTE+1n5IYhQkQAmg7dBMA3Aop
         Q7UBXeghNZwkjj1wvX6zCKastw147syZuTiM7xIAOXzCNX1+UrRVtpMcJvif/SMuag0A
         H/aQnLhZDBvgwSU8cs9NEC0BI1lVC+vLOnOGc54Nyemd74VWaOnGtk4trkv3A7m+9kK0
         3C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721345925; x=1721950725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvIns0vPchcCSpiwT/Cr//HZT6luVmkYPX5bZikjiSM=;
        b=e/2Nl6kW6Rw+n4mro8gXsCYFUoLmRWHl+Ndse/3PxUBrOOCqk3TtyjtMVP08Z6QmnS
         J1B9CME1qrrqne+Yr1Geq42NT4zGbQQDZA2W6GXRmGu87dfmGS9DdnXd360T21gBdJLj
         ffvFyF7mnEsQnxSO+MAyyUz1m8iJfS4WcaoW4kh7X+iYh/Yn/Q97YMGRKdu435HULPxV
         ZVf+VadOFbvV0fqDWwEqUpAkAl1Tz1NGR/+xeRKdeza2a/eAAcV2p4DjLMonwhMfviGz
         1Pc4Sg0qX/HG/2F0bX/WFje/Elm6a6GJBDWi6RHPSKTSwFHbeWFGEmbGbwaZPYe3trpb
         ilaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNnVKcRLdUlqDxq9FydfLKse6YAGagsL9VJ5hdAJnnsFKdFPRItm7EjeGfFSvtgbCxpQ+nWWnM9if4tmjp9pu59WK34FGzTLkX3FH9
X-Gm-Message-State: AOJu0YzgHcN1q78e+UVci/KtLG3yCCAlk/IcZmU1G0JYIAEC/K4rR0mL
	np4Q3BhTLX37lxCru0/hfphKKJqVBUhwmaJ8VxxWdI8JcFMNWOLfSJ7VfJS8H18=
X-Google-Smtp-Source: AGHT+IEIoaaRXy0Um8nUPOglEs3ZnOloxeKDVGZgw8a7UQi1E33LPlNqKhP4N06l+qm+Tlu0m2n/3Q==
X-Received: by 2002:a05:6602:1347:b0:807:28a5:aa47 with SMTP id ca18e2360f4ac-817125e17eamr804148139f.18.1721345924786;
        Thu, 18 Jul 2024 16:38:44 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2342f15ccsm80150173.67.2024.07.18.16.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 16:38:44 -0700 (PDT)
Message-ID: <727b966a-a8c4-4021-acf6-3c031ccd843a@sifive.com>
Date: Thu, 18 Jul 2024 18:38:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] dt-bindings: riscv: Add Svade and Svadu Entries
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, Conor Dooley <conor@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 kvm@vger.kernel.org
References: <20240712083850.4242-1-yongxuan.wang@sifive.com>
 <20240712083850.4242-3-yongxuan.wang@sifive.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240712083850.4242-3-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-12 3:38 AM, Yong-Xuan Wang wrote:
> Add entries for the Svade and Svadu extensions to the riscv,isa-extensions
> property.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> index 468c646247aa..e91a6f4ede38 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -153,6 +153,34 @@ properties:
>              ratified at commit 3f9ed34 ("Add ability to manually trigger
>              workflow. (#2)") of riscv-time-compare.
>  
> +        - const: svade
> +          description: |
> +            The standard Svade supervisor-level extension for SW-managed PTE A/D
> +            bit updates as ratified in the 20240213 version of the privileged
> +            ISA specification.
> +
> +            Both Svade and Svadu extensions control the hardware behavior when
> +            the PTE A/D bits need to be set. The default behavior for the four
> +            possible combinations of these extensions in the device tree are:
> +            1) Neither Svade nor Svadu present in DT => It is technically
> +               unknown whether the platform uses Svade or Svadu. Supervisor
> +               software should be prepared to handle either hardware updating
> +               of the PTE A/D bits or page faults when they need updated.
> +            2) Only Svade present in DT => Supervisor must assume Svade to be
> +               always enabled.
> +            3) Only Svadu present in DT => Supervisor must assume Svadu to be
> +               always enabled.
> +            4) Both Svade and Svadu present in DT => Supervisor must assume
> +               Svadu turned-off at boot time. To use Svadu, supervisor must
> +               explicitly enable it using the SBI FWFT extension.
> +
> +        - const: svadu
> +          description: |
> +            The standard Svadu supervisor-level extension for hardware updating
> +            of PTE A/D bits as ratified at commit c1abccf ("Merge pull request
> +            #25 from ved-rivos/ratified") of riscv-svadu. Please refer to Svade

Should we be referencing the archived riscv-svadu repository now that Svadu has
been merged to the main privileged ISA manual? Either way:

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

> +            dt-binding description for more details.
> +
>          - const: svinval
>            description:
>              The standard Svinval supervisor-level extension for fine-grained


