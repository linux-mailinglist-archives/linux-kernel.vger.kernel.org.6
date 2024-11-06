Return-Path: <linux-kernel+bounces-397818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71609BE105
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B59AB24D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE61D6199;
	Wed,  6 Nov 2024 08:33:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3081D54F2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882005; cv=none; b=bzsamciTeQyYEixNLomR0vamDXF1OhCuoXD9YtcEaeAb0Pqh+KJrReLUMeUc5WbB3gg5XjG1nFYB+YJka+TFKl14KvkY/HX+w7WtflhKT5mNzkJqbbWUitvOAFnSOJv1wlRIrVYpCyvJrDv/xgg3n0n4THZvNCtqFIafwUE+Yjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882005; c=relaxed/simple;
	bh=srY0MO3rROF+vBrxSFg9Wj/3PDJRSWSAUhQyqgFgbEU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CbiOHkU5PAtp1PradDyxdYayxozW+hhFn4hNBn1diGEV/phdY74rVfrtvo9wJraYNYbgGWZ+LVdLoIlVQNgGDSa0LHUL3lcZRrzDiQkNdHJUN+VXjZXoc+Fd0Ou6nRIkNOK0CW2GI8Ohn8x1vI6agJmQGXhhXiop8/dG28/sowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f3d7d13fso64221095ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882003; x=1731486803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDqGiM71xh6u3PCMqXYywGEC9WepRHBEgKYM5+6FC9M=;
        b=iKiyyMXOY9kg7MLpEAvflQZCsuATaVD400r5BUhyZQF2w/n19nZG1UKkaC/WqBwafi
         bpzEIGn7CfyoMWwAUH0XuotsoXVZsFetgg7KrhIU5RMSlSxy0ZCQLt/dxtYj9L1/jDSB
         LgwXRV0BQMgP5hJj8uvR+Aeg+5wMukb9Xf4O0VZq0iHyC73A/USeBoXLR4Np04HPRqK7
         PXTad9e4f6t/SjUnYw5OiFAUNB8vPPP6XFN5Ja8esqCIK1annPdZdTqSk+9/2bPZ9lcx
         6qBZg4rtm07pry3QeN/H9BvczRCqFWl5DQnddX1IXAksuSWaai4oAVmD910woSycU678
         XcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8UBsgkb0cF7zlkOtNspTkgC2NbB28u0fTwrdkH5bMs1k/blzTPBJ1B1LveYqDzD+B2Z6yD48y1Wb36Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UBkGjU9bOn+T5e/fwM8Gg1M50A8jsUVpGheTUQGPIqncfwqI
	4IxckjDkKQm+DT4PKXr9kaEJTaQIJro5gC7B0pYEmh8h+sNT+rGa1x3RhJa97wixQKWTjd6JTQA
	hbLh2uxnNtolRr5C/yQVnAiR4LAFniTD6xWDqSYDpQuoKuLdXGvGs6rU=
X-Google-Smtp-Source: AGHT+IE8KZeleEjuLmuInfhLaaZMkmgoez7AXY4X/DOyUbKT8c8IVtH+y5AxOjNtelvN4MnvmIOO1fs0SwC4tXMLFPmMU4fzUu/v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a4:b0:3a6:c98d:86ac with SMTP id
 e9e14a558f8ab-3a6c98d8a5emr122268955ab.1.1730882003462; Wed, 06 Nov 2024
 00:33:23 -0800 (PST)
Date: Wed, 06 Nov 2024 00:33:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b29d3.050a0220.2a847.1ba5.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Nov 2024)
From: syzbot <syzbot+list4e5402cbee6a192e1e9e@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 1 new issues were detected and 1 were fixed.
In total, 3 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 403     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 23      Yes   KMSAN: uninit-value in ima_add_template_entry (2)
                  https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
<3> 1       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

