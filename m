Return-Path: <linux-kernel+bounces-352568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643D9920D8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004712817A5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163EB18A956;
	Sun,  6 Oct 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBReU6W6"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8F165EED
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243940; cv=none; b=u/7P2g8e+NExUU5y4kyK8G9v3nu83K+gHK5hJzKCIGqx4a/bZmA2KQo+0cigwPoTK+66GDRo+Y9GRIsRdNCl1OXUnr1HRVVP+VSJcqJ+Un/JowRK99zXOf8qH6cKsQuKNFgFuufo2hnSi4E/shJB9g95A9aiFpN/+6d7jmgSNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243940; c=relaxed/simple;
	bh=gczS1H8RCbq/oSB66R44ifTocw2j5ELoXjzfzM1JX+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6P+BVgVqTk7rCh6jI9Fkyk96Hj921P2j5qqWc4Jdx+/RKwlnLXY544U0Ec0eP4l6u0dPatRZanc+sL8u/R9AzP8ONExaxBm1i2IKSmr7P69YKEXfLb5hyPpjBmyIOS7KvBFlVrcMm0aA2nCpbxaGLVOKDcOGQogqPmiNRkN5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tBReU6W6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so4532257e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728243936; x=1728848736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPMa3wRhVNb5mYhrjN3uRQ7odnUdYC8uDGoeGsan3nA=;
        b=tBReU6W63QatRpiBSQEpr3RrLodlFREYNPx5zP4i1Qy6RMXGMdTQR95zppQr20T3Uv
         shOG3KsYiDwzveN607KpD6HS0fB20F5ngowH4AF8DMJqbKa/DFCWh9itO3/utzliz8d8
         sKwfemdmYN2tsb5OYl9ViNZ+Y4QxoM/b8aOi/dKlaJZWbrIAiwPnc8g4FCMQkqBi7lKO
         3+Jxha+7eVityTMpCH8V1LypN875Xx5Q1eXVBHXtsm9ottemkBdVeBRqWNMYa+lxd9rs
         d2LrhxF5JUkK5z8klL8w2ARbhFKA/FqDlwYD4HG5ZP6svaM6FVisxNuhCc6eAqzgWMm4
         7/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728243936; x=1728848736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPMa3wRhVNb5mYhrjN3uRQ7odnUdYC8uDGoeGsan3nA=;
        b=EaWzZ8GukRv97WrYXt21V8C76w5/UG2qmLbwYKy1vTBM4nL5Xek072ftDtl8bzHyoe
         jxOTnLpUt1+GF3cOeMYAXJ1YupfD7xh6Ms0U5HuQHwDfukLnPViXS0Qu54N/UjE39/HF
         GghfnpgajGqeW55MzXvD4GSK/tVU/pvnbGCrSD061ORAweGISv++pIqd/FVO2So2Kdy8
         N/pcxKA6NTfDFmQf9T7YHxhx8ozcP6NAupUhkE9D5XUCp4q9bKoVgw6eQ8ltajGQSPYv
         SYwOxGsFWGVEc4K/XBq12LfTblUDLGXJVjxGf6umysune6Ql9nliA/jo090s5ywkIKs2
         bA/A==
X-Forwarded-Encrypted: i=1; AJvYcCXfZxH4IYdOqevbsZiMOAynOGkPp4I7TBG+aWHIyWfWVbdD1zL6O9BRwmagrxGl4ftI9wmehU9W1eneC38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYvH2yd8Ok20sMzEo+oHSglkoJH33ifMgjFK3s5aDXs9E+8CXJ
	cQVr8AAxvu4xOWfs9RRAxSFYAVbjZyJ1mtafygnEdku32oQqYRdap2ENoSYojwI=
X-Google-Smtp-Source: AGHT+IECZeyJy7q7aAhf4eqzO/46/Q8wdvSrEncRmYOG1aRnfFDqISQszpWAxx60b3qYA7t8pNewxg==
X-Received: by 2002:a05:6512:114c:b0:533:4477:28a2 with SMTP id 2adb3069b0e04-539ab8780damr4558781e87.16.1728243935636;
        Sun, 06 Oct 2024 12:45:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d2f6sm601611e87.152.2024.10.06.12.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:45:34 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:45:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maya Matuszczyk <maccraft123mc@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add debug uart to Lenovo
 Yoga Slim 7x
Message-ID: <pl7ixe7imgbajceyrlujyilnsd6442gywjn4pft2zjpboqofug@xnj44uujaoqf>
References: <20241004192436.16195-2-maccraft123mc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004192436.16195-2-maccraft123mc@gmail.com>

On Fri, Oct 04, 2024 at 09:24:36PM GMT, Maya Matuszczyk wrote:
> This commit enables the debug UART found on the motherboard under the SSD
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

