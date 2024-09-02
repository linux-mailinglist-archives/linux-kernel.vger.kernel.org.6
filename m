Return-Path: <linux-kernel+bounces-311649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA1968B94
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F9B1C21D98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A3F1A3043;
	Mon,  2 Sep 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZmlBJXA"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31541CB50C;
	Mon,  2 Sep 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293232; cv=none; b=pxxwDXtwGOCj+p+hcW2mb+o/GECZ0NIIoaUuY1hh8NaoKShLBOggAZC8vd4CD0Y7rHK+TKv1T5QqdmOkVNHEgP2feIEVlGCL1R4MwcpPSTjpG1CSumWF525CJkyFR/ZZpHH5qfakXm8Bo1T+h+3Qg9O+M4XwBSNJlwX5dJV7w+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293232; c=relaxed/simple;
	bh=LjOOCqzk1pYYGVEHkGJBoIjHHrwnZyCWQH88hUzg8i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKSPQ37teNNwcN2j9j0hPXgNrNRF+Di3WWuhil33bajRy35Mbr/s62oFWD2f5WShw0r39mRvMtRPejVE6F8TY6UlItoSa/HTYHim2P2go4SvFSUrRAQNbys5+HXTL2D6npMrQQknV5EZZy7/NZZbk4J0S7iltGn0lFrgG+Ty2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZmlBJXA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c210e23573so4483683a12.0;
        Mon, 02 Sep 2024 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725293229; x=1725898029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IFpKPUQiiQjznlpL3dC9bwEAhSvdW7y0yHKICmDze0w=;
        b=AZmlBJXAaejhaNzd1cgrgSyRfdOgeBwUMHFySQvOj3aQ/Ws3+PBTGoVUV1TDWkpN19
         LtTi4Ox5vKd0mdLdiBF5yrkLJ+3r/tLoU//ngVLv95eJnOtuJ0D0KcrBcQzsmqqoXs+w
         LgDplmAh0V2yfWLOFEiTVeYXP9kHv2ZqNaTxhpDpdwdvi7xYipVP3ZwvSvIkLzqnw/Ml
         ExrjFNmOUc8ZD5ScVtfwT0MqGBkwKoenHkyW98c0JV5csrtSPkbAFv6vzk1Cg7gFka5o
         g2rZlqzCPCXlnlgKdrx1d6uszRQC9RQwncVkwfgphhn2Yb15D+QoEHHcRYIGSf/X6FdM
         qo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293229; x=1725898029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFpKPUQiiQjznlpL3dC9bwEAhSvdW7y0yHKICmDze0w=;
        b=LunaZuunLs3sAHBph6bc9DWlPeoVOHr+GQbhNZYKIb7kyeRf2rGasYa+EJLIzGk4UL
         hZl8hWdafZAEt1fmeRPa93oHUQy4mKM+5pLsVTVSUCOGA9h1D6/OntbN7nlLw7YlRZYg
         7xPEdtQuZJ0V9CEqRcGqcA4qZus+rTTARCDAXfKxmVEEHDWAa3kn6+Lg/KDkZetOe5pO
         7uG5OLCYvRhIgaMKfpxwBDkZ9VdSlUk42Sv2ZEP9061XXML+r4IBmoRalkcjdlY+MTOX
         2/jaVmhNZS1nZuKl0goS/7GBbsS4wLZLuWaF91MwKcF0lL35kfZnbHuSkxo3ULo/Oofn
         2AcA==
X-Forwarded-Encrypted: i=1; AJvYcCWGvCiycUFGom/E1QPJwp/2jM/aOxFtQrxr0MbORESwIZ0/oqoV4BCG/cSd+w6CjPAReIYqEVgqB4AQ@vger.kernel.org, AJvYcCX2l90va0kdjRaIVo1CLueZPyyv34CllyZ/HlbTrbeZV/Dz1tEHOixcdvd4dlUb+IPkjgHrfTyhYSmFN75L@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfj6IqScwrg3LgNHdNpk/ijIkoYwUFb1Ivf7cOj5/94INhzkAI
	FWc2FiyKT2fYYUt8MWlvR7ehekFTp04ADMy/OBUEL/+bqqE4710W
X-Google-Smtp-Source: AGHT+IH2DkWASp1pwUYEawA2T8SRRfukE+ElsHknlGlmwAMwSVtewqJ5nzNaOjFYV67cTlRlQt9nMQ==
X-Received: by 2002:a17:907:3d92:b0:a83:94bd:d913 with SMTP id a640c23a62f3a-a8a1d29ba02mr53582266b.10.1725293228564;
        Mon, 02 Sep 2024 09:07:08 -0700 (PDT)
Received: from [192.168.0.20] ([148.56.230.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89890090a1sm576607466b.49.2024.09.02.09.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:07:07 -0700 (PDT)
Message-ID: <9aec2480-5b49-4fd0-8ad0-9fd87c865630@gmail.com>
Date: Mon, 2 Sep 2024 18:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8186: Fix supported-hw mask for
 GPU OPPs
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 wenst@chromium.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240725072243.173104-1-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20240725072243.173104-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/07/2024 09:22, AngeloGioacchino Del Regno wrote:
> The speedbin eFuse reads a value 'x' from 0 to 7 and, in order to
> make that compatible with opp-supported-hw, it gets post processed
> as BIT(x).
> 
> Change all of the 0x30 supported-hw to 0x20 to avoid getting
> duplicate OPPs for speedbin 4, and also change all of the 0x8 to
> 0xcf because speedbins different from 4 and 5 do support 900MHz,
> 950MHz, 1000MHz with the higher voltage of 850mV, 900mV, 950mV
> respectively.
> 
> Fixes: f38ea593ad0d ("arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency scaling")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch got applied and is queued for v6.12 (v6.11-next/dts64 branch).
Somehow no email was send to inform about this.

Angelo, not sure if it's worth investigating what happened.

Regards,
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 4763ed5dc86c..d63a9defe73e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -731,7 +731,7 @@ opp-850000000 {
>   		opp-900000000-3 {
>   			opp-hz = /bits/ 64 <900000000>;
>   			opp-microvolt = <850000>;
> -			opp-supported-hw = <0x8>;
> +			opp-supported-hw = <0xcf>;
>   		};
>   
>   		opp-900000000-4 {
> @@ -743,13 +743,13 @@ opp-900000000-4 {
>   		opp-900000000-5 {
>   			opp-hz = /bits/ 64 <900000000>;
>   			opp-microvolt = <825000>;
> -			opp-supported-hw = <0x30>;
> +			opp-supported-hw = <0x20>;
>   		};
>   
>   		opp-950000000-3 {
>   			opp-hz = /bits/ 64 <950000000>;
>   			opp-microvolt = <900000>;
> -			opp-supported-hw = <0x8>;
> +			opp-supported-hw = <0xcf>;
>   		};
>   
>   		opp-950000000-4 {
> @@ -761,13 +761,13 @@ opp-950000000-4 {
>   		opp-950000000-5 {
>   			opp-hz = /bits/ 64 <950000000>;
>   			opp-microvolt = <850000>;
> -			opp-supported-hw = <0x30>;
> +			opp-supported-hw = <0x20>;
>   		};
>   
>   		opp-1000000000-3 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <950000>;
> -			opp-supported-hw = <0x8>;
> +			opp-supported-hw = <0xcf>;
>   		};
>   
>   		opp-1000000000-4 {
> @@ -779,7 +779,7 @@ opp-1000000000-4 {
>   		opp-1000000000-5 {
>   			opp-hz = /bits/ 64 <1000000000>;
>   			opp-microvolt = <875000>;
> -			opp-supported-hw = <0x30>;
> +			opp-supported-hw = <0x20>;
>   		};
>   	};
>   

