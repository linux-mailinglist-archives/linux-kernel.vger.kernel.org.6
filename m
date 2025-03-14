Return-Path: <linux-kernel+bounces-562004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2B7A61A49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1919C474E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59A204C39;
	Fri, 14 Mar 2025 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+Gk4mHz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092F84D08
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980111; cv=none; b=ql+d3tsW++U0nv+3wMl5yybRbnE4Ax4hp5NjOx+1NhecL5WY6ZPWFp88xF2XX7vgQu/fmIDwGf+Dtjy8KaqMfZFwY0O6Rj7vLW1ibxM0efolqSA+xfkE6nNnUmGdCuqN09tNJRVkzBgoGEAwrS2iM4Jt4tPwYbhIVZhkBgu+W2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980111; c=relaxed/simple;
	bh=ryx0zKuenANkRXsYf6XtKpB+n4QJDHZaIXQLpHiMN1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1TNM8qMKekvksUfeoirnZ41ggAbp9aQk3qmkbLJ3Q0WLJZX/h2OtzLk1yzyN9t+w0Zpvk1DeW6OrPqXZ6w/8gAJIGodE8H8Au8JFoEAe7m0J68+iSomejKAKXzHpHbq4geAoqB1Ylqh5j02tMa4GadLZSzitOUywVjj+5nBaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+Gk4mHz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5497590ffbbso2545909e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741980107; x=1742584907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9+9Ep+7gxZljLN0TqwcK3ZG0MxqsMjlhUkQ26uvgW0=;
        b=w+Gk4mHzVyX3yxrKczmfN+FtCY5HdmYHZcy0vwTaTEzGE6v/Vc52uJJH3JBPWfPDZO
         7Rj18sga/GPLXXwIw7QP13o0SRyxvg0a/H5jI65UN6Khv64PIRlVb7lpdLGjgVwp07hl
         Wk65xchh0XPmgTaUT6sZQulSgcBxMpWjRAS3Iw5HReB8UrVNnIKjHKzaEKhC05Ck2hRQ
         Ev79A9l8OEXAy0hFBmtIhzzvICcx58pEfQ4VT1+hR/tdflCNn2j8V5tRNK0I7nbmZcDW
         945osC+3W2JgQFA3HHyAaHNSjqyZF38jojubE/4X7Daljaf9eh+mhjTqH69qL+JPCAna
         YHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741980107; x=1742584907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9+9Ep+7gxZljLN0TqwcK3ZG0MxqsMjlhUkQ26uvgW0=;
        b=KTG9I0/5mNjC2EBE/p1CfaLokDNMM3cZi3G76T2b9C537KIGgzC+5BA6cGJqrZPclo
         CSfeP+sMuEOvp8+hhq+JiPQeihzB9NVkRs3Bpu9+PYfleXxwpRLNnKQaOJJ2jQyZHHU4
         AmjFBa2gCgxDm2uLT3RMFr8JQhoe6hpRo1stATZOPopZIl9FKQ/eNOYcBEmUMRMazYha
         tdoIddIvVI8KiDSfUZcYuuEjxYpdi4Ub2Hz6Z5EWaXUAfPrrgC8+/ClfcAnBfA74UzN8
         QMRZ8DnytMB8LvrG2CORo/RBA8whU/dbPMCd0mOv5yfdirnrJ1JevdVnigv1DkyZZ1dH
         wz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjRrU9IyyaUDn0jT9P8C86dRdXchcGT9UgkTP1jRr/2CeErDMshtZNBjWgZNB2PBhV+DSgKxZiyI5XqQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHQMGc+UF+Lxf1BNQ1rSxR8qtwDgJPYnmCl7AxsJwBHTi1eoz
	87zOi9dPzTQe6u0avtfCSZ+kTqJd4seFUkqCFRYXoasOBt7i3T6JsWXRZvIf/oLxg2IYpBBseqt
	MAtMOW+FtMDXse44PJbUVAFvvbzYFvsQiLlE=
X-Gm-Gg: ASbGncv7WWQ2iNT4Ta9/X7CnaEI3AmAFplTHPP8abOCoU2ke1JmNc/H4bjCIpzRjvwB
	GcN5F2LdUABY1YQxg/nqsGMUBUNcU4XNCJZ5v7R931ReE21t2ErZFd6ZBOcudTTv4/6bK/XEnDx
	wwf1n+jMX8KpI+mLPFVO/0+PnlGyiVQtyh/2uydDFHShZERa5WlkhfQg==
X-Google-Smtp-Source: AGHT+IFmKudeedk+byre9+uuSYw848xLagZWetRKEOSCrq2CWQNdL6+bnwO8Fitbbk5qQ2XaUGXigHBY0L+t3tmqeII=
X-Received: by 2002:a05:6512:4006:b0:549:8b97:75f2 with SMTP id
 2adb3069b0e04-549c38ef3e1mr1159648e87.1.1741980107030; Fri, 14 Mar 2025
 12:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310030004.3705801-1-lei.chen@smartx.com> <CANDhNCoRxxA-CxOQ6vxfjf6BDxR-gqCC_QE1wwf4L3gwrvfv6A@mail.gmail.com>
 <CAKcXpBwvjrmoPnfFgaXs81XF5du-mWzLiJ+8YvvhM_1tQMiZBQ@mail.gmail.com>
In-Reply-To: <CAKcXpBwvjrmoPnfFgaXs81XF5du-mWzLiJ+8YvvhM_1tQMiZBQ@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 14 Mar 2025 12:21:34 -0700
X-Gm-Features: AQ5f1Jrm7wC0CVW9h6COejewRncxLSkkA6cB_Ppj_hgyHgI2UNGyMRp35_Vi0UY
Message-ID: <CANDhNCpSB5HzMHne94rnGEi+=yd1Q2j+pJX8pdX5RbEojwpZcA@mail.gmail.com>
Subject: Re: [PATCH] Fix rolling back of CLOCK_MONOTONIC_COARSE
To: Lei Chen <lei.chen@smartx.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:32=E2=80=AFPM Lei Chen <lei.chen@smartx.com> wro=
te:
>
> Hi John,
> Thanks for your reply.
>
> On Fri, Mar 14, 2025 at 1:20=E2=80=AFAM John Stultz <jstultz@google.com> =
wrote:
> >
> > On Sun, Mar 9, 2025 at 8:00=E2=80=AFPM Lei Chen <lei.chen@smartx.com> w=
rote:
> > >
> > > timekeeping_apply_adjustment try to adjust tkr_mono.mult by @mult_adj=
.
> > > If @mult_adj > 0, tk->tkr_mono.xtime_nsec will be decreased by @offse=
t.
> > > Then timekeeping_update flushes shadow_timekeeper to real tk and vdso
> > > data region. Then rolling back happens.
> > >
> > > The drawing below illustrates the reason why timekeeping_apply_adjust=
ment
> > > descreases tk->tkr_mono.xtime_nsec.
> > >
> > >      cycle_interval       offset        clock_delta
> > > x-----------------------x----------x---------------------------x
> > >
> > > P0                      P1         P2                         P3
> > >
> > > N(P) means the nano sec count at the point P.
> > >
> > > Assume timekeeping_apply_adjustment runs at P1, with unaccumulated
> > > cycles @offset. Then tkr_mono.mult is adjusted from M1 to M2.
> > >
> > > Since offset happens before tkr_mono.mult adjustment, so we want to
> > > achieve:
> > > N(P3) =3D=3D offset * M1 + clock_delta * M2 + N(P1)   -------- (1)
> > >
> > > But at P3, the code works as following:
> > > N(P3) :=3D (offset + clock_delta) * M2 + N(P1)
> > >        =3D offset * M2 + clock_delta * M2 + N(P1)
> > >
> > > Apprently, N(P3) goes away from equation (1). To correct it, N(P1)
> > > should be adjusted at P2:
> > > N(P1) -=3D offset * (M2 - M1)
> > >
> > > To fix this issue, the patch accumulates offset into tk, and export
> > > N(P2) to real tk and vdso.
> > >
> > > tk.tkr_mono :=3D N(P2) =3D N(P1) + offset * M1
> > >
> > > Then at P3, we calculate N(P3) based on N(P2) instead of N(P1):
> > > N(P3) :=3D N(P2) + clock_delta * M2
> > >
> > > Signed-off-by: Lei Chen <lei.chen@smartx.com>
> >
> > Thanks for the email and the patch!
> >
> > So, I'm having a bit of a hard time understanding the issue you're
> > actually seeing. It seems to be that you're seeing
> > CLOCK_MONOTONIC_COARSE go backwards?
> >
> I'm sorry for that.
> Yes, it's CLOCK_MONOTONIC_COARSE that goes backwards.
>
> I hope the code flow can help to explain it.
>
> In user space, clock_gettime(CLOCK_MONOTONIC_COARSE) actually reads
> tk->xtime_sec and tk->tkr_mono.xtime_nsec.
>
> But when ntp calls adjtimex, the code works as following:
> do_adjtimex
>     timekeeping_advance
>         timekeeping_apply_adjustment
>              tk->tkr_mono.xtime_nsec -=3D offset; ------------------- (1)
>     timekeeping_update
>         update_vsyscall    -------------------------(2)
>
> At (1) , if offset > 0, xtime_nsec will go backwards.
> And  after (2) CLOCK_MONOTONIC_COARSE will go backwards.

So, I understand we subtract offset from xtime_nsec, when the mult is
incremented, as this is necessary to avoid time inconsistencies with
the non-coarse clockids, since we have unaccumulated cycles in offset.

Briefly:
mult_2 =3D mult_1 + 1
xtime_nsec_1 + (mult_1 * offset)  =3D=3D  xtime_nsec_2  + (mult_2 * offset)
  =3D=3D  xtime_nsec_2  + (mult_1 +1) * offset)
  =3D=3D  xtime_nsec_2  + (mult_1 * offset) + offset

Then cancelling from both sides:
xtime_nsec_1  =3D=3D  xtime_nsec_2  + offset
And re-arranging as such:
xtime_nsec_2 =3D=3D xtime_nsec_1 - offset

So yeah, I see the concern, as when we are dealing with the _COARSE
clocks, we don't use the offset value. So the subtracting offset from
xtime_nsec initially seems problematic.

But the key here is the timekeeping_adjust() logic, which adjusts the
multiplier and is all done *after* we do the accumulation, adding
(possibly multiple) (mult*cycle_interval) intervals from the offset to
xtime_nsec.

After the accumulation, offset must be smaller than cycle_interval.
So the negative (un-multiplied) offset size adjustment to xtime_nsec
should be smaller than what was immediately before added to it.  Both
accumulation and adjustment are done atomically together under the
tk_core.lock, so I'd not expect to see an inconsistency here.

My suspicion is that if we are coming into timekeeping_advance() more
frequently then cycle_interval cycles, than its possible we didn't
actually accumulate anything, but had some left over ntp error that
triggered a mult adjustment, causing a xtime_nsec to be decremented
without the normal accumulation before that. Opening up a window for
the inconsistency.

The "if (offset < real_tk->cycle_interval && mode =3D=3D TK_ADV_TICK)"
check there is supposed to catch that, but with
timekeeping_advance(TK_ADV_FREQ) it looks like during an ntp
adjustment we can try to do the mult adjustment without accumulation.

Thomas just tells me now he's found a fix, so hopefully that will be
incoming soon. I'll probably be drafting my own approach just to make
sure we're aligned.

I've also found this is pretty easy to reproduce but unfortunately the
kselftest skew_consistency focused on MONOTONIC and didn't check
_COARSE clockids, so I'll try to tweak that test as well so that we
have better coverage for this case.

Thanks so much for finding and reporting this!

thanks
-john

