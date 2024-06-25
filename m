Return-Path: <linux-kernel+bounces-228732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B10916639
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C567A1C21F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1235114B075;
	Tue, 25 Jun 2024 11:31:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE745030
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315064; cv=none; b=JpC3GSnzwwib7YenQaGcsZ/7MM2uAv5ZGv5eXmeac+VLnHCdWBQNCmN0Qa6OYjWf9hSwrNNJIpeHxxI9qb8inTyjMb2UUlGMM5ngWuWG4HqFURu4bqA7uQoe1MPEiPXjkPgFGRpVdCGoreZCBma39gcuS6CePRwQBZM/yVQuDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315064; c=relaxed/simple;
	bh=1wGwLs+D9zcH04GgdrvUC++YqhuEyyd24gL7Qe1C3jM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fwUNK7LNC2ukVsBlcFpqgggam5oqTJF1/mW3ygcaPY6jHkIIFUi3jcr9Xs2zsk+VvfcsPzo+i0JOQ26H7FXb03WejUTP9iKZnoX7g6H2ybyBYH230XM7ro96cHYQkZn9mShMGGYIhFViXq06wKawZXwekH67A/zylpr2aiDCn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e20341b122so711763039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719315062; x=1719919862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5tzdhzTprBinh64eaia0xb3pkPffa6rhA+3q+0LvIU=;
        b=RdZDGN4JG5TLRKX/gK5B1SwTdRhXL77XgbZ5j/12UDyLsxrSYyBUnWNq7j53LdDNDW
         gxZXnGAt55RENQ7MxrOUbGkPRcqV9BB5Cvlj3xJ291gZMyAfAcdmHLGk3ZjErsyU/Vr1
         35ogsYQvWDH4eBHv8+MLKne30H+QC9Z4jYeH65Oi45hnD9MQLpwKCftpYgug3iMbgaCc
         PndTO3ygOVorpNjUepGS4ODkJwaJFNQ366OSfk+AFk5uSWjvrN4qNhRFI8RExgOPAv4V
         4Qg7PdLKiu9HqgT0ikuCNV1RPCQAu6606iGjDemWL1bbYiQ5OSIG1+oT63qkTUp7IHk7
         +JDQ==
X-Gm-Message-State: AOJu0Yzb+IC4Wnb6RGFq/5ysbU9fdY+eFxS/njWWKJiuwHCgzranptha
	9dVrk8NhOm9rmbRivnY9MN4yHjFEs4wyEdbf9fqx1eVNWpeO1e0ih9buig6j2wtJTV2l41TmZ6G
	sbEd5dGQx0z+cEQfRHwii0cvNtIc+zPmNo98gC+w1XCFIdyNXSvCaj8o=
X-Google-Smtp-Source: AGHT+IGYY+2GgZOfU10aVLrGZuSJLzxotD9CZHw78Uy/bkTyRp/iAYAzC2n+4oy0BRtAoaZaZ78tMh1EfdPilGT5Bmkyo2Xk9Tdw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9513:b0:4b9:23bf:6fd5 with SMTP id
 8926c6da1cb9f-4b9efbea2camr132410173.6.1719315062459; Tue, 25 Jun 2024
 04:31:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 04:31:02 -0700
In-Reply-To: <dd54a706e0d5ba7cb01e073a256b6855409684db.camel@9elements.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e2400061bb53bba@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
From: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel clean failed: failed to run ["make" "-j" "64" "ARCH=x86_64" "distclean"]: exit status 2
Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux /boot/vmlinux-5.9.0-0.bpo.5-cloud-amd64".  Stop.
make[2]: *** [Makefile:192: sched_ext_clean] Error 2
make[1]: *** [/syzkaller/jobs-2/linux/kernel/Makefile:1361: sched_ext] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:240: __sub-make] Error 2



Tested on:

commit:         62c97045 Add linux-next specific files for 20240624
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccdd3ebd6715749a
dashboard link: https://syzkaller.appspot.com/bug?extid=c793a7eca38803212c61
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f96f51980000


