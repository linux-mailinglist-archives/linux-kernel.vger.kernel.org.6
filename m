Return-Path: <linux-kernel+bounces-329649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FB6979449
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4DB1C22FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8662D1B85D4;
	Sun, 15 Sep 2024 01:54:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243953A7
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726365245; cv=none; b=p1BK4VXY1bwjOF2IanJMJYh+SOJhfQyUa0tUXS2z+eGjJa1h4qF7C7TAjTHs7HdV4G6qZUL7w3+rd+4Z35nkWBwMq6dkG2LcYaEC3WLQJf6FUytgb+DrvAq1KUzWOnZmZELWHRzWK8kSMcovOsJs0A/XcnyxGYeu2r9RDp49WvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726365245; c=relaxed/simple;
	bh=SezkDynUTrBxeSh79CPUTAlE+lTabOh9D3SmYeWxQqU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l+/+THdtOe4rnryHs729WJy2pC+Gp4hOB74hPpCllWZwaZn2ByV5wJiz06FO1illBzCPZz/vEP48WkVl6XLYhfuWfDBE5NJ7oUpMLhYZ6LXquKzliWAZ361EALLC/43hK2CaAPG+Yjv4CF3bDz7MMbn3UYf7bRFe4HKqiXi3s1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce2629e40so642068839f.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 18:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726365243; x=1726970043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrZ2/Pm9zRmtDt+f/bl4CiFjFBVzVyDy01kfKNm2zQk=;
        b=Gsm8P6Wx5g7YIwf+ZOmZ0uPdWIUSRjnouVYRMQbM0NHzMj5L8G33t/tWzcKcEtGsxX
         Wt3ddBC8TWnvoP8qmDoORGwt6WV8rwFN1OYXcNOKj8TmhQpP5aV3Da2Q79hDjMGaWBhp
         feQockq0MuM+mTlC3Ug95X7Dcdb88rIa8F3qJmomifI9r7qeEK0aY9BouA+KE//tawRP
         hQi0e00iYr+iEvm7u6+bEvH2pS9LIF8BMsenr4FTOFV3wMgJQBmPZZ1My649nui1ADo9
         8aWeFehpg/8ls+HO+282Uxfq4+V0jDjdSWlNUte9Oi4ymbe6Ivtx3NMpEffzPoqnABER
         KMdw==
X-Forwarded-Encrypted: i=1; AJvYcCVfuRxnCppcZ+1fHGYm1yWv4G1NXxY9r8hhpeTaJbUtZda6AlBZmOzEVnJWNmim48AHLqe8ZF0zMcn6euI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1NnkMCfi32g6/reIWUpIaFk6o57EY14xUS0mkt6MvlfXel7s
	JIJ6ZhZiUNQPISQi6TeN4BcPCF50xbn22AscasODkMa7Qnqc0pgZNALoPv56l5Xeq25JAxaZnvP
	srWQ2BFBuIv+vrvk2YEzYSOv6FRLG+sl1+0D7fwSz2OkBv18InscE/BI=
X-Google-Smtp-Source: AGHT+IEu9ty2Ok2BMlRuWvvMVYjJsiVy7nBGAG74ATPxH35ZyDlY6xulQMDuE6FwP8VWYZ2TAKBXs0d+HfrfW0bj5CKZeMv8TmwF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc2:b0:39b:640e:c5e6 with SMTP id
 e9e14a558f8ab-3a08493582cmr90766365ab.17.1726365242814; Sat, 14 Sep 2024
 18:54:02 -0700 (PDT)
Date: Sat, 14 Sep 2024 18:54:02 -0700
In-Reply-To: <20240914203143.99551-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d0b3206221ebbc5@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
From: syzbot <syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Tested-by: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com

Tested on:

commit:         0babf683 Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ec6407980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea008021530b2de3
dashboard link: https://syzkaller.appspot.com/bug?extid=b8080cbc8d286a5fa23a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

