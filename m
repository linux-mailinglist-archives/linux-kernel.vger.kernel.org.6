Return-Path: <linux-kernel+bounces-525009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375DAA3E9C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE02A3BCA80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D514207F;
	Fri, 21 Feb 2025 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gv51tuVU"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1F17996
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100659; cv=none; b=uDIwafJNrohuCUKKXNG7+8hhamPzGGWLmf4aEx/NRsFsYe75ofpPlRXY62h11JY7vcMYhBhLwJ2mEJ6mwNM9mjjde9IDnUX/OUcfy23Cx/5eUGOIb0VoJotXyjpEltTdOQAji3nZ8Sfcg4MnZbnfr9iUo8GfGxtA3c1bN9cbGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100659; c=relaxed/simple;
	bh=1gCFFhPre328Jo6BJaxyEfCZJIQOlY9Sp8B3gGnSSpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7+QpbjauoaZmRiAqgz93otJttWjW1Rss1GQleqjhri9AK1S+WflIhkKLB6IKqBWwFsM+9qvfIq6b8FZeLNMLzXsK2RCwCC0+InIjqDOHkK+I8q8d5aRuuYqGHx1K6AcMM0i4q0ZUUa5GuHs80erbBHfhWfaIBzmc67pgjGgRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gv51tuVU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-471fbfe8b89so176301cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740100657; x=1740705457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gCFFhPre328Jo6BJaxyEfCZJIQOlY9Sp8B3gGnSSpc=;
        b=gv51tuVUcwD97ggiy/TBbAFhZK32mQqRJhk56+IN8T1SgMbReEC29JqEko+w3fPs0r
         kUtDCpLqwS7T1ppYUcBJ5udeqZv/3vRi7Ezt56NH0XzAPzNelB5AG8z/gny1eurV4T5U
         5w5u4KLgHwv8eEiIfDwG7tfNwCzKeE7L1qSGX4M6GqSotX76T4l4JzGg4etMO54qXY+v
         KkHbiC6XbpAiid/01eHjB8CirGjWN8JFQQDtiO/a2A1m1Tb8YBkWbx5jlJc04A4Qsk2/
         aQy03+fqyvwRHKHL3AW8x+KbrsO9WBX925xg9QEDyPwub1D7ggBfl9txLJpLpVtZQopq
         NJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100657; x=1740705457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gCFFhPre328Jo6BJaxyEfCZJIQOlY9Sp8B3gGnSSpc=;
        b=XXgtEOJ3k9pSYZrMM3xPS97RlYMN/xdrfbP7Yo3f+C3X23xV8TeOl5A/6AyBMU8R/e
         lmwvhAxZRtr8TfawUTvDPnbSZvy+sXGKrF0g28uGLgOuBljeog3L3kawVJqTE8tniRej
         kYtrdO1u/sILNOcFpN/f/nPr4dUbMTC64mjdnfntqWVnCWdQFCCddskEmYWOck/If28P
         c5UR0VMhXFTP11vWfFxf7Je1y/fptsy9fW2GMMOKoD+hPmDnOI5Lw6BpghzgdNej4oUD
         JRalXeILE3B5jsBF1awsEhdU/2qNHDNcC2EDwe7l+ZRf6+G6oXB6Ums3IU4J39g/IPaG
         r1vw==
X-Forwarded-Encrypted: i=1; AJvYcCWtLQeeuYpm2nCVAUSgZOCUXXM668EXl5YjJTKXirBd05aixOn10AUE8Ptm3B7lIQ+onB8er8j9H9hp4Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf5xGK8QXbTBb6xVxxwMGvyP1d6oJKnrWWjZnmOp9r91YMDiYR
	fcNXp13T6kYY3S5YNa7NWFCj/Hpt2+fu70pzKyB4b6SN7no49W38EfZ01xC8f/CT+m4u3rpD5z2
	F0AfCU6CX+rOA5+4Mi5PeYk9w3O1Yqc9HiQ9/
X-Gm-Gg: ASbGncs7YXQK4JbsKCDhkRK8O0lDhjZ3Ig8icT2kw0kS3GA7eJN4F44KVqAXOLXbpyS
	Q+9IdFW8JkkFqoWPPv5uzzdR6BGTJTucNQqzcW8rUYLTUsHL/Dt9Lhj7YkKHc7pEgatoDHTvvOA
	==
X-Google-Smtp-Source: AGHT+IF7AlNAgH0UjxRv2es5ALe+A6mfPGmSxVbX6luAUr0KjSPvKmibXyCkkasN3H9u5m8y/v5ldowj7oAsz0/k9wY=
X-Received: by 2002:ac8:5a48:0:b0:467:8416:d99e with SMTP id
 d75a77b69052e-47225106af3mr714471cf.21.1740100656296; Thu, 20 Feb 2025
 17:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210195117.1074569-1-joshdon@google.com> <8923aaae-becd-489a-bfe1-8c1c569d8d48@web.de>
In-Reply-To: <8923aaae-becd-489a-bfe1-8c1c569d8d48@web.de>
From: Josh Don <joshdon@google.com>
Date: Thu, 20 Feb 2025 17:17:25 -0800
X-Gm-Features: AWEUYZmnLnZOx-woOtot8P2f9Hp1GdUS6u38mNdHZANKITXS0Y2iOa1hU6CM9p8
Message-ID: <CABk29NvJu82jsMBvoE0Fte4oo=tcVk0H=z1WpcaBasdaXC0Kmw@mail.gmail.com>
Subject: Re: [PATCH] sched: fix potential use-after-free with cfs bandwidth
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ben Segall <bsegall@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 12:11=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> =E2=80=A6
> > For full correctness, we should avoid removal from the list until after
> > we're done unthrottling in __cfsb_csd_unthrottle().
> =E2=80=A6
>
> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n145

Thanks, yea I'll resend with the fixes tag and with all the additional
review tags collected.

Best,
Josh

