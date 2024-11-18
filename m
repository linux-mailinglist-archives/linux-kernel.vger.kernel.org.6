Return-Path: <linux-kernel+bounces-412376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97D9D0838
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9374A1F21482
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDEE77112;
	Mon, 18 Nov 2024 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTnxgjPA"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944F282F0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902027; cv=none; b=ZwSysBrqcYTX0jcf8MnGiBOQWOo1dQ0rj/+Ny1iUlQJY9HPWlfRhyEU7HpBQacN6rjTbRATfFQvUpDkzDWC7SjCaNELOc/X867mPDnISKyozNb8OY4MDCWPQBlSrjwVLkFfGgZZWMrNZC7AgyBTNMwPtOgRg9EwGMIUEtK5MS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902027; c=relaxed/simple;
	bh=757AscSd7zeiv7j6vKkam3CidywRcEO/KEooyL092no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3TD1+UoGfNCgnF/9diTNTuXq5iLFKNR/6zovIgPZztkhRKsNgbvraz2IuoUlPZvKrsTfIJy42zrB71dfIO1bdvDGZ8eWr5c9+sVvA1c/gA8n4NTI3gPl2WeMiNfx3KLLOZtel/lvYanb2pRPgFzgP1z48dJrceutL8oG5k7gD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTnxgjPA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ede82dbb63so746261a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 19:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731902025; x=1732506825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iziczI7ZYYRzrx5DXDLTU2aWQXZX8V3J+sI1zP/uoWY=;
        b=mTnxgjPALibj2O3WKJROtQSBmv1id6igwS4U05Q9rMEXJIoEwCLREH2brLEYPRoXtH
         D/BICguNymuGh0SCSUIIgq1I3iohW6sFKKLQDmST2m1umImQItqJSCch2fMusSdze/QO
         Qo0k/2oc6Y/4amFlola95IDmUJEex9k5UV2SEHC6FoZ9AQFc/OWjcd66ErRFwzcg8KDL
         sY1L9Xubm2ZM8aRNwxFtQG/d5Zkl/L0wnyR6UwF8ETxH+D2j1eaQKoGQGtk5GWgpolx9
         TyMMjooqiiIAcIBfQOm8zP9CJTU/eCk25ff1FJFoIDf57JVb/YZ2kpcVx/wKpkX4TLg7
         oWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731902025; x=1732506825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iziczI7ZYYRzrx5DXDLTU2aWQXZX8V3J+sI1zP/uoWY=;
        b=hmnFhMqo6cmcaXAzNwvVDkUcoJkDf9agmPODDC8OFmW36h/tp9+V5/wF/yID7POFmO
         Uh0PEtCXAEGfeJ5DWUUrH23aI6iGTqPWXCd8GdUaJ5jCT6Ug8w6h2LwEimqIToq585Ys
         Q1nr9cGDEkmM+gzuLSLcCqWoHqn4kqtttvZFAWs8IVz1hIyf8o2Jw1jRHvI8toyQrQ4y
         jLDocxMQ/xS9gh08ahHDQUQi10zbIwBU/58En5HMg/oQVOm/AuA0vV0bvym+wq2iQOPb
         UTYJzmSrPAvFagTVwb4ePeqTKQ9yNoFSMY5uc5B4aFtbwmSqspowteArkfJMSnVHxBOD
         i9gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc1C3Tf13dT5GGOltw5NKXCKVnJsMoHDhfPDp6w4/T88MP+XqJ1RLX0uKGMEB1TYPOkAJDTDh7HjyWEQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rEtqe9bkaXXFm7vZcqF94/cbGYxrv2Xy0oTe8Rcq4B0wteFk
	CwVSVmur2RWrDPvfQgun3L6W58pzJTz02YVkS2Qxjp0CEjBG4yQ1wUtr6wYEHI3n5YIfI36Dz2f
	M
X-Google-Smtp-Source: AGHT+IGYl9W0UXIVLMASe6ljQEHSvMFAGPTR22VIIByVAeNekYNbpUP8Pv6DHUaufX/uZNV/YdmOCg==
X-Received: by 2002:a05:6a20:840d:b0:1d9:3acf:8bdc with SMTP id adf61e73a8af0-1dc90c05eafmr19652857637.46.1731902025266;
        Sun, 17 Nov 2024 19:53:45 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711e005sm5159648b3a.72.2024.11.17.19.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 19:53:44 -0800 (PST)
Date: Mon, 18 Nov 2024 09:23:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: spear13xx: Remove unused and undocumented
 "pl022,slave-tx-disable" property
Message-ID: <20241118035342.ej5pxzrn2lildyzk@vireshk-i7>
References: <20241115193835.3623725-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115193835.3623725-1-robh@kernel.org>

On 15-11-24, 13:38, Rob Herring (Arm) wrote:
> Remove "pl022,slave-tx-disable" property which is both unused in the kernel
> and undocumented. Most likely they are leftovers from downstream.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm/boot/dts/st/spear1310-evb.dts | 2 --
>  arch/arm/boot/dts/st/spear1340-evb.dts | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/spear1310-evb.dts b/arch/arm/boot/dts/st/spear1310-evb.dts
> index 18191a87f07c..ad216571ba57 100644
> --- a/arch/arm/boot/dts/st/spear1310-evb.dts
> +++ b/arch/arm/boot/dts/st/spear1310-evb.dts
> @@ -353,7 +353,6 @@ stmpe610@0 {
>  					spi-max-frequency = <1000000>;
>  					spi-cpha;
>  					pl022,interface = <0>;
> -					pl022,slave-tx-disable;
>  					pl022,com-mode = <0>;
>  					pl022,rx-level-trig = <0>;
>  					pl022,tx-level-trig = <0>;
> @@ -385,7 +384,6 @@ flash@1 {
>  					spi-cpol;
>  					spi-cpha;
>  					pl022,interface = <0>;
> -					pl022,slave-tx-disable;
>  					pl022,com-mode = <0x2>;
>  					pl022,rx-level-trig = <0>;
>  					pl022,tx-level-trig = <0>;
> diff --git a/arch/arm/boot/dts/st/spear1340-evb.dts b/arch/arm/boot/dts/st/spear1340-evb.dts
> index cea624fc745c..9b515b21a633 100644
> --- a/arch/arm/boot/dts/st/spear1340-evb.dts
> +++ b/arch/arm/boot/dts/st/spear1340-evb.dts
> @@ -446,7 +446,6 @@ flash@0 {
>  					spi-cpol;
>  					spi-cpha;
>  					pl022,interface = <0>;
> -					pl022,slave-tx-disable;
>  					pl022,com-mode = <0x2>;
>  					pl022,rx-level-trig = <0>;
>  					pl022,tx-level-trig = <0>;
> @@ -461,7 +460,6 @@ stmpe610@1 {
>  					spi-cpha;
>  					reg = <1>;
>  					pl022,interface = <0>;
> -					pl022,slave-tx-disable;
>  					pl022,com-mode = <0>;
>  					pl022,rx-level-trig = <0>;
>  					pl022,tx-level-trig = <0>;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

