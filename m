Return-Path: <linux-kernel+bounces-257482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F19937AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F4B2872C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD832E414;
	Fri, 19 Jul 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lme0PJN1"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B45320E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405936; cv=none; b=rAStZpyA5inkUi/KhXEG08BdlQBfTmc0BUkQ4dhdcrwJ+Y42XpWNhNTgkjH4CitR28c9sOXu1GvvwscemY9CGaRAeR7sM1lNYkxH3rl0iyVFduDlfaZADdjEuYoLaYfADhW6pQjQKWoc8ZaHuqOMRBmvhxcsO2eP7MhX/+TR/Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405936; c=relaxed/simple;
	bh=BK4vVgXsqd3HSwJZ5+Q5HPLiuoRpZi/LDL+knpfVAjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6KTA4VGQ4+Bauq37wvEOkpAQexXRNYSQeeWCn1Vd8/w9Pn8WxdKvPXr1ZfhsIFr1i2UvBRpMya9A4ZmEO/Yk2VmAMtqoKs5qPEt/I5iz/P03Gc4kiWBmbjcbvoiaYenFoyA3gXjZLmsTMVVzdlC47lbWKwZEIkOWEay526o7BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lme0PJN1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so1911356276.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721405934; x=1722010734; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5r9a4XXmQXP73cigBFNiYZaf+OV2yC8N7BDhu611Y0c=;
        b=lme0PJN1L4q/90vm5ccBr5ajxLC+i+x2ExN3/cWXe9fKzdTOYEk7+1+SGVfwIWb9Af
         pqbXJdYrMF6Ol67SxDfjuzP+7noXE5YV6PXwHvFDrZJ20xKAc2Z6yPNjXHPY0Qq/9IhC
         qkxOQRIzVNQPj1vsS6pHKn3tiXa8SuBO2UmssakTzVuxQFWcWBihXGg37/xu3jG/8zrb
         mu9Vx8PL0FkR4lBTDQubHQ/3hcBeNne6i0Fxi0Bk0iNlzElm4L+DjjmmsYc/TP0am3FT
         1dyBWsczO12ff0QnoVWAgWhaYrn1vk8yIrs5G59pqYYjLqtxAJy6ufsaMN9RI/g23gHd
         BmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405934; x=1722010734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r9a4XXmQXP73cigBFNiYZaf+OV2yC8N7BDhu611Y0c=;
        b=vIKvhpRGw9zBVRDfY195BrgnJONPUZLTt+i/88V8PH+XkjwOpHeQx/I3VrEv6Q5xOh
         t5gCNbKNZP/VB3th2SKiNbfsPpcV3mj08O3RUQYBSCbhyLWwteWzwbR/brp4e630G13k
         q0Lw70FeqBdtjpnGgK2lMBeTcqw6tDd5Tf+txVVm0Emk8uwYk30bracYnYEHdT+q7qqB
         pMzFIldNub1mgdWaR8VRSxMChsLheEbKN1Xmaac9rV3rk6yODXj7gbgHDmCfllUpU8JP
         5Qrlqto/u58J4WWAHxz5anR+wNaxEuWVbFVME2djyhiM0hxg0oOJSxOX9AiVara03biS
         gCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJO82QXnPua4vxz+P5uSgQexwUjHoNfer40FFrphexVJ9OdU3/jGx7UOa+4qZ0w6Lq6yzbKB4Aw7T2loEJ3VJk8pHOo6idr0RzaRcv
X-Gm-Message-State: AOJu0YxOEtD/Q0uHr6UwjRANm+wzeH+cx97ZZLZK/e2J5QXZijrn4ny4
	PXb8nUlDLsLbGZpebu9ZbzlXRgKLuwcKB/VXPTJTSOy7lwZU03T+1DqGnw==
X-Google-Smtp-Source: AGHT+IFXKxpJSm+jQINyIdcAS25z6i2t+cVLYvY9NKgzJVylfbWuM2nM12U+0rAKLzTfipaJy/hb5Q==
X-Received: by 2002:a05:6902:1141:b0:e04:e298:3749 with SMTP id 3f1490d57ef6-e08702a4b92mr142782276.33.1721405933866;
        Fri, 19 Jul 2024 09:18:53 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac7e77c0sm9169586d6.61.2024.07.19.09.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:18:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 87DC31200070;
	Fri, 19 Jul 2024 12:18:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 Jul 2024 12:18:52 -0400
X-ME-Sender: <xms:7JGaZlfzebu9VQHP0-3O4_4DmEoJcEJNzaIys-2n1_6ilpxDiC1X6A>
    <xme:7JGaZjPitnGgL93QGaFIGLcG_FSe-nqZ17v-S4jCRDyp7FFmMxuMkLQl_MvGYEOk2
    nP4iy2LKuPA-T8s-Q>
X-ME-Received: <xmr:7JGaZuh5fHKaJId8iyYLbwzIfM8f4l0Hg1fFRCdDZgd8ax1aVNfS2XPzIuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:7JGaZu_DSWs_avAUtV1Rf3eIpQD3hYYeTGm4BZXKLq7ms8WB_NWOGA>
    <xmx:7JGaZhvrCBMB2pipCXpRPEw-_XCZGxCfQYB4kfbe_oLBi3nmZ4GNBA>
    <xmx:7JGaZtH40MWSUV-7PdAMZ-9_MSE2StwFMQhwjoYieJJHpi3AYM88Ow>
    <xmx:7JGaZoNIzwrFzHenjwnmcTpCEZj9yzlFg8XT_cK3aOFteNRiPljdtw>
    <xmx:7JGaZqNe3FCovRFxaMJ4nQqnNhI18rLbEyOi0YqVOPwqh_ri9M47QeX6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jul 2024 12:18:51 -0400 (EDT)
Date: Fri, 19 Jul 2024 09:18:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomic: scripts: Fix type error in macro
 try_cmpxchg
Message-ID: <ZpqR4qkFUNgkJj0x@boqun-archlinux>
References: <20240719024010.3296488-1-maobibo@loongson.cn>
 <CAFULd4bt5oiQq4_3jSDe+3P=1xtAhZ=34vLREqPVT9njjdWKSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bt5oiQq4_3jSDe+3P=1xtAhZ=34vLREqPVT9njjdWKSA@mail.gmail.com>

On Fri, Jul 19, 2024 at 12:15:28PM +0200, Uros Bizjak wrote:
> On Fri, Jul 19, 2024 at 4:40 AM Bibo Mao <maobibo@loongson.cn> wrote:
> >
> > When porting pv spinlock function on LoongArch system, there is
> > compiling error such as:
> >                  from linux/include/linux/smp.h:13,
> >                  from linux/kernel/locking/qspinlock.c:16:
> > linux/kernel/locking/qspinlock_paravirt.h: In function 'pv_kick_node':
> > linux/include/linux/atomic/atomic-arch-fallback.h:242:34: error: initialization of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'enum vcpu_state *' [-Wincompatible-pointer-types]
> >   242 |         typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \
> >       |                                  ^
> > linux/atomic/atomic-instrumented.h:4908:9: note: in expansion of macro 'raw_try_cmpxchg_relaxed'
> >  4908 |         raw_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~
> > linux/kernel/locking/qspinlock_paravirt.h:377:14: note: in expansion of macro 'try_cmpxchg_relaxed'
> >   377 |         if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashed))
> 
> This points to the mismatch between "pn->state" and "old" variable.
> The correct fix is:
> 
> --cut here--
> diff --git a/kernel/locking/qspinlock_paravirt.h
> b/kernel/locking/qspinlock_paravirt.h
> index f5a36e67b593..ac2e22502741 100644
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock
> *node, struct mcs_spinlock *prev)
> static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
> {
>        struct pv_node *pn = (struct pv_node *)node;
> -       enum vcpu_state old = vcpu_halted;
> +       u8 old = vcpu_halted;
>        /*

Looks reasonable to me, we should also add static_assert() for
try_cmpxhg_*() to make sure the old has the same size of the cmpxchged
field.

Regards,
Boqun

>         * If the vCPU is indeed halted, advance its state to match that of
>         * pv_wait_node(). If OTOH this fails, the vCPU was running and will
> --cut here--
> 
> Uros.

