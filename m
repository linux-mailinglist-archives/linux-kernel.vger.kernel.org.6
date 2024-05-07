Return-Path: <linux-kernel+bounces-171697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC198BE771
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD2FB286BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C51635D5;
	Tue,  7 May 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfrX2mdU"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98551635AD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095705; cv=none; b=nUEbjgLk9jP8SDGi6Z3lJexmm38Pe41KfxxEi/Dit98ruEV9KQc7Dfz7ggHSGsjL1U9IihguGev8AjTjzAC0zIg6adBO6ZaFUf9D3Ifi4Ob16EPvmWyCb9jWGRcv+1tw4y1nhp018BL6bb9o7ZL6VGxrWKTwvzoJ2i8uR0HktMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095705; c=relaxed/simple;
	bh=1eFN26KonT5yyFzsxJJ7Z00H9iYnZymVbLRwbWxwvnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoJ/xUVTj62jK9R5m/9OYR6v0IoJVwSigYLH43RJpXUd44l5tP1DsdFPqCIavf/11DPIv/SHHvS2UWXkCh5pc3veJhVfkcViv0wxDR9Ma1C3DOCbn8cw6c9OXakIfMItweElnCvYGUivF9c6mh4AroJvy+DEpwGSpuAJci5mqCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfrX2mdU; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so1738465276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715095703; x=1715700503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qM+FC4CEUXNQ+inJpG0p+yw8Y03MFSDFW9+RZNkCDng=;
        b=gfrX2mdU+9mBNFiASXxNEGY/irV2jogYw19ECj6/n4ZlYGMakAFR8jhL81t3LQSXbS
         Zdn7ypiT9wETeXEJtOfCadS2hYUe6dxbS+T8zPN5PSWlhxN0LDnij20Z2JTefkSHmeNE
         ju1Da7UDGBeXkxOsO29sARY9dBvt1lmQmQVVLj/UEU2lEgs9y7og9XzVjoXFcA/6vT2z
         GmO1E9pM1ec8cSAFJsWV4dgEf2FKWa+RACiwdrl2VgGyLuH3M2KVOJKTC0yusf8VNXCL
         4jE7cs2jkaTPZ25nnIXDEZCsg2wgbJstw+Imse7JfC9byAfQFPdyxKQcABQHYkJAG6LW
         1R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715095703; x=1715700503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qM+FC4CEUXNQ+inJpG0p+yw8Y03MFSDFW9+RZNkCDng=;
        b=OkUwW6mOjlIob51pU2rxhvq00zD+LMOBDle2nWxCOLgXicUjw8Lxq9Ky7tDaP4yaF1
         l3VLp4zXz7jg3Te3Lp4KfqxOiqNUra3n2lT4pBGOHaC3x6CB5CGQiDj79q7HlYkkS1hz
         2kSWdc9dbBEXfhxUSYkq9yqBkXpb5bxd7YzZLq5gyNaRfATIX+Nxsk6Jr5+LMjTrU9Ty
         xLpiQUQ9iw4zaLqrwduwCgaH0/f0BTPWjarTuIvGYweYH/bZ5gr1iTJYcLYn5lVeyFIl
         jpmPjUGoMbIfiVn8t7vSTI5qSRuVcqlbwZPPF95KJBrI/xfB6CWU7VlSh/e6gG9k6hxs
         7meA==
X-Forwarded-Encrypted: i=1; AJvYcCVv+I3vxo82UrXUyRfrwvK/cDj7fi60tYAO5/X88oqY0YnH30HyjrMtCdC0yNcK3c22i4whE5GXreb5Svd6rrws/gn4em3M7+SD6shk
X-Gm-Message-State: AOJu0YxH2BRAyf+fTHoIfq3o2SvWB1yfdKZmSz63LwePXRIs7o2N/HwG
	LvNxu9zKL234OuxnY+6AydJh4yURk/U3IboglC4mC8t0QgvA5bJg4TH1GeXCI+UVYPBaKst0SUD
	I8kcyZRvSajT2Uv+RByZIcrX2ZUWrn2VjEgd+Iw==
X-Google-Smtp-Source: AGHT+IEcbcmFazU8TaQGERSPehFQMyW3IZsbwr73g5F4xiuMGtqaPbP9wO2UpFmDa4/+IdKS1sDCz7OELVDpunmfBxE=
X-Received: by 2002:a05:6902:2211:b0:de0:f811:be41 with SMTP id
 dm17-20020a056902221100b00de0f811be41mr16379061ybb.14.1715095702882; Tue, 07
 May 2024 08:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs1ZN2K=UHOjrwRR2JNE-M0nf9iW_Q-YPzVgmW+9daU4Q@mail.gmail.com>
 <CA+G9fYs1F=kO11-+DtAOsNwZGEd8mmojXEfXfg431JG=Spubcg@mail.gmail.com>
In-Reply-To: <CA+G9fYs1F=kO11-+DtAOsNwZGEd8mmojXEfXfg431JG=Spubcg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 7 May 2024 18:28:11 +0300
Message-ID: <CAA8EJpoMwy2w3a9VF3ejGkcxFK905DCczZOdD4k-cd7ouKHYcA@mail.gmail.com>
Subject: Re: arm64: defconfig: gcc-8: failed: AttributeError: module
 'argparse' has no attribute 'BooleanOptionalAction'
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 16:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 7 May 2024 at 17:13, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > The arm and arm64 with gcc-8 builds failed on Linux next-20240507 tag
> > with gcc-8 due to following warnings / errors.
> >
> > arm64 and arm:
> >   defconfig - gcc-8 - failed
>
> Anders bisected this build problem and found the first bad commit:
>
> 07a2f8716c41 drm/msm/gen_header: allow skipping the validation
>
> Steps to reproduce:
> -----
> # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> --kconfig defconfig

What is the python version on that platform / system?


-- 
With best wishes
Dmitry

