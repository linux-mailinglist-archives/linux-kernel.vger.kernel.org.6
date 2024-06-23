Return-Path: <linux-kernel+bounces-226453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA87913E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF701C21025
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3722B5A11D;
	Sun, 23 Jun 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9yCtxVn"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380512E63
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719178436; cv=none; b=JQdywVIbpkq37qijD2Nk3puRC71geLqAJ/LnxKk6kZm54BJGBL++NOg9m5cVzAqBBqXDegmMJZJRGtKV/QOuRJg9zrbSYY3WGM/a1jGq6FTWDYQYxnz3Dw/k7c91ti/SPjE6CLjuRb7vSE8mLFut8+4nq33CswFZcVSujD8GIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719178436; c=relaxed/simple;
	bh=3YGXMdWLCMGu29Y2FQ9xs4fuR6a8LEYWBTkUigaGmeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+VyRY2kRbMVyX+GBgajumkoje41eV/2I9MvQRpYu0DWfOldj8hqZMxmlOq0DaD4d9yWCeIghhKfzIKKsLilZG1xeijX85u/kZXtxgQbFu7Gjv8UfDRSsBR3ZkxCiiY8h34G8vzHISzdcFfheitdfrNnjV2et114R6mRxM43rZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9yCtxVn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295e488248so4183419e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719178433; x=1719783233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi22f/hqoDR5OnYjP9AudC72e1IdaNHxlqmDAvO8bUg=;
        b=U9yCtxVngKAhb0ZzNz95I4NrDE4Bl9sQempgdmuEWdoHwg9Np2LprdsYiyvnLlu+SM
         i6m+WBQRkbk4H1GgDu7UJuSFexiE7Aw3tEFu6YT+CIhgYuw+e36HIBv/cZGbZplTrabm
         iQDvUyRXxhstGy/aY4YF/35OMBvpCqNV3MYfvTaTudf6/wwT1WvwH2fAMlVTOdD8/KbL
         E/n+K0+LqgrBUcwWQw9seRa+n02SyWAyDbzga6AeI1R9u2cQfesdUUBCgaxvY5nbxg93
         1UB+ZBL1UviWBJZrD7kLNiPApC2ZpXHoQrUoPlW77gRf/jsVxjKNx+jI5XZbkbAPCGcI
         s1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719178433; x=1719783233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi22f/hqoDR5OnYjP9AudC72e1IdaNHxlqmDAvO8bUg=;
        b=Pyko2Xr907WlY30iKFzHXeqhnuuI18DalW5Xhdj87b3ksIxqzWAOjml7d8uxGgDkhB
         a6s66fQG8qklWLSImxXzPSOoO0oY+ZKMv1iEk/7cNMgvnalzze5SV5BwnOtxfoliGkKz
         iyxtuvF3gNrwVpDN4RDY4lO4LJJ5uov7vBfsKmdcXh6DaRU/jXYJNIRAPP9Ht3SiUX4n
         mQVVyiWSHdAURWz0TzTbf3OrBaDy6JGz3AAYFm7J12N8u89V3X8SozgBByTclyNhh2Pp
         t7+jRRQP43cgu9CVDwW7gllyTrBNUhbA3MekfDh5Yvc+dsqiYxx/nTrNSeamugO0EH95
         VwAg==
X-Forwarded-Encrypted: i=1; AJvYcCXpqjNfnAuaf89Hi0bWjLzFvDXCiPpS88PfXsHolcGzrxJUweoy5Qf3xb0fP80xm69M1upobkKHrfiIo8AEAJ5oNyNAywJbXBZ5KGBn
X-Gm-Message-State: AOJu0YyOeF8PB46R+Nln9hIvfvmh8R+DpkHydw1GtqcuXTOqNy6Y5o69
	O9vfc2tambz7mnOOQ8Bga23FyXae96LJW6za7vUvkU4iGsxw7DLPolMrqTbECM4=
X-Google-Smtp-Source: AGHT+IHDu+1XQ7zGrkcWkNtNb3JYw9Yz85SHVmkWLAFl8FdxQK3tb9C1BBWyth8Gh5+CWEycOLHI1g==
X-Received: by 2002:a05:6512:138e:b0:52c:896c:c10f with SMTP id 2adb3069b0e04-52ce185ec71mr1915808e87.53.1719178433033;
        Sun, 23 Jun 2024 14:33:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b4100sm846863e87.36.2024.06.23.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 14:33:52 -0700 (PDT)
Date: Mon, 24 Jun 2024 00:33:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: use generic node names for Adreno and
 QFPROM
Message-ID: <p4gozpzctrcmdijtxalcwpcfhfzd5wcft4mau46tpik2kv6di6@v45l76uc4mnf>
References: <20240623120707.45764-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623120707.45764-1-krzysztof.kozlowski@linaro.org>

On Sun, Jun 23, 2024 at 02:07:07PM GMT, Krzysztof Kozlowski wrote:
> Use recommended generic node names for the Adreno GPU and QFPROM fused
> values device nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom/qcom-apq8084.dtsi | 2 +-
>  arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 +-
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

