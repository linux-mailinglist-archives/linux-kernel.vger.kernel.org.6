Return-Path: <linux-kernel+bounces-192368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44E58D1C32
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34EF91F233FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F8016E861;
	Tue, 28 May 2024 13:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmQsayfL"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E116DEA0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901803; cv=none; b=LRIUmPuzAu89/XVUDBDm/QV/WRc+xIY6cadITdiIDXTl5M+9XTXkTIR1uZeP/xLeYvp+b1YGL28ie1YtC6oqQPo0cKRrH8I+G3JzwUtRoTAzNJh/PNKgcgJLZawn4a7hmV1badI6+ZPNasM1eqalpiRDzwsmzc4/lvuAguDgzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901803; c=relaxed/simple;
	bh=oJRSdItw2anLfw/4zZaFRaP3Dn6ne/abmv6YdE3q5AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut334bxU9/TNA9Gy/fvLq/ffvlYF7hCBE2t0TqKPR0IPLneAuKnS2rURx/xlU4TxJGw0P1Vl3npDJdToz86y45XSucP0wf+nKHFEujpZyaRootzPkT0aGGXIHLvdGxeWLLduiJpoXIk0YWdZfeeIqFI41YhIsHHG/VwfAKCdvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XmQsayfL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-529aa4e988aso1038157e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716901799; x=1717506599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PPwsTBTSG17+Fbzi2z4l/C98UM+jSBGnmgHkuUq/dfg=;
        b=XmQsayfLeDSkPS/1f9j2ZNaCnETid3Xyhe1IMqSQyOiKDQpa/7JaxQq0iwfxJvnZQI
         j6oJIntPosG6E2pfczc1oyYhIIOTRdqfhqZu09WtS9yPf7XATBFLc1RvW4kZC5dRn2iA
         /covHL5hkq7+gXezHJ4XBAxhtduW27rkjtD/6vDDcxl6i5emuHl4qavL2beY1sCtiqa9
         Z7lXx0mbFelsDTyRVMMbZ8+krH2GuuymbZSVddvT1PsQqd4HsbCf41HtVOOLO69E1YUE
         iELBkg6E3+/a/d+Kf/dcN0PIWKJsz+SCkIIEf9vzc0u5ViY/WiN9+2UCF1Dc/Usch8WF
         Dl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901799; x=1717506599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPwsTBTSG17+Fbzi2z4l/C98UM+jSBGnmgHkuUq/dfg=;
        b=cliv9jvYBY0gR5G2iXoZS3NhLf/0RrsxWUV3izlbpqu6C8HRCO2wS1VmNovIWzqr5z
         9Mj6Y1zkNQUAuvvLEgxmIqC9YsrTDsjOtdxFTXg7wWMwf2H3f26e0lyndTWxo6Js/i1/
         gIcjLW7XDA4zIh2uPuW7CqUh4DE4SHZTCL45dbmuK81B1vRBPjbAi1o4H/XbNk7jLUDz
         SLifUPEJZeCdhARyvuBeZ9LhHPYUZIFtxaYu9exFm5naxI2jlhmWnfxTig+oanXEBMBs
         fp2WVz8LC6XRZibAB7jbodTcxf3opzGWw11qZgjYgppRsBBEYMhv1Cv7zjJpRS5Yqpgh
         Hb/g==
X-Forwarded-Encrypted: i=1; AJvYcCUylPTnSdBVw5b1/LyoPC6CcoA3ck+SVXUJJdQ1t2gKWXZxX2/CsQoTENI306A8HOW5+WbDNJb5/TX3bfz/lT6mD5nMI5iwyn7vpvCP
X-Gm-Message-State: AOJu0YxAfe7xqItQJ78+TvrmYakF9HPhJmtYbIszZTIT9Idh0ax9LUp2
	5J4xaGIV/QoR+Z5s3tE2DShlrxqzrBOQ3NnYDNFsvZLkNq0fzo/HTmiU6abpIQw=
X-Google-Smtp-Source: AGHT+IG5b3vXE8/MoabYI/9hNRRALdcl2EYh3i90PULGycLtPuvRCTBGfdkvBEQL5r2PPaFh0SwboQ==
X-Received: by 2002:a05:6512:acc:b0:529:593f:3f39 with SMTP id 2adb3069b0e04-52964caab87mr9168415e87.35.1716901799454;
        Tue, 28 May 2024 06:09:59 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970e1e75dsm944316e87.230.2024.05.28.06.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:09:58 -0700 (PDT)
Date: Tue, 28 May 2024 16:09:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: x1e80100-crd: Add pmic-glink node
 with all 3 connectors
Message-ID: <wnja3vrlc7nnusdsi7zrb4yeej4oxslah4yac6xopojfe7hh2m@laexn6b5sxwr>
References: <20240527-x1e80100-dts-pmic-glink-v1-0-7ea5c8eb4d2b@linaro.org>
 <20240527-x1e80100-dts-pmic-glink-v1-2-7ea5c8eb4d2b@linaro.org>
 <68e51df8-5553-4df7-91f8-65bef924a407@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e51df8-5553-4df7-91f8-65bef924a407@linaro.org>

On Tue, May 28, 2024 at 02:28:08PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5/27/24 10:07, Abel Vesa wrote:
> > Add the pmic-glink node and describe all 3 USB Type-C connectors. Do this
> > for USB only, for now. The DP port will come at a later stage since it
> > uses a retimer.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 143 ++++++++++++++++++++++++++++++
> >   1 file changed, 143 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > index c5c2895b37c7..2fcc994cbb89 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> > @@ -49,6 +49,101 @@ chosen {
> >   		stdout-path = "serial0:115200n8";
> >   	};
> > +	pmic-glink {
> > +		compatible = "qcom,x1e80100-pmic-glink",
> > +			     "qcom,sm8550-pmic-glink",
> > +			     "qcom,pmic-glink";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
> > +				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
> > +				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
> > +
> > +		connector@0 {
> 
> Could you describe them somehow? e.g.

Which reminds me that we should add OF bindings for physical_location
driver.

> 
> 
> /* Left rear port */
> connector @0 {
> 
> 
> There is probably some better terminology to describe the one closer and
> farther away from the user, do as you will..
> 
> For the QCP, they're numbered on the chassis
> 
> Konrad

-- 
With best wishes
Dmitry

