Return-Path: <linux-kernel+bounces-562268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31950A620D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2324519C1EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474221EDA26;
	Fri, 14 Mar 2025 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YX8Cb2VR"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F81B0F2C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741992670; cv=none; b=cwPpoIdJ3gOIJAur3AFxTCaY6ePWOWKYJnK+PgAwjpOXnYohbBDvWm1bpw8nHGyLCnAYMLLxuZ0rAnnzw3zncb2Kef9PTjlaKVjlPjsE5IuHrbQIXh1DTHuoo4QY4D1hYqxmp7rkMjBKEl3TS3ITKgF1l884WrFgK6J4SzVlT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741992670; c=relaxed/simple;
	bh=0e63dBhED1vhsVehyEhcXoCrr89BKTLbrv7t2Fd2NHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfuUKPF80ZOlZ0kxstTuwlXzbfLLAsryBEjuIimRqJRy3EJ5BlZ0Nu5oYs3y/KAZiVxTcp46J0lF3nyd2uzyfS4m5ZenFtpqToAlvbuO/KLFsLP1BcLQ6TriDAPRJqyXrwvWd8oAOfsocwQjUcPT57jAjUzRb4Vl6W6aeGhaiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YX8Cb2VR; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fcfso28587941fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741992667; x=1742597467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abcj1sqti57082y+hPQTzkAaoTCwdpDPipp4Lzzk35Y=;
        b=YX8Cb2VRReqzm15iTBa7NRzpzkqdpcPUdhGiYwhFovTymhAqZkWiYyClsaOZEVnnRi
         nw7GJMvqnizGTk9i3l9zdGrCzx3ZRi8/yWIlmgQsgC1NLoEMDUEZgOOyQboeNWQQfigJ
         DviaszZbvK5tKkseZFmW4tPXWks4vN7sEfF3+oDThHRUSPhcCWD2VYmiRbVRDudNJUK7
         9LyUU2n8sFHydgAQzXIlZd+psAsOU5YEqhjFIZBq6YsNcqy+xiW+f6HENROmnC+1hUIR
         v6HwC4Tpkq8qexP2xxfkZ3K5bM1KsPYxbYbHaO/wjNBdzGGjyOUNSM3+iYLUdw63/L+i
         oIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741992667; x=1742597467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abcj1sqti57082y+hPQTzkAaoTCwdpDPipp4Lzzk35Y=;
        b=aOfYNL4+KnSPTWoTORweueIs2p+mwVQn3S97lH1Ei1/rV1JP4qXGE+7QVLHABK/bEb
         eCA+jSHSBN8w2YPdP7RM/HMEzVW4sMc0ZvCkrJ8jDjBGSWbBN7nQ1enIoI8d1VBVaM7V
         VpNB9MaoONYSFK0JPhSaRkbCJaGf3AZd/315aty6q08izQGo1rzPxMQCnbXSC/Q+PFNx
         6n8xzasdGqRSqGSex1qUa8QwzyPkNN3REXaiccyxB/iqSnVbaVFlDP54ZI7nqXxGt2Tj
         6FOPjZLq5Pi3hr7R6HxXUe1whjTH/uaj/MTFq1pjvBMthV5tBdUA8EvkH6QcJ15CIXGL
         xrcg==
X-Forwarded-Encrypted: i=1; AJvYcCUVZPvM1QIN/VYM0v4ZnqOB/zrh3hQtGBheaDe9ecJHW8AXeE/nwGn+S/5NuHAfDCzPaHVc+V3vd1xiolQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRrMVomYo4+dhedZuYGikCQGn42hgv5YM/r3WYWlGEwHZwob7
	Dw7hU7TPWb3trKCwSSHbXmrXhlxqptzrkgNyTINcI5Gi55QIxTyDMHjMNG+shDRR8a5DzkZCBx5
	fFhglIcnv0jLDkGBVosAww+p9qOVFmn8U8NwHVvx4BGNd7bKSCg8=
X-Gm-Gg: ASbGncvYw8oeiUGNJq7ryWK5Z/LdYnW9jGWUt+PY1xcrZOMawkEUjsEfi/coezs79XS
	bOVI2z0p8AW+9+jvtvBcCRCYuGZU7TiAc/kj9Azji1cDYHvISLuR92wBFjUYFAduCzcvny/VsOW
	8p8QWnCGN4UHqm1qRMocKUoy5YYRIIXLf2WqXoejdYo7yajJSGpl+OZQ==
X-Google-Smtp-Source: AGHT+IFm3g7i0fgkNjTj5rX7/Jo01XkD7CMfZOkzb1YhI0t54Y6qJiv3UZuW9RLxsEL/MB0QZ4w++0T5EmUcfKcDATU=
X-Received: by 2002:a05:6512:1048:b0:549:8537:79d6 with SMTP id
 2adb3069b0e04-549c3989676mr1462153e87.48.1741992666615; Fri, 14 Mar 2025
 15:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310030004.3705801-1-lei.chen@smartx.com> <87cyej5rid.ffs@tglx>
In-Reply-To: <87cyej5rid.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Fri, 14 Mar 2025 15:50:53 -0700
X-Gm-Features: AQ5f1JqB-akORsvQFGvjVXmkUMUkJqUkSvDDmb5myb8fx_M0da6KruNyOrbvmjM
Message-ID: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
Subject: Re: [PATCH] Fix rolling back of CLOCK_MONOTONIC_COARSE
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Lei Chen <lei.chen@smartx.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:41=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Mon, Mar 10 2025 at 11:00, Lei Chen wrote:
> > To fix this issue, the patch accumulates offset into tk, and export
> > N(P2) to real tk and vdso.
> >
> > tk.tkr_mono :=3D N(P2) =3D N(P1) + offset * M1
> >
> > Then at P3, we calculate N(P3) based on N(P2) instead of N(P1):
> > N(P3) :=3D N(P2) + clock_delta * M2
>
> Your analysis is mostly correct, but it is only correct versus the
> coarse timekeeper.
>
> Moving everything forward to P2 breaks the periodic accumulation and
> therefore NTP. Monitoring NTP/chrony immediately shows that they are
> behaving differently and do not really converge.
>
> The real problem is that the introduction of the coarse time accessors
> completely missed the fact, that xtime_nsec is adjusted by multiplier
> changes. This went unnoticed for about 15 years :)
>
> So the obvious cure is to leave the accumulation logic alone and to
> provide a seperate coarse_nsec instance, which compensates for the
> offset.
>
> The offset contains the reminder of the periodic accumulation from the
> point where timekeeping_advance() read the clocksource at T1.
>
> At the point of readout T1 nanoseconds have been:
>
>      T1nsec[OLD] =3D xtime_sec[OLD] * NSEC_PER_SEC +
>                    (xtime_nsec[OLD] + offset * mult[OLD]) >> shift;
>
> After the accumulation and eventual multiplier update that becomes:
>
>      T1nsec[NEW] =3D xtime_sec[NEW] * NSEC_PER_SEC +
>                    (xtime_nsec[NEW] + offset * mult[NEW]) >> shift;
>
> If the unmodified accumulation math is correct then:
>
>      T1nsec[OLD] =3D=3D T1nsec[NEW]
>
> The patch below implements exactly that and survives lightweight testing
> where neither in kernel nor in userspace these time jumps are
> observable anymore.
>
> It needs quite some eyeballs, testing and validation.
>

Hey Thomas,
 Nice work chasing this down. The approach looks ok, but I'm wary of
adding more state to manage.

Since this issue apparently only happens via do_adjtimex() calling
timekeeping_advance(TK_ADV_FREQ) resulting in an mult adjustment being
made without any accumulation before it, the approach I'm testing is:
in that case, to do ~timekeeping_forward_now() to accumulate the small
offset before doing the mult adjustment. I've got to move a little bit
of code around to do this cleanly, but I'll send a patch out here
shortly.

thanks
-john

