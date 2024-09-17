Return-Path: <linux-kernel+bounces-331997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D897B3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31254B22347
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F2B1779AB;
	Tue, 17 Sep 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsTMn1UR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850A4D108
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726595791; cv=none; b=CWquXgGOONFMkjQ2VxRzaCsoAFVLeR8l8X/XRtk8QYIC/bk+GNCA0nqd8rg7uWA9NCGWmiqQuAncECyswGlm5Skc3oo10IRqCbw9BMXUc0AwrnIg7PcMKg2lcf39RwRsqfl3EHoWdRCu1tkkVQBPFhV3VW3Q0VFRZVQEJ9eSsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726595791; c=relaxed/simple;
	bh=jNOYaOj4cZ7Bpj+k1zqagr701zaY26OWbDuiBz+4H2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKpfP/LwWef4AjFjKr9gzZp6FZRk8+Efrl9GpKXJcqHpyRmock9SPZG1Imydqz0paYSqIijyH9L3odQWbivkQv/8eT/GRXn+wJTrJBbvfwd+ydlSlfSQh84/fs/CnpXFarRdUw6HsxDdH7cKwWEqYyl5luHudtxczNz/1OBvwKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsTMn1UR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53653682246so7024557e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726595788; x=1727200588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+KgzJbKXX2uFfdVaHE0+abgKaVfXlOq3EDefktc24M=;
        b=bsTMn1URtR9RGuUTPcTcAZSlT5RCTw+HIfe7FLA8v2rfb/YL//nK6oPUVnVk5EUzcy
         MmKzif0hCBxJjnpkqbD9vnWfXeif0WybD5Ku0y4SPE9nMoOmNpoYqRUygIW8euh6PrhW
         YgX9MWb01bh+H2j5YdcspAjHG43XWgVJ6DFbrJTg4x3bQrf6BySGII+Hdqz0aFMHzP1F
         J2oMYsnCFfmdfzLeDsIBFcIUAa5mIGIlXNA9rCPBaR288/vONtl/kwdix+aYRry1HAeF
         b41LET3zw4oiINIdQBNTD4JlhJc20aF4fYamVIQmNk19aT22ypTcAfeUv1TEI0IMep3A
         3GCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726595788; x=1727200588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+KgzJbKXX2uFfdVaHE0+abgKaVfXlOq3EDefktc24M=;
        b=sSCBbFBtZQNHRd3zm88pK+WYP0CiBQRk4rlz8MxEV4phtNDs/P/QBMcncwWcK0aHqR
         LMsFt9Nhhh7m5CrGPzxagm9lxmuYByJEzx1sorFFZ7WkVCpDbKfmQ8NtspHBp2/8oJzg
         iVK7NbpJCI4qaI+Fm9Em1v1vp98OHkl9RgIiG2amA0MaMFrTE6yLu2ZHWyrY7pKtnRkh
         fvLcH/WOXwYsbHnfVF1aMRfe32E2NoOBJu2RDs7BwpZT+ayLHcu2cL0+sgEJ6nacUfqy
         LlyAa8Zd7gmZRDmXGKHMw59l0Y9IuGBv+hl3RSfoVl7rCTyMifdsdvQsPIbz0CIV+TbE
         m4cg==
X-Forwarded-Encrypted: i=1; AJvYcCWgQW8BNd/HwKElDGqPuVv8OkhMvWINgmhD/PkK8IRajWCCkZyNtJ9zhpO8FsFaZlfeb8ztcLCxRj5l8gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQC3rMFBXaAas4QporJpIStKAgK4t8w/RM+AQKKTpc1t3QwGt
	zbJzI+5of1JJg+K6gmZzP4V2mwLLsrGEr0LtL8jhtx2WmxnqIIaZ
X-Google-Smtp-Source: AGHT+IGKoOrv9ibAXTusAtqFkTwRnyIi4B3hpxcTBt6/NiSrEeCOLDrGayN8MUF72ybhjTsTH/omDA==
X-Received: by 2002:a05:6512:a91:b0:52e:74d5:89ae with SMTP id 2adb3069b0e04-53678feb07bmr11133534e87.39.1726595787251;
        Tue, 17 Sep 2024 10:56:27 -0700 (PDT)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a86c7sm1279253e87.223.2024.09.17.10.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 10:56:26 -0700 (PDT)
Date: Tue, 17 Sep 2024 20:56:26 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
Message-ID: <ZunCysUTSfQU1ylg@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
 <6e5d0e9978bff30559c17f30d1495b59@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e5d0e9978bff30559c17f30d1495b59@manjaro.org>

Hi, Dragan,

On 24-09-16 23:08, Dragan Simic wrote:
> Hello Andrey,
> 
> On 2024-09-16 22:45, Andrey Skvortsov wrote:
> > From: Ondřej Jirman <megi@xff.cz>
> > 
> > accelerometer is mounted the way x and z-axis are invereted, x and y
> > axis have to be spawed to match device orientation.
> > The mount matrix is based on PCB drawing and was tested on the device.
> 
> This commit summary should be copyedited for grammar and style.  If
> you want, I can provide a copyedited version?

It would be helpful to avoid further grammar/style problems in the
commit message. Thanks in advance.

> 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index bc6af17e9267a..1da7506c38cd0 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -229,6 +229,9 @@ accelerometer@68 {
> >  		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
> >  		vdd-supply = <&reg_dldo1>;
> >  		vddio-supply = <&reg_dldo1>;
> > +		mount-matrix = "0", "1", "0",
> > +				"-1", "0", "0",
> > +				"0", "0", "-1";
> >  	};
> >  };

-- 
Best regards,
Andrey Skvortsov

