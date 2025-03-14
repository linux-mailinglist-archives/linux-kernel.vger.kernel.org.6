Return-Path: <linux-kernel+bounces-560762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1DA60935
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C207E3A68BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CF13D246;
	Fri, 14 Mar 2025 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Aq9/1tfp"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277D2F4A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741933941; cv=none; b=FZagcxj4BDWJNpRX/cqjSnJRgA9j+zSs7fT461W+xcU9LmDiwR9OdYxgEWT3RH0CwHoQUZBfCPS3IOr8hpMa5nx/Xeu1ZwTaeXDI4EFTpsXcYBpe2Cio81LToUW65jzOk20G4KarpC1VunlFZHhIEuF5rB3wVjPfsYfVwaVPAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741933941; c=relaxed/simple;
	bh=tDYSQdG8a0UkcNzTAhdLSVTqfLqjx+9xH4EZD2wQ73Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXayk+ftmK66PMw0kpnc/3xQcY3ZSQ2gkZ+xoU7I05DvGGS1skt7bmIvO+++tFE+curWnDmYR5dqOZ8uOPg/peDImJ7unxMvl4TvDDZUlk4kS9wo1062x/N3hwd+AzycbYwGlkjtE3lkkBkAj3GKE4Zzz/ajnjbcdz5XBkAN++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Aq9/1tfp; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e62d132a6a7so1334958276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 23:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1741933937; x=1742538737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSye0IM6T+fFQco88xqM+x+quRiF8O1alSjOUyDpMzU=;
        b=Aq9/1tfpVRn18xEfiljLow6+1aZK3tuoZBfknYfxpxKz2TZi9UW/ysY+DWEZHS7gkI
         hS88+0/+R5+6OHghg2D7A9UsyOuqZLls6WLStTG+7P+ZccbwYf03r2F9pfl08qDFPel5
         TgaCMnyKIW8TAslX4Q2Ws5eXG5eviLl/MZADzAjjMZhl0OaIAVipRsu6LnLFcBI4Tc+d
         /CbrM8C7fV1qdx9uaM+OLPnC/xFshjboUxy/NahC7vZyaGk37wU3xn3EL8jfI5IOfXBh
         u4Wu6nNZw2kZuPMcy/FsAvmIsFrUAL84YV00EeqsS+pVi08zkxPmJ+73+ua3CjpSHJ4f
         zEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741933937; x=1742538737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSye0IM6T+fFQco88xqM+x+quRiF8O1alSjOUyDpMzU=;
        b=tQjMN5Hb1bk/igrqUhSak808VV8NOQZAeatnLqNNyR7Pu9zN/wecZkvyGXP/nb4hdb
         nXQ122lZS6NegN5av53x8PRItyW/dHWyou6v0YdEnvRqPjDIsHv0F1hoI5LVcmrZ4XKR
         mgrY/R1/9nIcUxsTpEzclYXCDa4L/tUnDQh1z+akhIZv7JMIqXiHnpeYkyGzdpWzVFdV
         6R5/1bDDqqM+g8jH1QcuJKl//5M2k98i0tBOSMCTb6rZov7FnZeXZb0B8zAC4rjjJ2za
         LxMd8dFXFtiMSzRLmzpSEbKYLM8EEdcfFX8M3zKM2gszxu0wtBAhJp91C/Ht9OitUwQ+
         Xy7A==
X-Forwarded-Encrypted: i=1; AJvYcCXFgqAteOOIz2OMmbHSL2T/HbqMHcY2d1dPqCcIl0YQtF2nrEdPeIEc9hHlizI3eZVq2TTnoHSi+scZ6Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw4vZrM5KUydDA499K3i751hKDQWUCw7OeKmVdAVRYXcGyvGVz
	nCOVbqK1LBP7j0GdHd7YBzqcnAkYx8A6BwomAEwBEG0lc1YwpPFt2pZGHlSNrRjmcEtEXz8T0TL
	UWqDoTeA6DpwYMJcrWDPwDHu1bTgV93HhX0x9BjxhQtpFM7zLw7+eLg==
X-Gm-Gg: ASbGncvPOj7IQXtFNi6pBKyT9a2O6WkrYNBoX/njDaX378+LpIq2lALKtxtxABQ5qp4
	+FT+d984EciilwDRS94BbP9q3lQ5RWMoY6IyTYNlDvvgG6DGxi7HK5ITIJDadOzL0hy9qRjP/pz
	W8zvwc3mvxxQ+6Ki3Ua7kWqKRnaFGH
X-Google-Smtp-Source: AGHT+IFdjV9rvN6kWBxbM1SXcx8x+0H5sVId9xosBFldVnnwqvfbgP3qQnnCXQIHKgeW6aNkyaVLID3Tl8HDVLihFwI=
X-Received: by 2002:a05:6902:208a:b0:e60:78b9:1502 with SMTP id
 3f1490d57ef6-e63f6506badmr1495714276.16.1741933936533; Thu, 13 Mar 2025
 23:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310030004.3705801-1-lei.chen@smartx.com> <CANDhNCoRxxA-CxOQ6vxfjf6BDxR-gqCC_QE1wwf4L3gwrvfv6A@mail.gmail.com>
In-Reply-To: <CANDhNCoRxxA-CxOQ6vxfjf6BDxR-gqCC_QE1wwf4L3gwrvfv6A@mail.gmail.com>
From: Lei Chen <lei.chen@smartx.com>
Date: Fri, 14 Mar 2025 14:32:05 +0800
X-Gm-Features: AQ5f1JoiKQn67UElYIocTCxZX2V5H2HB55w4VkGkg4WL6wV7oqkECoizqNvItRk
Message-ID: <CAKcXpBwvjrmoPnfFgaXs81XF5du-mWzLiJ+8YvvhM_1tQMiZBQ@mail.gmail.com>
Subject: Re: [PATCH] Fix rolling back of CLOCK_MONOTONIC_COARSE
To: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John,
Thanks for your reply.

On Fri, Mar 14, 2025 at 1:20=E2=80=AFAM John Stultz <jstultz@google.com> wr=
ote:
>
> On Sun, Mar 9, 2025 at 8:00=E2=80=AFPM Lei Chen <lei.chen@smartx.com> wro=
te:
> >
> > timekeeping_apply_adjustment try to adjust tkr_mono.mult by @mult_adj.
> > If @mult_adj > 0, tk->tkr_mono.xtime_nsec will be decreased by @offset.
> > Then timekeeping_update flushes shadow_timekeeper to real tk and vdso
> > data region. Then rolling back happens.
> >
> > The drawing below illustrates the reason why timekeeping_apply_adjustme=
nt
> > descreases tk->tkr_mono.xtime_nsec.
> >
> >      cycle_interval       offset        clock_delta
> > x-----------------------x----------x---------------------------x
> >
> > P0                      P1         P2                         P3
> >
> > N(P) means the nano sec count at the point P.
> >
> > Assume timekeeping_apply_adjustment runs at P1, with unaccumulated
> > cycles @offset. Then tkr_mono.mult is adjusted from M1 to M2.
> >
> > Since offset happens before tkr_mono.mult adjustment, so we want to
> > achieve:
> > N(P3) =3D=3D offset * M1 + clock_delta * M2 + N(P1)   -------- (1)
> >
> > But at P3, the code works as following:
> > N(P3) :=3D (offset + clock_delta) * M2 + N(P1)
> >        =3D offset * M2 + clock_delta * M2 + N(P1)
> >
> > Apprently, N(P3) goes away from equation (1). To correct it, N(P1)
> > should be adjusted at P2:
> > N(P1) -=3D offset * (M2 - M1)
> >
> > To fix this issue, the patch accumulates offset into tk, and export
> > N(P2) to real tk and vdso.
> >
> > tk.tkr_mono :=3D N(P2) =3D N(P1) + offset * M1
> >
> > Then at P3, we calculate N(P3) based on N(P2) instead of N(P1):
> > N(P3) :=3D N(P2) + clock_delta * M2
> >
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
>
> Thanks for the email and the patch!
>
> So, I'm having a bit of a hard time understanding the issue you're
> actually seeing. It seems to be that you're seeing
> CLOCK_MONOTONIC_COARSE go backwards?
>
I'm sorry for that.
Yes, it's CLOCK_MONOTONIC_COARSE that goes backwards.

I hope the code flow can help to explain it.

In user space, clock_gettime(CLOCK_MONOTONIC_COARSE) actually reads
tk->xtime_sec and tk->tkr_mono.xtime_nsec.

But when ntp calls adjtimex, the code works as following:
do_adjtimex
    timekeeping_advance
        timekeeping_apply_adjustment
             tk->tkr_mono.xtime_nsec -=3D offset; ------------------- (1)
    timekeeping_update
        update_vsyscall    -------------------------(2)

At (1) , if offset > 0, xtime_nsec will go backwards.
And  after (2) CLOCK_MONOTONIC_COARSE will go backwards.

> The approach in your proposed patch seems to undo some of the
> cycle_interval chunked accumulation, which was intentionally avoiding
> the multiplication. Instead it tries to accumulate the rest of the
> sub-cycle_interval unaccumulated delta. I don't think this is correct,
> as it likely would cause problems with the error accounting, as we
> accumulate the error in chunks calculated to match the cycle_interval
> chunks.
Thanks for your suggestion.
Can we just skip modifying tk->tkr_mono.xtime_nsec
in timekeeping_apply_adjustment ?
>
> Additionally, your changes are all generic to CLOCK_MONOTONIC, but
> your subject suggests only MONOTONIC_CORASE is having the problem?
> Could you explain in more detail the problem you are observing, and
> how it triggers?
> It seems like reading CLOCK_MONOTONIC_COARSE while making a large
> negative NTP adjustment would be able to reproduce this?
>
> thanks
> -john

