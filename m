Return-Path: <linux-kernel+bounces-187522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600548CD2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114391F21DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2BC14A4DD;
	Thu, 23 May 2024 12:58:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B778174C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469086; cv=none; b=QI0pugDOhKj62wm+qwvOw/WyFKHMT5m4QzE8CsiZBZuPdm3gz5kcgr2ZWBxmFANJaf0cpQX1RUVameasKpwAckw8DBYzOzNxnMK5rJXvew+bkZNQ4DcdBbzUhep5TRfdw3VRpIYpYUCFk/Vrok4OQMga1JUusuyCoWAigHhvLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469086; c=relaxed/simple;
	bh=bbSus61IPENCd63/yVddN6wUXqhHRUWd8Wd8rLl1FWY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BaMH3ya4S3lBYPAOCdHPJDZXHU4BoolAkDOEPoWNrXsPhm8GnDJQQyeLtV8M6qKxFfIeTW+xcJwdqdBga/44oElaXuqdFoy53l/mOl8dZSZGo2rCddAXynm9iGR9iG61Lq0Rkbn0mB6Cf4XrBKPQxuIaO5TMcpd5T1lDnbxhstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c74ef7261so20762405ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 05:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469084; x=1717073884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00aUEodfde1jONRp4lAPPFzzYhdOBLt8pgnc6kVNvis=;
        b=A1Sogke3Nfg8AmNDIZjwiWIKyV0KDEWzWMLSUzBnNE1nl8TaY2PVeYiaDxywKz+N3r
         3MnHl2ct4Il+54y8Zsy9Hj4b5sK9ppDOP2R6Jd9teiV+nj5+NXsPTlsxs0BMj+dLtOEN
         S0XKsy/biiO3U3gResAbSC/ouwCBxKVW0XpZV96PqERlnP3clHWj2md5nVQWS/zzHlB9
         XRj58NgUp7p3KMnVlop2v0jvH4Nj14qtB23kJ9lkzBrsesh/c4NGdQhzLub9U5rmGrLp
         NNzzRu9jzN9hjKSDq8HZ5Z3kWCn1BxpgI8VrO+CYUsn6MfkuX61vAvL+5O72/vbeaVPN
         /shQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbI6PrfuLh8IWuw9crPa+Q9JY2R8OAzg+0I/C3R9Vl/tC8X6Q3q0ksPAKtsozrHlNPtI92Ve9Adb1gkw0Nzux1QgzmS+Gpk1Ab65Ki
X-Gm-Message-State: AOJu0Yys6N3NjrsE+Ejz1gR4TPHLkJ15HfWnhqTm+V9BSB3PyffO5LrL
	0/VW+uxIQ9KHPQpdMtZtTDnQi0NTyB8VmhjM8530CsryyaAMOHerWlkI1S9BhG7+D5QG+8gPyj5
	/zDmyvX27q1mGZpLtewfSsttKS9IgWLazyISzif+C74BoO2NJTjNSqZ0=
X-Google-Smtp-Source: AGHT+IFlo32G3yL5vHTGnAePlWuaAvPcmq2p6c19AgKelnWb0GVuvwRm+qjtSKpWOY/Bmt+tbcqHVtoMWPIbpYDUGJyfUayQfT5g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:36d:b5df:f478 with SMTP id
 e9e14a558f8ab-371fc9cd989mr3921985ab.4.1716469083927; Thu, 23 May 2024
 05:58:03 -0700 (PDT)
Date: Thu, 23 May 2024 05:58:03 -0700
In-Reply-To: <tencent_4DA6DD13732376296683B4645AF76CB76205@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004089806191e9a51@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d87942980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133e9f7c980000

Note: testing is done by a robot and is best-effort only.

