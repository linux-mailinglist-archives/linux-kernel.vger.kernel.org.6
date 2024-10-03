Return-Path: <linux-kernel+bounces-348800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB77C98EC00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8528EB21142
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F22A145A1E;
	Thu,  3 Oct 2024 09:02:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC15F45BE3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727946145; cv=none; b=lbZ+JmO1YqVc1ogwaeATrxyqFtF1ZGt3fjabCMIC016kW1J2E2GvrYOx+F/osGjk3PsGCllAvzYdWfwfFEj7KJDpeVrDQMcTdzDemXAZrQQ75F2hxFDvGiG2qFGCUphLjCC/gH4rYdJdyDEyb/3XJavIXkJbF5K5qNTpsVhC8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727946145; c=relaxed/simple;
	bh=8/nQIZ6fj8ITsgS6yTlTQWgW+WMSXYAQOpyKO3Sd6Yg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V9wFtamp5/rKcwdkbeOVz4UmVh9uQgAz243chdUPrLLOlO8hACmVFk2Fs9vkuOskLHTImwZZbCLfHWiz4taYRl2aJGmW1ffK/6S+T3vcenT4c7ytjXOHMDgwsJVy7JdWo3FFEc5eJirNUjmFefhPo0n1Ilu6yGWlfdpXNFaHHlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a348ebb940so7739485ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 02:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727946143; x=1728550943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqfylRwsz28ZZV/UyHXdo5HEK9xLCqxEq+YXbQIkIKA=;
        b=pxJ9A2EvnTGfTCkyyioxeIQ9BPKv1YHTww0Ppq45os+rDzz/EUdzx89K15gnhXVOBl
         dOVRBFmZDizflKMD1B+X53c0FEY4cG/LX/sNGi0Ee+tLzjyCKfEDf+RV7L7ASSrIpoeY
         pZwiSBKS0PGd5pKBDaOJJ+OXLnMFosXU9WMVglEHh8n2Npqa0yb+9NHutgAE47lBGbDN
         1PSsfbLCVTX3e99uTxchrKdsuCTJ4rKMdm4kMs2IPPSXW9NUJBf5klYWKL+h6PK5C8+Q
         +SprzY5CNX11Q5dgVZRR9hg3ZQnKHsjJ2eVRn2CN6WdgMQMBO182LyCE7t9DZk5ka+Sf
         RlSg==
X-Gm-Message-State: AOJu0YyoPWCAtqfx6uzjFxHFUc4pChIrpaFhkKME9BwtUfX66bSRyjV0
	AU2Ie3mg0FlRVKbeHe32Tq6HcAWORXLH1+ELyPZC0nW8Pd6f6D/Aeteq7M5bxAb3k1rWRyDFHci
	8FvK66avTKVITm/NpE8URqA4yKTaESkIzNrgisdvcPOyqzwzO0OBtZLU=
X-Google-Smtp-Source: AGHT+IFH02MTzPhgEaZvbiHMRs/Zs0x6OkBbTB4Q/J/BhoR/MU08i5VVdxC72X+cDoou7gnA325GQoJonqzqzO5FzJazHQQO/rBs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:58e:b0:3a3:6b20:5e33 with SMTP id
 e9e14a558f8ab-3a36b206039mr28193155ab.12.1727946142814; Thu, 03 Oct 2024
 02:02:22 -0700 (PDT)
Date: Thu, 03 Oct 2024 02:02:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fe5d9e.050a0220.28a3b.020d.GAE@google.com>
Subject: [syzbot] Monthly mm report (Oct 2024)
From: syzbot <syzbot+liste8e8a93665e01bff6e87@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 10 new issues were detected and 4 were fixed.
In total, 79 issues are still open and 263 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10299   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7383    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  2612    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<4>  2189    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<5>  1579    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<6>  679     Yes   possible deadlock in gup_fast_fallback
                   https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
<7>  559     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<8>  460     Yes   INFO: task hung in _vm_unmap_aliases (3)
                   https://syzkaller.appspot.com/bug?extid=fe8f8efd070d727de971
<9>  289     No    KCSAN: data-race in __filemap_remove_folio / folio_mapping (2)
                   https://syzkaller.appspot.com/bug?extid=606f94dfeaaa45124c90
<10> 287     No    WARNING: locking bug in __schedule
                   https://syzkaller.appspot.com/bug?extid=46b40e354b532433eeef

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

