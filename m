Return-Path: <linux-kernel+bounces-192206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41E8D19F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBCE1F22883
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EC216D4CB;
	Tue, 28 May 2024 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLVLPC4F"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF916ABEA
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896646; cv=none; b=JM/3KmklOf5KzB/X5PIgLyELDGEVbUsW+itrDFLovqPwFN31FHscInpDjQqdHUu2WHRuOe/gOUtIXL7zW6Rsa2q3JhMfawfRq7O/eVMcKU6bRg3Cy9VLXZS5RITP8lR7idwZlAgDm+bXKvnMlnsWLzyHOqnGWgHhltu30EVaEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896646; c=relaxed/simple;
	bh=yOEmwDlZd2rxD+/L1uaF/14KWl2R7msUoWWl9sQJuMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Na7HF6lDtDB2qiHCV+XTkqkGoFH3LOdwP/XJIkep1z1IEk4rRT+6vKJSD4N2BQQFzwdS7bQ2/2Ah1WqG0hWaGWq4fEBIhaRp+1u278G2RTSsiVb2bEqxg3qfq8qUDdgMh/pRRWrtVnf4U/1p/bKe7CUEeVci01r8C4kostySd00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pLVLPC4F; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df78acd5bb6so728999276.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716896640; x=1717501440; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDCC8CEGZqZAB2Msg7Dc9A4feCAIq5W2zp1AC6fm/sY=;
        b=pLVLPC4Fhu25amY65NRpnDSircVt3aVW7uz5g4EfjbJdsgOBiYSsn+W/REZHto1lDe
         nVBnyFiYUGMKyhq6Kte5sIrUegMkDf1Dpcyp1hoyVE8GjbbikHXkTeCkZXP483ZRj1xU
         VK77wqXKG4z9a9tTQ4bQzS1QTWHxM/ZY+amuPNR0/Hv+/pJKWuakGpi/Ub2J/dl8UVxT
         68wuMO7ikCC86BKfq9YsglwDRT4R34StAwE85B4aoxIvJPuFXCJy9TZLgMvaJa6GJWvH
         LieOOcXXH4Q1woLFZEmjmRLhrJsCvxwF+tjRz7Ouzp9PaBtzfCrGPO+VXwgpNSQTbz0M
         6F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716896640; x=1717501440;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDCC8CEGZqZAB2Msg7Dc9A4feCAIq5W2zp1AC6fm/sY=;
        b=hyluMLdnOlESy4uuEs4KrWjAqulJvYg/UcRslQEOZVp+GSjq0M4p+1QPxyDdCaORWg
         Mp6VVi1v33rhWMwL4ZrRXgCI8FoPLCtXgphVxPSqyNWRqscVJmidi6TxramRcuB+3URd
         0XvjgH04VrQ/uZbo5tOAiYktVwc+9Vcp3szwA0XKKU+aw2OEE3ZHQePmwOlzNolklgOx
         QZIfAN7s1Frgx99IkJaTJdWLVpntUHNSH6LpkCWnOW+fwitlrZdT87/1Tt+7DjTENL54
         zyCV6p2K1UYth76/Ty9q1INCMcn69jEOaejlAhfbCtf/YcxQv7G3XipSuvu4txqzU1v8
         HgXA==
X-Forwarded-Encrypted: i=1; AJvYcCW1FY7TPFmiDnEq7hjaz0S6ZvRKUnG12bfcZ7AqEI2w2VP2I0VbE5VJMbghyDvv+RRjuo1REFg8q4typloozSlceOhCJoSuzwgT2wIz
X-Gm-Message-State: AOJu0YzUyL4SjR5YXuUhdMH3Os4XABbY9ua6G+j2i3P5oXemxS+DDYGQ
	KIDT31IJf4f/udcTFfCC7z9Z28LG6eiLHMj4wu9pvWduvsJCGQHnNQX1US5ApF5IyE6/TItIFke
	5Qzko7Cv9GNliQweErQa9EYPoowP7MA9JLwJwZgIqDC82SE4eaCmYWu3q
X-Google-Smtp-Source: AGHT+IGAlEjh+hwoEoU8O0CZzP7G3ESAVthO5rQ3B4MUj+UE7U4isFNhiJtbVLHDWwHzyej5tQV+REwk0Y5mZnpxIBg=
X-Received: by 2002:a5b:d0d:0:b0:deb:9e3f:8c7b with SMTP id
 3f1490d57ef6-df77223c93emr10443794276.60.1716896639907; Tue, 28 May 2024
 04:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zktwd4Y8zu6XSGaE@Z926fQmE5jqhFMgp6>
In-Reply-To: <Zktwd4Y8zu6XSGaE@Z926fQmE5jqhFMgp6>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:43:48 +0200
Message-ID: <CACRpkdZd_aXy5Dv_pZw5ue+T=1i8_ERP1Anc5Y_mu=cyd_hbxA@mail.gmail.com>
Subject: Re: [PATCH] gpio-syscon: do not report bogus error
To: linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, etienne.buira@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 5:48=E2=80=AFPM Etienne Buira <etienne.buira@free.f=
r> wrote:

> Do not issue "can't read the data register offset!" when gpio,syscon-dev
> is not set albeit unneeded.  gpio-syscon is used with rk3328 chip, but
> this iomem region is documented in
> Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.yaml and
> does not require gpio,syscon-dev setting.
>
> v3:
>   - moved from flag to parent regmap detection
>
> Signed-off-by: Etienne Buira <etienne.buira@free.fr>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

