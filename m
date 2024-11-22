Return-Path: <linux-kernel+bounces-418120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053399D5D79
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7426B1F21A16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A631CEAD0;
	Fri, 22 Nov 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDg9CrqR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4A210A3E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272502; cv=none; b=Xb8dFcWw9vZji5ueNEFRWzmC2jfcRPjENcaNaJw+9f43HYyPuPQPS5l8Odvpacg42H7qR0tdyQjPWtmSguF3AoDnxXwk/nBfPqGVaUaDDH6CzbLTt06Z7F0PNjJ6mamyKLjN4f0+mhj644M3qsznP//6UgdzEdXKcijqPn6huuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272502; c=relaxed/simple;
	bh=pJOdGDayJfCz/L+Uekx4UJ9FD/BOO1R8ukk28Rp+3OA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZexsdLMEIsMH6QTdJL+0NBLgxJBdKznQcvlrpi7dMHyL+NO32ggEO3BLEo0eeICmjKxRKlNlbyKN/3eIYXLCvvKTW7FblCCMOl064kAMf5fohFkMy1x6RQ33PThOtLrQdRl3xYT9jaguYEHUp7q87ij/gjXg5hxmqqSHxdWCuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RDg9CrqR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732272499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJOdGDayJfCz/L+Uekx4UJ9FD/BOO1R8ukk28Rp+3OA=;
	b=RDg9CrqRg9CFdgF1bhMRCP56oriO2W4/Cz2H9Rl12pU0NbK5kgOkvutJZOObJWqQrIDcF/
	jRwzTu+gHaq2e1XMXgDCDfOuEQCtABrcMT2KWo0LZNh1IV39iC+JE51fky0QtsPqz7XpIl
	L/vJ5J/wjdWfmUrZXXoClpWIUStdeDk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-xyPLBg_NO8Oxk9bo0mu6tg-1; Fri, 22 Nov 2024 05:48:18 -0500
X-MC-Unique: xyPLBg_NO8Oxk9bo0mu6tg-1
X-Mimecast-MFC-AGG-ID: xyPLBg_NO8Oxk9bo0mu6tg
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ea4291c177so2093114a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732272496; x=1732877296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJOdGDayJfCz/L+Uekx4UJ9FD/BOO1R8ukk28Rp+3OA=;
        b=KdNHkFrrpUe8BOU12IHNFSb2a6Jh3oJRNKhEjqI8GHFcB1qT6kSIflmx9St4uKwabE
         e1/33HysFJhaZw0Q8y9uGwZJdqzXGW6T2jdaP4PKWWUGt6DTKkpHUenYc+Uo776pSxRN
         jOrl7Yshn/eUqwHygPl1/kZFYFJ931+BMoc3M3r00milcMDYjXzoTiYzCehqsNn/RsW+
         QAA6IIFG06ShD2f7DqYJmsU8YJt8+SGb1yW1iDai8uzple+hwoQ/fQgggj0EjOMP7jw0
         vAmKdNA1i2Sk43tQNdTaMd5szpVas6EhvZ+u/NsdsYuR1/Qkpp0Qmk/Aytzip66Y53+c
         MlyA==
X-Forwarded-Encrypted: i=1; AJvYcCXanUQjpF0RICwHHuVy8DrRhQzZO7/9KwPzJuJC+dZgVcFi9RU5uTCUn9IFPwXKVrzna9kAFFVYBjzcSL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe7XgWZFLQfuQgKAVar+3iHPNYUGsAcbnH9mw3CKAphEOYjPLs
	72UfKSxdl1Yl+fO20z3vf5WRR8KbmHW7H+pfGqTAiksWB4inbfmhhrflHP/lsF5rjSQ2nKVVluA
	MbZVfENBm9GfNWx3THmvTJUP1VIf4oz0MWyWVqmoywkrkrmkS2UU0uS5eXd8sH47EF9hlLQR1yP
	BgM4wk6AY82kN3YtNCCsrGrKwJd/BCSIqu9FBTncQTFKs0Dhvleg==
X-Gm-Gg: ASbGnctJDFsEypiLAs2Y/Haq1vQn0MNXW+m0dP/hqnbrBFAs/Z+TZOVhywTd03uO+K9
	P2HaUudMwKG/DbrVZ2eXJ3u1olNGMXmya
X-Received: by 2002:a17:90b:2f4c:b0:2ea:5054:6c44 with SMTP id 98e67ed59e1d1-2eb0e8812femr2351577a91.31.1732272496462;
        Fri, 22 Nov 2024 02:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS9cApUHjXWWrIgw90VrNasPhY4FVjy3QXk4BeGdd2uda7CPeqokJcfMe9aNQ85SKWS1DVh6C9DieY+ywbWgE=
X-Received: by 2002:a17:90b:2f4c:b0:2ea:5054:6c44 with SMTP id
 98e67ed59e1d1-2eb0e8812femr2351551a91.31.1732272496095; Fri, 22 Nov 2024
 02:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120102325.3538-1-acarmina@redhat.com> <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home> <20241120164043.T1JuBALe@linutronix.de>
 <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com> <20241121170356.eC7f3-1v@linutronix.de>
In-Reply-To: <20241121170356.eC7f3-1v@linutronix.de>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Fri, 22 Nov 2024 11:48:04 +0100
Message-ID: <CAGegRW41HOdG+vEA6vwmC3WWJkRgMksasvoRWdwRzAE7mFbHEA@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Gabriele Paoloni <gpaoloni@redhat.com>, Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Thu, Nov 21, 2024 at 6:04=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2024-11-21 17:50:06 [+0100], Alessandro Carminati wrote:
> > Hello Sebastian,
> Hi Alessandro,
>
> > On Wed, Nov 20, 2024 at 5:40=E2=80=AFPM Sebastian Andrzej Siewior
> > <bigeasy@linutronix.de> wrote:
> > >
> > > On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> > > > The "%pK" dereferences a pointer and there's some SELinux hooks att=
ached to
> > > > that code. The problem is that the SELinux hooks take spinlocks. Th=
is would
> > > > not have been an issue if it wasn't for that "%pK" in the format.
> > >
> > > That is missing check and I think Thomas Weissschuh wanted to add it.=
 So
> > > we don't call into selinux.
> >
> > Your comment confuses me a bit, as I'm unsure what Thomas is actually
> > working on.
> > Am I correct in assuming he's addressing a fix in lib/vsprintf.c to ens=
ure
> > that sleeping functions aren't called, allowing these functions to work=
 in
> > any context?
>
> restricted_pointer() has a check for in_hardirq() among others. This
> needs an additional PREEMPT_RT check.
> I would be actual in favour to get rid of case 1 for kptr_restrict and
> have either 0 or 2.
>
> > However, his mention of "This fix for kmemleak is still needed as the
> > pointers in the kmemleak report are useful" adds to my confusion.
> > Meanwhile, Steven suggests reworking SELinux to resolve the issue.
> > Could you clarify what you mean by "So we don't call into selinux"?
>
> This getting out of hand. By adding the PREEMPT_RT check to
> restricted_pointer() we don't call in selinux so the problem is gone.

I am really glad that now we have a clear solution, however practically
speaking is Thomas working on such a patch or is he working on something
related that does not fully solve the problem?

Even if he is working on a partial solution, I am happy to coordinate
off-list working on his own private branch
(or else I would just give up and review the Thomas' patchset when it is
out...)

> kmemleak is not the only problem. printk(), as another of vspritf pointer
> code user, can be called from any place and would also trigger a
> warning here.
> As far as "kmemleak need to be usefull" goes: With kptr_restrict =3D=3D 0
> then with or without pointer hashing they will be useful. If we need to
> go via selinux then it ends as a hint.
>
> Sebastian
>


--=20
---
172


