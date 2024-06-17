Return-Path: <linux-kernel+bounces-216859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4CC90A7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1877DB26571
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C3419004D;
	Mon, 17 Jun 2024 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYBrPIxL"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF318FDB5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610230; cv=none; b=c/wgOOlZK3V+wNEbP2afzU0GZGhL8rw0df/ibb2cWYy27GJNU2tEryoGln4vdHwm8LSb2yeLa2BZH4tYBZYIlIKvoYDxJNgx8YO08iqYrFYP6FcJdf9JaDau5dqCTM0/L+H8qA3dxAPmOka3DaU0e2HjIAJu1EuNwHeBXw/as74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610230; c=relaxed/simple;
	bh=miN9duLyeGmrf/X9FIwiruW49zhwlcBWt6ivrI61rFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1l3sFhh1lwpqzF1pPWkVz9KrbrqxLVZm0VqPcpcqB6uZTKbh8wLF/SPt9mGQotKkY/G4jFCA4A8zIcusoU6+0r5Eesb9Biumad3CwK3HpbaTvM5yQOnfwstsjcVQ7NfwlgEXywQkMqE61L4V8nMmmb6dJubGXBl4RJ52x5Zbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYBrPIxL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c84a21b8cso3741894e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718610227; x=1719215027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miN9duLyeGmrf/X9FIwiruW49zhwlcBWt6ivrI61rFM=;
        b=nYBrPIxLKJs1vHFbb6QoG7qIuR7SzUJvKpQpFOwRjWSe3lbzpIfx+n4Rs7deKWJD7W
         D6z5CkKvchosbwelv5UpCr6otyZ+a52HACr76+95OB2naeLQNHf3q8LZDZG3RpH/ZRFr
         KToPQ0o2W3sp+5o4j2UYrYLOYVjLlxkIJL0X/1IvCer96Cwxh/xl0t4QKRrRQa080GhG
         MWZ59Lk8fNmdTBauEHCyGHQaRl6ncJt+MAhDBMKXXipTmANuIUJnEv4p9BVVYh4Ti+3z
         V6UgQ14uQx+Tv7IMQ8sABP0t3wsCI3Ulym6bWmniSNxZOx4cIoW4vPV91z6+AFN0uOCB
         rCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718610227; x=1719215027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miN9duLyeGmrf/X9FIwiruW49zhwlcBWt6ivrI61rFM=;
        b=CidNyveQIfdY1o0HvGin3tXod7OBTLylYi2ED1YqUcSvyJTkNhfrXOzfyybEGGj65q
         qll/mUXSeloCM4Bb9IzRzG293efcNvEPaYHlzCjMq7OKlCbh+RxgVGT7YDr9P5IHrFQX
         zcKiySTGQv58DMjsCPlQ6ICaNva5cfpEGR7CvbLOjqff+NeDRxIBrcK/yIAcNAfQoeH2
         Fcw+7rS+tcASHRiq8zrH13x+yiCF/+Mj2bQGk191ZADXsgUpXBJ1UW0/LPPFkVHZ+pLK
         TVt7zh0wItOTiNiCYXkXVibOYCNrMnH2AXykdrgFla+08Vl1x2IHKUFymWVjjvv4bFn4
         dlJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Z2iuOfFp7vOuS7txSrATs/bwPpZPJ4F0Fp+veG6JUDhomxwJshHmmFNIIGM5NqJDLVCcHbxlaXP3PB3BTL8rxEhK4fYkHt/c9mp7
X-Gm-Message-State: AOJu0Yz2hAzL4KjFLEk0R5sdWC1Nf2VMW3g2SdoxVmiParlJ5BlyyiZf
	SvsnsXfd8adlBfob/CyzvD9wvKmGinngKWzE8V69JLkLs94PfRDkVDIno468qWzVFq8iS728MyB
	MdpZZx4PfYMNOffW7pDa5RJ6k3oD2mZU0yEE3kg==
X-Google-Smtp-Source: AGHT+IFOqCN6cicq/x2MVaTTuIMNVO7XJDw/a9DBtHPabTzeQl7zifz5eKAuPRI/EmkhUo7ET77mP7kzjJRUBXUh29A=
X-Received: by 2002:a05:6512:3da5:b0:52b:c023:6e53 with SMTP id
 2adb3069b0e04-52ca6cb3012mr3181598e87.11.1718610226692; Mon, 17 Jun 2024
 00:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603082110.2104977-1-thomas.richard@bootlin.com>
In-Reply-To: <20240603082110.2104977-1-thomas.richard@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 09:43:35 +0200
Message-ID: <CACRpkdaYw=j2iArpC+om_guJtUg79uWSHiU_j6x_GdCLmJmPqA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: tps6594: add missing support for LP8764 PMIC
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: m.nirmaladevi@ltts.com, bhargav.r@ltts.com, lee@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, u-kumar1@ti.com, 
	gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 10:21=E2=80=AFAM Thomas Richard
<thomas.richard@bootlin.com> wrote:

> Add missing support for LP8764 PMIC in the probe().
>
> Fixes: 208829715917 (pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl =
and GPIO)
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
>
> Issue detected with v6.10-rc1 (and reproduced with 6.10-rc2) using a TI
> J7200 EVM board.
>
> tps6594-pinctrl tps6594-pinctrl.8.auto: error -EINVAL: Couldn't register =
gpio_regmap driver
> tps6594-pinctrl tps6594-pinctrl.8.auto: probe with driver tps6594-pinctrl=
 failed with error -22

Patch applied for fixes, I moved this up into the commit message.

Yours,
Linus Walleij

