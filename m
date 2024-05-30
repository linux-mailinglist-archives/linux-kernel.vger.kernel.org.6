Return-Path: <linux-kernel+bounces-195701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 443198D5074
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A1728944A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A5433CF;
	Thu, 30 May 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PH7rV5EQ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390683FBB2
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088699; cv=none; b=QZE42AazCTorw7h4ZWaZSlN8VnWzT6QRvGPD1af89edG1avOmynTJHjh01kwiL7SDfUefNLFTdJQvhB6Y41csQOH3QOZJiLd9HW0N3zLfTL80FE3lQoVXAcg0Cj+vrrWFD5fRYEBi0AgSuKng/iPvMtW8GKOut08EHPl8wOsMUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088699; c=relaxed/simple;
	bh=DAtbp+Udo51/ggghY8Ta/nQKZ1Qn63T/N+XvPyQlNIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vld4/vcg7KHeQG1fgu8UQk9zEx+RAo6Q4AUhQ0XMp6Q1N72O3lDaBxl1iCMy/3IHccr9PMQ9H9vuoWsMiWF1xd93VCXuWbwIgcMMpC/eZdnDN7I5ut/FRJoYbB1knaLFvVh8vJ+gDZeo+0qriTlwdpirKgQrtwnhKeU7O/dnrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PH7rV5EQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52b6ccfdf28so233695e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 10:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717088696; x=1717693496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqM5oBlvWmtQCy/vmQxQErg1+TLSJYV7HsRivxfdSao=;
        b=PH7rV5EQX9zjEQIF0t16yyaSQ+rBaT+CWhdOjroUum1wApUpvqRIsO39B10BSNoeKy
         Zcebm/rE0VtbuHy/FYxnrsUSXUbRsqihu0N8z1h1II4TByeUhLNdffYd+syZ4KJpVds7
         pd4cM7tg1kDou0alZfwcmI5UgA31aHvmqR/XUmADZ6X9Q0ZYsStLbU3470Uu3kRpsN9O
         BlKW9cm6LZpiyrKOJLEt4K2xjY4C/sLFDxbNGHWjo17V5VVh8NH2QU0JYTgni7CSrFGg
         9GOE/uSdY6LzQJKO1gVuroc7Ar2pQvq5z+8AlK9FbvMyuyAyNDrCjlUr/hWXhbFmtYIZ
         KXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088696; x=1717693496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqM5oBlvWmtQCy/vmQxQErg1+TLSJYV7HsRivxfdSao=;
        b=pcVTEVKN99dmOoH31KCtRne1hdWotaIKZBbxEdaa6TBZCgihWvZb2b9QfQakAu8sd7
         TVAYH8AFt3B4WJxKtuRfBTfB7WswHZpE7GsO/70qYJS+B9griCKBTOr7cNphSG+oSLr0
         d0r66LGyqy/kxXntW4OkH4C1Xq8vfd3AyinGr5NWYqmj9HxfqnY4Ima1LztO2H5z062X
         ePNRtv2Es/ENPaQYk5zc5Zs9QPoZ9e1vVSn5LbSYsPKDJtzKCJKiZTBI52DA+uqsE1pE
         X2muKZAm1mZXwsLRwsiR4ZbUcEFgkc3GFObECSlEbE6ei1CzSt+TshSIAZk+6hngNWes
         LLnA==
X-Forwarded-Encrypted: i=1; AJvYcCVlOOhwF9d7XgTTO2pvgV6LMSnZUP/EifP/8EC6O/53eEcvf8DD5gSQVUvSExmFx86/WS/uVoVYv1szahJeW9x0sdCNC8UNuWK4p0Bh
X-Gm-Message-State: AOJu0YxFnwtzNWUJKZ/gYcoHakixX3XMCOvoy0pvaQz859J8143+qrHk
	1OseWMT8j5Zg7heVGPw1DbAZX1TxpdoOdrv+Ec60Cbzj0bNiAP0ao23jlsPYwO8=
X-Google-Smtp-Source: AGHT+IE1ehckPaW3Xm4BfgQOz2B6cKjcXdpFlrcjgJ5MmxIm0U32yV97sJl9mZHeHxviYNkiJCitEQ==
X-Received: by 2002:ac2:457b:0:b0:51b:5c40:da74 with SMTP id 2adb3069b0e04-52b7d418ed1mr1803340e87.1.1717088696524;
        Thu, 30 May 2024 10:04:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d3465asm19038e87.44.2024.05.30.10.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 10:04:55 -0700 (PDT)
Date: Thu, 30 May 2024 20:04:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: Fix USB PHYs
 regulators
Message-ID: <qn64iunks32jlaevjdr5lsdpishsk7cmygdodpekdkgwtwxt24@6oy4kfmuqgo7>
References: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-0-6eb72a546227@linaro.org>
 <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-1-6eb72a546227@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-1-6eb72a546227@linaro.org>

On Thu, May 30, 2024 at 07:35:45PM +0300, Abel Vesa wrote:
> The 1.2v HS PHY shared regulator is actually LDO2 from PM8550ve id J.
> Also add the missing supplies to QMP PHYs.
> 
> Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

