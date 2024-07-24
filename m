Return-Path: <linux-kernel+bounces-261458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74E93B79C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED4D1F23D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041CB16C69D;
	Wed, 24 Jul 2024 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XyueOVUI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98F613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721849673; cv=none; b=FCX0dsORmxxf5tXMWFg7bUB4vXJ+BuXEg+t0zCCZD8tfAA9G7YpmQbgbeLj7XI/E9gdfioXC+fLPq5kYJXZ2ucbKsFIOawPLXK8MO4gkCb7rSzRzopzrk4b1+xvY4+NfY5lEb69osRzy+nxgaWYiGtsvo37USYqP0/fWkQCzUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721849673; c=relaxed/simple;
	bh=FKJy609O/RntGMk3g5/CVS3zTBU/bPfy34MfF2SDziI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLp6xiL3voUT48NSCAWZuOe9O1RP4VtC0+Sv3bXlox8Cok8HFcURR8zfu3W2zbZYzTuYrfOqdfgql37XUgL3lP+9zu26zijynXM38zpa7Y5muCWW492GrPt2eFyw+8OOBoieuzoAWaQ76cw+sl5uvzTmN58vrWxLN8+E3Bqvlbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XyueOVUI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a22f09d976so2232800a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721849669; x=1722454469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BlhvipNaCT5cUfH7RjUiYW0sn9RibqnWDx46MZHPGM4=;
        b=XyueOVUI/NniLqoWThns9bDFFJ6sr769RlS1CTr7/jzKOgYs9GqDqmYXG8rjsgfw2w
         Ac0uqZdBFmzabj25HOA1qT3P7GioM0eFGVawudPgyKn8QiCnCkAnDyacieoz8UdDtKsE
         RteX7GnbvR144bLgA8Nc8rHo3lfNkDAA+QrPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721849669; x=1722454469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlhvipNaCT5cUfH7RjUiYW0sn9RibqnWDx46MZHPGM4=;
        b=obMkm0Nmp+xD87Ptrm14VeX7WFBYd3KO7vky3CTLLFmusENSC3f2T2uCT31dah2GS3
         H3aI9M9FpnkrT24YoKFDrKiBxk3Se/XT4+UC+7AwpSHChghQEbX6yoUOuRI9Ol5qL6ma
         C4tDa8VsjzRZntAUnrfAppTzELPvg8vE18084sb37j6ICTz08TELqsYx13Z/YuqBdS5a
         u/Tbj/J0y0luPFCPc1mDl1xlswsjDntpam44Efjw1bSasdaiC8maEcc1E9s8EcbcqIeg
         MbDSxMnjo2GES1l4OfU24O/igd9HcmH0GKyfYyr7ar19ongpfBaCoyXInNnZ4zQ6mj2Q
         uF5A==
X-Gm-Message-State: AOJu0YzQFg/rv+tytaBZgFQeB2t1uffHOa4Wsmccz6kSkYtBgPK99yvt
	YJTaCyuruDUKFdVX1GdKPUGlrVisM3lK23p5Ww9sQDglAo6xr2g51ifgWyyTVLkKXqbLt/PDkZT
	rJGI=
X-Google-Smtp-Source: AGHT+IHz7va/BpY4bwImZz59bAVy8Mg4mYLdSpawsi6emcJ8ppf+8HngGtTl6dD+jQHRMEnH/Kl9mA==
X-Received: by 2002:a05:6402:3511:b0:58c:36e:51bf with SMTP id 4fb4d7f45d1cf-5ac123a7ac3mr644209a12.3.1721849669058;
        Wed, 24 Jul 2024 12:34:29 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d7265sm9344986a12.9.2024.07.24.12.34.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 12:34:28 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ab76558a9so32692366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:34:28 -0700 (PDT)
X-Received: by 2002:a17:907:7244:b0:a77:c051:36a9 with SMTP id
 a640c23a62f3a-a7ac44e144amr69153866b.9.1721849667699; Wed, 24 Jul 2024
 12:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63149ac0-73a4-49c0-975b-75dc3bd32f7a@I-love.SAKURA.ne.jp>
In-Reply-To: <63149ac0-73a4-49c0-975b-75dc3bd32f7a@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jul 2024 12:34:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAfNJKeP1WhdP9y0itF_AkgQJMyz8B9TCfAWWQRhDRPw@mail.gmail.com>
Message-ID: <CAHk-=whAfNJKeP1WhdP9y0itF_AkgQJMyz8B9TCfAWWQRhDRPw@mail.gmail.com>
Subject: Re: [GIT PULL] orphaned patches for 6.11
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 03:08, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> These are two of orphaned patches which nobody can take (and as a result
> bugs remain unfixed for years). These patches have been tested using
> linux-next tree via my tomoyo tree since 20240611, and nobody found problems.

Honestly, I've looked at this multiple times, and I think the reason
nobody will take them is that the profiling one in particular seems
horribly overly complex.

Yes, there is most definitely a bug in profiling_store() if multiple
threads call it concurrently, and we try to set up the profiling
buffer multiple times.

Doing that definitely falls under the "Don't do that then!" and is a
root-only operation anyway, but I guess to make syzbot etc happy, it
should be fixed.

But honestly, the minimal fix would seem to be this two-liner:

  --- a/kernel/ksysfs.c
  +++ b/kernel/ksysfs.c
  @@ -92,7 +92,9 @@ static ssize_t profiling_store(struct kobject *kobj,
                                   const char *buf, size_t count)
   {
        int ret;
  +     static DEFINE_MUTEX(prof_store_mutex);

  +     guard(mutex)(&prof_store_mutex);
        if (prof_on)
                return -EEXIST;
        /*

which I have admittedly not tested at all, but seems trivial.

And once that "no more multiple concurrent profile initialization" bug
is fixed, everything else is fine. The assignment to "prof_buffer"
will now be the last thing that is done, and when it's done the
profiling should all be good.

All the other problems came from prof_buffer becoming NULL again after
it had already been initialized, because of the "let's re-initialize
it and the first allocation fails" issue.

IOW, I think the above trivial patch is sufficient to fix the problem,
and I don't think this kind of "only syzbot would do this anyway"
issue is worth any more than those two lines.

Have I missed something?

The other patch in there (to just arbitrarily limit max slots to 1k)
looks fine and simple. But I really had to look at the profiling patch
multiple times just to understand what you are fixing, because it
looked so excessively complicated.

                 Linus

