Return-Path: <linux-kernel+bounces-392119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF69B8FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3746F1F2326C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF3199E8D;
	Fri,  1 Nov 2024 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sAGOHndU"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44E2A1B2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458962; cv=none; b=mpbt2MWQB6905yIiwAYs++/68bxO0FYTinm0gGh585zXexkKmaTezoGlYaDlfEr8jgC9j3XOH9hLEQoNb80M00FTNZlTsRncekLZXCf+2EPbhfed7XGEuE2QAGrp99NJmLth5+JgYbHMfiJ/+T1GiRzrfFYP4Nsn+HWv1BkFIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458962; c=relaxed/simple;
	bh=7RXcC+IawjHpRBsvShXoy+R5Y2/PQ9Rr6oanrpSkqkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlLl3TCh2VEpAh0CDoPdMsgyjEAzZN/IN2d5lGs/gSrragYYqbIXkoEd/1+FlxiVrOAaAqcPkLkH9Dzb3LMzJMgBuWOW6mjBz1JOgHHvYitWUkqHNsZMU3WMOocywx5w4Om+H7ZBDmaus9yoBGi0AwNekVitvxnaATvRRCozWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sAGOHndU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e56df894d4so1427776a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730458960; x=1731063760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owQfejAwjt42qdtK2q4XQLezl6oCKTj4spODHA7HEJk=;
        b=sAGOHndUA06X8zF42XC0KhhxmHVRpQvMB/OF15QEeBUYQsggfTnTPeknyP50HkKZrP
         VKdnBNM3zDstMD/NAmRWc4ZP0MtUjJs5RC6BTW/NnWWaOi0i16/K/tpV/irNblK1dS48
         hoWE2MT4f/PnvYogwVqGL+/se/U48SW7XvL2ehEgSE2RYX+E3AhaDzLz8QbttvB8ieJI
         m+t9fGcONnRjc6cs6RctL4A2i2jJCe7bE+W6BmWtu80cGemudbzutce+ffrWGUVlyqEz
         ZzSOsrsKLUXUuwMetCyeLIdHOI4e38NBIwB9tXbaibqwm3bMHXy+zNhuxV/PeYVcGIJb
         XhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730458960; x=1731063760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owQfejAwjt42qdtK2q4XQLezl6oCKTj4spODHA7HEJk=;
        b=r7xav9va0JalL83EgaCu5yJYVS1wQpNM83CmASV2hJLDvNhXsmcvnupioCA5ashdo/
         lkWd3tutzF8PUuutyE6Sj5sX3FNT7zAxTphZHAE/CBkIKIQG94M/2tEmau74uddaZ7nC
         co9JaFLMUW1wDpvbijLyveLXUpFXX9k/dEPs9xV1U4vFju2bXFAYsXDWOkKS7SCfKCaY
         40vP52+QbaOcWEB2BZXAYVLtvku3cpYUksNPBxQSoGY4ALJ0IXpvRm6ZQzNsl+12CF+d
         K5iQY6Ioz4cMIPDjrvIQf3iklJf5YX+qCAkMQZtEv+yFMDQe491Y+jgyNhk/kNsa9HUC
         qNag==
X-Forwarded-Encrypted: i=1; AJvYcCW3BXOVJUE5keF0nDrkqDdx0Z4tXZzITpQEAke0e/F/n2VT2Bw81DegmmUEDMlvmyT2SDV6x3rjiSsPyNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxQW05ywNORYuLJfgUHgdOFs75g/u2B7fHnU30bgJEAT3vXW9
	EItIHBbkw8VpwZu8IVMLsGd53tZMMSE/CVDxqvmLjPRnj1yHQimJ6UH330xQGHUbtXlF4yh5ZN6
	yEp4bYntdDtfT12h+o1EtJrUCyLXcwOvdXwh2
X-Google-Smtp-Source: AGHT+IGYGUcLrS9AcbUA3W7RaZ46FWQiIIQNNpQcmoWGQSvBjcT7EQZEJ67x0XF5XrP43lKMOJdiE35osh17WnqfNWo=
X-Received: by 2002:a17:90b:2dc5:b0:2e2:d434:854c with SMTP id
 98e67ed59e1d1-2e93c12378dmr8319912a91.2.1730458959964; Fri, 01 Nov 2024
 04:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6b63e97-6839-4beb-bb94-e5914837a041@lucifer.local>
 <6723b31e.050a0220.35b515.0165.GAE@google.com> <2928b6e8-3928-411d-82b8-6b17be266deb@lucifer.local>
In-Reply-To: <2928b6e8-3928-411d-82b8-6b17be266deb@lucifer.local>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 1 Nov 2024 12:02:25 +0100
Message-ID: <CANp29Y6OdSOrP4q+1QL9bZU7SnDkMvmSAkFAGM0VqX9gwnZghg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [input?] [usb?] INFO: rcu detected stall in brk (2)
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	Alan Stern <stern@rowland.harvard.edu>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Thu, Oct 31, 2024 at 5:59=E2=80=AFPM 'Lorenzo Stoakes' via syzkaller-bug=
s
<syzkaller-bugs@googlegroups.com> wrote:
>
> +Alan re: USB stalls
>
> On Thu, Oct 31, 2024 at 09:41:02AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger=
 any issue:
> >
> > Reported-by: syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com
> > Tested-by: syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         cffcc47b mm/mlock: set the correct prev on failure
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.g=
it/ mm-hotfixes-unstable
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1304a630580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6648774f7c3=
9d413
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7402e6c804263=
5c93ead
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> >
> > Note: no patches were applied.
> > Note: testing is done by a robot and is best-effort only.
>
> OK this seems likely to be intermittant (and unrelated to what's in
> mm-unstable-fixes honestly) and does make me wonder if the fix referenced
> in [0] really has sorted things out? Or whether it has perhaps help
> mitigate the issue but not sufficiently in conjunction with debug things
> that slow things down.
>
> Because we keep getting these reports, that mysteriously don't occur if w=
e
> re-run (or hit other code paths), they seem to hit somewhat arbitrary par=
ts
> of mm, and because CONFIG_DEBUG_VM_MAPLE_TREE is set we spend a _long_ ti=
me
> in mm validating trees (this config option is REALLY REALLY heavy-handed)=
.
>
> I note we also set CONFIG_KCOV and CONFIG_KCOV_INSTRUMENT_ALL which isn't
> going to make anything quicker if the USB gets laggy.

These are necessary for coverage-guided fuzzing. Though when we find
and run reproducers, we don't actually set up /dev/kcov, so I guess
the impact of coverage callbacks here is not that significant here.
CONFIG_KASAN is likely slowing down things much more.

>
> I'm not sure if there's a human who can help tweak the config for these
> hardware-centric tests at Google? At least tweaking the RCU stall time
> anyway?

We currently set:

CONFIG_RCU_CPU_STALL_TIMEOUT=3D100
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D21000

The expedited RCU timeout was limited to 21 seconds up to some time
ago, but I guess now we can safely increase this number as well. I'll
send a PR with syzbot config updates.

--=20
Aleksandr

>
> In any case this continues not to look likely to be an actual mm issue as
> far as I can see.
>
> In [0] we were stalled in a validate call which would align with the idea
> that perhaps we were just dealing with a very very big tree and getting
> slow down that way.
>
> Cheers, Lorenzo
>
> [0]:https://lore.kernel.org/all/967f3aa0-447a-4121-b80b-299c926a33f5@rowl=
and.harvard.edu/
>

