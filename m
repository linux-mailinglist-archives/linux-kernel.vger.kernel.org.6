Return-Path: <linux-kernel+bounces-386808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7EA9B4820
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A671F2162A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5779205127;
	Tue, 29 Oct 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q4ew1JJr"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E0204031
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200758; cv=none; b=ovD5I1SMWVaOShAOM/a6z7tur0fvqzJTWJiaYRPZAhcDbrEM7RCz1v4M+hiuC1OGaeDFKJjFRUAf5Yv82tztCPea1Ll2W8043rFyQQ28/R/C5rbJtGKCVPizCMVtq3EHJSlAfvyNMK5MougwqXRX0sXK74Z5AC7N2S6wj3MghJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200758; c=relaxed/simple;
	bh=tFMKTNPmYqJnBHp7LbWdTDUq9SozK9sVsXxDQzNVaBA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivU/TkKsjzQG9HYFmlvoDKjc4fcZxmJSTzocM9jf2PmvLxbm+Ue9h0uatmn7rZNWxb9nfnWM5FqFcXklsxV67d/Lov0R3XI4E16NurTm6FI8X098Kox/A+rEhN1HKH5maDyMA+iV9t/dXWf4zgJw5FrbLhL+4hvLR/sR7ohoSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q4ew1JJr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B5EE73F2BB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730200227;
	bh=OCvTHmHIsSTPPIZoUzRjyZ2bC+ZqfM/bLPYsIiMxcJE=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=q4ew1JJrAO0uRuq340Dxk2HTOnMS0zsf42msOpvWiJp0TxqPW+GTZSnO0HJukV43C
	 mpUnb6Xx5jEYWAozj2JU3OPKAZN+e/QSLXBM55fnObPdeNXfMNIX7cvGuxloeahuBB
	 MiDSHBLlnMdNd6YKLq6qoQEBuAJGv3jUEcKwTHmDuSqdg8niIpp3kIVsIHNLw4IR2x
	 42tAkyOVcMRDYQAq3Xee1v/rL6AswFoIfPH53lqkzHWyZCgIBjBihgMq/g0uQwIBtM
	 TA+kRKGhX+xzJGAtI+B1AIGcixAeKFmd6I9TvGf8gR5kDb35hW0llxwVmpUc2ucdaH
	 6NbZaQaa2Q2hQ==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-288a2ae6d73so4718276fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730200226; x=1730805026;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCvTHmHIsSTPPIZoUzRjyZ2bC+ZqfM/bLPYsIiMxcJE=;
        b=e7ChY0wI4K0iRN9GDP6yHo3XqQayJneo3IRysN2jLfDf8yVzZ5H40Yg5COq9Pyxr5m
         Qm4Q7Kw5LVbMKaT68X/AaSv2/AvvO32xjhsn7DcGzgCJzTzMSV3w6BPFEjftEOqYqOvD
         hkanBtP/+Okma+X4e+UvucQyJljkWcZCxBpYFNZd34dqmPoFa9/TCQrnKK2eXgBuAYCJ
         igC3YPwY91paizv+sggxV+kUkJomKE76BctkijuUzGKgvMUnF20FQ3Lt8Jzb/jdg00br
         0x3wbymu6nzNecWJ9f5ZwD7ZBKDfmlHRGFz3Wn4xPvpE0EOZ8fv3g2BTNUvmHrTRyEdz
         vqSg==
X-Forwarded-Encrypted: i=1; AJvYcCVcZTRDdaqeRquN5fNhp2wXblVTN8pWctmWjdy3id2DDs/Rh01XoqhWAnK1NHCJG1jhSeYL8UZIv7RZ/1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1AsVZqJKMoAFegC3xbdnNKjr2SwZ+Lwy0CzRQ/zp4c6HM3il3
	76HjU3jjC/HRr8vVN1rm4rIUoTQGimihxt+n7V6HWEWRfrGx8lfmSnPv5SmpTl6xhJutXd3rNFn
	QViARMrdzOcXAzr12Ewk9nJs3G+W51PU0k9hbWguXboEEgnSVwFPMc8TwvXha3cxZIr4xOKeW+L
	DG8f1LnIbFDiQWyFysqGqWjALWRdrXkBpJ0DzWAaylHRuDJPcur3BPwZRyM9YCMGRdYw==
X-Received: by 2002:a05:6870:180b:b0:288:8bdc:1ec5 with SMTP id 586e51a60fabf-29051ba4840mr10052136fac.19.1730200226510;
        Tue, 29 Oct 2024 04:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3/FOqZQ6Obh7FQh8oUZ/M2AMCPjS/Rwuilx2dDjehZ6+vagRyskdpKOXihVmzkbLu0/SzaBchfmjWxpYmNl8=
X-Received: by 2002:a05:6870:180b:b0:288:8bdc:1ec5 with SMTP id
 586e51a60fabf-29051ba4840mr10052124fac.19.1730200226197; Tue, 29 Oct 2024
 04:10:26 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 07:10:25 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241029032828.238706-1-changhuang.liang@starfivetech.com>
References: <20241029032828.238706-1-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 29 Oct 2024 07:10:25 -0400
Message-ID: <CAJM55Z9-xrKuH3eS3hUjDMv8JEabBZRR48oQmhv7yghtiG0cFg@mail.gmail.com>
Subject: Re: [PATCH] clk: starfive: jh7110-pll: Mark the probe function as __init
To: Changhuang Liang <changhuang.liang@starfivetech.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Xingyu Wu <xingyu.wu@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Changhuang Liang wrote:
> Mark the jh7110_pll_probe function as __init.
>
> There's no need to support hotplugging in the jh7110-pll driver. We use
> builtin_platform_driver_probe, the probe function will only be called at
> startup.
>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Makse sense to me, thanks.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/clk/starfive/clk-starfive-jh7110-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.c b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
> index 3598390e8fd0..56dc58a04f8a 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-pll.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
> @@ -453,7 +453,7 @@ static struct clk_hw *jh7110_pll_get(struct of_phandle_args *clkspec, void *data
>  	return ERR_PTR(-EINVAL);
>  }
>
> -static int jh7110_pll_probe(struct platform_device *pdev)
> +static int __init jh7110_pll_probe(struct platform_device *pdev)
>  {
>  	struct jh7110_pll_priv *priv;
>  	unsigned int idx;
> --
> 2.25.1
>

