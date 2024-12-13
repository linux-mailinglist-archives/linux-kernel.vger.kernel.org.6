Return-Path: <linux-kernel+bounces-444101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708F9F00C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7F3285BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F001854;
	Fri, 13 Dec 2024 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AVNVd/aL"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76280B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049634; cv=none; b=Lq2HTtXoojuVRapbZVqN9ifbeUK+7mXNJ2MR+Vvzyi+PBmh+SZYuW+AAnFYyNJLm1J2etC21DCPM4mkUSlVth4IcM1Is8sXdTHCyzmlXWUwGaW0Sn7Nkd0BVhQjYFeZN1C4oZ+32o/LvmrllMuMr5SdxAEb6ocznUbByeW616aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049634; c=relaxed/simple;
	bh=eXUuxYw/zq0YWB9TTZm2iQpmEhsWgzTOwd/QbpTSb4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC9Dmqko1DSADFDX1KkkR0h32EMyTJKOP0TB0xIpy+/viSkeKDpo9ucbrhWZukHAI71GaFOjuxDARxlpvZps315p3jAJXwiIggpDF+lcH9Ucp5aemYQhss4Ek1pRqannsvVPTUelXIijNqq6011nfdfynWxERSLNtYkTiI4EaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AVNVd/aL; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so1230568e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734049631; x=1734654431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXUuxYw/zq0YWB9TTZm2iQpmEhsWgzTOwd/QbpTSb4U=;
        b=AVNVd/aLl2IM/ySFEPjm9F6uAVVUJ28zn59mZhZHW1XRmn4SIRiJG5hZadk0iZwcjl
         WbE9WD1uYqcRZx0b2Xzw2empNzjFcpk6ZnhTWg80i4QDBnV8rFsVOmws6oBWJmdpD/zX
         QNAHLGQ+wHbHPVToP7JZrZ0Taq0G9xkKufMbgExxkkd8+ZeDwIR3egpw5MIfUM20qVon
         EPdfZ8NhCXW4++Np3wghRRdYfXxIvtdKfFtawsZu6SmJgbiQR2mDjXUn37VgYPB6J/B5
         aKm+8Hr2ehTmNdoyEaNXAQOAAPSKd+8Xq6vJMjtQYHoHb3WUkvXllTidJrEkdAUX+A4H
         Ga+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049631; x=1734654431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXUuxYw/zq0YWB9TTZm2iQpmEhsWgzTOwd/QbpTSb4U=;
        b=RB2xPQoV8ai3stEPKQKcIMiM/kuvXjUwvnEBn8JegtAEoO1JYfN2228HYY/YzX37cj
         5jYPWaz+Q09o64cfuuHEL0IMhfIZJvUu4B1Xy9EnqyiWrKjqYLrufui/JaDu6bVe9tvQ
         VUATLdTTiYvUnQfwL44sj5WrxsIx3hACKr3ZDCtJo5UTOHtR7LDA9PG2w1axJFI9g5jI
         o6+l8KttXTEA79/0KsI2PqhGcUqq4ZU9v72npL/i0xZBNy/c8OYemZyil2TwxqPjillg
         6exl5QM4nLGiP3Ygen5BIuX8f7/gmXzw2uCi9Da2vKn74Y9ABP1I2GZ56Kw7tMeKraXK
         XCBA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJLg75chJLZ71di+8OWGYyV/5XG1iKROL0UoGGCNSjoqAit5hYSReRweae8m8oRAiw1kDk6LV+niXBB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMs507gip1BDsLrHzjufTmd5BghM1s/DUCdebyMsDYxEh5vP09
	Hm0qMjTm6dxSrSCPOM9imsMuAiasFVWjo1t4pCTvj1/pXpw2z+4q9mnLHLjMX8tN+u1QkjCxmCw
	PiKUHgX9kq3XCIXzw+AW8NUIFayaHiMNbeZZKAQ==
X-Gm-Gg: ASbGncut54mEUzgj9e5QI2rX6/x21RdjZOeO/5BdRQZ0sVZVOtz50SUj8VUc01Uhfzs
	NzEozTO8dWdc5Rd/vTOJU+hqk0Ofrz0P402ER
X-Google-Smtp-Source: AGHT+IERxfeFHnzWGjnXWaunMgWNYVqkpPBsLMjAfHFuRIKYyNJQAYs2iiNndqzYqxmZbY3OMdZCdjicGUrYBZW+yZ8=
X-Received: by 2002:a05:6512:1053:b0:53e:bedb:867f with SMTP id
 2adb3069b0e04-540905aacbfmr97792e87.41.1734049630826; Thu, 12 Dec 2024
 16:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-3-arnd@kernel.org>
 <CACRpkdZaoD2vqbCi1AFUa6mF2_=c3Nu4R0CvxFAep0VMgtMtOQ@mail.gmail.com> <20241211152257.Igx3aT2Y@linutronix.de>
In-Reply-To: <20241211152257.Igx3aT2Y@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 13 Dec 2024 01:27:00 +0100
Message-ID: <CACRpkdbYU=Txm0zUWDWvNXA0JHRNGpy1ccy0zQdiBb2Ya+UBFA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:22=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2024-12-11 14:29:29 [+0100], Linus Walleij wrote:
> > So fast GUP is supposed to be lockless, and should just not
> > have this problem. So it can't be addressing gup_fast_pgd_range()
> > right?
> =E2=80=A6
> > I'm more asking if HIGHPTE even acquires a spinlock anymore
> > as it is supposed to be "fast"/lockless. If it does, it is clearly viol=
ating
> > the "fast" promise of the fast GUP API and should not exist.
>
> This is lockless on x86. The problem is ARM's
> arch_kmap_local_high_get(). This is where the lock is from.

Aha that calls down to kmap_high_get() that that issues
lock_kmap_any(flags).

But is it really sound that the "fast" API does this? It feels
like a violation of the whole design of the fast stuff.

Yours,
Linus Walleij

