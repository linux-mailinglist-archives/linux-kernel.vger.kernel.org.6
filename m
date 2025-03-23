Return-Path: <linux-kernel+bounces-572714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF47A6CDAE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 03:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9FE4189E983
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 02:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DDC142E83;
	Sun, 23 Mar 2025 02:26:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3111C84D5
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696788; cv=none; b=HNlTixGZUIsWWemPrDaDTQfo7uG0XkbT9nCpfDmpc2oFHqt8213pzkXLulxxR5WXffJ9CMhPRjNDaGN20m1GU6x48nvX5sgXcjJdtCEostSvKlzw+QQLARfGLHeTNLZzp1xzJvCLjwefgEeeksdyCaxSqbCEXuIr/Ben//MIwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696788; c=relaxed/simple;
	bh=k4n0+uoNAzxhKlB7OaiZaHgSrTsXF6p6omBAIXUMSQM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zr9mizlHoxdIroZui2iUABpMAGm2iB+aCBXuaTT7dnk/eErHcX7/+Pd9oUPPUlaCej3Ly0WzsM22GZlGkbN8pesjlojpDdSUboEIISm1tkwvyV8G+CCRu7A4UJm6as7BcLghQUAd2OscgwDpmbXk2fGYnTx7SaOoL/L/lu4ppYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5875e250so378819239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 19:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742696786; x=1743301586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUNBikr2xQNyLCafvTGfD0aOwk+e7KdAUoUyDL7ErA8=;
        b=w36Cx1DhBFCE8ZOcP0/bFb3u+q+qYcKRyiklpG6efPJOeBIthpcyouwnu2Byqh8LTU
         HbaCVpUbQF/rZMigamPqXnnAY7uSmrcGy7ELKpPVsBUmQCRJ7O77NTFGTHFuo2aj2/Mt
         CeZUlZioZByiYCAjdf71wMdiUjPkzMCmEJo6OYiEiOqiUkIUWmvBkj+dCZaeKRs/ay8a
         6JDvVe7/bSCQ20fxGK9HxFeqaYf/HpqU/DoTC/e9uh39Y5BWzp5JSp5YxGwoSvao0Tdt
         SStD6hlL0ibRUx55/QQcPlbmE+fGKCCaVBCGxt7KIoSBNz0l+h4XfIRZ+d9/pFVl9I4o
         OoBw==
X-Forwarded-Encrypted: i=1; AJvYcCW9k17Qt7YJ/mX36gJpw1k9Xg3IaCFxRHCNTE3cbfvdT8GFJ5hLJlZzsftltoTnIP/5SqbeBYg7sRbkJEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFVg460oIGNa8NuJYc36TWEPliVSJPc6WGjkQbYxErvb+lYT7
	2/TkYqpCcB3vZvzLWpvVIhf3wJnjOxLcoCPdLaarJqp4lCHalTS7tomE/rZKEQhPV8YBPza0sg5
	xYrvk+6FrkU6+R5yYykjOscAox+CFEV3MR9groSnTmFNuBmfCL9gQ4Gk=
X-Google-Smtp-Source: AGHT+IFLDbsK4tdgOd/gBuvSpcuQKoOXd5WkzAvuCgTSC39xvBsVcO00hLGjB4AFeB2ZwieR2TJ7LPSyxuFqEjuL/luLAyYEYPov
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d86:b0:3d0:443d:a5c3 with SMTP id
 e9e14a558f8ab-3d5960c1226mr90044505ab.3.1742696786058; Sat, 22 Mar 2025
 19:26:26 -0700 (PDT)
Date: Sat, 22 Mar 2025 19:26:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67df7152.050a0220.31a16b.0052.GAE@google.com>
Subject: [syzbot] Monthly udf report (Mar 2025)
From: syzbot <syzbot+list0da90758116753ae8b54@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 9292    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 992     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 271     Yes   possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
<4> 34      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<5> 22      Yes   KASAN: use-after-free Read in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=8743fca924afed42f93e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

