Return-Path: <linux-kernel+bounces-358000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72736997912
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9D91F23725
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811021E32A6;
	Wed,  9 Oct 2024 23:23:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD914169397
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516185; cv=none; b=Lxyv4a6/i/8Ei6JzOzA1tJ11vdyYQhNS/F85r50bwx7VafnEQm+vHlvmNH/oeOuzQktq7ZL2CC3O8weyLwApUls7QIZpDB6w3nxkXRMO6Ha9v8Z22xTLARh1xpALmTU1/VhzBqCqpxPPOW2W2DXu4p7sfTOiDGFiW997xK9KlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516185; c=relaxed/simple;
	bh=eo4Ymx/StZp5RW6GC+CgoSyMj82eS6wutLVMkcP9wOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nOQNJZ/QVoQs8CvWQGBDjGcXihqR5fW0s2wFAn0OKPM8DvAwYDt7ORqkhQ8AKzaDykjPlHh1T1A4+8VGvwkqkdDYniyqGahuqNQdkrsWpC/AqX+1PVQa9uFTKrthvTBLg5h94M6jlSzXQdIzYTLtdMa9QnoPGg8wLIC1UQxqcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34eef9ec9so3921645ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 16:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728516183; x=1729120983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUC8UPunWg8uHAeVxmpOOlMXguSRHS39bG0R/9ufmTc=;
        b=Ttxe4k8Bz0RrUOqfIXMsoVuLaFTzXNwL5tez0NvuUf30BNffAIBvkDX//Hf5JaCfWi
         EAlrCNIxCcC0JWOf/Fva47CM9Mhd+8jJGCUBGteC0VwMms47q4lhrG3q8Qk/m9vJutkF
         fhOhc8kDuLYN/P0ZEbKE+D/fU35AxIfYT2VGI9Kim38T7sNA/1/GV5hHkXKlD+pGT2rI
         fEB8bWGXx+fSBosOVhpKvDeEhf8Mk7jukgtSWAIzv/OiHqHbhNckvt8icnFE1S8zmrEM
         aKasDP1EDPYFhqfDdtToKfHJBy/pLgwISM0sM4mmcrQ7pgzbF3yCvxKIX3u57vyz9gpM
         0i2g==
X-Gm-Message-State: AOJu0YyL8ZOBlMK7yCuoecZ/C3BCrdmaVE18iCQWHwpEgAdvcWzpuZ+F
	ZMbQs7A9A5RzsgVM/ZWnxOPs6ENAMOUIjpVSfyXGpW6epw7lCTKap4n7l1XheajNNJ0eFZnNqkt
	sYY+x4HhXg1qF9O+fxb3gRZjJuWowMMDjrC/zQMDIkSjMSHrZ3KP2ttE=
X-Google-Smtp-Source: AGHT+IH51j1hZKiurrugW/rvtajJ8Yvk9MCM7SAwnXLi5Hj07KxaR9DZjNSPmsMN3+AJMA1WwSZ/Oi3QV64VdQfqio2B6eaG99rz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a397cee009mr40778675ab.15.1728516182896; Wed, 09 Oct 2024
 16:23:02 -0700 (PDT)
Date: Wed, 09 Oct 2024 16:23:02 -0700
In-Reply-To: <65233b0c-cf11-4ef6-957c-e0434742d6e8@sandeen.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67071056.050a0220.67064.0056.GAE@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend
From: syzbot <syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sandeen@sandeen.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/10/09 23:22:11 ignoring optional flag "type"="gce"
2024/10/09 23:22:11 parsed 1 programs
2024/10/09 23:22:11 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         ffcd06b6 hfs: convert hfs to use the new mount api
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17b18f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8420a89323bff217
dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

