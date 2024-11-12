Return-Path: <linux-kernel+bounces-405478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 484699C51E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41001F246EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D320D51A;
	Tue, 12 Nov 2024 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ambXO1xz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCC20B814
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403518; cv=none; b=jhUCU6i+ye5Y03pAA6I03kBp3JTxeSgEXCLLKIkqplBqadM/uZEMDBhvNO1av/gzKKQtjhaCygpq1Gy2EiDVOjarOt+jw5812q4LlOzvyLCylAeJ0BIobGHJu2GuBfACIT6Fu9qArRzl6OlUcREI2rFEfvPY/hJJBzUsWLqKEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403518; c=relaxed/simple;
	bh=SMgE+3sWs28SzC4Pv9fVGSgdUWm8ipB2zOE2VBvQZOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=szt0YppWdsNg6JaR14ndEXdBaQxDbcenZk9RURrH6awkceTxaeOYjieXi+juWthifXBQKU6wCEgFb3cdXSoQvLek8HbJaj55/FAAk6IKO86xfSpNCsdjEdHgWRBfVVJmQuBw3Vz+bB/5w3MOlMtkbQOQfrk5wVPF22wjjm1Tsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ambXO1xz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38207c86695so481809f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731403514; x=1732008314; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XblwL0PzEtz1p+RH+PZoSXPcYHiVL6RcENPZ9d+EWkY=;
        b=ambXO1xzoFmaTj+pPwjaHDhSxDCqahaf21SRjcHwH+6lKNaNZ9pZ7+QLxmMEvQ/fZe
         WFLhE6Oqhofm25ovJ1AzhcYtiJ1zoxPdiXJlvpiU9u8w2ZH1bG4tLzLJnlBdIKz05j4l
         iZg/GqSSpxEzRWpkhEmZyto+CJvPbvA8TF/VraLZbI2tPhs3oFoaNIEUHR1Q6ySrk8r0
         /Tf14KEiJmIgiSuHPPlkhfooDLdcxF3ol52b2P4rxKT5PynsY+qC39qezt7PWOmymrW9
         vh0e9g2cCME659oJEuppB3HY0euMLGuGoYDc+bL/PjX+eArJhb/6Z4KwGiO1pKKK8BdN
         z8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403514; x=1732008314;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XblwL0PzEtz1p+RH+PZoSXPcYHiVL6RcENPZ9d+EWkY=;
        b=EBCPAcfQlXES2Ibt/a8xUAR3q9JY6TKS6PrmM1kWob6YZXTH9i5q33fh5aeqi9dneU
         CtsTUQrttLWyEnEmxE/BtFyMxGJ6jGsMXNl/rSOHdAJHjBzeMC4ZtfbljnKFdhkRy4EM
         wfgGZXiRg+GxsoKd3U4ut9qD+FjXieMm4VKTTa6thQ2nRluDRpo4/SiNraJ3zLExGh0n
         DkNl7Uz+vWWz12lfFH2MnpDqtnZ9Vo2Pt5+PoX2JpZNbR8PwrhLAwZhLYoLtiblICsJI
         P4bu9eQGUaZXOHN7zJ4DBniWnF3F+iJj3C4ckfaKduHWnEXIAwVXWRwslIV/Lc1tOru3
         GX3A==
X-Forwarded-Encrypted: i=1; AJvYcCXLHCZms9fS5/1i6fE7fCJwsTkxplhzNyjIXl+Hk6mFS8bhrgKH7F9lcPArcyGzfPahBXOCBZArlu+loVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhF/qTZ0fVEjyCjJmiubkll3sIf3vwCk5qGagXNn3sYrjswGW
	ipogc8j2TcEsUuKVzu/vAmLhBbrn1pAEXiOc4R7Ka4c5I10crip8dqta3TGCFJ4=
X-Google-Smtp-Source: AGHT+IH4AWBMa8vfF0S/UtOUsgif9MEpVgNttYKPWrjNvh9pZpYY29xpo1rijWgHwhFk0PqGiPd7fw==
X-Received: by 2002:a5d:5f45:0:b0:37d:3f81:153e with SMTP id ffacd0b85a97d-381f186cbd5mr12768518f8f.14.1731403514167;
        Tue, 12 Nov 2024 01:25:14 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:50f9:1df6:c2b9:a468])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04b52sm14728353f8f.101.2024.11.12.01.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 01:25:13 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Arnd Bergmann <arnd@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Kevin Hilman <khilman@baylibre.com>,  Arnd
 Bergmann <arnd@arndb.de>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Chuan Liu <chuan.liu@amlogic.com>,
  Xianwei Zhao <xianwei.zhao@amlogic.com>,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: amlogic: axg-audio: fix Kconfig dependency on
 RESET_MESON_AUX
In-Reply-To: <20241111102932.3209861-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Mon, 11 Nov 2024 11:29:21 +0100")
References: <20241111102932.3209861-1-arnd@kernel.org>
Date: Tue, 12 Nov 2024 10:25:13 +0100
Message-ID: <1jmsi42492.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 11 Nov 2024 at 11:29, Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> As in most cases, using 'imply' is wrong here and does not prevent
> build failures since that code may not be visible to a built-in
> clk driver:
>
> axg-audio.c:(.text+0x15c): undefined reference to `devm_meson_rst_aux_register'

The function registering the aux driver was in clock in some old version
(imply was ok at that point) and I forgot to change that when it moved to
reset.

Thanks for catching this
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

Stephen, This fixes the PR you applied. I guess how to pick this up
depends on how you want to deal with the Fixes tag problem reported by
Stephen Rothwell.

>
> Replace the incorrt 'imply' with the necessary 'depends on'.
>
> Fixes: 664988eb47dd ("clk: amlogic: axg-audio: use the auxiliary reset driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/clk/meson/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 7cb21fc223b0..febb5d7348ff 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -106,7 +106,7 @@ config COMMON_CLK_AXG_AUDIO
>  	select COMMON_CLK_MESON_SCLK_DIV
>  	select COMMON_CLK_MESON_CLKC_UTILS
>  	select REGMAP_MMIO
> -	imply RESET_MESON_AUX
> +	depends on RESET_MESON_AUX
>  	help
>  	  Support for the audio clock controller on AmLogic A113D devices,
>  	  aka axg, Say Y if you want audio subsystem to work.

-- 
Jerome

