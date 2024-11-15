Return-Path: <linux-kernel+bounces-410266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F749CD709
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A51F22448
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AEB1684AC;
	Fri, 15 Nov 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bpaXvYwt"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D5D175D5D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651816; cv=none; b=hFqWNz23FSeBwuvxQsNdhhCbCN5IdzoIZSF18jdGjapUxH8epsB+0M6kWxWnLoR+UTG+DKqLL1+onQFoNt/lpeFk518AKAgO7qoHCn2EiBrbSZl2CJtQQqN3k1nJPYUBdAmc1vDJGVf/O6s0FJGMJbzYTmLP33XNz74hYF76QsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651816; c=relaxed/simple;
	bh=HDIsR4fluZYtTeIoaii/gTwhxDf8U6dUROcngneS9PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcxW+Oj+AlPoChvNtqfOvEqGynLBmC5tOJO5B8Q544C+gNH+9uRstTRWaJ8uWhxMZylhdxqUuYfkSsiRJdFTvHl0vTT8j+yavid0TiirxpsxlEyF1q2NdlHQE/r45WW4BbmQPw2WFE9uR/a34oc1l7TyEb+wGGZ55zRk7h24+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bpaXvYwt; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da2140769so1494711e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731651813; x=1732256613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/chBSo/Ph0swDkMZqbxpKHgwAyER7f2Ug328BGT3Kc=;
        b=bpaXvYwtrUXLp2d1NuJjviVWYWVK78XI0EFqhwmVqMvR2cCU3tzm+QU8ledHQjQhu2
         V4XaYYHEemgJQ8t5JdHD+GH25M7UHi1RUC9EGNMY+/V6ncT3NG2joGt2x6DTgBcQm6j1
         uBvUF/QFhVA1SyCFRs7hQTXVO3BbO5hkudLujn0Of8rJB7VpB5E30Xx3vTLddxP7/pHf
         qDbfoySw/9FxfAF4xgXHwgAJkNy69/iIUYtO9KUSZ8Upsb+Ls9E9BegNLPjy+7Zlneri
         JbVOcIUxWsbXRheiKDgKykivLITIkpHt5PlwFxoVbJVxQYw0ZJN0KUjCdu+AF42m59Aj
         kilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731651813; x=1732256613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/chBSo/Ph0swDkMZqbxpKHgwAyER7f2Ug328BGT3Kc=;
        b=vaA43PtyzDbY1W+YVByhcanRvnD+e0Wix9DAh8nSW4krO2Do6cfigJd+d38+Uzbq1b
         JHs/ZnL1ggnhTuuG8eiYzE1ectOxaR25cgJBp0k4OFVqk3TAwEIXB1nPAz5WVfikYzDW
         jzIi4425lAPojr9ZqEiVxoJFlYmr/YhJ76L65uR9vtvwWnTSsYNhEGYUZ71puBrM4Mh9
         vq/MJ2/o0D8mEruOOjETYrl8RMNiuyevd8C/kDd5JM3wq5ajqQsrkljL+6a5mhD98O6a
         WLoYxF2NFKVQSPhzefpt2pJ0SQhc6X1X0GaIjEZn1OHN5tzJlZAY6lfx1lvwTqVEtQcY
         E8zA==
X-Forwarded-Encrypted: i=1; AJvYcCX/abStA1fIBaeuWz+zQX/0b66YAPzrVGmPH6rJV/zC13QVkwGvnkw5VlK1UW+zYcvY7Xr2DLodnsGYq8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtgEsjpQ8JPV/uyTlQYoQ++gm04VW33fDiuEunbPhl49RG+tS
	1CAIgTKMFWTOrhfNiY5x0RdfpMJqyGMOckv+tJBzNb1bPJa5gbBdt1IJWJ8SZ6lrNo8Gok2MZJ1
	sSrob1bmsugVGAoWIY6/5h8BxTg49lHfaXZwFSNHVXSpetcDO
X-Google-Smtp-Source: AGHT+IFCglpifdMxdVcqfiIEjCrQDyKPs0b3O4KUOnVgdSPNxABQK4FbRhYOa9ftpiAuv6TIl0kyBRGahAttwj1uxy8=
X-Received: by 2002:a05:6512:239f:b0:536:9f02:17b4 with SMTP id
 2adb3069b0e04-53dab2b3c51mr433886e87.40.1731651812466; Thu, 14 Nov 2024
 22:23:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008160947.81045-1-brgl@bgdev.pl> <173151232541.92239.8233789832026323394.b4-ty@linaro.org>
 <yce7vswjat2bhda2l4c4ji4idtozo24c7tbmpahz56tmedmpw7@fn2h2t4hv7dd>
In-Reply-To: <yce7vswjat2bhda2l4c4ji4idtozo24c7tbmpahz56tmedmpw7@fn2h2t4hv7dd>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 15 Nov 2024 07:23:21 +0100
Message-ID: <CAMRc=Mdt0D4L17St06nn=mCuObG=e3btf42NHfsuTEOQepB6bQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: qup: use generic device property accessors
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:52=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Nov 13, 2024 at 04:39:23PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> >
> > On Tue, 08 Oct 2024 18:09:47 +0200, Bartosz Golaszewski wrote:
> > > There's no reason for this driver to use OF-specific property helpers=
.
> > > Drop the last one in favor of the generic variant and no longer inclu=
de
> > > of.h.
> > >
> > >
> >
> > Applied, to the GPIO tree as the maintainer has been unresposive for tw=
o
> > months and the change is trivial.
> >
> > [1/1] i2c: qup: use generic device property accessors
> >       commit: 400913bd4edd76ef1775bfd95543846bd6f5ed71
>
> I think it's a bad idea to pull unrelated patches just because you have
> a GPIO tree.
>

I know. I dropped it. But I have no idea what the recourse is if you
have reviewed trivial refactorings that get stuck on the list forever
because the maintainer whose address otherwise doesn't bounce and who
is active on the list just chooses not to respond for weeks. There
don't seem to be written rules on this.

Greg: Can you take it instead?

Bart

