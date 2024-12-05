Return-Path: <linux-kernel+bounces-433269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCE29E55C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8807D284DA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A88218AC2;
	Thu,  5 Dec 2024 12:46:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D321767C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402765; cv=none; b=ZLB81egAe3qRItueshmLT5JiLIVx+ZSiYpt/hJCTBPzjjMvhrM+3PygTzg7qdSZs67O5/d7H/DniZDAz5LzVwZC/UbAn9954hYllgC/zHhYq+eF19gaZXT8/VvuLLZxg0ALpAclpC2xjYrk4yXsnpoB4iDjYPyp1bGrkkEK7VMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402765; c=relaxed/simple;
	bh=eImJIpIF/KSB4uiwTOn7hdKg77lgYoGfVOXw0Hhbj5Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tu9HXFuKp5T95O790uPGkk73Gxzi6MGJqNCdZzAVn8YvMAU5GTIbATc9Huyj9sr0fTTVmHQEKLbGUdiCfRz2LyDK4DV37u5cYrAJvwoC34Ql77CU27EBbfF4FNZN2G5U2FQa1KhW3bOae1tb9TqmAguhLiGbkJbxPctHbFs9Jas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so18311685ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733402763; x=1734007563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0iaCAPdaKa9qoLnGhVA0Z5j3Ik/H4wNtiMhCICR7/8=;
        b=uY6fyLTEsvyWDltOWPd2Y2Z6H314sa2lNdqcESj1E9KhzaFzCevwEBU5jHzixyZTcI
         /fhCYuBo/qOYYYM4H+jGXOlmXgM9KODDzADTwnFMzEuc6BhveDl9AdTLpUunkooHm0nz
         77cUUGnwaI3ZC8sbpy9+hihCn0YfmHvbjaI6BgH8T0z4b7cDO2I2bdLnkrjlXwLwBJ5v
         NcLZoxV/4/hHPoJ26rvBcxnDdEtfaO0iPSGUT/jU4j7UjYuGDIkMCzH8wBMHI/QNirD6
         Mnt1UIImeZBKfu6BDmcJsz0NXLevFYDmzg8U0KGfX3XzHRqAJMWrlykLro0t5W45UKx5
         jRjw==
X-Forwarded-Encrypted: i=1; AJvYcCWlgZcCqR6/J3d7od8JxEDh+jYgXrq2HMFfK6tficjrkFCOeLTjOIci4IFXnxWuYSm4u9iEYz3+aaf9iZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mj7fnvOCHYMqR4FwZgV5ACL9+zocHPaX4GydSSt4WkyRBbfU
	FyBBfUN1yFOaYCT2evAbZgzS/DdD6+yUCTtf3PgeS300V8vZzfmPiyoVZdOnG9u+pBZUUHq9i5q
	nySOJqHyj4WKT3KUFjL6mJOh1iy40mVz8xF1yty1uNBc3mFfixhnUrxk=
X-Google-Smtp-Source: AGHT+IFTvRfKxh9O+0cvI5lb/BT7auEzA7r36ebWM+MMTsGUSosowkPGFsx5Ci7/GOAOsm1aaFjR8MlQwx95i0rRr2TuoXxlTcy2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:3a7:e069:95e0 with SMTP id
 e9e14a558f8ab-3a807576882mr27752645ab.1.1733402763106; Thu, 05 Dec 2024
 04:46:03 -0800 (PST)
Date: Thu, 05 Dec 2024 04:46:03 -0800
In-Reply-To: <20241205123216.2354-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751a08b.050a0220.17bd51.00a1.GAE@google.com>
Subject: Re: [syzbot] [scsi?] possible deadlock in balance_pgdat (2)
From: syzbot <syzbot+ac962f01776f0d739973@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         c018ec9d block: rnull: Initialize the module in place
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-6.14/block
console output: https://syzkaller.appspot.com/x/log.txt?x=17441330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6851fe4f61792030
dashboard link: https://syzkaller.appspot.com/bug?extid=ac962f01776f0d739973
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

