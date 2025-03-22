Return-Path: <linux-kernel+bounces-572291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9F7A6C8B5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6006E18938CB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E91EA7E3;
	Sat, 22 Mar 2025 09:28:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169B1D5CD4
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635684; cv=none; b=VixLcJRgWQHre6vwKa8kOm4LKtvtNHkT9DWjt/SNwwgIK/Oc5f3x7HZqEMU+xlB8nlWspG/1uzO3cdgKTQ6mX+BPd5f9lFYor2Pmpzo6HS0F5NLE8dB3M6lfjm59W1SW4a/VyeGv5HAGK9mB0VjfHqU5Ve97q9uPa23zC+xXRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635684; c=relaxed/simple;
	bh=YvP5plOupe1A1k9EZ7yU2X0y7ycDWIcFtZyz/cs0EWs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NDyY78wxfuMgWXAcq7DhHnRgCoqNXWViePVVT761k+JEUWbzUlKpJvGECg9RwzN317Mw6mOSZlWeLheTJO8wzx3jNOcxlUYO+Q/0E4kCMDQc3NQsUYwoJE/egdikG0p70Lr1WLEwPRjAIgdzUi8MWSxzpmWNNs4v6/f7IyhSP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so277511239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 02:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742635682; x=1743240482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/1/8NSp23q/ACQLJxacEQ6xVJJpFBAovimyCbTcpNc=;
        b=AnDRDNPDhX6FkGKRZ9Jy4e3cj3XJWkNdZxiHtHp8x1sLuef7tmjksl0lSuJeuJTasy
         26rpPgCtfoDmAlL4FXgv0ZShl+RHbIj1Wy2ezz/oA5opf2v13yv3ihXPqc4at8FBhAZd
         rKwEvCpMzKsgvxNcmfbcqi4YZKA1SpvLTk1W1j1Chz2whO3cfmXknoz6KtRhWx2arJTF
         aYzNpt4JsX4w9t08PyWtQ0be0QM6nKSIsE51itkuqFk+uDa7cykiGeSvR7t6t9bgq0l3
         HvGR7B6RgiePdSdOIOoHd7D0pIJro+4mXwptLmZe7gFR+0/YEutLWbUJhlHNtTNnf5W5
         PmTw==
X-Forwarded-Encrypted: i=1; AJvYcCUq0UiF1MZolKr07Ohmc9NBqmi9xJJ6qxc6hpIeQF1TA9EZsGEWgrlZNWdFWEfvQYNd2koRf0DA4CIEeMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJ2g2uWgvh1THLJVHuw68GBj7yZ6DdcUFINRrP7HhjmfgyIz5
	kFjZzbC2pnJX7SXW9JukKYE5Hnnv2iFBtDEKUXOgCKxjSYwk4yBN5/1a7DiiOkenawju9dHH875
	vC49Q3v6t1GlpH+H1LhnFkoJmH+ztu+7aaOHo13b1jSuXJ72zor2fhgg=
X-Google-Smtp-Source: AGHT+IFsGhUOtcYYvOrW0tXzabFLcCZgbkG7y/DFv1qHp9uYbi8OSs02v+7vcOGJWwbwXCdClCGkWwkdlJZzy90RPDkfS+SkGEki
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220f:b0:3d5:7f32:8d24 with SMTP id
 e9e14a558f8ab-3d59616b952mr65624375ab.15.1742635682477; Sat, 22 Mar 2025
 02:28:02 -0700 (PDT)
Date: Sat, 22 Mar 2025 02:28:02 -0700
In-Reply-To: <fde4a18e-0376-4c3f-9b27-b644c211618e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67de82a2.050a0220.31a16b.002e.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] WARNING: refcount bug in io_send_zc_cleanup (2)
From: syzbot <syzbot+cf285a028ffba71b2ef5@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cf285a028ffba71b2ef5@syzkaller.appspotmail.com
Tested-by: syzbot+cf285a028ffba71b2ef5@syzkaller.appspotmail.com

Tested on:

commit:         e1306007 io_uring/net: fix sendzc double notif flush
git tree:       https://github.com/isilence/linux.git syz/sendzc-cleanup
console output: https://syzkaller.appspot.com/x/log.txt?x=15809c4c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fa548b75e783182
dashboard link: https://syzkaller.appspot.com/bug?extid=cf285a028ffba71b2ef5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

