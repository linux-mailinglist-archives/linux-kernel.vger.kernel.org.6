Return-Path: <linux-kernel+bounces-182678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393E8C8E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3531F1F222D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259BE381BA;
	Fri, 17 May 2024 22:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYajpESi"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E610316415
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715986449; cv=none; b=ml0BGqiBB8+jz8yUu3xZsDI3dlAiyrNGAQ4Lt9cV7KC/LwNjf9ZayWiVyNIG/hkiiS5SQ/XHqOw66JB9EQdm7zxiWqtPRvCAjXuA6yTr47c88NEHmr+WFZEKotxdpBJH9nQtFH7MzqBni4qyoIH2aVToa2hqVMmfnFq3y8N+xZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715986449; c=relaxed/simple;
	bh=RLRKGWDzpkBCpG5F3ZAlvpq/UQy/STm/wXiH4yR1H5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdskRRbtMvNhGY2dznLp7Ag/N2EZl6UkdOz8h9mMFfkVj6f9heShBqv5ivctC551mWH0SeK7AH5p1bfIYgwXy60rWMIQnDyzxpfpyKo3AdQ9luy7P7ap803n54hKPc3zpR7xpuGfEGZP2pGAKQ7FJn1XK4DXyUutKyG9OBHbXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYajpESi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-351cda41b53so518499f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715986446; x=1716591246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz6Q16/VE6yW7THwpXy9wA+z2fX/PLFAUPnbPAQU51o=;
        b=dYajpESi+FLBwG7TDabA3RAHJNbc7FyUY4Gdxx2Tnt1xGYHwoSMvbQlO4leH+ECCl2
         cUVfqJLRmHPdtwAOuGBl9K7wxL6Xz/wUN9N/svsg/APDJy655ryKaRHuB6PZ8Kmc80wQ
         0Qwh/ETIHaE/ZmggnFuMOvq1AmYtoujb9jwnUE4yI12Hx+KAn9xoxX+AmX1RI/aRZwU/
         mVGROd/nOAMKUlq8o+KY2ULFZR+Qw5MHe5XK6vS0xx/5WXNUy+HBGhL6HDSTNosOXr4s
         7jArvXlLjrMTLnoa5rRJy4onVnGz0KbDnBru0+f0Afarlml3kfH5pf76NO+kLYKy7KvF
         kXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715986446; x=1716591246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz6Q16/VE6yW7THwpXy9wA+z2fX/PLFAUPnbPAQU51o=;
        b=Lq+xGLu0S12NRFVDAwBZcpX95/tv1NbC0+wMH8ZfKLkiOuiU8urvk0OoGlClnUGYsM
         6W5QFnxpoFLbXc0LlQcm3XU8w/5sjEaOFTYhMkcCIWPEnKFyqOD/LStX4vNS+c1qIo33
         01mVl89cS10ySEj1vbJz2QZDUXcDxkVd7KpIzGDpDQsDe82yj+YQ5cKRvL5LTkrtLwph
         dNvjlTIoDrLOdX2DH6VBgBLR8WXwtQa+FvBiX4LAyHwlhQJVwl3EAupB0vZSuBIroqou
         xnBd+QkuoEbPMFiGbFQSwJjuCXiVRTQqvgih6+K93T8BexB39RsWckDVobP5PDyeAU/J
         CDoA==
X-Forwarded-Encrypted: i=1; AJvYcCWaSN4hc/KvrgpcKIZQPI1A+tT/KlrCvDfj5hwCXcedqv3p+2tO7ZHHoZP6UaL7u8RMA8F4ZGfk51jKEFQp7u6KXANhh+RdCMLnOSl5
X-Gm-Message-State: AOJu0Yxwcjow69YVlvteLE+rh2MctBjU8TBw+2w+FFtCo3DdULiljcp0
	/881vuAJpVI4iFfRlfaEE3q2Dr9sAB011LQxU4sJlBK0rGSsSkTSDlMLBf/qBteBuB+1IzpGbdC
	oUoLvQwyfTwYZm33GVNMiWJBCqR0=
X-Google-Smtp-Source: AGHT+IFl3UKaC6vsnVe1jtn6roPdxU4wx0k/yjo45LXAXENMRTK3L3wn5Ptcg046cCmCQaXpTATZq5ebVKup2B5sgSc=
X-Received: by 2002:a5d:4d43:0:b0:345:5f6a:cbf7 with SMTP id
 ffacd0b85a97d-3504a7376a1mr15203162f8f.29.1715986446121; Fri, 17 May 2024
 15:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517130118.759301-1-andrey.konovalov@linux.dev> <CAA1CXcAdG=OFkBzjPqr7M_kC7VZUdj-+vH_2W4UidfbQwfQbeA@mail.gmail.com>
In-Reply-To: <CAA1CXcAdG=OFkBzjPqr7M_kC7VZUdj-+vH_2W4UidfbQwfQbeA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 18 May 2024 00:53:55 +0200
Message-ID: <CA+fCnZeSq0E0SoDOWAEs=ZTYFDZnT2Ox1X5CG1gQC0i88n8WQQ@mail.gmail.com>
Subject: Re: [PATCH] kasan, fortify: properly rename memintrinsics
To: Nico Pache <npache@redhat.com>
Cc: andrey.konovalov@linux.dev, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Erhard Furtner <erhard_f@mailbox.org>, Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 9:50=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> Thank you for fixing this !! The test no longer panics :)

Awesome, thank you for testing!

> Now that the test progresses I also see rcu_uaf failing.
>     # rcu_uaf: EXPECTATION FAILED at mm/kasan/kasan_test.c:870
>     KASAN failure expected in "call_rcu(&global_rcu_ptr->rcu,
> rcu_uaf_reclaim); rcu_barrier()", but none occurred
>     not ok 31 rcu_uaf
>  I can open a new thread for that if you'd like.

Looks like something else is broken :(

Unfortunately, I failed to boot a kernel built with the config that
you provided in QEMU.

If you can provide a config that boots in QEMU or instructions on how
to reproduce the issue, I can take a look.

Thanks!

