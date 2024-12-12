Return-Path: <linux-kernel+bounces-443619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E99EFA53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6466316FF91
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE18223E62;
	Thu, 12 Dec 2024 18:03:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B8223C57
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026601; cv=none; b=mxhtm3nFL3tkKunSqr+Tlv72qb4+qup+NPQjaGz3AAUCmPM8a2thBHvdt6opAdyOwqvrKiOF6+B34xiJHVEZ24hAHI5uJLeK9I/zAo5SIrCkzYESdxyoTj9rUqDevM7koB6pW6BSQB6lA2dkUrtHxkN1YSFqlpeWT44ROSLuzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026601; c=relaxed/simple;
	bh=5dGRG2TTEdN37p8FrZrRQp2WF2Q2E8aJjXY6VASUkZc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DcdvNRuEk4szYCZ7VslJ+Uddi6vd8nOgI2n9A/Y4SO3D+Fiur4mVUACIDmxCMi72Rq1NGC8OSkRikmts6qcPE+MU5Nv9gtD4qM9D3R4dqOnb95EkG27Y3I1uXBzyXd+qZOvE116iQPcjQSajAzcaE1tvQrgHxqz99ZaWIeR8/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso13633285ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026599; x=1734631399;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUnejtztCWMkudT/oI3VQaog1CrmZZUXUCcGdKJxyEA=;
        b=EmiEFCfjHcVK63jnmxjZWY5kElFolSP9zi4RLRvMwBV++NsXUKayAL8Mm5LT5DToPc
         aUyrPdopA8XmE0udgkLjjIhvj6Df5EFZENtQj24xMPh/XzwRwwmjZP+SgU0diSGuSq2X
         PLFx9tSorBfM0koaKAUTNGM90NxojqvHFfvD/Gzr1SyaKVfDDTuKs3XqnvPxgSdCJYwc
         melKMwWl4zGsv47rER14xtgf38P/oTEajOIN5IywCKfxDcz2VRRxrFwspixk4Pc1H1yT
         rsm10sqCgVQP2UoYk1bwzGZRr155PLQQg76d1CadXzbTukXdmP/rprjJ6ZuHTPmoqUU4
         yu7A==
X-Gm-Message-State: AOJu0Yxu1oIcB/kpimeivdEkp1/SCe7OqVUAhBkzQL4N5VwtbOB8Bne+
	g/E3rvITeeuhFrzjFJzPQUj0bEmXrzoLQGiH6/lA0D72z3qlkQ1wdgVPsdXQYFWhOFKWW51jIs5
	OXd8Tl5CgZB0zzzs3aXVNaEHS4zFWedHH79R46b3PT7YlT8vxl1kc/jM=
X-Google-Smtp-Source: AGHT+IH485OVJKmTJ2uaJXzL+8CIUdxTgm3THpKWX5ZLdy9dq+CqRHKNzmf39nKKbyuQXDfVvAUDwp9y5sWIkUD2EWmOtp/HBEJu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3a7:8208:b843 with SMTP id
 e9e14a558f8ab-3ae58f6f747mr15687795ab.23.1734026598871; Thu, 12 Dec 2024
 10:03:18 -0800 (PST)
Date: Thu, 12 Dec 2024 10:03:18 -0800
In-Reply-To: <674f1d49.050a0220.48a03.003b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675b2566.050a0220.599f4.00b7.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in f2fs_new_node_page()
From: syzbot <syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in f2fs_new_node_page()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0b900a7a48e5..c04ee1a7ce57 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -558,6 +558,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	block_t blkaddr;
 	int i;
 
+	ni->flag = 0;
 	ni->nid = nid;
 retry:
 	/* Check nat cache */

