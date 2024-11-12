Return-Path: <linux-kernel+bounces-405958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37D9C594B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227BD283469
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2740176237;
	Tue, 12 Nov 2024 13:38:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F166B15855D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418685; cv=none; b=Yous9ROg1VSxqHIVO1Df2nDdK4fWtqgPAAr4dTcZIvfjK9Tu9aT3m3Y7XsWEX726djf7zQRU4Kx/77oLqoB57ktIca5G6D1vSLCCIhGlWhIe/4OuAc1jUzWpIz33ewKRCe12Nj6jXrw19rvjpmGyfiAOC1tAQE82T46LqbTj3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418685; c=relaxed/simple;
	bh=h9Yu6xzR8u7sIBe/39NUThidTgBH92L8zb2PGNCcdT0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mTyu2xTs8lKN+BpAAr3r8i/QDuMiUelSAtkxx3vcamJyPKY3hSGiJuQui3serUMLPGZMORvRJcXKaDBCue8K8TK1EwEsOiRrvixaRYSwuw7xnyycDvRhyVOI/A1T2WriIdcIxvj4G110E1lvqbbZcRzXvhZm4n4HAQj3X6OuscY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6bd5be0faso72212485ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731418683; x=1732023483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GJ7YooMlQWOoC3zDWFNKtt8nEbMSfaqwcpXWS4ndAY=;
        b=gn5nL11lHpB3KPwFC7nafs2L+DYtZmT6mbenPV7CxqUrTq+Lqn77UqLPyFa3OHQFP9
         0pFNjqYLetpz1lBdC/Sh5O3G+s0CKCi8XaHk7wbgGXi2hMiVoBldx4nxnZnnYGxK8zIl
         X7Tn7VGhPcNAQyFudwq+Xkw1b+u43BvuLX3UQ0tACY7Duv6vUQ/9qzkKCPb7/MlsOFWJ
         puoTVbS63pUEe1seAXeZc2xoGCfFwRl955KstHaIiqNpEuqjOifpzDYbRrA5Yso4o6cT
         CVHf78+c2sYljhVI/wu9QdlCVpYNlA4ihnIC5FvpsWpTIkKIai19CQxl7Dg5Zv5ATd4t
         dBhg==
X-Gm-Message-State: AOJu0YyScw3yNWMpd3LC1stFMhz+FvSjLGxwOafEVBU/Hf9mTiyTKakF
	u2PFBeWQ5B2RkoA70OQhPD32Q5DPWbII4mBieJViZsQSNDybv2ZfedBdFxc9Reyk7CkqbKaqamW
	O4Jr+4p2+2wASJsEWwJ36oAcUM7Er7bLzQme4FGx5mM5RfnCvFL0a+t0=
X-Google-Smtp-Source: AGHT+IG5fGNxnWpuiL+9MmirWbqfsxjENBHZli6EcKB4ApyQJBntq6DHTKtD7VbFxPsk+Jh98lOvd8GhlDYqP2KdofXIRTf7ipVk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1486:b0:3a6:bf1a:17d5 with SMTP id
 e9e14a558f8ab-3a6f18cdbacmr169367315ab.0.1731418683169; Tue, 12 Nov 2024
 05:38:03 -0800 (PST)
Date: Tue, 12 Nov 2024 05:38:03 -0800
In-Reply-To: <20241112131142.638876-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67335a3b.050a0220.a0661.041d.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1298f8c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1130f8c0580000

Note: testing is done by a robot and is best-effort only.

