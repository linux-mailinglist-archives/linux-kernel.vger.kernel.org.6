Return-Path: <linux-kernel+bounces-392080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E99B8F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC8A1C22B54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79117C990;
	Fri,  1 Nov 2024 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3aqsRXS"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7536F15855D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457440; cv=none; b=g13YH1n/wG07J7XYVE87C9AqQVOyzxAbXkS1xwRRJWyVp9hJbM37tKXuWIw8/gSNLy58Ptfsa/laF05/ZaA6lDG97rMKvV5l6UrkHJ73CveKd8yn8tEoGSkoc/pPSDAHsdWu1n/GR6xG6OTwtguJFQRzBESb29mycZG/nqNYcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457440; c=relaxed/simple;
	bh=b43y7YfsSFCBHkl15ujK8EzvmByHsAr6zJ5WraHS89M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arGJ48Tx5bM40WngU70YVHFJOsJqV72rSYTf/1RIeU2y/55sMVXT4zNkwthJdZml1aFqlLXFcA0vAty9js+FWIyK9nflpguluSiUGtUD3upV65Tjk7T0U30+9HBA/IRuWlId4d3ei6xgza+Jqr9ocrEieejJenyZEaorFRFaEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t3aqsRXS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so19726811fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730457437; x=1731062237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b43y7YfsSFCBHkl15ujK8EzvmByHsAr6zJ5WraHS89M=;
        b=t3aqsRXSrA1KYYpGW7UQ8SOyGqCAMt23H/dYIb+F36NjGbK/d1wzKj6Rm5Eyv+5ust
         TU5Rk+u2xNaVPbrkO+gvxG/tw75zpxoDxtE1cjdPBs5TbXUafcqIlikZMghjD7dhfgVu
         7xpfuBniX66Y1f6J3KMH/tg2tcV66E4tlWn6ja30NQuapM/CUjZ/Eex55y9lOOaUwIyj
         SRufZyHofhcAI+hLYWbY8jeiRGDaPrQNFMUMwo3fXXxcCDFC6LaQu3ywch8pPx99XnTC
         SBNA/z9Hn1v3nqNyxoQ6M9sN/AlwAv4fwnxsHBhWaAwhRWWUZf5N46APYwvg3l2i3pT/
         bHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730457437; x=1731062237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b43y7YfsSFCBHkl15ujK8EzvmByHsAr6zJ5WraHS89M=;
        b=cltXeW7ockkIMkmExghrCC3eAG8o1lnwTqiaLy7NegQMTqQCpQgsrNpvWIEF5LAVjm
         Js7ZZmp/rEkNHBuFBaW3DT9G3zrOK3Pm2OpIYI4o4kmecHSceHFFVYytGvRpVX7VCxjn
         01wCjgMa0XC8ibyFuNG0J2HBo9uHFFrgfOOva//QGvSbDzuhLsb6PNKIY9iGiUdvNCGN
         g5OnImCL1VKhC6Sv9A2lZMrx2NzoD9dW/CspDLLlYMhm2uqi2bwKV5xwRzf3eMw3N8bQ
         V/hSE23PppMxXK1Tre6m08/6THIxy2uCsQgNzMZHj4fmGRDgto/1kcmRY8CPhBgGMzvl
         bmvg==
X-Forwarded-Encrypted: i=1; AJvYcCV86+iGRc/aO+IIlbgrjuzkeWY9DGaxRM1izi9Lyz2x6EMPPrFA8MgeC1hPC1gral/vwkk6rYQa4nFDGcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QgX15igf0Ls/8mjqWotw+rd1PSmGBlQXvrYSkxLn8DQsoKRC
	nBe0LjZsaqZDeaxErAqeZVHu8hxCkSvnVDn38c7lj4G3qCjzhzssq/pf/T5EM/VAhHsReYpmhTT
	GZokcSRw1J+hio5IJtoemqnRyxRrXNbP5i0bD+w==
X-Google-Smtp-Source: AGHT+IF30VV+6FdDKWOIEynqJfjgD3jOb94P7KBQLsgNuaSQRW2pePOXLiB1zU3v9yN27Dz5OLd98rmndC9gDmi6aRM=
X-Received: by 2002:a05:651c:b0c:b0:2fb:6057:e67e with SMTP id
 38308e7fff4ca-2fedb7d8b1emr16587751fa.32.1730457436634; Fri, 01 Nov 2024
 03:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101-pci_iomap_region_gpio_acces-v1-0-26eb1dc93e45@kernel.org>
 <20241101-pci_iomap_region_gpio_acces-v1-1-26eb1dc93e45@kernel.org>
In-Reply-To: <20241101-pci_iomap_region_gpio_acces-v1-1-26eb1dc93e45@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Nov 2024 11:37:05 +0100
Message-ID: <CACRpkdYGvB9mr_d6o1tFPUu9VuT6W1-BZNMe8DT5NveQYaURDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: pci-idio-16: Replace deprecated PCI functions
To: William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 8:15=E2=80=AFAM William Breathitt Gray <wbg@kernel.o=
rg> wrote:

> pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()"). Replace these functions with
> pcim_iomap_region().
>
> In order to match the rest of the code in idio_16_probe(), utilize
> dev_err_probe() to handle error for pcim_enable_device().
>
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

