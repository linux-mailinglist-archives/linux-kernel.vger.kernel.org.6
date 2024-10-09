Return-Path: <linux-kernel+bounces-357752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4285997562
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696841F21AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3F1E22FA;
	Wed,  9 Oct 2024 19:05:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28CD1E132A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500706; cv=none; b=rbdwdd42gfzlM/Ok86z2CyFZahMchHPWstfDVrAXgcDzP5a+KzKs1CqoQZuOxwKT8MhSke8pIeVC90BLPdbWS1gxDQBORZXRO/YR3L/k6xZXg2DtADAuBMwAsYTNx+m+QiCPiwRtAUOAwemyQhXBw1IE5XvlUXBeL68Aglvo0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500706; c=relaxed/simple;
	bh=gvl753cmd6Kx9Rt2yRzrebyZBHezlGiPW3rpihqJy7I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tw4cCWWwQPEGsKk+IXM7IXVoC3d4LNf0xhzQwDeEPz1q2e34Qv38Ri9tkSX/DHWVcOMp5gKvP9npXGgtKeUi7K5MX7UrHy+XL4kZj217Rx2B3OxniDczEJxuznwRrucMaF9zaHtyFV4hQm1uN4Zq4uYrr4R9R/deKPzhbVHM+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a363981933so2505715ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 12:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500704; x=1729105504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u95iXJ49Igp9OpSFm4zZV4sLy87CGukgyLqm7BVOA1s=;
        b=efCNAV8D+VViXhGv78qm+FgY44njWg1zDDRkM1CfJYzvXQQ/luSCY1wrOYKyI/7Q4n
         rMkYH/VmHqHSPQ8/fN81f4atsCH38Xznbk+Xd0+5NzN8b4sma+feSw1MKo05B9m0uR5H
         D9FvAtk/Wmx/7KcxYIIpFvBGAivcZ3pE5d1nAWQNQKaFJIfZUOhKWNAjJH8EcD1owmSo
         DZnqBLwHvMin/BOrr065v7Wz7jMF+TM61El1jKRb6C6xSaHAAztMkiJb0kNFzIi2Cw4q
         x3CEWeTUjpg4cjhzIcOAkJ8CaYGjf+cP5fpcCN6mIGVaD+q0We0si/8Lor3YPZRekVmn
         Nciw==
X-Forwarded-Encrypted: i=1; AJvYcCVdTwdy8ysvXVumYoEeho6MiI5+jXW6fo05fyryPhx6b7VZlV3J1F/Cy63IOXtx3oUMUlZmehYGi++bH84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpEA3+Q4m08KB7V29UsCPzz1UAYpOENPFdjvs4WN9FLlslFuf
	NoycExH01QkhOnTa/3Px8yNtmF5z3TpIpXZD5s3TFqr8/oUFWWFbKp9cTu4YATJvkEjf/g2Owhh
	ekTxYRQzAQ9x3BwzB8hr79xWo8sSS+ucDpg1RQNflAkGMoCUJy4PCWTg=
X-Google-Smtp-Source: AGHT+IFCPf66BkaFYbH2fymxFQd+vTQzRMgzpdKXDeJtc+D0Seb1RxcQ7Yx9MemFqc+6V2V4zIZssVNRJ7q4oSGwgJPuJ44k0O9q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3a2:f7b1:2f70 with SMTP id
 e9e14a558f8ab-3a397d2b458mr35000385ab.21.1728500703772; Wed, 09 Oct 2024
 12:05:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 12:05:03 -0700
In-Reply-To: <1a1d106ea8bba8abc1d3f3cd6fdd71d03edcf764.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d3df.050a0220.67064.0051.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	ebpqwerty472123@gmail.com, eric.snowberg@oracle.com, hughd@google.com, 
	jmorris@namei.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com

Tested on:

commit:         0438fbb6 ima: Mark concurrent accesses to the iint poi..
git tree:       https://github.com/robertosassu/linux.git ima-remove-inode-lock-v1
console output: https://syzkaller.appspot.com/x/log.txt?x=15ead780580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74c522fa0761706b
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

