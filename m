Return-Path: <linux-kernel+bounces-313241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F6396A238
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21698B245F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D418E752;
	Tue,  3 Sep 2024 15:21:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521D18EFED
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376865; cv=none; b=QxhU66yJ7Fy8F8sqDwCzhDN70axqxBgK7n79gKceNOjboF+vfgZ1/CmH3bqFXExbW8pgWyPxUZGfkTWyrgGA/BQKZpS9SChBHmpPfXbpO13/gc+JaRaoPGctDZsvFZ7b9mSs1bkCeJ6W1fPQ9SDXSbH5aLBpswgTn5tulzdQBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376865; c=relaxed/simple;
	bh=3Ny0WMQX8C6jeeIkUnaWG7nWZhqsNoZqmVph8c8Ul0Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RNskT6dQHSlaFy+TPUH9tomoVKm/gh/5A0TYd6xZ0eshLzGfp/Z0n9HtzhjCM7osIOVGdkWccGLtFPkmSZDRjn6Gn7sU0CX01LgDJ/C3Hvy/2skQvfLzXhr358jqzT60E0DZn6vglQIXacS8sA1WZXsWJwFoxtsKIFGxY4GiYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a217cec1fso592509339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376863; x=1725981663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdhWR+G8uLjBKfvU6iFCSQyIIWpyU5h8YmkzUpZmhvQ=;
        b=tXBF7tmbYpw0UxB8oC4tlmpieF9jDNA8CO7KVMrFZWovDRqqyfz6scDnoN831jxU8L
         FS62OaycoSB3RgI7n11PEPAb3VM/1ia/T28IzLxR7HWOw6intYMq6+xz/cryo1kw5NPJ
         Lj8a+Zu/WjYYkfi0wLTE6Sg8eFKP+wC7TjdpGaJqDpE8jrkavf5/dTKMexlRnendSeCq
         wxHclFgoBu8KKS0R4wYksgzeAHo4SCccVtAk1sU0VxBkRgsKuCOj+vStmVrnJDVMcH5f
         cbudLviCGpiEB5loicfO1uqgR6lK1PoCwuetnSkUbbqldEhBfgtJKxUQsLf7Nzr+3MzL
         YP0g==
X-Forwarded-Encrypted: i=1; AJvYcCXkHGTctfOLAvBJDZHE4GeMf75KapuonEqBXu0tyW69ZEv6iKVP56RuGEVCwkoQT8bbfpdRNUz+UCb2T28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+H/hU1LlzcHGji46cIR+GAtFbgkgEMe/PboSD5hZ1d2Hl/5Z
	WNme8FlkuauNs9zXlC62dx3y4wGJSs6NxHhs2YwJ4JTZz8vnbrjKg047VG06WvQsiu7XyVcKOie
	0WA99D1/GOvpoUpWKVBpwI7rvs8K+FYJgKInnEK5qMkF1mKhSP37I5CU=
X-Google-Smtp-Source: AGHT+IGuYDrHt//evjliRlOW0PwEhQcMUXOrsfLe+oymCy5dcfAwaEBvDhuYp5TPwilcadbw76Ma+1wpUBvjZysjrMFhUGCA373t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8506:b0:4ce:8f9c:c601 with SMTP id
 8926c6da1cb9f-4d017c6028bmr843346173.0.1725376862815; Tue, 03 Sep 2024
 08:21:02 -0700 (PDT)
Date: Tue, 03 Sep 2024 08:21:02 -0700
In-Reply-To: <10d4a49b-c596-418e-969c-0830d678de87@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000320e90621389b3f@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (3)
From: syzbot <syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com
Tested-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com

Tested on:

commit:         69dc8fbb f2fs: get rid of online repaire on corrupted ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=166e6963980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

