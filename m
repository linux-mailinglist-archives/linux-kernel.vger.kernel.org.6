Return-Path: <linux-kernel+bounces-370768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B29209A31D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5131FB2189B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBDB46444;
	Fri, 18 Oct 2024 00:57:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1373BB22
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729213025; cv=none; b=GtPZ9b4qnCAP5O3YsX3q/CjSTuO8P+uA4xZhZFOyGUmSm6JWLLTMxmewN6EBDscWsnlKYCF1atEf5HZmxFOISPV/pRYI7VpRY8M6WpBsax6RhAYVD3Dv5Xw+rbFj8Q/Dh04Zzua6zOUsAxQZRP7d8V24kr8OBLTFMlsosFAeVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729213025; c=relaxed/simple;
	bh=gCfZCa3eCO/ImdtfrgayImJe3Jk4aFQ+KvM1j0hJ13Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f5E75jiXpoZ1Ic+Ymn0SA2EJUA+QBJBlKBK7ifTAKSJTtIGDC6UkWWAYLcWPEO1Ir3TfAAnkQ6R1ulz2HaxQdbHcVoGjop7ArNn9962JFGIedRLtqW6OIdFmHjEEbihHuAL3TNT1tHdCHhKxVxghcCvGLlBCGDmfL3aw/aDMVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso15747375ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729213023; x=1729817823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqeLqdi4VZTQWUI7otEtoyavMb4hyb3TjNvZ1DOSFB4=;
        b=UuMZvC3+TeTHVb7fdGmVuYLqeEH6boA0ShGHd2PwpIZSSgaLZyWitGjkwqXAI7YOR6
         q5WfXjNmniLBG97z/YUIEGpokV1YATX2Ix9n8b/F2vf49NyTY/MwY5QQpAeFbJN+lYzl
         mAKEDFU/p8NtTejqzrl1h8uGY7/uHk5AizIGaRqYXNGPn+2kNvfjKJw7lsHTU9xIvX86
         qQBKFHvTLmhPGPOUatm+ok0ukNxok6X7j3ZeBGv9tGZvSG5RZsfGUq7Gs81yF3ukNVHv
         8jUxDr5I+WmfUnV+nbuDKmM75xwaCBayaaalWVoVEvhUjCWRN3Ci2OtckPYweeLLirzi
         06Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXsJPFWFMbUZJxr08Pkg96Ricmph9je4Mm+1zsjSUHtgXZi5buZuziMTPqopaOsyazwHcoPqrbveNIbqdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8yI4wUTwC3l20xdNTgvBSJNC7RS+JR+V00FiLa0kyEjK2b77
	90S8de07qg0+AdVU5mkKukQ12B/je5zkQldPx3yisBEPNsaq9yDSL+qBncWRnxIpjIky8+FIf1t
	vb0Qn5lJnZ18QNRu9pHdogkM9ZSVAILu9LOpw8Cd3XRRhvdlikffP1yQ=
X-Google-Smtp-Source: AGHT+IF2l/I5CwjB4QRbjF8KLulqSx+JqIfNHnjpBOSO5ETpL1Yv+UJRRdeB0PbR1ueuLAyjYo8Gc0436YSDNNO0EuMsJR0ZOblI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a3f40b531fmr6352115ab.21.1729213023103; Thu, 17 Oct 2024
 17:57:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:57:03 -0700
In-Reply-To: <ZxGkuaVUl8KRPAxO@Boquns-Mac-mini.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711b25f.050a0220.1e4b4d.000b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
From: syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, boqun.feng@gmail.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com
Tested-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com

Tested on:

commit:         117ea4db locking/pvqspinlock: Convert fields of 'enum ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep-for-tip
console output: https://syzkaller.appspot.com/x/log.txt?x=14229830580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de68ea2a11cb537b
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

