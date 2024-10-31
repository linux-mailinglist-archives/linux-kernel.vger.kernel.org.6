Return-Path: <linux-kernel+bounces-390894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1659B7FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10940281E24
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40091B3F30;
	Thu, 31 Oct 2024 16:16:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEEC1386C9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391366; cv=none; b=BOishx3wHe06g6OlHyark1iJXifNiLe0LKcTG5rxI/U8rt051oT7+UgV1e0kvIA5Rdpl5G6C7txQofiGrutbbC7lIjHC1GMvpXEZ/TfGsxi0qS+QdDAVP4YmY1HFY9q/vJkkfV1bQryxeZC2qPEhuVVgFKzGnJav9AXr3EEglGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391366; c=relaxed/simple;
	bh=r+qpItkb7jm3sKFuN1I9GGI0Fhr/LaXcPgtKZHcJsRg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yp7L+iLprZ/c1pMcCO3mTZxwdPFID8WZxEvgjs5AVkV+wtmTgo3rEdnbU5e9cwmFtB5H3qEd5SbQWquGRY0A8/Di381JqB9UGSeBQ+7ktNU4ib91eifRn35rSjq9M1dyh8JQ3XN9XgVR9AcesUC2AMh1BSI9+GUuVHd9iz8E/i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c9886eccso10740735ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391363; x=1730996163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIuVMfyhxzO9ySVh89pLxrqcHKyp4GLyv7o9dDWPSok=;
        b=C/6iiAb/N0zRhYLdY/f5ASp4zIr9uHNsS82BQ51n0Q2HFMl3cNKA1gRMQaHHsHL34a
         vTSMNTLEXnG5NhBG2J7UkB+JfspOfm84CYPkQg2rw9TjKY762N+gXcBaBJejMSZOc8Bk
         VaWqYg9fMvZw7kUTUfLY5VzHkVfx/lHT6wzYmnpE9mHoYbwZjI1VINjQG07+26aVDs9D
         iIbP/BMszn6yMdCZPc72rttZboyugAgEsYS83S+KUAFIvL3sSGnDIIvx8ihCrfa5Q/ol
         +cyJXlZyTnsLeC4OLc9vUbiNI2WvP4ToO4/MgDkele62Msc54Q3eutggxcTHr+8Wnc7F
         oreg==
X-Forwarded-Encrypted: i=1; AJvYcCWnCqAc7rVXiUwCwIuMRSnoE05aAATP+RkFp24FIfU/eNJCDRpzJSlD0n09L2zUVB4yxSr0NRr9AfpE3Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWOCFSYI+retFMUbwxbCn1x7gsZVxbiIaysuc4FPza4CqCAQP
	BTKj2+N/0wPsocdPVwg9mq7MN4dBx/bSalOX1fPIaOHDPF4+DVkilN5o0S4RT3WFpO758Dcdkfn
	pACEp+8k3FXpS+ys3VCWaPIw6J9pnSgzbefqrZypnVpTasOGXkJKggzE=
X-Google-Smtp-Source: AGHT+IEo/BGyXLAGCx+OHQi/PphSmBFD0XQ1zxoj+oxbaX2jSHcfpLjchrLJjoGsgRrvwCssJHcn4+0zJ2VdguwL1Tmp6iICzfx1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3a4:e2f1:936b with SMTP id
 e9e14a558f8ab-3a609a2afcamr39097855ab.5.1730391363755; Thu, 31 Oct 2024
 09:16:03 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:16:03 -0700
In-Reply-To: <20241031111732.2607-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6723ad43.050a0220.35b515.0162.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
From: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com
Tested-by: syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com

Tested on:

commit:         cffcc47b mm/mlock: set the correct prev on failure
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=1548a630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=ccc0e1cfdb72b664f0d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

