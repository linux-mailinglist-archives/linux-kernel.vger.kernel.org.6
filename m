Return-Path: <linux-kernel+bounces-336336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F598397B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D53D1F218E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3D583A09;
	Mon, 23 Sep 2024 22:04:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1129402
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727129044; cv=none; b=PPZ4c15AlfkA4r31fvz5pggvNewAu3r0/EDFEwRIrM/mVgKLGzwWNDTJJyV+5RiIA6JVjVrioN4Ad/uZWX1kSbJks5mTPrSwADHVK63CL0YOMLwZGUw3JbvmKKKUgaHx2HHydEvoWFi5BHKIaLYjfMGCfJ5xbZbvgaPWnHT/PfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727129044; c=relaxed/simple;
	bh=h/Kh/4ihRaTZWCDJUjsWAub24OCXdZphUlAwufe879E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dV7ZFhEO1S/rrd5q+CxLQiO6oJN8wgbilPWKyr2L4vDn8OGr3KCXsR8dZUBV8DaoovjCcTDe9gvzHc72iYEqtdgpJbHjZpt+ZZzk3d+HPwNlcwbIDITDsL9BZzys8fLt4+A9zagFEyTpyrWlPx7OuKBYPGlkQmljqz857DFTZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce8cf657so51886625ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727129042; x=1727733842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQMax4HhqwTv6Gt4Rt+eMIQV9ULWIeqJRLKYlQdnQ3w=;
        b=P73fUJ2HqmTe9eA21BEJuIMsGxQR1TiPxIt5fWK2nzW+pXvPOAOHjjjkD2gpc1K+I6
         5CtTgCJ0o1amXPLitR5i4aSNtthVEScLzBxrde/yus4YOGCUMOYQeL3Lh192eJIlO+Kb
         aLX+4zHmriqWignNdXn1rJuJu4114RYIqt9+dtGrAegTH9fU3BypCf3HzeFKSAfyfBtp
         wFEEqCnfr97Bq4h9VZCrTsVClLEvH2lb35mGERy6xjSJlwOiCxOqC9967g7P0A1oLHt2
         TPNLG/X/LvAqRxRGy9ZAPtV4tPcKC1Wc0yHGX4rsP+nmQn1g32/fa7ks0x90cM/CfGMu
         Sirw==
X-Forwarded-Encrypted: i=1; AJvYcCW0HXTpKJ9cN9E1XA/U1kCM31WEDkI+kZTKS9dfnfLvW6xPOEHMGr+fxoQGG6QVwo+UDQrfVUlpWL+5GYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztz1qL1sd0i6OFLkXhTZkYHzREiGGK5JBg+Hki4mhD6dJ5zDLl
	45dPQdnkS3mBxM8PkKYdZBubtVJZ/WJlSMcbVr0E5UAgGUM9zue3i36NZFCPGTRBzAYvsc0VXKj
	56iE/w1Va8HBXstsjs2lrKplXwV7XQPyLDVlLN9GVEmObVBjpmxZYtzs=
X-Google-Smtp-Source: AGHT+IHcOid/VFKx1yq8EM7fYZcnhzf2KHqDZPsgGE/+Ce1IK/o3bKwulkMGwU/7rKHTd0y5ctAOFNZTIVptWvAa//qymdmGDaZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2d:b0:3a0:9ea3:8d79 with SMTP id
 e9e14a558f8ab-3a0c8d12eebmr110480395ab.16.1727129042225; Mon, 23 Sep 2024
 15:04:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:04:02 -0700
In-Reply-To: <00000000000032dd730620055fde@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f1e5d2.050a0220.3eed3.001a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_try_remove_refcount_tree
From: syzbot <syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, eadavis@qq.com, elic@nvidia.com, 
	jasowang@redhat.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, mst@redhat.com, 
	ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, parav@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f6ca27980000
start commit:   de5cb0dcb74c Merge branch 'address-masking'
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13f6ca27980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f6ca27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74ffdb3b3fad1a43
dashboard link: https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f23880580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15851c27980000

Reported-by: syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

