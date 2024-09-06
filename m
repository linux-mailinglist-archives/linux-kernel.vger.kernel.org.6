Return-Path: <linux-kernel+bounces-319536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B896FE16
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE0FB24B19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6E15B0F2;
	Fri,  6 Sep 2024 22:45:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244AB3612D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662704; cv=none; b=Fs1IjbyxOcqDE7wN7VUVwMeFN3E1MQpcLbHrm3Fo1BvnlwS+Q7GOAfVyFA9x74b4PG0G8MYP/F6mmFvGdA3+Cir/jZmugh5Bz9DD8IefUCmrXofLTwL1o+VySHmVObzOXMJ2UcUY0mV9527EeXMRlKHXNCee8urOBWh/gtIn6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662704; c=relaxed/simple;
	bh=8J91T6+0g+beF3geljjWtDOb+BKObrCgpP4cX5Q+tZk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Aqbg7VeDmw8YuVXOFvhS6Jg7Z+CCNCe6Ah1kCPjNiK6h0KS26aasCVLQIOG3z/aZZAR4e+YwB+e8iPw30e0YCy5VmBepNlgCbd5GZRxAkZeZE2F0751zT7ODpuzPe+Y/2434G+ZXfd+ivfvWmQ7Yp4G1ZijXysOxdWgfJOXBK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a492c9d88so527390739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 15:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725662702; x=1726267502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRgWmnR7uxjc65cAqAgk0UjOgG5A5PqPSZqQa+3EZ2Q=;
        b=azvFUgIbGTzflFtOCu6ifWLuHsczNCgI7juUUECPjYO/26xyj+2VDSKhvPnjX3vKU0
         oX6SWBzxJWAP4bIQLQMfRcGmC/n/MboF1p4cl8p2JJDkmSGeafpkY6My6XTQRt2zZnqQ
         /Ni5ec94DhdBOYQ6zP0Vh4G2Urh7sMfUFgYZYES8k1Up0RUweiMPbgrBUHyJ/YakKxeW
         si21ZONLDb9oQpEZDh/sE431f8p/K7J2PpF3lNm1JdNxYH/4HtCl8f+IS/Q5DfNzmCGr
         DUIqQWQcVEKZneZxfXyX0OrjJ4BXAAbu8VAt5RO4qcN8KVY1Ie05Lh58QwyGfKz5gf66
         5+DA==
X-Forwarded-Encrypted: i=1; AJvYcCXW4oSJft2vfofyI9TX5nljNwsC8Gt1f72AdxruTykmpWU73sYPOsyacE2kLlyJPm38ItCCtEvEb2kuWZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcoTLFhitAj4ZPsvqaS4cfMea2x988lsW5jPX6jJzrAqkIp/z
	DK3+F/paM+BW4vsW4MXtZKgUJREIbKAyGDOEOkkkJ+No9Vs6a5Y+RF6v6XBP/UUazYS5n23jRuz
	yCP7QlyAJXOMo9GVxtmaLHFPhAOb0jlZiBD93MyZNiDtCdmDCQVpNGcM=
X-Google-Smtp-Source: AGHT+IFqA9fMK742QQwzYjDsOeVkVXJcKjISB60SiHI/k2L8TrTH1fBBcL8EvOf3OrjhRjQbEWTp58lobOM9hLeOZomwN0RMMfbC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6c8e:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4d084ff3a53mr120378173.4.1725662702252; Fri, 06 Sep 2024
 15:45:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 15:45:02 -0700
In-Reply-To: <20240906221658.2144-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ec5bb06217b2833@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 lockref_get_not_dead (2)
From: syzbot <syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com
Tested-by: syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com

Tested on:

commit:         d759ee24 Merge tag 'net-6.11-rc7' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17816567980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=f82b36bffae7ef78b6a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16949200580000

Note: testing is done by a robot and is best-effort only.

