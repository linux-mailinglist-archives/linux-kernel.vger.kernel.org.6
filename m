Return-Path: <linux-kernel+bounces-441299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF29ECC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CCED1676E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B323FD27;
	Wed, 11 Dec 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jLH76Wpd"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782A23FD26
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921186; cv=none; b=DzaJpRVyijp/CJPlq9XCXj1GC3656r1QDI5wKGiFJsYwjyZ4fJoFU+uSWrCBRpaXbdmoKof6c+tYBAxP0Mhw94BYShA3NbtMSmC5dN0uL/vWZTGTdSQ4Ibiir79D27MNKz6gruV9hK0AVRhdlPbYhqhm9BqamfoW6YP0KFFdjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921186; c=relaxed/simple;
	bh=ljytafcL4yuL6A3mBTqsDzIsfHaoog36bhny0bY+VLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1Q6qg5HNA4oi4Vt9s97d1I/Vqgx6HB7far7Vo2obKfGnSY4K5f+PjIyQurMFCbGh6BeVb7yUCMaCrPInWPJX6sxxZxKd1OYXkRgJ5Z4JpEtpuoH/TL4bHF+2wUSd6XfkuxA5ETeOX9RRYhJJ7tDtlJ3jsm/4aiLiEAONt7IJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jLH76Wpd; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffd6af012eso71607081fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733921183; x=1734525983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMRrLT8PBkUb9uwSo3UZOKSbeLIunajxVCGqM67QreU=;
        b=jLH76Wpd0C0oMGqzQv4/KNkLyf+MP0zmD+BLvtwo0hYDG57HDm+0OIh/SRbPkjIWDM
         Y30SOYh2eu9Rham1AE6QsuYzNVJQR4SEiBNwLWa17mDli8DFhtXcALgj+0RyKKSMdgLr
         CcsDTLiKF95tDavEA59gnrS0fjlCOU0bb2HH9iYQambCbjzWcPMvTtpaNWV2hsB7R5Av
         SNatHInKJuVN5Op7nXO10fwbDJr/GpcDRivwrIToC3qRA0cL888EFyjlNWQujClQxV31
         uTxAcuRROaE8Rt70yiwYJUz5/3jq2DT06WSwB8ShrS1wdhPqzDImkk8LpWUlGlmQZnOP
         QtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733921183; x=1734525983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMRrLT8PBkUb9uwSo3UZOKSbeLIunajxVCGqM67QreU=;
        b=C6Mr4/m0n8dpx/zxqOESGJRw0sA+rrFCUSDuJ5MJ61tKp2nY8CLQ/W0mPkAMGdcMhG
         OkedyRb7wccM+VWw+o8wicOTUakcMJ5VJ4IzK05broncngR6T4MRGnCwC03NcVHEERz8
         4htRplduxcOwpVzH8f+PBH2nx0SFKqeF1XjsSbZy1HqCu9h2ulHSs7cVkAyvk20o3jOd
         5x+KtorOcWZY0eIOJNW2q9C580jiEcYKhR6mghQDz+hbgu9OcMdyRxH2CubOosIg4Tvb
         dJHGxk7Q2tf8/sdTJrNoNMlMPEd7okhUaydL14bjhLx2BXW2SaDQVrLrpQDnvp8rSsRH
         owXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCxEwFVh+wUlkZRKgBJhrd8ke7W5ELS1Hfv6L3tKVpux4TbN6R+BgfMt+Rx8d1Vrtwtub0KhLXGHnFqJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKJkx6lG2ms3hQM29Jat2Pv01DIlbWS1nLGNKfeynEtfY+rzk
	CtaSemqT5qJHXJWB0El7SFRkYqXKkGQaAwBPLRYjgZeVyGPuMJGekGmmQQdmEDZXOk6/lL8vs2D
	+pbYF2Hwjc7tSsSnwdCvXsKxNgBOYHThmCdBAWx5RB15VxWcd
X-Gm-Gg: ASbGncuK0kHMwDqISfTpNkGNL/fF8F46ZIg4Ty/j055qdvY0dZsB5obh9sK+fA9kEM9
	SVALhoNBLkJr6ekG7O3fEIcgTtmbJ3oNvOumjksVklxqhTn0zJa5Dzz/IdIHI7/HU8B5oIg==
X-Google-Smtp-Source: AGHT+IGSGpq67S3KPhxv0QaGyYpi7Ds7VIRtelTKmN8kUlCb5EZQ5DwEZ8oJuL//LObkvog2EV/g3poagrgtfeFDHng=
X-Received: by 2002:a2e:9fcb:0:b0:302:2620:ec89 with SMTP id
 38308e7fff4ca-30240cfb673mr9672121fa.19.1733921182952; Wed, 11 Dec 2024
 04:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3f6ke0g@mail.gmail.com>
 <8dde5a62-4ce6-4954-86c9-54d961aed6df@stanley.mountain> <CA+G9fYv5gW1gByakU1yyQ__BoAKWkCcg=vGGyNep7+5p9_2uJA@mail.gmail.com>
 <bd95d7249ff94e31beb11b3f71a64e87@AcuMS.aculab.com>
In-Reply-To: <bd95d7249ff94e31beb11b3f71a64e87@AcuMS.aculab.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Dec 2024 13:46:11 +0100
Message-ID: <CAMRc=Mf8CmKs-_FddnLFU7aoOAPU6Xv8MqyZo8x9Uv-Eu+hs_g@mail.gmail.com>
Subject: Re: arm64: include/linux/compiler_types.h:542:38: error: call to
 '__compiletime_assert_1050' declared with attribute error: clamp() low limit
 min greater than high limit max_avail
To: David Laight <David.Laight@aculab.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>, 
	Linux Regressions <regressions@lists.linux.dev>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Johannes Berg <johannes.berg@intel.com>, 
	"toke@kernel.org" <toke@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	"kernel@jfarr.cc" <kernel@jfarr.cc>, "kees@kernel.org" <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:20=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Naresh Kamboju
> > Sent: 05 December 2024 18:42
> >
> > On Thu, 5 Dec 2024 at 20:46, Dan Carpenter <dan.carpenter@linaro.org> w=
rote:
> > >
> > > Add David to the CC list.
> >
> > Anders bisected this reported issue and found the first bad commit as,
> >
> > # first bad commit:
> >   [ef32b92ac605ba1b7692827330b9c60259f0af49]
> >   minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
>
> That 'just' changed the test to use __builtin_constant_p() and
> thus gets checked after the optimiser has run.
>
> I can paraphrase the code as:
> unsigned int fn(unsigned int x)
> {
>         return clamp(10, 5, x =3D=3D 0 ? 0 : x - 1);
> }
> which is never actually called with x <=3D 5.
> The compiler converts it to:
>         return x < 0 ? clamp(10, 5, 0) : clamp(10, 5, x);
> (Probably because it can see that clamp(10, 5, 0) is constant.)
> And then the compile-time sanity check in clamp() fires.
>
> The order of the arguments to clamp is just wrong!
>
>         David
>

The build is still failing with today's next, should the offending
commit be reverted?

Bartosz

