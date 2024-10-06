Return-Path: <linux-kernel+bounces-352189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB22E991B82
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 02:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A42831E7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52534C9D;
	Sun,  6 Oct 2024 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fvAgVPg/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C9A33FE
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728173696; cv=none; b=ckxMKuLfJmRR+N8K6+JHdTBuzgwdOPsVVk3MJLEf7eDP8/J9GJf3jdCiEOxqnixqGgrkfpWL+rcO7gRoWNZ6k2BduLs4ZKVdpAml87WZeTRsr9W9HfgTT0ERiqz+Mh1+327AAmuQBnfX2wU8mqTKtveSXR+qpOvqAsrLQB2fvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728173696; c=relaxed/simple;
	bh=HgtCN7iIuMmkaNV3I4PdNrx0uSYLvra8kQ82Jy6qi+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7M8ccCuzj2ESg0LjMFLNs9/g08seX9OzmnUzD6I47uoBYrVZ6D7xqd2vxOMlLmogOgFUPCShGLcmHISPyk0chmgKHg3s05v0fp2Pf9crHOaMmEN21+is9B00GGNPbr960AeJYfnyCTkaePtjsyEbYNCvGkqeRSaS4mHM0mZofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fvAgVPg/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a90188ae58eso427255366b.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728173688; x=1728778488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nzL6PAghOW3KzpclFbijO5KDwmQqxWPsUEDBX6EEH4c=;
        b=fvAgVPg/oE6klaHrBv9vZ7EyKbAgfoU4pmzqjFKQb231i3/7opuOLl+ka4jp/PfpcP
         n6xIVhw131t9RbekdLQTNiaFFKIbyvMmFehfjq4fKnC2xYSfVBY12uLU82hkUaLd77KH
         MuH4kkb4RZGyUhixx6kCk6osQLD6fNtGr7QMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728173688; x=1728778488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzL6PAghOW3KzpclFbijO5KDwmQqxWPsUEDBX6EEH4c=;
        b=L3xnSeK3HLa7WaCyflMPR59B5GFMF2M6MtcL39gQ3PzqtA71x1gpBP52OkyTxbBd8V
         L6K0uR344a2mJTun7sM3S0wnZUMqgFaM9bmr9LWJS0rYlKIfG9jutANS1L5C7SSMyVoT
         ZL9HTnX3S4x01iBKiSWITfQHA/Y+nf0e96FDij88AexYUUJyYW/hcT+PJ4vBj0r3Rj9q
         r3BPKaksI31WTqeKUC2xDsaa4mA+5EJcFEDixl2s6fSzluFvJ1/pTd+bWtYY9soLiiXj
         567my8DDR/UaAfRkQ5lR36HASKMds85xYy4FYyi1z4+bOeMUOGKq4I9WG864kE0VZwhW
         XdrA==
X-Forwarded-Encrypted: i=1; AJvYcCWIZQ56hOC9PIbBxZdndFS62e/ozwqZgcozgYC+QqP0DByGDZGmJe/QyafKMWAT1DUQHyF893Fmhl1DPDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDoML4wQWL2zc6wFD7XdcjctyGPhbrtnfV0nd5XZLrlwN2fmu
	8hts1x23Stip1dXsD2fyYRboUsXTI9BO5117f3PmqRs0RdRTHrM7Zu6s++EtcTWD7H96ozsRIAo
	+1kRakw==
X-Google-Smtp-Source: AGHT+IHMVOsXdGG9jrUFlbmusMyaqlGDXAFKHL+u1GV7ziyrpr+d/zxtJ60xgeCL5pgOMhMkHiHb/w==
X-Received: by 2002:a17:907:7205:b0:a99:384e:ade1 with SMTP id a640c23a62f3a-a99384eafafmr297368166b.36.1728173688494;
        Sat, 05 Oct 2024 17:14:48 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993897cd3csm148426966b.78.2024.10.05.17.14.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 17:14:47 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a90188ae58eso427253966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 17:14:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3GV05xds3QYxFSdycSRc8kDJzGD++sHb1GGWoE82IiFinX0V8TrQZzmYLZ1bxrfUJTdmikrYyaF7Vlkw=@vger.kernel.org
X-Received: by 2002:a17:907:c7cf:b0:a8d:286f:7b5c with SMTP id
 a640c23a62f3a-a991bd71ec5mr611797066b.27.1728173687316; Sat, 05 Oct 2024
 17:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com> <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
In-Reply-To: <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 17:14:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
Message-ID: <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 16:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> If what you want is patches appearing on the list, I'm not unwilling to
> make that change.

I want you to WORK WITH OTHERS. Including me - which means working
with the rules and processes we have in place.

Making the argument that we didn't have those rules twenty years ago
is just stupid.  We have them NOW, because we learnt better. You don't
get to say "look, you didn't have rules 20 years ago, so why should I
have them now?"

Patches appearing on the list is not some kind of sufficient thing.
It's the absolute minimal requirement. The fact that absolutely *NONE*
of the patches in your pull request showed up when I searched just
means that you clearly didn't even attempt to have others involved
(ok, I probably only searched for half of them and then I gave up in
disgust).

We literally had a bcachefs build failure last week. It showed up
pretty much immediately after I pulled your tree. And because you sent
in the bcachefs "fixes" with the bug the day before I cut rc1, we
ended up with a broken rc1.

And hey, mistakes happen. But when the *SAME* absolute disregard for
testing happens the very next weekend, do you really expect me to be
happy about it?

It's this complete disregard for anybody else that I find problematic.
You don't even try to get other developers involved, or follow
upstream rules.

And then you don't seem to even understand why I then complain.

In fact, you in the next email say:

> If you're so convinced you know best, I invite you to start writing your
> own filesystem. Go for it.

Not at all. I'm not interested in creating another bcachefs.

I'm contemplating just removing bcachefs entirely from the mainline
tree. Because you show again and again that you have no interest in
trying to make mainline work.

You can do it out of mainline. You did it for a decade, and that
didn't cause problems. I thought it would be better if it finally got
mainlined, but by all your actions you seem to really want to just
play in your own sandbox and not involve anybody else.

So if this is just your project and nobody else is expected to
participate, and you don't care about the fact that you break the
mainline build, why the hell did you want to be in the mainline tree
in the first place?

                   Linus

