Return-Path: <linux-kernel+bounces-553040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66538A582CA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AF91889DA3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAB11AA1D5;
	Sun,  9 Mar 2025 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdrceUBt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944811FB3
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513581; cv=none; b=M/FKGs+JZ3RI5jp7mRR4gC3MoQDuAAzjw/r2ZFwOfaTUjKf3Skho/+d8FWKWLVPhp4MZJA+hzrUHRS3GHF+XiGZp0iHzsgQibLO1Xp9VDK8UFZ3NpMvctO5kYNdX1wIea3BMdAaiQlLf/QVlrY1iWx3tRgQgtXHjrBkLCYM3KxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513581; c=relaxed/simple;
	bh=+HVJjVDCgq4y4PmECbHUGGaP4dBM6OeOZZaWwM5EBG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+4prXJCbUSu3TQz46q71V8+VrY+ZC4HeNa+VR+xozEO2t3u6MczAH/VJrkjjbr1b5/nS5LHY44dmgzjuBn5YZTKkzDqQ+1nChqJbLzi0ualirwfKVWFKpgvW5/levvtkJENMWKJqhTy0jHyurqUzDO7x8f11lNltok/33POvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdrceUBt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso3614665e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741513578; x=1742118378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zihTM4zMdZGsymohibQOCTVaMWIjUuZxrFcX+I+At9Q=;
        b=CdrceUBtSVUluB3ywMxur8Le4SgtqLkwQIkiw/VmH/IGiTkbBC9iuhN+vvambR53kn
         /PLxGPYaAAMJ2uh6G0GoDFfibc+/a9zAQGszPFICwnCI7MMW9bgoLtaPQkIATxbL8O33
         Ibx4YnUkGjSckrEeoHp3rD2tHL6MM/EUHevrfZeCMfk1yQgvGDKQ+TGeznJlng4V3g4d
         ATFhN2J6yHF6J9ZdJU+X4G0tjwXfK35yFx23tRZfQplY0JcCbuxO0bO6tqe+UsONeZD9
         /HJUmLulqBbOWPIkz9RDhnhbQ48XMLU+bM+9iQi4xIhb+7S5tSe9t3JNK8xyMotZ/5O7
         DCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741513578; x=1742118378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zihTM4zMdZGsymohibQOCTVaMWIjUuZxrFcX+I+At9Q=;
        b=DSSXpT91wMDN/1W4ehdl5EPwYZf+mkezU4vLoRdv0S9sF7K+/ze+5Zqd8eChLbbOpC
         yFGSnaDSQRNk6K4UOWskJqbDzNBiqzRJWArKb6P3cvLp3suarq5ymUCj7NwN2u0pcOJM
         rVL+Y2c6UPsftvwM0FmpM+7kDOO/OSddDd5zzXPA/B89vQaVV2epYSLzlnOsUjzWWtdY
         qE7pfrz3w7ZImauq/P8sPa3SyJeMY80siXiYtuJ04w0JjHiX228oBczgkYbCmnlTgnib
         ehM4/1D4Cp1qtCokYaA6T2pmq8UFRGt2Ms5O9eEYzLiOjPZ7nXT3t8UPMHNlaA7+W8MV
         ypwA==
X-Forwarded-Encrypted: i=1; AJvYcCWd1ZhI6XhgQpnJV7OyS8x+x4fyXH7uMxhbG+NoHp3y+LT3LKQUbQ+9qhihwdUzIDVxA8CfkMxF+fH/tHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzkULx0SWkD5RWNwPlbNJNUiVIuWFox5vUyVTC+IE/6+9uOnyr
	W76qlCnwnuSy1qZI/hKhLZUcNW/s1hHo4p+VbFo6Sa2n+HynkY55
X-Gm-Gg: ASbGncutM/zbGW2N5sH+bVfGL5yNE4QCjUs2sWQls7OG4eHwr+D2SEmgMVVYPBX0Qjn
	x72fNV3sVgPAnsy5anOF4Aw/ReFVIyCU1JfKNv18yQ68MbKD1DK7Gnu1jzkj9/uz+g46/ye4mtG
	UpPE/xshM3GUdMRCyapfxLewg9ttGY1fqUf0aoMIPmZw8BG4qY8n/vREJalPAQ5NJBJBnaKsUIg
	eSZwsHSPMQVa5aLs9Nz5gBYFOInIEvWf0F5LnY9izx/TAjgUbq1fJ93cHnsk1Q+IFqFdWpaWum8
	DYRtVkyKMzdchbBdyBQexlOR8kC+ZJfgWjz+mdj04G7vAKmRd2Wo3yMb5L00g1Sk30sCWICq8Qt
	g+T7suwE=
X-Google-Smtp-Source: AGHT+IGDPRS3ttlgxZwgwYwFForfnB5iqfbIAVODu1NEXLbUiFOpReOc7TnAHtnvP9mwBr2zV19XOQ==
X-Received: by 2002:a05:600c:4f09:b0:439:92ca:f01b with SMTP id 5b1f17b1804b1-43c601cf234mr65628965e9.13.1741513577597;
        Sun, 09 Mar 2025 01:46:17 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0548sm112598105e9.6.2025.03.09.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 01:46:16 -0800 (PST)
Date: Sun, 9 Mar 2025 09:46:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <20250309094613.50e930de@pumpkin>
In-Reply-To: <CAFULd4Z0FugNh7+6c5Di_o6zKTNOmkNytEpn0kfPhinFQEOSzA@mail.gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
	<20f1af22-71dc-4d62-9615-03030012222e@intel.com>
	<954c7084-3d6f-47b8-b6cc-08a912eda74c@zytor.com>
	<CAFULd4Z0FugNh7+6c5Di_o6zKTNOmkNytEpn0kfPhinFQEOSzA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Mar 2025 08:50:08 +0100
Uros Bizjak <ubizjak@gmail.com> wrote:

> On Sat, Mar 8, 2025 at 8:08=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
...
> > In fact, I would wonder if we shouldn't simply do:
> >
> > #define asm __asm__ __inline__
> > #define asm_noinline __asm__
> >
> > ... in other words, to make asm inline an opt-out instead of an opt-in.

The asm statements themselves get inlined (typically they are in an
always_inline wrapper), the size affects whether the calling code is inline=
d.
You are now in the 'games' of I$ fetches, overall code size and TLB lookups
(not helped by the speculative execution mitigations for 'ret').

> > It is comparatively unusual that we do complex things in inline assembly
> > that we would want gcc to treat as something that should be avoided.
>=20
> I don't think we need such radical changes. There are only a few
> groups of instructions, nicely hidden behind macros, that need asm
> noinline. Alternatives (gcc counted them as 20 - 23 instructions) are
> already using asm inline (please see
> arch/x86/include/asm/alternative.h) in their high-level macros, and my
> proposed patch converts all asm using LOCK_PREFIX by amending macros
> in 7 header files.

The other ones that are likely to get mis-sized are the ones that change
the section to add annotations.
The size overestimate may be better in order to reduce the number of
annotations?

	David



