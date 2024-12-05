Return-Path: <linux-kernel+bounces-432833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE819E50DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB11F16B232
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C3A1DE2AC;
	Thu,  5 Dec 2024 09:07:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2031DDA36
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389650; cv=none; b=GM4tsab5RAw8sVqWD2aWpvj9HcV2forXqZmyaZpw81rPPDehFjx89g82mLOGc20nGhPRt1+DgzRPIj7n7Fqz9Oy4atmbg5YLOZ9OwdMSA9cDSbJ4S79mW0UsZogPoMddG+zOa+5tbAH9VEYpNpReNkmRKc/kAxUpxViTOpNk+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389650; c=relaxed/simple;
	bh=/o7rulEOMmEM63qzozE5OYyLL26cvsEyiLzEXWZ5/Gk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O1af5pTy0Obb2gu17csbV4T1/Spa/B8eZ4EuLDoeX9JQI72Md28jT7WMTFtsLgU376In6NGoJlMTd4VMTnEFhSfZqkywaW+Yc4NUC7akKSaMtAM8+4p2QIM3ABEMD79tR+/If+3r523g1ybO9dgglDcZCovvh8lJsEV5NIxOo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-843e5314cb8so55269839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389647; x=1733994447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdfhs6MEPSrhsH7kSPgh77gARjdDh/yQz65BJfBdd6g=;
        b=jd/AriNIDgs3pO5sqZD97ccWGSgQbFFkZiYdXkHvFRKmXYGC5Z4HujPG6soXjfgNw8
         sxT13bHD38IpHSooI66aAo4KR5kUNFw+Gh8vRYIh68bIoZVvMx1bPE4xxuOVZA2QLRFO
         PVY37TxCXPEpqfvKIW6Rnjr0mtMLcHmHcbRniHllRixDwdtIvbk8RW9XfnExaZE0ovsh
         wO6t/wEze6OlVI4md5dGhc4PlQ8pLxgT8inALPtaPblTMSM7GjvEEJ+G0RIs6HRF0vom
         1Sk0igO4jqMf0P8SZBjfIBIigyOAD3/KjJMkgtdGvGWPrEM8BtyyGk6gjVgRaJE7i+yA
         SCZA==
X-Forwarded-Encrypted: i=1; AJvYcCVnIRPythpq+wwDIkuMNTf9IxvN6HJ8f9I2HARl3iIdR7wKNzbfJgbQoYmuV47zuu5/3UMXu9U48gvKWMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcOCNri5YCxLSN+wT+k8idUhsWSzvjiX1EKZj/H12QTO1w6AT
	tXnbxnZ3BYGoduf+uIrb/qjn3gtRR4F8DxoMXKZ9oy9WZNpdEXITwzEELHH1YROaNBj8Be0oeUq
	ior0O9LrCHXvtDxDAI1F2KYt6QxY8fggxtzULEOW1XY3J/YLLNZFhbsM=
X-Google-Smtp-Source: AGHT+IEbVmcaA2agxb79Tmka2U+KOGZdRW6zI5+MW2smkxNHgIizPfWV+o/Id4tUZavjN78CF5tbTpekTpPshAcE3sQXLGUFivmN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2146:b0:3a7:e528:6edd with SMTP id
 e9e14a558f8ab-3a7f9a55af6mr118113795ab.12.1733389647682; Thu, 05 Dec 2024
 01:07:27 -0800 (PST)
Date: Thu, 05 Dec 2024 01:07:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516d4f.050a0220.17bd51.0091.GAE@google.com>
Subject: [syzbot] Monthly s390 report (Dec 2024)
From: syzbot <syzbot+list695771e1b19eaf02e5f2@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello s390 maintainers/developers,

This is a 31-day syzbot report for the s390 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/s390

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7345    Yes   possible deadlock in smc_switch_to_fallback (2)
                  https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<2> 2006    Yes   possible deadlock in smc_vlan_by_tcpsk
                  https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
<3> 105     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<4> 34      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
<5> 34      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<6> 8       Yes   Unable to handle kernel execute from non-executable memory at virtual address ADDR
                  https://syzkaller.appspot.com/bug?extid=8798e95c2e5511646dac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

