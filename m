Return-Path: <linux-kernel+bounces-510884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D18A32333
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C66E7A4A04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23AD2080EC;
	Wed, 12 Feb 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsTHGA0F"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CFA2080EF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354758; cv=none; b=MaSnGTkxGG+b2gz0+tyv8n7IOVlegRGpb1TYQMMAM6TBHerSuPs7BcRTaDKz3dikAaXdvXx+RIDEeLe35LQu3Zk2DZUJ4FB2YOknS1kEHZf/Tx1XsrdqROZT5j885Kvis78crJ8Y76fFFNhwKFhfA+3oj/eXUQouix1E7mCBLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354758; c=relaxed/simple;
	bh=EHsJvTqyGwhk3LqjRdMjJz1ojxkbMBNLqjWWV/RXQ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBi2yUbtb0ceaPh8FXaVpk8ODvvcLIPgw8M3gjT5zCIEuvK1qZQIpM1d31UCxwlqR5LlPaZ+0B4eDM1P1rubZNPSATpnxvBJMuC1CBtSv6MObNcyOiB6dZTofE1wRB1BTLPNpMnyiIRbU8B75uZHEB7sAPK7SmhDUESQwHzvmnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsTHGA0F; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450622b325so3928100e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739354754; x=1739959554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVn+uPBQWQ6NpvoZYnq/I1sJTX4u55kbRPPlDvjT25g=;
        b=QsTHGA0FFO5SkiyXDgcIraOuPAuhwUo3QmqBqB32Xk3n0pIRS7b69gnwJ2sir1QnLJ
         TF5NfRIz1EjbY8s1ZG6kRfpMBvhzs8Aa8ygqHls/2BmCWw97KSaaPHYvwUnJl7iEJf/h
         Nb38iD3zf08pAZ9jknpLjTFx9c1Jmok5oUKyH8PlzZoe4RgHW6Y6mGDgzz3lFthG/2iV
         4wtc7oi42IizS2dSRMh9X+Mn/K5AZM08vKVy+YCWx3CEIDtqP0omUxNjkG4qePAiYFaj
         o1txB5d2NHv6nICRL3yrR5NAiCL0Gvam9FLa6QeY/p+6XvgD7r3jljvqkZA2EgInaHL9
         lqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354754; x=1739959554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVn+uPBQWQ6NpvoZYnq/I1sJTX4u55kbRPPlDvjT25g=;
        b=woptpIBws/MFeDlDDe5+nBWV/KUtKDOVeZEjd0eNG9PuLHN8l74XDxa7Mk0/Phn4qA
         O9jA+UH1FLkxW527uI4I7tacmV+FbuiItE8BrK5D9ZYEhAHZNR4BFVlgRREz3McadJf2
         uX4ratBzPNzoB6I0l1nmIqPLxTUsyT+x9/wSbBxqppevDGgD2fqKWZ6Ucy+P7XVZ7Nyp
         TIfRwdPsQU9XjaeSDUhrLlEwdeM8AgJCrkUIOtjs/LVt05Q5tYdKep/F83sBkwMVtOoV
         ekmIc6CQnqnJaW3NfonrNKKzrnZz8kijlCd0pLHUqDhXhbW4VUO0jPes+8mggrXmygxj
         0qsA==
X-Forwarded-Encrypted: i=1; AJvYcCVa/b3ov6mH18AOJEBFexqYRHcV7LsARpXHKL9nmeqgM+cScn5iQ6stYhx0A+cuh8Cb+Jt+zUjML9Z1tYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rAVUWxp4nyW1ncCbTbOxn6yvpLAzx4Gq0bCY5KtNezf1Vd+b
	+V8Nsc9RKyiUdqfnyoXgBOKpW2OhxWcw2tSkeoGFJz6I06Q+JL5XKWb1WcKFyaM=
X-Gm-Gg: ASbGncstYqJ9+fV/CcUeR2JAp4W6L48D2Da21iLxLrEvUGNeGKdpcqbePQ6vlQL6ZYT
	WzxORymbw3XZpjMnQm4y460zfGJ9v+46imfB7p3DvsP8qfJR66bZeFKFuHfAFTM7zFJ7HiPl6O7
	KAoJlBZ4YbdW90O02J2u2M2fkBXsLFGje0Y3JDNxDh/o4UwyS7OlkiTbsNK++tIqeAwIMS1aKae
	2wvTuSQb/J16x88xd/9XydYz9cxXfywZagBIbKN+MyD+EgWh5eRcD8RaEAkUpe2FESkzmYJi5e6
	VYqr0fiDE+3BTGE2LP6FsxyEQsttRKZ/ukaXFXvLOVVnisRi/0Mch4dNI3dxHhPy4qbfgr0=
X-Google-Smtp-Source: AGHT+IFcCCjr2F4j57iyCku2KMNTSNmgSM7kl23BAa4v+symeaOyRKmfomba9eHHUlGd0C+dHbaR+A==
X-Received: by 2002:a05:6512:3c9c:b0:545:bda:f0d with SMTP id 2adb3069b0e04-5451815a1ccmr746030e87.37.1739354754502;
        Wed, 12 Feb 2025 02:05:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54410555a3csm1825349e87.78.2025.02.12.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:05:53 -0800 (PST)
Date: Wed, 12 Feb 2025 12:05:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yongxing Mou <quic_yongmou@quicinc.com>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 3/4] dt-bindings: display/msm: Document MDSS on QCS8300
Message-ID: <emfd4gqstixawba64mywtsitbek5srrekoute3hjudi6xhfjhl@7ndrv3ua7uei>
References: <20250120-mdssdt_qcs8300-v4-0-1687e7842125@quicinc.com>
 <20250120-mdssdt_qcs8300-v4-3-1687e7842125@quicinc.com>
 <e620e80d-afeb-4ce1-9798-2f5cdd92b3b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e620e80d-afeb-4ce1-9798-2f5cdd92b3b1@kernel.org>

On Wed, Feb 12, 2025 at 09:38:07AM +0100, Krzysztof Kozlowski wrote:
> On 20/01/2025 04:49, Yongxing Mou wrote:
> > Document the MDSS hardware found on the Qualcomm QCS8300 platform.
> > QCS8300 use the same DPU hardware version as SA8775P, so we reuse it's
> > driver. But QCS8300 only have one DP controller, and offset is same with
> > sm8650, so dp controller reuse the sm8650's driver.
> > 
> > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > ---
> >  .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 244 +++++++++++++++++++++
> >  1 file changed, 244 insertions(+)
> 
> Also wrong compatibles used.

Which compatibles are wrong here?

-- 
With best wishes
Dmitry

