Return-Path: <linux-kernel+bounces-308520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EF6965DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC418286BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C617B510;
	Fri, 30 Aug 2024 10:07:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C9316D302
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012425; cv=none; b=og5sLq1Hqth9mjuwbAnAruwOmaEktI+7HD4e3cOrI3c07SPCHBHrzR32Tabyn5pwmbEpko/7W3AoapmoWtKvF5hFSg98EQ7i+jd1lEa2KBZhlBdzepV24ThZTmtDEQerymqjuTm6S2WBa7qdtafAkGSCQ2DN3LD6gMiXB9t6rVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012425; c=relaxed/simple;
	bh=nCGHzPr7no29OU9XifApE4hSC4FsyPblzxKN3cnEP7Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SJ6UObXwSp9BgfTqnimzkHlzYl2x8jhOMVborx2G0PrWZcDazBx9DwbXWok4wJf8xfcrtA+hzxe85pUSMO3yh30qcVKRg2HGh5wL64KjPh8ZdHSZNDF6dhfM/ZYzqgP+QyEFhe3gOGnuLToMkKvl/Hh36IGOSvZrnx1TDTYBRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4cef7aa7so15459615ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012423; x=1725617223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utPgSMNFFt1LPXK+sGu+DpkRSi1qO0vq5GIBjOS5lXc=;
        b=ErZ72K2AmQgLRBDPgd0eyBSJX5jGFoghmll00ysAauTunZKmodMqLo5g+6gEpxw0DO
         0bc7jigcoaRUKVrhBx0yyDfZpeyoUspTKe/P3qsLVFozuOCuaSEohK2tHc57rsoZQ9Re
         QUAgpKUT2CMmsr/KZbnuykXbDr4Q07mqZ3bvq/s4cSgnScMF/nylCSMo1mj7JrEwEjyB
         QlKT8czc908F8+EP7VkCKv0I6Ai/rDySiHbZJtzbwbLkFuP94yD+h44cqHm289aUF51E
         /f7TJl/VzZ9Ib4l367mUp/wvUBxa+G2vBVFfv5mpcAi2gt2HXGVx44NnX4FBWRt0+ymz
         ETMQ==
X-Gm-Message-State: AOJu0YzhdDjqkujPAoCxu5AYtF37+kaBqMixZ/bEDSBY0GWWhrC5jw+7
	c3VZs400KCqtJvwDIKK7GWUQh0XZ5ZtTgj4Sg/JgUN91iy2yByHDdLUKDTyd6OOZMcQUIwgWpWA
	lpnTH/KC0zzrsSB68iS4fbb3tPmGzlAnB9TzrhQV5gTykMIX+Ia2n9wc=
X-Google-Smtp-Source: AGHT+IGafG/O29kKQHdLeYBi/fpguCa9/Q85ZodOwEnJtDVw5wxtVE9BvfI5ddgskefJP33CAApBHwtR0pbiBKvhOv58MomU7Y0R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39f40e1f884mr1594445ab.0.1725012422761; Fri, 30 Aug 2024
 03:07:02 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:07:02 -0700
In-Reply-To: <20240830092202.266992-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b13a150620e3c064@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_get_ordered_extents_for_logging
From: syzbot <syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com
Tested-by: syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com

Tested on:

commit:         20371ba1 Merge tag 'drm-fixes-2024-08-30' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f1608f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0455552d0b27491
dashboard link: https://syzkaller.appspot.com/bug?extid=4704b3cc972bd76024f1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179f1edb980000

Note: testing is done by a robot and is best-effort only.

