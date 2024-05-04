Return-Path: <linux-kernel+bounces-168803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BAC8BBDCF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF94282308
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD384DE3;
	Sat,  4 May 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RrgZFY2e"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD884D14
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714850735; cv=none; b=KGSTVgJrfCNwTzuzsCf+fty/iOsSLLUIGLlpuF21rvgH0FN8FBnKXWA0fRJXVK+gnKh9ReXlwPj852qdI/QSmgaJwgx4vl0XxAe0jG32eVgonv+rJpRlzp/qROjjgwCzcPK8+5PN9LCQMgRkNO3Ur//nOUfG4hLIcAQEPZp0t48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714850735; c=relaxed/simple;
	bh=uUacTIg3oW/tfHkZjrilybVkU6Zn95Viljlcv7l4baM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4IjE1DMKBCz/eUxcR/UT+sysb5QNl2tdbj4fnHgTTUbuED9bI+1GWWcY3Iy6XfuiEUi1XjkoA0jku7YqfcIVywA544zsEfkGXArRvuqMSrOO64+ayltpNXZMa5ZLsjZYwDdHJu+ya3KkUQJMcgJ8osqYyn+1Uh4Y3felp7xBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RrgZFY2e; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e20f2db068so8260981fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714850731; x=1715455531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AzVGPeqOyogGFMBV1vFo5TD/D71MQY/fRBSu9alNMnY=;
        b=RrgZFY2eEqCJVOFKIxrCdFzH5j28NY7VWbiQJ2l6IwFSnCa4EAnEqWsMlyvn1n18c8
         BXsLvzkM9bpSW1hwYue5lpbDUAsYOguwlw1w0xVxPRAkBo684GAE81fHAmOfigFRhtwD
         Fwpua38jCm47yek/t0nGrqvNrd59mYhuq1fJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714850731; x=1715455531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzVGPeqOyogGFMBV1vFo5TD/D71MQY/fRBSu9alNMnY=;
        b=fXSmozjhcQvZvQJD53xgJmVjYMhWdLPRNR57HbFGBs3CTDf5DMBFv8cOKR6+jUhvuY
         Sl4L72EMfn8raX/3WzC03qZw/y3tV0UEIoN41Qe7g4gZhs1LGzNCa7yBLabeMOedXleg
         TA9sgQT7i5HtFYfxYvp9dvfqhx9+APT2UX5VJhgGZcr3vm34c1O7S39XzMMD/uCnVaW3
         PhaQKy88N1s1VMhtHxu97cqLgvVenZu0hKSgOtmXI5ObVysG8DNUWEy65Zs0pYPE7oQ0
         FGbK0FLF64rWR6vRCSQQDmbx29lK6QK+Nt8XZxxNYBp7GBrITxkq2eFvTflEpsU6aurR
         d9fg==
X-Forwarded-Encrypted: i=1; AJvYcCWU/MG6BDcqfvjd1fodY2haradAaw9GFx0zpp5MjrMQL7jz+A0tqU1+EmjuFtfLUhfjNSSrRQwtB65mcEgYu/8DbvtbvlToJ1iG23pv
X-Gm-Message-State: AOJu0YylZizQHVsQ9Js4+ZM6Qo64wk9pNGGAgk6PrbtPTlLRWvbV6vR0
	20VGJp/TOMEr0/TFB1k818NmLi/IkrKD4/JNFaQQ7rkNYr67atGI3PuJpXdGVHvJW10M5isqHt5
	VSPSwiA==
X-Google-Smtp-Source: AGHT+IGJFyEIU457Ym7daGWDdBgC9Qs2yhjcRbqiMBRJbLHszL6ihwkBIMkOXku1KzVfnZOY01iUaw==
X-Received: by 2002:a2e:9dd1:0:b0:2df:a8e1:c24 with SMTP id x17-20020a2e9dd1000000b002dfa8e10c24mr4022674ljj.34.1714850731261;
        Sat, 04 May 2024 12:25:31 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id h25-20020a0564020e9900b00572cfb37bd6sm2369272eda.8.2024.05.04.12.25.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 12:25:29 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a556d22fa93so144534566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 12:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7xzESF7yHQzYcSYaJEygGcxRNXbBuEYCllA9HbDYZtWRmqg9kgiHUsZVuFVQ1oRRJh3QRM2RexVlPRcLy8drqb162LzNhs42hxyxM
X-Received: by 2002:a17:906:5fd5:b0:a59:9e55:748d with SMTP id
 k21-20020a1709065fd500b00a599e55748dmr2531564ejv.35.1714850729561; Sat, 04
 May 2024 12:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop> <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux> <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
 <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
 <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop> <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>
 <7aab574e-b6ba-4038-802f-2d64af09d802@paulmck-laptop> <CAHk-=wi8mArAxxkO78CTSVRCyjim4hpGbzf2NFxNMAdXWR3oJA@mail.gmail.com>
In-Reply-To: <CAHk-=wi8mArAxxkO78CTSVRCyjim4hpGbzf2NFxNMAdXWR3oJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 12:25:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMzXHHxaAu8V1AyWLtPGwNZxbqm6_7j33zkziikFHFYg@mail.gmail.com>
Message-ID: <CAHk-=wgMzXHHxaAu8V1AyWLtPGwNZxbqm6_7j33zkziikFHFYg@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 12:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, the above are all normal optimizations that compilers
> *already* do, and the only real issue is that with memory ordering,
> the "dominance" thing will need to take into account the ordering
> requirements of other memory operations with stricter memory ordering
> in between. So, for example, if you have
>
>     __atomic_store_n(ptr,1, RELAXED);
>     __atomic_load_n(otherptr,2, ACQUIRE);
>     __atomic_store_n(ptr,2, RELAXED);
>
> then the second store doesn't dominate the first store, because
> there's a stricter memory ordering instruction in between.

Actually, that was a bad example, because in that pattern, the second
store does actually dominate (the second store can not move up beyond
the ACQUIRE, but the first store can indeed move down after it, so
dominance analysis does actually allow the second store to strictly
dominate the first one).

So the ACQUIRE would need to be SEQ for my example to be valid.

Of course, usually the barrier that stops domination is something
entirely different. Even without an actual conditional (which is
almost certainly the most common reason why dominance goes away), it
might be a function call (which could do any arbitrary memory ordering
operations - there was a clang bug in this very case) or something
like an explicit full memory barrier.

Anyway, take that email as a "written in the MUA on the fly". There
might be other thinkos in there. But I think the big picture was
right.

                   Linus

