Return-Path: <linux-kernel+bounces-195687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96218D504C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1FE281FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA9C3D3BD;
	Thu, 30 May 2024 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyC29hpk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07394778B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088168; cv=none; b=iChYnXKFO6AsmMT3GfIcs6qN9aXP4E39oJcCahyHoYZAJj/xxqDVE55Zds383V7Gmsm5Oz1SC+PCM4aIt75WnfTR6wWg3zE/KnWOxphtHLFPAypkzbIKKGKM2Ky9cMyAIIUftb5SjL6U6zvsdHsBWLSU3b6c4EBcCy9IYu3rDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088168; c=relaxed/simple;
	bh=FNrmY43/YCzNI9mINWD2Oip2Z3faB3SaM34C9EeG3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rix7Axp88EBoY+IwsWLwmJZAsZklZX6wy3vfP56xTH5b3JqUdrXI8LeJLXPZ8/YoABTJDxo3QSaGwSxKNbJ9G09MBrZCNzoSWMVgYq1C/ro+2mXrS5+3T3rzrHD3ZoZpVVJ+bh8/QEeTVBNGj7tA8FK0qfsP8ysDawIscYx4Wbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xyC29hpk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52b83225088so400978e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717088165; x=1717692965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cIZAyHQuyLuODFacqdYEeEJFSKlS0O4NsDUdsqJPEQ=;
        b=xyC29hpkU8lb5bGyPHU+LV2WHOBHZ2K+zp9S93zTm54DA4visFwpvjQ2PI/lb/ZJIc
         pjoADgtuh714Ap86aZmUtR5XDDBajF1Q+8XyYJf3gsbiMFuE6rYiAKFItR/DqnjQpSW2
         ms4h8CbIFqK6PtUKuRoPFQ5stjfllJB2GnJxVju9JSbK64ajXpSDPpI1jCpGBD9p5D7D
         hX16oVcAegclQYRdTI58l86zKLYTjbHsuZtcptbq3GdHGQKaDrU8aR+tRzzSuNgq+xvX
         9AnwQyg9NLVPcs/0D1KHC6sBXWh+zBNL4VfqXrbtKTC5dMPvqYpFovs+jyvga2fnmdLT
         wldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088165; x=1717692965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cIZAyHQuyLuODFacqdYEeEJFSKlS0O4NsDUdsqJPEQ=;
        b=YvRj2y8YUwUHBeeKRR9T9voV9YwV3on5SLMh8JrJUBnrySHTHx7fWGkROWIwhGDPu4
         9HyytoROkveY0WJn4p7Xmq4BTWxJaQnEWHPnL4IFHpA/iRJAg4LIYqygn4qH83tvj0Q3
         9j2mCwNHcb3zd/zeGc0+EBqP8ba1VIZTcmB3qArrGN8ubi9LJBQR49b7GYc6MYDr5ver
         ymYR6zmMx3CYNjFrnKFKdY1l5s4m3HrwRNASshTSUlej2YIvWGaRKzqctVLGJp9Nyf+R
         rQYc1I8xrJbAnojyygas90gQdzBnlZB9wjovQhszT8ZU2weDrZyX7DEsKtHKDLIP6+VP
         1kmA==
X-Forwarded-Encrypted: i=1; AJvYcCUDSLeXZlLfxbszOv0HXE0mAxfOR4FiHumNviXvqisCCLqzYpEcDj1cujHVs/Zgl2fzzhjwyCKocyjWcNogxhBd57j/sJlQBYAi1C1M
X-Gm-Message-State: AOJu0YxpKALnvYBV4d45lXyHUJKW9JA0OyPZ2kUsHGKXd+W3j2190pZW
	y7KLGMU1VV9u52dOIiP8ucegBkNl0T+kw3SSojAuOH0RDzQMqBJkcG27dKb19t0=
X-Google-Smtp-Source: AGHT+IHE+Ow+K5cH0iKEEiLQu1RK9+EhmsE5q4RgF+Mo8KYrQlphENI6AkOOWkHJbu2VU2gveInE3w==
X-Received: by 2002:a05:6512:3694:b0:52b:7984:2333 with SMTP id 2adb3069b0e04-52b7d490620mr1600521e87.63.1717088164719;
        Thu, 30 May 2024 09:56:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d7870asm14601e87.136.2024.05.30.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:56:04 -0700 (PDT)
Date: Thu, 30 May 2024 19:56:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: pm7250b: Add node for PMIC VBUS
 booster
Message-ID: <zmid5knlldfg3rbp6xlanc3fy5siyddznn7cdryo57bwxk4ntw@cd2vkkuvstri>
References: <20240530-fp4-tcpm-v3-0-612d4bbd5e09@fairphone.com>
 <20240530-fp4-tcpm-v3-1-612d4bbd5e09@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-fp4-tcpm-v3-1-612d4bbd5e09@fairphone.com>

On Thu, May 30, 2024 at 05:05:47PM +0200, Luca Weiss wrote:
> Add the required DTS node for the USB VBUS output regulator, which is
> available on PM7250B. This will provide the VBUS source to connected
> peripherals.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

