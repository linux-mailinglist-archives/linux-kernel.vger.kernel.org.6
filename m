Return-Path: <linux-kernel+bounces-359119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D89987BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FDC2880A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29981C9EBA;
	Thu, 10 Oct 2024 13:30:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0211C9EB3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567008; cv=none; b=grHHoxK/IZf2Y1dN8jTKB4jQOdoLu+Gfo4Kfp9BwmvVlVR6kDnSqAmreIrAKkaOgo0vSA+u215eHZCwqXFwa7ri1o/ilDE9/L2QWa5Mxo9FnzGyO3R7y0Xj028ONTDpxt5vyO6AsIwB53GmE2sPibFh7t1U5W/MpNC4tj5H1Dsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567008; c=relaxed/simple;
	bh=nkNOSc5l+QaITKjk0s5HhM9tT3PkPnyIu6R/zqTXxsw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MZg6D2ViB51O4KktbwXaIJU/Vz7id96f3vJNrUJ4PmD2RyVCGE5XDCnhHmzpH9ywR7BHzzu9T5ktIac2/C9rIN3q3kXweUhGEzmXhBWa1dU3Hwy/J69iTlVBegBXrU5dMffAu0/bsA8/9mnuyU6iN7LsxG7hjMFmw9y1cQhxR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3453139c0so12475825ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567006; x=1729171806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq8XZziocvWoYHwR3KeZEda/37+bLvjCmuc8VUjsfto=;
        b=QlU2jt4opDweF8rXio6eexWy471QMonBEuaDt1I/eUWq9o6usT1KJgQid9nil6+6jy
         q/WZArLpSI2lOLJB2N17yeox0ZXt5ASYjwA4IFADJqzcFsrPQbZ4Zh3Q4S/Z3bCTY7UN
         /VEWopFWxlco1v4LWE1rX6BJ7sCKgBeTJRVoyUzRwLh8Pu+NDpFg9sidyXRkfS5M7qtc
         2DdUXsU5PDK7Kebm6aaqSLeqA74aZTtlWdjkLr790g//fH9coJ+xUnDV0hcCc8FyoMiw
         6/RrnejM/IybgLD7u7GX4RzB620ghTrsPxBw2ng8ROwIP1gcmGFIfS/ht+Jof82VMkRh
         wF1w==
X-Forwarded-Encrypted: i=1; AJvYcCXigIvguNNXEhhyBrG25O3slbYAEo+voeCEkfj0tWVu09cyC1zXLThPfZQDO5t3o8xrOujb3L8fv+HwbMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0ytV7Hzuph9OV498LR13hKJ/KAKdf/16Xs5mge7BSNR6z2cZ
	xSBb16mgyDz1sLqODQsKieq1HxkMeIi4ZAPjlUm9EXmcDpVXpLIwPLNzPYL353KKH58oO+Nxylj
	Kpujh/TBHjhL+J8LQlJiCFE4btRibz5IAnGnMXNhRo/5Fy+4ByGgR6Xg=
X-Google-Smtp-Source: AGHT+IGOB85dETf5DWYKn8rL8ORPRPW2VUU98dU8ISsKM2qIlGQe1gBGNCZRbChfQp+3UKbSG0Uj794LoIVoqnIqMvEFGhLoaVsT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:58a:b0:3a3:a5c5:3915 with SMTP id
 e9e14a558f8ab-3a3a5c53af9mr29919725ab.16.1728567005858; Thu, 10 Oct 2024
 06:30:05 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:30:05 -0700
In-Reply-To: <53e285ce-2977-467a-ae0e-8d54f6835c09@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707d6dd.050a0220.8109b.000a.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/infiniband/core/device.c
patch: **** malformed patch at line 6: diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c




Tested on:

commit:         615b9474 RDMA/hns: Disassociate mmap pages for all uct..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e2a040580000


