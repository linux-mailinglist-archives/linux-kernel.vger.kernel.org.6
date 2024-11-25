Return-Path: <linux-kernel+bounces-421382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112D9D8A94
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA052851AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807F1B4F3F;
	Mon, 25 Nov 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNiTBHsZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385A2500CB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553147; cv=none; b=Ht5+dfUX7+eneem1KjzeVrmkBlSsz3Y0rL6yGA34AnsxyKRTXSwuTsVjCekEMt4psmrNI6VgBmxKCbB4vQPqO46LzvT+78sQecr82mmPbeBRaAUAlYouQ1LlGjAYfQl0TAPREoBS+Tz3DjgeQz3q7gmBc6k1nmiYkDgtJ2CgrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553147; c=relaxed/simple;
	bh=pntte1+Z8hWk6WRTFB8PfobjrAF8mnuCEH1yqjlijng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbS/O8cf5v78lbvgd3z9gP93s7EawFDYYrD/hsUqJPMm6Tt58PTEHgcm1nhKRKjKiRBmc+C0wSuGQrbNDh67pcXdDcinEeNHx0B2OYMSx7uizYMW6eke5v9ZrkgboXqBxtziI6SXArNIuYQCqTT4dTwxZs1AT7oKUinwe8zuFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNiTBHsZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de880c77eso22164e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732553144; x=1733157944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIAgeAhmCn372flnwJB0OBUFPTeilzavFF36VaP2Itg=;
        b=jNiTBHsZi11Abuz2rbREBYuGJjFunTAO8IigJ9bFMKVIXl+jycz7Dkzs8xvHLr1+VG
         dC4EOmOYOgQ+CGUS6xNhpFU+z2YzvEeuvxT5R1PNlTUm0a+n2KUIHmuHuq8QO1Lfn7z+
         XOuBh4zGrmPcexBLp0m9O/AcKtWkTty7aoPLkxzgK+31XgCzXP09yHjMg+o45nHvZp42
         aEgQUqHDTw+iscjh0IxZiolHqdkqytI0XKEd2rPpCniOKMmYo/XTN/1QvbNkXW0kHuy6
         Ryd87jwcm4KNGsxbtflR1f1C7D7tnliChul1lYYqZBpk6+JPKtlszFU9gQJIyDhDbum5
         nCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553144; x=1733157944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIAgeAhmCn372flnwJB0OBUFPTeilzavFF36VaP2Itg=;
        b=n2fcrjIbmwGjUQvbfy7wPL2x9tAXs7q0ZFdaV8P9UA46rK92ZSDLHHTVrO90auQOFd
         X9LkdjW4q+pM70aVaxwJ1tFGrliGDov1ChVuE5dMUX2lPyd9SORywX+hsrUjDHwJGlyC
         6o1kTbhUZD+EiJnrZhgxRaqb915VlPFuvVKKCjKhr7jSjYhx4xr3Yj+xVzEQzvCYtnj7
         p+yPHiMpVHPo/Txj7VkCX1Nl/IQFLi5t/qIrFm0dpO2a5jHM0RoVvKmFcTSy7T5mP/fp
         zun/ea91s3Kv05D5+GncXcy+2zrn7GmARqcmCwusVO3cqQouMewpP+0nj66TjazgS7yu
         2EZA==
X-Forwarded-Encrypted: i=1; AJvYcCU3NIlPuH/mPOesKE9Z0fCmPBkvpyFbrmWxTxdAWnNfGpDDsXFiWrVAUbanPRQOiNGoois0Lv4P+zSS7co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiejP67Or1jMKkrxVavp2VpE8dr5PcXofjiMctd1rDj42aVXJv
	961B6keb+Hw7l6GLV7a+XvN+CdXSzS2GYmRdTrYMRXf3Gx2B364pQloPfJDClfA=
X-Gm-Gg: ASbGncuZHXMZgpi0+Tevcjf+dsq1KpmkzGT3TLOUtfwMULMO9yWoVs7/tg2BANz4BrX
	blM3Oh+jQGQtrdM/6Jly4YXXew0anqtvljAjd0gLGrbec8RMkbMeoodGZpSC0K5KHWpbAZfN1kz
	a1JjFbyqxAWoLVTlSY6NELWIJ/1YCcav1V/gyCX0Y5Jsg2uNebHK0iEhyVhYVU825fr+zHvSEi4
	CI4egjAusnDmM4ztErpsJGGWvvhFidoOZd5/XWAo4L3ZBKlprtDRM9cHq8zR7jHUk8QydHjga2K
	CMeYpF+KI3ZUJhu656y+1o6b2zuz2g==
X-Google-Smtp-Source: AGHT+IF6AynL9UpDhBawUpEwDkQ2c3G14CtiWofl68FeWiQ6izt6omfKnKNwyR4f3DSsQ0mgBCkCPg==
X-Received: by 2002:a05:6512:ea4:b0:53d:de12:ef26 with SMTP id 2adb3069b0e04-53dde12efbfmr3507612e87.4.1732553143652;
        Mon, 25 Nov 2024 08:45:43 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53ddd09737csm1089610e87.156.2024.11.25.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:45:42 -0800 (PST)
Date: Mon, 25 Nov 2024 18:45:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xin Liu <quic_liuxin@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@quicinc.com, quic_jiegan@quicinc.com, quic_aiquny@quicinc.com, 
	quic_tingweiz@quicinc.com
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qcs8300-ride: Add watchdog node
Message-ID: <wty3opxcapeesat2bnai6ntbk4utwxk2hf56w4hymwjxj57ora@6f7f2lwtdcpo>
References: <20241125093503.1162412-1-quic_liuxin@quicinc.com>
 <20241125093503.1162412-4-quic_liuxin@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125093503.1162412-4-quic_liuxin@quicinc.com>

On Mon, Nov 25, 2024 at 05:35:03PM +0800, Xin Liu wrote:
> Add watchdog clock on the Qualcomm QCS8300 Ride platform.
> 
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> index 7eed19a694c3..d4e4c7a8b453 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs8300-ride.dts
> @@ -265,3 +265,7 @@ &ufs_mem_phy {
>  	vdda-pll-supply = <&vreg_l5a>;
>  	status = "okay";
>  };
> +
> +&watchdog {
> +    clocks = <&sleep_clk>;
> +};

I'd really prefer to have this in the SoC dtsi. It's not a part that can
change between boards.

-- 
With best wishes
Dmitry

