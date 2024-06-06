Return-Path: <linux-kernel+bounces-204200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980E88FE5B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4CC1C245B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F7195999;
	Thu,  6 Jun 2024 11:45:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F6194AF8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674304; cv=none; b=m1433dXxcp1s9ZvhVUfadLFKD/Lsr/wN912oue8QnLUgyZTsFRcomPWro9UPnz/yM+4I9Poo93B6NfdVmmn/AU19Mv0MaSdhYo/BkKKNYwhITm103l4T8APZSxPw+XIQgdQStqiprrzNKa83sU0Z8MUb4ofGJKiJXGyY499hKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674304; c=relaxed/simple;
	bh=NSnqkr/gfjY1p48t+iFaGKw6DOOdST7s2h6VaDJRfVs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O9pE5m4na+UIUiXD6JEZ+79zt1acshupAvwzlHRmljY+fgr9NJnfhRDQY7nRxYaS/y4Rt0D86k3kFchmk7N7zhDy6UERySVi/EPTXBdXMTTw1VpLntaz4pXlLwLlYd4XP5NYXuFex5YrFJgafdIlV4zvyuD3EyNALNtdEtn8ICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb34c7a2e5so88331139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 04:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717674302; x=1718279102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+u7BjMvOtjUoqQAFOQc26Gn/n/2VEOVuCJ6OTmdBu4=;
        b=PDFW6WL02yy9EQxLvCPtq7F1A8Db+WZ1hspjmpzmVactfXDdO7pTnbqmEQkCWizrMT
         gbhIRv+71BJAiq7MotReJEBKU+aBXwptBCurW1xTuQmeOp1CKRLXWWTFObhupQHRjgCS
         h0YG6/VXE54OUvacAVkcXyXOfXYCvPTqsoliMxMqvlAiQ05qly8XFxjXNoEjeWOlUzVz
         OP68dCLirpR3q7p7OOcABWmVPhwNZ9lHrRaV4ELZfkA9I8NkyOFpiIhe1j676pq7sjd6
         uEo0/dY/gpTp78H/Vtym15nUWEdY+9e3qfLiZitQcGdUHcNZHgCnQiHiI+4wICKXyWEI
         d5FA==
X-Forwarded-Encrypted: i=1; AJvYcCUhGgNx2YCc5SO38DsiZ0IV6JUbYsYioCejLYTM1rVMrStcK8gmCwl/Lax8Hn1MR8aSpMu+UWAzfuTbtJU2H2Kt4SX3ZNZJCEBe3mQk
X-Gm-Message-State: AOJu0YxWSKGHQceIkSOHQR/hQazryfS6d/1Y41qqvudO43jvDTS9/itw
	Lshhb+8dqCItLpdWzt0magc34CWg6uKzQN6EKhPCnCSZ894QE/hp2UpQq2hf+R9Xf/Kqr7Pih0q
	FenvrSWhXxQnPXFSdPLxURNzHjb52xw3Ut6V9g28k9EEHHqfkjQ7widg=
X-Google-Smtp-Source: AGHT+IEvVTLQWUUVW4dX+tdko3DC2U0Lom5rowVnSiDS6z0cgoL1la8PQ1WzXbE7DP2uJQtxcIh6qg6wbHciCneAEo3j5dq++qnX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6406:0:b0:374:c152:3d45 with SMTP id
 e9e14a558f8ab-374c1523fc8mr182895ab.6.1717674302623; Thu, 06 Jun 2024
 04:45:02 -0700 (PDT)
Date: Thu, 06 Jun 2024 04:45:02 -0700
In-Reply-To: <CAJfpegutqoJxR303yk_8pkvGidEztteGhTpk2uhf-oC4AXdZRA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5ec61061a373662@google.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
From: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com

Tested on:

commit:         24601487 fuse: clear FR_SENT when re-adding requests i..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15256e16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=da4ed53f6a834e1bf57f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

