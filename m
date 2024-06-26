Return-Path: <linux-kernel+bounces-230483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C91917D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D9A1C22869
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0583F17B50F;
	Wed, 26 Jun 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ifhg7PWI"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191F179957
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396727; cv=none; b=PmdLWMr3l7WXsT6evStha7ELexPLmLKsuCx6ivqN6uL2dSK/GcuEHCU+6mttZsYQFRE1IjA8J6Do2F3PUCmqUZUEVE+UGum0IqtMq1hi1haqwTdI8FWHYzkFud5IGtYjql9pLTK4R2TQee0wIifMM18Nj/NDnNuXRlpqL73Y97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396727; c=relaxed/simple;
	bh=cmknoVngdJYQ85cuMuMf/+xJ0MzFi7KYzXKNAOTHktI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLmEXaKqkCI5yl4zI+TBxZb6x+wuNxFlO+PXk3ZEXqkJleCAOdoiNcWFvAKUi1Shywl5AbKPgRm0tErwwx/60xrm3MtlsIJIOjPRGsGMZoXrq6rWbe80FGrHXWkHc14vU/bsC3lwwuZDonmsId8CZJGgUlMNdsVhDrQCXxA5ScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ifhg7PWI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52d259dbe3cso1188486e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719396724; x=1720001524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmknoVngdJYQ85cuMuMf/+xJ0MzFi7KYzXKNAOTHktI=;
        b=Ifhg7PWIeeV76pTvN+fQBxbIO1djHZsgo/3Tni0Mu/efQl2tKzrIm1IMvK0Xkt71PD
         r5BmAD7v4IO+X/8YdY/G+D7W/ZZjf37CWm67x6vCr/g19HkPGWca9XnikSpJzRfjAmCD
         t7RVMHZD/JHXCfNfD0MMgmIuGic/jGvHXVsCZS8Gv/BLKpUZQc4wVRgIcDx+6LuDb5Y9
         HC7ue3rbdMNRJvoW8H6yPaus2zDE+zoMhSAbwEmJQmOVyVkt9iBHizYZ6wBvLJL18gyv
         xovg3KsU22ZFdw7XVlEsNcw0lbeiCFC2Myrf4Kl5C6nhZ/kkZh2gg/FiYGbyyhf3Hcdo
         WSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396724; x=1720001524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmknoVngdJYQ85cuMuMf/+xJ0MzFi7KYzXKNAOTHktI=;
        b=GOxOZAL3aKNyfUaLmg2YvbOY5TeD1nRZ3wcp+cIlH9JbwmQdDkEpo9AqcdUT81qs4C
         H0a7s+3TzYPvAbl93+HIRS8PjEKvKVQHJq66cKSpLtHJAxzcEErZxcn1mOJ41aCotrKm
         dyQHV/Iczj20lGQEb0Da9C15ZWDHN+fhvm/o/VCvG47XyLSrMqD2kw6Q5TMZkmHiRMTY
         rHYbxNJ6p6GIf7KY5oVRIzFl0GjgsVXpDSKG2r9SdA55zF4dlcuIv5qn5TPMErhvN3hr
         L9YqsyQieD9bl17vEIK0R4TSk1XTVzE/iFfb/RVWKK9N2NaokZ9vkyoWcEvEnnucqgjX
         kdlA==
X-Forwarded-Encrypted: i=1; AJvYcCUPLUCkOWpfFKT/UG0hEXZUKQttAKSVmc3aemktlZYkr+HoyTIlULE9cNNj6k8RTLI7T9Dog5A1TuFHVpER6Chn1MK6C97lkiKIX4ba
X-Gm-Message-State: AOJu0Yz7PJ5mmfENYkDUaiB6I366H2DzmLC6ProcPYU0nX1xmyOHO2Cn
	uasq+smWuP6KwyM9IoPp8ZaNpwOUxJYLJOK/+rpEu/ziXAgJzB2YoHMVA1tQmKOZ20iGZYeahT6
	HF0ODoulUgn+7hZpJhlN9uH/tVtS9GQiEK/zKGQ==
X-Google-Smtp-Source: AGHT+IFlHWSye17wo8uw0up94GPccFl/V/sPyPXlvOG615qTQFfaqLTIdJTRIPVYR4dTna0h/ALhLnj/xJOSRpjTkMs=
X-Received: by 2002:a05:6512:3c86:b0:52c:dccd:39aa with SMTP id
 2adb3069b0e04-52ce0646944mr10878848e87.67.1719396723946; Wed, 26 Jun 2024
 03:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620094159.6785-1-wsa+renesas@sang-engineering.com> <20240620094159.6785-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240620094159.6785-2-wsa+renesas@sang-engineering.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 12:11:52 +0200
Message-ID: <CACRpkdbaCVoR97YZs7w4T6hg3a_+C__GA-qujdpc-0D8A_UB=w@mail.gmail.com>
Subject: Re: [PATCH v10 1/1] gpio: add sloppy logic analyzer using polling
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:42=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> This is a sloppy logic analyzer using GPIOs. It comes with a script to
> isolate a CPU for polling. While this is definitely not a production
> level analyzer, it can be a helpful first view when remote debugging.
> Read the documentation for details.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

This looks good to me and I think it is well worth the time to maintain
it in-kernel.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

