Return-Path: <linux-kernel+bounces-228674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B81916542
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374D8B24730
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880514A0BD;
	Tue, 25 Jun 2024 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZMTwKmm"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD92572
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311480; cv=none; b=MCwPOfvDuugZ7JwiEUZmtxJowiXlL+eS0CJYVScmaL8gVl+3/ePa2Y8tRlPXi8WArjsJvO7OsqNLbF72STfztHTEcgDEEYxYsIaEIj/fR3ckwBpVE4WeQPK04jNuMmjnVPr8T75UAiB3CVP93BwdQFzOJO9bUxr5d+hRE6hc/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311480; c=relaxed/simple;
	bh=ws9SOHPPrEiKArb9NtFvj/rc13eSTiFTo+1pisOVwsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXsnFcxBNV8sj9C1E9KjuXvrrIx9dFonDm9Bd2NCKKEt6ThBhXARxV+AcXchoP/VdjBk0i7wQH/j0sPci2SlPGXWlvY0OozpTdt3aUGdfxanLWEiOYTuSFk+V2YqCH3VcOEostRkslRJZFUS2BUPzjCyttVHxgLXkdQomQbMwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZMTwKmm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a724cd0e9c2so256785466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719311477; x=1719916277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ws9SOHPPrEiKArb9NtFvj/rc13eSTiFTo+1pisOVwsE=;
        b=hZMTwKmmJp0zWsYrdJ9wecJhZUZtgF+rsC5OA8/jsn5J6nd0CfwkHw6+wg+4EN6Ckp
         P8OTpNAlEN5EU61klxEEL2Zw8N81V98ADXiXpVKHdSzErOZ+JNy+CHK+CBRmRD4dtiFe
         nb5QaUHg9WMHybsqV5he+nKk3tfCZBl7jKncQqRVm7SIlvL59izUpA8CIT2G1F33EwZq
         VYQ9zj9Zi+vey8abVprlCkyKkApkI8Vc0X04MbKiXID36XeGyFU3n4xRq3+FbFzIPr0b
         RQLvfeL2nililfMb8Nr7P1Jh3/NadhsV1C/OaIeK9Ajtk8tl7jTuzsuReTntnlRr3PY2
         p12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311477; x=1719916277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ws9SOHPPrEiKArb9NtFvj/rc13eSTiFTo+1pisOVwsE=;
        b=ecBOPwSkb1EElgiLnkVA0XuVv3jsIK5mkizNYzdkRNF/DfrVl8hfOmQaK68nrhFyEb
         iahv37xl3ZRU9+9S4nodaNoK0DUjkCvV0kt/FTvrssVoHzG+y3wt9MnvD0pqbGhQAIAT
         Nn8CoRr4k1hx8iN7/T7kNtQLBP/3LqT6XWovRP7AkGGx8Y11yE//p4QaNNevxYKW4bcx
         l0dbxccgahsQUmA3ScFC2xMf/bUIWllUOXLXp3xSZvS3g0fost8SFxqxrj6wBEFR8WLF
         lVZgEIazWTzobCkg3fj8Jv3FmzikLfCCx4drJ9Ll+4GHz4Ut/A3GJoohcYcgMZDne3kR
         1kmw==
X-Forwarded-Encrypted: i=1; AJvYcCUa51ffdeiPXmCeaT6m2zOuhrQgcqA+lb+iu+K0/3Rz6lFZeZqzfOHpdtd5TaSUov4NN7zB4IQXxHHnbkFcL/ITF9i+KreW2LX/KVO5
X-Gm-Message-State: AOJu0YyYDPpciCxBh7BT7Kiu232dzFRxKTMltJVwyimRC/AeaegfcW97
	1R2yJ4vyiA0FeMPmCUO+ixobb4rPsmefy13H+qJTUPGLj0BLjf11U2oRE2qCVp2RymtsHN6y0FT
	ZDCGXiidHwOqRfTSYoUx/LR5QP5ak/N3UB6IiC97EkBhL1ayy46Ie
X-Google-Smtp-Source: AGHT+IFrs3kbhcd0kVhjLmP7Zh5J4rapkDDSUXNuVHvjKMsSjePNXYsAJNoRclJ5r3nRfCoh/UPikC/QR7N50v+7KAU=
X-Received: by 2002:a17:906:4456:b0:a6f:53a7:adaa with SMTP id
 a640c23a62f3a-a7245b6dc61mr410737266b.11.1719311476503; Tue, 25 Jun 2024
 03:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621054658.1220796-1-alexs@kernel.org> <CAJD7tkbnmeVugfunffSovJf9FAgy9rhBVt_tx=nxUveLUfqVsA@mail.gmail.com>
 <2e9ce344-e25f-41e0-8ca4-b6d80e095735@gmail.com>
In-Reply-To: <2e9ce344-e25f-41e0-8ca4-b6d80e095735@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 25 Jun 2024 03:30:11 -0700
Message-ID: <CAJD7tkb=VNa6PLi_3gTvLbTFEnspmvQdScFf-CQ_KofdzXRKJQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] add zpdesc memory descriptor for zswap.zpool
To: Alex Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, minchan@kernel.org, 
	willy@infradead.org, senozhatsky@chromium.org, david@redhat.com, 
	42.hyeyoo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 1:11=E2=80=AFAM Alex Shi <seakeel@gmail.com> wrote:
>
>
>
> On 6/25/24 5:46 AM, Yosry Ahmed wrote:
> > On Thu, Jun 20, 2024 at 10:42=E2=80=AFPM <alexs@kernel.org> wrote:
> >>
> >> From: Alex Shi <alexs@kernel.org>
> >>
> >> According to Metthew's plan, the page descriptor will be replace by a =
8
> >> bytes mem_desc on destination purpose.
> >> https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
> >>
> >> Here is a implement on z3fold to replace page descriptor by zpdesc,
> >> which is still overlay on struct page now. but it's a step move forwar=
d
> >> above destination.
> >>
> >> To name the struct zpdesc instead of z3fold_desc, since there are 3 zp=
ool
> >> usages under zswap, zbud, z3fold, zsmalloc. It looks like we may exten=
d the
> >> zpdesc to zbud and zsmalloc, combined their usage into one.
> >
> > Please do not focus your development efforts on z3fold. We really want
> > to deprecate/remove it, as well as zbud eventually. See [1].
> >
> > For zsmalloc, there is already an ongoing effort to split zsdesc from
> > struct page [2].
> >
> > [1]https://lore.kernel.org/lkml/CAJD7tkbRF6od-2x_L8-A1QL3=3D2Ww13sCj4S3=
i4bNndqF+3+_Vg@mail.gmail.com/
>
> Hi Yosry,
>
> Thanks a lot for the info and comments! It's my stupid w/o checking the e=
mail list before work on it.
> Anyway don't know if z3fold would be removed, jut left this tested patchs=
et here if someone need it.

It's partially our fault for leaving z3fold knowing that it is headed
toward deprecation/removal. FWIW, I tried to remove it or mark it as
deprecated, but there was some resistance :/

