Return-Path: <linux-kernel+bounces-287601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6EF9529C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DB41C2092D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA23B17AE1B;
	Thu, 15 Aug 2024 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6v2IFkf"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B41317A5BD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706406; cv=none; b=ddPnenILBqu4HKwD/2Rj8VrwxQ5G2tm17PIZFLM4+Z6+lvVNGVhhxIDo/4NKgAezz4qiX+w69NwUb7ACAVEMInuXb0bPZIyyEkf++HIrPUejICxa9femH+xtiiGiq+FTW3PTka0yBdFubDZfWyu0zNsnX3CmSvnnYuLykhACqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706406; c=relaxed/simple;
	bh=jsPdeOnIlJPuMPjLCro5SKmZvXAl1puLv+RSKZxyf4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnYCJiK+afxWJ8UonXMxguLPny7+IBdhBSp4oWSBheErIdSh6q/YyhglHJzydC8ykY0u1yXDMQyGTbpUVFg/HFBRUv7QlY0hpe2RPC9r5RfdvXhoEfbbMusY/vD4EQGf7OZ4GrNLZpKUI8+4DtY3aCPcmkb7DFp/UH58Wq0ccBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q6v2IFkf; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so1340623e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723706403; x=1724311203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYyfFXtm6C6RsJuLWVzh6ZAxLrDVeC9/C1JLKXigeWI=;
        b=Q6v2IFkf7k7L9fubJwBqKefqSfn90S2qms5+DaT2JxgczViT6Es+DeRK1363k2PE5X
         qn4i0V7lDf8GsPC0Iz4/+5LNzq5MZGeiyEtswOq49K07sSZf43eYXpIkjMOMIlvm+zuh
         lh/qOJf9bZFLirddGmO5FsXXUtoBYlU0O2XTEWAsSgJ3Qg6bFYZxEdcYmrBj3hKyL5qj
         M6SoJ8mi3rIomzACC3vWeJmgiMKaVYszUV0waM13WD2BQuaYyBGNXRPX9iC90SuF+5cK
         KR93XdR3aanYyc01SI1bkr9ng1EbixKMdFeztV4/8sfFdzV0TU8AtRpGG/ew/X0GUIkn
         RSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723706403; x=1724311203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYyfFXtm6C6RsJuLWVzh6ZAxLrDVeC9/C1JLKXigeWI=;
        b=TG9oLW8McKqp/HAAGjgJKfBOrx+27k7zOMaPvTf54EwC/q8sAsH6whTpRCEmKPp6EJ
         VZtqJE2Fc8C5ujJXK79oc5mv6W46yw8YTVtJWHhFFRBmeUa5YX8asYBC9xt9pxpwMSga
         KUc3NOWJ2VKNPcrAOWxI5EkcRCouLZN81xnREjiEkedlqCDFdkGZROgSnfpQxVS9yVQ6
         BXfqvt+fXZaBLzrXb3D+D+PMal8qVQrO3QaPqtdyXHkZHIVroXOpwN+dZo0m5l7SpDqZ
         ADfhPlJnxN9egcGu8xhEok/ozBEZyfRUBdjAY0eOToINsQoeABlk6mVEO9yIFJxecT+T
         gPnA==
X-Forwarded-Encrypted: i=1; AJvYcCWoLUkwkEnKxMeC3011OUKjJLMLLNSRrlI702YfTgGyM2yUmBof+WezlnQ8fecEAr7r8Z0KyOco6QC61A+Hg5j6b0Lc67DhwfHd7yBN
X-Gm-Message-State: AOJu0YxKMTZiiQiCbf5bKRaM/pCVhJlqvKeDfMBv6+I3K+LSZiBucG9/
	1rI+/an2eF4kknBkbxJaNiCLVdUM5rDpBSkmmDSRVO/jsfPXECeTOSV7PgEwgyY=
X-Google-Smtp-Source: AGHT+IGjAIXc3LM1HfHMtHToUbYecK2vDjK6Pc4pBkKHI9xD09PLovIkzA3HfX5+XUcVIhkIkzuY4Q==
X-Received: by 2002:a05:6512:12c8:b0:52c:df83:a740 with SMTP id 2adb3069b0e04-532eda8a993mr4211925e87.30.1723706402380;
        Thu, 15 Aug 2024 00:20:02 -0700 (PDT)
Received: from linaro.org ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839693ccsm57192266b.190.2024.08.15.00.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 00:20:01 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:20:00 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Marcus Glocker <marcus@nazgul.ch>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: Add Samsung Galaxy Book4 Edge
 Makefile
Message-ID: <Zr2sIAhB1i7akCCc@linaro.org>
References: <qv5pz4gnmy5xbxxjoqqyyvn4gep5xn3jafcof5merqxxllczwy@oaw3recv3tp5>
 <mtyjmbhqv5otvxhxyyvkxg6tubmtkeouwibmsmywmjdamnqnus@mow2w5trrmok>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mtyjmbhqv5otvxhxyyvkxg6tubmtkeouwibmsmywmjdamnqnus@mow2w5trrmok>

On 24-08-14 23:14:51, Marcus Glocker wrote:
> Add the new Samsung Galaxy Book4 Edge to the Makefile to compile the
> DTB file.
> 
> Signed-off-by: Marcus Glocker <marcus@nazgul.ch>

This should be squashed into patch 6.

> ---
>  arch/arm64/boot/dts/qcom/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 0e5c810304fb..77a48a5780ed 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -265,3 +265,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-asus-vivobook-s15.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-lenovo-yoga-slim7x.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-qcp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-samsung-galaxy-book4-edge.dtb
> -- 
> 2.39.2
> 

