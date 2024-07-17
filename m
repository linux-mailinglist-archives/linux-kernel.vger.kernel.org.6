Return-Path: <linux-kernel+bounces-254919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4D93394A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD91C21153
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199038FA1;
	Wed, 17 Jul 2024 08:42:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86493BB22
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205725; cv=none; b=Mb4TpSZs5GPgxfYs3v+e5W/xoofVOZOBrJzJOMEjxZrjFfYq/WncJPEeQM7Zb/Bymk85eWMTM1WDAJ6H6LPJ3OL1g95JiYa8Hph8uRfqujCgN4L+L7lLbN/DLwZcRIOfHBEelSyQuARAKpvnuxHNr4I72xl2AtKJNUgmbyDkWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205725; c=relaxed/simple;
	bh=UOIBL7aX3RLOn0PgPQubUIJjX3IhyxtqWGDKVPJ9T78=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RjWxhuBS/vj2WdoZwzvqqRec9i+B++NCZcx68ssO9AjdRCFiLCrmTKQEGr+sHcczOdfUPKHVVoUl/B/Jo9r8t2iyZ+KWzzrGktnaBgFmYxgjphJoKZzYDWnfY6yS3XP0pVNpZQqJdNq91WxqBAQGV67lw/bzpM0IxZ4Vfo9wFOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-38268e4ebfeso12576055ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721205723; x=1721810523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9V1geFRQ0NNQl7yDxNdS4mWzCKltiTuEdo35eA4xiVw=;
        b=LpyW7ijSJIP6WLB0HFwp4KKIhLPcUUDt2wHUeJ+cBCcdBZD7byk5xxJ8E/boxpIJwu
         Rpz5DZu0tN85N4xQ+heYRGvPP+adKUVtr8XJbX712hywJdk28HjpOTl7aZYtALL4OQy7
         zL2iDyvGNxEjxmPaD2xXrpRNkO0baQ+PCCbYZKOWzT2qoI5oExYEA8nKFYaCGFRBjHaa
         7zsGhBowabwsVxGatxEzdxNV8Wuc5UqTaLftTm5lZlQZDwCvn/GhTvURdlzlcKr4BB3d
         x8K02k7yDgPcIGY5wYhXw+/gDbVXldWxZ2SL+WgSH5XpwGngb3NuyPfB/Cu1vaZCpvNp
         YEzg==
X-Forwarded-Encrypted: i=1; AJvYcCWlqRAgNZ/ZEHA//pdKiVv+2JwSm/Pys8oQV1DeVPWt1qfEtTFWr1xwusj/3e98cJ76b6ZVxzJq5oQZFyVAVk473g5hUgD49moSfCU+
X-Gm-Message-State: AOJu0YzVgG6o5FTxEiq60fktVTeFS23hUR7gLBTmNMxDSShOxYpLt7EZ
	hcoa6B/f+N6k7s6ju9ZX4mavPckCkyZhzhiZ+poy+G4xT0tsyiQN47PoPoavVW3K0N+Ye4y0GZW
	dOD97NK0k9q9tf4y1ydysI5AgNopf8tH1Bz2owIe0Gjvzuq7Tl8YVWN4=
X-Google-Smtp-Source: AGHT+IGoZ8sxXs3Kv3OJDXWyiYZhyl3Xr/R1jx24Zx+SnHcxw0nxgXrkstDdMi7zk57HE6vkWVZWkdPhJv5RtZyjytWBnjUipqZu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:376:417e:c2b2 with SMTP id
 e9e14a558f8ab-39557fac7bfmr1089725ab.5.1721205723104; Wed, 17 Jul 2024
 01:42:03 -0700 (PDT)
Date: Wed, 17 Jul 2024 01:42:03 -0700
In-Reply-To: <654aa65d-c29b-449f-9df9-d8d6775b0355@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b63e2b061d6d6fb2@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com

Tested on:

commit:         d0c3df62 ntfs3: Convert attr_data_write_resident to us..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10249a0d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc26ad11927ab7fa
dashboard link: https://syzkaller.appspot.com/bug?extid=5b6ed16da1077f45bc8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

