Return-Path: <linux-kernel+bounces-397703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FAB9BDF40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961E3284E48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206D1CC175;
	Wed,  6 Nov 2024 07:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6B1B5EDC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877604; cv=none; b=j2JK7gF/JFHkT+YwGhdlwS/uVPawvSjpkZHhtctKxaIaApn3Tid+CprQxbkJ47PNAuSKSKYfJItzUAUR+ymb8EJqqUVC04cePwWj11cmMv3Z9tgQJS6ahwxEePVX1vmH4gQWt+aPLzvE+nUq2P7FNu4RLmcGMZoOaJZ5Ie0+tGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877604; c=relaxed/simple;
	bh=Y270/xRUpuj8gwRE9wa6Q0/PzwMPDFUT+l02kpxYJvc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BX9DijZJ231xF9FjgIavP0rWvksojXb4VS4fLqeBvBk97nMlrQ1hdhAK+brADXZ4UzZ0v84bbyAIG3gA5dGP5FJDkiqpXn4QXZcMc76FaRgDNtDslUtlBHEEKIHbVVdRrJfVHTJTQQe3uoidCn7H8yEwctdAfXGdu2MT/QJYLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6ca616500so37089035ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 23:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730877602; x=1731482402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRoiQ9O17ecUzInDNwHnviQHANv5CWKXk0TEsKw6AfU=;
        b=JoQH1xPpe9xwTpsVIvB9FtsNw5GcOSWl70d63E79oI3eK975DUnN9xIlHc1XQqJ8QX
         PQuNAPESZoDbS7/5V9TeJ49DeCmK+Znd3oC0wdYecJ6sZmSJhtxxsjdD5kDofOQF1C4P
         ebWQvH4OUlAR8Kbkysxphh3yr2E9onngMNWJEb4Eq7DO8/cpJHiGFzy4y48H/l6zM1DT
         fy/iEzjhmlW6B5SYT/yPu+uz5oFvPLgFMZ/f5eQGbjIUfgHo1avmaqYJNBn99AXDPWF/
         WdZKIaxgCwBbK0rs4RrKNLsO+weRDI+jdwZ4JXyAbblI14Y7l2IIIIHojqDuI3yFAaot
         wRSw==
X-Forwarded-Encrypted: i=1; AJvYcCVTOzpkG+yGl3Kd89/fF6Vle1oj7yjyPhUXA2cQ7oAE83DgZmTbsc/3E46zdFY9MWtgJFHC63HLyxuePrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySk1XvYtE87kQXBms2iW1CniXu1nMJ0YU8D/fPtiJt15sjHRBl
	Uj+qlVRXxxLAfIgcmPobaTDBc12ve46Xl4BgXqexVmW/KSyE4gT3N6aLP1IvEnx8WPuJr/kiC2d
	V2nbN4ME9PTZEViKf/M7hSgcgmERGyG+xdOetbHr8k16ChktLGvzZKUk=
X-Google-Smtp-Source: AGHT+IG2btnfaVPTCER2vSQjwK27ilgCD4Oq1p+DbbNgiSfEEU/hvxPvODMmmEHFepz0gIRnNtTr1d9+OMsKJi0HRQLikYD54Mj6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3a6b445dd34mr159977155ab.10.1730877602621; Tue, 05 Nov 2024
 23:20:02 -0800 (PST)
Date: Tue, 05 Nov 2024 23:20:02 -0800
In-Reply-To: <tencent_536FC3A5A458D765576F66CF736AC3616905@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672b18a2.050a0220.2a847.1ba0.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_bin_cmp_key
From: syzbot <syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com
Tested-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com

Tested on:

commit:         2e1b3cc9 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1017f587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=968ecf5dc01b3e0148ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1233f587980000

Note: testing is done by a robot and is best-effort only.

