Return-Path: <linux-kernel+bounces-524126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379DFA3DF84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37EC16D1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FC51F9ED2;
	Thu, 20 Feb 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xnPBftNh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14FA1FF7B7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066945; cv=none; b=GiWseg7YQ5zt5tdK/27Gg+LXki8ESRiR0dUyI1ZWhYpB7++N8/F0kYfRhxcrzUktb1KAQcGXTZqHIVXyhjsa+sgsOVy4hMnKkYWaT+DNSZ8O5ybmAUhIMgebKegtw/L9Fuog38Ok2le9WRciJCrmY5Zh2Tzk6Vj28xy5NffDVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066945; c=relaxed/simple;
	bh=RS3YJJLlOcou26Qi+ZFaLNYDiSgH9C6U1P/Jn95ETpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vt5wS04Q6V9mz+iEPiRYitTpgg0krIwHZsGMIRkzoGzEOFrPT06bzgDll8KjaBYClyKutBVS8QZ/c0nzERGMBYsl31YSw6R4km9p9PEYKeprvID0L9EEir15YJRujIWuWtG39IyWC1A1VNK8UiiMPS0oJR5IDuBp+ld9vcOSFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xnPBftNh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so1876627a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740066942; x=1740671742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS3YJJLlOcou26Qi+ZFaLNYDiSgH9C6U1P/Jn95ETpY=;
        b=xnPBftNhDmVvZNZ4H/NnAz+SkjLw3+1SyepmZOhxLCaZEIBiE9A2NPLzMrdBfBQOuC
         FOe9TxJwx/6xhoHkxQF++TqfbSzUOImP5xUtT15U3BH3kIBjbEZgYQ8M/5lUwUkDT16S
         LmxNJ+zhvV6fjMnlh05a+7Jri5F1csarhtQeASZBAwDgAp/Nz/QdCWm3abFqhGJxTzQ7
         C769sJITrxxHOt3WGejzoVEzlWJAAHZsdjQ4ST/uvXU05egCzYeTU8iDr74+aTDgxxuq
         Q7lDeJlud/7qvAIARuZVXXYTn2X++abEwCFrCdiy6tXLTL8zL7jFmoZqQehylVFlarM0
         HwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066942; x=1740671742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS3YJJLlOcou26Qi+ZFaLNYDiSgH9C6U1P/Jn95ETpY=;
        b=S9VlKE29XisuqnHCzRc3IjEYqJi1eFSQMyItNCbnE/2ccpFqjhDPTCLuI8HrFA4N28
         iys9pUXJ5v34tvxL/+tsHy5xr3Fa3g2SKT9sbeXi0Sn7CXdR2w0Df1meSXjBa0lb4Dqo
         evVn8XMZCRIiiImbdLiLiyWr4+t4hbEBtilHkCRwxFNp0wMtrEWEkaQHCC9pafrEM4QG
         /QO/Hs83M4BQmT2VQiJz7CYuwFY6ZF+wQX3GAAUDHSvyGZy4HcNHAgrbBqdFGYmAFFr6
         0yf3tFWoG/O+FBK1duizHD2B4waLoC2DP9bnSgx4XpnHGnXw4ke79sylNCZ8GitEn9Xp
         xdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBZpRej5l6Oz48ExbcF5NjFpFaKqVz28rsRsaW/pqczid0MqMMF9fcgTWhHH9f3mB6+nqvH/3G++h0NI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhEl9p2d7ByOXP26bNVlXGK6GVL4dXFpv6luKfo7gXNlPXc01H
	4NM66dRIEzfSrIixBzuOmtQz7Mc5VgxmrB3pIHObrTN8hV4sNwaSwUALl/hCa9EIdC1y3Tytc1C
	VjEq8vsggBZQwMb8NQsE81ygIsfbMELzainskCXNEo4E6Isqcyk0Q
X-Gm-Gg: ASbGnctxNOUyQSj2bo1NOQ62AoiyCkZC8LKoP5r54WnfIx8M3Rj78kDF4HUVXvxwUqk
	8Jf/yPi1d2vcItItErR9JqzuGz+PO+bzJF+t75reYkbDRW18tSlf2iTtCHE7ChM33mzhzK5d5Ue
	LsJH/81aJHHfai1ZLihPy6YSUQqrNKDQ==
X-Google-Smtp-Source: AGHT+IHCeWhERDWqGl2qKOQz2L+yxEG2jvtghKblcF5xy9Q+Utf+fm8OMnCCaH7kzPq/dBN39Gu3R1EqvDP50SGLq8U=
X-Received: by 2002:a05:6402:2807:b0:5e0:2974:c20c with SMTP id
 4fb4d7f45d1cf-5e089d2ff46mr8300816a12.22.1740066941700; Thu, 20 Feb 2025
 07:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com> <20250219125522.2535263-2-edumazet@google.com>
 <87wmdlhwa8.ffs@tglx> <CANn89i+LJFHhA=VF2T5v_kN0=sFLeropuRERnhWdadj5w6kiyw@mail.gmail.com>
 <87h64oiuey.ffs@tglx> <8734g8it5m.ffs@tglx>
In-Reply-To: <8734g8it5m.ffs@tglx>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 16:55:30 +0100
X-Gm-Features: AWEUYZmvDxyRdrNK4APEpn53_uwuytmCx-RQKbkdQQzQvNvtG8HNW1QxB6l_pwk
Message-ID: <CANn89iKAiJvOXLC4SkWnsKC-6m9HU1KoYAVPE_G_UhOb__Gj0g@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] posix-timers: Make next_posix_timer_id an atomic_t
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:32=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Feb 20 2025 at 15:04, Thomas Gleixner wrote:
> > On Thu, Feb 20 2025 at 09:49, Eric Dumazet wrote:
> >> On Thu, Feb 20, 2025 at 9:09=E2=80=AFAM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> >>> > This allows the following patch to use RCU.
> >>>
> >>> Your patch ordering is slightly off by two :)
> >>>
> >>> And it fails to explain for what RCU can be used....
> >>
> >> This is explained in the following patches.
> >
> > The changelog of a patch has to be self contained. The 'following patch=
'
> > has no meaning when the patch is merged.
>
> That said, please just fold this into the patch which actually does this =
RCU
> lookup upfront. The change is trivial enough that it does not really
> require to be seperate. If the lockless increment would cause issues,
> then the subsequent RCU lookup is the least of the worries :)

I can squash all patches into a single one if you prefer.

