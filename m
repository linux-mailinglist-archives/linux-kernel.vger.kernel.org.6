Return-Path: <linux-kernel+bounces-334735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283497DB74
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E96E9B213EA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DA8489;
	Sat, 21 Sep 2024 02:28:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C622301
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726885685; cv=none; b=hdsOrZq+RBTJZw6lHDC1JGuPmfOQd+wGU0mQCYhWAvkVWg8ntoQI3Y1Jl6wJlxXnDmql944IOUUbCfF+DFYMQLENfmHYxK6IXzfvNCGBEhx4f17xEsB3ptmc7LJm9TpYimx0gZ+Ls/3kIqat1Yz0/wKhNZ5Ow2h2bt2O+qPOrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726885685; c=relaxed/simple;
	bh=Sf/yzFQmkJpemzBUSSHu8EYMjfz2GGlqtPerwLWt16s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jWu4VLw/SpO4GkDCuEAMTTGkfBi3jVn3s4hooNwmp4j7IE9HimZGDnwp+ssG2JGxZhJ60dDJFs1BAsmckukCJFIaX8tatE0opwtJEqLxH+sqXk7jLhxlnW7lGd+BGBoVO5Xwa/HjHJbeliPZcq3QEG4CYyAjz58foi2T12391dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5605c674so35933715ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 19:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726885683; x=1727490483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMaBaEBkg/OpyzN2Uqpyv+3f9rsnvjhbKblOU2k1UIY=;
        b=ELX8sDSFhUQNqGPA1kxRxf1HryygAz/r9jyMNf4DGTwkvQ8MEt4L0KPwtmfjg5oMwN
         DUPiUd/GUSb0zUFBNLaZwKLYOEFUmh7fTvfXZJK/MlSIGuD1lpX9rLaIQXthB+KQ7CSJ
         NZpDcXOkofoZyOSoLFU+uATsbIaiNEcWxWUE6oZBo9rhP1xkseNVmRe+wayjkYM28fag
         iSkDEonCJ/d2XnSHYjiX/U7UDFwKwDpKDYhZiYQBF8UpUD+lG19fw0scEYQ2ayLYK0vz
         HU/cYOYpY69j/KVArRjdBPD+8bxrz+q75XR1Pz5oZOYURfnHfkSAaQCrxFB6/qGNxAxN
         T82Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbEcKYviTnhWoE3jqvO0A5wzola3toXQmSi/CfUH9SJ+qL/bIQ+ABaeJZJmrGPJffG+NcuqjgRNwu3c08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DqURZ6/Mrf7Xgmv7kafmCAKMy0T0xKwe/n9GcH+CpqzOCjcW
	hqYHXB9quNienNHK301PLfRiJiQtBYCZQUF51JIfPa16hEQu2z+Auk8GKEMiNI4HWORJ0uMaIvU
	6aJK5YGEZwEXzfL2uRmhdGwT+UTM4okkfqMsZgWFLb2YoaYOMjdcJBTM=
X-Google-Smtp-Source: AGHT+IEBX0mqdaKQMXd3phHkA5Bo7NhLiKl7gSe+Czm+rTbLUAbFma0yjB0JcMYuUWElVfz8LxXmUdnVRWORvK/jjNt9gxUoUyj0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:3a0:b23a:81f2 with SMTP id
 e9e14a558f8ab-3a0c8ceaf88mr47172195ab.12.1726885682790; Fri, 20 Sep 2024
 19:28:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 19:28:02 -0700
In-Reply-To: <tencent_8A28BB01332A9E381B7A4BFB1BAB2512BA08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee2f32.050a0220.3195df.0025.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING: bad unlock balance in ocfs2_inode_cache_io_unlock
From: syzbot <syzbot+0e4e71041c9609d922a2@syzkaller.appspotmail.com>
To: eadavis@qq.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0e4e71041c9609d922a2@syzkaller.appspotmail.com
Tested-by: syzbot+0e4e71041c9609d922a2@syzkaller.appspotmail.com

Tested on:

commit:         5f567360 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1210ff00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=0e4e71041c9609d922a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107fcca9980000

Note: testing is done by a robot and is best-effort only.

