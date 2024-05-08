Return-Path: <linux-kernel+bounces-173466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB38C00BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBFC71F23692
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAC81272B4;
	Wed,  8 May 2024 15:13:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A571272A0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181185; cv=none; b=WyCpOprQanjkmKvcQ2uKgyUfE6N+8cqZGt+FjLEL2i/7aflakcKP5alwMrIc5kSPuwWAxQDH+LJWVhr2aVdbdVLyJkiX9sxQcINjUzgKH62i4++uwESyBdHYjyafBxhJk0RgtV6DlxCMK/VTH9gDUvvqlHpzvrEQ5TtVEkGM1so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181185; c=relaxed/simple;
	bh=VTooLKM1UWVTk8gSGQDqgDwStVWBUyMdaRzHq8tOcbs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L5oqXMtLDCz/mROLTfwZkJGUJ4KC4uULoPRkw7b5sSOo0pGH/nQqLd1OtSsMhFhy6tTTqzLNb61es/pkGXuU5cTU/ascxwoS43arIpif1vTKtBbpL5IrMOhVT8bcGwETcj8bIDcioTH798s5aK8ljAWqiMDu5zFgKA4lV08KIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dec4e29827so463929539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181183; x=1715785983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEBdO5/t3gWQndQoUbCFMwd1dlzvgeFuNRoAmahB4YQ=;
        b=DHlgbOsFCZOApy+/V9Eyg5XxVkxUxSSuhIjRq+r4BfgxWw4yjp6LQFTT/+NEGWNMUC
         ujFeghQ53t9o6SH47wZDN0iGaNaeV3mqHy2a0m7WmaozXdFGCiNBOu75gdHQUVE5wdZp
         fXP+bhBncNqSGjPA1oyVRFCQIZSp7qx39FNAiAQNSwx7enhCMNq6vchnd3Msfwb3W8Np
         62Zr2xC8CngsH6P6x7CTiCaVuFgnAYXf/qdGA+DoxJB7kIjXibxad4wVpIGkflOMw4vm
         YvKZWXrnAtvttm/oXsHCLGy9El6ZxN18t6TYkrObilTzQh2ZRigPqUDs8ZmGfoNIsKXw
         Cgkg==
X-Forwarded-Encrypted: i=1; AJvYcCXds+lgV+kESP4quwIhHCXRqZZ3ur6uVzqYSuPGyI92jhQjPJB8fpgiPSnVnIv2sIyOnAtupIkf067OezWMLqkNw8Y7wNEYGOPU9lCf
X-Gm-Message-State: AOJu0YyPTcC/8tAaiLcT/+K6z4ob1JB30VCbhWk+UCMR1H0o6qwX/R9a
	fwoIucuiJ2QT+5qMK070KzmwMAS90rv4PfAC6Vhwgbi/heCHW8x96iN0AsamrIpS/2mxmshuFm/
	Erudaz+DQEOrctMt6JBsTDVkxoNXGUupy8/9cx4mgt6SpjELG7SsYrOk=
X-Google-Smtp-Source: AGHT+IEgJOu5ZVCCFED8YRbF5GZ6UCcgUorZLjp//7D8s5IUYcamXViyuOmXvu9So1WH93R5xeRN4nyaq37WLksFXyCFnIm9g7Cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8325:b0:488:ac5a:7fe9 with SMTP id
 8926c6da1cb9f-488fdd777e4mr155178173.4.1715181183643; Wed, 08 May 2024
 08:13:03 -0700 (PDT)
Date: Wed, 08 May 2024 08:13:03 -0700
In-Reply-To: <0000000000006399c80617120daa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d41840617f2bd39@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
From: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, gregkh@linuxfoundation.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1e8c813b083c4122dfeaa5c3b11028331026e85d
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 31 12:55:32 2023 +0000

    PM: hibernate: don't use early_lookup_bdev in resume_store

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1380072f180000
start commit:   dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1040072f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1780072f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134f3c0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367a504980000

Reported-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com
Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

