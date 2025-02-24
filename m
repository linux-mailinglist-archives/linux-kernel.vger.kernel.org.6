Return-Path: <linux-kernel+bounces-528009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCE2A41274
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E3018900CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C92A125DF;
	Mon, 24 Feb 2025 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxogge4k"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC2C2C6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740356343; cv=none; b=JedR8NZNtOMBqjWWHXDwuIrOjLElFJyyy4Ah3DjT74PKZpCNynKXRBzsqBwDVD6VMZKyZRS/Rfo5WbL0UFU0SKGNlcHQINgAmHm5iErjjPEitTH4cmRRGJkaKWve0dS4do+RQBbprtv8xXWcxLiDbVihHSQvInTsrE97ikxYJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740356343; c=relaxed/simple;
	bh=7Jy7dLx7zO3ZkOOyvfUI0Qww8vOfT8OV2kKdICBqy9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7xPc9mMrrVEr3924qKHlEhct0/9PdbxKumeX5TpKzQOwg7xQCme63MBtxclGyKt/3M9dE048bBqfKanIXBPrgxdIjoDLbsMFp1qeHUZBXtpH6sH3nMYitwY++dfsiZPJs/J/OOj2FsKm+mIwcic1H03ii+pntdphAuq8lTQN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rxogge4k; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-547bcef2f96so3775650e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 16:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740356339; x=1740961139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGo606DZMNR3CPOmAAdH29sE1yGH7gxkKNN2u18HmZw=;
        b=rxogge4k0F1EP+QODG0E+y6/Qq8Vo9PVYQgUJEDysKAxTIepMkh3DZtSzYNtJfbU+y
         Kd5VqnXIB3S8xAqPSUc+dwUkjshaltdnT+kV6D2XOdkzV+aKqkmSIEU/8Zhd3ol53lJS
         cxoENrK2HHhL9azEZAcpllSEiG22CUYGpfS6CLlpLNAi854eQglGZQ/W4eHpelFnYHoi
         iHH7XP1ZP17Aypb58HxV3uUo5Yjv0nkDsifu6SqDUJW9J3A+R8y4Y02MfnvcZXjRQLJb
         HScTvIzlryx8kCjBeFPJFtqaqGjO4ZO5bLWLXmxXi/LXnjsMgOM5E7gGzhe1LocDX9On
         mRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740356339; x=1740961139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGo606DZMNR3CPOmAAdH29sE1yGH7gxkKNN2u18HmZw=;
        b=BlhQ5whnhtgqSbwLMxcyMay0EuUwMQ2sxnhnnxyPh+SCz4Jimh50z6n0pgPQTzzxQ+
         oL/JZGwiOv2uUXCcvp7twmpkIflZaMXUDFZjuTQXU1PO3JvEO7UzKyRy9oqtMTpp9LM3
         np4lDfz65FwU5g/lKPRjcPWHXldDBBSqsOAL6CDI389Moyxaui90K2vFMYjzv2predBZ
         z7MURO5M5Pxt3XN/eMRrHVtp19kwj8SYREq9fQhipsvflHHiD2iFQmiyMovWfrL65trF
         LBMK+oJGX7cnOv1LTHggt5hSuDdgfN4gbNJgkrKNulZRk5M5mii2pITV/m1hTSiPEmGI
         W9Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUz6/Ns3kl3scS4PhNxq1wbzKw1xMwCfW+Ee5UI8HUEXI3gNi/Ofen3HkbscOYZ+g5DHed9SYVITVRj+ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAuivS65M5Ogd4/8Q+L8+uwsminrvZw6dmfcLBELzuMcLTkrE
	XCG12MGPByS5fR5K8vA7iH7KRfubIl4r8hAAci7++8lDF+xgBzn/3mmiNfc5VE4=
X-Gm-Gg: ASbGncvYJPSgnoDhYWlwvckcjzP1SKOQ7EV/lC/Vww2JCi/3h2bZJECzXJ/UqocQaV4
	aEwFno06Vn69na4BOWXiYRkP5M1Mo3IbWBL4AZUBJnwBWnLipE8yt6p+MPoRGt1p4CV8s2KNUmb
	zYmV6vSKPIT0R7lk5Tp7cMxOa8lRsjFps/fK96okti5tnm0eaYDiVKkbSAAORQ+BkHRSEsoGkln
	0HlljQzF8Lm/W0Qia/pvRNXtbFKABW9/inm0AIDI2Tf4hMNIEEuS0mqQt0ftN6gmPaiKg8sPV7r
	658/O0LlEG3nObmsKJvFB8lUac+BhBkPLxQgLCaU1ePzIk1ytyWzXGbXkf1uL2LznBx986Tfcyr
	gVM9IeA==
X-Google-Smtp-Source: AGHT+IHh5wVjH6EUlxs4+YZZSHGEjFF9k8cOMxZNtJaJAuOd8RU4IAkF2m0DIXqEyGl4vlUyI3tWrg==
X-Received: by 2002:a05:6512:280b:b0:545:bb6:8e41 with SMTP id 2adb3069b0e04-54838f5b913mr4097064e87.52.1740356339157;
        Sun, 23 Feb 2025 16:18:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cc28sm3301582e87.201.2025.02.23.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 16:18:57 -0800 (PST)
Date: Mon, 24 Feb 2025 02:18:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sdm632-fairphone-fp3: Enable modem
Message-ID: <bz3mola5r7v4rs4esmhiticq2ahpkhtwxqnv6nweyfkebszvrp@ap6yn6pvrtww>
References: <20250222-fp3-remoteprocs-firmware-v1-0-237ed21c334a@lucaweiss.eu>
 <20250222-fp3-remoteprocs-firmware-v1-4-237ed21c334a@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-fp3-remoteprocs-firmware-v1-4-237ed21c334a@lucaweiss.eu>

On Sat, Feb 22, 2025 at 02:00:50PM +0100, Luca Weiss wrote:
> Add the necessary supplies and set an appropriete firmware-name for the

Nit: appropriate

> modem and enable it.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> index 5611209dbfa41d7834af7903535ed3e05604ba63..31ed26c31e6ea381a8942ccf569513df3300cdeb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts
> @@ -87,6 +87,14 @@ &lpass {
>  	status = "okay";
>  };
>  
> +&mpss {
> +	firmware-name = "qcom/msm8953/fairphone/fp3/mba.mbn",
> +			"qcom/msm8953/fairphone/fp3/modem.mbn";

THe comment from the previous patch applies.

> +	pll-supply = <&pm8953_l7>;
> +
> +	status = "okay";
> +};
> +
>  &pm8953_resin {
>  	linux,code = <KEY_VOLUMEDOWN>;
>  	status = "okay";
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry

