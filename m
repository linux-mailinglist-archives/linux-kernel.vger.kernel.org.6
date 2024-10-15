Return-Path: <linux-kernel+bounces-365843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A795799EB90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D904E1C231E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827A1C07FF;
	Tue, 15 Oct 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyiLKfPp"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8F1CFEA9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997701; cv=none; b=GohkglABb6liuueo1U4nnSvO21F6HldDzSNP84QEreDHQ89r4HSNpu+jMQZrPwz+ejCt8ggcIuJDHTGqw8HW2Oo+tVc7IwQ83oAG5Vlbi94rIjdLGT5xiQF7losAZrNp5x1C1Fz81/CsvnXUNS09l7Ns0qF6vcKU4lnFf5PI3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997701; c=relaxed/simple;
	bh=nGUgaS3xSqIDmh8hU4JivJzlEHXiIXok89af7BxXPcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5ZCOMEiNSB82axhOPqNNxJfCdskgNd2KM/j+GOLEFynnDj4WTGaxokRKdUJXufQA6q948fcNF7igIP0I4etkmxuFQOkh+YQv9SynMrdZexRsi1LRaqfVgj/BO6CvXBk3lLY4yn9XN6RHmPvS8pmotHbvi+9iZnTm1jCUokdF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TyiLKfPp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53a007743e7so721924e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728997698; x=1729602498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrYegS/cg9zWrW4IjkZUnQE9rjlPUwUGC3VKtBGsMag=;
        b=TyiLKfPp32pz5wSuayFx9M+L732xmvp3i6cdZCgFX4ZOeNf5wXVdxzUWNdIvvGw0Ez
         Y4EJZMYSPwy8CftpfMwin7FT4huXg6RoLDhhxpcb4t3MN5BjfW8KIQu8uAbMuP1f8Sm2
         NxcKqTfwYiG9Z8MtKAJyQb4jOIn69Px426lPTiWVgOneUzsky1mvQpMPjmQu28lpXjMV
         gG3HVClXuXhozIxiwBlR3skVw7o06wu9+5IjXhugl4txC5638hhBIKaH8KPCIykMiC0d
         W5kAoD422SaOOrIOKTRiPDNVjH+3QgZxgNzeiZd2sA7HjELl09wDn+pClogxrOmhbFUf
         TlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728997698; x=1729602498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrYegS/cg9zWrW4IjkZUnQE9rjlPUwUGC3VKtBGsMag=;
        b=BMhUYGkB78W4hmWAFL4WDmtd7qPeijfQm8Se/u9YWIvA0Et+ST8T3Pf0cR/SpJMuYb
         Stz7/8c+ffMVEFM7iuSq/7qd4a3n2ht8x37ZkRXTiA+1uHFo2rv+UiZQKqtuP+cTxYM0
         4fQ/Cik8k1DF0WYT8aM1acU716FzHbnjEH62Vh6AwHiiMH3fOwlwlm/fkovgS7zgkQjO
         iZ06HTcroX4FVo5CyYozsNL069IQ4cR5EPpJVc/6zMr2h6A90d+UyIfJkXfaGlGgmNZq
         FoKaxhyoFPstVGzybzcUC74TlVUv1otDnnyX0N3lscwUdjyuelZCjy9jWZXN7pbcMjFJ
         4x8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWICSFoxYXQ8PBXoj/jQO5vXm4DQNPzSGYYZwA7AC1hRfe1tAoEch79K3qqfmqMpdB+JO6YUk+YTmdTQ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Qck7CnlLRgJbkhV18b8QwpDCg9MSc6CMaF0I+i4/PVL5t362
	xA5KW0EXX+cexlqScbvzVgr2EZVYw0hmRlkYqSH5YadlkssYTTCYey2zI3YAKh8=
X-Google-Smtp-Source: AGHT+IEiNt9jcpifpSJ4xTgDlnr3L/ZtDDqDq5h+H8YO2Y8dPiK0O/PL8SlRc64Fnhh2XiyRLqTPfw==
X-Received: by 2002:a05:6512:2352:b0:539:f7de:df84 with SMTP id 2adb3069b0e04-539f7dee17amr3532200e87.10.1728997697532;
        Tue, 15 Oct 2024 06:08:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffa8e92sm168284e87.15.2024.10.15.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:08:16 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:08:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: rename vph-pwr regulator
 nodes
Message-ID: <ofrnqmnfy7tj2myngfplhycwmm6kyv4guwjlz2vuzc7gd6retg@mleqzgzft24x>
References: <20241015122601.16127-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015122601.16127-1-johan+linaro@kernel.org>

On Tue, Oct 15, 2024 at 02:26:00PM +0200, Johan Hovold wrote:
> Rename the x1e80100 vph-pwr regulator nodes to use "regulator" as a
> prefix for consistency with the other fixed regulators.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../dts/qcom/x1e80100-asus-vivobook-s15.dts   | 22 +++++++++----------
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts     | 22 +++++++++----------
>  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  | 22 +++++++++----------
>  .../dts/qcom/x1e80100-microsoft-romulus.dtsi  | 22 +++++++++----------
>  4 files changed, 44 insertions(+), 44 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

