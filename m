Return-Path: <linux-kernel+bounces-284788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FB5950521
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0537F285388
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026DB19D075;
	Tue, 13 Aug 2024 12:34:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7219D06D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552468; cv=none; b=fBsRL9xMPCxJLB3m5ikE1i5PkjjfD1+uGyJetDnDol7XlZ0VbfnVtsGRtuLuZ92JFP7Vr1/VNzDbIkzQExGmNd43bJZPUCcrYDMQOggqts4OFkSJLAueeA+Nm4xhaXv9NqLkVnZQCuMvx8QAMk8EHQ8K2Ak4z5G0PvcbMLEJ1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552468; c=relaxed/simple;
	bh=MWYYWzrLBsyhsepfViZZe+n7+XEy4XisBYxo3KCbwNg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ppY4VGLO+DrHteswpGgMeE5n6mcgNfnYnnT2A3BdxNse5ABxKsf6OM7TkjZ0ehAbY6puMBMydoIjupG6NCOCIHOCTHVjLvS3nB5fXtUcnEBrm9fBMaRLUTmV5lVKajvWyZ8WVGv4SpWbdDe3PzUiixvwVU+svABRmy/wBACi39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82237159a6bso644378239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552466; x=1724157266;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+Ln620VT8KH54iQCrLjkomNkv6MG80t0C+1+yo30Yg=;
        b=LxiNhA3yMrSn7vL7M58Jv1n5roD6ZeNvL6EDLwoKEfdVxgfKkV9Sa2MueDzooF3FXd
         Eb+Pxm/0rHr6Ob9//Kd1W5aD+cNEZUnC/VJnizeUm9EbjVcbo6mc4cz4wuwW+XdfZLos
         O7fOpmNIi3iS+4iF1fV3AtA5EjJ1Wo1JmoRmRW/+f5TABPbpSzpD6CN7uduF/gj25Pzw
         IxljW/iA8RXZweB4yqXj8m1ITqeXO9MYjhR8zgoZpn+oiNarhuCI1sOs9vmI+nlA5pz5
         /+EQjTpDaSj8nHqkuyMmlBGSt83NFvpqXPKXj+Sc0RjUgPzJD+1s5CwzVwjgj3QpoQ1A
         CwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwWdtNN3tEIv6P0GPTERYEfb2frR4SXmCMzQhGcq87+aZOPb/bwdN4lbzZYhP55PCH/0AbWo0HizmSgHDXYdp4OuR6l7Jf0Y9kXOnT
X-Gm-Message-State: AOJu0YwheqieFm6R6tt/9qNqwJAdUDHRTqOS0EsUvcMKruUXfBj+UEiK
	xiOui470c2dd37SJRZCkW7AzbQwwXMXts9+MgcLYJt32vS6TOt/XRnnodEHJAMQibXtBS0sMm0W
	77hitbkGn5BPl7XgKArpE1h+vFvDlhczfDyp+tLaLibdK4fEnUHJ9pJo=
X-Google-Smtp-Source: AGHT+IG3UXOsj7iMlJPd1YaGKTgrI5WP18qFBGO56hVK54vUBxVZD+3+WCWnv+apxl+45UkIn8nKCfEWOmoKOaIfDmC4Py0tCjDB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:396:256a:2e01 with SMTP id
 e9e14a558f8ab-39c48c1647dmr1582815ab.1.1723552466282; Tue, 13 Aug 2024
 05:34:26 -0700 (PDT)
Date: Tue, 13 Aug 2024 05:34:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000813aa7061f8fd478@google.com>
Subject: [syzbot] Monthly serial report (Aug 2024)
From: syzbot <syzbot+list6032cdf2de475380d173@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 288     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2> 141     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<3> 4       No    KMSAN: uninit-value in gsmld_receive_buf
                  https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<4> 2       No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                  https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

