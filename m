Return-Path: <linux-kernel+bounces-231338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38127918E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686A01C2229B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F686191477;
	Wed, 26 Jun 2024 18:29:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71572190670
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426548; cv=none; b=cZV85SWRQlAfZlGLrF4xsyluolxC2ZjETK/uKtaWCtZlvRwfPV1M+bkwuEU/1oYnNMr3TxNCQA7+bLl/sZNTqndjUKG3uaNqhjq6GOlkzG97bzGwsNoJhjfROHwwS28B6GpEI5hNYKfWYVFyipC3c+dBFrIBiRO8cJynE53PN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426548; c=relaxed/simple;
	bh=4/7baJuhh/lT7Cd2eMzZakIwFC/4OqwUDvhcrIGu7/A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dOa9J2DUIf3vn17i77XbkJbvzvRflBY+au9PPmBGeesQhnW/k+iP4mST2uEZOTB191E91VG9fymR3QvXY1zuPW4MbPYa2NK+K9mVYxHLizNkhfu+dXozSM0edhdx8wae03kVUKz2/gtj2X33bixx2RttIFmfCdd0Ysvw7EiLqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3caa9e180so73936939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426546; x=1720031346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dwpjXibG3egVpLU/Cz4ZzBYRJ9ct/ttM3sVTBx+12MI=;
        b=SZjIjOnOuRsLc5nN2ihwG4G4l/x39J1ryVNEtZ1GEMa27CLdbixjzeUSNWxpJZwTqf
         CTJYiZmVbFjuDUMPDsHsBBXyKu3IzCP3nCZNfBGpVqXcD+srNdKsQUf9YTwLZndmx2d/
         sLNZEVO/240NczGPMcp6dO3QC6Gcw9DetnOaiKpItDCQ8BA7LEz6cokcJRDH0rb/w1li
         pe8/Awo6YBq3ITcTqL0DRO/aRJwYB1bHJZwFUOEhUiwb6WdXTNDhqLi0SSyUVm6lHRPH
         0iNsxd8JbqKw1t6U7UO6khEJY2AMOt4C0Div3xTXkzq2HLmlJvURF74Oz7fl1i9pp4A8
         4IWg==
X-Forwarded-Encrypted: i=1; AJvYcCU+49L723ASimMrcaUIMNDGmR7lOVvWdHmN81A0z8WGbRmYkTfVkgqfaRCUce68NkdWU9nH1/FgaPaNNN6GizR78Dl+Wo+MKARhRWmJ
X-Gm-Message-State: AOJu0YxmbJSLCn0fKMbTwTCF+4IoXXPYvT8jL9YOt9cZIFcymQ0CLcmg
	V+7agZ13jP0Bp6ASmMXurp212IjWFtRy/lCN4KVwqPS1g5NsAe9C+42Az8BCnEoNwCHLstNSSkF
	+PhdX//b1N55cQPVndHKrdRZlUzpPdfEJQ2z11Qa12Q5ocXOyF9VNpUk=
X-Google-Smtp-Source: AGHT+IFBXRm+dBGPSfZSWjNzhRkHktbN8nPeJbAzSA80x+ytjT+oDOAM5vlPE9zKuN/nMl/oYxFLwa990b7qwYmKL4y2QBFbf+L8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6410:b0:7f1:3a4b:27ea with SMTP id
 ca18e2360f4ac-7f3d75a761amr2557839f.2.1719426545598; Wed, 26 Jun 2024
 11:29:05 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:29:05 -0700
In-Reply-To: <6d1f6bcc-2918-48cd-bbb3-e8cca46622a1@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077d198061bcf30f1@google.com>
Subject: Re: [syzbot] [usb?] [bluetooth?] WARNING in btusb_submit_intr_urb/usb_submit_urb
From: syzbot <syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com

Tested on:

commit:         66cc544f Merge tag 'dmaengine-fix-6.10' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15a59299980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
dashboard link: https://syzkaller.appspot.com/bug?extid=8693a0bb9c10b554272a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=169b3789980000

Note: testing is done by a robot and is best-effort only.

