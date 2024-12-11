Return-Path: <linux-kernel+bounces-441152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83839ECA68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B6F188CF17
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94501F0E48;
	Wed, 11 Dec 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHSxBhVS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D7187872
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913289; cv=none; b=rrvv5WqkI/CBkmlmCgoqwBsYKXn4C56JLzhLaEO42tPSJIEJXVMFdRuEsTBV/HAVlFCdps45OrVRLloa24k5kBecPiAy2ZLQrGJ9fLtC3SNupqG7/Ug+lu3i8DHLkbEr2Y4pdG+3oQHh2b/S9iiqBCn3YhxVSZsAONIRA44Q6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913289; c=relaxed/simple;
	bh=F7KIKW7J+BGVxbry91OimwuExdPUPVb2HBrGO+PaP7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQAahGlmPLnMMITRccGDQBMqGBoYFh+Wk7EeRjwMt4kKVhjBogOJM637q7XvA4QnodyhWGuDI2NPkylIAXVL5peFn9ZVxduDRQ2o5eG20mB1I6azD2Trjs9lu5NWURel2KDilUzqiBH/5x+LChd0f3UDtqvZGKzJuF3GD6x7ik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sHSxBhVS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso572578e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733913286; x=1734518086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7KIKW7J+BGVxbry91OimwuExdPUPVb2HBrGO+PaP7A=;
        b=sHSxBhVShK6cwd6IZrPsoxKhebzHQJIfTaCKZJ/OfLkSrtkQzlltoBDDhcxx67l6VL
         0RemwlrrsdawJBqodhhKPlauH36zpUuQOVA94PREUAmhLqknfyH/dq6WlMkYAQI0emFX
         7fxhNxTLFLd+/XN7qWNMeZtqsknLu9xxrFNvh4CUWJnyAVzo2QCS+u7S8WEMV5YBUpxK
         +9UuxC4uumPtHUmF/e/54PzRGRy9CEIQTvyNtdm70FhskdH1BqXRhR6vLpJ3qYCD6xnr
         Aur13clCcctuuoSRQNXuSuDj+BK30fbwORuWSKP34WdbrOq3y0ePTmVkimD4Wrca6tp8
         Dq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913286; x=1734518086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7KIKW7J+BGVxbry91OimwuExdPUPVb2HBrGO+PaP7A=;
        b=OkpoKxJNDpGbX/zdu4aB/f84azTmXUAP6O+Skou9acPpnaNJseBnAuwj/v4lLuTrUQ
         c44JXS5nmFswJeTHrFYBD1qCWcdp1VU11Se1Vp4qYdzdzc3j2mZ0X1FyyO4O/uS90i2R
         dDcwvBYIYCCPnpLYvTx65nW8BmP4to5fXe3xN5vaYmjTzDPHPZp2q9MFioUCOHyfuL1C
         tzFjWGqKOxiZY87nwRy8v5xY6Gx2CAotvXwz7T57KZe3CBPYe9kBxZnUnqeRQ0KBZrRW
         l2kJ6aDfdUwpg7onjUK/e1zsfvu4qSLJtaUUnlWDTofJ/pm12ckq24cKuTEDgo0RYT4e
         dLFw==
X-Forwarded-Encrypted: i=1; AJvYcCWgj2NOiTPC0vwkwlyUONZM/GGraPs3g6FcqdmQfxuuAu4TVn8fOowZ9LXUQMgHnR00mr0LG8D07UutdcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75tXmruR8p/RviRT1LBGSKPLNFe14GzsgWiMfUBQZG+xD2XXi
	eOVpR2MNdZ6lQ/yhwokWz4oRisoIOeaqPOqc2TfesGIG862VjscHhq8ZF1zK48J3cNBo/9kHUd0
	M6dH1ysjBqqeYWaSEJRtkkJSkv50feCEbg70TRIQGtpw4Fs6PIxE=
X-Gm-Gg: ASbGncvL/AUfaQze70OIpni1P0Diookjgm3x0Dd6rboeed19/5heYkDOa/yl4gudv95
	CqDpzDuqfYfjaib78NRTqti7CgTNsVF+ftw==
X-Google-Smtp-Source: AGHT+IEIzF7TzpGGOuEOvb5mn1FpOkiF+vDhRngOQ1SKyw/OD9NX/30zYA3n7HT3xgkbQLl1uo9Edg4dhzoo7+83kh0=
X-Received: by 2002:a05:6512:ba5:b0:540:20eb:80be with SMTP id
 2adb3069b0e04-5402a783b7dmr685573e87.25.1733913285595; Wed, 11 Dec 2024
 02:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211011201.261935-1-linux@treblig.org>
In-Reply-To: <20241211011201.261935-1-linux@treblig.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 11:34:34 +0100
Message-ID: <CACRpkdaarPM3vx6vAVhdSv+KHDZq6MTDo0JpQYGj1gJnaE7OrQ@mail.gmail.com>
Subject: Re: [PATCH] ata: sata_gemini: Remove unused gemini_sata_reset_bridge()
To: linux@treblig.org
Cc: dlemoal@kernel.org, cassel@kernel.org, p.zabel@pengutronix.de, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:12=E2=80=AFAM <linux@treblig.org> wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> gemini_sata_reset_bridge() was added in 2017 by the initial
> commit be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
> but has never been used.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Right it was never used because the corresponding reset in
the low-level PATA driver didn't work so I patched it out before
submitting.

But should you not also remove sata0_reset and
sata1_reset from struct sata_gemini and the code fetching
the two reset lines? And even #include <linux/reset.h>?

Yours,
Linus Walleij

