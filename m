Return-Path: <linux-kernel+bounces-422426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B849D9999
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74539B2242F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245181D5AC9;
	Tue, 26 Nov 2024 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENF/T8Zr"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA363398E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732630939; cv=none; b=Sw+D6l75I4R5ifLDsn3C18aFdZmGclxqxyZRNpKOs/WFB4uegVl8WSYGbwU0rjH/rRg/n6/LhPICzFDtHuNIOQtLdTjrlGP7tntnDkxsuYWbYTx5d/rhfaTieWPME6AzZoDfY7muFWG8vgiR+GJND2QVKTR7MmMuSIxUWo1mM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732630939; c=relaxed/simple;
	bh=SOSUQAOlh5dpiHg97YBtYq96KsfsNqWvdPKUV2/BcQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNtPbr4OMaxybDlBqkiZGjFXskyA/V9yGJ4MUlEGyKp7ayhUFIYC48ITVB33d0hGLH3ZnNnmOFq96JJSAdeMfr5CYoc/NJJoO34mCHnlkE+kuE6Z6fYxEXa7e7X9jBo7QkzQamTPoOYNLncHQ3zQCzK+SERwcZWxIrXG7gJnCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ENF/T8Zr; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53dd8b7796dso4280248e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732630935; x=1733235735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvxvLshTV6jYerFVYx7chEJSlAAM8Tt1+r2hoHp2IbE=;
        b=ENF/T8ZriMV9+IJsXkIg6O+Ipmx8gw3iirWWAsknY5Ru3zhqQuQbhjHkxFHVllaId/
         htWDD+xwBC2j/wChfkI6mR08CLZGeAp+Gwo34iYpaqsf72BkBWPLG9j/O3kShDGy2G+V
         v0EfptUH5270F7ArdKAJP48MGNKEyFA6E8ybd7cu9CHRzZiL4L7fa4nf41AVmDnZx1pE
         GWSWgWw2XfjM+PPtSPnkRUwyqhsVaqV6Z3Y1k+1vNS1IPtCpGmCxSazawawYMdHnU/mg
         RTQ28goK6oaDp0wkzGj5i3K5glou4HaS+fkOuEVD1oCwkk6S+TCMTZLdkBMGicnuIA4X
         RAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732630935; x=1733235735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvxvLshTV6jYerFVYx7chEJSlAAM8Tt1+r2hoHp2IbE=;
        b=IjF1xVQZj+Ey1n8pC0Uv3VzuDzQntFhvOKv1Ipt16k+SK2/geFgCc1+9dhs58nxlLQ
         bPXJRans0ZS4I/z+tifNlAweWmJ5UTPlJzSZkbIuOdT1gpI0owAVZbwIhnSZ0ZWmZanp
         ZjJVeyTmLzjxc9Ftu7oTbVKo/J20J2F8Cjh3LsWfSZ2O9eOPvapDpjFrpYwALURoSA9s
         ajTSB7PgopSH8XUEKQKj+Hojf4D/79AfvfrocHSuJ/JIINM/Gw73OLoCKueBpRMATFpD
         lGOrE/FFejqWg2++LyMlp/ZYRr7WGNJa01fHfT4ZmDk5SW/N6QYJk4INnU/7a/Vt7jJS
         W3/g==
X-Forwarded-Encrypted: i=1; AJvYcCX83+SrkWRILGYtYyKL/y53sjcFGpDhWnOXV6R9h8mUx+jy90hWmE6iGQRLOvCROVAopPNLn8+ahPzzfWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmgINfljLc7nde/0VUrOK83r6l+pZpj534TWQv4pIm9plfYS3
	gRM1zsaIPTkmyv9tbhlO0WgEdjey9/wDbZ+sZmxPWPJOJBdzyMwMD0htrNEXq9I=
X-Gm-Gg: ASbGncsOBFWi8u7imn3SO1FNWPtn7L+g/nJkoL0p7ZReRR2xlxStFqthUYudXofn61U
	GtcwmHAqejvhoqiMH+TH7EpGuJHOpTBG4/8LWU9YpkdpcDo8n+ninwyTMO4aYl9ngO4ofkCWEFQ
	JT6QyrJ15cT8r25bfC2ySgc3fHOzdBwSqdHXtOfOYjwMIuzn6Dj3y5fv8LcXw+PEMRqqE4bh+QS
	r7wSFnMkbLrfiTuMWwtVxWO12PxmxBtA7qFg33U3Y52YgbRIxQZlOXWrhPVxsdQbqqM6k0yckBK
	i5gRwGTXt4swSk5m1hEf1Ie4lapvtA==
X-Google-Smtp-Source: AGHT+IEAl7X75IiAncEt/phKEqkFqYtoa4WMTlsSJtcMFByYuTRg6SCQ3j0BgI9MU+tyzTVAw8Jtng==
X-Received: by 2002:a05:6512:4022:b0:53d:ed70:1a74 with SMTP id 2adb3069b0e04-53ded701abamr1046438e87.34.1732630934648;
        Tue, 26 Nov 2024 06:22:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24811b0sm2054224e87.162.2024.11.26.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 06:22:13 -0800 (PST)
Date: Tue, 26 Nov 2024 16:22:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhang <quic_jiezh@quicinc.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qcs615: Add gpu and gmu nodes
Message-ID: <b22n5muywlavttjo2iub7uijqbonoeifkqhrqlvfrqadiod3tl@l5mrikdtbyp6>
References: <20241126-qcs615-gpu-dt-v1-0-a87782976dad@quicinc.com>
 <20241126-qcs615-gpu-dt-v1-2-a87782976dad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-qcs615-gpu-dt-v1-2-a87782976dad@quicinc.com>

On Tue, Nov 26, 2024 at 07:36:48PM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <quic_jiezh@quicinc.com>
> 
> Add gpu and gmu nodes for qcs615 chipset.
> 
> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 86 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 

Clocks might need changing to follow the schema changes. Otherwise:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

