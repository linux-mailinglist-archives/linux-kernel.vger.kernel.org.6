Return-Path: <linux-kernel+bounces-366790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2588999FA72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578811C23785
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B21FE0F7;
	Tue, 15 Oct 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVztYQXJ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C51FDFBD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028375; cv=none; b=pFvEw5J/HRxENe7aYJVEZQ0MGMIKz7rwJfRo5pmeP3pNbn7yYmlMWGuzqHjZFLf2Vxy6UzMujsGpDvWhU+T2NU7/aMK7RtJSjf8adRvo4fox/FJhrkil/a6DB3yAY8zk5w+Qs7eQyBt7ldStn662iTVsUqJP9A0JyYqQu2H8hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028375; c=relaxed/simple;
	bh=NY5tsDG+TepaBzQoeKpnr+oeJW9vQFfX1a5J87FfW34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kz2ZzKAi/6kPbU4ROXg9LJthOg2FqEHvJmrCfWN9xtTurW6CTf5+dhWnzs/WD09Sj8CX5K3tIyQni1HORTG+p9ApXIaP0TA8m3XuBje+MZOlR9lk3wNHVK1+dgE3chYS5Bu3PIE8mNAdV4k5k/+SgHbpsWxJ4xUU+U6Obo/pkcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVztYQXJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb3110b964so49227421fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729028372; x=1729633172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt1uVRncBKO3P0OnuzsWJGZJCb1Wq0MWXLMHVEHZjFk=;
        b=bVztYQXJ30hYLQ+Qy7++h3B3ZwpKaf0H1eyIPEWW3ZAFwDJm5owoR6jO4IGclK0LDB
         Awx9gc7A+/n/D7hKW/duBwHIbX6qCFomfBhnUV12jFkinf0HOJ/TPl0vV4hq40jdz0vZ
         oxQmfUffmixFc6CbSkNkiMhR1Lz0Yz7Jcco7UNZalHvjiQi3VcHFGHExhnEkubgHAGYp
         pnsOn0P/MMLFwQ3bjFg0sSWsj0CGpoee79yewNpvH416/jf+c96uYPT1VuJ9aBgeKWEy
         gujDPHln2njgnWt+w4exBRru6Q5RNDsrwYpQ9bVfGG0zzv+QEVAvb73MvtzQeTicZvtj
         mUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028372; x=1729633172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mt1uVRncBKO3P0OnuzsWJGZJCb1Wq0MWXLMHVEHZjFk=;
        b=k72WlPagNJx9FvHRLtk2Sl8gVTiPJzNQjq/JUSO15hD4IBWwh7KtarfQy7V/NLywvr
         5cdU+m4j5lzMzRfJWjWAcqzrwnFGYCQE6vhs2uue6PntggTClPecjgNRebdyIgQRI95x
         SzSN0MmQ3+9+DLOsSsepSPenp/gkbRr8bJun17eOzP4D/dD0Ga+BwKzhZRC+igJLf7Ve
         jmKzQWdCeffWBZLWZ9QNvFWhLjJefuJlJB90Dn7xUm7tPN7MmyJcWqr3wOBcE/l6zCyo
         qCkIBedMe+WBO98DR9UEjds7PuagQzdxAAyRwWsxplg6pZrF0JANNzM1mP4UMwIDJ6xe
         yjYg==
X-Forwarded-Encrypted: i=1; AJvYcCViMcXMfGdDJpxz8TvIzT2I/tLXbt2Sr64eXAkuxCIulsR7slNerbK975LiUfhLyd5u6ZciqeznCUt0pEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNktlPmleoC3YgLtNvUZVRel6hddtcb1FfwL7ODxBAYshXLlK
	U630dTskw52BT5YQVGwoJ9KkJXHPQohaNx/7iHx0/2DRRTp788XACZxU0ef1G12MGe5i/5W8w7L
	R1Fj/Ew43gwVPSh5Id3ai9lre8ZYD9/WDxauOzw==
X-Google-Smtp-Source: AGHT+IHa2frolcu/goJFwMBAu6bA/ZWorjW/fjQ26j0X/sDgzZ923uAKQjIodHfeTUJpoVqJmFqouNcmF7KCP+Bru7g=
X-Received: by 2002:a2e:b8c6:0:b0:2fb:565a:d918 with SMTP id
 38308e7fff4ca-2fb565adc3bmr43605611fa.12.1729028372533; Tue, 15 Oct 2024
 14:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015151126.2401855-1-arnd@kernel.org>
In-Reply-To: <20241015151126.2401855-1-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 23:39:21 +0200
Message-ID: <CACRpkdZwG0Qgxjy-tmh34Pjd5YzMmNXM=PktKMgd+rwbfPRSPg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: th1520: add a CONFIG_OF dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:11=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> When compile-testing without CONfIG_OF:
>
> drivers/pinctrl/pinctrl-th1520.c: In function 'th1520_pinctrl_dt_node_to_=
map':
> drivers/pinctrl/pinctrl-th1520.c:455:23: error: implicit declaration of f=
unction 'pinconf_generic_parse_dt_config'; did you mean 'pinconf_generic_du=
mp_config'? [-Wimplicit-function-declaration]
>   455 |                 ret =3D pinconf_generic_parse_dt_config(child, pc=
tldev, &configs, &nconfigs);
>       |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                       pinconf_generic_dump_config
>
> Enforce this using Kconig dependencies.
>
> Fixes: bed5cd6f8a98 ("pinctrl: Add driver for the T-Head TH1520 SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied!

Yours,
Linus Walleij

