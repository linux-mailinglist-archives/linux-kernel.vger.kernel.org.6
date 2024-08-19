Return-Path: <linux-kernel+bounces-292115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C8F956B48
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971A71C2206A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872616C68F;
	Mon, 19 Aug 2024 12:53:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFA16BE3C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071984; cv=none; b=M6x9ylXM4w3dzXeBJkecV98LYminy82T6MRIKTraUhOVl+frEs72bXpeillV9BD1MxseFO4G9lMy3Lmh15Iw6mrkYXr6hPDZcT35I4vOzoQg3raAtESB7wnhBj+eRm7sufn6efbvyC0sPK4U5dHH+uNcFpjJaLTJdCLYq3BhyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071984; c=relaxed/simple;
	bh=X5pABsohzN992YgymNgdYOqRC/dy+WQh62GZDXUg3y0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bQuDOs237xJvZDN3NyUS8uEDJGQesng+qTSzI7MVz5vJc8mUmhl7h8oAX6YkQCiBDTirrYPl9vkaycPs8nOTFWl/Yr4xLaoQT8GrYbTxt9phaenIvVo/v4hjfjTsHiH223VQrnKd/zqPh2l0AmeWlGu30xcj00Kj3KNw2s6iLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-824cae494e3so407115539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071982; x=1724676782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9Y9VvtUrbunpeMkUGrnk1PlairEHkTWeoZ7yal3l60=;
        b=RI2q8MiPEoZjE5//w44be6W5KkooR2Br0UIUU7Mdg/ake0VQJP+6FByUfWpgekO2iU
         Tbrzqy+CGgT1gE5AHl2zXLKykWNyoY2Vvtdm8tLsen86LrXhoAkGgbbZlHg7lFB0K5gm
         VyZuR9H4DYhr1ryIdVblrUFcFvLIolOIs/ARPT00hlrSHyNHrIdAqFOAfIV3dHyLyZQu
         WgUWuQBA04WsimaKXnOZtQKQFD023OMG0Dx6so2sjuJvr5+MhoTVdK+hWUidb2mgANe1
         5XLhVEcASMyifynvnTA7YCkqkPAaN7BjD61wB4i4RVx5pGBKwoK0WjrhjIRjYODn++jx
         sXvg==
X-Forwarded-Encrypted: i=1; AJvYcCVzncE2cGBolZISvGvX9FVGXQaWhjOrDHWkocX5686hUzQfOzwFzLduhxfvakJIz3L8q6j8ueXzD3bCxm55GTIBrrjovtbhxN+BLYpi
X-Gm-Message-State: AOJu0YwcV0p3LB00pkfYGbPfMZRVSlpCRpN8Z2VTTHhrEuOS4kRAseZq
	YwX95pCx+I+zfP/Zpg/LwZLOz+gn5o4bFPwWIrX5rdRmSFRM09G82/Q6ZISWFN2LjCZgTNkABUK
	T3TP97H6hg+Pk9Zm5jrxd8pv1LoqLPwBea89zq2e+tncm4u3qFrvtVps=
X-Google-Smtp-Source: AGHT+IE1XgiBtkhxIO3hlcxpa9C6S8mIBn17MQjyMAA+VTY+qvp5T29PhcHOc/oH/vldkMe/Fd1kVjMEiAwQVvGzB9bxnFmR6OcC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1541:b0:7f9:3fd9:ccf with SMTP id
 ca18e2360f4ac-824f26fb839mr27386139f.2.1724071982380; Mon, 19 Aug 2024
 05:53:02 -0700 (PDT)
Date: Mon, 19 Aug 2024 05:53:02 -0700
In-Reply-To: <tencent_E16C702F5D6FE89404EB76ED62CECC783A0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013c5aa062008ca65@google.com>
Subject: Re: [syzbot] [ext4?] [ocfs2?] KASAN: null-ptr-deref Write in jbd2_journal_update_sb_log_tail
From: syzbot <syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com
Tested-by: syzbot+05b9b39d8bdfe1a0861f@syzkaller.appspotmail.com

Tested on:

commit:         c3f2d783 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14739d83980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=05b9b39d8bdfe1a0861f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ef258d980000

Note: testing is done by a robot and is best-effort only.

