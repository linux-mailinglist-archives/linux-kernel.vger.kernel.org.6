Return-Path: <linux-kernel+bounces-397826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C09BE119
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4F4282606
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F761D95A8;
	Wed,  6 Nov 2024 08:35:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD011D7E42
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882128; cv=none; b=MrgIIKPzJCBXD+Lz767Jj0ppMpP+E8QrlqRiRmZX4tdk1IP6RnDM0mlmlRH6s16zAV1QmVaF8370BqYbo5s/f2fEyFYXOXyeiMGZWmda9dEt/vQg2v9f/OLsNiA2JIw6qPBeDudPmcm75SaESA+Alb3lnPSl+rQYgwOT7BAIuW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882128; c=relaxed/simple;
	bh=t1WaeZXqfAVXlpn/npu+nVOQn/Vs3v7N64kfTPZodSk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UXNI1QMAwmtA3FYXBLm+jZM2OjY6yJz64F4erfImKzXyHGMQ03Uq3VmmD/IdcvKX66mkwU3dyx8pV3IPGcauAOnwMpF8Jwe3wvu6AsCEVxtndQR2sQXMEc02NvP0LkggV13S3aMFElyxk/sqaKW7z61WGqsYTW2dFWXhWz0oBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b7974696so51355685ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882126; x=1731486926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnB8xawJVTltgiDGSn+8C3xEi2E88CR1AX+Gfs41VwY=;
        b=HCPE4bKa57/P7/lI9mZ0C4l0iRsPea/ceqCovcyHY5t+Ef60c760FOWRGGgeuQeaYG
         kUTMNVgj+tnSp1Eca1BpSK6T022/H1/9rcfZnPpw4MT8dBFtkjLNw/VCLZQKlVNuvFM5
         3bjUDRCMQgx5FllKX90m7BvFaCZHJAoOdG+pBrK6sZObjwyS9MXpaVo5IUliERYYjcgQ
         ucTtFrHZ66s2L/fjYrvXzG3KHEJVinvhkTb3t2G6MjVZ6sOmpS+zY0TH6FW3oE9qVfkm
         o3eAwkGlcBEDX7sILWwDySKMcKbNHpruJIXZbwgHt9wu/Khfgft9OkVesCZKHiDmq1QA
         22Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWMFK6OB1wwyR184Mk49xZMT7mypiHUl2lPl78emRhQKf2JPTcZz+rU3USkeTo0FHPdHw8Wxl/Gt1GfbJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd4SZyd5b1WwkkW6YPYtS9n5bMFlL+7o4M7QenkriPGrhSMqjz
	GdC1IwaIoNOihJsMQ1L/P8BoBihQEwXgh2JZs5iA61hnTRa/pk3jaXmlIoqBqATvwgU7N2OUWGp
	lT3j6Xne1atjIxb1R2tEXPwqTKLh2hyT/DMZH3Xj6K5+PCzJulCt+1kg=
X-Google-Smtp-Source: AGHT+IHh+rwwTLIISK3Gu5Vo3+mBgFl2ihCHw0zNl+TBlvaH7OVlYqPaskk0ZWCGb/oOB9AzjziAzuQYtsnaF2TOMXo3O7MxUApN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a6b02fbee5mr181857015ab.15.1730882125968; Wed, 06 Nov 2024
 00:35:25 -0800 (PST)
Date: Wed, 06 Nov 2024 00:35:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b2a4d.050a0220.2edce.1521.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Nov 2024)
From: syzbot <syzbot+list0e9829fc16403a65ac7f@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 3 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 17 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3108    Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<2> 1835    No    INFO: task hung in exfat_sync_fs
                  https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
<3> 17      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

