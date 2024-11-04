Return-Path: <linux-kernel+bounces-394624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE389BB1FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A40B2334E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9931D26F5;
	Mon,  4 Nov 2024 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ3kVd6p"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F41D1E6A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717576; cv=none; b=P+vBSRaPsADH7h+W+aM4gOJWP5t2xHyfNTc1Qj40sYAf0FetyWdb6ekfGIkQHWUKh0Shp03uq6hoMHDgIfuzf3TlkD4o7jYKarHCh/W353Na9omxXlvUn4D/vKlZYesadnzfXq5ziM68y3Y4S1OUyJtc6sX7xo6QeaN9Cg3knIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717576; c=relaxed/simple;
	bh=vKAr9hmyTddgF/WSN6iuJQ5BAfSJsnCK8GkT+tZfH0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLEz29UQrE4EViHqGe70LkgQ2DJQc76Dbj9/ibovkTPG+BndMUu4g7fhC05nrg7PFiIaetT/2P5+2KsJeiNhq6DpoJw4hkv7imAg+S8dJI9SbRTWt4cNXn6lzy1gnejms72WMTHT2rd0oNlImf/iWzoijbDx0xk5bT+s0EpIggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZ3kVd6p; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53c779ef19cso4656465e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730717572; x=1731322372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwsIeL6KJEG07y8wl1qOjDdqNT8K9HlcyWy1sRLVSGg=;
        b=NZ3kVd6pxU81ohNXiM8TrKnboqB8NS57DV+9kCuy0DO4k9utYuKLdpYLg4msHmqaPt
         9nHOsl3dRq5USjDtg1D4xLj4Jz9aFQxWt+hirM8E9F8n4ctyHzO5oInE5mP8inKNnJrd
         13efpAvjHN4ogaIgx75MwlSCMlZwN88pzXLDaXrnInenZiJOZtuR2Ep0E9wDyaSXHd/u
         YF5CxZrWjFJxGqjcYeux2oQ1okdqycVc5jiXqAkvhYi2kx/Ye5QJYC3cH+fwhC1aEIC2
         0AXpRancvluAdNGj0SPDF9+kV4svQ53B4GiQdl66c+CfW3CWTJxwsLZBRJkvU6om/ZJj
         DFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717572; x=1731322372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwsIeL6KJEG07y8wl1qOjDdqNT8K9HlcyWy1sRLVSGg=;
        b=e/yrOXCy9GJ1ADoeq6+STrkpQHaq/xjveDOw9QTqo/JOydrGmpwqzq5yDAWYAwIzeO
         mxxvh6pVJ5NWf1XoYWvAVnRYlFTTZYxAynLlFItYI7IWFFbaQlWxoAxAwljD7ENQkh0j
         7YduSor9jhJ6UUsPp0j1vI5lVmx1zo8E5Uy+K2a6lRf5j6SFUCXwC0yoKVfPBwurBIjJ
         17eA/Wd1abIA5r0gSYPSXl2vqXtO1Wp1LZZkwmHgxs/gscIJ2szQ8DowcEm+7M7uqDh9
         tHlIEX75Y8uPgVAPbZdyWj7UOr5uSWvLsYmfuvRG29zmCrmYOeI/0QpN39+PrcXlgJ19
         57PA==
X-Forwarded-Encrypted: i=1; AJvYcCXEJZMQG0BUbN6k+vp6mp8aoqS2R6qe1jgy7bD0B3chrjaToC4SRhCYhGTsyxxbOy42rRpSas1xrqa1yAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oM5n5q5wE5u10fto+yIGungQz6PFSJnQLJknSKFx3QK1/nF4
	R497R/HoNAslPxBaGH6Deu2zUQbzJ/fJwfyIbP0YL5ZUt3s7qalBkdFWwDCbiN4=
X-Google-Smtp-Source: AGHT+IGA/AaC//7xRg1rvQ3Pdaj8tMAcvK/iweU+LcWcYnfbkwdRORCk/zzuaDqXc0ND2sX86ZzRlg==
X-Received: by 2002:a2e:1319:0:b0:2fb:4f0c:e3d8 with SMTP id 38308e7fff4ca-2fdec88b40amr51037091fa.27.1730717572530;
        Mon, 04 Nov 2024 02:52:52 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a62c0sm16317631fa.75.2024.11.04.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:52:51 -0800 (PST)
Date: Mon, 4 Nov 2024 12:52:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Melody Olvera <quic_molvera@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm8750: Add IPCC, SMP2P, AOSS and
 ADSP
Message-ID: <kxpokionrgollof5yptnqnxgsi4v3g24iwdb67mznljzjzpxab@dnts7qgvu4vo>
References: <20241101-sm8750-audio-v1-0-730aec176459@linaro.org>
 <20241101-sm8750-audio-v1-1-730aec176459@linaro.org>
 <0782c956-361b-4109-a8a1-58b8ad396e0b@quicinc.com>
 <649f43d5-2d75-45eb-b13c-31fe88d99c8f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <649f43d5-2d75-45eb-b13c-31fe88d99c8f@linaro.org>

On Mon, Nov 04, 2024 at 09:36:46AM +0100, Krzysztof Kozlowski wrote:
> On 01/11/2024 19:14, Melody Olvera wrote:
> > 
> > 
> > On 11/1/2024 10:19 AM, Krzysztof Kozlowski wrote:
> >> Add nodes for IPCC mailbox, SMP2P for ADSP, AOSS and the ADSP remoteproc
> >> PAS loader (compatible with SM8550).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sm8750.dtsi | 140 +++++++++++++++++++++++++++++++++++
> >>   1 file changed, 140 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> >> index 98ab82caa007ee63c395a3ce0f517e2bbeb0aecb..eb826b154dcb2d8165426ba2225548efd7547da8 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
> > [...]
> >>   
> >> @@ -538,6 +566,17 @@ gcc: clock-controller@100000 {
> >>   			#power-domain-cells = <1>;
> >>   		};
> >>   
> >> +		ipcc: mailbox@406000 {
> >> +			compatible = "qcom,sm8750-ipcc", "qcom,ipcc";
> >> +			reg = <0 0x00406000 0 0x1000>;
> > 
> > nit: unsure, but should thse be 0x0?
> 
> No, all recent upstream DTSI files nodes use simplified 0, because it is
> shorter. Maybe except few cases, but then these could be corrected instead.

I think most of the files (including x1e80100.dtsi) use a mixture of 0x0
and 0 here. I have been told several times to use 0x0 all the time.

-- 
With best wishes
Dmitry

