Return-Path: <linux-kernel+bounces-358476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54ED997FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F491C23EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4ED1FF7AF;
	Thu, 10 Oct 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hk/u2SM/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4291BC9EB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728546647; cv=none; b=nzo234W0yi4iDZHGqFiwWNOqpbTv4t/j93jMxEis9VBugE3G5I9vpXJN+DhDxzla2ShKSExRnPLMWIrvOFYWD/MepbWZiE8rPDz8bH/jXDAjjJ7gxqoy2a6B2ZOdl53BswBR6pnsCfdpLm3EsbY6VYXhyeq3hvjRr+8lB2Cg1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728546647; c=relaxed/simple;
	bh=h98qP67ENFBhQ8PzFpiz15au4EHuD/oL34SEByQ/3Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H974DCiI6+cS0l/rYIje8l7uwqkTfK9h3nzvtJ7fkoeaHujpIWXDYqLnofyXWs5eICWr4S+RyNoFSixaNHgfExzd2FuhRnx0h0XtyG1FpxpV0dDtpUHUN2DpRdlsr4uyZHRotUc6vB8T+kIIL+ZDlHNRutzlkVStUA5p3hUdPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hk/u2SM/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b5affde14so3305585ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728546646; x=1729151446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jvmR8o1Zd7WNMFxg04YvM6ScNptO0BgRV3DizZHFUZ8=;
        b=hk/u2SM/YDsezExANsrKkV3hBj0heJa4zSiqIw7jCyxetWa2mRAa21kLUt11DG9/HM
         oPUCH7aHEMhD9I0TvFVxJjvg3CkvKlL02perOW8HNAJFTh5z6FXofgyxjiYshGDysyeL
         Zk5SKauVeT00sdQZ1YZwwjAg64kqRM8u4Y2HtsfcGSlSuXDc03doDkbbNxsZE/JJolfB
         46FgAXw++i3aeUNusaRrClVFk2az+BhAC2eSq3qKzlGk1WLWVCJ9m3ee1iLkze/3FF2W
         Uy7az8mw/TPBB1m3lfOPoIvMSdN9bZxjPlgv0Kb2G9eZTEozIYePwsY3UNDR6C/1PyTu
         vYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728546646; x=1729151446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvmR8o1Zd7WNMFxg04YvM6ScNptO0BgRV3DizZHFUZ8=;
        b=QhC8L+ZPFUzBzS5E93HqEOgUjdzVuKipqh2iDW2Lkxp/7tA5GCY81gzMXIzHjrE+he
         PsTKN94hwMmvS+lURnmnH360LUna4v7ESrbK5Ng5xvIB0Imy6Zvlf8rU9gAJs4uU8siE
         YoGgqHZ4MDgRMtuSm0kqzU/xZqDYNmvDqFjbWBMNmjuuH6l9V2Tk47MfHkmmlzsxd7iO
         TooKC8fYswju42f7gLwX3Lu3cRq3jT/KwrYtIL58gVNnF72LU5WPccRJ3zLOr38BwvvW
         XYBZw4m+w2Baghx7BKMjSZ+Oqw8EBRjyZTfq2fTxadnm72aSbL+Mjkne5/Pnuif7OFeA
         DHJg==
X-Forwarded-Encrypted: i=1; AJvYcCXgBBGIJTDWMpn5dSbyknoG5T7JicfHYIJDHic1Dduai5sBq/UlaI1p14CPsrEGgQ/eiRIPvi4iIfKeRzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkz3t6hgdc6F9yigLGEb0rvD+8FGzWYa+zHaZECKRh+1ExFWos
	fhzmbDuJABZ91sPmO4Y4w9hceVSsvUwsKHrJut5lFXP1+Ml06HelDXcxX60qWShp9EXt0MP+y3+
	vpY7FlPzOnrZzsINALv8836aHYyfdM6xDzvG1NkvEGPQ7FB+MSsbn
X-Google-Smtp-Source: AGHT+IG4NUyfVCXyCU8Jz4aqTBl4CgLaNqotRYOmed8iiKV8Huh04xpDq0iTWoUYrpHsJPdMC8FpAz5yJ6lXTTaMXU4=
X-Received: by 2002:a17:903:1c7:b0:20c:5c37:e2e3 with SMTP id
 d9443c01a7336-20c6378011dmr65091635ad.42.1728546645201; Thu, 10 Oct 2024
 00:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6705c39b.050a0220.22840d.000a.GAE@google.com> <Zwd4vxcqoGi6Resh@infradead.org>
In-Reply-To: <Zwd4vxcqoGi6Resh@infradead.org>
From: Marco Elver <elver@google.com>
Date: Thu, 10 Oct 2024 09:50:06 +0200
Message-ID: <CANpmjNMV+KfJqwTgV9vZ_JSwfZfdt7oBeGUmv3+fAttxXvRXhg@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] KFENCE: memory corruption in xfs_idata_realloc
To: Christoph Hellwig <hch@infradead.org>
Cc: syzbot <syzbot+8a8170685a482c92e86a@syzkaller.appspotmail.com>, 
	chandan.babu@oracle.com, djwong@kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Vlastimil Babka <vbabka@suse.cz>, Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 08:48, Christoph Hellwig <hch@infradead.org> wrote:
>
> [adding the kfence maintainers]
>
> On Tue, Oct 08, 2024 at 04:43:23PM -0700, syzbot wrote:
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8a8170685a482c92e86a
>
> [...]
>
> > XFS (loop2): Quotacheck: Done.
> > ==================================================================
> > BUG: KFENCE: memory corruption in krealloc_noprof+0x160/0x2e0
> >
> > Corrupted memory at 0xffff88823bedafeb [ 0x03 0x00 0xd8 0x62 0x75 0x73 0x01 0x00 0x00 0x11 0x4c 0x00 0x00 0x00 0x00 0x00 ] (in kfence-#108):
> >  krealloc_noprof+0x160/0x2e0
> >  xfs_idata_realloc+0x116/0x1b0 fs/xfs/libxfs/xfs_inode_fork.c:523
>
> I've tried to make sense of this report and failed.
>
> Documentation/dev-tools/kfence.rst explains these messages as:
>
> KFENCE also uses pattern-based redzones on the other side of an object's guard
> page, to detect out-of-bounds writes on the unprotected side of the object.
> These are reported on frees::
>
> But doesn't explain what "the other side of an object's guard page" is.

Every kfence object has a guard page right next to where it's allocated:

  [ GUARD | OBJECT + "wasted space" ]

or

  [ "wasted space" + OBJECT | GUARD ]

The GUARD is randomly on the left or right. If an OOB access straddles
into the GUARD, we get a page fault. For objects smaller than
page-size, there'll be some "wasted space" on the object page, which
is on "the other side" vs. where the guard page is. If a OOB write or
other random memory corruption doesn't hit the GUARD, but the "wasted
space" portion next to an object that would be detected as "Corrupted
memory" on free because the redzone pattern was likely stomped on.

> Either way this is in the common krealloc code, which is a bit special
> as it uses ksize to figure out what the actual underlying allocation
> size of an object is to make use of that.  Without understanding the
> actual error I wonder if that's something kfence can't cope with?

krealloc + KFENCE broke in next-20241003:
https://lore.kernel.org/all/CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com/T/#u
It's been removed from -next since then.

It's safe to ignore.

#syz dup: KFENCE: memory corruption in add_sysfs_param

