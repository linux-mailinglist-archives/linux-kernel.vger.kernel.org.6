Return-Path: <linux-kernel+bounces-327243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD689772BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256BD1C23D25
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE51BF80E;
	Thu, 12 Sep 2024 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zGQz/FO"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17913CFB7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173228; cv=none; b=SrLtDJEd1c9fVR0dz18gCeBZdXlp4fraCOZy9UJjNlPlMO2Alg8pdd59rmUG1DIg+O3f099+lamNNQgTWz8Hp5rBTH6TNXlLzG5haUnutmuhZ1pwrhjLICWU2gP7alBjzk1Zu6M5u1qsMspHWMxky42UECW2UyAFfBr6N/BhkjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173228; c=relaxed/simple;
	bh=f6ERQJbQwk/iGWHYGK3yLPp3M3w3mLPJKq1J/UZVYPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKvdFv91E4f8yyIlvjAJfQERFmyipZ5BoYS8SjRFH+Xh7X380+J6IzpezeuEL+dOoz3ckf/uSxE4LEU80gevmUfFvPYDQUPvlqRACsjcYMIZ7eOE+cEXje75447LfGQJO7VpVXHqxbhYYFXnG23xKfs9x1iW7LpQYjvwcK2BrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zGQz/FO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso202258266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173225; x=1726778025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oS4TU96UJdXs9qX6YedMEwU85mu32Jk86XLWPBY5+dY=;
        b=0zGQz/FOTl7pDfC8We+yk+GPslwhE25kpoK6rfLO9hcd4s5y2PPGbmQc+pBUoJbwZ1
         fzCp/U8LSjFstKNouaX/0BNRhK4oE++GE0X46wCBwS2HYtEIP665Gt7tzUTBsw8e89Es
         KTHQ83u9/XXbfur/K4Z+SAXxJ0KR1OZf9n/iPyxfsvZvE/HCAFzbDDhm2XI1SIUrUl+f
         J7fuO6vOvs/MY7PAhQCmXFLytrzWDG552iGwMbiIT1wEzcdwWkefo+WuHpMFT7JPSzB5
         FflT0yYuuZMLSO+C+74myhnddScRra8f0CH33uZGIOn+sRdX5HES57lZTDJNUKy1FyAk
         5KRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173225; x=1726778025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS4TU96UJdXs9qX6YedMEwU85mu32Jk86XLWPBY5+dY=;
        b=Vmtyr7b16Dr2GKRYcNxc1p7T6pH6rCANezVbS6d16GolvC+q0OxJgAB00zYUG8g3Jm
         JEms7O9OpWobwTiNQABxHv/8BEKvX4NORhNMGDtamaPu91yLed9ZfUFSFnLyzi9fr19D
         UVJT3ihyhHk7kOCXqKCUf1wm/Xo1ef0iZYlM3PLzJiU2rsYZqIX/62xeNuFqm8Jfjo2Q
         12fQUNFupSgvaQJTlvb6U/17X3cp7xP0SoFQ07M2JyaVLhHTUoNTA7z5Wc/Kr3KXPeYR
         fR2Bm4R7g2i/mIFT+8KXrLUa1b6YVKSSqkoI6Z2wGQPXYsk/P6aQH50aYElUnNHDQ8VH
         oO7w==
X-Forwarded-Encrypted: i=1; AJvYcCVHB/inK0LZZkmm1QICO3Oyv5nafWIMmwv8EJPKY83XlFrakCvn+vA/CBkSDNItQu2gfdN1Tu2NLqHlByI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaS5TjelXQB8pAX39n9ONYG3tR0K31/0NO2E0pAWGszJTWTHXh
	8vAzvCf6uZLBB18YUidh27AFqMh8ouc3031RcfD1SCBHP+drcYKYli/uUn8pkfqOHg8LRsEdAaR
	3okgtiY11jJqXIO1GTRFzTU86H0kVr+QQqn8=
X-Google-Smtp-Source: AGHT+IHpCG5S7D8Lnxdd6/fbpN05HhZ/okJ2Tpoe1ppVltTR9mHYnJ+v13xdOmFSTQ7kYpK54QTuqRYek1b99JPjfOw=
X-Received: by 2002:a17:906:fe47:b0:a86:a41c:29b with SMTP id
 a640c23a62f3a-a90293c50d9mr475525166b.8.1726173223814; Thu, 12 Sep 2024
 13:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-mgtime-v2-1-54db84afb7a7@kernel.org> <CANDhNCrpkTfe6BRVNf1ihhGALbPBBhOs1PCPxA4MDHa1+=sEbQ@mail.gmail.com>
 <80f8f49da3f7208101e497a130a8abe106b298ad.camel@kernel.org>
In-Reply-To: <80f8f49da3f7208101e497a130a8abe106b298ad.camel@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Thu, 12 Sep 2024 13:33:32 -0700
Message-ID: <CANDhNCoLCbAYRtA+kjVNiTeNZg6UtCycNpNievLboXbjNU-a9g@mail.gmail.com>
Subject: Re: [PATCH v2] timekeeping: move multigrain timestamp floor handling
 into timekeeper
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:18=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
> On Thu, 2024-09-12 at 13:11 -0700, John Stultz wrote:
> > On Thu, Sep 12, 2024 at 11:02=E2=80=AFAM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > But instead, it seems like if something has happened since the cookie
> > value was saved (another cpu getting a fine grained timestamp), your
> > ktime_get_real_ts64_mg() will fall back to returning the same coarse
> > grained time saved to the cookie, as if no time had past?
> >
> > It seems like that could cause problems:
> >
> > cpu1                                     cpu2
> > -----------------------------------------------------------------------=
---
> >                                          t2a =3D ktime_get_coarse_real_=
ts64_mg
> > t1a =3D ktime_get_coarse_real_ts64_mg()
> > t1b =3D ktime_get_real_ts64_mg(t1a)
> >
> >                                          t2b =3D ktime_get_real_ts64_mg=
(t2a)
> >
> > Where t2b will seem to be before t1b, even though it happened afterward=
s.
> >
>
> Ahh no, the subtle thing about atomic64_try_cmpxchg is that it
> overwrites "old" with the value that was currently there in the event
> that the cmp fails.

Ah, ok. Thank you for the explanation there!

> So, the try_cmpxchg there will either swap the new value into place, or
> if it was updated in the meantime, "old" will now refer to the value
> that's currently in the floor word. Either is fine in this case, so we
> don't need to retry anything.


Though if cpu2 then made another call to
ktime_get_coarse_real_ts64_mg(), the value returned there will be the
same as t1b? and would be before t2b?

thanks
-john

