Return-Path: <linux-kernel+bounces-277024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C5949B37
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE40128655C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D31741C8;
	Tue,  6 Aug 2024 22:18:51 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA80173345
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982731; cv=none; b=Hn4/ERXEb1/YAmBr9yRxolEm8ay1gf9OtMYsePLdO8tTzpbjYIjIaSqqLftp3hdcSwEfGuExl/MvLZ+/6D2120Q/5dm7wqG9GgEt37rVq9VJbLjrrxGnPafRlGWtIk5wdbSQLTtY4L1IxBd39MIOcobmAOorm0Yb3ynER6N4qMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982731; c=relaxed/simple;
	bh=XBOTNrgQouJow2mtcvNorPdu6ZwHPZzLY2QvmeOTCiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ffOqx76GyBW5R/x0qd2dXIMGd1U8eJlSfxkfABaepnJXWWUYmYod9FrD7QKrljFBpysd46TGXZX7bFiIJsfopJOV5jWys1pZ6zJDTERspvB2EHsFKsZ2/B/qSwU8aE64KHMESxnWKvJ1UDsV4hYrOqwgZYk+eC0I3MbHtuQ4fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f87561de0so144308739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 15:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722982729; x=1723587529;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PP1h4B7qKO8yrH53cKEsFZGXe+GswNbdNOzW19uGwAE=;
        b=mhulKevWrXNPjPBQ7blyQy5xyXwzLj4vtKyrz88NOoOZ7olk9Nkb2i6kNVWMksGP7R
         l43z1mRTJMQbsln/7VBsjID+nfRA9jeQu9P7LjRJmeVAJApuRLKEdSXavEuNkQuf7383
         1kjyWS3cQ7U98v6FzKTwCJNpBMPtB9f5UQygZY/TSQqOjKHGUqDl31oaM8Q2ZjXLT75+
         ngcDV8pGDrueMoqGmrjV57kMiepZ7r1fP81F++Q5d0YmGv+Y6rrgKge4BwOcIn09f/SY
         DPlIu7q5PHwfpdnYvU1P3hfSw/tytLjS4rjhkQ7qiZ0hbSU8V62eNYWdFMGLxcQah3qP
         Wq1A==
X-Forwarded-Encrypted: i=1; AJvYcCWUyN6jud58SgoJhCGJp34bdREFTXZgwqWE6BCttArI8ANZXo5xYD2i21z4R61iRfWsfakpYv9nfdzTHZrxEPp/5s6iGUttuQoOgZxn
X-Gm-Message-State: AOJu0YwW85h/TQJQoDLURGfDjS6nEJFR8oNRhVwr3L6Cxg0itGBXY2cL
	xlfwbkivMfyfr1/CvPaUhmIL4W6C4ixf2qsJpjXI34h5JEGDwYuzHWYXcQLNiLqg05wrcgtztNZ
	ougopbeD0WNcNZp3hPaLICu99IxCBDZggBO/y75K5SuH5Jt/yCdWVkm4=
X-Google-Smtp-Source: AGHT+IEqdW8Z5VhqHm6dClecQ4wYIXRV9ksWbAnqmdhH3XztqBCnSSroE7lkNLCSVKg+hPdCtCHjxCnXsBV7INOaCNeVHh2tszjE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c4:b0:81f:8666:c71d with SMTP id
 ca18e2360f4ac-81fd43dcf7emr62035539f.2.1722982728799; Tue, 06 Aug 2024
 15:18:48 -0700 (PDT)
Date: Tue, 06 Aug 2024 15:18:48 -0700
In-Reply-To: <20240806221845.GA623904@frogsfrogsfrogs>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000812b06061f0b2d48@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in set_state_bits
From: syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
To: djwong@kernel.org
Cc: boris@bur.io, clm@fb.com, djwong@kernel.org, dsterba@suse.com, 
	fdmanana@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Aug 06, 2024 at 12:25:03PM -0700, syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>> 
>> commit 33336c1805d3a03240afda0bfb8c8d20395fb1d3
>> Author: Boris Burkov <boris@bur.io>
>> Date:   Thu Jun 20 17:33:10 2024 +0000
>> 
>>     btrfs: preallocate ulist memory for qgroup rsv
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165cd373980000
>> start commit:   9fdfb15a3dbf Merge tag 'net-6.6-rc2' of git://git.kernel.o..
>> git tree:       upstream
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9681c105d52b0a72
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148ba274680000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ff46c2680000
>> 
>> If the result looks correct, please mark the issue as fixed by replying with:
>> 
>> #syz fix: btrfs: preallocate ulist memory for qgroup rsv
>> 
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> I don't get it, why am I being cc'd on some random btrfs bug?
>
> #syz check yourself before you wreck yourself

unknown command "check"

>
> --D

