Return-Path: <linux-kernel+bounces-318916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E34B96F508
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E451F23AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9371CDFA4;
	Fri,  6 Sep 2024 13:07:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A01CDA20
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725628024; cv=none; b=WSxcSNFzlgVTyWs17hkzj6wo2qukFX9WG+xlQX/vIbaFDVuYnoNcbtknsb0K7aZ9DpeJfP/qgeJr4vQO3woEPi3L8QSV0fKc2bAHLqgUJvjrEGxhGKXpedHB3m5wudbFZh8cc26i9vHNis5bklOmvjt3WMGc/PoRk90MunkbTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725628024; c=relaxed/simple;
	bh=DSmNql4YsJ6e0HOONJCQ5cyLenqtI4kwdqXPhTZPsAA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JbhndqrCTUxAUjL6TPpP7Dn05G61OViahd6exqE+285VQJsKa63q8zY5wqZ9QzAjHV5GwFBxGt9Cz5IPC78AWp6OLjwJ0muU+m3bA1lmX607pTOtDRnloO3wwEhkjwT+lLy75JIRn2JloPlC1u2Hsl78E9Celjvh3gKkh/TbFZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c81b736so494288139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725628022; x=1726232822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ/z39LrhFhxbN1DaO54UNKT0/nnXjroNPD4GtE69H4=;
        b=OnPEBLPGguPqsIAxEMaYsW3cy2O1TCPu5gMl5muhSI5ndD8xDevcrXwiRantdR3u8p
         LIHVjxoKVmDJyZAxGYO/cDRVePl7kMB0wr5yGo4dMRxvtbC4+ajTzoCxxO3lvJFaxvPK
         MYX7Pm+M/j3Tv4HUnZe06KE0tfQhgbttKgalUIMC7eDEOw86aWolf8VGbIEL4dIvin++
         N97sXkjPhk7LWhqp8oY8aEaskJx3Dr2QG3GYCVIU9hORacrHqprhExtt/uSdXGQJkpH1
         9uIWmPX7Ygje1zHfoGL+luYSEk7o8tiEWgLnna/it7m8j8WFaWCi7qWiVjLIb5zZFL7m
         0SJg==
X-Forwarded-Encrypted: i=1; AJvYcCWm4Qa8QjzmyHwR07L3UCKZ+VFgt4DuUQiZ3KUBr68UBSui6DSTBYZZJSd5uaIuiDVQj+cCBlhgcr5E1+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaYPUIcMp/k/KkRIw7s41sssJr3nE0Xbv9QEKcbZjvfwPG37e
	lM3/a1T24EknAY/yF4mES5OnQ28zKIXZY8ElEhjHbU31NID7olC5mjilUakFStWUAGd6zie9xA7
	w9/UUc4oquW4gCeKsRKc6nbF3L17qSpmT/MLR2PUFW/Bp9fbrETvIyfA=
X-Google-Smtp-Source: AGHT+IFHXbzJCZMSVbXbJgTMyxdt3FsZ/RMr2bvCL7UXlLGINm6UYqJQ37RrDvAi7PA+9B5nqdHYtZ6nAgQ/BeaGl5/CGX1xO3An
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411b:b0:4ce:8f9d:2c31 with SMTP id
 8926c6da1cb9f-4d084cd5056mr119787173.0.1725628021786; Fri, 06 Sep 2024
 06:07:01 -0700 (PDT)
Date: Fri, 06 Sep 2024 06:07:01 -0700
In-Reply-To: <tencent_9909BBF933FF9E791B784B591B1525EDBA08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040de9d06217315f0@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

Tested on:

commit:         b831f83e Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1422348b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b3458f980000

Note: testing is done by a robot and is best-effort only.

