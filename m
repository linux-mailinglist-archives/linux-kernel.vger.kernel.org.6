Return-Path: <linux-kernel+bounces-426165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C41F9DEFBD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F175B2815BB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB731552ED;
	Sat, 30 Nov 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8wdfpN/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6E14B97E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960668; cv=none; b=BSOYC4rzz6cNB1DxZpOLQ1ew93jIbPozOeuPqEq8otmkrj8lbcomItAy46einDfBNWfC/VmFf2JrtyD3m68YCH7a3FUxW5voIvSoFUepe0MO7e90aCGQgEDAhJBs/DbRwu6NEIVvsRTDp0h+KbAaCW5rW70wIfAhXJvFHlVe5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960668; c=relaxed/simple;
	bh=YIBpB2xE1kqIfJ2YLuejnuVyeiazkUuFy0aLl8X/CHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktO4SOyb0TtOyqksr68OKtnq6mH/Moy9bhbqytahKUlemRahHoZDRLTZVzUaD0Kqje0fCosX+WvvNB3rmI6pmnJQUmj7STSnN3Ap+7J7NLPRbgbd35r5cytf8QAAk3mZZCePPY/AKOu5pxjI84JY43tBON/gpTgms6DjJzD2rfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8wdfpN/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53df1e0641fso3007044e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960664; x=1733565464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhYxiSJzuTPfKXgE0zJrJ7ilcsRu4Gvm8cOkR8Pij8=;
        b=j8wdfpN/npsp7D6THdpQLH4re3jJ6S1JeDodbcVXr7e8k6kz5GozCXw6pva80f+Ois
         OWH3SLULFuM8wn1nA1IktEVD/PhaZF33XjufS/n/Sd7wmKEvqp8VmTEnLvuOrZiJhar8
         5XeQKA9cEgjWZyt173qYDqiM6bwoCC+lKlEywXEjUeO3YB5LAvJ/XsAsuXVcSRrdIhMt
         V0U1/mAdcRw7VJPmpz92H7JAXiP3Ck3sHIXkfrh4V0wXd8v9d49jBTd3GpFAv+tRnHzd
         1HZ1zjlu2uUwQGWl38zjMQgOMTN+2UkQZemNwkPao3JUA3zKXa3boWLDCnXNi800qNQS
         bPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960664; x=1733565464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayhYxiSJzuTPfKXgE0zJrJ7ilcsRu4Gvm8cOkR8Pij8=;
        b=fQP3eLZFo9kXXt00NFzrYhOKdgnWjSeitF64lCiNdMMEsSudCiYXHw0He906L0Ffj1
         RX3x3Eu44XXGtx2WdYeFP4j2l3xm+P/Akdo4uE7AbFHAoFr+rFhc7EUpHm/QM15dFZB1
         z9KzVmiyjPfyq0mT78VLZgpB2NeyyQc9jSGtIwoYywS4+0WF0agKSoVBJ4ud5GVAOyh6
         HrBQb1e8cnKkdIQA58weJX6ZBlRIHOVP2LYcrfbqGTTtQHIzDQG3VO/G9FLUTJaFbQrL
         3nZFymk4YDig2w9DWTHmYIbottsxy1sA/44ANLummU14/HBBrkvVL8Hb1zCiW1hG0HZ2
         CwPA==
X-Forwarded-Encrypted: i=1; AJvYcCXmflrBND1Vm8Q3O6WyjQbNI8N9JuLQBTw78qH5GEWMxRo0kb8x2YlpyYcfHrn0GACA3IXAGxRNo8Q/Hhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6S/yf0krJ6e23YoouXLlHAPPpjmlstFqWatnCQ6sDce3+V21G
	ulzbffjZGin5eM5ChoUszAUB3k3qSZftNnEK3qGlqeYqeGD1WS1sDmkNVhOTjw0=
X-Gm-Gg: ASbGnctA+BvN790bN8ZEet3jguLIaMKFM5oCBS+fa8aHZ/pMClq/FPGw2KS7WFOhHcO
	PDfsjU2ulGGta2p0UELCpzJPaefMxGO/BD/Om6kAI66cKcSoU1DFnFPxeEsFD1d+LE00M3D3V5/
	HLXjRDgaAqoeG30xamnIuaBnuKJCyaxEWOWo2hiwHg/bbxjrnX1CGaTgmdfRTJetaEfNQmauLxV
	7BpmNz5OneCJAZqZbWZGQpDKHgUeNCj0H1Fq1a2ksXRrgtWzN1uaEsw0ZUkTvdfVMVx1ToDBIE9
	Vd76OmKGmIQfw1XJhrTlpXSpEPi7yA==
X-Google-Smtp-Source: AGHT+IE0kaUxRUyiwhzjR7KOYu9LRoA5PMpmgImUKZcJzs4qoeA8sIkGUNfm6CoNnOx71nPvgxUmyw==
X-Received: by 2002:a05:6512:3e1e:b0:53d:a9c4:9ed6 with SMTP id 2adb3069b0e04-53df00dc9a4mr7704840e87.25.1732960664465;
        Sat, 30 Nov 2024 01:57:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6431858sm723340e87.35.2024.11.30.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 01:57:43 -0800 (PST)
Date: Sat, 30 Nov 2024 11:57:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Joseph Gates <jgates@squareup.com>, Georgi Djakov <djakov@kernel.org>, 
	Shawn Guo <shawn.guo@linaro.org>, Stephan Gerhold <stephan@gerhold.net>, 
	Zac Crosby <zac@squareup.com>, Bastian =?utf-8?Q?K=C3=B6cher?= <git@kchr.de>, 
	Andy Gross <andy.gross@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, 
	Rohit Agarwal <quic_rohiagar@quicinc.com>, Melody Olvera <quic_molvera@quicinc.com>, 
	Bhupesh Sharma <bhupesh.sharma@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Stephen Boyd <swboyd@chromium.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Martin Botka <martin.botka@somainline.org>, Jonathan Marek <jonathan@marek.ca>, 
	Vinod Koul <vkoul@kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Fenglin Wu <quic_fenglinw@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
	James Willcox <jwillcox@squareup.com>, Max Chen <mchen@squareup.com>, 
	Vincent Knecht <vincent.knecht@mailoo.org>, Benjamin Li <benl@squareup.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/31] arm64: dts: qcom: ipq5018: move board clocks to
 ipq5018.dtsi file
Message-ID: <zdhevcnj6gszvaayhu2dghubwm23cdoyeik2dcnqo376gcstnz@xv46iu6l6yvu>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
 <20241130-fix-board-clocks-v2-20-b9a35858657e@linaro.org>
 <83990b97-3f37-47f0-9cc6-fdaa730a8df1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83990b97-3f37-47f0-9cc6-fdaa730a8df1@linaro.org>

On Sat, Nov 30, 2024 at 10:29:38AM +0100, Krzysztof Kozlowski wrote:
> On 30/11/2024 02:44, Dmitry Baryshkov wrote:
> > IPQ5018 is one of the platforms where board-level clocks (XO, sleep)
> > definitions are split between the SoC dtsi file and the board file.
> > This is not optimal, as the clocks are a part of the SoC + PMICs design.
> > Frequencies are common for the whole set of devices using the same SoC.
> > Remove the split and move frequencies to the SoC DTSI file.
> > 
> > Suggested-by: Bjorn Andersson <andersson@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> This contradicts DTS coding style and all my existing review. Obviously
> that's a NAK from me. If you want to merge this patch, please kindly
> carry my formal objection for this and all following "move board clocks"
> patches:
> 
> Nacked-by: Krzysztof Kozlowski <krzk@kernel.org>

I'd kindly ask Bjorn to chime in as a platform maintainer.

> 
> (I'll respond in next patches as well, just for formality/b4)
> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

