Return-Path: <linux-kernel+bounces-416785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA86B9D4A37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB0A1F220C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515851A9B42;
	Thu, 21 Nov 2024 09:50:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E61531E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182626; cv=none; b=WX02e6y+ZNm+s5gznEPw/HkY7ocGMyKMPg/xTmYwiIiOXBeBDh5JQqLQUqM51A16pQUzCBP47qmk6XPqQcKipawBHq4204d5YnECHoaoHtZhkjrlxrrk4WAxFyNsuQ62s0YHeGzIwqu4Ll86Ty8f6cyKiCg/ELsWPXXRNWV40T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182626; c=relaxed/simple;
	bh=FGO4BeVUMYEZDZMkjtSlonZAZx9UMN+rpetz3/zATz8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qb0Uy23/C55NlhWzWDKYAJwWh8yBZ0wwJFCIPp0k49qc9mSjZ1wvxijuVzTJgG6ifUd9Bs5uxjrKXJX8y4gGKtYlffgKhAVuCnUy9JRgcIpQkAu0hMpNbj8Gvifdnr9bOMFBnVWYwnkp5wyDAsWG9AYCHUAOLk/Mh3802NWkJrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso7812855ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732182623; x=1732787423;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yG5fYqoFl0t1IHX9mlRsDbQlnWfhNBQhEGosyFvJw70=;
        b=kq+6o//YFV8/oi6BDKWFklVHynl6iLaji3eVgIuohuKD/qfZRX+8K7yQgaaWVl54cF
         6BB1uA/TmaEWrt8hXwTsFVhILGchItKRabVkfIGF/l8sHw0UJ2yoXNKFI6QlcLOhC9lT
         gKGV4ujEQoUJpkVLJqCyZoTOINYlA817/SEMjUcUOGi654h/QSBu6wkHlY4NdIKKHVpK
         oJ3Zqxoz3LrlGti9UHO75mKA8+3vUwkX2OrdjnEEsrfstvmKtbDE7K1qa5T5JiblbVu6
         IlNXSJ+zvnCANL+nlatT66vMM5M8PyW2SF2hXmvcr3M7dQ6wBx/mnSfrir0ibM+SC4pL
         JVPw==
X-Gm-Message-State: AOJu0Yxzi4kWkx4yn8ThzY0EwWaH5SPJq3Zol8uYVfSSmbzsvQypaXNz
	ypSaS5biHyb59FqkVoENfbzdtRJcFiDKRWCoIKnmoH9QmQVv1wdVbWkaXFwZGer3iUNN4p+/PtF
	wowcatvPCngojUuoFzZEq21UrUHgBYnO3aqBZtcp0enHJsduGaeZyC7E=
X-Google-Smtp-Source: AGHT+IGfDDjmHUsUK18fbFKl8h22zJyn+fThfcuo/Q4Kz6URLxQGTP83WTonaRZ22t++zCV1b+0tIV7ZvxVgZpgSfMFKeuZEzUFT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ae:b0:3a7:819c:5129 with SMTP id
 e9e14a558f8ab-3a786574454mr63939175ab.18.1732182623685; Thu, 21 Nov 2024
 01:50:23 -0800 (PST)
Date: Thu, 21 Nov 2024 01:50:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673f025f.050a0220.363a1b.00fa.GAE@google.com>
Subject: [syzbot] Monthly netfs report (Nov 2024)
From: syzbot <syzbot+list7a6f269bbee45c565136@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfs maintainers/developers,

This is a 31-day syzbot report for the netfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 1 has already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 58      Yes   KASAN: slab-use-after-free Read in iov_iter_revert
                  https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
<2> 4       Yes   kernel BUG in iov_iter_revert (2)
                  https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
<3> 1       No    WARNING in netfs_writepages
                  https://syzkaller.appspot.com/bug?extid=06023121b0153752a3d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

