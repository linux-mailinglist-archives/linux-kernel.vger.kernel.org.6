Return-Path: <linux-kernel+bounces-305043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26F196288E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102FF1C214A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C6187862;
	Wed, 28 Aug 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxPkfVqX"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1216BE1B;
	Wed, 28 Aug 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851511; cv=none; b=AG6THhgkqUYNLW3DdPRpdy5saU8ATtMtwjdVzda1HlJoRzgcDQacOLPlf4C6srJQJRyccRyxU2Hj1Y+rL6fmEpbXJqOJBqIW3MuIC1dNZRu0MeAdAnEA9AzU7u/eDUnoh8NCUAOq/UBpEguWC5UX3iQiu0RJrun37nN2NUntY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851511; c=relaxed/simple;
	bh=IgiiWmkaONZMDrv95lSjLISp29W4kqOAF1MsY3+Ck9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/AC1gMLVYc80KHu75c/2LNc5roNJVhixy38LZKE/LHO1TfF7Idngxi0M5XdQL4r6CjtnyJmEVkfdOupViQuGSxYvf7Qy4jwqqWWUm5deI2qMec3g3JH8mq13GfXjkjc97R70JA55H9iwiraw8E3llyrkx6VivQRggpLHNA07Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxPkfVqX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso76454461fa.3;
        Wed, 28 Aug 2024 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724851508; x=1725456308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgiiWmkaONZMDrv95lSjLISp29W4kqOAF1MsY3+Ck9Q=;
        b=gxPkfVqXMLh3JUjmTbT8oxMaKG32Hv4uHOG9HRwC95JpDTTne6ZvjILAIEWpnDYubE
         IGBaeLw/oN2GTgTc+xMm8nFnToBOWnzY53+pDt4QM7m+F/1N0K04SNycH8FYxbRA0UYT
         M/F+WV80OpF6dEHvSWD7x5Re3pqxBzZJlUvVM5tUBlQOiOxQ/O+4/K/vtMhtrbj9HkJ5
         9hhDuUyleT83pvmqNgdr6vHd1BD+xIhuo6wB0UkxLLzKNqecd5K9MgMppD7XT1jbNr/p
         ZwG+ajHV4GUR/9kDNR/XKiJ1n9fUQyQGC5KK+XPX98UhVi3IT4QYEpBjViUhUOMCP4qM
         IxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851508; x=1725456308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgiiWmkaONZMDrv95lSjLISp29W4kqOAF1MsY3+Ck9Q=;
        b=hqreNPK14qXCYytVWF9TLtExlZ4qYXVe5XdAQ39kgFpO6dhMwq23f4ZGVuFu13dZPe
         2vPNYFqcJIh1yt58eeNGjjm2lsur5OXg0bq8xo/0R2XFdmPMn/l/UAmsZof3Qku1McKg
         GEcheCetRu9YLM5WyDLm1I0RZVUwhFywu7MfI0Styc1DFCyPycoNxP631Yr3Q0zuk4T6
         F7+ceGz85Kvb/8XdYnj63poO+pVopun/LR3ia2HeQVKVo2eXkCDoTaBMMKjb8CwZiE/0
         dLUDURU5HG9k5lYXm583O6or/rvu6+BmAaaorDVeTVN68ykweJ0uAyNkwgnenI7FXkr5
         PWSw==
X-Forwarded-Encrypted: i=1; AJvYcCUNPu6CiSJzEFc2z8T0Re6El+H8yLEtASWIxclcm+ld6kvr2hXYu5WfkVfZpncVzpWTkeYl/frhun3E@vger.kernel.org, AJvYcCXKIYZknQUUawyE0rw2d+A0jD2CuekxDK17ThpkVpV5ccxi/d4c6gKcuE33l34c4aylV1eJmr6OmHDf+qGy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4eIexSpVawDKcudv86eLjes5PvY014F/D5DguzMRZ5Br7sJf
	5dQ0PiSCquc7GW1KHsUSBZ9c/AxFZ4GDoucHx7UE6hvL4S04xEA7vFyesNX6kDsTuy06e+d/GJv
	wtnOvW7ulKb1p41o8DST2wXeaGXM=
X-Google-Smtp-Source: AGHT+IGUdU+h+hht4AnIJHIpk5GDpGgevmNBw32u6Cg0ojQjMizUfieIlJnFQWDOIjZW9gSubMvP7BelF8hDq6Rw/2I=
X-Received: by 2002:a2e:80a:0:b0:2f3:e7cb:ee37 with SMTP id
 38308e7fff4ca-2f55b64108cmr13324471fa.8.1724851507882; Wed, 28 Aug 2024
 06:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828074755.1320692-1-net147@gmail.com> <2502361.uoxibFcf9D@diego>
In-Reply-To: <2502361.uoxibFcf9D@diego>
From: Jonathan Liu <net147@gmail.com>
Date: Wed, 28 Aug 2024 23:24:56 +1000
Message-ID: <CANwerB0NUFyJ1egYNEAnhdqSyBTq41cSKKC0bAbKudZAPx8UfA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Enable RK809 audio codec for
 Radxa ROCK 4C+
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, FUKAUMI Naoki <naoki@radxa.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Wed, 28 Aug 2024 at 22:59, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> Am Mittwoch, 28. August 2024, 09:47:53 CEST schrieb Jonathan Liu:
> > This adds the necessary device tree changes to enable analog audio
> > output for the 3.5 mm TRS headphone jack on the Radxa ROCK 4C+ with
> > its RK809 audio codec.
> >
> > Signed-off-by: Jonathan Liu <net147@gmail.com>
>
> as it looks like you have one of those boards, could I possibly as you
> to take a look at the vdd_cpu_b and vdd_gpu nodes?
>
> I see (and devicetree check reports it too) a pinctrl-0 for the vsel-gpio
> without accompanying pinctrl-names.
>
> Could you check if things fail if you either add pinctrl-names or remove
> the pinctrl-0 entry?

I tried both but neither resulted in any change to the warnings in dtbs_che=
ck.
Reverting my change also results in the same warnings so I don't think
it is related to my change.

Regards,
Jonathan

