Return-Path: <linux-kernel+bounces-398986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C59BF8EC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB79282AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8520C313;
	Wed,  6 Nov 2024 22:10:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEDE1DFE13
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931005; cv=none; b=Ww96RDV32CRLejB79LvzgVBTDLtv+QVjPGg6cgiP8zgxHSQqC96FWsiMwAZ5rg0MWQ9r0XZ/Kwexq+uJ6LoKIqsJXjH98jP3i2FbrmUTmUjHervhPgDZO7qOdUYYgwd7xPWAUBax2WimDlxHHLD2xVTv1BFO5KFILdwvb60Z+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931005; c=relaxed/simple;
	bh=ZDCq+S196X1oEZe/GjI0HBmW4W0Qjau2MkKtbK/A+3g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pxMiA/YfrnxewJyDvkG2mEpXZi0Uw1FEArpDeRmJR23ByLEjLOdlZYTsNsu0VtfjVNR7mlKT5cxQ212+vsLLI6MqwwySHsvUJOfMZTkNVrNtxRncdlVE5f6VjA0GUqBIt0xtyHi+xpwkLaeJbKHSViLs+OzvfP89O0eyB3NtQDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so4098645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 14:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730931003; x=1731535803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc/p+7snJhM6/YlTQIy1yUOBmqrmGxzfzfEeP866GUc=;
        b=a9N8NFU21axGIM8IGn/l+PMMwWyPcPImNrbu8y0M+oFmSGdEYXL+I6NexOU50mSgkV
         TSSArTp8ns5b4Q3fZ7oTiRfyscYBP2IXSok5QHvn1g/z9IAmbFntORpmY/YSILKKCGD5
         yvwh8s3QKtve+MQC+KFGvJOaXSHGYHzN0puq5eQ5TDsblbojIrWYdgpfd60+GMwEMkA+
         DTE6tAMrjIKSaYw01cMiIY0xHk3ewVm12ifHLN2wPEJ04vcRClovjIKrY9sybY93fSIr
         9Ms0hncw4gGKomm53GSnBaLS7ZrEqsPDLyrgN7VPtJPBTN+ieG1ZMDSgB6VHSmAdhmN4
         e82A==
X-Forwarded-Encrypted: i=1; AJvYcCW/FmvJQaAIs69rtiLnpR72QZ1KufMxzL4XlGWA7ZU57B7l+ei9jOlw+wyV8SQDO6sfh2v6jE3GsLNBEPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhp0K1A9caasyldqyN7LlrRW1uoNe5Htsev6Q0fpY9W1E8rplB
	gLSdp2o4nIKeoe8NiYxVPH7h6PILtfVHgUnz8SPQ3dwBy/kjsH2Juy1vY5XjGU+tCka71FKsP4a
	xkJ35TxeJNUaF0TaVC6nLcnG+Lp7n7iE55DL1jUk7vAu6LbZrqIV4Lsk=
X-Google-Smtp-Source: AGHT+IGA0N+fYg0ceNk/VmG5X0IIfpv364dj3EaK4JJ5MznsiNyj+5fT51/Q1iGdRIVJGz8AMXnPs9fGUy6Eo/50PQCZFzgyPDtq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a4:b0:3a6:c98d:86ac with SMTP id
 e9e14a558f8ab-3a6c98d8a5emr150122055ab.1.1730931002785; Wed, 06 Nov 2024
 14:10:02 -0800 (PST)
Date: Wed, 06 Nov 2024 14:10:02 -0800
In-Reply-To: <5e3c5bf9-5c8c-16cb-5b35-4fe57c636d65@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672be93a.050a0220.49393.016e.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in l2tp_exit_net
From: syzbot <syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com>
To: jchapman@katalix.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
Tested-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com

Tested on:

commit:         ccb35037 Merge branch 'net-lan969x-add-vcap-functional..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=170f8d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9d1c42858837b59
dashboard link: https://syzkaller.appspot.com/bug?extid=332fe1e67018625f63c9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e7b6a7980000

Note: testing is done by a robot and is best-effort only.

