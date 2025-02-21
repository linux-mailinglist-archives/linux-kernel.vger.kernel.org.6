Return-Path: <linux-kernel+bounces-525896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0780FA3F704
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4EC861393
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D07080D;
	Fri, 21 Feb 2025 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfZ/XAiQ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780E1420DD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740147362; cv=none; b=XHcSMde5VUWP0W4ZlS7s54jlxnk38Nmj07WucmIT7Xj4Lm5S0Z6OpDRYcOrg6oO+FrB9VSQfKlp11J2RaKyrY1JR48dV+KRlh4cVgrvFCuhq1aLWde5mbYePXq+9pTlVf0V9WL6EQj3AaL5CCXPWLe5VLA3NRSuxBOd1Qz/l+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740147362; c=relaxed/simple;
	bh=YL8jPrvdUOfB9pwVp5vmJysM82GiiQMfRYQJGXragaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGOkSo3bn25ca+0nnkgf8N0yWl28V9Iq39c1MymV06JpR6yQKcFNS1haYRSeoqTybHdCA/9geKkRghYzRqJHNy2RfEnPsjeC6NNIqmiJCtYK6/pI8HH7VpQjt6QKMnReYEwLG2pah7JiRQNRUJlq4QC5wswuEM5A4yHErfPQru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfZ/XAiQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-546202d633dso2257301e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740147359; x=1740752159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bqdjIBWXWliY7LxOtFti2ta/kieZvqtrvhn2QZYRayA=;
        b=TfZ/XAiQ/dqVQYV+db4LvYrIxxwDgYox80u9LDOli2xH50N0+fCmfyznBklgdXkRsf
         LM/+Tpioub4av8+aOSGr8Z3o85VKcY/+wrJk6wKnN1ERvW8WsOmUzw6alSywzeyMtdzI
         UZ2ZXBio49v5oOEmJjbsAWk0+ZoCCjffFqjYKk42Z4mXkGniSo49F2lMoQyShEVbOZ1x
         rMrngwfqDEwrQtgHOwgruFyCyQhPr5pi9sR7ThTfg2kJZWvJcKCo7HdOgCAtJB/D6v6D
         WSqUd5frdEjTRrdP2j+Ddj5j0PShB/Zbw+BgYhSQXlqobXqb067QxhDujTV30fFa2di7
         WZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740147359; x=1740752159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqdjIBWXWliY7LxOtFti2ta/kieZvqtrvhn2QZYRayA=;
        b=HedmU98ODX/gybT9PhenMKl2sbkBtlyPf3HGHPipuhPkFd+iWuwQyiNR/iMeHiRJVD
         jfsL4g/RvBqkODA6THQKSAm0o1mNroa6te4TQmnURFHFXlSHW6YDOOwtY6YyDyns8eF2
         Wo7BPD06hYCVvqrAhc7OoTDUhX/+oOIzszLnYwAakXUMHrZ02v2RcjI9AMJ8DS5hWlys
         Z849hh+7OxGvUlQUVXFSz2iFWI+KXg8NCta3CfcSyRR9FguTosl957G8c2bLjUaz8W9t
         vvoIVGRJhe47io42S+qX9UR1Q5PPUrYlrH/y9oZFCJF/t3yX3Zy9lqawAPttS9XyZwYO
         YhKw==
X-Forwarded-Encrypted: i=1; AJvYcCXWa9VCV6urswA5RZTslzah/pwfzTdEBWG+q741eRhlSYJUThY3IBF2+9qBtm4QnHmLQzT2qFBkHcNvWu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZsO+eRF1/ZjgfQ+TA912DgbgpxOTLUHWCLwBebfHSKelHm+t
	x5mf6yPmRB2LwmD68JSyp6rPpLVThE+x5N+/L2V8yyt0fXdxCoVsfIG7tiildHA=
X-Gm-Gg: ASbGncte7C8+jTBBIpqXO3eaoighR75SKAJjxx1+PRAYGZ7uRtKQ7Qz/74sStnFtCTK
	lSdd/hASg6bldb2CyysyVNGQmmrc8T6dHD5WOs7cF5MluFTBlMXtvJL1JHHD6nLofpGFnyepsxR
	oTO0PHxv+6ovscoQmpDSskumh6hZuKrEWrGcgYpwOu7+HJjFTZlQIJbxKBB8xbPaRv0k8GM1tVP
	1i65LkPpJXRg1w/DWgTnWNA9Ljiv4LYM6/Lwjvg7008lDsZs5bDF3W/1RxDY/g4nFtP9z0t1Wf6
	7Ji8wgRx9SK+uDfBP91oEv1WpjSsawtGKZ4vbeTRTjx9XHpsssEPpkzwlP3CZITMYOskOwBhAhq
	o7bcthw==
X-Google-Smtp-Source: AGHT+IHxo/Z2Vypj16VF0GmKYfWym8LubvFupfQd41+zMTMPmL04EgeKmlFfU2NqFPOowvlrSSrsuA==
X-Received: by 2002:a05:6512:1305:b0:545:764:2f8d with SMTP id 2adb3069b0e04-54838f77b46mr1359150e87.44.1740147358594;
        Fri, 21 Feb 2025 06:15:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530b2aeb3sm2115666e87.175.2025.02.21.06.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:15:57 -0800 (PST)
Date: Fri, 21 Feb 2025 16:15:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sm8750-mtp: Enable CDSP and
 mention MPSS
Message-ID: <7ge5bnzqggaeoyme57sjbchehdla5icblyjc6jiop6f64bfk5y@gobmmlvp3cie>
References: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
 <20250220-b4-sm8750-cdsp-v2-3-a70dd2d04419@linaro.org>
 <dihnqsdjqxq7uhomceeiejey7dezfyvhpnyc3zyzhyuyfdjtec@d4ruo5xbxid3>
 <e4630796-49b9-4a09-b511-fffff1352350@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4630796-49b9-4a09-b511-fffff1352350@linaro.org>

On Fri, Feb 21, 2025 at 09:38:09AM +0100, Krzysztof Kozlowski wrote:
> On 20/02/2025 17:19, Dmitry Baryshkov wrote:
> > On Thu, Feb 20, 2025 at 04:44:13PM +0100, Krzysztof Kozlowski wrote:
> >> Enable the CDSP on MPT8750 board and add firmware for the modem, however
> >> keep it as failed because modem crashes after booting for unknown
> >> reasons.
> > 
> > So the modem crashes on MTP, but does not on QRD?
> QRD was not tested - which mentioned in that patch - and I hope someone
> will test it and tell me :)

Then it might also be broken. I have the same situation on SAR2130P,
ADSP works, but CDSP crashes. Please separate modem to a separate series
and clearly mark that it is not supposed to work. Until it works on any
of the boards I don't think we should be merging corresponding driver
bits, which are known-broken.

-- 
With best wishes
Dmitry

