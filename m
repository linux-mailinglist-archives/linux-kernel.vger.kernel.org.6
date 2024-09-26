Return-Path: <linux-kernel+bounces-340420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA6987338
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3581F227BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303F31741F0;
	Thu, 26 Sep 2024 12:03:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4A1547D5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352185; cv=none; b=fRCVPUpIyJvv+ZK6HBOijG2Z7zYp47V3Z08IIfzChBK8ZDsiu7hqoghvrqv/8aVezhlI4RPp/N2aRwm0jjs7NobpgAVg46Q3pLxiIe5tC72+IfnJCI3f5IsIn6OHdK1z27Z6SqHbtnkzatwfmL5gyZVpwjADSN4OypxqkmoVrz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352185; c=relaxed/simple;
	bh=0pLfY2X6UOKltECcM9pAIOwH7vtH80T4zfABC0u7l5U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iEshDGn21hknOGoIRt6esLiJraohY27SYl+qPKFuERrsEFY39lj/D8E6gyow5jkshRGWnYCxBh9e+8+YDRCxajvBT2OrPSmbofV4OO1r0f/9rVc2qNTc9dt/k3Dx0E9VSP7d4+v2UodilaVURZKVj1Iyv8fb5iMmv1veE1nPFVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a343860e72so817905ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727352183; x=1727956983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54lezyFMcL7IULZxWN2mlDaTweHivExRLmRhOC2RpXs=;
        b=QPs+shoii4UJE2dOZg5D8pujZmRBGEOLooON2MIJLdhF/k85ruN28+NIEElZzsB2gS
         oHurK/N5yPrxg7OGdS3zRU5icRnUka3Axrq6YTk8yjPqpa/rm9dnM8kHrA7MFx/a9/VM
         22b4iW4BBN8JqiWVx7nETE6IV20ghI5jrcgvlwWFCK6ATj2i95rmDDVDcdTizFC0PWGC
         9K4jSAvdMRpcfpl1PiZUo2XUNmASHSZJdyx2Y4X+DznnlABVrqIv2yPryD/LHfkk/+ti
         ks1i1cKMecfpMatqZWv3NMuWO1UTiq4O0QpeuAL2H4bprXRqc7gkEg7gfyBgDUMK7in3
         UD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlHKvid/g8VgSw+BO9sgMKME8/rN9CWUbIg+MZBEexeGUqkgsAMxFu+fhAOoaQpuJfyQ9utbqTBtrRysQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywax3sVJOhS7p/1m7Xwb1FDBWCrfEPI/hcNnj9Syur4T6SOOwPp
	/0/2XFmn1fObMCmbXjdAHBXnRkciVdLwPp3/Pm+TXOeIcERf4qwJX8leTOhM6S+njQLhqy863TP
	5dCVJCV03ogqoq9u7qPz/kHx4/3TAw2eAegWxWt/HGTwlhO7xSLMJMFk=
X-Google-Smtp-Source: AGHT+IHnASDafTM22RlCnOyonhfpC/P/cmQXZ4uTEmDiR3XlfgK07fk3I5FAtnesHqDLxp8qemu/hST5MQQezLCC4c5Cb0wwPwWO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d04:b0:3a0:378a:884b with SMTP id
 e9e14a558f8ab-3a26d6fa5b1mr65614265ab.3.1727352183406; Thu, 26 Sep 2024
 05:03:03 -0700 (PDT)
Date: Thu, 26 Sep 2024 05:03:03 -0700
In-Reply-To: <29447f93-7b01-499c-85c2-747285d0a73c@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f54d77.050a0220.211276.006d.GAE@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Read in
 udf_get_filelongad (2)
From: syzbot <syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, zhaomengmeng@kylinos.cn, zhaomzhao@126.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1125b627980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1459b627980000

Note: testing is done by a robot and is best-effort only.

