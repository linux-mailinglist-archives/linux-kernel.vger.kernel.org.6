Return-Path: <linux-kernel+bounces-383326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA69B1A1B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54DDFB217E0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72E1D2B04;
	Sat, 26 Oct 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPYIdG7A"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC91179958
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729964176; cv=none; b=gmgXoGGM7AD/4IoR7YQHPibQQ/y9RENXeBIvX/dgumSv4AWJA98wSM68Qg4Tk5P9RU0ep0VHJaKmhgIEFxcfW2eIOCf4hMGcCd8N/Xp6JQ7aLn0ieoGSbGPZE5AUF609diGmTYbQ1qhs9dzgJ3nXBjlZSbEM1UKMx2Z0KRhPPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729964176; c=relaxed/simple;
	bh=phUfAcDTOItD03YWDpnRE3vQIi5vjTKDUM3kCtTifo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKI+j9JOuO36v3mAR1y0IYuBoH25wSMG2aJ7ssKArsgC6Waq8uTR4eNGWusLhYehVHrNCadwum7PtiPLnudYz+tlIx6Ixg8eXgNaBDktHrEpuXUd/7fnFhRBsXxdwy9gjZTRZNxdJCrJhrw1SEH0R0QYpI/HuSh+F6iNLSRDsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LPYIdG7A; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so3298102e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729964172; x=1730568972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmS+fK2Pn+5Ry5DbVr2l2yafLL4Tr2a4G4QgAKiqolA=;
        b=LPYIdG7AjLiSOOGoneJH7LnOpt+n8GNyRswqWdsDcZe51jALyG6eQ4kBbewMmregNa
         JxHjW/dGH88x2O//AKObWRfFhjY0IqHV1WrJfJBVs9X0YUIjf2c918b9kLaU0gGyiMNU
         SiTc3ux3n/pKBpn5eCrGjgT5hm/1E4I6QPjqZqjj7k/WPJ++9VpjopCXleEyyWYzObwM
         L+Ms27Pgdg7oAoT3jNLWRl2AxRFXnKcjMdwH+Y67mSojFrIK3J6lXoAjWT4Y7+++JgBy
         Z1F+7nYNI58oHZN8ZEU2QRB/mq6R1gZR7OQdQEMuqGonzYNNT24cuutYbov9cCQeWqST
         UOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729964172; x=1730568972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmS+fK2Pn+5Ry5DbVr2l2yafLL4Tr2a4G4QgAKiqolA=;
        b=OR8fzRTKlRQc5UCihk0GHRBYstGDUL940SvqJUTvaFINDp+cpSmX58ZjhtfZhzJIsT
         7F6o9cw8+uS07u+PPBbDkoT7kzZpKRsoxPkWSStvErbvDHOAvSUJfVmcoGCyTHWI8b9p
         M9KOq06CBAXnNuw01FehIvS4xc3nRdnRsi+I7T34Mw3LB39QB9IrVqzY92iOf0gpHXgd
         PgoxMHfDZjpTEeKHJ3fFUt5VNnqOx5K2WIc4aYWRuoOzN6KOtKxEgKAjWBn2Cd3B76xr
         80sSjkRilu6VEHu6LGKUL9HHVidzhSG3Fy+ZKy5LIv7YkNPyzIWgfz8a8GnkZzGSMHUV
         BVqA==
X-Forwarded-Encrypted: i=1; AJvYcCVLccAKNTSpYO/g3Bxo35hFgnMx3AogW1kS1SyfEZzpVnpXOCS6XToxDMXr/xQWNkwuX3PUq26NqFeckhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TauQuJIxgkblVoSpPRFnVeIx64Na5cEfK0v3ZWLjwb+Y1lRv
	sYfODbIdG+WnglknHYgfkRn7Z77sAV7TBzCvFNWTxWKjqxK2klrUIr2wjuxC4UFrMnRK6dVdIjh
	y
X-Google-Smtp-Source: AGHT+IHxFtbh3mAC/q2yje7AqlBTOhREdJh9MYZEaNaVgKdJdZ09vcBo/Q+Pw/1GR6+WaFWYyICbXg==
X-Received: by 2002:a05:6512:39cd:b0:539:f51e:17d3 with SMTP id 2adb3069b0e04-53b348d0ccamr1172908e87.14.1729964172292;
        Sat, 26 Oct 2024 10:36:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e12452fsm566762e87.73.2024.10.26.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:36:10 -0700 (PDT)
Date: Sat, 26 Oct 2024 20:36:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Enable USB controllers for
 QCS8300
Message-ID: <xijjs445fzeuzbj2bg3ziwlzenrk4wo5zlyze4j5mldb444oj7@73ynic4xqfdj>
References: <20241011074619.796580-1-quic_kriskura@quicinc.com>
 <20241011074619.796580-3-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011074619.796580-3-quic_kriskura@quicinc.com>

On Fri, Oct 11, 2024 at 01:16:19PM +0530, Krishna Kurapati wrote:
> Enable primary USB controller on QCS8300 Ride platform. The primary USB
> controller is made "peripheral", as this is intended to be connected to
> a host for debugging use cases.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 7eed19a694c3..3e925228379c 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -265,3 +265,26 @@ &ufs_mem_phy {
>  	vdda-pll-supply = <&vreg_l5a>;
>  	status = "okay";
>  };
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l7a>;
> +	vdda18-supply = <&vreg_l7c>;
> +	vdda33-supply = <&vreg_l9a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_qmpphy {
> +	vdda-phy-supply = <&vreg_l7a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};

So, can it be used as a USB host controller / connector? What needs to
be done in such a case?

-- 
With best wishes
Dmitry

