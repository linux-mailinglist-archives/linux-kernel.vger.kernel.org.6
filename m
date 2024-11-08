Return-Path: <linux-kernel+bounces-402068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409E99C22F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A6A282777
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EE8199949;
	Fri,  8 Nov 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGPlTwLS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED62191F8E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087057; cv=none; b=SAzF0a42Nasg6vblq63Wi7NUq1SXIEyzh0Qqd6EGisY/DFAdUrit1xBH1wSZeUu7jkAZAJbwFP9uYR4jGyV9J+AKgBaOKQRWL9tPnVdRlACLWV+K7axqbHhsyz1l+wKZNlZZtHaHr+ZqXD0xTa/8E5ePAMiqndAjpSMmbyHrMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087057; c=relaxed/simple;
	bh=CXGOR8dp2cvOBQjL2frknhXNbqPTi2sDD8uCs4QUQdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNf8NSIJZNn1wNchCKFS/9hZGaFaH2bOSRwPCLFXcoihDHbd6zY0e4bS+bg9NUmhwxRzK7txcUUCyA9cEO2J6aYmre9GDo5sSowVyVDYqC9amBPRUG7YbgslE9pHF3SkwV8QglV+92oXzVMHslvv2oa/23+02/kViZCmXp8bchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGPlTwLS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f1292a9bso3139402e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731087053; x=1731691853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HR2TxMgpZ8/rc/m1AMgMu7w77GdSFVU9VMdbXA9s9WI=;
        b=NGPlTwLS8okEIFlVUK2RKYpy5gwQUyaDigvCu07ARTHcWFXtA9+8hUXhseNGDK887x
         Jj+FkE435BOR9MIGKHGCnDN/vsDAS+dvMTf8SYoM5yMqu8G+gHDRJLCsV639Hp/fvfAJ
         sNtL8cBRF/W+x+grR7gT4PTMTVvbSblZ32WM9GUWOsp6bte2tEbk3Rng9PAlwy75tEai
         uHpox1R1nScPxpy7XDt2EE+VEwaF2ehKbdM2RcldlGm6LDTb6p9dsccbz/+/TfKjBEg4
         XYAiTpiENZeMXzXedt+1TltXCPT9bJygAimH7yvr5dRII3BKsgMSBoOQvIL2WOqlIgnp
         v3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087053; x=1731691853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR2TxMgpZ8/rc/m1AMgMu7w77GdSFVU9VMdbXA9s9WI=;
        b=kUto0pMO1nW42GJt2UPeyF7TavR43aQsI4nr7qqbwREYVPy5I1HXUZmirchocbSqyt
         2Z95zrOlEm+laqFVtqFW1GFNKStanuWoP8blEoWDMry8UgTW+4UowBt4WElGrf30t50c
         oWPiNFt6m5tqqUdb5vqnvW3DUTJe8GluyZ5rDwYgHiAXjyS9XK4w4Wnxv/AoxnIiu/tG
         RzEHuilo/JWu5Sk9WWj5pwh8r4MQJDA4Fb1f7+9djpVzt6CyHtNWSXNL8n7MRrxIH3mm
         6vJDKiyFJZJyD02k29fRM2yKDxR1lTcePMdrGpWeg3vU3SjYHMgB80bdy3Rp8RX6bAuK
         hTEg==
X-Forwarded-Encrypted: i=1; AJvYcCUF7QQG6iqdxmHWKWh9XiAuyAm9iYok5gRLOOFNSeXJ1zmXqzu0XYxFgDsuakETsSokxWqYmYXDoPc0lP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpahi1ko7U5dXP3q6XrmddNKbrWzK+PU+fm5cm45OW1BLlxGrh
	SdtR2TiN1LI4bfJUQbGJyuaJ6wzWB7j4x1I4PbJf8bdSn5tHZfZGkuSJ0y/Tc8tuh6ch35sPRTc
	AZx4=
X-Google-Smtp-Source: AGHT+IEmbAp1aw5z0/qXYi1N2m9p7W/TyNvIQC6pE89E1FbB47EbyRo3HzALuncBJye8XgeVFDi31Q==
X-Received: by 2002:a05:6512:318c:b0:539:e333:1822 with SMTP id 2adb3069b0e04-53d862b4664mr2119678e87.4.1731087053381;
        Fri, 08 Nov 2024 09:30:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d82685ea4sm680867e87.78.2024.11.08.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:30:52 -0800 (PST)
Date: Fri, 8 Nov 2024 19:30:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Viken Dadhaniya <quic_vdadhani@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: Use valid node names for GPI
 DMAs
Message-ID: <lbulzegpd5xachy6v7qgqwwmsy7h6pj5ykf4ni6fz7idpjdbr5@3nhx32yrz6gj>
References: <20241107-topic-sa8775_dma-v1-1-eb633e07b007@oss.qualcomm.com>
 <b22836bb-4fa2-4605-86ca-c3cb83560292@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b22836bb-4fa2-4605-86ca-c3cb83560292@oss.qualcomm.com>

On Thu, Nov 07, 2024 at 10:15:32PM +0100, Konrad Dybcio wrote:
> On 7.11.2024 10:14 PM, Konrad Dybcio wrote:
> > From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > 
> > As pointed out by Intel's robot, the node name doesn't adhere to
> > dt-bindings.
> > 
> > Fix errors like this one:
> > 
> > qcs9100-ride.dtb: qcom,gpi-dma@800000: $nodename:0: 'qcom,gpi-dma@800000' does not match '^dma-controller(@.*)?$'
> > 
> > Fixes: 34d17ccb5db8 ("arm64: dts: qcom: sa8775p: Add GPI configuration")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202411080206.vFLRjIBZ-lkp@intel.com/
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > index 9f315a51a7c14cd4116ec5a66a60285361d343f1..ebfa049515c63a0f1a333315dd370e6f78501129 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> > @@ -854,7 +854,7 @@ ipcc: mailbox@408000 {
> >  			#mbox-cells = <2>;
> >  		};
> >  
> > -		gpi_dma2: qcom,gpi-dma@800000  {
> > +		gpi_dma2: dma-controller@800000  {
> >  			compatible = "qcom,sm6350-gpi-dma";
> 
> Now that I sent it, this also doesn't look right..

For the node renames:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

