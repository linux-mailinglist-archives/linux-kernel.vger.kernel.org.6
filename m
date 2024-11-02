Return-Path: <linux-kernel+bounces-393224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D029B9DF4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACACB21768
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DF0155336;
	Sat,  2 Nov 2024 08:46:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914B136351
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730537166; cv=none; b=L+02W4CDTehUPo9ZlanCx5Ke1GSyWYSfJ+/DU5Q8MqWfcyzRSGq+6lKs7G0xwxqqZL8D/udUAWUH6L7iTpHIRlYqQ3MPSpR7h7HM00glF7VFs4NlgWsGTknQJp/s3ffrheObtCe+tQPxzFydknVzGr2XeA2T3S9RCovkW+bIUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730537166; c=relaxed/simple;
	bh=alHqhlxZy9CHzA7FfvdFLVLYG/72RH1mK9Qy6u+wri0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uq++vo/JGypRxag3LNLZoZ0CLFGkMcBAospXUjb3HSW8OBOhHtNtlIyrsnRPnRjRx/gg095WFYiNU7WToUP2DJw9mU4Gt7Wls6uvLT4/KPQZqDQNBXbU9WmjHVbVAMXSgO2NjspM/cyXL0EpH9DS3GuxLk0kNa4HdnRmEXQ53KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abb2b6d42so249150039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 01:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730537164; x=1731141964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+COjwGQQuPgh7wKQd9KxiO9PxT6slG910E2O0t65Dno=;
        b=fmVzBKFHIDiYQvM2BhRWHuCJ7wauWloL6yy7jQeSjXvI92gYX0PnvNxz+kz6KItMu7
         2Bog4L8dSzMoni8h0tIgRyyBeXonmuqFX7AYy8lCAqan0VgnUiQ2HYRdOfG4cG90UaYL
         lmgbZstYTZ+tyitJMlSRQLb5CUC9midUlsUpKp1MCTj93nGQUJqHSlLRv/gqNTcb+NPo
         HbSXc2rLJssjDRBZ8TculWIrwp4C1OWt258qpLxsTscPVZ6P11i3Q+Mz1SOAP9Dy5FZ2
         GSJ2rnWCVK3gBLvlDq6hayofpa/RiGlVMzoMrocGUXTPG0gYmV89nawfsm3MWEOhcnkE
         3bSg==
X-Forwarded-Encrypted: i=1; AJvYcCV7MsoLJAhT65m9eH58XjcQlaclVMjolOdUD8DAo0e678BbrcAcOBzSIOsO9a79NmrrqWAQ5G1rl40/VTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrWhMOD9hRdkYXfmoCJvuui/5GbaaQrv9HfLBxPyHkzICXtdYT
	Pw3ykLNBPlxSgEd3vhP9in22JnMugsamcdAL4RNQroUUh5mWae4Zbamai5fOM3XiTGxeKKxkB6E
	Wnht0DgK/JFNGR1O9vAPnKoCl5qJD13vBah1RKmhAph5+5+Hu0l0m75U=
X-Google-Smtp-Source: AGHT+IHM/UkISB51RIfmM8lc4dSpOecjv1ES85q+rtccSmr68OsqKUOfUdWCNTz4hmHJwoLEd41NBMQCDtqvhB0UNSFJAGA0jQaL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1688:b0:3a6:be66:ce53 with SMTP id
 e9e14a558f8ab-3a6be66d4b1mr16498395ab.18.1730537163747; Sat, 02 Nov 2024
 01:46:03 -0700 (PDT)
Date: Sat, 02 Nov 2024 01:46:03 -0700
In-Reply-To: <tencent_F5D894DCE9D6EE76CF4C7BCE6CBC2FAD6E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6725e6cb.050a0220.529b6.028c.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
From: syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
Tested-by: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com

Tested on:

commit:         11066801 Merge tag 'linux_kselftest-fixes-6.12-rc6' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15802987980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6b0d046ffd0e9c1
dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1395b55f980000

Note: testing is done by a robot and is best-effort only.

