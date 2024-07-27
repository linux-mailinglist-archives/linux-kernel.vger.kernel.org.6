Return-Path: <linux-kernel+bounces-264283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E740A93E10F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F2D1F218E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219023FB87;
	Sat, 27 Jul 2024 21:30:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAC36F30B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722115806; cv=none; b=cdr6/xtrBaThP1nmY1+++VzQY382Hm+A8+y/HxjRrfqh/ldmrHi6/aL6H455qiQai0gvCTXDxGTbLFGtTsFGFtisilPUX+yj2J28i4jenNoS46ipjaSGH9UGbirK9eipt5YJzTHsoddVBfBhBzusODcqrUfq8VdHjB9q0Q43Mgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722115806; c=relaxed/simple;
	bh=aVNeDwAcH3nhinn8KN74yp/VldGnmgYK31tdROz90MU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ge4fwcU/YxxZj9TV/+1na3jIGZnesusSdfghGfSYzpR8gtLeY/TyE2ehK8JClhpVwwRR3TvR2AWpC1pBSPrdlVSZE/MM799FfM9Er5vdqoHttZ/ME0UP5lNsaK97cEB5T7ZTJk4OPs52ZITinWn3CUSLpWSkIV/5QE8eLk1c6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa12a11b7so26427739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 14:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722115804; x=1722720604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fsdRpaghEJ+/Dj0wdbkeHYQLI2pmFwp1Jcpptz5Os0=;
        b=LFJsNLg4D+TA3waGD+yHsfPwARtOOmSicQrFxgy0ViDKlJCE+KvzFfDm2ogw5Od2Lm
         /NWQ9SoqgLitclGMlAe85MO9ZdVfO0vk8/K9UX7ZITs5WFNoe7V/noAy1ntRfax+1BUB
         MaDORskVBTb67mSxx3qnHD29BRjAOuUVRyxvxa9a4nkonNl54hbSND++N57KDEou1JDa
         lRqck7C28a/UQZPl1rG72lj4ZfTiJF3s5Sxn9QjvkkRyQjE6c/pwrNaUl8xEDZMfu6SE
         NamgfuMna4UCUvtCXE6TcMlYJzdO3oVAtTK4JImcoc/3jf+mfZPlTueBpntSJ86uZ+EM
         iJqA==
X-Forwarded-Encrypted: i=1; AJvYcCWrEh+kTF4NYTWIoCzEgRJzd68uMrmQ9NVkNRQlg6y/EQxsqJe8H4YW77y3xrezz+XynBgu1LRM9yuj/O4280dOHgGq2N9Q8/ddCfxe
X-Gm-Message-State: AOJu0YyoAjVvfCgiq8In3L9QuEGrDV2jav5SeLC+3enHc1bUjdM6vcY3
	ddud02ClgdJFtwnillvbruRDUYYG/EYaojlhjjNwhaoB53a66UcyuP/q9+0xxXnt87fmAaEzr21
	iTnW66yI16OneNer5hp54FLz2PiQxmgzMz/XKIBh3RzAqXL64IsXzYsY=
X-Google-Smtp-Source: AGHT+IEUvhd20vFaJyfB7vqzeeapYRA2ugZRDA9EUzCJ2ga1J1o4joW8dZ5gt42Tjtt++7T/3t4KQ3D0k6wJQCAiSA7/YhflOq40
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56e:0:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39aec41b90dmr2735975ab.4.1722115804535; Sat, 27 Jul 2024
 14:30:04 -0700 (PDT)
Date: Sat, 27 Jul 2024 14:30:04 -0700
In-Reply-To: <0000000000002488fc061ae886f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caad4b061e4154d2@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_file_mmap
From: syzbot <syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 69505fe98f198ee813898cbcaf6770949636430b
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu May 30 07:54:07 2024 +0000

    fs/ntfs3: Replace inode_trylock with inode_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17772623980000
start commit:   2f8c4f506285 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f72623980000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f72623980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108328d9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e875a1980000

Reported-by: syzbot+c1751b6739d83d70bb75@syzkaller.appspotmail.com
Fixes: 69505fe98f19 ("fs/ntfs3: Replace inode_trylock with inode_lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

