Return-Path: <linux-kernel+bounces-311089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3299684BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73ACB1F23425
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672FC181B80;
	Mon,  2 Sep 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CvIo47+G"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648E17DFFC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273193; cv=none; b=juBwanQpM5LwdrTwpiR+nwirNHiUrHuy9ypYb8PyzrMflQgpP57v0am/dfPvfiEZ0j4TXprxf7PkuKM0jparGU6y4VfLc7qkz4STbNIdLEQjd6KCYxZJuTRsKA/uurJ1+jq18WMfgQYKHtl+j3p3q9lkBHhBPt1KCjCyaVlmUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273193; c=relaxed/simple;
	bh=ntBd206Yvf20SaH7Pj2eQRVkjOQdc0qX6sWfPk/fAfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex/JLU66PC+1clWLHfke2ejxDz3LrYdJjbD600SHnz0MzvgZ8RCjhOcWJFRDmsXUaXIGhYP7WD4dKOqDgIzfYmYiHZHW8UmkoVLxLUdIqd9DO+T0hLnS3wsXVsBoajSoqRwVIQMonYG7w2P2yrwRwpdcSbKDLxN8zqVbUZk+WTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CvIo47+G; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53349d3071eso5350140e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725273190; x=1725877990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntBd206Yvf20SaH7Pj2eQRVkjOQdc0qX6sWfPk/fAfg=;
        b=CvIo47+GM4Rfp+YjhJEfpuUlwvCaGUB4rZwCPpP4fNRA0/E81UfebSweugmSHVhxbE
         aRjq4zAMGlXEWesOt4jaU136k1b92Sbt3Zjadqzrikp6uTkxN3dmzagQwaPcT2ur01mc
         YL+O/PR61AEbRE+t7LEFl/PnEixs4yTWuaBsF7HvHyMCm1XoTANrqllQL2PUe90aJOpe
         rRb0+hd1ydF2ETuYth2KJ5Tk2dCFhUDjdfJI5/B8mYNSzAYGU1nXZrUXxEIKgCQXWiXh
         hgrzZ0mIuB39Nu045dq/mDOc7bNsrV9aifXWitNyRogBvB16ugSStKzxZXcbuxQ7Zwob
         pmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725273190; x=1725877990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntBd206Yvf20SaH7Pj2eQRVkjOQdc0qX6sWfPk/fAfg=;
        b=RvMVFVj5lvhpQTVH4S6y1BB9hQ7SiKMXewwo1LWMt6RV7dUTwDD2pWP9IiIWsO2zjy
         ki7esK6atxxnM4/R9SArboZQQrgx6yKzPzoRLwORNlw8SNRRYlf9LICekKrmuCZj5PUf
         hblLUq7nSreIfzJ2nI1gAkffNW3plcaGAOm8pvAWPQUmKg4gG2DHpgJNnMyi7FYoqvIV
         dWgTrhi2faAGxk4NZTfyCKGS5UolxJJrozuhUCvsoSNThsdnpUcpW5CNDVu+qzlp/qh7
         YvcsV9dwAbrfYIk7SIiFcM36TlMYeGHuaqiSWzXeX4Wjj5bUPSFtuwu9Wa7feGfb44C/
         KyPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa9r/KUTTABQPj1shq2LT+x55RKmaB9RwzFsIcspAKDndDSMpS8fOBLXZgAoBsklLRUolH4vZwIO1FyH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6/FVpIQn+bZDexdU2As1yj+UtGuibQqAXdM+TADcjObOX38nP
	hUy7HxuddHrVZ6GJzBTDDQZCb9fJaNLfkzoPK9Skszz2EcJA98fsRzSKZuycxPhig5MUIx0BYrh
	h1tR5AneG7Mj7/3owPzwInZJG1JXaDYMejxSxtg==
X-Google-Smtp-Source: AGHT+IHR0BjlaxvH5N4Xcsh9oU+BzC5/rnmjLf45rfI9sxOMbtwkRJLYZ/zoGaUuvSzjAzYpnLfsKrP5/6IvBrMJBJY=
X-Received: by 2002:a05:6512:1055:b0:52e:f950:31f3 with SMTP id
 2adb3069b0e04-53546b44404mr8330415e87.35.1725273189848; Mon, 02 Sep 2024
 03:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820121651.29706-1-rongqianfeng@vivo.com> <20240820121651.29706-3-rongqianfeng@vivo.com>
In-Reply-To: <20240820121651.29706-3-rongqianfeng@vivo.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 12:32:59 +0200
Message-ID: <CAMRc=Me0OBPTneoB5WGa72eL_Yu=1=X_yu3nFimsDKUv2X56Fw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: zynq: Simplify using devm_clk_get_enabled()
To: Michal Simek <michal.simek@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com, 
	Rong Qianfeng <rongqianfeng@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:17=E2=80=AFPM Rong Qianfeng <rongqianfeng@vivo.co=
m> wrote:
>
> Use devm_clk_get_enabled() simplify zynq_gpio_probe() and zynq_gpio_remov=
e().
>
> Signed-off-by: Rong Qianfeng <rongqianfeng@vivo.com>
> ---

Michal,

This changes the order of operations in remove(), could you test it or
at least give your Ack here?

Bart

