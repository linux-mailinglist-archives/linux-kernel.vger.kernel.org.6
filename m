Return-Path: <linux-kernel+bounces-433270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C219E55CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243E91883DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2421885A;
	Thu,  5 Dec 2024 12:48:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD51C3318
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402885; cv=none; b=Fy5Yjyj+JVba8ZIYVdl49CZ02p1vbtNMbcyQaABPV0rMWSX5G5lSVwFsABqRxnxZPA8p7E7z+ft6EtSuR9FVRwe466KGkngKFcT4DXZghTU8+E8bzMSkm5MACL9UK8xsInEffNog/AknGkzFwldoFH3VW3i8rxi/6iWVptrX984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402885; c=relaxed/simple;
	bh=JtW9DSn43JnTVXM66K7n/AOhN7dK9ZqeMne+o5dQK8o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lu+fcgwNUfrzQrfm9Kc7VYbWdCGm1PfjBYVV6P8CX3VQh9sRib2Ogsdr6GQ2D0GuZ42Rwjl5iZYvcqXfHKt7DLsdfOuOaxW0BhIjDk6jyJHZMqKJFnSXZKvEaQPVahmRZIVrmaSK1Hi3FB9KgO+yvb1wfWToqdAAuo1h+YfLs/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7c729bfbaso7797475ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733402883; x=1734007683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0H58XYTkDtD0XBBFSXvQuooWrVnhkbaYnS0ZTH7egGU=;
        b=Kg/MteBEG2ojuXeKjA1V9LDtLJi61zwp4dPj01SCBpaaNYXR+1pEmFqU55rpQ3Qz/Z
         1PF7pPLqEdyfRXuPApT1qDVhuj50O/8Q2HqtvwLndiz019RcL7rO8WFL8j6uDiZjaHTj
         r0+6YPotwL3Mn38hIs29yUXnvxYDG0y3X1BOsMSso4SI8qrfCksmBtQpvHpTAdhzVpqr
         YBw958/XRpruytAlUwOmH5Dec37C9LkTa31JuHaWeVb/1StnYUulLbrCX3EtYPwPquiz
         XGnf7MS5bLzQP1cFFXeMTe58B+ojYFrtQN3zpNkGD/4yyck/fHbmkQJgMTArQpyh2mOV
         ClYQ==
X-Gm-Message-State: AOJu0Yyg4MIKBUEN5fMs1Y56PMm++mSadT/A/jENNI7oMO/CmAqfWwSz
	IwKzg48hU2J0elXoYp+8K5RPbxfPvbdaqs8U63eCF9cCsV+XQeyecfI3KBSY7sCQ9tFyZ3LMypi
	3WDy9IaOr8pqWAbpEwMxQ8LfQbtSYxCCdG6yS5uREW2GqUq8DxVVcH/Y=
X-Google-Smtp-Source: AGHT+IFPy6JVWq63BymBKLVMAU8WfdOfu1g3i92PSSyoncoz/k0//Wk1ftJdy1VGQKult4GF2j8CQbi5ckW7sjr7xB91/H4EGXuU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13af:b0:3a7:e592:55cd with SMTP id
 e9e14a558f8ab-3a7f9a4e21bmr118917015ab.14.1733402883177; Thu, 05 Dec 2024
 04:48:03 -0800 (PST)
Date: Thu, 05 Dec 2024 04:48:03 -0800
In-Reply-To: <D63RG2V1SJD8.3JVR47OT0IN39@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751a103.050a0220.17bd51.00a2.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/mgmt.c:5525:3: error: void function 'mgmt_remove_adv_monitor_complete' should not return a value [-Wreturn-type]


Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10368020580000


