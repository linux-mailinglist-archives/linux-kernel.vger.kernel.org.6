Return-Path: <linux-kernel+bounces-514799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5D3A35BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F24F3A261B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD352116F7;
	Fri, 14 Feb 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIFTwBI5"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10FA207A18
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739530066; cv=none; b=hcv6b8HfbcqUn9Y9cl73nt6MBy3+8d09EZBsL/haRyrUcg5SbnYjshAyl4ghBSpTHhDzY6+jdxIOCV3neQhloSyYusDcR43j80sZdMTyP363pSjLbFRuN6OKI/Tm/T2do2PngWPWtRA9rMTug07mQVjssOkJMmCIEU4tL2yRjbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739530066; c=relaxed/simple;
	bh=09U+MhfTX1sMM2Iy7LhhBD7fq40jKR/6lAXB2pThy8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmvuqeVre03SFGc6rX1zgwlanIIjMf340YG9lOCDs9J6zyADddtVrPpxGyCe5MepQgM21nvQt4nPWxSFPlT9zle6c+QtPKtwQJ19aBJvqQIVuzABncGd0KXkkh+P6Zn2/2QDE5QcmdbslEHXQRf40+y1U8j3Kz5PAinXSNHyeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QIFTwBI5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f4434b5305so16269257b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739530063; x=1740134863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39d87he4w+nqhvnifbqZl/bqbaPjTdXMuZ/SdAklOjo=;
        b=QIFTwBI5CSDGME2SzYR/LxUy32+nL71aU4aSD1ZnmTOBXtn92lLTBZDkKRXjDkZ1Km
         A9Jycamxks3Cm8cX9vWfo3pyxdC5KecIee9GVNb2ZnBkHyTFTHvljwNDT23N242x8DHW
         c1zc8JHd2DYpMB7jclg4s/3yFrhENVEWRLgsuHuU510ViVcNHuz+enZwEimAOH403Jpb
         pbN9Y4H9HVVgNSgdkxF8BRnOnA2lpLOF1anqV6/3a3WTkJoYFDqhebDESEpIihD08oGP
         9vCZIyasgmBF2k/4LLZeVCI/5fwDaIwf/Cw4OoAgmawnY+QHJA00N8C5Xhrz13l8clzz
         Hw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739530063; x=1740134863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39d87he4w+nqhvnifbqZl/bqbaPjTdXMuZ/SdAklOjo=;
        b=jQi0zt/VaRYcBFd0XN1Hres64q9Ylkig/8iRVkVbEOEECswUiwuvWY+Ia5mVzZSKPj
         1MiEz4U0Ycx/Kb9MpgaGzqodQIUUcl/98HiKkU28depeSprYAWVAoqnez2YUFGwOzqrn
         0MZfUA9EYrfQoRU7fQw5k4E/dWar+LO6pDX54v+23nALTqc4gzljO4vfAtcON+GWLuVJ
         rYWpIZK1wLW+8hnp9U5QtiaQNspPwtjoW57pCz37nO4gX72oxkz7FGOlbYvncwlSpzk5
         Fw/hKW9aZXnGkuxP/dXeKRjMiI2JA1zXrwxg8JHmpyTsVzyXzOIWAe6c1mskN3Oja8dW
         mWMw==
X-Forwarded-Encrypted: i=1; AJvYcCVq4AOmEP6tDuoowilMnGyYNlwKuE9row1oX1Ms4L9Genxk4x+tM1HuRC6yTm6fGTPMRWVocn6AXv++1MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzciakhJMoi5WVgsT/oB7bgsovoiwMvWnmTlSlIXYDjPU/SJdNq
	v0sw3pVqmuWpxpaIJOtG9iXNbKPhNSzLy1UxYuuYVm1a+UU6BdIvtwp6Qw3AvG7XO2Lmd7sSe2B
	twtMBp9NG16NFSE9LwzZJEEMTO7UYW8z/2EBWZA==
X-Gm-Gg: ASbGnculRvuEJdXuEFM/PQIcqAE/AWCTcRXmDKK8zmcswvMsCARcT0bl9ZAvamL74I7
	pTED02RxCJO8MoDE/ufg6yIL7ekKkcXmEhDgvt9bNKznQhKAvSynWCSLd14TdZ/DsPcerpt0/
X-Google-Smtp-Source: AGHT+IFpq/TAGroz+gdgkVpMwZHPYA3s6SCCL9gaFmmcJASK+ip50/1eOiWJmQBpq6AFdEspn1ZcNflRwFQIDYc7lB0=
X-Received: by 2002:a05:6902:f82:b0:e5b:248a:bf2f with SMTP id
 3f1490d57ef6-e5da81e7effmr6876170276.31.1739530063426; Fri, 14 Feb 2025
 02:47:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-arm-generic-entry-v4-0-a457ff0a61d6@linaro.org> <20250214010325.GA12626@strace.io>
In-Reply-To: <20250214010325.GA12626@strace.io>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 11:47:30 +0100
X-Gm-Features: AWEUYZlN3BW34B1Z-q6x6cSfXH7J9CenfXpmXt_ykKPAp-0W_NVi6kBmkZfgRDs
Message-ID: <CACRpkdZJYFUhmPg3EWJeU42fzJMzWm7Sgn3XfELB2-PSCf6Ssw@mail.gmail.com>
Subject: Re: [PATCH v4 00/31] ARM: Switch to generic entry
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Eugene Syromyatnikov <evgsyr@gmail.com>, Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:03=E2=80=AFAM Dmitry V. Levin <ldv@strace.io> wro=
te:
> On Wed, Feb 12, 2025 at 12:22:54PM +0100, Linus Walleij wrote:
> [...]
> > - Tested some ptrace/strace obviously, such as issuing
> >   several instances of "ptrace find /" and let this scroll
> >   by in the terminal over some 10 minutes or so.
>
> Could you also run the strace test suite, please?  Given that it used to
> catch quite a few regressions in the past, it could be useful in this cas=
e
> as well.

Sure, where can I find this test suite?

Yours,
Linus Walleij

