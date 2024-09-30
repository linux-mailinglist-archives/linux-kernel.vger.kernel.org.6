Return-Path: <linux-kernel+bounces-343496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F9A989BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF841C215A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD515E5A6;
	Mon, 30 Sep 2024 07:38:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD015B0F2
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681909; cv=none; b=egCofj9hsmNKuVxsS0xjJOf3AawZae8T/EnKBZXr8S9lTbhlwUvHtA37Uy+sWdKg5Uh4seszUfbaganmnLys9XMDunHCzDsOzuOle8qljUlQMXXDcuohDokRWO5hQhgqFAKOuK2ArCdU2B1iKBYpibsMobkDkephOyMq8/rDQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681909; c=relaxed/simple;
	bh=Ci5gZ2/uPSu/oziTiVK6V8inA4emnWAXOmXiBnqWkrc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KK3EqEQzSJqdb29uQI4t0WihAMY9Jymz0crIgLawL1KC8jqLnAFa2qaK1mB1Q7OVt7BBgy3nZD/wUOK0gTVcyM6p0Q8rca2sMI4geaCADDtNAELffG4v17+luwP6/0eNZ6YAod/9NFdT7U3vjHqPzzFCS6PuptvEQxtPOiC3kDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-832160abde4so419764439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727681907; x=1728286707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxlMTOU2mzL+3rUriWACIZZLQuKPP8xQrF+zmKFQkJw=;
        b=D/9zwOZwOtp65UhIOB7pyvfCTX9xyGxVAAw6pW2lCgqN1TQ1jbhdOdgOV88B45ntO5
         9vFeAv2qHUtaWxTJ6fDfUsY1Ol7dtELoMK7H7/tJLkDtJDrf8oxalyie6NGDZDbIOugu
         64UBAt/NAozLO9AJRSQikYNKKgbOC5r+qW6qS2BYP+oLW5UTZlup+y2oAO/EyXLNJzeg
         5T8z8S+/m0+akR+ibbMnPSNfYKshLyRXMVAEKp9sEUpqsFztaeDzulr8waqBUrajW+An
         myYVzBvnBC46Z/3ACwPu4WII2ccAXum/4oTpcpauwCaQGhvtCWeiAK3oulaS8KgVVByS
         9M6g==
X-Forwarded-Encrypted: i=1; AJvYcCWmCtWeShhQZY8+pPPBebf7u2GjnuRcQMFqQsyYwJLH34cczxB3t5+MhQLqnPPWUddbz63Scemx9mE5ur0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ASK27iPmQHGeUhDAeg/EWmHOyNbbh0G6o/Z2b5Tc+06uuYl9
	T+FbTJe4/OLslbHYns5sxxFKVLhBYd6k+Y6mSfYp3r2hKSgAL1doSVu8aANaWi5Dcl/YU29Is9y
	ajjrIBUVF4Rg4/GGteJu8FsPPS8eU8HpyVUSZchiRCg5vnMS7/LcGKAU=
X-Google-Smtp-Source: AGHT+IE5jdf691+FBSsW7HKtfTkMdheschOcFT3XglMNkPfZNtemCPCQV7AOUEja9Ptj9WfXI4H8ES2sVDKtWyYFv3/yxn+1ko1l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:3a0:9238:d3c with SMTP id
 e9e14a558f8ab-3a3445ec927mr75425745ab.3.1727681907002; Mon, 30 Sep 2024
 00:38:27 -0700 (PDT)
Date: Mon, 30 Sep 2024 00:38:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa5572.050a0220.aab67.0029.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Sep 2024)
From: syzbot <syzbot+list812c5632ce6defff608a@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 32 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3220    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 273     Yes   kernel BUG in __iov_iter_get_pages_alloc
                  https://syzkaller.appspot.com/bug?extid=2fcb246021c963371c20
<3> 1       No    KASAN: use-after-free Read in p9pdu_vwritef
                  https://syzkaller.appspot.com/bug?extid=9e324cf5c0846336fefd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

