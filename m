Return-Path: <linux-kernel+bounces-244603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFDD92A6B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9905C280E87
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F313F012;
	Mon,  8 Jul 2024 16:03:57 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B778C99
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454637; cv=none; b=JmYvunk04mOMJjw4Uy5rlf/78PQeZ/kSmTZdS4NSzooiuicSL+lZX5htEcwWhRt1MSOXqp9NT2w8KlFbv7ybgb3kjZYOmUMn5FMAFAxM4aU1Hme1WOYoif42hNozlKa51cFkIJFOy0Z15AzsXl51lKhdi/izzdmZR2AxBPWSsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454637; c=relaxed/simple;
	bh=e6tAENN59f3FBQmposGo4o2K+8TWP1WthLx/6KBYjXU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MqeJxv/wctbluQTKd76kB8OsXQ4GyMogX2A4/jtgotVKpOkJQVitTpuK+HChxNpdQzCwTbpYV/6CHvE9x3V4qX+UBx/aq6uYVaKWNOY22HH0X3Ikz12t7RHUWKNkSqNWz2x4EcPq9IfMDuRI9BahHBFzDqCzV0hk+prDeoBfzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fba8d323f9so141604339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454635; x=1721059435;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmBfnbayny0VHkfG74l9o4ynNDwzKpECpfC8Vi9lP34=;
        b=j1EdHkUEwCGNxzslEpHcR2JdaAhucswWMTkLjX4F9YVs/HwEBaWl2hvNpZlK/Y2Vd5
         m80Zzgjfji7U/0mi+nEHNqre7JHXrRczXANuyVVprc+Pyj159ARRjt1UfVFTa5XY4X2S
         uuK7kJF10BQopLCqyGnp80/zdLi6bzDDmlkpP/q2KGeDaMiNBCMrusYXBjT0BtFHXtFS
         rfY344Mub+CLEiSPJt3jkpjOlRuUydeVmj/1b9YD9OQI9+/BP1aWMpzv/sTp6xTzOaME
         QqGMIXRIefrdk9mpp6IPMXGNxdAywN+E2JSeLy2GqWznIBkUsbnxnuhY21B3RwL+coJm
         A/vQ==
X-Gm-Message-State: AOJu0YwrRsRmEG0m40RZlMIQiwhd401RymQChCu07jt4vbl1lZydPmp3
	KH8nafC3q5cgNLXT+UphnCjOM1sgJiuJ0Q400vO0Qybl6UfIqs22LSMT5uz+cke9VhcoCUoUkPV
	mKU2KOBqhN+KmdxJLMmRbEhEt+nPFD3sZlGIuCI62AvoYunWBDk94gJs=
X-Google-Smtp-Source: AGHT+IHZR2Mhh8/P4CMe5sdi9EBfwzqnKQu8Th+gN6eLtzHAOB7/tX9CnLOf3ybBmGwoRhuGhMUOiV2NBCjQey5zFBG/XLtPEtf1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cc81:0:b0:384:ff22:e5f9 with SMTP id
 e9e14a558f8ab-384ff22e6f6mr1883755ab.3.1720454635077; Mon, 08 Jul 2024
 09:03:55 -0700 (PDT)
Date: Mon, 08 Jul 2024 09:03:55 -0700
In-Reply-To: <00000000000099cf25061964d113@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060525e061cbe8f71@google.com>
Subject: Re: [syzbot] bpf: Ensure BPF programs testing skb context initialization
From: syzbot <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: bpf: Ensure BPF programs testing skb context initialization
Author: michal.switala@infogain.com

#syz test

---
 net/bpf/test_run.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 36ae54f57bf5..df14f4c76186 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -970,7 +970,7 @@ static struct proto bpf_dummy_proto = {
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
-	bool is_l2 = false, is_direct_pkt_access = false;
+	bool is_l2 = false, is_direct_pkt_access = false, ctx_needed = true;
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
 	u32 size = kattr->test.data_size_in;
@@ -998,6 +998,35 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		return PTR_ERR(ctx);
 	}
 
+	switch (prog->type) {
+	case BPF_PROG_TYPE_SOCKET_FILTER:
+	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_SCHED_ACT:
+	case BPF_PROG_TYPE_XDP:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_SOCK_OPS:
+	case BPF_PROG_TYPE_SK_SKB:
+	case BPF_PROG_TYPE_SK_MSG:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
+	case BPF_PROG_TYPE_SK_REUSEPORT:
+	case BPF_PROG_TYPE_NETFILTER:
+	case BPF_PROG_TYPE_LWT_IN:
+	case BPF_PROG_TYPE_LWT_OUT:
+	case BPF_PROG_TYPE_LWT_XMIT:
+		ctx_needed = true;
+		break;
+	default:
+		ctx_needed = false;
+	}
+
+	if (!ctx && ctx_needed) {
+		kfree(data);
+		kfree(ctx);
+		return -EINVAL;
+	}
+
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
--

