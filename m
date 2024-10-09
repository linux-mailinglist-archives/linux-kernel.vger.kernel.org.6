Return-Path: <linux-kernel+bounces-358030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E290997968
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9AACB230D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F831922C4;
	Wed,  9 Oct 2024 23:56:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B729149C4F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518165; cv=none; b=MoXLCtrnyjidd+RjdiQGURV97KW94Tdy2eMVYI2t+a+ByKSHQCDteRcDPPF8hNdoQenRW1TjSZuKk8Nxpm4onBSN8gK7LnREux4ECF9jlu95zCIhc5xYjIZdQQ/u/9xl+AOkaGrZiANMFuKCgpV+oUUHI+KyChCRZ74OL9RFakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518165; c=relaxed/simple;
	bh=iuFCy56Oq6Fkh46Z7lDxc4hbrSQO5grvkxbQ+GpRUMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NHB/zDsA/wDQGB0RuFimpkUjvdVU9rsyfsPjPlvzfxvAr0OcETkWP5Gvo3BBmbQZJcwqlcho4Ay1KwUAcMcI/jfgERvtfwazxK9NJ69be7aWZ6bWJnT96B4+AN/wPY3OeCxJkooBw8abk9JtGKP00YV34eAE7AHXg+Jwkafmxsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a344da7987so4508685ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 16:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518163; x=1729122963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/FfdGOVz36J7B1YaBjbT2FiMwpL5OA+SdCSaGVXrTM=;
        b=VhZG41jjVYlNPmoYTQ2+uLOtlbOc9DAWRjmjHbR+hCio0ITZaom584DmWETWj+JUrQ
         xfW6u+Y/ybeE8s29IV6T1JBWFiwmc7IAGC2TXtW6E9iyHQ+BcKxyUFYJ0k1Tq3eTV1+G
         2JJeCME4i6Go3/A/WWWLIkpvzpGUhRwtKOHZ/lDpBTBAVB7qxnBVtAYl3QH9bD0FpSZu
         904cX8t9e5lArW22hKZrRilUF5qFvtAD1h7ZwvK0RHs9XRul1uwgOmqc4XVZ/hAtWK54
         Kp6RJK0sB5vBwCrWn0lMaLPOAyUUPZvOWHBuK7pjw1W+ByqGGFq8V5jJB7iCz2TVf6qS
         mE0Q==
X-Gm-Message-State: AOJu0YxBap3wt2Kl4+BHGcuMX7Gqi0XZpNdDoeIrDlDegI7jQ1bmvWmV
	Z36xuLHz+nDV794rIlJt4erFkaOsoOIV92i2nDGtjH/SNy6Tq3ydqDQKbW13vkiuypqKht8lMrK
	N9SR1OjSYk84SDYrIunxMFPqy0RKm9Ipsh/BF7djEWJKtbj6SFsR1m1M=
X-Google-Smtp-Source: AGHT+IGQTCpz3WGRkCzTt0e9q3R1Itc3U2sUAp5y05fPouyBDeznkzM/Vt14L0L3Ed0Bcb9ZvMwcN1OpOUykygeGrqvDfGQkAGpq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a0:8eb3:5154 with SMTP id
 e9e14a558f8ab-3a3a5c96a9amr17639395ab.4.1728518163387; Wed, 09 Oct 2024
 16:56:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 16:56:03 -0700
In-Reply-To: <5c32f5f5-476f-4693-8698-3af5d29d726b@sandeen.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67071813.050a0220.1139e6.0011.GAE@google.com>
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
From: syzbot <syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sandeen@sandeen.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com
Tested-by: syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com

Tested on:

commit:         ffcd06b6 hfs: convert hfs to use the new mount api
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10798f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=43eee68ed9712f80
dashboard link: https://syzkaller.appspot.com/bug?extid=5cfa9ffce7cc5744fe24
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

