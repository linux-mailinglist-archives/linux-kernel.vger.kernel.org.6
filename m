Return-Path: <linux-kernel+bounces-365480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6235099E2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196121F22D96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF01E0DB0;
	Tue, 15 Oct 2024 09:45:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29E1E1C1A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985505; cv=none; b=UAjGkHlQT9BiouYsitKXCj6RpQCASg01poi98vnHICkSuZ+F5afSKVfm9nKoWsNdYujpT2izKol4PzU2M8eODu8tzMrRHy7Lzw5v9AsHGCW5fBujHu5Bp/l5bZC8PeZDc+cPCTViJK+t7NqJyoXTvd0dSGUZhCB9xKk5w6hI3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985505; c=relaxed/simple;
	bh=s3RUsSYf6HEGJZkKbpAcZcDrWM8Q7dEpXU/OWdX0u40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kNZXBWaHUNBaAUUGG+zk0MWlBzbQCn1tTDVDhvOvzrXdfWhkIdW5d9v+8YKXR9unrGBYkEL8UKfonLHp4u5Q+s36UE1IrLKJSYfovBJaLyzt44xgTwcVg2sa/WxRGL2hScscpI5sPrS8EWKE/iJPctKDkqZcROHCyRCP0E1ZBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b7129255so57693305ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985503; x=1729590303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xALKlN2ovO2mb0V6amAaOMXvrsoZMqemd7QT5SbNimY=;
        b=El3ftJpW63MSnetSe9wsasZuaiM48AKPmDGR4U3U5MIfD2kyPD97qzyMzlxpP58vYJ
         McvjdkQ9Iz0yLEqJHnf1BJg3dp6LdTsThfGzoBnzNd0b36sJE+EL8vmQq/WTBGjCLyOC
         KWxDN5g5PvM4nS1L075bxJsrFHwioU+2zWgEVm68GAbVR0ygY8TN2KEw+U7cY2GPoytP
         o2l9kE02Rg3RRrFZ5pTG60aAl05zFu+u5eUxPjUI42u53qS1WmuP2FYyZSq0EBPRtf7i
         g9RgULcVdd9A73PcjUbwOWT72SB7Mzhf4osbaU8K3/weXFjMReZHdaZK4fKOUwL2cmPa
         hQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpAZWv5XGaxwIOBo2u6ei7N8l8FqUdPKo0ro0EH/Spdww2AjstLAhEvaCgIGQ8kxsNxDZoTbzbVgNU7NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnBtk4zgpGNDsxfGdK+JCRJ5pzsGs3Q5GdUcJ3Qt4XYN8Q2JY4
	Xe87p0Vlm3kzq6D1y3i3ddI1uN/Dvk01rY+wat+/IrAdu37J0SRZ3sutRW/XtiVnNzpRlKXtUJA
	ZrU8wBn16XCmzYWK51AZbW0J5SR2p+MVdfPfi5mce68jlDzd4VFEjHiU=
X-Google-Smtp-Source: AGHT+IEhKRVrCZkAhlCW00Rik13sgAiQvqwQSq4s1KNDJWGREPyu0ky6iqCVETttYYF6Aglj4mTYpFWWQDkjO1p1NO5LjUWf7NMW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3b60558cbmr110829015ab.24.1728985502985; Tue, 15 Oct 2024
 02:45:02 -0700 (PDT)
Date: Tue, 15 Oct 2024 02:45:02 -0700
In-Reply-To: <d38ebf68-46c7-443a-8771-3dbd835a17fd@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e399e.050a0220.d9b66.014e.GAE@google.com>
Subject: Re: [syzbot] [iomap?] WARNING in iomap_iter (3)
From: syzbot <syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com
Tested-by: syzbot+74cc7d98ae5484c2744d@syzkaller.appspotmail.com

Tested on:

commit:         7f773fd6 Add linux-next specific files for 20241014
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20241014
console output: https://syzkaller.appspot.com/x/log.txt?x=138ad727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d6083ad781cbf8
dashboard link: https://syzkaller.appspot.com/bug?extid=74cc7d98ae5484c2744d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

