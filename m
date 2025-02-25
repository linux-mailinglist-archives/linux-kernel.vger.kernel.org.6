Return-Path: <linux-kernel+bounces-531862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7CA4460B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AED43B4A26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4818DB29;
	Tue, 25 Feb 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjR4vTPt"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F694315F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500610; cv=none; b=d1+YdVofKPje5DajtJ4ajKLmx2j7Eo9v71RbN447b7lwZ+3ahbydIzs+s+yrUE3Iq8muTgGIEXDaR56AguwkikhgP6uVJ+fmLUuI3xtIUE+Oc4MzNf4Ovm4Dwco7bJF/RLYeN1ANdEehTOeRTivy3CfRXKpl/X55pWDtn5DUG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500610; c=relaxed/simple;
	bh=p2muOdipPBPelc0G8QVVmxLLKm2ZUwbsy/AC035S7AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mm8Cs9CeH0uVrbSCvP6F3GVji72SNKrbhShTI9oIfmsgw5UHy0kQpL2TStLGJvafF7xuMjVo1s8OOu59e+1Z5DRPt0C57bu9TJO/t3vV9MgsqfIJudKIqlPENgqxJFI1HsNAygPb4pWhq5og62zzQwHhYB3q8Uyraamxq61qjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JjR4vTPt; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307bc125e2eso53951681fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740500607; x=1741105407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwTVpdV2JjSXgTvzENZ9IyWWdkDRBnMKH/dfCxaMyOU=;
        b=JjR4vTPtJb+aSd/emRscX4dnrfsdPwYtvgOxAf2m2Svb2hmq0M2xEHL7ozvDoYvYRr
         riA7s8EgWoKSELiz0tcR3oyCoRdCXzY5z09UswE6k2HTTWhCcfLUp0O3tGBTGw7hyfRU
         idLAgx53TUGigm0EZI/O+olk+Io9FwvOE932BAtG13Kv/4LB6P14Q5GmoY1lYolJ+7qC
         wkR+qhv+EEy3uLmcpxH40huSqEj6AFT0Zwyofx8dBy+Vs54+t+rwxkJrPmpD1D82geMq
         +xX3jQfKXEzcE3gsODdspdYuVpPyGVHbtOzM0sX/fyWOnX3tWqqOS0lgUwZamhojEh8R
         1BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740500607; x=1741105407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwTVpdV2JjSXgTvzENZ9IyWWdkDRBnMKH/dfCxaMyOU=;
        b=t4Myrhm8byJJ5fFHmVsmWMaUoIJA+daFyI1Jdm8ppdYMb6UfE4JvoCvX04GAqUrdr0
         KmONIFRYc8CmkX1dXSpZBPVNoJjPDqIwOknBM2y6sfecv1mr+Y/99RKdJwn9XKf+jaLg
         RHWdrLt6n8w0CObCyJCBOcJObgKmyRT2msI8TlkYjOEbgV6qpMKytmQ3tO4K15eThD4R
         325penmmmleG3q2v0jIe7lmz31OUtdRnoQ+lwFdajp/t494tdeH4R6es8xsEDMppNjoR
         HPanU5WjGRz4yeYMpxaU2OAy3xe3BPzJQzg+0aE5LtjWUj0cRQtYSH4daIPlfLVi0a4I
         5mZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn26xTx6/NSwNlpfXT576CAPD1+ltgJIYdP64GUlYDAydkPbX8knFkUdQCTN8lHJjNwJmE4f9Ww3mWgUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXrbV7hbG0BAYcGz9OVpo6WxG1sFJ/9za23GBwpCHkX+YPsRl
	FKjpp8v9H1nVGZqbr5el1AM1A1sE/Pec2uD2z5J441oNTY53gYuHGk6fzNrlyxqkvSuTlmrzRy2
	LaIdNGCiHk7p1qk0NEW2kfl9gA57c6IaWCcwnyQ==
X-Gm-Gg: ASbGncseSO+oIE+L2/1RBz2PQMTkuG5HQnocpPL21OueETXdrUPFAtLkpPtinlMVGuG
	3QXRHvkcHgZ7qIpFM+RV0GKt7AAbR9/ho2/M5RnfEM6kXVmbP6isk8uAla7mHUmhrjDYQimS1P+
	RGhl9muk4=
X-Google-Smtp-Source: AGHT+IH1cSBiJaqWZBQz+1oq5/PChixqiVALnH9bhFgTe0md4+MN+IzZ3AEODUq6QzG1w0FaEprZGS9Czr6Kk3AzBSQ=
X-Received: by 2002:a2e:9ad3:0:b0:308:fd11:770e with SMTP id
 38308e7fff4ca-30a80c0f167mr16005611fa.5.1740500607109; Tue, 25 Feb 2025
 08:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-k1-pinctrl-option-v3-1-36e031e0da1b@gentoo.org> <20250223120638-GYA39613@gentoo>
In-Reply-To: <20250223120638-GYA39613@gentoo>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 17:23:16 +0100
X-Gm-Features: AWEUYZlkLTGEHvbrZyxHu4Q2yRspVFfhcab6__rjgENXWUAEaf3SKXErwl_alg0
Message-ID: <CACRpkdZLAtxOdF5TkGtdrbXB+S2jV8Lh_47vMdiwUt74Hez7OQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: spacemit: enable config option
To: Yixun Lan <dlan@gentoo.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alex Elder <elder@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	spacemit@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>, 
	Alex Elder <elder@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 1:06=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:

> Hi Linus Walleij:
>
> On 08:31 Tue 18 Feb     , Yixun Lan wrote:
> > Pinctrl is an essential driver for SpacemiT's SoC,
> > The uart driver requires it, same as sd card driver,
> > so let's enable it by default for this SoC.
> >
> > The CONFIG_PINCTRL_SPACEMIT_K1 isn't enabled when using
> > 'make defconfig' to select kernel configuration options.
> > This result in a broken uart driver where fail at probe()
> > stage due to no pins found.
> >
>
> Can you take this patch via pinctrl fixes tree? if possible in this cycle

OK!

Patch applied for fixes.

Yours,
Linus Walleij

