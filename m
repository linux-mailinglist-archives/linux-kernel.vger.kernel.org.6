Return-Path: <linux-kernel+bounces-229622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C69171F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58772B20D07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7939417E449;
	Tue, 25 Jun 2024 19:55:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52617D88A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345306; cv=none; b=TWNPI+y8DONnWC3z+N/WIegRZG3Dke0jf9ORjaLu/TT0wJ/4L1DCBDnwhzNrgJ3WvOSAr/QdwXUt6RxhL29Z3jEeJ8XyfZcd1NtJzPL01umBhnBxLsX9LNGUR2kSO5VE8boYn+9ODveUwFj0L2YcKPhTbbRzHB+0gVzCT01fDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345306; c=relaxed/simple;
	bh=b0MXbfQwiz1HqvRQlWZG7P6qJc/DnE9RZQB5as9e4TQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gSqQd47yWoeXVW5UZ5ZYQ/a6OI0xB1io5ABIO8aZ1kRIpbKKkQige0Km5BmAWUYRmj1xIQvGCXJiuPBGuTJ8bSZD9MuIfnCN11SyPgdD9YdMwLSMZKUFpjjY5cmkcLgWcQ5QJ52zcFLN2XRL4q+lAM4pgMRyZKw01WCUegIvgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ebe8016637so906060339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345303; x=1719950103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kYK1blI2kJuy7K3T4k8oxcwMpMhBo1+92dw7x8VL1U=;
        b=boGzZVv1ShuN+iDN6KFMupRRkz7nnCs5AsYOUYc8PK3KJ1tVnOsDS2Ai3Mz4/kY6O8
         d2moBLrGw2ltervK/MveCFTXCAoI+YmyLD4uxxaYuQgPednj7URVf6t2VBRDNcCTWcia
         2JHgh53++auuleDRFOTRncw1XAucBQ7uhCh9BUcTChtfQLIe484YHx2uEl5Cm8I+X/qq
         Q42FP3qB3i6TVi+/FuBw04dpCUgAMVGrxWz1+MxrV1XWkYoruRu3/ajdw04aM9P4QCFp
         2kqa+dIcBWy/7fzzL4CBD7PIT/0G7FBChGN04yHhE4y8gLDJVxo9X44kfWYqof9Q3PXr
         IqeQ==
X-Gm-Message-State: AOJu0YzoxIE0sM7Gi4sbnfH7RwzCoOpSpaDKDBDX/MWCcVakgsVxlLXq
	/x+IImD4wGiqDWV2ZAaFvxYw1Isko51bhACz2h8gZCBQmhTH9AUulVJD6NfnA01HS1R4eP15FXD
	gEgt1E0r7LPX+FRoVun/TuP1SGZIgTVw6s+AJqOsn811OtuJYFW/NpV0=
X-Google-Smtp-Source: AGHT+IGBaqxn53uNErHOa1j4UTzFDRdyl+OoBSl1S7lW7oZquXgRtDDL7apYg8S4YQEzDKDvE6oVnCwTeK2GSsccHb8os9PxfYwU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214c:b0:375:a55e:f5fc with SMTP id
 e9e14a558f8ab-3763f5d9db7mr9883035ab.1.1719345303347; Tue, 25 Jun 2024
 12:55:03 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:55:03 -0700
In-Reply-To: <CAMc0M-8fr8AiyAK2Q_VUKnCAzB1e-TLfo1qbHvEYhj5zL4PVug@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d7474061bbc468e@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_sb_errors_from_cpu
From: syzbot <syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com

Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1790a501980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b9ee98d841760c
dashboard link: https://syzkaller.appspot.com/bug?extid=a2bc0e838efd7663f4d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1272faae980000

Note: testing is done by a robot and is best-effort only.

