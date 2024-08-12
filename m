Return-Path: <linux-kernel+bounces-283720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F9794F824
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0D7B21215
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28819194098;
	Mon, 12 Aug 2024 20:21:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56903191F80
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494065; cv=none; b=kbOPKa7QlqOgZUo7dFNqQJU+1P+UZK0A044xsvdSQubpxABM6xc8Xu40/67LhgNHlA71FNkbobHiXBiPzqPWooX40rBzTZ3X3J1QasWoZJ9/so5nbi9yywZzbrOSFpa5mKhw+AO14HOhtb0e90JE89Gk5EYRHnAMvUcfW7F0IaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494065; c=relaxed/simple;
	bh=UbmbfC7e36OTI4cYk1OKjlF5GdQ5iHnM5dvLpU9Frbk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nEmfUNMJnTOzkAEXzEixzNNDMIlR3QOo/h5A8ebl3qQDKnz9GY1ebd9o0bOTPTZVDohzOKVREmMAK++WoQybfDhQvL/G05kP5EaylMapChg91zc32r8eeRTedD5H39KdiKix19thntnn7WPKEr3YB0hJzxBaC5xiJKQLH8TrQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-397e0efded3so71827235ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723494063; x=1724098863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhX0NUR56YcJKqQmUDiMRdL3O8rX3/tbBH1Xo/h81SQ=;
        b=iQcif0dBf2Lbgrchd4pns2pETHeqC5jPuORYVjL+4M/7zpYx5I72R+/O+dLbJ4o3Cm
         +hE9M0ntAr/jY9IbqWpFtnx4fP50QQ86+ml2AeLhx6zuaKyew/SW3URtMNYcbSlO1TGH
         8qxGUP1Xlr1YlWQ0OxXrpZbx5VNVWymi12qsCvMd6b9M+mmIFSIX+57ZbRUN1kqUl2M0
         UtmeUoFX/BaGN4P8cU7KSy26Cx1/pht8j8f+i8THh5C8Q+KtTarm6amlaFH75FMBRIDu
         tmwwtvcc9w9zewjcXBbKmapFRH5vIXgp1k2RKHKVguYul2Rt2Sj8aL46o1O3G7j+d8IG
         ncrg==
X-Gm-Message-State: AOJu0Yyyap2CtpbfqD/Ggnoif6UDOO9NpzUd57jtbKPaph1VEB5spLXS
	nJUg3Mr88Gq7WiZESQmPv5N6qggA1pPVnnIJ4Lb6GK3g9usS3BM8gOfk5vmzhFeFmvGO1VBtzhP
	bCd2oZg8oBj1+m2l+eudUFjDuZCguqrHq/ltBILUuc8VeLRxHKlbwp7M=
X-Google-Smtp-Source: AGHT+IGz/rVqYloft7OZjYCuAu6ZH0jb/UqSoy886Zzdm/kmpYqyHDxUGSLbEoXJsD/qttMmEKtQqKm69F9jNGLchci0r1P+TWxt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:39a:e91e:38e0 with SMTP id
 e9e14a558f8ab-39c479311b3mr830265ab.6.1723494063083; Mon, 12 Aug 2024
 13:21:03 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:21:03 -0700
In-Reply-To: <CACzwLxh3b6tBYOsdMF_QqGDrBPE2qULgg86ToJt-OGQ142Hneg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006728af061f823b83@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in __flush_workqueue (2)
From: syzbot <syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, snovitoll@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com
Tested-by: syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com

Tested on:

commit:         4c278153 drivers/xillybus: fix deadlock upon cleanup_dev
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux refs/changes/82/25482/1
console output: https://syzkaller.appspot.com/x/log.txt?x=16dee405980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=801d05d1ea4be1b8
dashboard link: https://syzkaller.appspot.com/bug?extid=e528c9aad0fb5383ec83
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

