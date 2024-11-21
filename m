Return-Path: <linux-kernel+bounces-417007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4489D4D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AEB1F2232D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A61D90B6;
	Thu, 21 Nov 2024 13:13:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2741D86F2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194808; cv=none; b=ZJeskl6Cc+dBOASRxbXfB+kdswRFfU7xlW8HSqR45JIGFSvF5JV+dfoQEbzXAZmyI74TwlwLvKcByo6a/THrVhAWBa6WZyXfvlMlPPdiNIDwumvbnLi1VfKQjeTfGVUCPIDPkbLCpws7I9BdD2Mp5/OHfGygB+GYBPaIECDr4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194808; c=relaxed/simple;
	bh=mlh0bylkAm0ifIvx1L8aJUhGU24UbG3qrWP5TY+9Vos=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=exxVEVQnwVQrwMdOSBoLh8gzsbnjaFDMxgwYCXov4giCnIHSpIMe/qK4DqjWk7fpArmthSB+pS42Eo5RymsUNDnqBhzgBeZs7Ps/wx6iOFDBTsPdcZhA0xgCU7meYzgXs/WhfwCH9/WKY/MBhsy/SeU/l4YZ/7hboUj0hRBWpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a768b62268so9062675ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732194806; x=1732799606;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOWHR+6cZm9nrsSvHH6bPy3TZe9GkM6yhS+PqixliyA=;
        b=fSW9+FXPCS5QgZyk79SHGIaOuzFTTDP5TKahMP8Hm9VNipY6T/txn38Pe+QihWM64Z
         /v3GD5UxenkjdhhB4CMYLA5oyBpGc65BQh49kf+pl73CAew0Pr8eGTi8foHr9IvncVC9
         X81ub9HV94cb0lEd60ZNKKUGLMRy5HYHxaxU1D94TPKrQJuCCLSrc+h6LltCK22lSi8V
         J2+pekDC4eE0TAoG2c9Ni07opiS0XmsthC8DpEumMA1EVzCkcRXqg4McYaG7/QG6QpP4
         uL4jqZ+S8JGIQjlPVaDndW7KCB0iiX5F9CMsV+ICO2fNCMSXSYdudK0CutPUcqKmjrdC
         uNCg==
X-Forwarded-Encrypted: i=1; AJvYcCWorvHRbowgw5FBfLYwvBW7pC2A2hLnaOLqkY3emJTGVe2MSs4G3A8d4gRudQT6g5X9NquR+kSqRG6Hjwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/qh1xiI6z0IhJciyvPuSXWS3lpopWze83yvXg4iXI6zRwLHA
	xaOidsx1+SsSQWx/b+hs6+8OgOxutgYcN4trGCfq1JD3t7vHksmaa5uMK8289sS4zoy9hg1Kbg3
	0IzpP9v3ksSHra4Xzt6jFSGkF6js82zqDpj4r8SSZLTFQBPQPkFY+qsg=
X-Google-Smtp-Source: AGHT+IGFEBt3e/K+uovLH/gxLg2jsIfyHVP3nAy08FHlw1Fj9XF7+NFLkATQ9PZtp3iRlVkadJUOPFwpB1vNiLG1ojoIGCMIsx/K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:3a7:7124:bd2c with SMTP id
 e9e14a558f8ab-3a7865814dfmr75048325ab.19.1732194806328; Thu, 21 Nov 2024
 05:13:26 -0800 (PST)
Date: Thu, 21 Nov 2024 05:13:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673f31f6.050a0220.3c9d61.0172.GAE@google.com>
Subject: [syzbot] Monthly perf report (Nov 2024)
From: syzbot <syzbot+list5bde034aa3d7a5a8ec4d@syzkaller.appspotmail.com>
To: acme@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello perf maintainers/developers,

This is a 31-day syzbot report for the perf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/perf

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3720    Yes   WARNING: suspicious RCU usage in get_callchain_entry
                  https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
<2> 5       No    KCSAN: data-race in _free_event / perf_pending_task (2)
                  https://syzkaller.appspot.com/bug?extid=e75157f5b04f8ff40e17
<3> 1       Yes   INFO: task hung in _free_event
                  https://syzkaller.appspot.com/bug?extid=3c4321e10eea460eb606

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

