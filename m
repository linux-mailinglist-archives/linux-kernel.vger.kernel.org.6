Return-Path: <linux-kernel+bounces-342916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6709894CB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ADD1C20E08
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C013C918;
	Sun, 29 Sep 2024 10:31:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE337171
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727605865; cv=none; b=TwAfA8KwH5BiQ7hLe2GqZgMPBwGKo0JI6Dbkfr8Bq85AjrN6deyQZue2KhMpfP0lcjtOc7QUPuU0fQzh9qLe/3N9/uCWX4nlOUMhOBgvbrrNCfZO8XtEmNWsW/TUU+aOE34gUzY0Qu/Q2GSpAScVreiA39w1j+CpyzO+Z9AK2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727605865; c=relaxed/simple;
	bh=v0h4ietXfqL0/iTxvaLz23TyTcL+QXDS87rU9yDL8Ek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YQ4+brbXF/qTmuU79bDjsVXncWVs+VuVZ7nJnC994VjGTnkfWpvD4cynqwaaaaWw7c2+YQkuMIbjEbWbUPgS3XfBqyU1DWOMevsGdQFsumtnvaLNaaynvUbtU9kaCpdPS9O45M7SaSme9hzICz5iSJYydS68ECL6caiXtvrZxiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cfb2e416eso347850939f.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727605863; x=1728210663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+aWts5B3130eVNvfIu2VA/KRNwLQEVkdnMNxWWE3Dg=;
        b=DlDomm4ava1KEQZ8fvh/l/kM86L4Xb9UhHmpS+ie+fkhBCAdfysop4PjXd/ySrfikj
         aHLvYoL0+7tC+gAo0COlbPTICEDqulOuqJ2UsEjK0qZHuBK+vfnsW7qvpicnhx8v5JWS
         02yI1wCvWV6md32laoQRONZjLqBVoqJg+ZEPNADr8XqBR5oG1wXZEl7LCLEq3DyxPX4v
         tkIMIOntpTdWOIEJc0evwyljN8nMZuH7ifRxwFeh5/he8Fj3DZCaVZbd+GIwyiA0BNmx
         RvLUCR3dKlkIsUyz9NtvZZ6UbaWh436BPkvU+HAqfo9iILRhoPseG9P7+Cq11MbvCmM2
         jKuw==
X-Forwarded-Encrypted: i=1; AJvYcCUZaDNGnZ6Dm6LD1Y3oCBr5VtbsRXYJNT1jJrWWfZE5S9z+5G1HdR4mmGHGyxR7WZQVwwUHoUE2g7hNylc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXfYcPS5feIrMnScf3h+UAQhvzk5YADAFp9MHRyNk1OmrnzkQ
	Xyujpk/Et49gkhdD5/zktmPFZ2NUvfLxzpdmY49YpZrAfqYeQuWVzpucPp5oD/IkY2ZzqfT2yOM
	HnBQrgMjzqmpx9KxBIpCY5yKm/9TOdVwqukNA+5fVyu2VeIzDpDxJzI8=
X-Google-Smtp-Source: AGHT+IG86I+1DE2Z5otDQjjTsskZ5+bypVtmICl87PQj9nISUq7P9DVb6k6d/crF/9op5Um+4sBHtuN4rZkkR6FTdCZYzbl9zF1Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a2:463f:fd9e with SMTP id
 e9e14a558f8ab-3a345160ca8mr58482305ab.6.1727605863225; Sun, 29 Sep 2024
 03:31:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 03:31:03 -0700
In-Reply-To: <20240929092816.205431-1-dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f92c67.050a0220.aab67.0018.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
Tested-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com

Tested on:

commit:         d505d359 net: wwan: qcom_bam_dmux: Fix missing pm_runt..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11a1cd9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f49dd07427b3bf8
dashboard link: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fff6a9980000

Note: testing is done by a robot and is best-effort only.

