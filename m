Return-Path: <linux-kernel+bounces-545587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E69A4EEED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845C93ACAE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AECD255250;
	Tue,  4 Mar 2025 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLRykez/"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF8335BA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121930; cv=none; b=Pww7d4tcQ/5gDO7yIOkOMG2fA2fnV1fvJldvt/zZlVz5l037gGX5jyEacWrMJYe19/9llwuwYFcFxfQMx9/uplmha7EL9vJbQTzfnawux9hIeXz40aMKgdpWgmAvRf8JQBFsQOij5RqKX1aLZrAR4fIfBMvzLgcu139Jr/KiigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121930; c=relaxed/simple;
	bh=5CJK1L3DdT2P27pS4L8DUKmYYJnFR7F+MB9nM8vDjq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pclBf3fsvcozRHC59TGr1Ck9q8T/XwCiP0b3hyGNv8LiRahBWzfhfR/+akR+KXm3ytsIJXZOQ0RS/EX1ucTj63U5nyjMeRPzxB9qnrg//pZ5KPwZJ/a7m+fs8nnKGsiPzIZY3IZvR21s5ljpt214XmxBkW8hTRMpjsnWVSNrKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLRykez/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so3814176e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741121927; x=1741726727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mmSXUaSzYlxPu2USBQ5qryQWG6hHSfkcGFhsLiuIng=;
        b=yLRykez/HSbsccAl3klZNZQqm+dTAeD/0VLjmeTb1XzXJfhMmKA2Ae7rqJV/9BPtks
         N1qgKKdfdzhkczmiQMbMZ1SHf0HL9vdL6gjqyt93ARiB8b03Blubnvg4HeDhsYfhpzYO
         KD4KDeNLRF59PO5NrTv6gYnakgnONv5NbKvsNoCqhBB56AWhiZZ2EIl3smVuLLys7CHm
         tKJN5DH8Hp4LlTDqvQk4LT6pezCVim5EC1ji5bGpM+mwGkp0IHRmmuFISvLNnGMn7Wqb
         rNU+EEUcnoZX3rwkRRWnRHPbucF3j9d3ojXhWK86YABn2x6el0JiNZ6+ASrDekC6IIk8
         5q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121927; x=1741726727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mmSXUaSzYlxPu2USBQ5qryQWG6hHSfkcGFhsLiuIng=;
        b=X3y6WojMMBd9mjws322HXJpvSTeZQQw02UTt8fJ2W6Bs4A8QHCdcHiaqz+nLy2ML/k
         PjzxOl/uM67rNWRzWTgH9gESGgXP9DNRlX9iXhUbXsjIVFGApSm1GUjGKZZGlAXjtMhI
         DJiPMFfDGWeza3n6ZI59ChB5QOhKwLo1zgtmccrqCw6uhzSS9/8z45ibpjgxJHcQ3KkN
         WIhApZYa91Ew+5+tTvhksLvuLW3M3BA6EjVgh7hV9WtTMMdRJxGQcH9msv/7lxyYxrjW
         vcx5hkaE0q3f9geuUyiWugFbF5cpMSUrad8Dzn1apMCkmaTG3pw294ZfVA8onj/B5hg2
         NgSg==
X-Forwarded-Encrypted: i=1; AJvYcCV/VPSUudHy8yQZEn2o+T4RLuT0b0ASmVACmlo/3vmWBglsyifjXnoB4uJwlLhwp0opt6s+vjtO0LnFX2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnyBtGuhiDSpY1+iGRTczHFUO5a+wmvl7dJs883DcmE9/cE4p
	oXIxeyQOvDLn0epc+Y+HTlNbQmH5hZKcslnl1Z+u3f9K5E6i5jvbdZNh8irqf6QxKQI+hGD86EQ
	WLp4=
X-Gm-Gg: ASbGnctVKvpSXsfOuwpnNiXh78z9pVPNBdwwXg/pem/07hRTFbO7s6sh/mclEq+VtdS
	kVz6qPZhM3iB8co6tsjRBxb3rsO9XkkUVYZLOqQRcO2wrIoMrB1CvqcZIEGx853v+B4lCo1YQ2G
	SK+uW/ZD9v6ymledZWW3cXBQjwhxJ8SRLgBDnMSbTkAs0lTgY1hCgyiJVyX0a2cseM4qwlDOTY6
	WW8xAqXhvtAF7e2Y4Aoo+x9FiTYuePpBbS6oQVIQ7VOzaQBvddctQhcvRhZXP2plbrxUscWQ84O
	nv/Z0HoMBJIq/BZxcMjrWFJ5+PNVxPRkB0uUPNtBrGdUuJ6HA58Lo7RdVsmfh6ycpbe9foh/RS+
	Q7xg+LS8Y9Abwc9xJA5fBA2Y8
X-Google-Smtp-Source: AGHT+IEkteX/WZFejhteH6gRB1PUmIKU/gh7k+WBHiisHZu0Tfo1WrX2L4UA0SJ992cRS807pAM8qg==
X-Received: by 2002:a05:6512:1289:b0:549:7394:2cfa with SMTP id 2adb3069b0e04-5497d377287mr150803e87.38.1741121927123;
        Tue, 04 Mar 2025 12:58:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549591c8bacsm1132258e87.122.2025.03.04.12.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:58:45 -0800 (PST)
Date: Tue, 4 Mar 2025 22:58:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kaustubh Pandey <quic_kapandey@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_rpavan@quicinc.com, 
	quic_sharathv@quicinc.com, quic_sarata@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: qcom6490-idp: Add IPA nodes
Message-ID: <7jupetl37t6nshmme5raxavvbjo3vo5eajusroh6j3ccdxnpo5@7qaz2nckghcf>
References: <20250304152133.GA2763820@hu-kapandey-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304152133.GA2763820@hu-kapandey-hyd.qualcomm.com>

On Tue, Mar 04, 2025 at 08:51:33PM +0530, Kaustubh Pandey wrote:
> Add IPA nodes for Qualcomm qcm6490 board.
> 
> Signed-off-by: Kaustubh Pandey <quic_kapandey@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 9209efcc49b5..ba47786d6474 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -19,7 +19,6 @@
>  #include "pm8350c.dtsi"
>  #include "pmk8350.dtsi"
> 
> -/delete-node/ &ipa_fw_mem;
>  /delete-node/ &rmtfs_mem;
>  /delete-node/ &adsp_mem;
>  /delete-node/ &cdsp_mem;
> @@ -515,6 +514,13 @@ &gpu_zap_shader {
>  	firmware-name = "qcom/qcm6490/a660_zap.mbn";
>  };
> 
> +&ipa {
> +	qcom,gsi-loader = "self";
> +	memory-region = <&ipa_fw_mem>;
> +	firmware-name = "qcom/qcm6490/ipa_fws.mdt";

"qcom/qcm6490/ipa_fws.mbn". There is no .mdt in linux-firmware.

> +	status = "okay";
> +};
> +
>  &mdss {
>  	status = "okay";
>  };

-- 
With best wishes
Dmitry

