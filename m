Return-Path: <linux-kernel+bounces-271132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763879449F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322AD288E30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00174170A29;
	Thu,  1 Aug 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIPTLMv1"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB516D4F3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510103; cv=none; b=MwEd+yiZbOGk9ir/35Ya/+OF2XtK/eiL2OYbV0jP5Dnrc1c5JNYk3HrZ2PMII6wZw+x09hyy/A2UPmdXWLe4S8LW/dCveS0bMds24tPwTwNyFv0yyeLuBiquDXKtvUZARBKs0yePSeV5y3o6j/hvdbwuPmoWCcJekySnMdC2SGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510103; c=relaxed/simple;
	bh=R05DKqS1w9uIVMFcvpKFDclE86k9lkrCoWmX9bfJe1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjyxndHqGZP7zONW7rwTa3olnp2ficFyPgp/mHzov4sWSXxSxE8Aj20xKK/VweieEupzcRHZr6MTJdAtBltZOZyGFL8Hbsg3Zu/MB/v7U5iUZEayPO6h2F1ZSoauK6vl6pnam92MSYRafv4Jp7x4lEbVquY2zBLECE09S6l4cL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIPTLMv1; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e05e94a979eso1623983276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510099; x=1723114899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hvEVInb3XjDTInVG42ARV/26R6ebE2gUOo+RJ8/4wBc=;
        b=UIPTLMv13scF61MazmIeN3uyvRfzpFNDGGju0d60AEmK17qr3p+FZ8cSyN8+0/Ta6w
         fI4UwhdxfJCQNhPPPJQtescLMDR9j9TOPQv6H/SmoKQmuZm3JMaxUPSNiX8iJttEmIIq
         5ODOIePiPbxkEnoDknaA7awyC1J9z5Ri0P7e8RxAMnjZE0iUatwsEYr8J50nbAVzFZ2l
         DA7OK1xBJejpL04ovA11VxV4MvIQIixNKQGmAxG4gieH7+8MO8q7AkkWLf35zLiJKfdR
         PuNR5OUPKIOAj8pbDAEod0vWPe+q1MjXCuUi4Mr43uVMO3DeAB/db05QjIPJSAZdd2WJ
         oSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510099; x=1723114899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvEVInb3XjDTInVG42ARV/26R6ebE2gUOo+RJ8/4wBc=;
        b=XhqJwPuGoUUwElYJRt9MVsokjiQmJW9hcziYkLO/kRxdTBCu34hw2BbhcstywGLhM9
         YpPiLOqctekknX/KhTIq0R9iC9fd1RTYA1UBP6ezYe/cH/hapj3OWNJE6bI7HQ18ekSk
         lwDa0VXKcmw49h8FkSiJ/E/rX447WWkf2MZQEChHBNQKO26VsDEPwzvNEWPBY3u2ioD9
         tO3L9abAT5Lf5D+39UgiTcXWW5j1EntJdBs3b+snglcLlp5+yfSPatSpJEFo4PJ2vuuN
         cYs2GK6oXV8BXzkG0lLTTPgPDwbXDCZbUxaZrW+SFC/howlREwDXYsH0DiqmuQieB//1
         rKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQkFNk1ZhYulvkKmIdfvCjRWWtZJSuFg77at5unkjFWtwPiE7X4tjfVLIKS8iKk0STTJCTi3E6D5USSsiGS9gxUPEdIF3kQC0qPcoR
X-Gm-Message-State: AOJu0YxNpSHO4DFiH+bMyhRv8VEwbxxctIZED3zfxoNL0VKVYklSwjZr
	LuO0lYCCTkT1Y6GQl06uFtrnnsD4YldZYoqVvao8LaR9wIaMvC7y01ZounccgQeKIRJALv1NvbD
	8SQE2z4C5u9yZbk3cCZ0XdciH3r6H8+HZ0xkHvQ==
X-Google-Smtp-Source: AGHT+IEMWWDuLSCLxVuVMb2OSeIqnvFCckIeIsKnFAFjoQOPspTTLeiCkBU/fF7EcmInj8+0rp1IhGoCa55ZCvPHsDo=
X-Received: by 2002:a25:90f:0:b0:e0b:bc8f:293 with SMTP id 3f1490d57ef6-e0bd5420f5bmr615793276.0.1722510099291;
 Thu, 01 Aug 2024 04:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716004527.20378-1-shanchun1218@gmail.com>
In-Reply-To: <20240716004527.20378-1-shanchun1218@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:03 +0200
Message-ID: <CAPDyKFreG39wJ85Mz=9MnkG-u=hDFCppsgfmv_mzpPbT3rxpmw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add support for Nuvoton MA35D1 SDHCI
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com, 
	serghox@gmail.com, mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ychuang3@nuvoton.com, schung@nuvoton.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 02:45, Shan-Chun Hung <shanchun1218@gmail.com> wrote:
>
> This patch adds the SDHCI driver and DT binding documentation
> for the Nuvoton MA35D1 platform.
>
> This MA35D1 SDHCI driver has been tested on the MA35D1 SOM board with
> Linux 6.10
>
> v5:
>   - Update to nuvoton,ma35d1-sdhci.yaml
>     - Fixing the same orders as in the list of properties.
>   - Update ma35d1 sdhci driver
>     - Fixing the error path syntax to err = dev_err_probe().
>
> v4:
>   - Update to nuvoton,ma35d1-sdhci.yaml
>     - Fixing overlooked issues.
>
> v3:
>   - Update ma35d1 sdhci driver
>     - Fixing "Alignment" and "spaces preferred around".
>     - Fixing style for multi-line comments.
>     - Fixing double call to sdhci_pltfm_free().
>
> v2:
>   - Update to nuvoton,ma35d1-sdhci.yaml
>     - Remove some redundant descriptions.
>     - Replace 'minitem' with 'maxitem' in the clock settings.
>     - Make corrections to nuvoton,sys description.
>     - Add sdhci-common.yaml.
>     - Remove '|' except where necessary to be preserved.
>     - Keeping one example is sufficient.
>     - Add regulators in the example.
>   - Update ma35d1 sdhci driver
>     - Refer to 'include what you use' to modify included header files.
>     - Replace the number 8 with sizeof(u8), and similarly for others.
>     - Use "dev" instead of "&pdev->dev".
>     - Use the min() macro to improve the code.
>     - Use dev_err_probe() instead of dev_err().
>     - Implement an error reset check mechanism.
>     - Add devm_add_action_or_reset() to help with sdhci_pltfm_free().
>     - Use devm_reset_control_get_exclusive() instead of devm_reset_control_get().
>
> Shan-Chun Hung (2):
>   dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI
>     controller
>   mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
>
>  .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    |  87 +++++
>  drivers/mmc/host/Kconfig                      |  12 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/sdhci-of-ma35d1.c            | 314 ++++++++++++++++++
>  4 files changed, 414 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
>  create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
>
> --
> 2.25.1

Applied for next, thanks!

Kind regards
Uffe

