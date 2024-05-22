Return-Path: <linux-kernel+bounces-185974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E521F8CBD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BC71C22140
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A3880632;
	Wed, 22 May 2024 09:13:51 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A37D408;
	Wed, 22 May 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369231; cv=none; b=GdU9kPQ+BLgFdBRLkBVf9N6gbFL3W7d/Ni7hXSi0Lzs2yKuLapw8NHlxB2UMZ4XflTjPaFFyG+XpETr3WhCcCNiRA4+ywz6s0roaDaLpu7jnmmf5MXKu3UR98ItrdYk8Eq7/iwCvhf8tilVbWwsbqrTMEDhO6J6pBLYpMXEiDdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369231; c=relaxed/simple;
	bh=AuSfgrk24FDMN+9WMVPugcETHuqlogourrnVh9GS8OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TACpjJDmruGG2kxBghEF4/7Gvd0gCJYdFoO6WVH4mt3+Fs5I80hjgscyQOXEMiB6JYAzvfkvB0bv1s6D1GbHpSk+WrpqwRz2YSq1Qq1/UioslOtjgnITygvcZVsoeXQPVB9yK+MbMh38m2lZ/Z4NHru9gHckxGeJyVh9iK/SoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6181d032bf9so6515757b3.3;
        Wed, 22 May 2024 02:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716369228; x=1716974028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D77FJbeI7zjBlfIfP+J1Pj7HEl2BfXUwLgE2ROEWK+Y=;
        b=fQ326npfEYoisciei2bQozNSciD3C4ryiReBNyT/HwNuJPX0y9KnFFc/vvGDyd0q9U
         KXiphSoVvVTAMyM1nsmsRnt735q1jL9+jR6ilaVEN9qrjtmaElXx2r3g0vGzAmE90ji/
         Wx6nQTeguFWNWvRTdzc//y8WchiyO97bin25qenrECkuBQJ6f8XFLbym+hZTOpiC5/Uq
         T0tmaTRTtDU1Cyc41M1OWrYsQrqm66jFcApHoH0NNBGmiuRNhkWyP8VgEL8hFCMko3Qd
         3rZfRSQhIS9UoySR4QA4ybne+ROX9XXxhvotsXqR0DD4dDWBlygNdaGAi5HGT7VJISYN
         iFTA==
X-Forwarded-Encrypted: i=1; AJvYcCWJaGEu3n7nQbQ3lhaTybXw5DcQVyC1aOtso3mKEV6EM1zBsvAZn/iJYl2HZr+Dg4/vhC2q7kfaBdcodThWDbn5/AUhbHadWsU5yqU/aCuK4ZrgYyV3NIMXVHK1AuelNQb/mvJyufTylA==
X-Gm-Message-State: AOJu0YyAphjyOKVuY2L2M0vM8feV9efZiAH2a7Z04HazgMzDofyJirQ4
	GVoJPnnW60MC1Da7KO2OYnH28gZ5eyAKURqnJKkYSAeDT/fk4E1iAIRmuFQK
X-Google-Smtp-Source: AGHT+IH2nYMeEKK/rI2XXzH79//ViJ8zpyThV+wi2SJJbuC3yc67ntWVoeAioMlly2jeA5clnJ2b7Q==
X-Received: by 2002:a0d:db08:0:b0:61b:1bf5:67a9 with SMTP id 00721157ae682-627e46df502mr14757867b3.22.1716369228463;
        Wed, 22 May 2024 02:13:48 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e346042sm58273877b3.83.2024.05.22.02.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 02:13:48 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so1171560276.2;
        Wed, 22 May 2024 02:13:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXO4xOIoSndmeyfDdGayQUROv/XQHizoycBN8eN7TB77JjCxKz3RcL+DfSMT/Mm1MIS8lBRdwzV+8k23lka4o1CbCS5y4Z84dw5cwrjlqHSvZVpFXORVL54r803ZIhcddHrRRkOcXF7Pw==
X-Received: by 2002:a25:8c03:0:b0:deb:cad4:796c with SMTP id
 3f1490d57ef6-df4e0abcc3cmr1418661276.22.1716369227968; Wed, 22 May 2024
 02:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515091925.24353-2-wsa+renesas@sang-engineering.com> <nsozpsifnhpmsbrzvpttmiu775mhm2oq54hycjvc2wa3qtoukh@wpigcux5tkyr>
In-Reply-To: <nsozpsifnhpmsbrzvpttmiu775mhm2oq54hycjvc2wa3qtoukh@wpigcux5tkyr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 May 2024 11:13:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEGK_=89YNgZSeGJki6ibdtkdP0PmX2L-ony2=L3x+=A@mail.gmail.com>
Message-ID: <CAMuHMdUEGK_=89YNgZSeGJki6ibdtkdP0PmX2L-ony2=L3x+=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: gray-hawk-single: add aliases for
 I2C busses
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, May 15, 2024 at 10:43=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> On Wed, May 15, 2024 at 11:18:51AM +0200, Wolfram Sang wrote:
> > They are numbered like this in the schematics, so keep the names in
> > Linux the same.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Hmmm, Spider and WhiteHawk are also missing this. Shall I send v2 with
> these included or incremental patches?

Please send incremental patches.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

