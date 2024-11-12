Return-Path: <linux-kernel+bounces-405432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA7F9C513E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4183282196
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623F20BB5C;
	Tue, 12 Nov 2024 08:55:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89649154456
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401710; cv=none; b=b8CvoUES2YNzSx0uXDIrnqc/7Mkl1luyAmv63CZDYBig37hW/AdN4eUQZ1igu6c32Y1wqKbSbgQWMezKz4m1XMfO9X41FTrXcx6QYx2nCVLJAeip8H1Qe8UfBKw5CyZVSV4YR50QK+38Z84tw4Z/zAKXYv2L3TldIPr/G9WQXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401710; c=relaxed/simple;
	bh=ztM9wVjiSan7s6e5tfLWzc/0D0QxDJdIGwTnfHl7MOg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=raZ+KfQbh7KbPKLVMXJRXLnFAbewyG4MfjK57ZGBn7svePVE62s/0YGXh42LEb2/62PSOKNXVCV+tLRGC2A6XB2WUpF9BkC6TPCBD7vB4821/TmCiH5U6I9ZI+DRj4qbALTBZIcKNnRQjiaUrauzgLOguDyyRGcrFn3ML69LCkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so50731385ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 00:55:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731401707; x=1732006507;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98WPBRbLn4NW7F0b9o4aM0K2Gjtvn022nK3G8JzBygk=;
        b=T0BYGCYw3VwtzWAjdb8HHdyrsMjAvYswlt98HaDpjdYIs+5XR7fi1thLX3gcESq73S
         CfY70Q1G8mshwXEuW3wAQ0pO5Xp9PIy9lfzTkluqEvDkHkp/BOmwFSQs4bkDGblOx8K4
         0eJKmgpLHx0PgE5KKe5fleC0pRmzbysr5qTi0kYE0XIPDCdkuNaehQFnbYWAZ1i1bkvm
         cAufVrYiPn3UK+CT79Md/SBkTgvr/H5nYXFfze6xdr8H13fq1rCtnDSOVs924uazYSMK
         OzM2Vp5QKhsVF7TtwM9lXSjM+1RA2cId88j5odcS/fAHHgSySQ1OfiwU2YgqcPTzDxPh
         wCmg==
X-Forwarded-Encrypted: i=1; AJvYcCXqpKclcLjz1kxwHlSDi5Qqnx/hQzMqhA5s/vDrObzFDHyIfrXkVKh4gjmIbkBxw3NuK8NaaKd4F5OMLTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWVS9IbLcEIoEe1Ho4zef7i2fVO7fL44nrhenFwrFATso0J6t
	Q92/jIVzixNEBKDq9rZYyztBzhgdxaIgUQ0kVrCyLkqCptJnhnOa6WrJpnX75CrGpxnU9jsn40M
	XHIyy7qvIYw7OcTH5DOqtcJNT1k4HNpWvSUr6W0RChj80UUbFMXnvf7c=
X-Google-Smtp-Source: AGHT+IF7auYBiz9WILSAE0641BsdbiXeaNbhyR1E9wzgDtwfl9VhE504sUb+aVRBe1ssz8b1YxhZ+lODXWLCgIw1PWyrjd7Sr556
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3a6:c122:508c with SMTP id
 e9e14a558f8ab-3a6f1a357f0mr167241175ab.19.1731401707757; Tue, 12 Nov 2024
 00:55:07 -0800 (PST)
Date: Tue, 12 Nov 2024 00:55:07 -0800
In-Reply-To: <tencent_7423BEE445F76E7764C6C2336F8364696C05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673317eb.050a0220.138bd5.00d9.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_find_entry
From: syzbot <syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com
Tested-by: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ad335f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=96d5d14c47d97015c624
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129678c0580000

Note: testing is done by a robot and is best-effort only.

