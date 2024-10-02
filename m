Return-Path: <linux-kernel+bounces-348230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B1598E462
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E96BB21FD1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5C2178E8;
	Wed,  2 Oct 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JaQazNg0"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5B1D1731
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902018; cv=none; b=h2+v1ziwsYWS3iw2ZZKLce+07RhI+kyE18dcfr8AzcJadG2Rfzt2hEgMlqrIsAMphvCMRogH7bVRjY0W/nhbr6pinbHzQr+WMbfds+3JXAHv3Dgkl4jYLVqEZAlsL0JWfBR1Z3F3M6UYKP/XfRDT/35JvJJfQXrk0cCVCxt7w+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902018; c=relaxed/simple;
	bh=w5jMYwKmB8W72lN6W7VZKsy2T+c6dYOH/2CyYO3mAiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbhcjEBNQPNGnE2OeJmlt+zXuEAbhz8NFA7m/gGm9n0rXIW7f3r1d5q8a9ja0b1fTaf/ezCJLImq1FENLsOoJtOE3RIzmIMouzq5XwmATmo1uRjart0lP0418ArC8c37a6VzQJZI4FKP9gBcacl+HTjE+XFlHF9+3CsHQSm6z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JaQazNg0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad15b3eeeso2641421fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727902014; x=1728506814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5jMYwKmB8W72lN6W7VZKsy2T+c6dYOH/2CyYO3mAiU=;
        b=JaQazNg0xPkvRDrDKidouaErF5RKM3eqa3byr0VuUFkEnOAdQvPSS238g1V51a5vFF
         BAjSf+Fvc7AGUpI0Naub7wFmKFSgSVJxdbnAxZAsbIiLcGxLZtWUDkdLnxo8aFOIHQ7I
         rvthHiXcfquyZ5XFUjcwTL/LYDfLtXtsJnL6x0TWfQA2Le8RRZhesAWfaiWVSpoMOrAn
         B+H9dBJdGx+Mv944036pqW1hT6sbf9f7FifGXIbqceYYke8Cy5V/HmC0wA+jl7uHk80X
         wgih+1XQW6vGb/3d9WKakZcQ7RNB+kPvp60EaYdXDeAt9au0lS8tVJI8JKyeCQaGvGhb
         juOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727902014; x=1728506814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5jMYwKmB8W72lN6W7VZKsy2T+c6dYOH/2CyYO3mAiU=;
        b=EHkzyI9Cb8yGFZc16Ap0uaE7B2PrpOWWyK955BaMmglmA8TcVq0LJZ1i2h6In+Jhdy
         m9kmxLAFPxZpFvkhtWmx2acT1wds4NUptyhZ4e24FSwwi/x2vMQOip8YDL5HutNfvPRh
         nwgUgdlnCu22rpDyI7MfBw4wuBQgNDHNWaL2hqkc81DhW+adduXBxpUhwQ7mQk6CP/L5
         5Tz3alq+3KDhnFu4IpeP3dUIIVR9ulNJleK0FHC9hoOoHeUA6e8hUokc4S6ecLgGh/5k
         WcPyga2El80xwSOsbIzeaxX9EESFhFnMq/d420od+k5frP2TxlMZcDx71+mvW4JoC02U
         1hgg==
X-Forwarded-Encrypted: i=1; AJvYcCWdDqU5I16q4khQAkpQnPa4qNqXrkPaZLN4oabNqe4ofEn3IluJGwTEFi8J0Zz12H6QzfabzRCUZ/5e8yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkCzkhF97ZMjOKDD2oFcF0JW6bTpobbj5HT4dEBv79wr/nYGbP
	f4XeArrH1rNHGq62O+fKZiSG7HyjSMIEzwSuchsDerCelkA7XQrXZpzyFsBLMBUnI1hjgZIq1ZG
	7jW6HGonxsrJn0iUqGQZME6WhShEaOLJWL/R4fnWq9nRX4cZR
X-Google-Smtp-Source: AGHT+IGaqhCOQr1G9HU8iZ6II2tGNhnTjzBxP/KS5MJN/yVHuuSAlXhMx8i3hI3s+b5zUczFp8Dm6bqf+ETUQcD6z7U=
X-Received: by 2002:a05:651c:210e:b0:2fa:d386:c8a4 with SMTP id
 38308e7fff4ca-2fae103c83emr28985081fa.12.1727902013866; Wed, 02 Oct 2024
 13:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-th1520-pinctrl-v3-0-32cea2bdbecb@tenstorrent.com>
 <CACRpkdavPAv2sPRREQhx_A7EtOj6Ld_n+NcO+vH0QCnfVedXKw@mail.gmail.com> <Zv2SUVv2PUYqwOzh@x1>
In-Reply-To: <Zv2SUVv2PUYqwOzh@x1>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 22:46:41 +0200
Message-ID: <CACRpkdZRg+k=N42EA3+3c4Er=DHf2Q1aVzzCM0OQuEx7xWMAvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] pinctrl: Add T-Head TH1520 SoC pin controllers
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 8:35=E2=80=AFPM Drew Fustini <dfustini@tenstorrent.c=
om> wrote:

> > Then I merged that into my "devel" branch for v6.13.
>
> Thanks for taking this. Will that also end up in linux-next eventually?

Yes next -next.

> I'm working on a TH1520 Ethernet driver which depends on the pinctrl
> driver. Andrew Lunn replied to me that all the dependencies need to be
> in linux-next [1].

Well compile-time dependencies for sure, run-time dependencies
we are usually a bit lax with as long as we know they will
get there eventually.

> > I think I'll make a stab at using guarded mutexes etc and see what
> > you think about it!
>
> Do you mean using scoped_guard() for thp->mutex in
> th1520_pinctrl_dt_node_to_map()?

For all mutex and spinlocks in the driver.

Yours,
Linus Walleij

