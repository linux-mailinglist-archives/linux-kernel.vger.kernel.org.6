Return-Path: <linux-kernel+bounces-412174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6109D04E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7178F1F2165F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BA21D9A47;
	Sun, 17 Nov 2024 17:49:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A2A945
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731865744; cv=none; b=YftsfKJ8juE7RIZwRpLyl/WMqBei1qAT8GPoBOg4SK59w07j6pwYVIbLglUb8J6yRlB1foswHSd7Oy6hgfM8Y6vus2o4iaX2mvNsX9s3j4sGLbQ0Eq3vP7XQF10AyGP5PTdqH1eB9SXmsZhoFGlE0+aPoy+hoKbcayDwXnV5uP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731865744; c=relaxed/simple;
	bh=RmZwaPE9t9S4xO4E+RPxgKRwz63mR86k6WsistzGryw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C/JXdGyNtpcgEfH7qgI2fapzJgJBoCkbACTFp5HCqHoAKos3MfTojWglRoz7SxGjJZ/2Arzqnu+OodBsDq2YKOPpr96YyhwU3IkEn4u/0IxaV3zdZHFgIAI1Eof65uvOH5wkE/51ll0pmt6scZZrY+EbOQ0r7/i0CmwJo2htOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so42650525ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 09:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731865742; x=1732470542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lH039o7iT31/Qu/1scxtSdidkcelHSCYJg58Ymh6JG0=;
        b=FNRkcHdK721tDmF+mhquRFxB+Li8xAlAZvc/QmeLrxH8s63btbDSZVYq0HF9Ka1Psq
         W8lhwBh3JGuWJk7nrXeKKXp0S/uXt2mP+zuCgiJRCogB2vPyKYMYOnAtPw67YOFG2Pqf
         G06wh42+EW4iPi4UFUgqUBmt8hv7V12b6/+8ujdj2gB7VH2kWRJSiTMRG23o1DUCJC3s
         ahmxfMMv4uVM9IdQFSQglcgJ9SqKQtN6ufurCfnUDDeJun3zs/YUbyLjzWbmX8ZQpgIU
         d2NJzyEqc2yvMSlcLVJlP86GXz4xur7x46k28seSo+HHbmKxuyiSLTgFvQHUWMIw8fWF
         IiqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0lx5DL0PYwItnleUiRX62q60GHlm5Czfj83V1uckuxtsgYTHmjDD2Fb6GiLuEqe/ePYojL9l7ncxUfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPTBo5Mil7evoZXiEzg2WOAcFfKOLwnWTYB2THDuOp5gyfiKl
	SPKSZTUpBVjff6SnY+tIhrOkTU8HUidteTLY7byY5b/oe0ioy+q+MrmNyN/2ZeOQitIQlmf8X3y
	xeZUSYIdeicc+zz86szcNaHsBNoB7nTTQO2EjwadyOkK1uC4ci79aNJQ=
X-Google-Smtp-Source: AGHT+IHgeFp9d9NI51lcsjZ1noXS6I6lDq/BwKeNkva1lw7F6tNxdBBtcQk6nkn5cPhLIMXMVlqRtPZMlC3JxYVyUzaR8xHWIlmA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a748082c35mr93496865ab.15.1731865742330; Sun, 17 Nov 2024
 09:49:02 -0800 (PST)
Date: Sun, 17 Nov 2024 09:49:02 -0800
In-Reply-To: <00000000000093a1ca0621e8d336@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673a2c8e.050a0220.87769.0012.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_page_mkwrite
From: syzbot <syzbot+2e6495950edcf7fbfccf@syzkaller.appspotmail.com>
To: elic@nvidia.com, jasowang@redhat.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mst@redhat.com, ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, 
	parav@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fff130580000
start commit:   b5a24181e461 Merge tag 'trace-ringbuffer-v6.12-rc7-2' of g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fff130580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fff130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6495950edcf7fbfccf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f252e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ecd2c0580000

Reported-by: syzbot+2e6495950edcf7fbfccf@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

