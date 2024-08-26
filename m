Return-Path: <linux-kernel+bounces-301443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07B95F0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6901C236A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996C187339;
	Mon, 26 Aug 2024 12:08:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7C144306
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674083; cv=none; b=Fb5SYZPmAT5mJZgUYd5Lsariiy97qzSmoEfnITDPd3uq8cy5R5cXcD9Ks1ekXrHK1cro7u8zfqw1ijzDV44sW+nCc+nOL9hOoCaecy+DQSGAsVqDbsg2h7Kbvti8F6mGkaTCyQQoJfTiiNzt6TdpSe3sv4eSs9lngozf1h3QkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674083; c=relaxed/simple;
	bh=7H7ZPMsxBIRgLMNNoeMI8qtMILF0jMnKnj12Bq27HP0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bdj/bWaDrdLwbb+2UTudaUhjBRwRlt6grwbsXv77M2xHVF45bmaA+CG1GThITTpwQi1oCjps83wN4e6HNBi1OY3qfxDDQXMUbur3/NbXQUKH8UUkwUsKyyJDdwIi6p9n6g6ivx7cuPxNghrAqCKx/XTynkyrnXPmmfaeMQ7d2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d27488930so43162785ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724674081; x=1725278881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wuE1cX6E/LM7OqLE4HWg7L3K0h/Pi1McYvL/zJdmR4=;
        b=Ibl9eY6qW+Gem6j95KB4vtFStpmY1B/zMrQ5H6Whvh+stbJ627q5uuQOwdapH25Ruz
         HpBgsEKJkVvAnh6Du+GNEi9L1BeRNnEm1t3Vq5OdAh1qvfmuTZQ/Uf6opdjLgRHXqS3Y
         5kHiy5EtfUvRYeF3CUw+tAGC+9AYluO9Sqbo9kn6mnZVj/4+IEsqIJ1PvJ42NqlH4ZOo
         7v717gSXJAwjlXxuYSSsThTqiJ8zXdDinKMjdUZKTKg/Cua4TXXtzVOx6DNc145DbTWY
         8WUp9VpLbpwgiy9aSSYDWkmZxL5Ofq5MpX/ke2M5V5szzPnA2gLoJGxaWmaQOx4q1+tL
         QW9g==
X-Forwarded-Encrypted: i=1; AJvYcCU13rpzD3WIEmtNjYoqPx6x1ngAPpsyND5Xf63vySWmQm98jXXprQm5KBXjQEea+L9Mn8WSGtudiz2ylBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLrhmHb8eGlddQ57Xz1ry9alj/YJee7EfLfN9OMarLkc+nCqnp
	IGBn71kb5fZwaULedDyiL9q7Sh3LJYztD227hf7ggsfkB2ZOH65hcz8HcCsx0iaftAs2wUa8g7Q
	c0eoHhPu9u+c+M3f0hpigWUYwgC+e950ishCXCqJ27EdfMVS1/yJeIvw=
X-Google-Smtp-Source: AGHT+IFpEhgAp1GvVv0Zg8iV58xhZderM606AbgS39DPBV5pRWlle6onO2rTsGV3Fgn1peEgrDKyRsRZyS18fy4lLhSaMiELYInf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:39d:300f:e91c with SMTP id
 e9e14a558f8ab-39e3ca05649mr6986005ab.5.1724674081523; Mon, 26 Aug 2024
 05:08:01 -0700 (PDT)
Date: Mon, 26 Aug 2024 05:08:01 -0700
In-Reply-To: <20240826114341.7421-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb9922062094f965@google.com>
Subject: Re: [syzbot] [net?] WARNING: lock held when returning to user space
 in ethnl_act_cable_test
From: syzbot <syzbot+c641161e97237326ea74@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
Tested-by: syzbot+c641161e97237326ea74@syzkaller.appspotmail.com

Tested on:

commit:         18aaa82b net: netlink: Remove the dump_cb_mutex field ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10940a29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=c641161e97237326ea74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b0800d980000

Note: testing is done by a robot and is best-effort only.

