Return-Path: <linux-kernel+bounces-171977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023968BEB6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B5A283460
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A016D322;
	Tue,  7 May 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZDwPDC7"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734516C870
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105973; cv=none; b=mz+os0yxS1ACMjXVDFW3hKJvnNivTzdxuLc6gy3kSpBWld9P9+rTidrTv8tgCLVwapm/4phTvIyp+jNe9dLkSLQVi7VpM1TkAPbWyY6Z4NfTXfhKFfdlk1rcgV2IjLjRv/B7ymmVHajltc/ICaEO6fAutaW4db04gojwkNQ7v6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105973; c=relaxed/simple;
	bh=c0Si3PAK9XuUohVtkgcxlmeIOxLMy40VadrfEZobTo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tAh4cj1rVk0Xy2G/o66w9DzdcwyWycHlwuLYXI1cUzwbwc9UEVsyyzNV3DlOpKYSbm9YA1bDc3pV2cbYQLlX0wR2a7CYkK/SHuKvmKMnryZtBO/TNSiGXrsbqinErVVwaSXZjMvcWwsc0fKIyM2ja728F/1CFmDqytitr6waoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZDwPDC7; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6203b1bc935so36100487b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715105971; x=1715710771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SPGluv+uZ69E9hq5Ivvw3WNr4s+K3uFompbuzq730nY=;
        b=bZDwPDC7PKBgw0wmaMFDyqpKFgVYspWbiXTlNv3anH6bSVyTxj1Uv15ibAVp/oXUOe
         P+Sv+eNSNn5Rb4uEWStj2raYPnivNsGtInqq0k5tMO0cNHStrUIUQ6kNJiRYi+P+DGiF
         yGjG4WFwAqVykEjMTaguYpe8xGSrsGU74qACtCLbzBCwxInNPDWGV70E8mFiVrqy4j35
         EQQWC6DYbJ7tRUQEPxOLEMkxHY38uJpLlIAYlw3P4C6FRivWNr/gmE8roljOpiDplPpy
         PfgSqkhnBlT7sCvvBUPaIRQZOviI+GUYK3e1sR1tBKK74y/JICbG69Yh5jyF10pkQXiU
         CicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105971; x=1715710771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPGluv+uZ69E9hq5Ivvw3WNr4s+K3uFompbuzq730nY=;
        b=ZN0PAT1bjBaKU8qdFA2y5RwZECR8xdAMW2sHvAb4/cdhrm0KWV7lcCD01aiZZZgqlE
         JsLN4KgbtoiptoRVOdmnvXNGNKjE9OJaIqLo2FGTPkoeitYykwGruu1SlrS5ulWn99S9
         UpQ5Km5vmoj6y87OFYnV2QU16esNmiBKOo3vTqPtC1j1jUOoPAtZ3bnNCB3MvjUcEC1V
         3HyrpSFGplepIzaIhaR5bfBZPnmGD67ngXucqSiFWHrReg5+6nNyZJuX+ZhMRGSfz1KE
         RzYxq48kb2/4Wt9ZIRbVYgyl12V36Z6QH7G6my1jtMiJThdJlSWdDtSU8GMAzkIjA74Z
         wnXg==
X-Forwarded-Encrypted: i=1; AJvYcCW7SN3w0ORNKMwY7JFk4B7jqYcyg+2LT0OyrSVKTN1bHIAWn9gFwzgCQb2xT9W9JJJ9FzUWAKhL2zkJUDKhQgXP5EjNicvNfLcbFAot
X-Gm-Message-State: AOJu0YwU1adw07101g6plZ8lEoOqu1QpQq12rVvXYMPrQ+/plemNwaro
	5cVlFsx4MRzGREdCp2XMlJ5RM2bE+azDA7xq7jAlDkVA32E9Kn3eice0ApLgBpDlgg7KgvOViL/
	emvsAlmDU2Svtf60cIUbcTAgDZ9DOYD/q+v8KmQ==
X-Google-Smtp-Source: AGHT+IFbNfibs9GOcfAtE4djrU5hwEh8dEzw/WiiE8HunAJqzpN92edJJVHBU0ShyH7E9dvzYe30+V44n+imf+Z3g+w=
X-Received: by 2002:a81:844c:0:b0:61a:db67:b84f with SMTP id
 00721157ae682-62085da981emr6811217b3.27.1715105970792; Tue, 07 May 2024
 11:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
 <CA+G9fYs1F=kO11-+DtAOsNwZGEd8mmojXEfXfg431JG=Spubcg@mail.gmail.com>
 <CAA8EJpoMwy2w3a9VF3ejGkcxFK905DCczZOdD4k-cd7ouKHYcA@mail.gmail.com> <CA+G9fYuGLz76C9F=onq6u2hk9_YYHhyjT+bvwXmeN8U6bhejNQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuGLz76C9F=onq6u2hk9_YYHhyjT+bvwXmeN8U6bhejNQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 7 May 2024 21:19:19 +0300
Message-ID: <CAA8EJpp5TO9CkwWCUy_OL5T4px9gTjmB-pKPr1dNPgudVc78Tg@mail.gmail.com>
Subject: Re: arm64: defconfig: gcc-8: failed: AttributeError: module
 'argparse' has no attribute 'BooleanOptionalAction'
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 21:06, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 7 May 2024 at 20:58, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 7 May 2024 at 16:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Tue, 7 May 2024 at 17:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > The arm and arm64 with gcc-8 builds failed on Linux next-20240507 tag
> > > > with gcc-8 due to following warnings / errors.
> > > >
> > > > arm64 and arm:
> > > >   defconfig - gcc-8 - failed
> > >
> > > Anders bisected this build problem and found the first bad commit:
> > >
> > > 07a2f8716c41 drm/msm/gen_header: allow skipping the validation
> > >
> > > Steps to reproduce:
> > > -----
> > > # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> > > --kconfig defconfig
> >
> > What is the python version on that platform / system?
>
> # python --version
>  Python 3.7.3

EOL.
I'll check what we can do, but please consider updating the platform.

-- 
With best wishes
Dmitry

