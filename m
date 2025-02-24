Return-Path: <linux-kernel+bounces-528346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972B9A416B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800E31701C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F724061F;
	Mon, 24 Feb 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAi1tzoG"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1523F40F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740383834; cv=none; b=JWQtnQtrWG2dmIjw87JL7ULEmi7AYwbP2vlm/P+R8JF/hmz2+7v5Kb6RSdbnj5SFwAT8tqrSmsQdSLFH7lvCLH988nz2eCGFzPZOMYQZPKXkMLfwhEn9wBWKOrBKQg20fcipYMDVwpAUhiaMFr2TVCXC9P1zO/q5vFENl3rVtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740383834; c=relaxed/simple;
	bh=Juv7g0Uj5bLKb3s/0g3g4OyFx8+Nyhc41MmHQVT/9Qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwJam1AHZknkikrs0rWjKA7E3BI86cmCnXf9bxj49UdTFR/TY0ypoMHEpPhuRgcl6IW3zxERH/+P91WvK+n70DlJVv49g1O7PFeKihMnyfEvk+/sDW/wWcSibxhRjihQ3PsXZV3IiCrw3oCMmxHeub+iEXp4Mtx6uLkqNx6JmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAi1tzoG; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a69c1a8d3so12804541fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740383831; x=1740988631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvEugR8ULzP3PSWqt1pest7RsDy+r+SCuWz6MkolMlM=;
        b=aAi1tzoG3X4+cgrmGsSnGGuNk3RYKOtSu4Y0GJ1kAIUMShowQ+alVzGWfy75dfs+8A
         QWKzn8GO4fHuNKPbgid5DAjmWKja+FW7rp8HwbvcpaCBloA4XwnPtQcCSEM7PjDDFeIO
         pV/m+Hxh6NKVcePy108OlxdBbiw58sgE7hnGtWJFOcTJasanUbJ4EH1zrenpp/igLXvL
         qoMECWaUED9mOxOcwhQSBwUPG5O02icSaQ+SXOect/sOq3GPTbfqLvPcwwQAE4VUimzO
         Mr4TddEO/3DxNW68+X+gLfgWksikAfErq9kVaExdqgQ8qKamQXXGOiL6CXAFtrIKkdw9
         ImwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740383831; x=1740988631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvEugR8ULzP3PSWqt1pest7RsDy+r+SCuWz6MkolMlM=;
        b=gSkpk26rfVAVNxRmXi6LA/cuMILG7+UCgNCx2+A6pd4k9dpgOveIvFvXS0ffH+/zEZ
         E5cXoS/ISF1TcAE4AVhbkwOFQ1sN5kI0E33GJW6THF8nPuOSg0pwz0v+LbrvnJQL+xSS
         UtWu0BLh0CRwnNPiYyE6ZuRm4k1lU9Cz8dYKFMgomM7v4z7DzFXkvEU27y0Yuk2gmpl0
         3wL+PXuNZ4vDODNKJgJtTAeyx6ZDsN89B35uq0Bx2XnyRon8la2OBhwOz+A/toi2yubJ
         YPjv5QxBCujeOOvj4+ZtTZ6+yp4PEK5R4PMB8BqZL8LUvgxR9BXHMBZi1UTfyxSqlBuC
         wDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxLpK7ORcimj6hmfT9FSXmbSGtZE0LYRJLxhkGJIHllcLUU7SnhL7Pe/1ty2V4b4GZ0Gc0xh+nlcTMe7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkrN6t/wDwqowcSq1VxVbMu7I16w1cuLXuG7e7BzC3mHLk24ez
	yKFUC4yRRzODJw0HDxBUp9d2FNxoXe535vBNwzUlItdvD/H/7MCNuieKBllaoEJINdPzvoyIc8W
	jEjK1MYQ85u1SuBUAlInpgPiMDOU=
X-Gm-Gg: ASbGncu+HADP9mP1OCHWzpYKdANtkiDKN5lCsOT9lnG0yKhMKGIPGd6FaU8pkiLISOb
	QbIi67AYvIEBKROp7u7fvZ0a/h76bc4MeW0Zhm1lK5uCk4sa2OErnXGre5s+Hh4wxVJ+fiU9F5I
	xG97S3AGk=
X-Google-Smtp-Source: AGHT+IGEUbxK2BnXSNJgIoMGVWtq7TQMBScMIbMwnYsfqZo3ipB93dfeLkaUXfflrTqAasv+4n8Nt4tL0NHjLVagxnA=
X-Received: by 2002:a2e:9590:0:b0:307:e498:1269 with SMTP id
 38308e7fff4ca-30a599a2963mr39338291fa.37.1740383830995; Sun, 23 Feb 2025
 23:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129154920.6773-1-ubizjak@gmail.com> <31e1c7e4-5b24-4e56-9f17-8be9553fb6f9@kernel.org>
 <CAFULd4a4qbMiP3dYXDp0_vPapkoi-i-ApOY5pHfKG1h7=vfbbA@mail.gmail.com>
 <43c41ab4-1771-4b01-853e-08e1689df7f3@kernel.org> <CAFULd4bTYudfNap1trVyjqA0xv5cQQeWxSZ8numv_uHqxz1Afw@mail.gmail.com>
 <ef6e2925-f005-41e9-bc24-b9adc3922706@kernel.org>
In-Reply-To: <ef6e2925-f005-41e9-bc24-b9adc3922706@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 24 Feb 2025 08:56:59 +0100
X-Gm-Features: AWEUYZlR97mHCK-c0w8i8CLrxUlGGuiOBY95Y0vHmKkCRe1EShY1C4qF_X6fOUM
Message-ID: <CAFULd4bR37GmvXC1oqbwry+HtZ0JqLz432CK69mSNkDsibmDaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/bootflag: Change some static functions to bool
To: Jiri Slaby <jirislaby@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:48=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 24. 02. 25, 8:39, Uros Bizjak wrote:
> > The internal compiler representation of the following testcase:
> >
> > _Bool foo (int x) { return x; }
> >
> > is:
> >
> > --cut here--
> > _Bool foo (int x)
> > {
> >   _Bool _2;
> >
> >   <bb 2> [local count: 1073741824]:
> >   _2 =3D x_1(D) !=3D 0;
> >   return _2;
>
> Yes, exactly as dictated by the C99 standard.
>
> > }
> > --cut here--
> >
> > For me, !!x in the source means that the change of types was
> > intentional. Surely, the compiler can do it by itself, so at the end
> > of the day, it is just a matter of personal taste.
>
> I've just learnt, that we even have that in CodingStyle:

Ugh, I didn't know that either... Thanks for the info.

Regarding the issue itself, I can create a follow-up patch that
removes !!x, or perhaps we can go all the way and substitute the
function with parity8() generic function, available in bitops.h.

Thanks,
Uros.

