Return-Path: <linux-kernel+bounces-412909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB69D110D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB153B24E28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5CC19ABD4;
	Mon, 18 Nov 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QowslvRV"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53A192D97
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934572; cv=none; b=m6RSfxTbN6j8iEhaBN9oOjegza6t5E6lC+LpW6vukng97+FOcHhSq+u/7vVzDVOmZSXt2aNyYjW8mliWFXR4IEtXcSGKOeTkjBFHcSlleA9rbMoPgDiTzSaqGVVaiCL4XG162Oja5cJGbSpkzt/nI5GTmlve7FSQv5fjAE4Q9J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934572; c=relaxed/simple;
	bh=GeWAFYEO669F+1bbu0zR8yfp+pZj13YEcoliIrUfJzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNY7I3EDZgH6lWRL0Ch/X7FPyCvoR/X2yOT+0du1KDurERzZIVAaGMh/OLHGBSrKzpqIZPOpPTBiarFMvKrXJjl6ZwNoY1IPKtPmZFqytwfmpp0k4BGDdqY56gXpo+2IhWO2rgRgc6OFQ4pR/62r+uGVgbHqt32Xt9puko5P6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QowslvRV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e8607c2aso4279674e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731934568; x=1732539368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAqwMGBkTmHKZ4CNoWBz4QXL8qsRGD9BwJ8T1sZ1LU8=;
        b=QowslvRVYHIVzOIctggEZqu/EQzBnqzrAC0R1WBT/Oaa/WRvODHeupezsjz/VlC+mU
         es0NDSZ0n7OLA18On4OMFa7RwqJj8O3wdjhYmKzAgxZAUpumiwFX8SXEsfau2ziiqWc2
         sWI47f3x38ojxkHr39NztTpz6Y1MaS2ewHT1SeLvokVjSuo1VXhFMRzzkaZVeb1BUMnd
         R/nHlcE6ey173ZHpB8gC19dS5gHDUE52cpRcTp66ynMIXNZYHLZBcCO/PhxMxiXRpMZt
         L9AtQq3qRCwJhPnG2NmQBMCWwnJxnFf6BLfpNa9+WqqbDmbpahP/xtoRtJHv+1mZj3mQ
         s7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731934568; x=1732539368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAqwMGBkTmHKZ4CNoWBz4QXL8qsRGD9BwJ8T1sZ1LU8=;
        b=hAmv91zB53NLH8Gz6b9o+OxmXn2/7MgeMbm894zOxE0wbkKWbLWRsIIAv7YfLZmzLr
         p3EyVjRyToMdq9EE7AwQIv2Yy8c797LtIJeleVTD8JgrNh1r66NgjPyt8qlsdLcXSzvW
         GUiwOncqbhk6LZF7PE+i4x5PVlUM0e5A/wiN7dREtDnoU7tXAEvwz8Ulg/BE283RfVbM
         G054YnNX4PW1g9csPEwZcDaf1wrU4zeni7zgEdHbOYMDkzcFK01MottMCwuPQBh4/+bK
         PmW7cMwLpU/xeBGv64O0/t9p6Z2iFlRpf5n5ZXsr6SbF5rI9bRiq3qOFN1C6ZOdg50tO
         tNtA==
X-Forwarded-Encrypted: i=1; AJvYcCX4wCCDRaQgBGxp3iKdXlVJxoB5eSgi5AuSOnQjUNvf0Wb39HiIiDG2/Oil+zFJOijwS9ey5GKUAKsi3og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfOEODF9OdKUpoW3xYp2OWMY4nkxcrPLi+FS21aTCSuzDrPJl
	XYG+RNKfxG+82BhDmjUNzea6TtUqwvnQtp+Gtu4sErm817E9ZDPjv1f+gmVAypM=
X-Google-Smtp-Source: AGHT+IE1rwlqvuyY2O92e5DgZac5q8JPauzE9y+A00EL2MXWGS+FvI+OvGI5kWfZ80rMTLt0Z01AUQ==
X-Received: by 2002:a05:6512:398e:b0:53c:7652:6c7a with SMTP id 2adb3069b0e04-53dab298aedmr3661459e87.8.1731934567633;
        Mon, 18 Nov 2024 04:56:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548e40sm1594497e87.258.2024.11.18.04.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 04:56:06 -0800 (PST)
Date: Mon, 18 Nov 2024 14:56:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org, 
	andersson@kernel.org, konradybcio@kernel.org, mantas@8devices.com, 
	manivannan.sadhasivam@linaro.org, abel.vesa@linaro.org, quic_kriskura@quicinc.com, 
	quic_rohiagar@quicinc.com, quic_kbajaj@quicinc.com, quic_wcheng@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: Add USB controller and phy
 nodes for IPQ5424
Message-ID: <q3twp57aiwvsj2wimvszp7ecr5s4ldacxghzzepmxzcasgy5a4@nnqvq6tgruaa>
References: <20241118052839.382431-1-quic_varada@quicinc.com>
 <20241118052839.382431-7-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118052839.382431-7-quic_varada@quicinc.com>

On Mon, Nov 18, 2024 at 10:58:39AM +0530, Varadarajan Narayanan wrote:
> The IPQ5424 SoC has both USB2.0 and USB3.0 controllers. The USB3.0
> can connect to either of USB2.0 or USB3.0 phy and operate in the
> respective mode.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v4: Fix regulator names to match with other Qualcomm DT files
> 
> v3: Regulator node names, labels and 'regulator-name' changed per review suggestions
>     Stray newline removed
> 
> v2: Add dm/dp_hs_phy_irq to usb3@8a00000 node
>     Add u1/u2-entry quirks to usb@8a00000 node
> ---
>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts |  66 ++++++++
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi       | 159 ++++++++++++++++++++
>  2 files changed, 225 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

