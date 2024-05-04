Return-Path: <linux-kernel+bounces-168773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC8B8BBD83
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 19:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED0B1F21BFB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9476E60DCF;
	Sat,  4 May 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A3JyYr/s"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934159B78
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845051; cv=none; b=O2rZ5dVKMXZebDO5jpTtMQhqMMLwJ9r0ZbUOAH3SQ0UEOFSF1y63aVd+3GKocf3dlZ8ZkwsiwH1zixoX42VamkUHqXKbPCAWlMHAsg8+uLorz2tzzq87vlD3GNx4oE0sdLVXZfdjcizWZR6bS5PYO/G/1+74Ojyryd87HDjhMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845051; c=relaxed/simple;
	bh=vNJoGAUUvHdGoycuhcgj0oJQMe4+8XP0PvAVk1NVaj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGWXy+/2oTIY3JEgzuPmK7Pk1u7ji85mRhqDvNqgQrdqbzTySv0Utn23jaNqMdkoiAmJU+A/8T0dHfHdjhiAC/wCzlNrDSD/jG+hhfBn4BTRJrsj6zp00PlQFSz5gy46DVXqPxNJqhG2OlKiduEoU8P/UKHfozrhkqQV3MFAy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A3JyYr/s; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a598e483ad1so144722766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714845048; x=1715449848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TRzbcihXI24SCuYOsVfgrVXS+13k3RWWLtY2qXmne2s=;
        b=A3JyYr/scBjjeFKvt+K4O2zu8Fhz7LemuwfKnlQDeX+udqpxg1FKSWTD3K78UzKf1J
         vsbGtoERFBEmNdml8R4QooQciBWmuYh+LVK/4dIP/QYibvoRa8+E9QklTvORbAqeDDdK
         3gGNiQZhhwB1YNRh6LbV1ABu2847PIYMbGMvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714845048; x=1715449848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRzbcihXI24SCuYOsVfgrVXS+13k3RWWLtY2qXmne2s=;
        b=EOwaAkSvH3q877K+G4XJQ6uu4J0JDv1Jv7dkVeqbEqamDMYm24hsZBcEJLpLJ7IgQy
         LcDAXCHlqtw15HP7ICQhN7uGomC8+yF1zOsTDNC9DNmM205aIl7VTRV8tU3f0zE18ZNF
         2YDP7uUyPDLNyUb53AI7/H+pfxYIeRw/8S2gnTf6R6V44ITv2/jzk5KNT06mVrBEM5KG
         I+0mHk4Bj6cEMbNmYgvIGsYlk+Nctxc0xrWDRFJvuaEm5HnjEATHsmfUooYC7yw9WN9P
         hVZKxwZ/sRx39ldbB5bFA9fWi+NgwRAZHjUS5+XHxMrW6RDSr1XO8TmNuoFIOPsUUt16
         +oKg==
X-Forwarded-Encrypted: i=1; AJvYcCXzUeGiues9RMBrJySyZ3wdi5WyM+CjECazJQOCEZdzgV6c8emRtj+8MX9Hizhf9H0typcAuswu/EJgdtxNw0IEsRs65uwml7+c5V4n
X-Gm-Message-State: AOJu0YzyTd2eE9Y4s2yWn4dKMUEaTy1vrqLtceVWLJaKxNwQIVlkK/vc
	XXfL+QRoQ0Mbh1/WRT57tl6bkGOKkPckY2AK0SREon4ORN9ve/qTPbHGb1mBl+dcVHKyMnWCtRg
	d0c2goQ==
X-Google-Smtp-Source: AGHT+IEfOgGScB51i6Z8382yo7VcIT71+Pqy1l0IkZzOEsFJzQbGKrs+9KaaKhoN5jEDdlb/Z/JQeA==
X-Received: by 2002:a17:907:7243:b0:a59:b490:6e62 with SMTP id ds3-20020a170907724300b00a59b4906e62mr763132ejc.40.1714845048029;
        Sat, 04 May 2024 10:50:48 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906051500b00a59291b5551sm3147363eja.63.2024.05.04.10.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 10:50:47 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a598e483ad1so144719166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 10:50:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4PYowdM0+sv5zwNkigDnEvxHVVkxK6K7Ckl+wCf9rhtRUkQvQik+94pRInIS7S5Q7eDY6mBaR0wB6Mj1zn7rTq9qLlKj88/WTX+iU
X-Received: by 2002:a17:906:abd8:b0:a59:bbd6:bb39 with SMTP id
 kq24-20020a170906abd800b00a59bbd6bb39mr209514ejb.55.1714845046603; Sat, 04
 May 2024 10:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop> <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop> <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux> <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
 <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com> <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop>
In-Reply-To: <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 10:50:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>
Message-ID: <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>
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

On Fri, 3 May 2024 at 22:08, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> You are right, this is going to need some arch-specific code for a few
> of the architectures.  Hey, I was hoping!!!
>
> The compilers do not currently optimize these things, but things appear
> to me to be heading in that direction.

Ok, so it sounds like right now it makes no sense - presumably
__atomic_load_n() doesn't actually generate better code than
READ_ONCE() does as-is, and we have the issue with having to make it
per-architecture anyway.

But maybe in a couple of years we can revisit this when / if it
actually generates better code and is more widely applicable.

            Linus

