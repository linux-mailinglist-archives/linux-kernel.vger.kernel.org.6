Return-Path: <linux-kernel+bounces-392192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754DE9B90D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E361F23A15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABCC19DF40;
	Fri,  1 Nov 2024 11:59:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB119CC32
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462371; cv=none; b=QC/eRNvGXUHFLTFuCmdnqAA0mQ5qz1yRmMevq/gaqbQAgw/ELRo5N+zW0f4mLOupVgojy1xw/ICQr45P5f0gac1ws2dedmDw9WmZjCr+RhXQNEO95JwdlttAbPsWNc3xYYmjQJBe2ttYqQ9z4xPV1MtLYlMQ3TRejmZmvVXAPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462371; c=relaxed/simple;
	bh=CcpK9/383D5fnWPAkGajgmczMb2oDpxeG7QmPcyeWm0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UDb+ImZ0sE39IOrpuirZ4MrcHzgichBCSP/9imWEW90q0Z0lXtJ/AP1AYbuWCld1ygtQ5qFogjdnYRlS0/r71sY9XwSx/L3AJux5a7UEMaPqKQkWJaqt9Qlsca9rRzrsfGG8aKhIWkwiGV1uDJpCRlUG7OtOWB6VzCBzCZVuEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so16633625ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462369; x=1731067169;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/FBxdpk0UW7S/RPa+f4yDCF5+ZAC3m1a3/exQQzNXU=;
        b=Y1UcttZttxrcWsDo41BHX/ZvOczzqHJ1snnJy4GG9dniBhtc6xhVOEjv4ZSfOtOEvw
         2Xul0ERveVxmV2n6i3nNnNYA5Gagv2u6P4YB/wQ/vylR9JoURlTudEu9Gl/ib3BHYYkI
         OsZtjlxQ8NYwAKR5qERHg8bQJOO+rU9+oggtjiZOLywrZJFDr8W0UeRLZush2Gkm2wUa
         tc/NxrGPEEcJ/RGyR39vLhekcnRwTh7ghsMx7nEV60Eh54+t2ZhqNWvrTaJ7KuKLrAvc
         BLmk0pN9nCsN26QhJODZSMU510mvw0UGG/30G4SLiok1F2jwyHHBroIGCM7pdUbbHy88
         3xMA==
X-Gm-Message-State: AOJu0Yz190Phn3TRny7kvhSUJmyp9NOGtanY79b/svdClRCKVROjwXe2
	QVWrWRmdQsLxkWIbkU3k8cwIFctPQ6usRFl1XSEeFi69f2q+QD9jp3VtFNTM3RqgOHxlFMhTdNy
	Rn+tSx5nABTywq9O5AJvyomFBQmg61jSyuvshUWDTft3mVrxMFnOXrk8=
X-Google-Smtp-Source: AGHT+IHcdPfhyPYX5yrvGBIlb8Y7Yam7b6kwCX89oo7wLQKF2B5TwXPMskAKDz46lL81LaQieup68wYaTrHqQP3j8zeo1HF3DDXk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b11:0:b0:3a6:ab82:db58 with SMTP id
 e9e14a558f8ab-3a6ab82dfcbmr39923435ab.23.1730462368955; Fri, 01 Nov 2024
 04:59:28 -0700 (PDT)
Date: Fri, 01 Nov 2024 04:59:28 -0700
In-Reply-To: <000000000000afab690616b12f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724c2a0.050a0220.35b515.016f.GAE@google.com>
Subject: Re: [syzbot] Re: KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KASAN: use-after-free Read in netdev_unregister_kobject
Author: dmantipov@yandex.ru

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next dff8a64238a3f951dbf0930bac915eec7cae8200

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 367e32fe30eb..80ac537fa500 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -73,6 +73,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		return;
 	}
 
+	device_move(&conn->dev, NULL, DPM_ORDER_DEV_LAST);
+
 	while (1) {
 		struct device *dev;
 
-- 
2.47.0

