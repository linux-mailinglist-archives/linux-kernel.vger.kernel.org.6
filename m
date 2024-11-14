Return-Path: <linux-kernel+bounces-408850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FD89C844E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE285B2654F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B501F584A;
	Thu, 14 Nov 2024 07:50:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014291E9080
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570632; cv=none; b=llzJaVuqDP8X61xUL3FkKVVqZgjdRTxYdxhOQczZnw6GAbalK0bveKQxkaSnOs2POoxEHIKUcfKMOFJXssnq/iKXWCZo5EF+y7E53HsXCQcPZDMqrkYcBKABdgXpDWN5sN4x5JYRVU3qgnlI6NA7OrnI8cNBSlD9YJSukd0k8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570632; c=relaxed/simple;
	bh=xDEQ/0e22KT9b/jlrBYDIOEHAI+gSL9iRHbizP+iPAo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mB/hxJCHqh30B8ei/WovG+3fHH+6QAB70C3o1Nvnm+TjoeaVNMqkURfaRkl8po0r5O5hNEnrvgyd9JuIH3P/Ic2UtmykV5xY13ACpBWvNCUc7/XyikRPa/mdGeg+5hLqh2U2AFgEz79rZjKTyxFBrXzG5F8FL7o8/EOjcPRkR9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83b6628a71fso33517839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731570630; x=1732175430;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDEQ/0e22KT9b/jlrBYDIOEHAI+gSL9iRHbizP+iPAo=;
        b=Eu4s+YHhW84x/E/SWDgc6gQBGbb5Z+vIXSgCUz/aV+oexKUsGjPmLWQ/DoU4JEAeyi
         pSX0ZLP/1mIhDAhmwsV80RUbuXFakmUf0zXv14Zrxdud7iQ4FdyE3+GwLW4zH+UpKkFo
         JE4IU1svEqxTUQZXAHrbtKsRjfSNe7Vj2N5kkEsK/ZwVVvTiTaza/ziqdljnlRdWyZId
         auzju5/paTp6V8qToA9ufKDQRKGP0n9aCYstubuNmvbiCjhqVTWuRogqQcBQmRnBb+cl
         +YGDYpYndi4HhGIcoslydVOurlmOTU0q4e692TvQVBfedKxZoqVJDCO2Hx8LhUY15j5k
         YqsA==
X-Forwarded-Encrypted: i=1; AJvYcCUOSLGVhIVdR1TkQ7Hj4RYElEsqLleVlD0yta/XNK0b/FSoDDfWbUKsruBtailD1okXJI8fwdLpmYUUqVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbRHlPSKaaKwmIvsZmUNMsZZXRxZUnvWNyvr6G7wHELIvGPCp
	Bnpk0KYBo3GO5Wc50r5/Y0SkcFyOzjScZbI31n/0MC4b1Ts4WtqbFy8I42g6EH0aeso5oulHyoT
	0+LlhSAd5tsfxvgw0StNuIk35AbH9ply3r619WbP2lz9wpo4ew2ciHiM=
X-Google-Smtp-Source: AGHT+IFeSso1xZ/huYZTwvcdRL6JQM4k4Rf7KXF8DagEjZGJGkHDsXbGJ/OT2rxCHYPUOtZK4hmtVTFpNJ9XxM2uRXIp9x5SeAEp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:650c:0:b0:3a7:158d:6510 with SMTP id
 e9e14a558f8ab-3a7158d6768mr53192415ab.5.1731570630054; Wed, 13 Nov 2024
 23:50:30 -0800 (PST)
Date: Wed, 13 Nov 2024 23:50:29 -0800
In-Reply-To: <CABuj9FcMbcsjvcTxLvqYnjE1+jLbJ3qiT+=WFc4VWBS_ws6dHg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735abc5.050a0220.1324f8.0092.GAE@google.com>
Subject: Re: mm/slub: fix a memory leak in sysfs_slab_add()
From: syzbot <syzbot+d0bd96b4696c1ef67991@syzkaller.appspotmail.com>
To: sudhirdumbhare@gmail.com
Cc: sudhirdumbhare@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test

This bug is already marked as fixed. No point in testing.

>
> diff --git a/mm/slub.c b/mm/slub.c
> index 4148235ba554..d10c4fbf8c84 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5653,7 +5653,7 @@ static int sysfs_slab_add(struct kmem_cache *s)
> s->kobj.kset =3D kset;
> err =3D kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s",
> name);
> if (err) {
> - kobject_put(&s->kobj);
> + kfree_const(&s->kobj.name);
> goto out;
> }
>
> On Thu, Nov 14, 2024 at 1:18=E2=80=AFPM syzbot <
> syzbot+d0bd96b4696c1ef67991@syzkaller.appspotmail.com> wrote:
>
>> > #syz test git://
>> git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>
>> want either no args or 2 args (repo, branch), got 1
>>
>> > master
>> >
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index 4148235ba554..d10c4fbf8c84 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -5653,7 +5653,7 @@ static int sysfs_slab_add(struct kmem_cache *s)
>> > s->kobj.kset =3D kset;
>> > err =3D kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s",
>> > name);
>> > if (err) {
>> > - kobject_put(&s->kobj);
>> > + kfree_const(&s->kobj.name);
>> > goto out;
>> > }
>>

