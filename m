Return-Path: <linux-kernel+bounces-221853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF26C90F996
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52DDF1F22E10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D372715B12A;
	Wed, 19 Jun 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Eq4sBvQh"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990D82869
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837790; cv=none; b=fbOqhKtniub9SAhcTeOUlVzOpvBITaoZHWGAxIviIFRUPpUG1BzjY3V4IEdtlaMF44g7k+jBLpsnzEV6K/mNRVARHKi0EcUa2mPUK2bZln/xprFcVLIPgpa7I9Fy/Cz2qF+CjPzLPYmKC+BejDEgovZjmwktfrw44UVOIyWOS38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837790; c=relaxed/simple;
	bh=oA+sj7Djqxbrarm7I2zjgfnb3L6txQDz+HbmFlGzGUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJ2G20GTuQjChuSbF/qs3a0rr/pFZQB0SfOFL+mB4mRKvZ0fMpmgWIIgDbwExVThRjSiI/nr6/s4Buc20mnOxfNywA0v4q9dPYVLgdIOsFvPzLPbrWpnKpBfpgfvjr9qolqT9uXqYEFyCQ2wcLc0BtMHtL4HvbT5gTkzY3VsIms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Eq4sBvQh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-363826fbcdeso236281f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718837786; x=1719442586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4ArltmimkgOuzhs9/gakjvhfS3EBeG4nlT8epF65b4=;
        b=Eq4sBvQhkKxdGuVqN58QiMUHPrwF9M5TQ87OMUPXahvrdLOSEP3iYk2jJmRykyhckH
         dNL+tb621+XZGw9MbB7gqoKm7VLNnuo/yuzWY4MsN8lFVV2IG+76dWecdbEDltuHQZcO
         klYVDPRDaGic1rDlBLOS8BP7yk3V21P3vh0vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718837786; x=1719442586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4ArltmimkgOuzhs9/gakjvhfS3EBeG4nlT8epF65b4=;
        b=DZ+cNqE6bGHdO9YhKSh0ML63b0ZmGtQpGL1m6RwjvDZ9o13aChfTVFG9vn/NRXuXga
         Jkr95k/4dQ00tTg82KXLweBdhOJWAvOA7fZyGGEEJzZSy8j0a3NWhr1eCMVbnCLzYZsD
         GiN/9+MeABUadGXV3MNScJBK9324cXa/UDVWeLRBsA5/Fi0+sVIb302+Pvq+OjzURrVb
         px+H11On2rhDjvtONssdCvjGR5dNPW0rImeMkuqcnpumregMMVXyholz7oNY7ynVsB1U
         nEGT6oQGfLlB1BKh0wozpfYFZZP5+oRTxFho2uRz6sPzGenDAcooUoNmRU07NvI8eFHx
         g6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHcEVs/uuxC/I6G4yEMHyTXgh8rPop1nvTGZSDrcyqYtgDJ7Rgw2L+zg+znLCgqj2p9seHlvE09hcjENxWYdr4qOmVjeYYGxl83tKx
X-Gm-Message-State: AOJu0YyzpZI45Mi56qs8aFHlzFP3EA7YX56jyCee96+Gbqv8aFFW/ztF
	xCEUY+dc0aX9o0ZYlYS4AHlDA/NYLjkthOBumsQnQdlncsLl/ksK2yjtvAazYWVTPCJd07nRXQO
	2RO4J3g==
X-Google-Smtp-Source: AGHT+IFo09Odie2fxPiPo99fqzzjMUc6WO8H02jMmEyZ/FZgpD0erpfk4aBcIl6FYKq60dSZy2ZA7g==
X-Received: by 2002:a05:600c:379a:b0:423:57d:77da with SMTP id 5b1f17b1804b1-42475185504mr26188665e9.24.1718837786335;
        Wed, 19 Jun 2024 15:56:26 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da824sm8905593a12.29.2024.06.19.15.56.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 15:56:25 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217926991fso3393545e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:56:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7LUxP5ABYlSzvZ+ApCw5ux60sXB0K7fItIMiNMM8eBzoKUHpAo0AEtmlwHl5BnevKjqi1tpBSYEG0KHLFS5WUlfAVyENZOBnI9GNF
X-Received: by 2002:a17:906:2519:b0:a6f:5a48:7b90 with SMTP id
 a640c23a62f3a-a6fab641667mr177288966b.38.1718837763732; Wed, 19 Jun 2024
 15:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
In-Reply-To: <87bk3wpnzv.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 15:55:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
Message-ID: <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 15:27, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Jun 19 2024 at 15:10, Linus Torvalds wrote:
> >
> > The thing is, I have seen absolutely _nothing_ in the last 9 months or
> > so.
>
> Right, but that applies to both sides, no?

But Thomas, this isn't a "both sides" issue.

This is a "people want to do new code and features, and the scheduler
people ARE ACTIVELY HOLDING IT UP" issue.

Yes, part of that "actively holding it up" is trying to make rules for
"you need to do this other XYZ thing to make us happy".

But no, then "not doing XYZ" does *NOT* make it some "but but other side" issue.

This, btw, is not some new thing. It's something that has been
discussed multiple times over the years at the maintainer summit for
different maintainers. When people come in and propose feature X, it's
not kosher to then say "you have to do Y first".

And yes, maybe everybody even agrees that Y would be a good thing, and
yes, wouldn't it be lovely if somebody did it. But the people who
wanted X didn't care about Y, and trying to get Y done by then gating
X is simply not ok.

Now, if there was some technical argument against X itself, that would
be one thing. But the arguments I've heard have basically fallen into
two camps: the political one ("We don't want to do X because we simply
don't want an extensible scheduler, because we want people to work on
_our_ scheduler") and the tying one ("X is ok but we want Y solved
first").

I was hoping the tying argument would get solved. I saw a couple of
half-hearted emails to that effect, and Rik at some point saying
"maybe the problems are solvable", referring to his work from a couple
of years ago, but again, nothing actually happened.

And I don't see the argument that the way to make something happen is
to continue to do nothing.

    https://www.youtube.com/watch?v=lOTyUfOHgas

Because if you are serious about making forward progress *with* the
BPF extensions, why not merge them and actually work with that as the
base?

IOW, what is the argument for _not_ merging it?

                        Linus

