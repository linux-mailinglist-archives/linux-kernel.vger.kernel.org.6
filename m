Return-Path: <linux-kernel+bounces-403154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21259C31B5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 665A7B20D63
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BA155325;
	Sun, 10 Nov 2024 10:55:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED614F108
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731236106; cv=none; b=bCD3lRofXtjqAZA3kY2uvAHRzuxL0u9BnnyA88maVhAygngpah9fOsHvEvUeE6YEsFJ+GoGu/vaji17eBJAjs5wt1Saj+gsBmvQpdvSd1pKdXeZdNotEwxM+dbvNIaZsZ9/M2Fhst+zm5qPsukdMBnkEbwP7CbWfnu4QJ/RUQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731236106; c=relaxed/simple;
	bh=qp30AENi8dcgpbgR8q8aWwhedRUsRchicjsEyep+G7E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MsghhlCrcp+RfrMxqT7DtqAGutP8/YGQcm82kR+G7O3VlrLKuCXPZmQlebPr+LC/+IxEofQoqSmCgw7MkO77Rkq8cyyz0Pm8bAe4iiilw7NvDzjpCa5prlsFxvVr7AlKpRU+IgOODSLqxuVzQjI0993hrALiWeZ7g3C6lTq0SoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so47289865ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 02:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731236102; x=1731840902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkrHgi6tIDZKDVhNeZ89zrLoylCI9aMkz19AD8osQ10=;
        b=fDUaaVp1p6ElqWLWe89xIRXdyEuVvTpyGP8ExqqF7DjMzr2eupt8j59CJFY6ca3ZJV
         dOpVn5QpBRL1/74p6v0XKmP3HoCH8FndWxBNZO+RPOaa7hfQv5r0ClRbRWV4KUC4Tm6I
         7GkvS9IjcyNkFBygHphjueAsqOnChTPmi6a2uw/uGQWfgUXaoobPOXstsnvYmpUMBQsi
         Am+HqBna0Rvtfnc43IPsoAOJlELJCjKXldENDI1y7hcSikZDGGJxsWkoUiMbmzuXFAbJ
         7d7Et9F2ibd9tVVdmWJi0bdfiROghcLq0YMS5rFGVahaUMAcfjN3rLGMqE8BCY9M9uKE
         45rA==
X-Forwarded-Encrypted: i=1; AJvYcCU1T4EHsyI7y4u9JffQgzCqkl3x6lU1d1Klg016q/worvQ9jpun8IMne9PMRlr9He2FOfIIoWN7ZSQpy/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUFfbUdu3UDhHul12ZLrISZQvC9c/Ug3LLZAiW59ubzKQmvBD
	UlPemkc4b+HX9GZLA+gqn0Z7cUfcsHRf9Vawcl4Uos8x86Xwr7Dsmv5Rgt4c14iHYvQekh54iJp
	dtIiKFjECNTK5CvanQjIT/G52RELD2TUQoPP7CpO2dx0JkfrwyT/qL48=
X-Google-Smtp-Source: AGHT+IFAs92Gwb0aXQftJab7U5XVyZHIVCEeOqd1umax+/Rh6VlSO2sxjsRp1vnO1AhdxCcikj3wrFudLW+Sqm7j3Nry1ZTmiWeN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3a6:b258:fcd with SMTP id
 e9e14a558f8ab-3a6f19a01c1mr98799655ab.1.1731236102561; Sun, 10 Nov 2024
 02:55:02 -0800 (PST)
Date: Sun, 10 Nov 2024 02:55:02 -0800
In-Reply-To: <CAHiZj8ieKPXqLKx4oO6Vhb0QPU+8hF9B-gaQ=Xinawrqv86==w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67309106.050a0220.320e73.0322.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, rafael@kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com, vishal.l.verma@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         de2f378f Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102594e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11629ea7980000

Note: testing is done by a robot and is best-effort only.

