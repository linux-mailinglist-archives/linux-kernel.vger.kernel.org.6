Return-Path: <linux-kernel+bounces-253437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C0932159
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9E41F224AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BA54315F;
	Tue, 16 Jul 2024 07:38:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B844369
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115502; cv=none; b=An2gyHiYhMuMfwIpjqPSMs302zIxVkYiVYyjjCZtIOxC1S+pgxGf97vKvUQeEtKmd8L986H8VPFOhjgRugTizI1WFL+uy0CVvSvBxcmYiP33Y0U8oaxLKKNI83mx0fG+XvOZ4wjKWPGII177hmfVFNEbxVsTMGSDGwt/fxqorA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115502; c=relaxed/simple;
	bh=Bfr+2oqKDo2i4Pdo8nM2yUXYJf1UPSlRnL4MCq3zFOM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sBHchcZeXTQg/bydOn4qtIcasNzespyDnVZ6aTKh+VK1PUAalglJpdC7A3xnmsgpZx6HtqqGwHON3APZLLcCGTb0rh7ox7FvpcN+H4n9ZpTC6h+5c5J5tJf6gNSsnHXNkVOgDnjjEMVQMk0QC3AzkxaGGy+aY0PyXHgLQ23ddvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37642e69d7eso55798705ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721115500; x=1721720300;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9htk5aJgdqfYtz3ZfAD4q1FDJGfF5bTAzJYsn4qenQ=;
        b=dpTk0ZUaLhsKCLZxn12pyfYyW3ZRPbn/e27zSKIjs6n933qTBzTjHgrYUIL/BU48hb
         0wnK5FI6cDN5irXHLAVLQBr2KEcCoahWMTPNSwsgFOektyriPPJfSKrsaVK8hoSyoWGm
         OV02dh2jDSx2rurmMuVCR+zbh0Ju3wxAo5It2urWG7et7/iiB23SNpccv/Cy8bbYwc7Z
         kyJUW5Mzb8qqJcXIT0axpLLzydZiEJ+kEe4eL3Xmy0mWi2bJk+Or9OKcDYZuJmsgdlN/
         dtshI5v/ixb6q6sF5KFnU1LFR4nkViWvujBddxQ724iEj971Xtr69QM+J/6x0g3jHu+D
         MkvA==
X-Gm-Message-State: AOJu0Yzak1hymeNvRKCl9tLKBLWPdKzeF1wTT9KNc1QkpaDh0VWWJwkI
	xMlHCq0Au4tNvE3oULbV5b+Pl5d03E64/Guqsq+McKxNCLQpLDnZLuDZPFRWnqYUp10FI6nkBc8
	MQTlLqxQDccV1bqBlGdeLkFxsOGNgf15cei6dfjACP0LYlROwvWExwR0=
X-Google-Smtp-Source: AGHT+IF4Elg22B87swvQ1h2NhAnrhId43ftvWY/c9tmpolNBoybTkzjXI+4UZ1+mdQIP1RzKOeIqQMB+2/44dICtxnw58YIJKijV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:381:24e:7a8c with SMTP id
 e9e14a558f8ab-393d0e2328dmr1183045ab.1.1721115500231; Tue, 16 Jul 2024
 00:38:20 -0700 (PDT)
Date: Tue, 16 Jul 2024 00:38:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000024b79061d586e6d@google.com>
Subject: [syzbot] Monthly media report (Jul 2024)
From: syzbot <syzbot+list68e667ad3809de6c5bd7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 0 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 871     Yes   general protection fault in ir_raw_event_store_with_filter
                  https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<2> 101     Yes   WARNING in media_create_pad_link
                  https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
<3> 90      Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<4> 23      No    WARNING in call_s_stream
                  https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

