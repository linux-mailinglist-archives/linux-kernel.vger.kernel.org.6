Return-Path: <linux-kernel+bounces-386920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A19B49B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645A81C209AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933DA4C8F;
	Tue, 29 Oct 2024 12:31:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DBE621
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205066; cv=none; b=KWoSZQ/TR+a6sl1enyolw5fGSGMYVnt+VOZqfOmzgIo/bbrhDZbxVdeB4wnwXmmbNpXWSdJcfmlHy8LTD5FXkYUL9rbBccNqEfPcJjwry6ibEevPo+G41FOJKdbAHAfo56IT1PESpVYArFDiW0WBD45dH1Tb83bdc9XbWiOXDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205066; c=relaxed/simple;
	bh=u/4XRxxy5K/sOYURUQRSstzHYs7gRPUYSUirE3eSVGQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l6TpuDeLF+0AQe/L1zXghhpXrp32ma+YyncwY0bQPMCirvQwKhWCJoJt7Yir0PC9Zu/H0isOlL8LM3241VuNIN+GZxiB6NsQ+o0N8wxVtvpADV0nx7yJDo9l8ycUXKWOIX/uoBxyjiQCHMXuI6lb+FcuWVwkTF9XcMfEX44KOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f01d43c0so24104435ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205063; x=1730809863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Co9AO4JFXy8gDr579wogsrvW4Pw+5N+pTZ7bC5R335I=;
        b=axuhi8BO9VoszW2m7cO5p3nvCXqcUIXmFY5+w8MTrgjAhTaXI2trrBX7Ir1GyHDYgc
         NdN+7fKvhKmz8Uhmtv+pKNeKfHfqD0PttPqaFDBHBRcJX1WyWYTaF88/r4wyf2hDqxI+
         LG9XNuLAmC4a35Hae7eL921/67viRDnARjAWxv0O10HSENQinSCfjFv7a67Pjbie+6L/
         stukk5MK1fsHutCGwfBh0dC34IluZYb6zKb5vz12nWUxRUlepmapXMLdFVZwW03vRHQM
         CXWGTMib7pd0cWoW7/6tq+p6RijQUBeAGSc7xE402pJTkIbaCvYP0e1LH0T6vDcw70lZ
         5fJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9QKXlVp34RldfevfR1Y83FtDJ0RfPg5FP5S6LcrXER2zpo5GxEfwnSqMgYtUSeLK2cb3/3e9CIyJXvuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIoy79hi0c/7f5WyBm9Smjl992uxVsjnw8E7RlM/XuQ4UWN6J
	RWMgd1jAfgbZennADberLv6Ie34gOk94jK2KmqQ+NwUJMN3j0vq3txk9LE0gf9yntlb8WAHARFE
	25jVaiMHDoGfdqxUHv6//b04T0OcNVmqtVAuEmuTAQ8S9pUXx8MAaPhg=
X-Google-Smtp-Source: AGHT+IEj94dKEcR0ff8arGxukdG85LeFso7DjhiF57uvFaJ/xkKAOZL/ellsQjaazXnGK2WKbRUeReTN+8/6pXwN8ps95ic3q+0w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a4ed2ff79dmr92769555ab.15.1730205063426; Tue, 29 Oct 2024
 05:31:03 -0700 (PDT)
Date: Tue, 29 Oct 2024 05:31:03 -0700
In-Reply-To: <23811290-dc18-4f54-8222-929969e6ed9b@lucifer.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720d587.050a0220.4735a.025e.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in zap_huge_pmd
From: syzbot <syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com
Tested-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com

Tested on:

commit:         b70a32bb mm/thp: fix deferred split unqueue naming and..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=155e4a30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35698c25466f388c
dashboard link: https://syzkaller.appspot.com/bug?extid=4b5c704012892c4d22fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

