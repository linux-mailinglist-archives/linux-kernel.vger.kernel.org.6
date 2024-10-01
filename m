Return-Path: <linux-kernel+bounces-345080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F60998B1BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240171F222E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EFB67D;
	Tue,  1 Oct 2024 01:20:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379D63C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745606; cv=none; b=QTtTydt8E5vG0/TYj/PkbYkny9CYbSiKrt3QI3bsqEG1Z8x25P0NK9OOkDKs8KPyQbNaHOqqLfD+z8wE4e+fM5qZeXA05XNveexXrfNrJ0G+zcsHPhO3M5O5jBarn1GkOqWBmswsbzS0VSoqXt4UT03fLXxsxtQP930nIXD+5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745606; c=relaxed/simple;
	bh=/TCFAXIJEXjwlBnPnSzugwHuLyLp5eJRcH7VmMEzqik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XL5WHr6OP4kWUFEmpJNgSpbkJOVmSduDevKdu9onrKMeagv6Xoexu21na+WMvl2m/su0UnQDFemSk7Q6d5fvWvdNgIGPnHepkpboVdHTFO4NmeAumlu7hLnDj1J6KFvhrJ4gikbmN9qUWINfWgBMX3BcpP7lBvhgWyEhkOxG5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cea2c4e35so625412739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745604; x=1728350404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwyRuKxX/otJecMs2zZ2G+Y7WFxKAcGZEjxsLsP1Fow=;
        b=sawhgoAov9fE7XoqfOa0M1nkCwcgmDBT1rC8FC/0MFczATxWvaLJnlWxEy3thzwbzM
         hB3gaZkqcDdvR99lkaYEvlfbisxhvUl6SZCCOeT5fZmyjgRzBF2kvSR422CRvjfqyv63
         tGsPRvUec0SZRcRRW+U5wixJWRcyvV06hYQDLbmhdhWU9z2cY+ovEbMBBsgJDJQbAb42
         hgDMg+vZNdcL/k24ed0/a0c4iWEeJjcyC2PoiCwrlz38bbW4tdh7fMShKSuAhM1CDwso
         uQwxezHpc9Y2r4AmK+wtPLriEVjc3FcXlvE3yTtWpy8W8LeLtRosKjbUscr4DYAATrLS
         oEjw==
X-Forwarded-Encrypted: i=1; AJvYcCXEAaF9sqrlu+HL50dB6+V3sNqmY7gtzTY/KCBH+LfO7m1x9N++6MJXBf9I3VnX8knz91myxlmg/9KVero=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1OZggyUfHLcisqP/e9MIeL3AlavCy4tGMXWSGN3yR9McRriA0
	oSReuy6HP5XF3e9z30kKGSWLy/MEWZCQglyZeZDT9K43DFYAwj/CZl+ZlFsUUUozkund/EEQGxU
	CI6+ObvGSHZj9P1i0Pw7UL/WX0gYkXdatZao0T+WatnYTx7q7eHCYsz8=
X-Google-Smtp-Source: AGHT+IEMeivzsVt/aZUxIwl42QDayN5BHBtKgwqPTEYVsP7JkFR9MqkfdaIIFh8+QCg+J9G+fhBB/rn6cS5Lq2W4JiUv2g1UjlkS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:3a1:a163:ba64 with SMTP id
 e9e14a558f8ab-3a34515057fmr107664135ab.3.1727745603863; Mon, 30 Sep 2024
 18:20:03 -0700 (PDT)
Date: Mon, 30 Sep 2024 18:20:03 -0700
In-Reply-To: <CAGiJo8TzPyoxUoTV=48uowQPPywbCZ6X1fRRF5KGYFJyhkY5_A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fb4e43.050a0220.aab67.003c.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
From: syzbot <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Tested-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com

Tested on:

commit:         c824deb1 cxgb4: clip_tbl: Fix spelling mistake "wont" ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17aaf127980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10257d07980000

Note: testing is done by a robot and is best-effort only.

