Return-Path: <linux-kernel+bounces-261775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD0B93BBF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B02FB21C56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86F1C6A3;
	Thu, 25 Jul 2024 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vr6XZTVN"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA512B95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721884325; cv=none; b=Isp4/Hsx14fLD3+ZyQMF+L0feqLdQe3YQu55enbJhYFlH9YGCh0LHADfgmUpTsbU6J/gbJbsOPQP4kNTDEg7skMYo9CP5PshuDuXDSqe01AnxOnL9jqv2V1RQ/Eu1bBHlxhvgrWvgqUHyf2zMSO6MUBNh/L7t2l46CZtWM9zneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721884325; c=relaxed/simple;
	bh=gP19qtha1QfnGzxFGdkfIe/Kk6Vh/E3r0N4r7kHqpzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjduEOuqFGOhpgyX+Zo+7mDpZf+mRBow5it59sOSNnmXK/A6PXsG2DrcbuLuGrW7CS9vU/lNr32ExiK+FdyAdMpKOc9V3tJuGCC3WABZkgENxCl9xeogGjurWBkqmM2PptLUvT+DaV/jlRQsHsaWZod8nwRaEJTy3alsCxsNWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vr6XZTVN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2d7d8854so5980781fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721884321; x=1722489121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3BmdRKWZSq45FPwmbDQuz2L1sHehf6z5rR+bt1yQbs=;
        b=Vr6XZTVNSonzi1d2JFIC2uQGx4nAYxl+5slFObw7+LNXT5DmnayOnJtn/VyhiiLGWg
         ryZ3rhVQj2muHpO+yZWqqgyz7Yx2Hr1hfHoeymbotdI0/bI5uugF4TSoa//k4b1Y49kw
         r5TwwFgH69rd5RIlHrmv+dHtGGYT4D2wBk2to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721884321; x=1722489121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3BmdRKWZSq45FPwmbDQuz2L1sHehf6z5rR+bt1yQbs=;
        b=Iko3cAmTd/blctIBD+I9s9pyVQMyWo/zqsTfZelj2PeMEDIwuPqeUuRDdCWVRZ/79K
         7RL4PFPoc4H+sx40Zbp4DrWfUN0lV0U/Pk7r+8YshrtJm5HR/69qNKO16D3ZdDyeqtqd
         y17MGtoFbJ3raBtI7SuQAVUTtaWB/ddDSq8JtMj+hr2FZKCHbAb7z4wM3Xj/h5o5zf4k
         0F4VwLC6ORop68IF6+vQQeEVDS6CHVbZfYV5m+D8myTHO9rtHkEMPpfRVW8d2X6xgURZ
         3GuRN84Zu0GYh0af3CSxXqEUnsEde4kcmduPQppF2y3WFJ0ZHxW+vPq8GxQDdwcS+axh
         LEeg==
X-Gm-Message-State: AOJu0Yxi2hG72h2R7DUlUsuuVwnmBjrrsjUioG1meiczDToSB+OMv4b9
	37RArbdLMrZ4Utq+DK/XfS50q/ksgrcjNC3slsw5JM0C+gxBFj4b9CpDJprhNm1uiPuBd/ifLqI
	VLxo=
X-Google-Smtp-Source: AGHT+IH2BezlTgC6NHUPr8/fU1Uh7sArqPj4bPh2O3pDlSvxY4Fm+V1c4Q+ipM0CMW6tCooL/JfQJg==
X-Received: by 2002:a05:6512:a84:b0:52c:c032:538d with SMTP id 2adb3069b0e04-52fd3f2bf2dmr996550e87.27.1721884320871;
        Wed, 24 Jul 2024 22:12:00 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c19ecdsm89952e87.203.2024.07.24.22.12.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 22:12:00 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so5647921fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:12:00 -0700 (PDT)
X-Received: by 2002:a2e:9b89:0:b0:2ef:26f2:d3e5 with SMTP id
 38308e7fff4ca-2f039d93228mr11421801fa.36.1721884319766; Wed, 24 Jul 2024
 22:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63149ac0-73a4-49c0-975b-75dc3bd32f7a@I-love.SAKURA.ne.jp>
 <CAHk-=whAfNJKeP1WhdP9y0itF_AkgQJMyz8B9TCfAWWQRhDRPw@mail.gmail.com> <5ad7dffa-204e-4d37-acf6-0206d7a87f37@I-love.SAKURA.ne.jp>
In-Reply-To: <5ad7dffa-204e-4d37-acf6-0206d7a87f37@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jul 2024 22:11:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYB_aeCxtBW2+-GqcF2PxwJ5061BFrAMp3mJgBy3GGvQ@mail.gmail.com>
Message-ID: <CAHk-=wjYB_aeCxtBW2+-GqcF2PxwJ5061BFrAMp3mJgBy3GGvQ@mail.gmail.com>
Subject: Re: [GIT PULL] orphaned patches for 6.11
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 21:24, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> If guard() is already backported to older kernels, that would work for
> the kernel/ksysfs.c part. But I prefer killable version,for a large
> memory allocation which may cause current thread waiting on this lock
> might be chosen as an OOM victim is performed from profile_init().

.. and this is why I'm not taking these patches from you.

WHY WOULD ANYBODY EVER CARE ABOUT A KILLABLE VERSION?

It's literally *nothing* but stupid worthless extra complexity.

There are zero real loads where anybody calls this code in parallel.
Nada. Zilch. There's simply no valid use case. The whole thing is
literally designed to ever be called once.

The *ONLY* valid use case is that this write is called *once* to set
up the profiel buffer (ie will return -EEXIST after it's been set up).
And even that "called once" is a rare thing that doesn't happen in any
normal situation.

And when it is called once, that mutex WILL NEVER BLOCK.

In other words, the only reason the serialization exists is for crazy
syzbot uses.

Really.

And that situation is not worth one single *byte* of complexity, or
one single line of extra source code to worry about.

That situation wants the absolutely minimal possible "this is the
simplest solution so that we can forget about this insane case that
doesn't match any real use-case".

So your "I prefer killable version" is literally a completely unreal
situation. Your argument of "may cause current thread waiting on this
lock" is nonsensical.

Nobody we care about ever waits on that lock, because NOBODY EVER DOES THIS.

Except for a crazy syzbot "do random things in a loop", which is not a
real load.

So no. This is not happening, and you just showed exactly why nobody
wants to take your patch set. Because you make things more complicated
than they need to be for no reason.

Stop it. You need to realize that "syzbot complains" is not a real
load. It may find real bugs, but they are often of exactly the "this
never happens in real life" kind.

That means that the fixes need to be simple and obvious, and not
pointlessly have extra complication for no good reason.

And yes, apparently we should just also move the 'prof_buffer' test
earlier, and do it in profile_tick() too, so that we don't need to
even worry about the cpumask_available thing.

In other words, start looking for the _trivial_ fixes to trivial bugs,
instead of looking for more complicated ways to do them.

               Linus

