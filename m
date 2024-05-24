Return-Path: <linux-kernel+bounces-188820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB838CE772
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3361C219DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90712CD8E;
	Fri, 24 May 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hcr2Mbsm"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA012C55D
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562729; cv=none; b=dhA9EiYd6jRzqTtcIuUCSzCqMoQ5rUE4/2ptJKXPYNqd2YrgirrhBs1PioyiwrndJL0kzrgPKR+iVESK9tQP0r0Ulotr+zI8+NBdDAzGZMqpZ/rWgB7ipqdvfqhEg4tgL5dmW6SaMGL7hcbSPdqLTddETcmB//brGvzaQxvlv+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562729; c=relaxed/simple;
	bh=2PAF37j9F18Nf5iuq9vX6tcKGUy44bEVYVrsHN5w9GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDoPImnioofUZ0lsLz8NFCqALn46DUvQ74TYgmw0aTj+6T17waHDTWqaKJbBOn1Nyy9bmplCVoLcDMvUUR84FDVTK7Yxg+HRiVGaVMWlIsvRyQmXhacFE8Gz9TLswPU3+zmcqg88f08TbAf2cuYVTHlnOsV3qO5IhUt3f8Lh3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hcr2Mbsm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-578517c8b49so1280575a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716562725; x=1717167525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rcMspqehBFuBupFDxybL8n0NBRn8g86OZY15bYliGX4=;
        b=Hcr2MbsmZ+IdUPrT/Z53hUrQBPhqvBWWOdoMYHlgkoHNeGvbgnDrrYd/lIY2mVd270
         xIGtlZz4+UJxFwocspcYGdco3JsgV97huG1f44nlBNE4f9pp4g+MZM3c4rL62f6Gup5G
         3EPJL0niAJZ/izTWY+e/dhHLXhZFJnwK5wd5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562725; x=1717167525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcMspqehBFuBupFDxybL8n0NBRn8g86OZY15bYliGX4=;
        b=BYB18uAC06LkzngwvsnAz/4hg9NIwg/ty0SqCfwFlyegAi1rNGNjWk/5JqMkKGkueI
         s4xHqFyqN8ltwUwdxc8+rLexNKhFAPhnlDiohbUlWAa0/uUGmO3pPiykZ9LgFpUSAZMy
         Ngw97ATlife0GocDIGfGd9cmERisXZtgn+4Po1LqniOyfGtnGoxRa6LDtkLHSUpfAYQn
         BLwdpcyR4CqA33qJvSpyBQnoy9dr27akVvd+0II0a7GJBY2ca3lFo+mntHtHKuqz9z+x
         kPtJRxU0olGDdbH9u4dKcqpAR9ziD887rBdANIcuPylCugihOuFgl3ZJOqsn0Cw6hr5M
         VTIw==
X-Forwarded-Encrypted: i=1; AJvYcCVtI4rF4tIWJZ3ok4NjkFXtRq69kj5+vD9dvVoG3IJXNaRtM32H49pqpTgZmSW7W1HjwFgyAutdUBSIxFBX9btG8m5L6NpSGcoZynw1
X-Gm-Message-State: AOJu0YwWaAHCt5zPdsilPTC5YBgsTZsuumu3skeNP7NsL7r2IzXmCE4F
	1TDeynV9kF10ex4RCqVnIcEsjjImeWbKOLZgARkYLoY9Wo6XoqyXuhp5q1DBM6Q5NEkgIctAi0T
	Z3j9BrA==
X-Google-Smtp-Source: AGHT+IE9/Ab/fkref50cqc38dqfRc+2ZxdTMfktiFZBz6udps7S2Tmp4TrRAxXxdT/GNriRqgvQ/ZA==
X-Received: by 2002:a50:aacd:0:b0:572:4702:2227 with SMTP id 4fb4d7f45d1cf-57851a98927mr1640024a12.35.1716562724992;
        Fri, 24 May 2024 07:58:44 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57852495dbasm1821249a12.78.2024.05.24.07.58.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:58:44 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6266fff501so123555166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:58:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWkvRRtBK1KU5nOnO5/VX/qa4OkjJe4KF5xlFFT5E7juspR0UU46AoAqnZiPAB/gNRZQXBkRqltiNq8fWHEfUywR1SST+eQ+blODEX7
X-Received: by 2002:a17:906:2296:b0:a59:afba:d0a4 with SMTP id
 a640c23a62f3a-a62641de237mr167222666b.23.1716562723858; Fri, 24 May 2024
 07:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
 <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
 <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com> <CALOAHbD0LdbQTWyvDiLcgGupcQJKmadzWhoZiUTj126Rqqn6fQ@mail.gmail.com>
In-Reply-To: <CALOAHbD0LdbQTWyvDiLcgGupcQJKmadzWhoZiUTj126Rqqn6fQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 07:58:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com>
Message-ID: <CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 00:43, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Actually, there are already helpers for this: get_task_comm() and
> __get_task_comm(). We can simply replace the memcpy() with one of
> these

No. We should get rid of those horrendous helpers.

> If the task_lock() in __get_task_comm() is a concern, we could
> consider adding a new __get_current_comm().

The task_lock is indeed the problem - it generates locking problems
and basically means that most places cannot use them. Certainly not
things like tracing etc.

The locking is also entirely pointless\, since absolutely nobody
cares. If somebody is changing the name at the same time - which
doesn't happen in practice - getting some halfway result is fine as
long as you get a proper NUL terminated result.

Even for non-current, they are largely useless. They were a mistake.

So those functions should never be used for any normal thing. Instead
of locking, the function should literally just do a "copy a couple of
words and make sure the end result still has a NUL at the end".

That's literally what selinuxfs.c wants, for example - it copies the
thing to a local buffer not because it cares about some locking issue,
but because it wants one stable value. But by using 'memcpy()' and
that fixed size, it means that we can't sanely extend the source size
because now it wouldn't be NUL-terminated. But selinux never wanted a
lock, and never wanted any kind of *consistent* result, it just wanted
a *stable* result.

Since user space can randomly change their names anyway, using locking
was always wrong for readers (for writers it probably does make sense
to have some lock - although practically speaking nobody cares there
either, but at least for a writer some kind of race could have
long-term mixed results)

Oh well.

                Linus

