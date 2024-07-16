Return-Path: <linux-kernel+bounces-253773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81509326C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1E0B233C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A995E19AA66;
	Tue, 16 Jul 2024 12:44:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246017C233
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133844; cv=none; b=uQnwwpHog2y8E1H3fHgfvAEqMVi/Nf7gRAF7Dlw0VX3LaZrNtvlCO+RxkeFEApkog9GRb6vg533QwFyL50TASXuEcIE+89Xh1Mrj92X24SC/+V5RSHBoAw2Ozpd2M7LdkmHxhcxlyXUYzebunMxXb5OJudC36MXGiqHSYd4JW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133844; c=relaxed/simple;
	bh=Ry/5YTBsVvR9REbbyIAXHyQci2H2u79AtPCrWlByGcQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kIP2dJzNBadhUzJDOOOWKqfR4n9bWKQPbW8Da/IB/YJyyu6Zq4dHraXkve+bkCiQPnieaazZ/XcZl+Q7tVHHR5I6GhyuBwSqYGow4MWgMF7W8TCaTJBZI58yENKK6bfsTfqaUVLJCJLqm1H7qvKDsVmXFeP+WAjhIO7wjKLw+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-386540d8c90so62773195ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721133842; x=1721738642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RdyGEHqBnFMt1nPt1eV6xECBNR3tFqZ6LsQJrhOt+k=;
        b=Qgj0A58UIxa0Fh1o5GyZGWWeK7OuDobWX6w3xdupTLS7iedouvbG/zfsvIp4IKpL/1
         39Kp4u1nuZqhiwMfrUmPNOpmLv9zBMIFCBSlQ/Pb45oq3IeBS+9PODgeS3MhTL532Nte
         jaReqMVTj7jxl78WtzQv5a4MgsPhGIZlYrjPLLw+sqA1bAfS6E3MQWF291WY/rdR+YD2
         XPjCe+Nha8uZ1Hn02qrWJ7+uh4VKRqDayrHsmT0+B+pfjyX5f2HfQBK74mYlV5pT+frp
         tWvoy2FZ/M3CPbxjfCbLJHZG3+i8W44zD5DoxT487BHbE/NBPNTENdNmqrXTJciY+NWn
         rXeA==
X-Forwarded-Encrypted: i=1; AJvYcCXmRkZZhCvrL58K0MRlbcCqk4QPkkWDcrOtmbqW9OHdDTT/Ggj7m7ZiyzGytidC9FheT6GuRY/0mZiCPBJwqQORiQTKc/Q/kQGEDYIt
X-Gm-Message-State: AOJu0YyHzCqc3ZDrR3rPVX0FlI6QjbToNYHSRx5kTqPOeenqNOZ14kbS
	iFceHMnVvn6wlFC0jkZKIFGbLzHjuLkAGChg+SZpYUVHIljMJ64aQ3lkVMp+3NW/X10oHKyFy46
	gs4Vxy4WaOdV5mndYDSk2CBhcqkeT5/cKCbBpe0siH/e8AjyWdfE/H8k=
X-Google-Smtp-Source: AGHT+IFJ9isERFxWkiz18kCcoNDmUeaWuruDIJTmUnJWrA5G5uztzV2WynsyFFKgd0Mpd3ah4yb5p7BQfXkDabGV4f0uhBWvKf0+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:385:ffe:4516 with SMTP id
 e9e14a558f8ab-393d150aa12mr1266775ab.2.1721133841910; Tue, 16 Jul 2024
 05:44:01 -0700 (PDT)
Date: Tue, 16 Jul 2024 05:44:01 -0700
In-Reply-To: <20240716115504.1136-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000422161061d5cb3ee@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-use-after-free Read in handle_mm_fault
From: syzbot <syzbot+4c882a4a0697c4a25364@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4c882a4a0697c4a25364@syzkaller.appspotmail.com

Tested on:

commit:         3fe121b6 Add linux-next specific files for 20240712
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17749121980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=4c882a4a0697c4a25364
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c86045980000

Note: testing is done by a robot and is best-effort only.

