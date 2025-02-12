Return-Path: <linux-kernel+bounces-510850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7248DA322D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644BF3A7A99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7591208994;
	Wed, 12 Feb 2025 09:49:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A22063D6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353744; cv=none; b=sMRTARUs6IObvzE/jlIoc4kp1huaHF/kwUaTtomeSwNGyAC7Jxk8DNsICqbHdteMhjeDGDRu4R58PNP3UAACU4im9zaTiWG/PA6JX0iFonCsa6f4Pnh4AnRMP1C+wbk4gQKGVVy7f9gd3fMQBRIu+QCo9beejEbMTL8tI7+mFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353744; c=relaxed/simple;
	bh=rkCwBPKPtJ49YZ4SFX1SLtCIPwcFJwzxFPxxODXwTlA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dcSAp4GxtlxWYBE/wU+tZvwwpdsFG7nfE55no60ktNwthok3utwRadM20X+bcXeOEIs2jCLjWNv97oE0z3TPojgb6j40j9c9KhcD2kLE74nVzRKpvWfA51SXOOMKtD7Jw39qltXEoNgMrvYCPHqnBGsA4f+GxxZGHlJloR3vOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85525d6d034so588830839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353742; x=1739958542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io45Eohejs+Fvr4vaR6agY2CweeHHv/VVIkUZcuyASM=;
        b=G/dZDa0J27eUH3YzMQmK7BwBrXwslcvGs9Dom+tSSfeBlUVUkVWI407Us038x6IcA2
         pnNrXTTTe11UJFysKwXDqthbpDaQSuSLQ0cxAKnmzqXsttIJdptKEu7gJw6M4x3qlYGL
         RgEFGLa9LGTISMIM+PxpJO8w+zopnpI9mxjawcWXDAK+GPnrRMcupJ4WRv3gfvQF0Bkq
         OF9Ie8irBRdhXgiDhXKFyakgs9+2cCK8+OUPl7xCnsa8cqTylBAUhFtBux5Atw7MFy5d
         L6OBD+3AquukiP8mxr0C2IpJMPZX0d998zjFz/IfN2eNg+jEwYiUWSK7BPBWdRoCd4EU
         Vr0A==
X-Forwarded-Encrypted: i=1; AJvYcCWsSo7m1yOKXTdypAOyCDhJBD1VTRIEkivO8guH57Ggjvv/dvQO3F0LPlhQjzxDQg6nz9oCvUpl4Gbze/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01EgEsyZAv8sFoJDDPtofEcemGwDAKnSZkIbZtrrHmlH7IO+O
	CbHQqsgxigDiEgSFMzev8DRuma1BS7KuaWsMc1HXbdUsXtP4WnbC8OQB7IvLWiVClYyQ74APAyR
	TRygxGxRx0+rHGrCMIcqI2PSPY4gvYKA6mu9t0Mlpje1wHXA2+Y17igE=
X-Google-Smtp-Source: AGHT+IHmzz7MH3fIY10rUZGar542sOj+lOZJTturqEGQw5yGoQNxbyXt3oX2g1mSJu7UbCOXups98TFKVPsi0BkfK4eUHSS2FCE4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ad:b0:3d0:47e3:40bb with SMTP id
 e9e14a558f8ab-3d17bf4a445mr26670935ab.4.1739353741937; Wed, 12 Feb 2025
 01:49:01 -0800 (PST)
Date: Wed, 12 Feb 2025 01:49:01 -0800
In-Reply-To: <71A3E5DE-50CF-46B9-93A5-8A27C1817F01@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ac6e8d.050a0220.3d72c.0140.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in pcpu_alloc_noprof
From: syzbot <syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com
Tested-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com

Tested on:

commit:         09fbf3d5 Merge tag 'tomoyo-pr-20250211' of git://git.c..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cba3f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c2347dd6174fbe2
dashboard link: https://syzkaller.appspot.com/bug?extid=fe63f377148a6371a9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f28aa4580000

Note: testing is done by a robot and is best-effort only.

