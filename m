Return-Path: <linux-kernel+bounces-181189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D58C78B3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702FB1F2357B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD3114B96A;
	Thu, 16 May 2024 14:52:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5478A145FEB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871126; cv=none; b=tZQ4it8cjpHpfFgJpwYmGWhpxKz9Zgr6JOWRx9cHeQfNwzkdKBlddei7YXMSwSF+8XGCF2DGwTzESrkByR7A9Ced0zBWRVCyV5M3OUjpLxc304KgH8BddTF4sE9ViU04rSPSj8Y054jv1CjJrkoALNCnPDl3FZKUJVOJ4J1LKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871126; c=relaxed/simple;
	bh=MEKwTfinQ3+tsYbToCpzW7toPpNK5dxfFiaRQoDyleM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hWS+0mRE1Lony9LhYsDgxy3jSdZQ2zAKmtuIf+8r/GusE3LiRNBdm15ZOKdteYTReznfbzUbCoHfDDCqAQGxpYejb7s+nJEIpcoI42FhrUq4UHiQ7clPF6iNjdRUezDLqquQt4e6sxvCYQ4HiA4dX20ZYJwnVzhYb/Eab8uMfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so863231139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871124; x=1716475924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w5iFDZEuDDaIQsZgYKRfYXjxpxMZusIjleMGo8+W/o=;
        b=pwPOU0AeUNpTg6JW8SD7+sN0DjnU4FAj53KRCYcrhg1QyU4z9kQBP1fc638Czvjuru
         63G5id24K3aMg0Yapglr7s7B63Ts4CWUGcywz2aNMXc5aoGB1A5FxMVpTp1hRYxNRTGg
         ZLOh6RUMqHw0CK0fWgrbYIddSXqu+cSB8WasQJCx+UwdoSaV5uDmISQJ4z2yuviDtnnK
         S04faeUP8CZwWl/Cjl2jfWaDwI6o7Gp1iZpQTOClp/IkGAMuwqWDavb3E9wldi1/B/Lf
         /0gMkFgg6wPJp9V4pVtLg7/6U/RcZqkCMNucYG/R4Mb03vW9hdKjfc98BfR06l6cAPZ9
         DN/A==
X-Forwarded-Encrypted: i=1; AJvYcCXUt7tlet135wASJGtCkobhrloH/JcgaJYTc4WTbTEQHXHxwnj3Qa+YOQEaF7hAbkRqet0G1AhV14xxEZwaOx9DOjaktA+GI365L7gy
X-Gm-Message-State: AOJu0Yw23phKvWOOQ2HQ+mqIglj456wAgBb7E2Q/dp1QQqE7WorSRTWh
	ftn4TXtfDB0qNOHxpZZus0sIcvCk/+95o4RtjvZpfZb4j4M6htcsjETPtTZMJLjuyNkPrsjnQk5
	L68UP9mb3i9vDStWmvDqLARZxBpED5/ydTKbLWNEdpVBM8XllctaTip0=
X-Google-Smtp-Source: AGHT+IEMzGQLqNXuUZwQynm8XPRB+X4/zFNYXAsBPOFmlkiV+gSnMrSb/JAZCbhNzlCLhE+qU0QclNBH9nUUVyUE7ZIDxoOPST86
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3ca:b0:7de:e175:fd2d with SMTP id
 ca18e2360f4ac-7e1b521f29dmr154874939f.3.1715871124641; Thu, 16 May 2024
 07:52:04 -0700 (PDT)
Date: Thu, 16 May 2024 07:52:04 -0700
In-Reply-To: <20240516142748.3376-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd6a3e0618936093@google.com>
Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
From: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com

Tested on:

commit:         26dd54d0 Add linux-next specific files for 20240514
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ccbf70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8af44e051929224
dashboard link: https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13960e20980000

Note: testing is done by a robot and is best-effort only.

