Return-Path: <linux-kernel+bounces-419057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2859D6902
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C9E4B218F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C824F1EA6F;
	Sat, 23 Nov 2024 12:32:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5578F62
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732365126; cv=none; b=fbuXpaPYDevQV/NUD1/7xu/EGExekrG2JcVm6Xaro8d6Ew/0vbzLoPLJc2HEZKctuVRelq/qRFLnTFtCKr6jmi4/wld0BqhwWFb2NR8Fvaauj5wVtDgVwtWALGyTpe5KM21XF5Rm9hAN2v1aRbFYJFLlN+lp9bRGmf6m/g5JhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732365126; c=relaxed/simple;
	bh=sqFt6fZGJdnGMh2iMK8p7DWsFb23tErII3wIs8rEvtE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r2W5J8FBg93j9t+PcPyfw0h2o5qO+Szv9G2hRIxsnAhUv/sjSN0+GHZAppDpbhKYvKpeN4unKCOX2Hfl8dC48NGsEugUqFab5/mu/tSuZ37eRafd62GmQLXL9v+wc2mlWIOvw9obxjDao5KXqstpyq7lDDDTjBr/iDFjkGiGvMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abef51173so320510039f.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 04:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732365124; x=1732969924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/+xGT+4zxnqA1DJvffqxc3A2/w01vuiwspLiy7elRU=;
        b=Ipg4M7XkokFpzb3ytq2+7XRMmOFYCWYGuCETJWVSyL949OsqprBudj+2J7W2sKerWL
         GDPdM9Ar7vbR1Yo9qCeVxnu4J5MMQ1B/fbNuRSp33iWHrbBgqJaTYAH9qXoWcEcBs4Z9
         w0Qd9Zd2a3apb1nRdiWQaGfA2vJEWz0q7Qw9wV7PBzy/qfrU/+yo1MfouGQTuIiUPX3g
         1RKHQ27WOzyNk+RH8BhJKz281h0TexKe5zknzgpnugIQ5BQG0mGfH8mMANQ2sRHw83t/
         iL2/IRYreJUtq6L2g9jZidK4TLUQMmtJ3e5q4y9YUtBL6dvvSGtDMFVZx87nEvL7TSQZ
         zLLg==
X-Gm-Message-State: AOJu0Yz9OfrDRUbPS6QPt6dJp7wbjieAAz5cvk3XGYbCdy9ZT7bRlNYS
	vAq+qpQ3dD5YV6Kfi5VAxRQh2lFBZWm+oZA7A16FdsHMYWYKCq+z12MbE5dqoenGyTv9WaSERaz
	RKbmWzP8lZounFrGlPhe51cfaC8YW5+S7Eelo68mcH24+awM+XYKGma0=
X-Google-Smtp-Source: AGHT+IG84q8zUbZsePCUMjw3ufxU75CcN7U5qemanjqFCXt96q8d95YRFPfOM79ZAKgh+OOKXoU1KEUP+lYDzOuu5yDCptJEz3B+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3a79ad5ba54mr64563945ab.11.1732365124159; Sat, 23 Nov 2024
 04:32:04 -0800 (PST)
Date: Sat, 23 Nov 2024 04:32:04 -0800
In-Reply-To: <4fa33a28-7cda-47d8-be4c-238e022406e9@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741cb44.050a0220.1cc393.000b.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

Tested on:

commit:         adc21867 Linux 6.12
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.12
console output: https://syzkaller.appspot.com/x/log.txt?x=12b77930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff82e14879b6fef5
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146f36e8580000

Note: testing is done by a robot and is best-effort only.

