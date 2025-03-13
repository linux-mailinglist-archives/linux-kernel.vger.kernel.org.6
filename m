Return-Path: <linux-kernel+bounces-560092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18FA5FD99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525E53BC317
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32B16DC28;
	Thu, 13 Mar 2025 17:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQJgM4Cz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1A6F2F2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886454; cv=none; b=p0ow0h7nvkgIo1ODSvI1v3ASXdhRnZxVEdRiC4pAgh44v2NXY6xujEgK1O8um7HPRz/Z+6G7+S5U21q5F3IZOiUenBnK+zfTf2clIHVieKhCn6hDbcLeDclyNGilJAus3D2DJcEMpUX0DRAxgUf5R/szDGw5UlDILF4ipiw66yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886454; c=relaxed/simple;
	bh=OLKBnNsMngGmJm6dpFIEeHln6vIL0XyDfg8TqpsYxEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnQe0b1ntNl8T4LRSZIEWdEv8xidzkaxxa9BhWT5bPAxsqFPpnLfZw0c7gEEmJ1GEt6DcByTTa+r/DzyMaRY8pUo0ppw2qB7r0xMzS6g5gebNB9WRUHd6/O3GLLxnAcC7V5J0+i2J2DUmcxEb8jm0XHkZWsbbbkbUl3HgKlnbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQJgM4Cz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307325f2436so12061161fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741886450; x=1742491250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCGXjrhsE9oWGfXs3bCuaZWdIdJANHhaJh5AOXV0WQw=;
        b=jQJgM4CzcFv0N5DwwdtB7B3qDIV3gmIi0+wEpY1+O1jhtRNk9cUs5ymrwRC/hUsGCg
         xpuLDjlxDbYdkWRVSdweFl5VeL/gNCSYqkYEFNOfQusUcRzPxmOoO1ILrF0ezKLbvL1c
         99lEi8IwdW8d8IAsncQKxKjdHQJrtttipYzhxTvaJgthteWE1fcXzrcmLAdEYiHwSerJ
         v97A0WCMJZP2ODaPRMkV26fIfuNZT3GsQg5TB8p938L6sLxih4vQYWzT8ff2AXPhQCnT
         LAB3jMlMiNWiKdSJgsF8TG8Ql3JMUP6jIF7xMXGb/7KRoZrhFqkrM1dUin5I0PE0SEPX
         Kg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886450; x=1742491250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCGXjrhsE9oWGfXs3bCuaZWdIdJANHhaJh5AOXV0WQw=;
        b=w+T6uYQqqREgHguedqpy3Vp02f1kvYTvS+Vn7T0JiK1/m6JpNxS/anZreqs9YfNUWk
         5RynJjEQCfzL/H8FYPwUBwfJ3c9YDRveygDeqNObbhcgRCB5fVtgMZnAeTKFkZBYid0T
         ho0Vb+56gkYoey4DVRNC9mob9LUHIkh6vveNb7fsmvnCQc2/8oDwciufUF/MQevUaxy1
         CCVCi95yMg+mIIJcPXQ72nIevXDZph1ilyGNHLuckaPuXTg47QQEVW7sx+TOgAH/8BZz
         Ez+Vuajc3Jx+z8ZP5ITXo1aLFphvsPSZ5kRVHSp6JL7tv1wGXl2cGG5ONp1jdswOwo9y
         AQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCUupyT33tuDJeKiUeHnYl5A8nlUirkbC1AQI5KAY7iRiqY0C9uKohtYkJ+fzAB4Rc2pTsJXtaq3/h6WvvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMbV9I5rJbgaGwNUqcZOaEPhXknLkkd+M+GTvD18b78qfsBIJ
	jCsFU08z2/0/WiN4lteRQJLeTs9hh+njiKdWh24h6mpYmDeNXqoeOxxLHs6406v4eqRJZ+caHoY
	WxyPu83DvAlDxDZTMd6qCPtIYnxqtmSrD++U=
X-Gm-Gg: ASbGncueZpDdAKrzLbFBX/ahY4ilc1amDS8Q2hAcmlhQbBoN4xpWhy4ochFmXuN3gFW
	Qb8JvXgo/szKQQSpid6j9PnoqH2MAAQIM7Tg7o9862nu+lkttqvXDHRIz0P21/ojY0RikCzhpNx
	8dY8AA3GfPM8lz7EJ0mh85CcrGOBf3rxff8ntsNiAz8f/oXIUiMVUUmfw=
X-Google-Smtp-Source: AGHT+IE0zMOBZIfP9ij8kToK0CzIWUcde88XYJO2NY52WAFstx8EGXE92pCIM1DFfsWbgoK+lewg6aI6PQ3+Hc21W5Y=
X-Received: by 2002:a05:6512:2253:b0:545:c7d:1790 with SMTP id
 2adb3069b0e04-549c09ebe79mr239070e87.22.1741886449936; Thu, 13 Mar 2025
 10:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310030004.3705801-1-lei.chen@smartx.com>
In-Reply-To: <20250310030004.3705801-1-lei.chen@smartx.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 13 Mar 2025 10:20:37 -0700
X-Gm-Features: AQ5f1Jr2mVWGYYs6j6-97VQrjm8ignEgA4W2qr7Gyt-Z_9-pvHrJZ5Iak8URCiQ
Message-ID: <CANDhNCoRxxA-CxOQ6vxfjf6BDxR-gqCC_QE1wwf4L3gwrvfv6A@mail.gmail.com>
Subject: Re: [PATCH] Fix rolling back of CLOCK_MONOTONIC_COARSE
To: Lei Chen <lei.chen@smartx.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 8:00=E2=80=AFPM Lei Chen <lei.chen@smartx.com> wrote=
:
>
> timekeeping_apply_adjustment try to adjust tkr_mono.mult by @mult_adj.
> If @mult_adj > 0, tk->tkr_mono.xtime_nsec will be decreased by @offset.
> Then timekeeping_update flushes shadow_timekeeper to real tk and vdso
> data region. Then rolling back happens.
>
> The drawing below illustrates the reason why timekeeping_apply_adjustment
> descreases tk->tkr_mono.xtime_nsec.
>
>      cycle_interval       offset        clock_delta
> x-----------------------x----------x---------------------------x
>
> P0                      P1         P2                         P3
>
> N(P) means the nano sec count at the point P.
>
> Assume timekeeping_apply_adjustment runs at P1, with unaccumulated
> cycles @offset. Then tkr_mono.mult is adjusted from M1 to M2.
>
> Since offset happens before tkr_mono.mult adjustment, so we want to
> achieve:
> N(P3) =3D=3D offset * M1 + clock_delta * M2 + N(P1)   -------- (1)
>
> But at P3, the code works as following:
> N(P3) :=3D (offset + clock_delta) * M2 + N(P1)
>        =3D offset * M2 + clock_delta * M2 + N(P1)
>
> Apprently, N(P3) goes away from equation (1). To correct it, N(P1)
> should be adjusted at P2:
> N(P1) -=3D offset * (M2 - M1)
>
> To fix this issue, the patch accumulates offset into tk, and export
> N(P2) to real tk and vdso.
>
> tk.tkr_mono :=3D N(P2) =3D N(P1) + offset * M1
>
> Then at P3, we calculate N(P3) based on N(P2) instead of N(P1):
> N(P3) :=3D N(P2) + clock_delta * M2
>
> Signed-off-by: Lei Chen <lei.chen@smartx.com>

Thanks for the email and the patch!

So, I'm having a bit of a hard time understanding the issue you're
actually seeing. It seems to be that you're seeing
CLOCK_MONOTONIC_COARSE go backwards?

The approach in your proposed patch seems to undo some of the
cycle_interval chunked accumulation, which was intentionally avoiding
the multiplication. Instead it tries to accumulate the rest of the
sub-cycle_interval unaccumulated delta. I don't think this is correct,
as it likely would cause problems with the error accounting, as we
accumulate the error in chunks calculated to match the cycle_interval
chunks.

Additionally, your changes are all generic to CLOCK_MONOTONIC, but
your subject suggests only MONOTONIC_CORASE is having the problem?
Could you explain in more detail the problem you are observing, and
how it triggers?
It seems like reading CLOCK_MONOTONIC_COARSE while making a large
negative NTP adjustment would be able to reproduce this?

thanks
-john

