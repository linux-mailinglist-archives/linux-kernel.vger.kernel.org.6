Return-Path: <linux-kernel+bounces-236034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A27E91DC98
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC451F238BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087B156F5B;
	Mon,  1 Jul 2024 10:27:21 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E45155A30
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829640; cv=none; b=Kv4ObTNphRvLA2vvnexh5fSxveOG+3Z2vW9oof5sVvwR+MB/LEPLBbXZlpj6ejKU3s0RSYy7kJueQBENdz+ghhBZON0abmqj3TFUqJ2qpJesOXM8wdBvCVMm8PyN7+ArB22grTCoaO5jmVICnDDtxAiYA9MJ9Raf5pfbVzpkfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829640; c=relaxed/simple;
	bh=Y0qZIvU3876rhcbNcn0n71jnqgpzrYheC/iR+xhreng=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a9XKMfzDuZwLn6I4SAz34m3GypBn6eqhuiPwC9vDSPJx+lOTd15D91b0W4WkE/Zhf85BlQc6pmu2YmQXj0/Mx49eRHeaZCwkZmJuUaOBNLnWZrwrZVyv717DYR7ZBx2FZ7X/LGldtXcqmfD3NN7P7AQfsVL2TxT2nvK/+q23zEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f61f43caa9so263377639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829638; x=1720434438;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f3GXA7uhKwZE0H98n2mKoXilFcX8QW2muoSJ9YrNyXk=;
        b=ljOx0LAaj4aecaFXlaYmnONyIbveSyJu8t9zI2eTkcdMnKX03dFIxBCNtP35NENCIg
         bvf3TJsQ9Yeca0+CeljrB3yBPFK9ANxlOzrq4qj1NFUk/EhZqIztid+3IIe3SM2iPZTc
         Tjt21ti32YGJXQbe6zv0gwfC7Sl6xKqj8utENxiZZRlyFQbZ2de6MkLzUvpCCXQ5EDVP
         qvq/2xsyrCWJ7aIfxirc3SAd0m+y5hdZfQ5txxrWSZ4da/Eze66I443pkRFhaAGFvUMh
         xmzt6mwUhNbbkfOF8kt6G6RPxrB/Zr2K43e6AFdL9DxYl6kYBVClVXtw9lP0UEcZ3ZzY
         Wceg==
X-Forwarded-Encrypted: i=1; AJvYcCX4vhXywIi7+CB16lSvM6sepyoaqbMuw6fAoNxJX9QCOeEHgvsX/Ws26aFL0qZUCjqghZx0+R+9/EfUWQJo6nQOXThMibaQ9WcG/FX+
X-Gm-Message-State: AOJu0YymzbAulaw2nj+ANsfDt9bsPQ3i+AbXieIVenv45KlndPyiM6GV
	b/baDiwVbgDTMZK9nIca0SG2dw0g2VHW+322F4V41/xNqh0mUyBUV0WSAuOSaVXIyuYIB+Gd3i5
	hRSzrphXgHOZK808SsEYZHlfVVTxLVMloo7ObAw9Ste2606PN4Yqjqao=
X-Google-Smtp-Source: AGHT+IHTaDrwjDf7ugCew8VjD/72J/605lf6z5TepBofMHBh1zZLWLbP2TODGpGmpDOmIQcVrfigq0cFq+ZRmqX+BpEkD2WfmaxZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8b:b0:7f6:28ed:efe5 with SMTP id
 ca18e2360f4ac-7f62ee8869bmr46169139f.2.1719829638731; Mon, 01 Jul 2024
 03:27:18 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:27:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0e95a061c2d0a52@google.com>
Subject: [syzbot] Monthly gfs2 report (Jul 2024)
From: syzbot <syzbot+lista20f3f55f8bdd22e24c3@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 264883  Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 2677    Yes   WARNING: locking bug in gfs2_fill_super
                  https://syzkaller.appspot.com/bug?extid=ee157488ade46c021ef4
<3> 1266    Yes   BUG: corrupted list in gfs2_fill_super
                  https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
<4> 1196    Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<5> 584     No    possible deadlock in do_qc
                  https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
<6> 14      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

