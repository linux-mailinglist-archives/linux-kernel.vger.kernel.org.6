Return-Path: <linux-kernel+bounces-521663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5065A3C075
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F07A359A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851241C4A16;
	Wed, 19 Feb 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nEzbjkMW"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A5C1E0B61
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972949; cv=none; b=W4NUvueoH0u9BzC32FmZDUEYskOSoFR9aZUgL8yxsvIoeW17dz6KrIS4HecfJ/W4UqbpyUUEfU3fwOU1+jl3PPayNiOrP6/3DEiKcF2vmuHXmeW0KNq8pshddHALF+vCjSxFW2Gk64oNSprpFF2hc3XeXfkRF0XtbIPcOwtJ0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972949; c=relaxed/simple;
	bh=BUI9OqmTcDikEdPpFqYBtUMWk3tIemL4LfC4CrBlhCs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKH0T3p/XNLodXL/1z/5cqJ8+rb+vhvhf1KNQaLLKIGWhkaQFi26YRwft99h9LxRXlJ1qW3//e42Hfe38emVQDTs9Ia3JW97Cbyax8MDHZ7e/TkMvSQITnFZ2TJfITp/TlQJg0+lUPN46TQn2WKyPhjOqBrb4v2gBmTD94cxq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nEzbjkMW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 30C9B403E4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739972946;
	bh=vZ2L/MpVD9pi+KEJm9yQ5LlxRKJxVGZ45ty3yuLt/90=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nEzbjkMWCJnyEWQBKILuTnDW97lTVU/aBTXW2aqzx3rC5S734Yb6BkrGSCEQuuZ+X
	 zcvHcndsb92buXpnQB7mKmbKhO7MMKe4YKoj6vSpuDuVCenqqJjW5/Hszp0KpG3My6
	 yG0encPaaPDwQXpT4rtKh2/pvuV3+KyWhjSoULAkdXr3FdEoPIzZchwmPz7GfcJBvD
	 YUMf27tiqfqpYwvL5j+e8Vb14ZwoUst7apMN01wa4vgW3HnIrhUHK1g5iMOtQoTq3v
	 2iCjpoTSHi0ATFRyvLkpEJJoTBH1DsDUUhioxb6dfbRfpLvJtKVQgGPXYDfaT0FjqF
	 UbylJ7ch0ayQw==
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3f402d2e007so2393666b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972945; x=1740577745;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ2L/MpVD9pi+KEJm9yQ5LlxRKJxVGZ45ty3yuLt/90=;
        b=PODuwzuK4+8sK7Djv4OM7ii+PrbeNsr3M2fGcPYxrUKa9qiVpa9shXyOEDQak1mMPe
         ovHUBUPYlyHvCXo0SpMZJXzcuM7vnSAysIArKqyxj+6j1ISPtiVvgiKgrZT/TiPMyaSm
         nzJZ9rg693G+vxEeqrZPnbXciyvny/Ab1eJOUu9k8gMfqUTVUsW5Zlbs6UQCgFRA9gbT
         6txLSOPqhWoGZcl7h2gwohvClurAaZDWoW37K4ZZAm3brc8FjpVZFE9c4YU0Pqhzvw/Y
         scHGMXVtDpq6vRAsBXFt/KEu1C0ngxFQmI2RMSoy+ub7EtjUpwOtZnnoHpSdAmt09PTB
         xRFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0KCtOzd+zdBEKoReFXux7a7z9E9gV/lqCGD3V7pj0ZvIqIpgrPfTQsJhHYvjD4qfyIDWl7T3mlPn8yoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1H71dZAMhPEQDYcBKtiknGJBlxy9jlRTBi4MHPLcDxDkrhwT
	9lmCDXj9UEos1fAkwT9qwN09Q080nMBXQi2lwntqiogVsdL4RjaXJ65kS2ejnViGyLsAdg4WwuF
	RFW5bk/cNz95M3kWEti0IeCdcm9yV3dFvRIywAiUoyhwRoeW6Vgtv/J9emBw0UUs62Ugptl7QxT
	dk4mrFsuWhVPxIYZp17S9Gc5lH33WpCeBmBQ2KNEmUQTD8fMvUWy6p
X-Gm-Gg: ASbGncvnoj+vuuvjOdXw+nCSLWtyksEriWYoqL8+xHV1OhYJANPJH09EcR1SrqVX1k6
	QpM7Wclyxd3/IsWzf8Kd8oyMLhMa6VTjzHhJ7y00kld3+LUrC544BM/quAUVUjKzL2lqpyFJVqc
	S953lvMtSXSedJVWM=
X-Received: by 2002:a54:470b:0:b0:3f3:fd67:2608 with SMTP id 5614622812f47-3f3fd672befmr5957015b6e.29.1739972945145;
        Wed, 19 Feb 2025 05:49:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGemB5vEg69QJBbksFxTXFeiKLyjYXC6wA0L7MlZFlY9odqxeB6ktR9vGlUGBZLGLU/XQ5O+HGNQ5YSDDhmNxY=
X-Received: by 2002:a54:470b:0:b0:3f3:fd67:2608 with SMTP id
 5614622812f47-3f3fd672befmr5956995b6e.29.1739972944890; Wed, 19 Feb 2025
 05:49:04 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:49:04 -0800
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 05:49:04 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250102183746.411526-2-e@freeshell.de>
References: <20250102183746.411526-1-e@freeshell.de> <20250102183746.411526-2-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 19 Feb 2025 05:49:04 -0800
X-Gm-Features: AWEUYZkTX4lQFT8guSxek473k_5pfX61Dv6EsoPJnhEMc3gblikrRm7DyM9abC4
Message-ID: <CAJM55Z-g4nQXcHe94KUj78W5N1PfSbRo03uPs31_8gH41z4aww@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] riscv: dts: starfive: jh7110: pciephy0 USB 3.0
 configuration registers
To: E Shattow <e@freeshell.de>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

E Shattow wrote:
> StarFive JH7110 contains a Cadence USB2.0+USB3.0 controller IP block that
> may exclusively use pciephy0 for USB3.0 connectivity. Add the register
> offsets for the driver to enable/disable USB3.0 on pciephy0.
>
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Thanks!

> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 0d8339357bad..75ff07303e8b 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -611,6 +611,8 @@ usbphy0: phy@10200000 {
>  		pciephy0: phy@10210000 {
>  			compatible = "starfive,jh7110-pcie-phy";
>  			reg = <0x0 0x10210000 0x0 0x10000>;
> +			starfive,sys-syscon = <&sys_syscon 0x18>;
> +			starfive,stg-syscon = <&stg_syscon 0x148 0x1f4>;
>  			#phy-cells = <0>;
>  		};
>
> --
> 2.45.2
>

