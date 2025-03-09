Return-Path: <linux-kernel+bounces-553044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB165A582D1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA03188AC49
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BE71B3943;
	Sun,  9 Mar 2025 09:51:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B41B2EF2
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741513864; cv=none; b=XmU/jsfkKAaM3TX8APuTtszLkzV71wKK1fMlKeAw+LefP3osDEK5eU+GhQtWOvIW1SSXsYd7mwyPYEad6DH+osbDdLCeRt41HY/tPBo9mudh0ZCd3ueLZSfq58ps+3qwLVmAakAfwn5Jp8gszCZXE0jfXuHM6iS2iWOhE+nOVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741513864; c=relaxed/simple;
	bh=G8aqMWVSaw6yzkbrIolOTk+kwZj499uEpYCtfFb/mEA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pUXrXKDySf6LoQjIrX/ijuUlGb0JF4UVQwTZh6hjomhF9JVdzf9uvnIEe9ebXSnFPe7bBYfti8JHEndjVEVEqZBzv52Nnw5Q4UtpeF11zL3YBG4B4YLmThaa3bG+qSJfVRhxDCBeMzrgoVmowwNY3NGORlQoWPQf3k3A6WZareM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85aec8c9633so675034939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741513862; x=1742118662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vobFlyI0UQEeXRjeOzCF8M4VWtXlPFUwz8UDJwB2YXU=;
        b=QGnWyL/KeJS6ag7VWNIseV6ghhXeJdUeiZMFgYlGGtPbJN1YUpcuWimzlr+cOykdCc
         LkbJFz34qEY/tVB0GKub9m2tGlq7scj5ILe/30uiXc8m2WUOgS7F6ImJ10x9fCpDmjsr
         Gkuz5pwXxkFP/lp2ks4v7J8q57TwGa1ONKQQJGv0YSrm5EZd66/63XYTtxukzZ8Csgz4
         vZ+zPWUsZiOcuxkzUUotakhDuFptkdIj3hIUZiD4/AGZxuGo7nx1mViwbPsbjAFUep4P
         ZeY6khjy5x5vGkdsDvjak/1lixLv51O0BeNUr0jh5hKXsdoZju8/KtvKfgbiGdigxdxq
         xOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCURfzpJ/dtihjCLWJcsOYdcBUqlUWZAQfWK/d6Od25QDDA66yo/cDkqftt1F9v62/XmUNV3qD+FhtQZzlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUhVvDik1Rii+BO7RbwIsQv9xAsGiW9Og9ZBs6vwVGACLUn4t7
	xgXFn+33NLBVyV+P9NoeUHGe9e1MW2bGDrSYgawdo5ARBXTxCAn/KpluC4rTIBAkxX488Iwqo8p
	QoXD2fsaZQXwB6Lz6473ZZvsJ/TuEPy4PliFfg3pWDn5onADMISvc8bs=
X-Google-Smtp-Source: AGHT+IH15FrsK1lvK/QpLL2NdAnSlTXlBCmUpSXbTz7TEE9K0VG2GwGeFTO/nm6OCVtT3bzbA4pXgWAOQQStsslHOsRXO1QkOuJ+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198e:b0:3d4:36da:19a1 with SMTP id
 e9e14a558f8ab-3d44193ed4fmr135204135ab.21.1741513862338; Sun, 09 Mar 2025
 01:51:02 -0800 (PST)
Date: Sun, 09 Mar 2025 01:51:02 -0800
In-Reply-To: <20250309092120.3184-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd6486.050a0220.24a339.00c8.GAE@google.com>
Subject: Re: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
From: syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com
Tested-by: syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com

Tested on:

commit:         1110ce6a Merge tag 'mm-hotfixes-stable-2025-03-08-16-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14541fa0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb3000d0159783f
dashboard link: https://syzkaller.appspot.com/bug?extid=019072ad24ab1d948228
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103ad878580000

Note: testing is done by a robot and is best-effort only.

