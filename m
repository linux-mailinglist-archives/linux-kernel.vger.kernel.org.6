Return-Path: <linux-kernel+bounces-236223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E598491DEF5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7740EB21621
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0402C14A0A0;
	Mon,  1 Jul 2024 12:21:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437BF149DE8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836464; cv=none; b=nr7XuhkyPzMD9PcsqG8BxMJMXPN0Rgakp1ChJ1aMKDVJ+GzcRr1Hh1UhCaQADjy13J7skEQu+HD+Lo8X87hBxxARIan6yXhbWTkXp0p/lhXraEBzCGc1AKNnaY6eIdYqNaaAt8B/EZCsSST3p4dcXHZnolsSWSdUuM1v3Onhhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836464; c=relaxed/simple;
	bh=+deYL4WBlXJWKQEpgNwbfhUrOdLyhKqyIlelJn25hNA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dNiqzi8mU+kQ6pJnIn5boivUBhfrPHiSsAfFRZvDqusrf+ErqD4oZQPm8b5DXf8w2s/ATvmS/65gwPnPajJZvEMep7U1fMvm8mUcSk4nPLpBYVJ0vbX+E3OR9/1O4kAd1h/qlM7YnVaj+XN9ilC50dkDDJb1c/84l4w2rwImTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f63eb9f141so66229339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836462; x=1720441262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwUU/lzjebgwtoQnySebEIMZvhyJodUWf06YFj+rre0=;
        b=Mvhb5KhW320kBFQFPrTu6VHzDQCiPKesONG9wuijFnlkQlDRhM6M01/jIjp+3O1pRK
         fPlTZTwXtSz401lVw/Tpeh5mYO8ahJYqS+onT/7+pEEa72jpN4r1l9wbKy8vwYxBKKCJ
         B7aWJ+79oGJReWYwFy9rfmggrKnpAxnYSCyZBkT189IJLAbX8BDUVTbIWdeVngzOPLGx
         54GTVFMbHsARb21dhAMS+Y4yt06B8skbQN3LHl2QviXgW7CVuTJOZ6oQ34FVAVIWDdBX
         ak6FYbOwxzwZOMVU370NSj/rSjXHMA0k7uLuFwErQR3lL+jFFqK6zdu9IP/bXmJQ3ZeD
         cSyw==
X-Gm-Message-State: AOJu0YxWm5aprNbQbjelhZ1QTkYtpWqkjt02G2ofDJ57OTs4eSO00JTb
	ZcrFzQSrTxtzAlfdif5sbUCYHZN/t8iSEGP+ne27GaVMwbyQlknTsRglrMOKSPGOEibSieqWVN1
	ByxNWo2yOTFTeNhdfyBTM4nNNhoP042OSVpsQ62yKegeoOmHlAKFtVtY=
X-Google-Smtp-Source: AGHT+IH9qCJVN3HstAQD5PBF97/APL/UyLQfzjGiMydDwJa6fb/CgDGnCv+v3p8wNJR21pEG00ZhKu83CKaBAWCvPIYyMsfrtTKw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:372b:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4bbb59453e7mr386926173.1.1719836462510; Mon, 01 Jul 2024
 05:21:02 -0700 (PDT)
Date: Mon, 01 Jul 2024 05:21:02 -0700
In-Reply-To: <20240701100849.13110-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b809c061c2ea17b@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_percpu_map_lookup_elem
From: syzbot <syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com

Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=162282b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ad6a8768920dd4b
dashboard link: https://syzkaller.appspot.com/bug?extid=0a079d6ef3831217a230
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148ddbfa980000

Note: testing is done by a robot and is best-effort only.

