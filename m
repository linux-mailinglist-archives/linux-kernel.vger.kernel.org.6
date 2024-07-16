Return-Path: <linux-kernel+bounces-253779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E499326D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17806B23607
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD8019AA7D;
	Tue, 16 Jul 2024 12:48:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3974D8A3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134085; cv=none; b=VZFscq4tJ4vb1gKjJnKpr50JtEnk1TzbHBvM7MySPktXm14e0bZzAbYEhZye1GTn9oTh0UOOxPhN51lhlTXkkA4tKvMZ21jExUe8lFJDp4t+5iYNH0WFTf3IKaLpSdwBLVrXNZ/Qc5Ql0TA4kRGKVj91Ln5Bh8HsUZGEoYnv/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134085; c=relaxed/simple;
	bh=E2nZjSWDCpSniAOgFo0k28Kj4THvfunBub8RcuI4IDc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gk9vOOR6nAT9wp7yiqx5uvLWY2fr2oCV1YulwGaYj832Cy7+Lmq6bEvoJZuwMuT7u2fe7U20y+z2UmUOpKuS7Bybe9XcduQTq8nKpCyCPYcO4qB5Er3qRx15tLDSCeBY7yffW3N6O3n/3PbcfxTZUVxeOi6XI1actUxXcQGRB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-807b123d985so729039839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 05:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721134083; x=1721738883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/GQmuW9oEGylooIhciy6e3DjFVO7n6m2qCoRl9cIxk=;
        b=FuVkkc4GJOU2It9JVJ0V/hFGkY94HChRNoaRxYnUS/OehdvRknvn4pq/3wfFOs2uV3
         Ztxak/obah1biBG1jeW/UuO7SwT6A7IELKOw2wyjYhUPvEsjWgv8m0RbsI5DOl1Dpgd4
         OibYfAVrR/gKcFr3WLJhHOPTyBAwVg1VxvUYIeeyPCrhZ6oMajEIeH+zPFRIfe62Vcuk
         YybLvXKBwqDy+CJfk4leXUQUSD/NTl8RKqDPtIedD5yFPCjp6cDisYyVH3vgTC25FZfF
         PNpF8ih3KBS6PmjxubK5vk1A4TlSGh4n76wBtG/lL2mBz66DSjf2NGYx/YDYlhhgYYmk
         v3ew==
X-Forwarded-Encrypted: i=1; AJvYcCV8oh1CAvi31l5YcdjEWN3x0yOLgzkDLzxPl0ugdzF1gNtGcDL6qGN10wRjl31bbGx5V/I8vuvoE0jHkMG07hexOrpVhy/fr7I5yHKz
X-Gm-Message-State: AOJu0YxgYgf+yatBXVuh5NfX5gekUyGlGFZan5mQ4fWY+Axf9Bdhphou
	E90NZ4lq4569X6mJI6F+TKC732TPay1ardE6Yzt1lNe7lQbQ4rgM1NwFHsVLy2Naa0jJIg10L0u
	dDrPaOPRR9MF40JSmJO1WCgFzLrP3kjcKiLzOv4sFWx74BzuCCzd8yew=
X-Google-Smtp-Source: AGHT+IF0N+2TOc0t43ZvyhnpOUrNdhABMYBRZ7HlAQ6MLOp6KnFbslLaXfCAy/o/1nZ29lCtkMF+nqQdQrgC2dpCO/jsgD7aDQgm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:6c0d:0:b0:804:f2be:ee42 with SMTP id
 ca18e2360f4ac-81571a97c3cmr2458739f.0.1721134083002; Tue, 16 Jul 2024
 05:48:03 -0700 (PDT)
Date: Tue, 16 Jul 2024 05:48:02 -0700
In-Reply-To: <0000000000005c6453061d53bc0f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0f1fd061d5cc101@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get
From: syzbot <syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com>
To: benjamin.berg@intel.com, gregkh@linuxfoundation.org, 
	gregory.greenman@intel.com, hdanton@sina.com, johannes.berg@intel.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miriam.rachel.korenblit@intel.com, netdev@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0a3d898ee9a8303d5b3982b97ef0703919c3ea76
Author: Benjamin Berg <benjamin.berg@intel.com>
Date:   Wed Dec 20 02:38:01 2023 +0000

    wifi: mac80211: add/remove driver debugfs entries as appropriate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=150e3cf1980000
start commit:   58f9416d413a Merge branch 'ice-support-to-dump-phy-config-..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=170e3cf1980000
console output: https://syzkaller.appspot.com/x/log.txt?x=130e3cf1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=d5dc2801166df6d34774
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1658c7dd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ed24b5980000

Reported-by: syzbot+d5dc2801166df6d34774@syzkaller.appspotmail.com
Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

