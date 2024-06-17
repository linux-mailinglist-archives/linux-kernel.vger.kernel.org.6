Return-Path: <linux-kernel+bounces-216874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F6990A7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED9ECB2110D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ACA19004E;
	Mon, 17 Jun 2024 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osR+odEu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1F39FFB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610952; cv=none; b=QX9wtF2+73h4SamUyCHUdczQ7GNqpS0XY5gWMXp1AMsKKblQk0p1wA2nWsGUItME4ULF+9sH8HE3DaRjvbqd94HOCwwfF9xgFnH/YcoyYCQuBLA0GkHRw+VSsg+4O55WmvayhoKeniqmIhZ36mZ/Q5cmdBKU1lu8HT2iDPWZRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610952; c=relaxed/simple;
	bh=C9hSnkp2ojc7XcRy6ZOH9cp+ZYwbLo6myL+YauvJk0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKPOV096kBCfJgJbVFYmth0K0hyyQpxOhhjtVubbsq7FH0IKqvT0CxN0n6n/FGojUXy/zMFR9+sjzEXSGEVzcCa5DiJAAZcxGi7q76oghRzNrTMt2VSGw1pr17RHp6eh61A9fcxyufiTu4v4PrJaoFjCIebpVQC9bSsXiB6GCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=osR+odEu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so39593451fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718610949; x=1719215749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9hSnkp2ojc7XcRy6ZOH9cp+ZYwbLo6myL+YauvJk0E=;
        b=osR+odEuMoF8Ccih4xbbzZoHXJS0GmjNkpqkWLHf0llfl9FC40G6fqkgZj/7xmUug6
         TIjIbQEgGHbxVx2rW2hdh2+xC7Ksof0DOybuNdG0XtFzi09pc/Zx6krT1vHnzX3fJJ8L
         dsdygRvDoefJz215Htb6uv9dRJQEPeCBCWR9pqBNKtn4gAtPOayIhdt1Js/mA6/rgyaB
         KV1BjtJg2rxbF8BZHttXRnpvhgn0gD/H55h2oKspUbwXoAL+tKrCfXVcWd9QGT+IM2fL
         TkVC4Mpj6klxWP4ID/KLjrIjs07lIxgv+SSB3V70uAhwmJe/qQ+ym6E7TyL8UPCM5Ama
         9gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718610949; x=1719215749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9hSnkp2ojc7XcRy6ZOH9cp+ZYwbLo6myL+YauvJk0E=;
        b=r3soe62l8q29G6Uy47MNI43zYm2cOpobWpTtq/Km+lKPVNnEnlJ/XJzDGjyIHiQBZr
         KAxkfBjsyrzh2KwPSa9PneNjWqM3NGircS43x3BT82QoJCC/VLaNnlmcBdOkxwNlro5x
         9sbdr87rvAJ/IAQk7FptXtLLnC8DO0/W+/5DNKUGBgsoEvFbIebUJb4x9Tdbaq4Dw0nr
         b3AfnQSHK7Q2vY4p5FyxB8JwntlU46Np59SlQFmo/0xKMog4Ufite+vz1I4kkDNJEMHy
         yI8DGVCWy+iOXYedmfR2DURt3hVRGJZ9CXGejlZVQ3v4qSV4WcHM6oUdVRoVwxNEKaRQ
         JMQw==
X-Forwarded-Encrypted: i=1; AJvYcCUa4vZy0NasVHsC2CCvvWC6ViwUtG4SEtzrt4seKO99UwHsHclp9PO9PCc8bSddqBrT+1vOkbulFsMqF29c0r3NOVC3mGFESs2+o1eM
X-Gm-Message-State: AOJu0YzajH4q8dOhKgSTaorwJx04h1nyveG/LhwY9AfW+DNIO7SfpA9T
	rzpcdPzHv553N60DhGVRU1M5PyJqRST/vj54sEIUi3eZaGERV6aN8uK6WVvTSwZI6FMaQoSvVAH
	i/2oksOE+85xF/pF4puyRaq18EJdK81e1pyymIw==
X-Google-Smtp-Source: AGHT+IFiHzorZdOghywat09Y1Jdbs3dcScYVdCpywIHV0RMRqy4yofH/Tmy6oLZ9j2GE2KZhNTp2SO0aGLdWxF3mgRM=
X-Received: by 2002:ac2:4c02:0:b0:52c:a20e:4da4 with SMTP id
 2adb3069b0e04-52ca6e9b912mr6772734e87.57.1718610949260; Mon, 17 Jun 2024
 00:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604085838.3344-1-hagarhem@amazon.com>
In-Reply-To: <20240604085838.3344-1-hagarhem@amazon.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 09:55:37 +0200
Message-ID: <CACRpkdbWeMtQ5upOQR--6RYzwcD+N_2o3OA11zT-sPr_SnQWwQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: fix deadlock in create_pinctrl() when
 handling -EPROBE_DEFER
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>, 
	Patrice Chotard <patrice.chotard@st.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:58=E2=80=AFAM Hagar Hemdan <hagarhem@amazon.com> =
wrote:

> In create_pinctrl(), pinctrl_maps_mutex is acquired before calling
> add_setting(). If add_setting() returns -EPROBE_DEFER, create_pinctrl()
> calls pinctrl_free(). However, pinctrl_free() attempts to acquire
> pinctrl_maps_mutex, which is already held by create_pinctrl(), leading to
> a potential deadlock.
>
> This patch resolves the issue by releasing pinctrl_maps_mutex before
> calling pinctrl_free(), preventing the deadlock.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Fixes: 42fed7ba44e4 ("pinctrl: move subsystem mutex to pinctrl_dev struct=
")
> Suggested-by: Maximilian Heyne <mheyne@amazon.de>
> Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>

Looks like a real issue so patch applied for fixes.

Yours,
Linus Walleij

