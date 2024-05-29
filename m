Return-Path: <linux-kernel+bounces-193924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E38D341F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729D3282F92
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3817B438;
	Wed, 29 May 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="QW4RfmeK"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9917B409
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977453; cv=none; b=IKGb20a1r3Qtu6WFvxmSDphuvbtfHYgt8Nb34bAy3h+Dg4JbuD8JAcKEt7u1PheideI7kaiBMfEgKCJjvNx/I25hIfRsvnJb7VyxdsXVdNajKuOWF6TBLb3EPOFYJRmd83RRKBSktm9+/fg3VDm5pMc75AP23pPx5g1B6xYlsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977453; c=relaxed/simple;
	bh=zygsDcne8CRDzO76sDobH5aabsfZxMHdf9IAs1HAIE4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JeFK6D35BtetAvAy87NlVD64jVL+ZUSeFBfco/Shpux+yVRXPjjW1RIOdlhhHFk0q11FUdMHqAJCQsO5rTHvFqDjLyY5WvVBbXqnWbzhJ7IgVmGtdHnWKxuweDiNKxjxjltvOob+VnE4LLdxhdPtohmnz0BDA/Awgr4fGNKUiPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=QW4RfmeK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso2233023e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1716977450; x=1717582250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSoVp4DQNbCfZosuSUspIzbLhAdqRfk3MzM3YcjAKVw=;
        b=QW4RfmeKoXspQ7dP1ha77yS5lt+nWYno17iBBzIEX6dLv3g+MBk7zzCSBjw03DHC4U
         y4Zj8X3UIBg2ziApeYb7hWy7q3AVLn/jTgtwlFlJrU49aUJBE4SfaGNjWXwvphMP4Qas
         k7XrhRAYYRfOYiHoEyggWJoK7api2TNj6WA09tjFW0zAfnz5BG2JUPB+MKWlm4wIwG9Q
         r/GIqNVNzGReHZNlWjQBFtPG5NBMw4gua1+8+8v6HadRah1WsS6qxwhKF2WPr4JnDL9R
         qgIHUGsFcWX+jvPGCsxqFsVT32pBH0NONWixl+QN+KTL8nw0MYOks+oqkGMKn4NUSD/m
         1Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977450; x=1717582250;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSoVp4DQNbCfZosuSUspIzbLhAdqRfk3MzM3YcjAKVw=;
        b=qawBLir2pHGeaMDF5sBp3CNxHOHEwW2vFGjVteja3buV8N4/iH8BWXjUCqUK2OkrjA
         UMpCyaligfGo5eXF62FLYG5iAIWJiAp6w6BB+bMjmDrErhuSCN2rcG/D9AYo0P8akcCe
         /zce4EjQhEmFloxM/3lJc++7FXZddMPuN3VuSyv8BcnGhUElvraaPN971tFEfZp1xn3v
         9mE0zC0fXg8Q781z0axZT5B9L4UvBnigdEN5JOdiPhY6F0/n9dRxkuZab/nTPhv1phHI
         9VnwpECLKkrCNLp7+UKwHOX1sl/U8kiVgu0TaI3SlovthKb4Dh3iq4zS2lDLAH2aqBtc
         mOiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0du0MSnrmw2XcEZsGeXHDJ5BByrGiWg60xjlhiQSw+IyhdveBufCba7jxr4CZShlM356pMC8bl1BEtLiVI6TZuprfBUa4WZzKF2z5
X-Gm-Message-State: AOJu0YyElBMoG0NHU5qH8ZV0tUZLgxyMhT/s/Y+HjUmXzMy62am9bDs8
	PnvJeUnV+yT4cevgZubSVtxXZc+n4jRUomo9D0KdHxPtB1oXBcYkhAy8y/Vzl2LvLLZG9NukOw/
	frMMjSQtHECnq/kHuHiRsQr+tSUp7LgeZvvq0bA==
X-Google-Smtp-Source: AGHT+IHYJZBsJdRJR+ZSwpHCzyuGph7Zavse2q6Cc2Nu04AACOr9/ojv1MOTePUCWn/12FmemAN3H/3cVYdAZT8fQX0=
X-Received: by 2002:ac2:4c25:0:b0:515:9abe:6c46 with SMTP id
 2adb3069b0e04-52965199a87mr8479219e87.34.1716977445168; Wed, 29 May 2024
 03:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhitao Li <zhitao.li@smartx.com>
Date: Wed, 29 May 2024 18:10:29 +0800
Message-ID: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
Subject: Question: How to customize retransmission timeout of unacknowledged
 NFS v3 TCP packet?
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ping Huang <huangping@smartx.com>
Content-Type: text/plain; charset="UTF-8"

Hi, dear community,

In our NFS environment, NFS client mounts remote NFS export with its
VIP. The VIP can be assigned to another server node for failover.
However, the NFS client sends the unacknowledged packet 50s+ after the
VIP is ready on the new node, which is because of the exponential
backoff retransmission algorithm.  I tried to set this parameter
"tcp_retries2" smaller so that the NFS client can reconnect with the
new node more quickly, but this parameter didn't take effect. From
tcpdump entries as follows,
  1. At "2024-05-29 11:47:00",  ARP is updated.
  2. At "2024-05-29 11:47:52" ,  the NFS client retried to send the packet.
  3. Then the connection is reset and a new connection starts.

I guess the parameter just takes effect for applications and doesn't
take effect for kernel modules like the NFS client. Could anyone give
some advice to customize  retransmission timeout of unacknowledged NFS
v3 TCP packet?


OS: Linux kernel v6.7.0
NFS mount options:
vers=3,nolock,proto=tcp,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport

tcp_retries2:
[root@vm-play zhitaoli]# sysctl -w net.ipv4.tcp_retries2=5
net.ipv4.tcp_retries2 = 5
[root@vm-play zhitaoli]# cat /proc/sys/net/ipv4/tcp_retries2
5

tcpdump entries:

2024-05-29 11:46:02.331891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973659245 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:02.542836 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973659456 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:02.751013 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973659664 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:03.166958 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973660080 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:04.046882 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973660960 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:05.710910 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973662624 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:09.039310 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973665952 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:16.017889 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973672930 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:29.326891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973686240 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:46:55.950915 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973712864 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:47:00.379844 52:54:00:13:1f:34 > Broadcast, ethertype
ARP (0x0806), length 60: Reply 10.125.1.85 is-at 52:54:00:13:1f:34,
length 46

2024-05-29 11:47:52.271192 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
options [nop,nop,TS val 1973769184 ecr 28456
58566], length 124: NFS request xid 1954624602 120 access fh
Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS_ACCESS_DELETE

2024-05-29 11:47:52.272041 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
ethertype IPv4 (0x0800), length 54: 10.125.1.85.nfs >
10.125.1.214.58428: Flags [R], seq 1148562527, win 0, length 0

2024-05-29 11:47:52.272909 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
ethertype IPv4 (0x0800), length 74: 10.125.1.214.58428 >
10.125.1.85.nfs: Flags [S], seq 1734997801, win 32120, options [mss
1460,sackOK,TS val 1973769186 ecr 0,nop,wscale 7], length 0

2024-05-29 11:47:52.273503 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
ethertype IPv4 (0x0800), length 74: 10.125.1.85.nfs >
10.125.1.214.58428: Flags [S.], seq 1078843840, ack 1734997802, win
28960, options [mss 1460,sackOK,TS val 2235915769 ecr
1973769186,nop,wscale 7], length 0


Best regards,
Zhitao Li

