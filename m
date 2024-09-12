Return-Path: <linux-kernel+bounces-325938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FF975FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 638E7B22DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22ED18786D;
	Thu, 12 Sep 2024 04:15:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808118800D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726114505; cv=none; b=lUGusPEomc4fkvh0ksPWp2LCDOKyKqRGHI9DRpTaSnryPkhM5B3ecXOfP5Bv/TJgF5MmQnKm6ynxbCWas62iOMFwkHvzLy0N4IfR7C0x2ROqbW+StaM7RXt/iu68PKo7EW68vp2Wqseh1I5QU0amPbg1hSWhQ2Ihswyiva8U2Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726114505; c=relaxed/simple;
	bh=drIEYd1p+XKkDRI5e7Xpahbz3l1mCoonZHvzvjjNJPM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iOGivcFpAJADGVY1XUvmKh5LSsND+/5d6zk+5ObRNi/b3AVFdSJxnaBlnIDOeT89uVhqgh6cJKvZ0jrYKR98KSZJmgLm6DXvuBH9RiNIRlRGBnhzZSmJLCMrK0Me7ehvC3NkBFCVTIsVF10xp2w8bsuec7zNP8r5ecu1LD+hLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0459a8a46so7901675ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726114503; x=1726719303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PH1s0OoDbXs6TE6Fmx2ncIwqA7zq7FKWONLeE3QHdKM=;
        b=Lot+s29ihMdqkDVrp/vNgh+nJVwXbuTYembXcl/HcrYsx0Z4Cro4uEN9veW3I7vys2
         qDjjjbmg4ppGdOYjW3hGjQkWz/KRBUd3qHx32fQCsxZOZI1Wh+JXDUFBaXHTXW1AQa9q
         3QQTX3A8Y163uRheMxaqP/DkZpWnNQX8zQKQwcb/kMy5QP3QWiJROq8ETw2oeQ3ByoqN
         GBOfGkB0MfMNd7O7R6WNK6ZdJmGvOZf83JGqPTFOlxVwrmp6MEb3dcysyzWoAvvGOHho
         bry1MhXd7mWNwhxco+0NZjyH653ugEhagcl92OaoNmmF4+ebLIF7nUvUyoEzUwwdQpiQ
         z2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWwGbV1C+6Npy+/wkCnjSycamTXMKj9VFIl9CHkfxHUmmeyHdz/J/wTnAWtXx3qzHPtMSy78/j9+04cUts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKdDaaWuCPCB3yaLXtI4CMjF4/T1kUfJ45AxfCM3X94Me3cyt
	TRikIuc04jP+QGglyu3zHmeEviuY8+uOWFbYn3tLxEhUQSx6GGBjeKGuq7EAIxexZeZa0uGZujG
	QWAwtQWk5twX3L7jsPUtXD7CwyhA8aNGFXwZPVWpQCTDCwV6UqV9rWy4=
X-Google-Smtp-Source: AGHT+IHhHxnZW7kaWAqYFoZTnyqmcge6Eas76Ope67PHfGWnkmvBDSSTwYQtp8OZjRjMMj5q/mcCbYFlEbDJH4yl8YppRnBlUdlb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:39f:b5e7:93f3 with SMTP id
 e9e14a558f8ab-3a084925eafmr13559355ab.20.1726114503254; Wed, 11 Sep 2024
 21:15:03 -0700 (PDT)
Date: Wed, 11 Sep 2024 21:15:03 -0700
In-Reply-To: <2adcb13b-c729-4547-ab98-ee2dbc8cd73c@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cef8a80621e45913@google.com>
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_vlan_by_tcpsk
From: syzbot <syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
Tested-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com

Tested on:

commit:         77f58789 Merge tag 'arm-fixes-6.11-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10915807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf6caa9e11507c7f
dashboard link: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c4a0a9980000

Note: testing is done by a robot and is best-effort only.

