Return-Path: <linux-kernel+bounces-380120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE339AE929
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D429728A109
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48A1E379E;
	Thu, 24 Oct 2024 14:41:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694B51E283E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780892; cv=none; b=KSTGVFI2B8XojKNUrjufKbLMi8KpuXCTEKdouoOWTd2OvSlb+HMJBipzPzUQsvYy6BVmKlf296qau63zzlcmna8Lvadr2loOieW/LP3mVco66XeI89jd0rNLVMG7pDO1BmkyWT5ISf2qVf7E2GjbDjjCWshC0AJ7alPMIJyWm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780892; c=relaxed/simple;
	bh=b37uSE3Denko+MGREyZXx9iSU2x92nZ+Nz79EOZkaEA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mhVbeAqMRvGjWFRbFFbLL+du7tueEWRjt3S6Lj/QgCXLpMmT56QCXZfznfEmbwzvvLAfPHWJui641ta576ap00ae/tiS3SBM0s50JS2OOcG4GCYMvtPFK/DYdm3OWmQqYSlCWraJABnpLi2G8E2sjT7o8cQzpZ/ntTyWX/NE6yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so8874125ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780889; x=1730385689;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiT6nIdw2XJzUlwCgPuAoXE6wrcRpvlHvMAwMozDubo=;
        b=S/6cyzjJmb/S2ekiGaaFWudMI6nv1H/c97ZLv5kusvzlpU7RhP9PCkaVHtNfvRtEfY
         rx1TcjOkayX3HLZqCOVoDHIExxwiEG5q1okqqdYx8mULEB5sLuHpIynUYvh9hRYsx49V
         Xvf9/P93Pl3ChmfkimKkxmH1/XlaP4zzD8QvXQk2kPLzJ8JdFan2I3WYJZ+8l7YIx8Al
         +69uXVP0qzHgAmyAJ4QCGTegF2OGtzfTHd2+cSZUp9CyULvnyXv0JqMPADwwWw7ODkq/
         uN2w8PFKTlVrMYNvENEGjUIAZy30esM9NIrgs5t4tHiduTDdIbn+7g6lPi3V9JStT06N
         3XDA==
X-Gm-Message-State: AOJu0YxcQwTEJ1869qN6eMLWdgF20j2d2GGDI0MJpqNDuCNNP/GsSBrL
	rSZkX4W/KOeb/ttLgvz33flgSr8pmztS980q1N5Aj6e10iO+/h5eA6M36Mq2dsBdLo6kaX27TE+
	FgESmMHLOHbLd5jnjs4cO2TXkX8xl+aqL7tFqT9/Qfde0rNPRGzLU5co=
X-Google-Smtp-Source: AGHT+IGTq1H7g5UL/4Rm9/HDtSu4fiwPMuf97qYzwpzyWjPTXggZxHWCMOSOsAs5imzFJnDA8CEFuAKuUD5lWkW1nLf7NpzJZ2HT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:3a3:b07b:6b1 with SMTP id
 e9e14a558f8ab-3a4d5a292f8mr57144465ab.26.1729780889460; Thu, 24 Oct 2024
 07:41:29 -0700 (PDT)
Date: Thu, 24 Oct 2024 07:41:29 -0700
In-Reply-To: <0000000000004e41110614187d35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671a5c99.050a0220.1e4b4d.00ed.GAE@google.com>
Subject: Re: [syzbot] Re: UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: UBSAN: array-index-out-of-bounds in htc_issue_send
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next eaed5fc0c322d75cfcdbc7a16c0c5023d9e4f6fe

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..a5bc0a5dfe7c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -294,6 +294,9 @@ int htc_connect_service(struct htc_target *target,
  		return -ETIMEDOUT;
  	}

+	if (unlikely(target->conn_rsp_epid == ENDPOINT_UNUSED))
+		return -ENODEV;
+
  	*conn_rsp_epid = target->conn_rsp_epid;
  	return 0;
  err:


