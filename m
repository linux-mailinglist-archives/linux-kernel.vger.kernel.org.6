Return-Path: <linux-kernel+bounces-303945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC0961743
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5192841A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1708C1D31B1;
	Tue, 27 Aug 2024 18:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGFIdCTt"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7A1D31AB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784540; cv=none; b=fqRM1dkoFSmpNMJ4cOkEgXT/Dc5OoIsJrfAM/xX/zZlnDOgRt2o2WSXJZYyJjpWJVnlh0lrt0C9NNW9gkphRydz7BCmlX/eEDTNOD3h5f7B6/7VcOln5SjR/OpSCG1tghBD9I4RXfAor7XjTPZPIAwT3OEkBORB2i+O2bMHXwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784540; c=relaxed/simple;
	bh=+fM/Qyk8h6+mYsjYQvSSfjnNJ8uLvU2/CLFvC7f9D3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7Qt4dF5TliYhx8JPmjPiVGsA7DXlNOy2Cx60i1UkAedRg6BmsR8v4YE69frD5y16bb4ISseUxxIGu9veRIzfIiOpSX2PmDSXoQIaM6+akLzfdH4As0YMw1VzjCAily9ZCX/P25dSyc0YXb91A0yVXqeWsbwUbGDw39iqfasrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGFIdCTt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c0ba23a5abso1564377a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724784537; x=1725389337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fM/Qyk8h6+mYsjYQvSSfjnNJ8uLvU2/CLFvC7f9D3Q=;
        b=lGFIdCTtRJeXOYY5grAVYQCqvGWph8gl6IGx2D3r1Xon7tF2PfbKja0EN5bzLd+5mG
         OExGSK0AWbleiH1udVJUP98pE6+OqTRvopY6smytd5CWk6ZQWetPIwEYSvT8AqCf/Lhs
         RT1b5o1tWO/N+h4aRRv88hUNJGm7cF/F1VtsMS3ojkiS40xukAsJAr+MqnSKREdGJ/up
         RrZYdgP17VfKEPphNvarIMagEhKwp211ZYnSE6uBtprlZPI5MzQc/2F1mPn6zJXfaGrN
         eCTpQJHo484MM9SFMyQ2WCIMbJqEqk3YAzi0V0YbtQDJtus3LMaI1uoGOYd9QD5524jc
         cwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784537; x=1725389337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fM/Qyk8h6+mYsjYQvSSfjnNJ8uLvU2/CLFvC7f9D3Q=;
        b=LTFsHE3z805yDzypNmAOnMdY3zCIkSNkevth0BZU2Tl/WHG9x91Fuht0IhYtyqKfsR
         7NVQ9Nl8FV8mZxJT5rG6EeYJx23Pfo1IiKvZp7wzUfFD77oNHyEWdXzZ9gFHKOtIQ3W/
         JMvs/DvvKUp7UKXAM9CzEiMcQJwrqGffxESjd4m9n9J/K5S30GZZNKUuULgXg9wAkPi/
         +7NA/hjAcxK0Kmrj24/R24njCIJJeoL62h1tMWpXFm1lhTgKZ8hdjWbcqsHJCZuGlvyY
         CD5Kh3XcD/UQeITMnKbK3CTOV7UKs4KvfaoLuo3XX+WNmJ7I/XKue3VVhQl0wmi5yLbA
         z6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCf42oRBjmAY+O9O4u8OqsMhz92WU4gAOO6K+2m5/+XRyWK/TQtH7DDvqu1e1cU4Hl5qevwFq4vxFojl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGDAYhpKB7dB+UZrR7bded64MJKSogdqM6kOEaBW9Uoqz+2CQJ
	j+ZCeC280qq07aFnQEM0Ob7JjRdD/907LMZ8W6T9XH1uISTNhJsXeWz8VvxSb+lIWriaikcwdm7
	Vhi7R7VUg2wgk5xof6bEn9K6BhbZFpgeUWQmE
X-Google-Smtp-Source: AGHT+IEDE84HW8WhltURoZPE6AnT1p3yEylLwiUEf8EfZjo6o3kJOFM23s7uhP84XseafK+WQn8SInwK5adVNDb6Bys=
X-Received: by 2002:a17:906:c14d:b0:a86:90b8:9ac9 with SMTP id
 a640c23a62f3a-a86a52cc979mr1096924066b.39.1724784536549; Tue, 27 Aug 2024
 11:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info> <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com> <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com> <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com>
In-Reply-To: <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 27 Aug 2024 11:48:19 -0700
Message-ID: <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 9:24=E2=80=AFAM Piotr Oniszczuk
<piotr.oniszczuk@gmail.com> wrote:
>
>
>
> > Wiadomo=C5=9B=C4=87 napisana przez Pedro Falcato <pedro.falcato@gmail.c=
om> w dniu 25.08.2024, o godz. 17:05:
> >
> > Also, could you try a memtest86 on your machine, to shake out potential=
 hardware problems?
>
>
> I found less time consuming way to trigger issue: 12c24t cross compile of=
 llvm with =E2=80=9Eonly 16G=E2=80=9D of ram - as this triggers many heavy =
swappings (top swap usage gets 8-9G out of 16G swap part)
>
> With such setup - on 6.9.12 - i=E2=80=99m getting not available system (d=
ue cpu soft lockup) just in 1..3h
> (usually first or second compile iteration; i wrote simple scrip compilin=
g in loop + counting interations)

Are we sure that the soft lockup problem is related to the originally
reported problem? It seems like in v6.10 you hit a BUG in zswap
(corruption?), and in v6.9 you hit a soft lockup with a zswap lock
showing up in the splat. Not sure how they are relevant.

Is the soft lockup reproducible in v6.10 as well?

Since you have a narrow window (6.8.2 to 6.9) and a reproducer for the
soft lockup problem, can you try bisecting?

Thanks!

