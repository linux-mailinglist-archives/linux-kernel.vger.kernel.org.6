Return-Path: <linux-kernel+bounces-524300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE4A3E187
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CFC16DF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DF12147E3;
	Thu, 20 Feb 2025 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBAWYeOn"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E2720E6F7;
	Thu, 20 Feb 2025 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070354; cv=none; b=EghL9bCrgpWDrc4n3tVV3iyIxjhz8glEpNeWHz2zSRrmh6sox4al6Vtw0n6g4tekBBozuGuGJDHG05HQLxLl8y25s6pwxfBhszW/SwYz9SDfeBWNO6aigZzs30lwJr5hOSllGiEteWigjff11eLzammR2LpM5J9aeje43ow+FAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070354; c=relaxed/simple;
	bh=fa7LbJLhmvYvV8BXLBCfBB2n6hXZJeZ5Eo5qzrXiJUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heqczE88uAU56ekI47YKXXGAxsfU/E7rDMjqVftbOcpvoTQ6EfPnBZtRUHMZBz3t0wZ3w4EpF4/HATTQe8ZiLpHRrNt4TA6FZ2TP1vJkIMaqUsX4Cimvw06vObl4RUUDTu0XnTv6f4Ph8Hs61MCO55XJ+FBY5U7o+1Tz8/ZSmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBAWYeOn; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5452c2805bcso1344576e87.2;
        Thu, 20 Feb 2025 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740070350; x=1740675150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LAKMwvAmNdWCPpYvxLkRI0MMIHLbof9NaOcf6O5TxU=;
        b=nBAWYeOnXNRQe+MZW2D72MuL3g7C8tuBS+0+KzfP17yoUpCAHBd5bI3mKvm16jRZ3i
         uwmBWK3S0yw11fBxUT4pYSPuu+RxIZLGeDC2ZusKhfg7suua67Y56Fm2MjDVJf0zlI2i
         4Stm/fh+gqRL06zssWMqaVkb+kNlKJsN/fayii6QhP5lWDXsovPFfuyfYKe1hvttm7ga
         Q9CHtj8GMbJH8ef27TY/tbnhLsmb7oBO/WD7k1PDPrsR15Rqpk47NKpKVTr3ZJ54AIwR
         k0lD+eKcnvOdrx1FrDbp1AulFJvpDgM4j5muHhzHthRHC1pceHhM1OLZxS+fPjnbBqhL
         smzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070350; x=1740675150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LAKMwvAmNdWCPpYvxLkRI0MMIHLbof9NaOcf6O5TxU=;
        b=GKlucTYvJIztyYxMEFhIQu8HIodAhhHoCgbySbv3N1wEPZgN9W/UFVOTIM9VwIueoj
         Jp4+fbZmWVvuBoxGm2nun/wi16dEMnaqemT3Id7PkWpmmPpXIwzOH9ne3ZyOcopXndEB
         oGvRHE82yXWqUnPuwIqXRpc9kN+P6RzH5XgRSl42psosBmgYIsKroHw7G138xBTww+WC
         lND3N8g2nuNUxqZ5iJOil3vM3OKXwn1RYrBCC8w0qYvdeeDLrnhAuiCMCKcnnNTuxPV/
         JEdbFqAv1eL/DZl4Kf0ZU5HbGOzdgJivzqb/L3HslRA0kzl28MpTl0BOL5GzOXiBQaYy
         Sj3A==
X-Forwarded-Encrypted: i=1; AJvYcCWsKqT8S/PJoV4EJ/Fjop7TS9lZ1mZ/jE5rZYmBir6YhvtYLYD6rmSJFafFs775WGD0E3K8f0ol3+3Kag==@vger.kernel.org, AJvYcCXBIqevCJ0yxOlGnO06oQVUK3/N4wHGWebDSKcWPza645+zuIRL2VaYSFhSKXm7PH+orgnzHW/+GQXGaGDH@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVBnXNODytjruqESqIiynLMmJpHBj8oELJnHqpS0Y1x2g2OXQ
	g4QR1tzWx+0W//AFX5M1N87IhxnqlkeYRAMv4njvgqyiOHR9puv03C0qk2PdY9aKyeLQ7FQl2fy
	G4HmN6uFiXDRcOAzrw1J/89M+P2I=
X-Gm-Gg: ASbGncvmp8S+x/jdaW4dnAOTRTwUZHcb94gnlDLj53151UoO7669lryrtZZdQ1vPmBN
	viLCW/1MrijCVUeYtnXOdFKr9qFr0mPnvIwCZm1ZOUuPWKLn9gHrNFyFQUHUkF1ArbraXzDI=
X-Google-Smtp-Source: AGHT+IFLdBEhYh9DzTyLf0JEty98KSxhk71TuMOZBqu5nMd+aZFhDuv77Jwv7YKX4n4UCB4F+Spry1Z70uOrtzOCTgQ=
X-Received: by 2002:a05:6512:4004:b0:545:e19:ba24 with SMTP id
 2adb3069b0e04-5452fea60b5mr8641391e87.48.1740070350326; Thu, 20 Feb 2025
 08:52:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk> <CAEdQ38GUr2_0rCiN6GxE8rk6ex5m-Y5do=QdgKi-hb=1jMGj-w@mail.gmail.com>
In-Reply-To: <CAEdQ38GUr2_0rCiN6GxE8rk6ex5m-Y5do=QdgKi-hb=1jMGj-w@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 20 Feb 2025 11:52:18 -0500
X-Gm-Features: AWEUYZltfbdVJ3qNWcv1zEbzl6Geg4hDatJ0AnfgA4y-lBstyqiLlsWGUbqXjdg
Message-ID: <CAEdQ38FX4M1hKMgmNJD7s_eVa4-_J6e9+xCqTw653wbw8BNPWw@mail.gmail.com>
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data consistency
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@unseen.parts>, 
	Arnd Bergmann <arnd@arndb.de>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Magnus Lindholm <linmag7@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:46=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> On Wed, Feb 19, 2025 at 7:46=E2=80=AFAM Maciej W. Rozycki <macro@orcam.me=
.uk> wrote:
> >  #define OP_INT_MASK    ( 1L << 0x28 | 1L << 0x2c   /* ldl stl */      =
 \
> > +                       | 1L << 0x2a | 1L << 0x2e   /* ldl_l stl_c */  =
 \
> >                         | 1L << 0x29 | 1L << 0x2d   /* ldq stq */      =
 \
> > +                       | 1L << 0x2b | 1L << 0x2f   /* ldq_l stq_c */  =
 \
> >                         | 1L << 0x0c | 1L << 0x0d   /* ldwu stw */     =
 \
> >                         | 1L << 0x0a | 1L << 0x0e ) /* ldbu stb */
> >
> >  #define OP_WRITE_MASK  ( 1L << 0x26 | 1L << 0x27   /* sts stt */      =
 \
> >                         | 1L << 0x2c | 1L << 0x2d   /* stl stq */      =
 \
> > +                       | 1L << 0x2e | 1L << 0x2d   /* stl_c stq_c */  =
 \
>
> stq_c should be 0x2f, not 0x2d. Looks like a copy-n-paste mistake.

The good news is that OP_WRITE_MASK appears to be unused going all the
way back to the import into git, so this doesn't indicate a problem
with any of the testing that's been done.

