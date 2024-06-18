Return-Path: <linux-kernel+bounces-219010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2890C8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD241C22AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD731CF3F6;
	Tue, 18 Jun 2024 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zA1AtdkZ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D511AD4A2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704823; cv=none; b=ZrK+7992pNFadO2vAMMdDC8Bv9cCgeb6RLEtZ/MNd0oUqM5OfpFyFbujH1/mrxx5ux1OCtCpsO53BefMIT9TGiTSfot82iFh2lD/vTZn+jjGGKrznR6zqbtlFdNs4NH4zuxjeDT3CbpdVnxsktQ6zoOTlolwcT1f8uv93xb4Sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704823; c=relaxed/simple;
	bh=y6CpY8UrSo33MHhP8FCh1QwnMKQUwodzy+eoAoT19Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl+tisya0+bdvAsFBiCbjCVYX1uRS7l4EMJBahwWKtl+Bfm/JQf54rVN11Tx0t//MDJJ7ZjPKfrID3y2gS03clah1e1N+lCaXnkTzPssiVC4tSze/06vafZBTfm2/7fdBuTC8gflNbklRF0u10VJR41xtkldH6X82t3nAMvrnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zA1AtdkZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec10324791so54628611fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718704819; x=1719309619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ngIQn+y1I4/dZZwfy/zLsGesaWK/7P8e5P4qGlNeiQ=;
        b=zA1AtdkZhx2yBvP1fm72nvd4dFGaNMrQ9F95AET8l4nk0Lo3DmGwbQ0GNTQcZLNQx0
         aLvPU+eB/wIdloH6ziBM1627lX+zB3zk81cS0vbEJApmX6VZvGQgf4FnKxG0ywsZmxLF
         vpE9lPX3i/22liIUwjWqkZL1ZwTIZrA9+tOVN80Idl0Oxil9xPfOOzMELfFdfs3ZX67N
         GS0nXxhD2wBHeHDHRydxcXzM5wZ0u2Su/lDXRmidAo1RS5E/9AxPs2Nj+Dtt7yJJGt+1
         a9w6Wh8Cq35OGNPa6ZtIhEyv0KvgYZNawpfhPEyUrXicha5Jok1nGea9UkzgywsuP9+C
         bwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704819; x=1719309619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ngIQn+y1I4/dZZwfy/zLsGesaWK/7P8e5P4qGlNeiQ=;
        b=BlelrN0J0aq23odMzyGBBRhVYdtv4ZOqN5lf5d0llXBr3dwXf832UqO/+JWd8J1aTi
         vGM6WCVszpMmh8hmb6jQoD9VulKY69qsfGw3uEYkTRGwQtFt8wdN4a6MvTRlNsUEBnbE
         S/ZWzIvpFz2PkRBEEtoryukZmZnNrx6Bx3IwWCtlN8j+TlIU/UBfp5MpqcU49EJ5Nvm8
         umkE7V0Tl47ilJh+/f0Z3J/S8qmlIS04GY8YrFiRHkesLpK5CbNOKyzQ4ucZztBsqtFX
         SmF0IM2bsjVISHrspcWUKd9AMP1Q7a2WHqRsooZ8tisyhWT//HNzA/yLRC8/JiLf7f6A
         mH3A==
X-Forwarded-Encrypted: i=1; AJvYcCVJCTYO10GL9IGFMCOljbGpypQlHpE42/7HZ3HKecMLQ80A5VRIQm9w+7fxVwo10HiqZfGW1Z4ztsLOqpEq6Y36PhCMVPDh4nu3SfOo
X-Gm-Message-State: AOJu0YyDstnjMAw/a/mLBgP7V5Vxe/JYSOQ2f9vG2MU1/Lqqy8EeIkIz
	uZ5IbRRY3Vbjv0z9MgCPdSv0wVN4b3G99uiusoZEKrJmMnSZAH4u6w+cpTAE+34=
X-Google-Smtp-Source: AGHT+IH7rtbQgMI/Xpi2ruQ9UrqNrldQoq58i+N6rvWxQBTuiDOV7XZQFcZOb2BQcHFO++Xy6iKxXg==
X-Received: by 2002:a2e:b013:0:b0:2ec:27e6:39b7 with SMTP id 38308e7fff4ca-2ec27e63cf0mr46551291fa.37.1718704819326;
        Tue, 18 Jun 2024 03:00:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05bf41c1sm16556731fa.11.2024.06.18.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:00:19 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:00:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: qdu1000: Add secure qfprom node
Message-ID: <uur33zdu526onphnxjtj44mijrj7ykfst4ninrtggcloj6youv@vrdvdd4esecu>
References: <20240618092711.15037-1-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618092711.15037-1-quic_kbajaj@quicinc.com>

On Tue, Jun 18, 2024 at 02:57:11PM GMT, Komal Bajaj wrote:
> Add secure qfprom node and also add properties for multi channel
> DDR. This is required for LLCC driver to pick the correct LLCC
> configuration.
> 
> Fixes: 6209038f131f ("arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller")
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
> Changes in v3:
> * Addressed comment by Konrad

Which comment? Please be more specific in changelogs (no need to resend
just for this issue, just keep it in mind for the future submissions).

> * Added Fixes tag in commit message as suggested by Dmitry
> * Link to v2: https://lore.kernel.org/linux-arm-msm/20240612063424.2494-1-quic_kbajaj@quicinc.com/
> 
> Changes in v2:
> * Minor correction in commit message
> * Link to v1: https://lore.kernel.org/linux-arm-msm/20240607113445.2909-1-quic_kbajaj@quicinc.com/
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

