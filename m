Return-Path: <linux-kernel+bounces-373912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823489A5ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380201F228AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8BA1E22F8;
	Mon, 21 Oct 2024 08:39:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CB1E22E8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499946; cv=none; b=WQkoTuLyXX/uSJfq1+lns7MZgZhp0jBrtF0Sbg1+eNZyk58At/f28addbJtFiqJClT4ddNi0/iTAuEm5t3V9g7MiR4GDZVGNBBa96v2ruF5mvKsZ5UMsts6vP7eVZsobw5EGdkDDEwZHS93b/jb4sHFLK3bHWVB1qrDGC/ugxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499946; c=relaxed/simple;
	bh=Mw3mQ51Qrp6VAjQ+PLfksbQ7K76tqgW6TBErgdaibQE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oPpvYm75LyCAdIzDVojKayzJp6qmGIHvs7XQbJMFTRvqaiPmB6zgfvnpFWSjgEWo24Ae1i79zYgzxoEyr9qNenJ8TZURT8qvtkvZIUyr7kiogzJmPgFZBdKqTnt0d0cWCfoEQP9QTIBHS9WWQb/7GZmyWVIllx5vjhOB2NEA4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab434c629so319794839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729499943; x=1730104743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOMO5YridhNWI0/MqOp9S9+4WTERRsU+BRRRGAf9Sk8=;
        b=BdkdOnCRx8K/g+ko52bw3IKZh0Nem5fyGkaAMcrDqh60aqYJdDVZPm2LmG7HY/RvZt
         xVrCai4IP+JpmJ5e3IRMa5Ae4RRaUuMxd4eCIP11owwL7funm1xs7b7zTXtkkN7yllIz
         FxPzuW8HUxw4ESIhia+mBq8k8R7L/rL6xUTUXeAazyL6UpM58CLxzkpF0WLnqNnsH+9r
         yyKN2Kw5HYg4cUKjZQFzweolUXlT8L13TEdZwZBTnkUE551t/lGcEqWqVt2eQsUKA53k
         B3gBWrefI+IQ1UMrD2VGsWNPr27wIiTRjoV6cWA9luTBdbjQlLLhpmPXDe/KZYFpuLSE
         7HEA==
X-Gm-Message-State: AOJu0YzHsRISRnQH2OUmQE5NBpo3tHdHSu3M2X74M8r33/4xvi0DxKOh
	jldJhW7CPp3kX5wuiv3PgV2E/MpHiO8u+53KZVgTScw5j6V68paIlIgYoYgrwFvbTQ6d0gifUXP
	CNo4jPcBwLUBYZGH6GWqCl2Da8B6nkkABizPfLghJkQDUuBw29iV+iLM=
X-Google-Smtp-Source: AGHT+IGJYHewHRfsLWZXGYSoCAo1wEJB2NpoPHzcVNTX2LY0FEqFhoqn1/R3ctnOL0gdAICQTMArzTiPFh/FjIAxEv6fW+vxnywM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b81:b0:83a:9476:2593 with SMTP id
 ca18e2360f4ac-83aba65cfaemr797290339f.14.1729499943430; Mon, 21 Oct 2024
 01:39:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:39:03 -0700
In-Reply-To: <62UDikG_A_c9--WGMXiOnVYgYo7NJo7Q3r83PJM03i01CIM9IRkHrZcG0agPWZ38lUhCqFLDToTkgxHwPrD1aKOhFvnIeJTS49ygYkRYCEE=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67161327.050a0220.1e4b4d.0053.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_bucket_alloc_trans (2)
From: syzbot <syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com
Tested-by: syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com

Tested on:

commit:         42f7652d Linux 6.12-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc6a40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=2b6a17991a6af64f9489
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d46a40580000

Note: testing is done by a robot and is best-effort only.

