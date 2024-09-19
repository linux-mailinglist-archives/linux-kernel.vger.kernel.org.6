Return-Path: <linux-kernel+bounces-333878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2303D97CF52
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 01:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16981C2189E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 23:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC518E053;
	Thu, 19 Sep 2024 23:04:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD71802E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726787044; cv=none; b=QKeorOgBo6uxrBLuqkyWMSSGu9wIRnpPKtDj0KrTxtGNC3VYzMkItukMxnF2MIurZbRFVfBfE9bjJrClbIRsEoJf+S89hsYZn/7jqeFPkg5abh6/9zDiQxEYC3dcZFB17RcMSxwKJ+a4EOiJooFstEQzF+za5EDcBWW7XONrz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726787044; c=relaxed/simple;
	bh=S+xaMHpRzSmwKl+xnSmMA+1rbDdDSSqhrETfd38to5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ps4hpP2FZmfB5uO3t+vIh4o5OibaulEZonLhKAU9QBLA2kMYoC0SfFmA/k2kJusJ/sHF3Z07aTv/nl1YCkotapXLTRE1vPDBC4aJKmKZYwJhgvxvUxGCoBInyDFJwVeAggD/XQc6nj66/1iLITf2olh/5/g2p6HkBI76/ezy9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa94d4683so191246539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726787042; x=1727391842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWJz9uQb72/vEZbHa2crnNKcS8EkbVeNZXJ4aWGfF1U=;
        b=UvvErLxJuvaYVif0sTgftuDk6jW9f4OFbhF2yowyU16C2otNlPD53fR/CITAo/CH6X
         g5rvbGnmG/Nk+kFjYgsM4Xr7TfgqSDMKgXMrhCWEJhcwWB4rbgjHrdQoCFu7zwu4K3+n
         y36danDlRiRT/a1Plho3nMMOKpwQUVl5zjKSrAN9j5sX+xgL1KsOfNjMH/a4cCdg6wWR
         kDZfPZqGsdpZ7vdI5ohsgR3fv5Rd4h/gnYYxI3GzPWuOZsK6xK6w4rnzN4l6GRsavK0C
         PFPCA3Y+gcVCRVEd0w12QDuifB+3PGtF/ZdRN6GHfhukuiuzOWAS5kNyNJdX7zpDINbv
         FMEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUspKyc65sD2L6Zkwi5eBqWDtvlyCXnVDuwvy9MjKPAR6QAIpVd+3D66+M5Sy+/llo3uxSBUtm50oB+ZkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24ToAYax61mcHUmshP6phqL72vQZDpEyKFSJvrYb1LQuj4i3k
	YPRdZiDk68ZVEbvSGLBut1PoOr4p4tlNq2T60Q01vXE7MQ0hq0mHMVOf2RLe4tRqiK/ZSAvCFWK
	wX/dU3yE7CW/65nXVAywBSQCtC4obtJXqn9Zm7ROyu4iZG5d0IxHrKNY=
X-Google-Smtp-Source: AGHT+IGUnyFeMqou91gbt1FJ9NiZ111uTDbMyen86xCUbASIebuCzc7eghPfyRyWtoDKYYnqMvMs9h/eGV3ocurQzcFme/qgSaZX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2162:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a0c8cbf020mr12612215ab.10.1726787042095; Thu, 19 Sep 2024
 16:04:02 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:04:02 -0700
In-Reply-To: <d2c7c140-5c07-4071-b9c3-28eab1e3f462@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ecade2.050a0220.29194.004b.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_recover_relocation
From: syzbot <syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com
Tested-by: syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com

Tested on:

commit:         e309734b btrfs: reject ro->rw reconfiguration if there..
git tree:       https://github.com/adam900710/linux.git syzbot_rorw
console output: https://syzkaller.appspot.com/x/log.txt?x=167fb69f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=4be543bf197a0325c7d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

