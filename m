Return-Path: <linux-kernel+bounces-565357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC46A66692
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766A73B9CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393A18DB2F;
	Tue, 18 Mar 2025 02:54:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0916EB7C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742266444; cv=none; b=bB6POuOUF6Ib/ap68eM0U/JpC/mkENYwZFEQU2xFPoHtsJs9K20IbNvR+QaC0i3XqiNB3pohA6zp0qZ3/JZMo1Z7dnNHFK0rxvKk1b/XFKBU4KUk6/Z5RrB3eCNLYmo5S+h64tfIyE43UfnySThVSADVvdCBX+eWuHm+aD51aJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742266444; c=relaxed/simple;
	bh=ExsWMUyLKfb3Gb4mRPAn4J4rMFP2ywmbz+3c+TWmnP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=niWl8QCP8DPQdRsLTSawHCAlZgwrF/or7ZZYrRSgL9lT/ETWStN0+RHcZqgeesLs619cvb4lWT1mj6CVUggyLKEGE3Z6ZADWCvs0E51qYzZNjBzk9iYcWVkQHLX2V+VFseFm6jpOG8vScSQ+XLpTkCJ+2bT8a60IKnrH38boZTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d443811ed2so107112245ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742266442; x=1742871242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fztltw6UvbSlY6+olu6PShWPhIheNzBVy9Q9PuMhtXA=;
        b=xPs/MD45tFOqtInH9xa8OktR+ZaBvohCChSZe2yG6pBeYRbcXsdnHs5dbTHeqjMNfP
         74MNNAAWn+rzsN0SUl97WvGclBLkuaxsBRZBu4Zts7n7fsgjmvePfNpEd+C46iMinwte
         71jOcoM3RwEulEUGFdDyGoJIDZV5h87qNa6Wt+Z84PBWqliZALg5bq7E0Wp563wpIUdm
         87JMwzTYWPA8rgQAcFAcvFK5WmeV2N/7pFU84efDAN4VZ4vbMBu+HP+dWIKPVodR4Mrp
         uO98Q+EqQZTPhFtT4c3rLDFNCnJxzHkE6v373JMesyLI4A1l71em6GTT3hg3unpLaD4A
         g6fg==
X-Forwarded-Encrypted: i=1; AJvYcCVzGJX7Q4iIjo9FdZJ0HRP+ln3a7Job/cVTbO7L9tmBRdOmS8luamiga8n8KrGntt5fRAPLbGjp7gjst+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBf2hzIeNJAlHZ6gjbRJ1O0Dr63BPrzcMPiN9+/8YBQxfcdMRP
	afKSoDQp/An86i9DPAGuFGnatuFDE0jv1xFSPccete+sAcHOZ9VanA8FQk448ep7b6ChJDNiylW
	mjT8ANMOtsoOLdrCdJ+Vr98dzQUNhVtaiEVdctWQnkzgaYfT2A2MyKgE=
X-Google-Smtp-Source: AGHT+IHGWqR39OPN+bUONprIQbY74vvS5hvVHgavDlxChgAFGU9cilZY8uyEbY5EiXbxxxIO1cB869Cy3kRSg7VE9NHS82BXAs4j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1562:b0:3d3:d823:5402 with SMTP id
 e9e14a558f8ab-3d57b9c0bd1mr23826705ab.7.1742266442486; Mon, 17 Mar 2025
 19:54:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:54:02 -0700
In-Reply-To: <tencent_F403B22448977EF77586CAF362E375A96D05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d8e04a.050a0220.2ca2c6.00ce.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in cfg80211_dev_free
From: syzbot <syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Tested-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com

Tested on:

commit:         4701f33a Linux 6.14-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b42068580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=aaf0488c83d1d5f4f029
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174cc44c580000

Note: testing is done by a robot and is best-effort only.

