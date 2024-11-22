Return-Path: <linux-kernel+bounces-418540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02A9D62CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1778D16075C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B471DE8BE;
	Fri, 22 Nov 2024 17:13:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7E18AEA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732295585; cv=none; b=sIxlC5mV+YgkRyrLr1d61swJ/Idos4PYEJDxWkXR3Tt0Wp4arbzcIscvO3y9YKCIY9BYGhdfX90NJ/ix76V5l2EWDQfGiqpoFCGMMEovsmlG88M5G88dlVyw++wuUOpEqoTAF+6vDmwOltRdzvXp1c5C3b/4EB5yJHx6luJe0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732295585; c=relaxed/simple;
	bh=0dySRWOEt2cA6kbJOPbnGdnnK/6lUdfAdQGgf/JpW1A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dKV2MFDUVxA9QUFw/N3Y+UJQ0AEAsM97CxNnzNNTTam7m+oDs9wcYT9sMRnSqqljBvbfBva1aEUmtTtpWrSPokyVnnBGekwuCvbzbtr4PJI5abHlxVYT83BKkFucTha4mKeAfz2OTLXVRMzYTvfHbKwgKMFvGK+MgmxWZ3v0xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b7974696so30237445ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732295583; x=1732900383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNkV2K0yI0nr0L0trPpw5OZF25ru/yAYFG5AyZEPHzs=;
        b=BYWkLuLHbccUYbrv+Ie4WP50+n4dlJilhhfVisBcUlZmFCVtIRrDiB1/4hN76FAlCl
         7ECb7X9/xAheBeJ5hoDwI9h54AhYVXnbEKYJyLE79hwUO6nx0sVwCapkWpxshu0Tm94o
         q8ammfhHJSfei9gl5YqupUMSs61zxWNtJ2FMcXCENMpDEGHVUEq/u/c3ctFjgyfGqVPo
         OnX3KUFyaxeMxONvXUrlb0yfaNsrTKOE0lNd7cG8NA1R6jDqF1IrSJ1uYT6QByR4nFuk
         2lw9lK/KHoEhNSwU9edGr6/VjSrk2P3gid5GjyxT8G4zOc/gfie8zkq7FhQQlTFssT/y
         Nivg==
X-Forwarded-Encrypted: i=1; AJvYcCVwzBiCmYvJp7nGBgD4sQ3XYos9dkQ+76z7Xf/JeHUVZyFfpbYSsGsl/a5p8Dvs+Au4L44NtjEBoFN8RnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ZoNFZxnx7GvcFR9p4cX/t7fTBY/BkLXnAokTCWJg1PWObgRV
	zZqGIG2k8VT6ac16Qn5Vczc1ETyYtNUjfm6YAhhakOtUTuZG9iIXhk4vkk6CqBPZ10/jFFyyca1
	hP2ARjNvmeN0i7UDTIxSwtW7UXSJJul/rSPxDHECa0gCse4+5sXvT7cA=
X-Google-Smtp-Source: AGHT+IEk3JJHzPuaVmI+sg1Zh+eggMHrBez4gsVLN4FpI34Thfdr7hgicsHStez7h83NdXGy5KJM1aQj6d1+R2b4HHRLMrBl7z25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a79ad10db6mr45827015ab.2.1732295583554; Fri, 22 Nov 2024
 09:13:03 -0800 (PST)
Date: Fri, 22 Nov 2024 09:13:03 -0800
In-Reply-To: <CAPXz4EOcrGyLkp9XGn8-XgzfuebuW5=AdR72hP8Qf2hK0DrHcw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740bb9f.050a0220.363a1b.0149.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: bretznic@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ext4/ext4.h
patch: **** malformed patch at line 6: diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c




Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca2f08f822652bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b6db78580000


