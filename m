Return-Path: <linux-kernel+bounces-315754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AB796C68A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B2E2890D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA61E2030;
	Wed,  4 Sep 2024 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiuo8u8F"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC381E1A33
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475086; cv=none; b=bsvgf4Q8ofQczzUCStxt9wb6ReAajOaTZI5af2ZXsi5oT6MOWfM3FFiFIRM/iZxdW1Jo+tDRXvobnUZGnlU18X/ReYQ68WPn+rCqWOdgzlViJqjT1kHHzo/tYYBMP3jSHcCjSZPnP53azw6x7LQBsWUOr2rnHrPEzk1/HHJsBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475086; c=relaxed/simple;
	bh=9pQAMVTSR3f24Wv5nWW5VXl+yfFf1TzPSaWfMAL7FMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUvdGW6YaOFIXB4HAIsQfIxJzuoSrROhamLaCs3MHO3BVWwifb3+56vza3ARpW9ggTRQl8P/rNOcvo1PD2al3qNNNARLZ9GEK5CXA8ftHORZashGBxX47Xqx7i7dszb8Fta5KPTzkgfKcFljJcgqULiJYr8D3g5aBy2aymcFp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiuo8u8F; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so26094181fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725475083; x=1726079883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y31lgc5K/TFTdDqrtgkkfI0qYZcr/9voUjOlhV0p688=;
        b=iiuo8u8FQL+MqQhg8vIJdHD1/bHjRokPUh6Bvl57OmWZmidHQaANdLoMxfzyYgQPa7
         LJHE/c4frRekvXRh3Upvza7eFIj/5xiZd6NOcltoDu4qH7jp5gx6qAw+2wcYX3kaXKJj
         IH919rtbGwtjevTfrsyz6PBkuIuOypkOdsdYcw0EyQXoFSQQbAe1DvRQtk1LyW4eYBYG
         RLfMfVfsJ1A7Ec1uMwR0pe/4Che4+ZKP1kDMu1fP1OxbXo8EICu2OZlB4ndnR7tQmINQ
         0RXRPXWDQPZXgea47TR/2JA9uyRpKXBnKBK8YF5vSLSuqGo3Gj0Y78O/zH3XrjX4AwPn
         HPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725475083; x=1726079883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y31lgc5K/TFTdDqrtgkkfI0qYZcr/9voUjOlhV0p688=;
        b=fWrl+DiYtVdBAnO9wEIZINh6y2Cu4fjf7yyWzqjr8yEu6TBq397Jv733K14qlN6ytz
         S+q6oL1V9FExeO3T1wDgHPNgR/Kwc4pTfFLyiS14AyrBSCYFGBxFDZoSJi1ooT39RNjo
         GYjFNxJ3uDZx5uKEozlxFFeCW5jsxODVDBalKZbKkJE5G/o+EDnsAWIDK0E3nBaEM0hC
         Ca72fBs97h+Tl2HiSzvCVuPNTnW7kvMsSUr77uaOVJpOIQnSyOMWdMursO1R8ljp6Xgn
         8fAanQtq9vhRAziRTplCNSojGAZDfMXy0un271joi9a4j7ssNdZG7WGUUs7C1nT99NnW
         qECw==
X-Forwarded-Encrypted: i=1; AJvYcCWlNmNk582IXUglHe2Wpei56FjlWJqKyzWEQAzzDj2HxZDOGV2rtN/KKDl+zeJJPWPC+0gA3Mna8gLsvIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNTtTl+hk/1/HaWY57qJA3tUG5e1La9Yu8y9kAc5g+Wtn/dOR
	88gcYVxX5XSDSLZDzP00YvDY6pHS/XxFv5ZPKTxj31Y9R3bX88R7YfkjvIvjjvbcRTn8ZwtlPZ3
	HvI0lvs9ZyFUjARzWlmDqRqBnqrw=
X-Google-Smtp-Source: AGHT+IHOD/qVjP74cwcaPb9AH3vCXXXPLx8qzk1Y6mjszbD4Yf1Rdx4oFVIt+pjia83lYkqaJWA1TysRkId7avhN3k8=
X-Received: by 2002:a05:651c:2110:b0:2f5:c4f:ddbe with SMTP id
 38308e7fff4ca-2f64446e056mr56640191fa.38.1725475082596; Wed, 04 Sep 2024
 11:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904095205.739422-1-ubizjak@gmail.com> <CAAhV-H5WX7KXXpLkLm_4L-y5J-4fx-72uN+cvFGOZZh2NXUbHw@mail.gmail.com>
 <CAFULd4abR8Upu5UecVes-sEc9his2yWL7pg8hwKSJ+ORSNL5Ag@mail.gmail.com>
In-Reply-To: <CAFULd4abR8Upu5UecVes-sEc9his2yWL7pg8hwKSJ+ORSNL5Ag@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 4 Sep 2024 20:37:50 +0200
Message-ID: <CAFULd4aZcWcX5J==n7N_AQJre13Jeh6eJRK1eHmdSzRS3ZagCw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:24=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Wed, Sep 4, 2024 at 5:02=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org=
> wrote:
> >
> > Hi, Uros,
> >
> > Thank you for your patch.
> >
> > On Wed, Sep 4, 2024 at 5:52=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> =
wrote:
> > >
> > > _percpu_read() and _percpu_write() macros call __percpu_read()
> > > and __percpu_write() static inline functions that result in a single
> > > assembly instruction. Percpu infrastructure expects its leaf
> > > definitions to encode the size of their percpu variable, so the patch
> > > merges asm clauses from the static inline function into the
> > > corresponding leaf macros.
> > It seems in some other places we prefer inline functions rather than
> > macros, but this patch is the opposite...
>
> Please note that these are leaf macros (functions), always used
> through the upper level macro (see e.g. the definition of
> raw_cpu_read() and __pcpu_size_call_return() in
> include/linux/percpu-defs.h). These upper level macros do type check
> on the pointer, so there is no need to do it again in the leaf macro.
> The percpu address space checks on x86 depend on the presence of these
> checks.
>
> > >
> > > The secondary effect of this change is to avoid explicit __percpu
> > > function arguments. Currently, __percpu macro is defined in
> > > include/linux/compiler_types.h, but with proposed patch [1],
> > > __percpu definition will need macros from include/asm-generic/percpu.=
h,
> > > creating forward dependency loop.
> > Macros don't check types, so use macros to drop "__percpu" checking?
> > Seems a little strange.
>
> As explained above, types are checked in the upper level macro (that
> uses these leaf macros) through __verify_pcpu_ptr(). These checks
> currently use sparse to check __percpu tag, but x86 will soon use the
> compiler infrastructure with much more powerful checks in this place.
>
> So, there is really no need to type check percpu pointer also in leaf fun=
ctions.

OTOH, you are right, we should also typecheck _val in case of
_percpu_write(). We need to add:

    if (0) {                                                \
        typeof(_var) pto_tmp__;                    \
        pto_tmp__ =3D (_val);                    \
        (void)pto_tmp__;                    \
    }                                \

to the _percpu_write() macro.

Let me test this amendment a bit, please expect the V3 patch tomorrow.

Thanks,
Uros.

