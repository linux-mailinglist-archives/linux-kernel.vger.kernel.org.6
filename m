Return-Path: <linux-kernel+bounces-302889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2B9604B9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D521C22845
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB95199E9E;
	Tue, 27 Aug 2024 08:43:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3D1714A8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748204; cv=none; b=ZZq+6UKaZZMluEELzqM0XVY6kW0Ow8QZ6P1ZHkAuBARIZdGUxxIa6VzyLrgHCd8wqKt13bY+7BlLvOgisH9iFIfxaYVTSQvRByLYAazFnFgJkLZn7i0T0rLRcqbtjLMT+bRKtd5y5s2dF2bzT6/EXLtPUt7jDETb5Hs9VfjW2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748204; c=relaxed/simple;
	bh=XKuIm4B9e0oqIMtvY6r359aZpxxV6yrTqMrmrpy/nj4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t4DdRMnrXcFakUOAhY0NZUnYWVsSV0Xd6L77//eZPZKCdyWwvofsgKyA/eTppFlU4SD0bpULrk+c3FYq15v3WH+zeQcMCzhGJsuw0U505/j3sJpGaJ54K9oTXPuEM6rzSGPWfiLx+9sBd0sZb30kqtHABaf7XvXOqkBUufEflGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso570844039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748202; x=1725353002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yb0vv4+kO+PRSHRfUJfXMp+Rzluk27Didm4t5BwNtqA=;
        b=qvT//1fV7alnlzZFuDYXUko2acNHiFAPhs9wOcc7rld4YwgmUrevr5oNNqRtXx2YZN
         EKB28COBWY4wu7pwvZGJf4Epf91Zue+oy9pX0MZoVBRPIBLsnLejRCM2OeGzFY6tGgOS
         LoTy0PdXHtweRLnr20oRZ294Ii/LQqWWbB5TVy2fc6AV4Ot5PpB0plZ7GY9INPTBAYEL
         TwlNZmj1FRBLUP0GlfLEayuJ0SZwaC0adjaM7FRkoMFWPXRVeg+4woPC4e8hfJaB7w1U
         SUbbsE6aGpkNBIjzhK51jdmVAJMShPPPe1BwwkIqUch+t86PT3hjj5Eqq5vjJw9Aa/Rj
         0cHw==
X-Gm-Message-State: AOJu0Yy/3DLOIWlDUyM9zqtoIQFZgIMrZjeG4J5GNe3Txf/X1wysTwmL
	V4VlpAS++32sDoHxDqwNogBpBizYWSGmNfPVPQSzfN9dO1P6h4oO19LaSn47yz+DiAH9R67UKbA
	6IkC5qcbh3w+w7YGhObbPypq/zRG0lWLapCNgH/PRxT8gg57E50hbvec=
X-Google-Smtp-Source: AGHT+IEOJQEUfSz+/2Vw2uJF276C+xSABwvTeqD4hUIZvuf9L/TBg+bbnAz/RDhH+yPEWyagtY3qePa9tbqC4VQHWCA8Ad91Ud1o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c564:0:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39e3c97fb30mr8107365ab.2.1724748201860; Tue, 27 Aug 2024
 01:43:21 -0700 (PDT)
Date: Tue, 27 Aug 2024 01:43:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e629df0620a63b2a@google.com>
Subject: [syzbot] Monthly rdma report (Aug 2024)
From: syzbot <syzbot+list6d1c113d5d8954339576@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 60 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 33      No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 24      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 2       No    possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

