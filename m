Return-Path: <linux-kernel+bounces-248571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1325192DF26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117CC1C215FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0614329CF0;
	Thu, 11 Jul 2024 04:42:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDF45014
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720672924; cv=none; b=Yrbd44Zn1tBHTW6h6UMDGye6XIIW9CfOXmAwGvgBnXkh68u+v2lUpMkS3W8nzsc6znNo9Toze1lvPkUe6xUwBd9GcQiS1gmE2wbwR92puw1kktodXsk++apLLx9nxdP1aFk7hSPFvmq4Pqz69Lyfjov3TxXvgx8ljE4fGsfgsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720672924; c=relaxed/simple;
	bh=Ke9BzQH6yyvYYxMwPjfd0wvvKfrWji49IS+kN+TLvEw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RHTpKCyQg36PKvokHVWBYtGedJIIA9szh2Xe/bV7cSOKRd0KCaj5VzVIT8qBCT7xlnW5r+LEEexe3SjcFnX/A4uoSkc4mSaHtOG4zznZYCkwVaomM9rFBtOmbt2XnKM1XSep2KIpCKJULefjM3RS6W/SUBVRQwwUCbAvARYR7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f61da4d7beso56601039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720672922; x=1721277722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ6LuX3weJvjiHL6qfsZLL7Ga7FcQBVOAg2SvG9dtfo=;
        b=nbLIAlQeveZ3Pc+IDh3l/2q6fdRFltIBaU8N9v0TI7mXE5kjk69YAlKtB/uzUk5ANb
         z67GI9auvCTnLCbMClRuaXzt2K5SZ8QYSjy1aVQsibiKKyaTrH2Xe0oCO4cULTXmffO9
         H/jZYY5i+E5ZITXyCRmQCnljxaC6pTlzKHGUIRX5ineuOiczCXhw3JC8kfTww5f6CEiV
         Y0Q/aoq5WPMmds1ND2YjIzU+EU9P0seIwGel+vDrXVXCvOfYR/Wj9UpLc/8YFi5nblqN
         osIKGFknWgvGZSAtp4QQhDz2buC2g/oQ3kdIvmmxR4C8V7vynl5IMA7DQ9god7kkHZ2e
         KlrQ==
X-Gm-Message-State: AOJu0YzEgq0qfr9kpqgLOGfw/uHnyCv9gaQZeD6iwDxr5Pzskbp1b+bn
	hcU3IhoQuIiNiW/woGz1UlCHyBvhP5ITo8QReyigItSUT/9xiEcYCoQ8n+Izu4PsqDEcKjvF/ND
	J20NqRmriTt8Hsx91EInxR5f3aP0if/KDbGsX73KgOpNtOTWZMzZ72WA=
X-Google-Smtp-Source: AGHT+IHg1ukiBb9nye1ct1LVIFIcl+55RjhrrtqOEzouMGY5OuSV9kXTAkV2heaBPfIzsOK8/FODdWz80kZqKhzpYTR4mmZVQrg1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6199:b0:804:f2be:ee42 with SMTP id
 ca18e2360f4ac-804f2bef028mr24799539f.0.1720672922507; Wed, 10 Jul 2024
 21:42:02 -0700 (PDT)
Date: Wed, 10 Jul 2024 21:42:02 -0700
In-Reply-To: <CAMc0M--0X+RmTskfeiz4vzVsPXze0Wv8TYoDVEw0ra+CwGCRMg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005229d5061cf16206@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in follow_pte
From: syzbot <syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com

Tested on:

commit:         9d9a2f29 Merge tag 'mm-hotfixes-stable-2024-07-10-13-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13be8021980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=35a4414f6e247f515443
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145e3441980000

Note: testing is done by a robot and is best-effort only.

