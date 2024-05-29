Return-Path: <linux-kernel+bounces-193945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6418D345C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9984628478C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5817A92D;
	Wed, 29 May 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="swRBNM/+"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019D15B138
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977954; cv=none; b=uspaCnSi0jRe3bhSM0D9S/aA6msg9dmZSr7JsCLZwhX/Yw4KniMdLHBSE1IyhhIONNCvC8Q101alOi5xmg7Cr6hpZ0ySJMWCT2/0rP2zVQHx5fy3SRPtPX8UU5m/OqQ/CuN/3ObgwnITUSXtH3oautSjqinLOeQmpB29I/804G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977954; c=relaxed/simple;
	bh=LSTWg+rsvuFYOkOF6cwSnUA7hCVBfzA0aBKlocHZZAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7ch3fPsgfSAcOyio1lH0CYUTl/IeXGYG46UZWP/qqSIgXbusA9gG/FS1WPd72eI32aS1lcHVpNPRTpjqPVAcbWHXnGGRYSvBVUGkfFloCaXD0UelPSGbwZCJ8D1VeFuTEpFR8TI0Bm1sbOBqZpjM7GQaqHbUM30TP06gibV93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=swRBNM/+; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-529b79609cbso2909285e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1716977951; x=1717582751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vm8QJwrPDlseWEMBGEntuX8NC8tqdJObdJ0cjdPNXM=;
        b=swRBNM/+vg0wzD+bl6avAlRBFrgASE/40APOry8mRhH5xOqN2qxvlPYZXFyhgu6/qe
         dhnDpNQVoGLKXC1hMMX/MLNKFafxFYIQ2K+HzB3ciihpGO+zc+d7O9bk8OpqXE0Ow1oy
         f5LrrRswi6lS3WyUS54TRKAKnto7TKtp683TmXeBJoNRyMp6cYOIAGih+ZZ7Iggx0OqT
         LuVnz+kTqCNOzI5SMAfTgEfMDQJeGeYLP+fVZ2OV/0jAZcsgpXnOGf+v+7IcAl5276Y9
         Q5viBtsFLH4mWlNSb7lXyYomzPCXowagJcoop+IxV8Y6fdHaERv/v+kncnZ6hm3ZmO+G
         zFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977951; x=1717582751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Vm8QJwrPDlseWEMBGEntuX8NC8tqdJObdJ0cjdPNXM=;
        b=VQC4wWof26RzaHOXB4SFBDLH6oRTRM5wc7Ep65fq4JrAphm4Jq5eJ9Ea87BfwXRGuT
         bpYnwMhfkOaWmGQX/fHngtNCVJnlJGRVTQz+HtShdtT0dE9N8LH9ebFfOhOjJtTfHgyL
         baoeHNqRY+qWAMy4qqQXBuYPlL6Du9n3AMLg91HWY5KIL4W2/xoqc0nWBekM0sbJ7MkE
         ddYB/dTuLTNWWXHss5txYiZvrtcLZJMtGvY/tp8R7SdEDjErgnpq4yVO3AoZ8yXWnIcs
         kmNPSGYglw1ypbrazQmdEhvPKFbG7ec/hXtz/23qIkdKoC6WCKEuTyNmci/z7mZ03n6e
         KKAw==
X-Forwarded-Encrypted: i=1; AJvYcCXQkbN5T/eG0qpl5Y/1vr4EvUVAwr2fIl9K5di9qSsI7OhBHL0agRF02xgm2E7Hq5ijAISWFtjnt+YtnfwYTx79vKmftnOlW5I62sHc
X-Gm-Message-State: AOJu0YyxuC7TPTo60RBysxL/SuEVHEK5+84QJBVLe51pp5k6lEvmo9f1
	9afTRQYAqjuLJNTXNzbPhTHIJKkHqaeVrjaHm2RBxIOnL6JsgId1jJ2S9K3kXyCROsDC9K89Pxo
	pyJPaGv5jaCiuBFsHbONfurbur/NdEFDr70Jp3w==
X-Google-Smtp-Source: AGHT+IGUzYRIdvoRNMdQb/TUKDqF1qZxb8inmeXLWL5WyGORFLpBzo5cAD9WWqXwUD9pLdFbKNz3zbnHT/rbHAa0dys=
X-Received: by 2002:a19:4314:0:b0:51a:c8ba:d908 with SMTP id
 2adb3069b0e04-52966ca8374mr9238761e87.62.1716977949578; Wed, 29 May 2024
 03:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
In-Reply-To: <CAPKjjnoeLkkvSZwpWw_bTCOCTfWYgjCyvjpoa95E4yroQR5zyA@mail.gmail.com>
From: Zhitao Li <zhitao.li@smartx.com>
Date: Wed, 29 May 2024 18:18:54 +0800
Message-ID: <CAPKjjnrez+hip+VBVrLT_g6Uzxd5DGSCoCSXQnRLx-qXT09yQA@mail.gmail.com>
Subject: Re: Question: How to customize retransmission timeout of
 unacknowledged NFS v3 TCP packet?
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ping Huang <huangping@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Essentially, we need a mechanism to quickly reconnect with new
nfs-server nodes for failover.
I also tried to adjust mount options like "timeo" to 10s and "retrans"
to 1,  and found that they don't work, either.  It seems that the NFS
v3 client always tries to reconnect after some request hangs for 3
minutes no matter what "timeo" and "retrans" is.

On Wed, May 29, 2024 at 6:10=E2=80=AFPM Zhitao Li <zhitao.li@smartx.com> wr=
ote:
>
> Hi, dear community,
>
> In our NFS environment, NFS client mounts remote NFS export with its
> VIP. The VIP can be assigned to another server node for failover.
> However, the NFS client sends the unacknowledged packet 50s+ after the
> VIP is ready on the new node, which is because of the exponential
> backoff retransmission algorithm.  I tried to set this parameter
> "tcp_retries2" smaller so that the NFS client can reconnect with the
> new node more quickly, but this parameter didn't take effect. From
> tcpdump entries as follows,
>   1. At "2024-05-29 11:47:00",  ARP is updated.
>   2. At "2024-05-29 11:47:52" ,  the NFS client retried to send the packe=
t.
>   3. Then the connection is reset and a new connection starts.
>
> I guess the parameter just takes effect for applications and doesn't
> take effect for kernel modules like the NFS client. Could anyone give
> some advice to customize  retransmission timeout of unacknowledged NFS
> v3 TCP packet?
>
>
> OS: Linux kernel v6.7.0
> NFS mount options:
> vers=3D3,nolock,proto=3Dtcp,rsize=3D1048576,wsize=3D1048576,hard,timeo=3D=
600,retrans=3D2,noresvport
>
> tcp_retries2:
> [root@vm-play zhitaoli]# sysctl -w net.ipv4.tcp_retries2=3D5
> net.ipv4.tcp_retries2 =3D 5
> [root@vm-play zhitaoli]# cat /proc/sys/net/ipv4/tcp_retries2
> 5
>
> tcpdump entries:
>
> 2024-05-29 11:46:02.331891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973659245 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:02.542836 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973659456 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:02.751013 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973659664 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:03.166958 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973660080 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:04.046882 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973660960 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:05.710910 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973662624 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:09.039310 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973665952 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:16.017889 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973672930 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:29.326891 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973686240 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:46:55.950915 52:54:00:1d:a4:24 > 52:54:00:a0:93:93,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973712864 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:47:00.379844 52:54:00:13:1f:34 > Broadcast, ethertype
> ARP (0x0806), length 60: Reply 10.125.1.85 is-at 52:54:00:13:1f:34,
> length 46
>
> 2024-05-29 11:47:52.271192 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> ethertype IPv4 (0x0800), length 190: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [P.], seq 129897:130021, ack 171633, win 2356,
> options [nop,nop,TS val 1973769184 ecr 28456
> 58566], length 124: NFS request xid 1954624602 120 access fh
> Unknown/43000001180100000000000000DE40020000000000F439000000000000000000
> NFS_ACCESS_READ|NFS_ACCESS_LOOKUP|NFS_ACCESS_MODIFY|NFS_ACCESS_EXTEND|NFS=
_ACCESS_DELETE
>
> 2024-05-29 11:47:52.272041 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> ethertype IPv4 (0x0800), length 54: 10.125.1.85.nfs >
> 10.125.1.214.58428: Flags [R], seq 1148562527, win 0, length 0
>
> 2024-05-29 11:47:52.272909 52:54:00:1d:a4:24 > 52:54:00:13:1f:34,
> ethertype IPv4 (0x0800), length 74: 10.125.1.214.58428 >
> 10.125.1.85.nfs: Flags [S], seq 1734997801, win 32120, options [mss
> 1460,sackOK,TS val 1973769186 ecr 0,nop,wscale 7], length 0
>
> 2024-05-29 11:47:52.273503 52:54:00:13:1f:34 > 52:54:00:1d:a4:24,
> ethertype IPv4 (0x0800), length 74: 10.125.1.85.nfs >
> 10.125.1.214.58428: Flags [S.], seq 1078843840, ack 1734997802, win
> 28960, options [mss 1460,sackOK,TS val 2235915769 ecr
> 1973769186,nop,wscale 7], length 0
>
>
> Best regards,
> Zhitao Li

