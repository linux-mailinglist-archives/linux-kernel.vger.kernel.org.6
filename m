Return-Path: <linux-kernel+bounces-384906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F29B3001
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C631F215D9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF61D8E1D;
	Mon, 28 Oct 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCPDdwAj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547C1990DB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118100; cv=none; b=RDzTwT0Us35szRWnv1bZ33bp1k4PS1AJvG99hEUx+e/qL6YQnXQlowoRMToCZz5qdSUOqC6ZakaVdXBLvaOdpmmYW4ogJ8YxkA0Hdm2fA4YubC1HPYsS+Zzs4rZUNN6rHQ7lRn6aNqfbhNbexfiRMi2FZK94GMW8ub7sIz+rW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118100; c=relaxed/simple;
	bh=0KJmnar0ENzo0Nmbqy2W7n987z5/A5L/VlLbTAuSoe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZtZV8lz0LEWYjOeFAvqLVp4Vjv58xBFuKNc76ISJhFkiz5RZq3N/bhhZDUNJe9CN6kv+D/jIra7q6iAWzUJ2TlruF7c7kmONiMO2EJXWhH2US88EroctqnfOWsZgHmXpdtyaNQfdEzsgOoqBO8iTgwoGVaW+C3QntU+QauyTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCPDdwAj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a0c160b94so4645822e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730118096; x=1730722896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uZwvmXTI3rx+8d4K4ck0wQr/Ryjxkfv6hZd5Po8vYlY=;
        b=aCPDdwAj85iMO/In7cy161VfGo9cF/kaZAQ2oOxyEFFzt45B0U2xoSW+xiYQRoZdCt
         4QcznLyib5hIFsxukOF6Q/PNlo1TTFav6b2HB/QOmBXCsxK435ozTwFC5bkFe1rMufjm
         VmiTcnSW6Pn31UOHYqwxN1Tfil5jEqhxgf7LN9Y3JyOKDfbu54n7I1G/HfT511V/Y7tf
         CdkNU3uJpK73uDNt4o4PpKOE6+XBe5B/WvgY2eizNcIm6AN9nAhfX91DVqwEhhM8nUDi
         3POXal89mb7j1x0WlHB6oJkNk1uQIC24r/hB9+XwxTO5kw3UKDuSoIEtSKU8Bq3b3pMW
         XbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730118096; x=1730722896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZwvmXTI3rx+8d4K4ck0wQr/Ryjxkfv6hZd5Po8vYlY=;
        b=Be4jRSCTSsVpfmEwwehI1LABuClbqpKiZHfgj7rIwR0Yd1+1d9QQzvWvlj75juixZc
         eEOqTbzbZ47b13MBTlZNE6Zb09YwR0Rc0CqVWbAVYbzercefVhCWNvgEAe09R3VvCfNu
         Y9V88Jt5lBfWoxj3QDlelOn22AXO7q+iAsGAfFgFFzrS63nJ+GE8+PvLHINw9cJIWs8L
         YtpWg2Oj/XVR0tFiIu7l9lUk1r2N1ov5FsscLAPTsPbcVFNQcs/nYu3152mXfHjksl7+
         PtGKQqOahyqZsVFLstR1gOG01+qSySSrGjiFAezf+uaVMRr1aiqOUMjLJbHSKSOOLSWp
         c3CA==
X-Forwarded-Encrypted: i=1; AJvYcCXAEPWd+5tDXgU9JiV1faOvtoBGnoxJnWHRKZLUZUrRJFq7nlhAit/YQ98PdusDTLy/VEvs1Wkcr7uDJkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMU+mdslyn+ziIJwN0zMQ58rcY3p2jbsWrMtFqfG2dsm4ivCP
	/eCyX5vsTJTJ7ppuE5DHk5Y+tClrM83zsrwkOj/NZrDnp/sdqXdwLV1IVdz1tgA=
X-Google-Smtp-Source: AGHT+IGacAWVy3GFBz0pKlZcVPtx47HGkLAv1BBaK4EDC/lAvynm/V4JqWFS00dPEhyrQ8mVfYaTZQ==
X-Received: by 2002:a05:6512:1090:b0:536:52ed:a23f with SMTP id 2adb3069b0e04-53b34728355mr2949537e87.0.1730118095954;
        Mon, 28 Oct 2024 05:21:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c9e43sm1056755e87.214.2024.10.28.05.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 05:21:34 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:21:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org, 
	konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	konrad.dybcio@oss.qualcomm.com, quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs615: Add QUPv3 configuration
Message-ID: <hwan6cblfhvwmeos4izmhlzfaydxvs4s66wtjulk22aj3zhy6d@xkaqfgxe2sx2>
References: <20241028112049.30734-1-quic_vdadhani@quicinc.com>
 <50a0a56d-55ce-4b59-a004-b8418309eb92@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a0a56d-55ce-4b59-a004-b8418309eb92@kernel.org>

On Mon, Oct 28, 2024 at 12:33:48PM +0100, Krzysztof Kozlowski wrote:
> On 28/10/2024 12:20, Viken Dadhaniya wrote:
> > Add DT support for QUPv3 Serial Engines.
> > 
> > Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> > Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> > ---
> > 
> > Build Dependencies:
> > 
> > Base:
> > https://lore.kernel.org/linux-devicetree/20240926-add_initial_support_for_qcs615-v3-5-e37617e91c62@quicinc.com/
> > https://lore.kernel.org/linux-devicetree/20240926-add_initial_support_for_qcs615-v3-6-e37617e91c62@quicinc.com/
> > 
> > Clock: https://lore.kernel.org/linux-devicetree/20240920-qcs615-clock-driver-v2-3-2f6de44eb2aa@quicinc.com/
> > ICC: https://lore.kernel.org/linux-devicetree/20240924143958.25-2-quic_rlaggysh@quicinc.com/
> > Apps SMMU: https://lore.kernel.org/all/20241011063112.19087-1-quic_qqzhou@quicinc.com/
> > 
> > v1 -> v2:
> > 
> > - Add opp-shared property.
> > - Use QCOM_ICC_TAG_ALWAYS flag in interconnect property.
> > 
> > v1 Link: https://lore.kernel.org/all/20241011103346.22925-1-quic_vdadhani@quicinc.com/
> > ---
> >  arch/arm64/boot/dts/qcom/qcs615.dtsi | 642 ++++++++++++++++++++++++++-
> >  1 file changed, 638 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > index 865ead601f85..1d1cdf6f9a74 100644
> > --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> > @@ -5,6 +5,7 @@
> >  
> >  #include <dt-bindings/clock/qcom,qcs615-gcc.h>
> >  #include <dt-bindings/clock/qcom,rpmh.h>
> > +#include <dt-bindings/dma/qcom-gpi.h>
> >  #include <dt-bindings/interconnect/qcom,icc.h>
> >  #include <dt-bindings/interconnect/qcom,qcs615-rpmh.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > @@ -17,6 +18,21 @@
> >  	#address-cells = <2>;
> >  	#size-cells = <2>;
> >  
> > +	aliases {
> > +		i2c1 = &i2c1;
> > +		i2c2 = &i2c2;
> > +		i2c3 = &i2c3;
> > +		i2c4 = &i2c4;
> > +		i2c5 = &i2c5;
> > +		i2c6 = &i2c6;
> > +		i2c7 = &i2c7;
> > +		spi2 = &spi2;
> > +		spi4 = &spi4;
> > +		spi6 = &spi6;
> > +		spi7 = &spi7;
> > +		serial0 = &uart0;
> 
> Comments from v1 apply.
> 

[...]

> > @@ -392,6 +428,24 @@
> >  			#size-cells = <1>;
> >  		};
> >  
> > +		gpi_dma0: qcom,gpi-dma@800000  {
> 
> Nope. Don't post downstream code.

I'd say, as this has repeated the second time, please get the patches
reviewed internally, before sending them for the third time.

-- 
With best wishes
Dmitry

