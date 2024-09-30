Return-Path: <linux-kernel+bounces-345024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A898B136
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9FC281EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08D185B62;
	Mon, 30 Sep 2024 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK56poLr"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AA2C1B4
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740365; cv=none; b=C6IFRlgjsIfa3RDMDcKDwRoBs/V4zv0ItrzitPmmirZ1nZKvL0ZAyJCkMTfGur+I6CPkZ+Ly0heyod8iIo2/cuAPdJSh1Bka8Ej+yDZQlsSqNACJ9ZVINkLHy+x5wc+QXT2Ax9PDv7XbDEj1+pgPlbCODj35jdqEmljrEd4LeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740365; c=relaxed/simple;
	bh=OqEc7OwtPB32ect8efeDSUqWViMU9jUnSjwFT6sbJs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiB5NlgLe0WWD6SLMlv5lceZ0j/pPt8Ub/uXIdCmOM3XE4P4kQqNk16DQA8sTAYBN8ow8T9GVy3ssCX8860r3suYpSJIiAvrm51RBZgx+HM1IWMWIms6QXYcRuOSLTrbGe3YqIlawYKAHt9YALRQg78fyl8hdk8/qOfZbAuuJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK56poLr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so3552860e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727740362; x=1728345162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekER+BlavVK8e8lSCl9Lzc6p/rOexUYi5x/FegHKg2c=;
        b=KK56poLrH3aVJdYIrCSwbIH9eS29+Er5oTA264ZNNtVSYByZ7wTdRkjsktghl9gZ37
         Ne8kuhbbIOHaoAzXupweF9idZG9pnMHMz9qC3C0YUxtzK9M9GxAmAhH4+J1Q7YOruedV
         VfOsiN3GTuvyvCNESj+o9nRsmpYJR/PcW0HZAPBJ4IGJvuSuGhbTCsJo13y9/mqzEBtD
         zn1C7KQYJ90zG7SFpyAC6gZKwhLyFxO9LKZ9g6JxfHYGTplSV1sBeU26GJcWr//C5qNh
         7pvBkgS6xx08a2t6yOpF31oLR/13pKrVJIhRCKMT7CY4wSi/Rlvnk2joC9/Moh8ZLUDm
         MHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727740362; x=1728345162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekER+BlavVK8e8lSCl9Lzc6p/rOexUYi5x/FegHKg2c=;
        b=bKlgpZXBx4nMe26uuQ2vwjp8rnDdCTsCqmQJYYIAl9MEv6RE+CPZq+CNIV/py9NBlZ
         XDqeafo3WpuXN12w9/2xBnDomr3JjwsC1o+zO3LRweoAlaWJ0mmlzotKxU3+y+RL07bF
         ZiwoyFKQ0nXDfMuKc1Zi7VZDjgQhp/iN3CZI0HSfhuHvOC1fnx+RVSaQdtr6N1AXS+YT
         kHRtMYgCFMn07LNS+N3ghWDe6ueVZp5e0S31B5rPAduCTCRWTr+v72FNfGJ/0/0GQlhY
         mewXEU/V5Tgi1kNQIZES2YAmRmWBQts/EYWGbcSn+b/14uaXPr/VRQwUFH/VmBx4EvFa
         8eRA==
X-Forwarded-Encrypted: i=1; AJvYcCW7pFryPXU/vDu8Y4mGOH/+iLNa76c5FmRwSuqsgo7ISAHJlySkt/GbiQ5CMey0RoZFMhHD3h1xuwRy6iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdhd8eYH71vNVjed1KYcQLReXccqoVXZALVueTKCfBMPma6ZE
	z/lQWP7/biAxdsipjl4zfO5ABHd6MSXd5AwpSmcy1+h1hgncP55iaFN6gdHrR5/nxi16DrfHz7E
	YBelwDCERZeSeHHENA9gR48iaOzo=
X-Google-Smtp-Source: AGHT+IGYS01WINA5gr1bRtsyxPngVbeEaeTYygCIoc+XhMsXVkXE2hkSm3g+SgpdWpx1vLyRpRargUgPtLBuk2FDJOY=
X-Received: by 2002:a05:6512:6c4:b0:52e:fa78:63c0 with SMTP id
 2adb3069b0e04-5399a24ff2dmr379518e87.13.1727740361446; Mon, 30 Sep 2024
 16:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b3a0.050a0220.46d20.0038.GAE@google.com> <66fa4a57.050a0220.aab67.0027.GAE@google.com>
In-Reply-To: <66fa4a57.050a0220.aab67.0027.GAE@google.com>
From: Shu Han <ebpqwerty472123@gmail.com>
Date: Tue, 1 Oct 2024 07:52:27 +0800
Message-ID: <CAHQche8jUaarbLbMcQ10NXQrqAZSz6ibghML38c2fkXALpEoug@mail.gmail.com>
Subject: Re: [syzbot] [mm?] possible deadlock in shmem_file_write_iter
To: syzbot <syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, paul@paul-moore.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems to be the same as [1].
Link: https://lore.kernel.org/lkml/20240928065620.7abadb2d8552f03d785c77c9@=
linux-foundation.org/
[1]

syzbot <syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com>
=E4=BA=8E2024=E5=B9=B49=E6=9C=8830=E6=97=A5=E5=91=A8=E4=B8=80 14:51=E5=86=
=99=E9=81=93=EF=BC=9A
>
> syzbot has bisected this issue to:
>
> commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2
> Author: Shu Han <ebpqwerty472123@gmail.com>
> Date:   Tue Sep 17 09:41:04 2024 +0000
>
>     mm: call the security_mmap_file() LSM hook in remap_file_pages()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D110d4ea998=
0000
> start commit:   3efc57369a0c Merge tag 'for-linus' of git://git.kernel.or=
g..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D130d4ea998=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D150d4ea998000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da4fcb065287cd=
b84
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D288aa6838b3263f=
52e7e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17af2980580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11607d9f98000=
0
>
> Reported-by: syzbot+288aa6838b3263f52e7e@syzkaller.appspotmail.com
> Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap=
_file_pages()")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

