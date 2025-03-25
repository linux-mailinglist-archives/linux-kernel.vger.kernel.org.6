Return-Path: <linux-kernel+bounces-575779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B34A7071E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB9D16C78A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8025D553;
	Tue, 25 Mar 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpkHJfnS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A191A316E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920625; cv=none; b=Hx7efiubeXcBY6Q2riMbnfArsHPJiEguev6Y+j95pn6f727cp4IBj3NgngTPlU2OKqw3YPtEWQOoEUZiv0ngQ0cbu4RiK1MwG2SYfO5We9mG8aSW5bWqo2vFonO8JRJTLTUUl4VTQ+zd4JU8pmdphv19mpJsu1HIfQ4fsCpt55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920625; c=relaxed/simple;
	bh=cdtKBuwq8KD1n7kXxsXZzrCM7kAgY9mfaSLYLssvPX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww0RsvR8FRz3YceiyDosVxUG6usVjZ2dUU6phpxGsVL4Vpf05YXlCOhBUezMtueND493i1YCIZv7XoZ7rtVY1bOE02MZq0ggHWebuKRIy6BOgx6tdHvbIx/ZhMs9zlB6CksywL6GWxyUfAUfK2g2kf+/92mpfteHU0T7Sh2TuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpkHJfnS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so11703a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742920622; x=1743525422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdtKBuwq8KD1n7kXxsXZzrCM7kAgY9mfaSLYLssvPX0=;
        b=OpkHJfnS0IIAT0vf0aMAo4BUOJUo0Gq8OsDgyMa3/urmO+q99LFNy9pd1DWfYjWsRr
         fwKl4w5zmbyrCRY1y6/CMujBt2MO6SnDAoK0L/HQKPB9AmnMXsvRWERL0gkuuYnM+BiC
         V7F9Up6QkAE9tw6XJOOGuvXklZD61C+TCyEYbOD6iCy8KTiFnz7ucDBDDvaPklgYtMLy
         oNMg1DPQEXNJPj18Ldh0lmfNAqaanqVq0fwrH3wBKrkBfx3bSfXmOndRWM90tPF0cEaT
         4jf2riM6frqvgWoi67Dq2qfjbpfqthx/pyJ/LCnBkRu6U3IYphMvMFtStL+RFVG2u6Ei
         51JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920622; x=1743525422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdtKBuwq8KD1n7kXxsXZzrCM7kAgY9mfaSLYLssvPX0=;
        b=VdqmTwGxFVm4N/zxfAEQeqvb1BPymMkh8MapFA3AGncyfJ2lgw5yFyC89Yuhuc910Z
         mwFu5qNMGRdYmMFSM65Ix63ccUmzzawPBuXRELNtig8pS66Mt5OhEqJOJOYaojYE7zgK
         5bpCYVve98WW1aUgxc9YHmTF+1pbnZULxlp9h54W1DssxID+WEOshb4y/iHjJiPBPT12
         BjqTIzfc8uySCutvF5LYXo8GRife0jgz94hvJTI18UmjgAhoyHpV4kXP/MD84QEVkvmK
         jdxT8MXNiStToDQbiLn4Usz2UvsNrSEipU+XI06LpKgT0oxLTgZdlfZX2EFaz5CkFMHD
         GcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVFSui2m0Y/+Zy7bJE1QyRUYsvhKzgOMHaSPgl58V/7aFip1Vdz7Kd4YTQ//hIbdzAuubraz4vjH0x4I0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cDsyAHPoiqun962nhVBQqJY4DxEOqusJ8Vi20VEk29pBP+O8
	5nldd2GBmMbWP88SfljBCpctAH0ShucSlvwG4ft+xMTMHcs5FcGZdrwSS8L+xF+MaeLr1LyUEz9
	zNly7ownl9ABZipdFxTgEiPzJBbPDjeA1/Uc2
X-Gm-Gg: ASbGnct3Mi9QtrckSQC6Z8hiOwzuuUB8RhqMtAU6W5l3VtgZx2WSvo4DQ1TNdRlps9M
	zQvX9RNljzlJ+gi/YhwlK7Sf/day4FJw4jNRB5qgHW9n3Fl0en21xGSJsPYvIBqPEAYT+n4OuMb
	pDyFn0ZWFXxW2U4MNC/bq7pq/KM4fKMX/QQlKE/es6HGkzMXguKveYdQ==
X-Google-Smtp-Source: AGHT+IHPUGHREqco1DTnfO/F+aCYz8cAJ5qYMao8+1Nj74JN/TypPJxBO7NjUrPuX7a2MaW7apzLRdIsTLYZoT/21N0=
X-Received: by 2002:a05:6402:2058:b0:5eb:5d50:4fec with SMTP id
 4fb4d7f45d1cf-5ec1d8fcf0dmr312539a12.0.1742920622152; Tue, 25 Mar 2025
 09:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
 <26df580c-b2cc-4bb0-b15b-4e9b74897ff0@app.fastmail.com> <CANpmjNMGr8-r_uPRMhwBGX42hbV+pavL7n1+zyBK167ZT7=nmA@mail.gmail.com>
In-Reply-To: <CANpmjNMGr8-r_uPRMhwBGX42hbV+pavL7n1+zyBK167ZT7=nmA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 17:36:26 +0100
X-Gm-Features: AQ5f1Jp1Xe_G-CxRRO6kwph46Q35uuQWx_DCrGXZTFNG3il-9h0KD0k1zhEGxuE
Message-ID: <CAG48ez2eECk+iU759BhPLrDJrGcBPT2dkAZg_O_c1fdD+HsifQ@mail.gmail.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
To: Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 5:31=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
> On Tue, 25 Mar 2025 at 17:06, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Mar 25, 2025, at 17:01, Jann Horn wrote:
> > > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrast=
ructure")
> > > Signed-off-by: Jann Horn <jannh@google.com>
[...]
> I have nothing pending yet. Unless you're very certain there'll be
> more KCSAN patches,

No, I don't know yet whether I'll have more KCSAN patches for 6.15.

> I'd suggest that Arnd can take it. I'm fine with
> KCSAN-related patches that aren't strongly dependent on each other
> outside kernel/kcsan to go through whichever tree is closest.

Sounds good to me.

