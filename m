Return-Path: <linux-kernel+bounces-375308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB89A9476
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D5F1C22262
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F03EC2;
	Tue, 22 Oct 2024 00:04:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1A360
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555448; cv=none; b=F82cvoAVr8USSb0jdTxUmFncj5acpEcTNGQ9kcvWrEhSCXztypnSkZNv7FQ1QGIhDg+kb6HMCJdM9s2DkbpxM2tQx2kQ3c8krKo8+r204w/tL8xHGxkikIAlovMTddmQ2kxDCzxSATaccfC26QbG5Sq8JDj1kKi1e3c4gskkL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555448; c=relaxed/simple;
	bh=0grzT+N83BxWnGl0HbYbc85viJqvdhp7OcfYa9l1hNo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=loUZBtEx4+oQgaRyZwdjnNG1sfwlOwEI2w5KeqtGG0fxy4SDIf+xdmSiTjkpZsyaToWTXRFuvB+pRwI5+u5Q6+kbA0fQvNm6Kui+oIk/ijPVaaPbjEq6Hlw660H2ND87kddpaMgCelTFfc7/P7RlVsV3iJtE0Kgn8FeWp2lYvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b457f6aeso38598335ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729555446; x=1730160246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHVYRYpVjNiDHLdksAEBN0IhbCnkWlNKgjbrgj+XHME=;
        b=dMoUnJZ/LN0kYwcoDCX8awVSkbcR7/HhQQUv7rCx5Yf8FbvsCcUoabU4BhJ14OPFE6
         DUlMnrG5jLalLSLhfHoWx4JzW8ZOQOwiGtLZZbeYPjPRZl8BR2k7y9YB74hkU9K+aKJ0
         73MumXGKgYPn1n7h/CixQ7jSIUeWHGRICPhI5EEXyubC2zO+TT4WkgDFUJsXUoPtYFzp
         Q24ExtZmBtMoGheAZjHt9a1pfZvIpZjUGT/ajGuzmzJ1RaaOdDysOMDn7ABu83v/vXPF
         MXSXmKvoFJ6f/CCsdRUJB2/P7LpzefNRkHm2WyiSfzwNqr0rgQBcV7H5G6pqwGSC+eig
         uNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtTed9YZu4AdMwapxxiXR2tFFGvc2hI62GQmpPjlW0tuMWxNoawk/o4+RFc4zLqykz96dZ+HXZrW/seRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8q8xVE5HF8I2kjtvdL4NGaWC9ZgGAQaRAchrTJReSVv+aSQo
	s8s7FO9YMsEfLeBcADYLugtB5bxDrUjeDMmC5d0O+xXaQQmFM8MT2n8IMgD97z1SCf9252b8Ecd
	raZWnIpcix/OnU3qPValnfjWphWAnCbMkoQpfMykoneyKxlc+5O4n17A=
X-Google-Smtp-Source: AGHT+IGoXZdrmhIEr0MI01rF+VqRSdj3NZ1nXfdnSSJtqRgq6R/x7fdcop46PF7CIZHACWN4dEWkqYyrQg7qUTAjzAxRTw7znf1u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4d:b0:3a0:9903:42c3 with SMTP id
 e9e14a558f8ab-3a4cc250da8mr9055975ab.10.1729555445955; Mon, 21 Oct 2024
 17:04:05 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:04:05 -0700
In-Reply-To: <40b42775-ca29-4c63-b13c-7b02911379a1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716ebf5.050a0220.10f4f4.00db.GAE@google.com>
Subject: Re: [syzbot] [udf?] general protection fault in udf_read_folio
From: syzbot <syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com
Tested-by: syzbot+ddf8715339c89280b6fc@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12684640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=ddf8715339c89280b6fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

