Return-Path: <linux-kernel+bounces-411939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBA99D0184
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3E0B23D5F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89D34431;
	Sun, 17 Nov 2024 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TCycQ35F"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFF1392
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731802650; cv=none; b=PGkUrXooPMB2elX6RgiLCXBK4w5XKzvbwcQgv+mWsmOjsXSHzf/9wSGR1rPHN+S/wSL3kd43jh6ebl5Ga78D2/AUWDggPnnkQYZp3PRMP9bPSyO5cR9EoUso/LyMd0KYPnpcGfiXXh8Au4HNjHXFjs2Qo/zpBdoET0EzUb48bo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731802650; c=relaxed/simple;
	bh=1Nqxs9q3mTk8yYp9yleEw57lik/PJU6/xEBFJRFNcEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpdM7pFdeQwAeZGzmfunyZzrdobLQ8dnCMo1K2tyotkMAvtxPS0U0SNEh6QRuR9nXlHjufOoNyAvJf+YNo4j0+X/pr14JnSDqeI2cWb7R6xWEha92BrncaOELY/GWuznb3p7oXoCukGs3lyBT7PzoREY0ZhDDVdvoWUlBYbtVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TCycQ35F; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fb49c64aso972753e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731802646; x=1732407446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+vJsz7FXCzpM7ZnAh9+lq2u44q1RCsUt4nJBaoI93s=;
        b=TCycQ35FlFaTBEhzo8EMmg/agj7tWMBfJZe41KkhiSrOkRnvscMoigmew6ZprMMswt
         U2E+OUyGMiz35WYGsm5SOC3MmXzMnRceY0Acmj9W/xCOIhWAf7llvse0MkleAYlTioG4
         KfStbkhYM8J4E430ve/5gG3zQuZCU77kY92ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731802646; x=1732407446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+vJsz7FXCzpM7ZnAh9+lq2u44q1RCsUt4nJBaoI93s=;
        b=BrAKAX18yamE6sSBv4lNPehdxo/NHObl3ug2UnEs+6YZlasDf+AAS6xl6tG/0/HHpT
         hJ/SacoRpH6sqNdAb0PDtUXmHn4Vz5H9uJ+28VgkzzEzVokePKsCfhJpgHi2smNxBSk8
         5+/Y3TVIkClVeU+1757qQSRK8Cr2CP0rGSQ4kjBqvhHsro+5M4imfQm0TjTgydKxQ2Od
         PbJudk68HX8GSCwPJe4kTl38TOWnolqlu78lbPHkZUmeF/+lqZpItl3v6+IuaPR3T58g
         9IrjMW6QJWoY0AioFf8CMIrlaUbHGpWzpgVGC+tnTwEt2KY+BVjfGA6rjU9GlnlVDt+s
         OzAw==
X-Forwarded-Encrypted: i=1; AJvYcCUOkmDOmMB4sJK429geCO32s466HV0w9BqbNcf6TvU3hdZSeZJQASqe1u5313SbFBLF/gpImD/4LciFfm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMibtQCm73H66rFILTZDPBIfw4/dISgCDW1YUPTOTJLGV/jowJ
	SjHUxC4on1hCBJ+Bsk+YQcEh2ukm6qAq3JTMrqErqJwx7CBFFVnaqESP/Zhi1g1Y4RHckZQg4nR
	cKS8=
X-Google-Smtp-Source: AGHT+IFrFBNOzEzeSnynq4KzZ6HoltBeCIWwipNCsJfKmJdYg6vc9Qrax8SkxOhkyOHJTU8wEsOYbA==
X-Received: by 2002:a05:6512:3e1f:b0:535:6951:9e1c with SMTP id 2adb3069b0e04-53dab29ead9mr3850621e87.15.1731802646042;
        Sat, 16 Nov 2024 16:17:26 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df5690csm359529366b.75.2024.11.16.16.17.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 16:17:24 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso13165735e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:17:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxx0ov6j5hONFDYqw1Kmgs2C+XDnTJVJ+kZzCiValfrrL0oiNTuS06671DVEWGXJIvOdK7ZmQZg8A/eow=@vger.kernel.org
X-Received: by 2002:a05:6000:1fa3:b0:382:5af:e996 with SMTP id
 ffacd0b85a97d-38225ab7a3bmr7775914f8f.46.1731802644402; Sat, 16 Nov 2024
 16:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116153556.767f1aeed6ac628a09efe346@linux-foundation.org>
In-Reply-To: <20241116153556.767f1aeed6ac628a09efe346@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Nov 2024 16:17:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wji0ErHJjX-ZE4fdQ02nxcqQa5pwV==1sHC3p91wxUXAA@mail.gmail.com>
Message-ID: <CAHk-=wji0ErHJjX-ZE4fdQ02nxcqQa5pwV==1sHC3p91wxUXAA@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.12
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Nov 2024 at 15:36, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>
> Motiejus Jak=C3=85`tys (1):

Ugh. I've pulled this, but you have something *seriously* wrong with
your locale settings.

That should be "Motiejus Jak=C5=A1tys", not the garbage line noise you have=
.

Please make sure that *all* your tools are using proper UTF-8 and
Unicode. When you do

  $ echo $LANG

you should get something like "en_US.UTF-8". If you have something
like "en_US.ISO-8859-1" you need to set your machine on fire, and
throw it out the window from the 43rd floor.

I can see the original at

   https://lore.kernel.org/all/20120315030631.GA28296@pierce/

and it has a proper UTF-8 encoding:

   From: =3D?UTF-8?q?Motiejus=3D20Jak=3DC5=3DA1tys?=3D <motiejus@jakstys.lt=
>

that you have broken somewhere in your toolchain.

I have no idea where that breakage happened, but it looks like
something treated '\xC5\xA1' as two Latin1 aka ISO-8859-1 characters,
rather than as one UTF-8 encoded Unicode character.

That something isn't "git", so it's probably some effed up script of
yours, or the fact that you have some 16th century locale setting.

Please fix whatever horrid breakage you have, and get with the 21st
century. Latin1 and broken locales just aren't ok any more. You are
mangling peoples names horribly.

And yes, your email was marked as

    Content-Type: text/plain; charset=3DISO-8859-1

but that's only the tip of the iceberg. The name is incorrect in your
git branch.  You really have some totally broken setup.

              Linus

