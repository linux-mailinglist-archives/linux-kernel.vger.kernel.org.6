Return-Path: <linux-kernel+bounces-189532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5B8CF157
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3251C20A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86DB1292D0;
	Sat, 25 May 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJ3DRrX1"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB0127E2A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716668237; cv=none; b=FMZ36yU4SrgviudHO5dz1whAdl+F2MSyG+rPsre66u7SYgDxZMXhvBmwnZCJyi5es0lTUMdTXAAdBgNE1gzwsGy8Y2jK1DZB6417Y2NCq7kWgElAgQgNtcr/3ZQ9pVi3dUm1fMBt5G8zKLix4qQ91oDkeMCsYykXXq0+PDrB3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716668237; c=relaxed/simple;
	bh=e4iB2hmWqGkryypMY5WGSupumWJitVR9QfeEQAmfbtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK0jvrBVtYDz+O0A1CmeQYSXcWMXZTX75NKFxrU26/K3h2KjJaszQO8ISywwskbZ868b3B7BaA0Bjf1CWzCCeOQ1Yxyq79ZuwXVoJCtqnU4IVIjtecvqEAqZL79tVx4+OZ7Qeo9nDpBobhSRHKmo73xY0SEyGblnWmGyDfR0DoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJ3DRrX1; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e96f298fbdso3178241fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716668234; x=1717273034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SELA5GlB1npzSiGqvDyKxGuHXX9mh3K2r4rEuPeskoo=;
        b=rJ3DRrX10SlSS5JfjJWD6JaKCzua20jwy8AySs1cchQ+2p3z5FAgexB0EUVrJ8k7LN
         q09W2arvl5w8KO6hE3kBJuoYKLh92w/WezDwXNHxnj0cboxvuEcWM/pQ69W7+UEkGoNP
         6cxTBDlZOpPht8qVSTr2NWnhPxsJ4WpRRXrxnUCea2TNSQXfNnjTE02HRL3UVpQoJxx2
         VayNXJMf1PWVVqZofDIOP+prtjo/CBMkAidKEma5xWxrzTm3xNSejCrF8YNv6cPjGJBE
         QerFyMhsKxVDmAMHMVYNf3cFrweUpvDjf1+gHf/RVR9VLqPMJ3fHY2Xn6jdq3ZbeXcvX
         qEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716668234; x=1717273034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SELA5GlB1npzSiGqvDyKxGuHXX9mh3K2r4rEuPeskoo=;
        b=LwG6lBexzF6W/cB7gXgB38Id3JPReovSd3JG9ZcP40gcBWe7hUjPvaF0R4PgrF+dqO
         Emsvjxcd/9ToiNXCTWODCMD8/1kwjDoiRUamyqrSfB2Lb3MGHNUZ+S0kJNvmS/+TmIKp
         gfoUKn0oo2MdzbwvyZDmxReNwRMC1QD28WVhlTG/drSZLl+RsKJQ/Np4s51vvDQaYAHd
         p3Zkm7zq+DgZ4afKN9Ll7v5CzylTuhr/NDcCDLm/gebfgZIYc9OdTNe4KwcnvhrGWfpo
         vyUhoPmMkWDhI0y7JwueIua2v8eCQJSHBf8Dm/RHvZUhs5CXtAk/WXgsTz45yx4po60A
         6L9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk3BVuABGZ7wUqBlkDJBCKleJ0Q2y7tj+9fBDKuh/Rsk4++rfBe4YpFw9+fkwry7tPh/bSrL2RJh8uIknO6yGBbPf6SgDpKoCFn9oU
X-Gm-Message-State: AOJu0Yx841Xs84/aBf85g6KAqj+X+YLnjI7sSKsbv6jJ/WlQbAtSd2ki
	pYoohGrAL7jh8FyMef8mjPRhuCDJtqHAdq25tyPM4oyFYYKSJJTnyFTtj/2wNyVeZ+HTf3lvLWC
	k
X-Google-Smtp-Source: AGHT+IHxaWWgdxxG5Pc00Dajc8BYwzofGEJRg7u/AinnLu/2v1c6MdUcnFcvyu+PBrOQC+NZG4bt1Q==
X-Received: by 2002:a2e:a556:0:b0:2e6:fd20:2982 with SMTP id 38308e7fff4ca-2e95b0946cdmr40028101fa.3.1716668233787;
        Sat, 25 May 2024 13:17:13 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bdcd234sm8791121fa.99.2024.05.25.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 13:17:13 -0700 (PDT)
Date: Sat, 25 May 2024 23:17:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Drop ipa-virt interconnect
Message-ID: <5ck2cusj3tbhoo3h3awgyi7oigh3kk53rzlu7n3ltczp246ff4@mqmvgkq4yoi4>
References: <20240525-sc8180x-drop-ipa-icc-v1-1-84ac4cf08fe3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240525-sc8180x-drop-ipa-icc-v1-1-84ac4cf08fe3@quicinc.com>

On Sat, May 25, 2024 at 11:07:05AM -0700, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> The IPA BCM is already exposed by clk-rpmh, remove the interconnect
> node for the same.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 7 -------
>  1 file changed, 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

