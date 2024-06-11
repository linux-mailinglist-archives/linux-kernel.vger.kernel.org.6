Return-Path: <linux-kernel+bounces-210035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396EC903E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C08E1C24301
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB5017DE1C;
	Tue, 11 Jun 2024 14:06:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FAB17B437
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114768; cv=none; b=FDJtamx+OADnublcddCUj48zkdOllONjj/S1iXl6x9w0IfocoMpe4O7yE3OeI5CKEmrKzEy0Ngq7kRS5+FJ/vltA23gZ8KPIyhw+3GER0e0JafcO8683k08LVDVYA9IuVChSdaOPGQd1pUYx0T+Di/FaLcxJFUwjxMxZTJeabY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114768; c=relaxed/simple;
	bh=vnPkA8fhIo06qxbVMv91q0v4j+dElkSKKNBq14Jget0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iCLi2nZJMSPcjbktEwsJ3N9gDImIholXnk7ovSXWt+u1dye/BCCjYW3Vkof7myD4AnwaraOcjPvwFNo2AYKKbQ5Sq10pZdHeJRymuDcGPiuuidlfnmLqe2z7vZe6KmkIRXIliFCbiJTgtDQznNZpzWvU59qmh+ruMFiauHSjyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ea8fc6bd4dso693995839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718114766; x=1718719566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2d3J5X0vIWXXvbpLI1PIKb2skYNl4t0Lg5fOvtdrEU=;
        b=qeszUY/asXPcekqXDGngebBu/W0Dd6mv7tdkE4jW1xxQHtxCrdaChj7Q1R1Sh0nBJB
         GaaftuWbSLIMZ/aRlEod0pJqI40OlDdsELVaDONRavfeEkz7TxDWvdOQ4n39/ZR2U6bz
         2a75+P+MbtsZUQjOZoBIf+g4sBxt9UZyOCyMKziTV2kWypXQGy4nL+eYEXg9kBaJ03Ww
         O7UTJ0KmfJETn3CK0l06yt3BzVkZmQM0LB8fOQazqRflBWb2MfGpoy9QR7vBd8DaPw+B
         YJBHJ5bQ5Fwt0DuNygG6b+Eljqxon5t9itC4LAvDCjKaHtBuZnP1M1iRQWMdtxk6eGHe
         ZtOw==
X-Forwarded-Encrypted: i=1; AJvYcCXAOeAuoJSgMQg1aVgr3a0g6cZDkWwJtNzl4K/zcHHM4LbBLlgXQHVbYsdlCe0knis6s0TdzJgS0zgGDAn/udfxS18lMzXJEK8eatLs
X-Gm-Message-State: AOJu0YzJhbbi2v449PEGqxEmFk9dSTNytRxCZa6I4N24+vAZe94tW8Qa
	CJDS+uOpgIVlScycwYdyYDUmeotq/qpeKZo7gSPVIohpynAkRYblDC3QfEtvJtC0hQJOUnjBYb5
	y+qFjwBBpyt7pANBIa1IlBLXc6lDBqrGB65FDxUT12qxlo2eGQZzzARs=
X-Google-Smtp-Source: AGHT+IFhUXLztk2ihDkkpRpHr+i1y5PcHBFgk42SqM5tmWv32uRRnMSu7awQnEjsqE8i2mw9G5+i6uKPyaG/pPjhR2cPtYCM8lVO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-3758046d0bamr11464875ab.6.1718114766014; Tue, 11 Jun 2024
 07:06:06 -0700 (PDT)
Date: Tue, 11 Jun 2024 07:06:05 -0700
In-Reply-To: <tencent_A26D4970C3B204575761576126CCF3696305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fda69061a9dc4ee@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com

Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13ae3bf6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1716a4da980000

Note: testing is done by a robot and is best-effort only.

