Return-Path: <linux-kernel+bounces-196363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290AC8D5AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BA91C218D3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8B8063B;
	Fri, 31 May 2024 06:48:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C98062A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138113; cv=none; b=u0fWS3pmF/iGHWYzKD7VEzgGqGKQeXJQeMR+b2lPX9j/sa+jqQGx5N+b4QpPLTB03XhR/D8ygd+xmFMv2V3XxYE0JSLiu2eXf7Hg9fuYJK8RB8HJ2oEtiuVBWkK+9aoVfne5mcHUQq/jWeYY3RBUhspXkK3E2JdDmlyhMHY8VSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138113; c=relaxed/simple;
	bh=5GuW+wAoVkqu7l6IeWMTnJH1fFp50EfL6Hps2dfh5SM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iRQyln4UKmUh6jTMJ4BrUVPmV1CfWhsAesvojX8Y+c2rLPk9S7MEAA8FmkezzuS+ESjqsikYNf/hJvNpnR3tVcv/2zdmjJd4Gc2xUfzR524gm61v4BujfyIFtAcUBUiHBxxTm/8d/WPsXWJYYyNepLnY03bzNEoeS8cfIeKQ85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e8e76ff0caso216522139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138110; x=1717742910;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYfXvnqsbrHi/Oc/r6FBi9UXCYN+odhEpQwDglNzhfs=;
        b=A4MyBzdAZGyN/Hb/D8Q0N+ftFXj+95TNIls2yLxUtotQhEWrC/UR4alCMOmZlvuVE9
         /jrL1ATx2xJPm9stkNrQznNz50BsSv86PZNAke6qHHtURvCOhdSaG/ajbOYNQZWYEYbf
         kMDsi4wmcjzoy8kzh8eVAKBvtB+CbVa95Thhsv28JCilUobnMhXeP5h0ILYcoZwC1Ais
         VJdae52JMAmlkonU35ibuE+aHwg2ToOl/+ITVIvkdp4xGhnQ6ZEDs+y54uk6biQdvmj1
         9nxxZPPairxqyA32MBGUqiZeGZ7AdpY0YWg4CKtaz1DTkyBGiDDCfi18zlsLF+G+lbZE
         1dVw==
X-Forwarded-Encrypted: i=1; AJvYcCWCFEHsBavj4dEfvijMAdFTD+TuiPUUnZjF9L3M3w7h35N7w8cj4UP+R3fELu23x1zNe0cgIfOTdAWbfBwHx6jYlR1wqCsjPO49hCUI
X-Gm-Message-State: AOJu0YzxTQUc0obpm+eHm4+bIIWwYgt8I+VAOJQCazBUydHzS8ZUOmg4
	vN75tuhJmbz99J4d+KCnX0+DEBoxBduuuCkmtKJmfgcrrQUw11bifNbqZzqFNY6oS3HyioJxmrI
	T4e/7i/dyeAlftGYR/0Xa6TtfmLX1fQMtTeZsKZQHM8MtzS8osSecmH4=
X-Google-Smtp-Source: AGHT+IHgoq8zW1aK/NNaJeL/+sF9RNDjZXoE48Ka+L7N6RuFoaLMJJzoDz4mrpWCTAiwUrFLT7X6GIMgj0l6/Pj9yVbeEcfhhO2z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:a381:0:b0:48a:37e1:a545 with SMTP id
 8926c6da1cb9f-4b5457ca427mr10532173.6.1717138110258; Thu, 30 May 2024
 23:48:30 -0700 (PDT)
Date: Thu, 30 May 2024 23:48:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017ad920619ba5fae@google.com>
Subject: [syzbot] Monthly gfs2 report (May 2024)
From: syzbot <syzbot+list32b4241e4e5ba670eb68@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 127508  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 804     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 342     No    possible deadlock in do_qc
                  https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
<4> 14      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<5> 4       Yes   WARNING in gfs2_ri_update (2)
                  https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

