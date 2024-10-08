Return-Path: <linux-kernel+bounces-355117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503E99478D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C791C23FB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ABD1D3653;
	Tue,  8 Oct 2024 11:44:14 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F51D2F58
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387853; cv=none; b=arvBcH9DD5WlfJLUaYKCMnOLQh166RHIwuJ7ow3Nb5TlzFGgn6decR+VEh1l2vcYu6eJoJ6qeVjQCq/rMuIP3rLeUiWi9eOxP1t3Ph/tZc/3pzAsvIlnyt7+p9ce/MK0PVv0WMeobYpZ2qo2cJaX/HN4aT8YsjsklGxIHQXr+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387853; c=relaxed/simple;
	bh=R+lDoBLiD5ERuYIuHtTXKFik7xoGJq/YXB4Inf94k0M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fZnm5jEtHsDTG9PIV/Uaxxz6qbt0CzwIocQpE96ZXtiPrf+kT0fsAmfRDgCP1r9hz+oSQGz1R+vZ4JgmnvqA3Eu0JCYtjm5NvQK+noeFRPXRNGt5WG3pPGkjRpibkzzsU4+eVVYorDFMC8RyHyvXUR93KIVQgLHWLrdnhmCh6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0cb7141adso75450135ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 04:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728387851; x=1728992651;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k27kcYtruRb8lGYCWT83EVOj1cT81Gs1HR3UFgXmztQ=;
        b=Q77vgZHXZmrexF2TJf7gQQkfjag95M7KCIYHK2ucrgdkgM27ruPfNW5iCwm+YPvXm1
         YzgZjbxk6IIPyOUvfE2U8ASt5iPoA8GBp4G9WYaznG2xyN0ydKH5yBnHlq3UD3f3My6J
         NqCAQhW+sCI/16AhBAqDFUF8YqfAfnUiutz05Hz1l5bxBrc2tLDJTZI5GjOX0mhr48Qm
         3hVyG3MwVPEep74UGWsAMQdhwyUt8u8WG1DgJMoDCgH/g5luU0gfiJW4QFHTJSGei8qG
         sSVjFySgRaTdqEwHX128aVg3m/6pU5oDzcjazICwOu5K/2Pc+VHSEpj+qklWGgZkrX/7
         qmbw==
X-Gm-Message-State: AOJu0Yyp5zm+auEcTXMyTBXqdz7zB2jQzo3QYylMpONHuUFyuYUq0xwZ
	6r3qzoI/6pwnTMSwruDdZDCi1uYYNJG5KFXgZD2JhACG7gHKdgMfH7bqaQKMkCAZkg10EX4ENBv
	tvNj+PPW9QBYxV1sgOU+FLH7pTvwylx9R92Hc6SWv+S229GzJHGlETVM=
X-Google-Smtp-Source: AGHT+IEphvE+3V6op6zep54wHmUZsvLzAPh22/fSKNz5/+ZruFgfPG3rjPgDJxbB/9zsrCglIVNAywfeLqT3FVDOhTnc1wRcmHNa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2142:b0:3a0:4e2b:9ab9 with SMTP id
 e9e14a558f8ab-3a375977f36mr136718335ab.5.1728387851365; Tue, 08 Oct 2024
 04:44:11 -0700 (PDT)
Date: Tue, 08 Oct 2024 04:44:11 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67051b0b.050a0220.1e4d62.008f.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: leon@kernel.org

On Mon, Oct 07, 2024 at 06:44:02PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 5f8ca04fdd3c66a322ea318b5f1cb684dd56e5b2
> Author: Chiara Meiohas <cmeiohas@nvidia.com>
> Date:   Mon Sep 9 17:30:22 2024 +0000
> 
>     RDMA/device: Remove optimization in ib_device_get_netdev()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16db2327980000
> start commit:   c4a14f6d9d17 ipv4: ip_gre: Fix drops of small packets in i..
> git tree:       net
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15db2327980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11db2327980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eca3d0580000
> 
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: 5f8ca04fdd3c ("RDMA/device: Remove optimization in ib_device_get_netdev()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e029401b5680..f56085b928a4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2070,10 +2070,6 @@ static int iw_query_port(struct ib_device *device,
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
-	netdev = ib_device_get_netdev(device, port_num);
-	if (!netdev)
-		return -ENODEV;
-
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
 
@@ -2096,7 +2092,6 @@ static int iw_query_port(struct ib_device *device,
 		rcu_read_unlock();
 	}
 
-	dev_put(netdev);
 	return device->ops.query_port(device, port_num, port_attr);
 }
 
@@ -2134,13 +2129,27 @@ int ib_query_port(struct ib_device *device,
 		  u32 port_num,
 		  struct ib_port_attr *port_attr)
 {
+	struct net_device *netdev = NULL;
+	int ret;
+
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
+	if (rdma_protocol_iwarp(device, port_num) ||
+	    rdma_protocol_roce(device, port_num)) {
+		netdev = ib_device_get_netdev(device, port_num);
+		if (!netdev)
+			return -ENODEV;
+	}
+
 	if (rdma_protocol_iwarp(device, port_num))
-		return iw_query_port(device, port_num, port_attr);
+		ret = iw_query_port(device, port_num, port_attr);
 	else
-		return __ib_query_port(device, port_num, port_attr);
+		ret = __ib_query_port(device, port_num, port_attr);
+	if (netdev)
+		dev_put(netdev);
+	return ret;
+
 }
 EXPORT_SYMBOL(ib_query_port);
 

