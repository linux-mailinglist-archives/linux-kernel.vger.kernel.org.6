Return-Path: <linux-kernel+bounces-308504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166E965DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BFF1F27952
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952E617C20F;
	Fri, 30 Aug 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="V5s9JdGv"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BF17B4E9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012209; cv=none; b=otrKCwEwW/h0riJBu1eKXUYRlK2LVOFa6w0+Kv/2vuV6V6oo5rwzypz5Ooi6mVIq8eONEmaBWy8jF5f+cBh4qe/Wtvk1mtBQJZnvR1zJNuySgyfrE0HyN99sTsgxAL8MLrsH7JN4xMhy4OkhPemgLJs7GoiCPL+nF21XWUu31J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012209; c=relaxed/simple;
	bh=Qzz2aWEELYP8mMctfESYoFBlj6mzA2qfCfyV6WlS30g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Glk2p2Id31q0zf4pHFLeX5es5m4fPC9JtlJUQaPFLECXfqHK/DfNAeqXYjM8wDECFFLe0O8Y3A+3FBaYtfNWvU1iEfwvu68lTHJPHKAaXpXGec087GrkNCE1rX5wgAwM5c2PUyv/ck9v8/XiNFFLQifMfENvkZumOEYnNemiKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=V5s9JdGv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so160245066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1725012206; x=1725617006; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cIeMDcm3LN97MVIbOIXKOQTp1QGgYG2TQG0/ddH0/U=;
        b=V5s9JdGvjpMmzsjMgKNa5LQuI1pfSY4Rir5lYRnlWhYtHkVtHdWx7DSb6ARrmgZCQb
         cdq5tQdJvlGTAc2vO0ttqHMRXJhiUq3cPPp/49alCMBQpLyO5HAXoPEg/YuDJ7RPDe69
         PpYNhHsidavUsb6cDU7aNPqq8zKaGGGJQAiUNKpo+clM3dzHkh7yXfn8nTVJDoQK9FHk
         Pc9Hy+YFUuhEudlLmOOmPmcaMToEgZWLfDJcpKc1CnlraEf1YoRUwuDfTfJfyHbm07lS
         v62Ygjr/4zDbUUHdcbC/AYN05b0d96FJwFhElQqUVRKp6s8KwRCUTnXa3XPsHwP70lkL
         Y4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012206; x=1725617006;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cIeMDcm3LN97MVIbOIXKOQTp1QGgYG2TQG0/ddH0/U=;
        b=vSkdrkulk1WwsFUVvmC3ohGArCHk5IJE1dpnOduNEEBE6ahltlssmMTuGVT7xQwe8j
         e7ldzpnLoTbqUYo3WNpYWmThNKOhl7z8fKNNWQRM7KI7EaLfo8qb3TDsxzpkuChmaPoL
         IcTUIpDG03SERk6F0eJdIrJqdaxmn8Pu6z1QJXtv3yahLMkdWv7xPGYwD0gcSyckWPjL
         GrDRt0k9pwqSqAFjDC6+i/x8pZyQjrywJX/5/N5S30OhVpvo3sUlOW5hcgKIQUfQXdAp
         GI8lEhet9fQ1wMlvOfKg9ENfPxRpKPLBZro1VZTx6aEr6tpFTF9/F9/w+9RHPDX41BGs
         BKbg==
X-Forwarded-Encrypted: i=1; AJvYcCX+1t1BI7hlt7iLO99KyPoz+eEqTsQTvGRBqqVZxjro+S0UiBu3VsvrHY/P8Mx6i66Oz9fviyZ1WljyzQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXlsbZcakqAncuSKi2SGR4Tb+9K3zhw6y0PZdrMDjFTaT5CRw
	M4k2BSubsuYELLhsXZkJhKO6Uab9ce+adVx6wwz3d0bjcAPEiNQuT9cA/ffJX/M=
X-Google-Smtp-Source: AGHT+IHtyYxAeiiHI3ftANQtuGsazwoduUWpfMVaJOsb+Oa0tdg31ut88AFK+yFMeMN/gW5P+qDwyA==
X-Received: by 2002:a17:907:9717:b0:a7a:a06b:eecd with SMTP id a640c23a62f3a-a897f775d8amr420312666b.5.1725012205800;
        Fri, 30 Aug 2024 03:03:25 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff289fsm197362666b.2.2024.08.30.03.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 03:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Aug 2024 12:03:24 +0200
Message-Id: <D3T5SIUJ281Q.2APOQMPFJ9VYI@fairphone.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280.dtsi: Fix PMU nodes for Cortex
 A55 and A78
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Danila Tikhonov" <danila@jiaxyga.com>, <andersson@kernel.org>,
 <konradybcio@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>
Cc: <cros-qcom-dts-watchers@chromium.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux@mainlining.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240818192905.120477-1-danila@jiaxyga.com>
In-Reply-To: <20240818192905.120477-1-danila@jiaxyga.com>

On Sun Aug 18, 2024 at 9:29 PM CEST, Danila Tikhonov wrote:
> The SC7280, SM7325, and QCM6490 platforms feature an 8-core setup
> consisting of:
> - 1x Kryo 670 Prime (Cortex-A78) / Kryo 670 Gold Plus (Cortex-A78)
> - 3x Kryo 670 Gold (Cortex-A78)
> - 4x Kryo 670 Silver (Cortex-A55)
> (The CPU cores in the SC7280 are simply called Kryo, but are
> nevertheless based on the same Cortex A78 and A55).
>
> Use the correct compatibility.

Hi Danila!

Please remove the ".dtsi" part from the commit message, the subject
prefix should be just "arm64: dts: qcom: sc7280: "

Regards
Luca

>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/q=
com/sc7280.dtsi
> index 91cc5e74d8f5..ab024a3c3653 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -845,8 +845,13 @@ wlan_smp2p_in: wlan-wpss-to-ap {
>  		};
>  	};
> =20
> -	pmu {
> -		compatible =3D "arm,armv8-pmuv3";
> +	pmu-a55 {
> +		compatible =3D "arm,cortex-a55-pmu";
> +		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmu-a78 {
> +		compatible =3D "arm,cortex-a78-pmu";
>  		interrupts =3D <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>  	};
> =20


