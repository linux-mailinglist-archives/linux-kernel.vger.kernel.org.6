Return-Path: <linux-kernel+bounces-348530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3D98E8AD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB2F1F26BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825D3FE55;
	Thu,  3 Oct 2024 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dcT++lDK"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C21EA90
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924976; cv=none; b=Z4uXeWu6FNhmGk2159sK6I0V9KPi/PxwhusDG+E2iReNf1Eqydee5DiPqP8ZGapq3ZWQUF9iS4bXoYpphHS3bPswY6tKT2sJciRN8gr/Kat0vXabOviCAmycWTy3UBasQIkYGSmxdyFb9o27iard08uinxgrTvQ05pXOyJVwqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924976; c=relaxed/simple;
	bh=gqxa1YnqSpyoO8jYHhaneN1Xbjde9NeCMupNvy17rVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMov4MCV/0aOMWdPfyv+X2yz+6g5RtFcKM5TNj/CUsymWUZXEKMcmEjMA9abJDNwuBUXNWAQ+Eyx8nWOwIPfv6/z3J9wmxpO5c83kgQwfqs01JS34Xtq0Lpm+DbqPJ8422Rp61ZdH2N3ckr8W0O2YU7q1+lZWJgTrG/KtqJCnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dcT++lDK; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso392794276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727924973; x=1728529773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TKlAqmWS7yAuGxt2U11/NinoSGw3zEex51U/NMll6k=;
        b=dcT++lDKZGo+I167ijS7wJafX8qH34ogEGytZ+LqXFMa+/I6+gJWFaLd9OIy8+rNqQ
         hytoO83DZqTVs0rcShRiCzQomzXm/m0oywfe6Ha7D7Rg+6iBTQNx27QpXnsSGyQFSPKW
         ngqyxBSepdTtk62nC5prlCPZDpjC0FTIe6Ng2ByDzdJ1E8J+khx/7Eed44nnyIJut1/x
         iWDwkoEgggTrgZmxlMFbAI2aace//qm+gYPsQIyiV/jH4MZMB9BXBx6HOwTZ7iQeMZ8p
         cblaOkdadofbtyUhBcZtc/9OcHEar2tWIfbuuI3AW8XEus8CcVKThImFtjXYVsinQ9fj
         3xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727924973; x=1728529773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TKlAqmWS7yAuGxt2U11/NinoSGw3zEex51U/NMll6k=;
        b=tc1PIc8Yzi27rgOjfI7sxxCOSdaVKaQ2P/vRrawGzQVTlLk9cNQOPZQa4eZb3f9++6
         AReiI4QwqX41mITdVV5tTwWZVTSoZqwn+G9GGUBPPQjM9bcCskiDnde9ZsZw+6SJvVuI
         hjYiqeOQX2UHnzFuG8IBNnySZN2fMMiO8BCjzrLQAvNwz+asJDJFMW13Ijm/OVF3pnBH
         XyJzRFREfFtTw7JCoMTG3mjwDQAgXXLBMObOORwMrRpKVzRFgvmvA2EOspj48esa6+lP
         JA9fiuhKllBfC5qt1FCgXeycTsDL/gLr7OXFAftmB99/wpQEAoq2dXMi12fiY/oNv8Mc
         aE8A==
X-Forwarded-Encrypted: i=1; AJvYcCWnsRif5SgjtA9H5z3KWYUqUvNWIKIJg8z+XsHm3KZSi0ZyNwAON/lloi01N66rjszvkv4GgnYlDq7uCp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeBLno0Vd8N64k9kes0MjyUPADYghhI2AohKJf50hLp5+23JD
	Am+Xi3FI+nRXKWD0vIb6D+7r2Vt7uCGbdliYFKqLfI7bhB/DSDt+bijsDgpjNKKEzzCExdnzol4
	YGFX1aKqRA4U4VZyy8WszP8lS3ntuQglIfJaf
X-Google-Smtp-Source: AGHT+IEXOkpzxjalt/s6BumTiyIkpgNz6DTSsxcgK3vVgqu+PX9GLKOWjEc84soRoaZm+DQi7TTIHvhFljCKfSz0Z54=
X-Received: by 2002:a05:690c:ed0:b0:6dd:c679:f108 with SMTP id
 00721157ae682-6e2a2b3f03cmr55041267b3.5.1727924973274; Wed, 02 Oct 2024
 20:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b10e.050a0220.46d20.0036.GAE@google.com> <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
In-Reply-To: <CAHQche-Gsy4=UT6+znKyPRDEHQm9y-MQ+zacoqfywKaz7VA2kg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 2 Oct 2024 23:09:22 -0400
Message-ID: <CAHC9VhSHSD5QF8w2+n9f1DAEfQAwW5eA0skSuap2jdMWrLfGWQ@mail.gmail.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hughd@google.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	roberto.sassu@huawei.com, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 2:08=E2=80=AFPM Shu Han <ebpqwerty472123@gmail.com>=
 wrote:
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: possible circular locking dependency detected
> > 6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
> > ------------------------------------------------------
> > syz-executor369/5231 is trying to acquire lock:
> > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_l=
ock include/linux/fs.h:815 [inline]
> > ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: process=
_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
> >
> > but task is already holding lock:
> > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_kill=
able include/linux/mmap_lock.h:122 [inline]
> > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_file_=
pages mm/mmap.c:1649 [inline]
> > ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_file_=
pages+0x22d/0xa50 mm/mmap.c:1624
> >
> > which lock already depends on the new lock.
>
> This issue (if not a false positive?) is due to the possible `prot`
> change caused by the processing logic for READ_IMPLIES_EXEC in do_mmap(),
> so the remap_file_pages() must perform LSM check before calling do_mmap()=
,
> this is what the previous commit want to do.

My apologies for the delay on this, I was traveling for a bit and
missed this issue while away.

Looking quickly at the report, I don't believe this is a false positive.

> The LSM check is required to know what the `prot` is, but `prot` must be
> obtained after holding the `mmap_write_lock`.
>
> If the `mmap_write_lock` is released after getting the `prot` and before
> the LSM call in remap_file_pages(), it may cause TOCTOU.

Looking at the IMA code, specifically the process_measurement()
function which is called from the security_mmap_file() LSM hook, I'm
not sure why there is the inode_lock() protected region.  Mimi?
Roberto?  My best guess is that locking the inode may have been
necessary before we moved the IMA inode state into the inode's LSM
security blob, but I'm not certain.

Mimi and Roberto, can we safely remove the inode locking in
process_measurement()?

--=20
paul-moore.com

