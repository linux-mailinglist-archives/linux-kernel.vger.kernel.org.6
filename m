Return-Path: <linux-kernel+bounces-226350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D322D913D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C35C1C20FD7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D503181318;
	Sun, 23 Jun 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NCJ9xubl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C11822E0
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719164953; cv=none; b=ELqTsH7gW4KkTHL73FFVQuHMoJ+HL2QzoL3PxWYhTvFnkk2Y5DHrPSBD9NU37doCqNJP9ZYlvpOX0z2GIPCF83o9Sw1rUgYatzyiA/11PBoVPOsCL0eMYfWBFXysZT6jkSZRHHmBlseqRRBvOsNnD1yQZKlss7D8mWp0n3LgfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719164953; c=relaxed/simple;
	bh=wcdFcMoQThWwG9qZTr5TVP2xgijbHAoj07YzN+ZnusU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajKZw1fOhLb2gwpN0/F7tYMcRZfrYR2ueqa0uTwAgi3GYk9PkkkdbDVxsbsxFefZx2HsrWoIRcjWAqre78DccZeS6ILomvnkWux9gqfiTzeVgOeEqnitSjY42W+FjtoxKMqXFl9iq5TITcr7fEtl7vDILBm9T/JK8xzsuUriBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NCJ9xubl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fdd947967so131411066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719164950; x=1719769750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5bBS4/y88g2wsr1Yt0/71zUw+hOiW/MiIB8thdqOhiY=;
        b=NCJ9xublU4TGiL+k2VWFT4YgdXDNPsixFJjfwjwgizSEVZf6f+ApVABvMy2wJq28Ox
         xBLpAlOEzPCc9ZTgaemPV1WDAUmXtLyhuH+CAvAcwzUR/IbdbzeD0J76eSfdYgr3GG2w
         N7HHZaug7hXnevaGg7G/WGtnYfmRIVU6t04Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719164950; x=1719769750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5bBS4/y88g2wsr1Yt0/71zUw+hOiW/MiIB8thdqOhiY=;
        b=qgMAtOzzXqLQVaWKGH+2QogZ/Ct3wnb04JBNVDkCY0Uy0hkU86LMB4j6o6CPIGlNxq
         51LiSNSARizB3Cl0RlNvO5I5ngQ2r9KA3wMvb4lB9kMJuFi2YEZGyGadqs24bT/iN0tS
         vqLY+h+E6s5I+XB61g0UC60tF6puqdREKavFni3NHiOj0KCzHFj3+V+mIc+VTsDzOVfX
         BwEXMcYZ/b3aK5GzIKFBrf2YgpfKJoajgJNuP4q2Ccc3nAgR6Fn2+Lq8pRVTjTlpbt6+
         QYpZHuMdbSlLfQDr0bpdP86YX35LLR8FGxrvZtDKGHnvs1z+aKt7QbK8Vf4yH4WzGYaY
         Al0g==
X-Forwarded-Encrypted: i=1; AJvYcCUR+MpG4zxsE+07p9mCaHerXMi6P8bT3I4XTmCE4cGneC+kbXnG6VKpfsWRzjjKlehIzqubQ/k7bEJvfVNQ8NS/3e+f6hNCFB0+dh9i
X-Gm-Message-State: AOJu0YyaqKvUC+8SQTre0reqN7A9JvH7ngRkvEPRHoYyenD/mki2j/QC
	oHIfVWTHfEkE04c7EG42pLP53ae5wWY6YwBdsNLkDaJis+B5aQbt4Xi4kARvSXdRGsnNyoIncS2
	9aoen4g==
X-Google-Smtp-Source: AGHT+IHOX0GMWPfmKor8BUtsLJk0FbUDvuEhltxWeCiB8GPXZKhLvWPtnID3ncUXfHOMNMDjqIDj1A==
X-Received: by 2002:a17:906:22d7:b0:a6f:e459:30c9 with SMTP id a640c23a62f3a-a7245cc081cmr204495166b.74.1719164949921;
        Sun, 23 Jun 2024 10:49:09 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7242aa3c00sm151975366b.225.2024.06.23.10.49.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 10:49:09 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6fdd947967so131409966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:49:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUz7ZI2mkpfHVCAuzdFn6knmLWX+G2TtqPshpZ1uAX969uVqvkv+5YNYsxML0gpHieYtcl88K6BW+IQxOaSoY6N71hQ/qUZ1SPwZeDJ
X-Received: by 2002:a17:907:c289:b0:a72:4f24:1a28 with SMTP id
 a640c23a62f3a-a724f2425f0mr131294866b.27.1719164948938; Sun, 23 Jun 2024
 10:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com> <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
In-Reply-To: <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 13:48:52 -0400
X-Gmail-Original-Message-ID: <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
Message-ID: <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 13:43, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> I disagree with the above.

Your disagreement just doesn't matter.

We don't introduce regressions and then blame others.

There's a very clear rule in kernel development: things that break
other things ARE NOT FIXES.

EVER.

They get reverted, or the thing they broke gets fixed.

This is not debatable, or something you can "disagree"' with. This is
how we work, and if you disagree with that, you had better get out of
kernel development.

> As said in my previous message, if the compiler can't handle
> __try_cmpxchg implementation, the most straightforward and reliable
> solution is to implement atomic64_{and,or,xor} as outline functions,

You also seemed to say that nobody was doing it.

Which means "revert". Because that I can do trivially.

Now, from having looked a bit at this, I can point you to the
differences introduced by having to have the emulation fallback.

And I would personally be ok with leaving Pentium etc entirely behind,
and getting rid of said fallback, but that's an entirely separate
thing that will require much more discussion.

Some people still wanted to support old 486 clones not that long ago.

             Linus

