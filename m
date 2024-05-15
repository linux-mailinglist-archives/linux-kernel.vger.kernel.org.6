Return-Path: <linux-kernel+bounces-179644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27838C62AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58751C21B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A674EB23;
	Wed, 15 May 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eoB6MZCa"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F94C61C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761160; cv=none; b=Y7iBUzZlwj7KevEAcVIBafeTP1c/ZdHaRpTV/a77o6xNQvzXRCbQldAf+sQuFdcgpaU6QWe3DC4OY7/ojEheFLDZwoDjAaBbQOzxJpveyG2OMBH/RQLAUTONVJiaCen9CSRq3skLSg2lk5PioSvYM1j8RQ9do8ySFPfEdoko/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761160; c=relaxed/simple;
	bh=z0zhb+QV5hbyDviqfqShLmfRPBX/cjad8dM1YySRgs0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmskgTWcOq1FtmR52/DlRMicxt7xRPDtu4LZJ7Zze7Job+kkeW+IVPF/ZKLS2+NgajrSq2VO+RMWR5XNbpIizP1oMx9zJKxDG4iwUzTlz0HJufEBRoJSwOs5lJIqaddCmpzMYR15LldMQCsv5W96Vp3eBRv7kdh2TMJWbhxg3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eoB6MZCa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f05b669b6cso37035925ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715761157; x=1716365957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6o942XCtPQjJiLKQGAB2J6bVbP8KodkalImgwSTnKDA=;
        b=eoB6MZCa7wHl/a21R4eOuLGD9Dbzy8ctbadhXKIVghpUnJhdQ4LQpGip8bVe7boojU
         pdLZvuFTDrTQRAD/S9Hu8Os2OwdTZScmi5vLrMCuwyaIjbXPxX/B0407M4JVYa1qmu57
         /5gllz8UFvpI4x6NlQj5BWz/SdnW3ZY8EwWmJDc1Uywptp/IecNA6UfS80RmxqoFc1Y1
         QPxVM2sjQHqja9ON8IgVangV8fs4hPaDaV1niw5N0HOJL3PhruWLZeLvMPjwwa+xFCd4
         SYOdZigioQjJQm5J4cUUL0cxHxTapu2l3I7E7jP3zZ5AOV5s/PoRWpn0BHm93gRCl0kM
         /ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715761157; x=1716365957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o942XCtPQjJiLKQGAB2J6bVbP8KodkalImgwSTnKDA=;
        b=mi60tTxKykkeCbKVAjiZnRkUl4CleYyg1fz3fQkNHvPqnLqvo1tPdjQ0nYaXQ8wpYN
         kiubLDTD/pSJ4z0G0ypAvRK2ATmq4o3mPDjs0OrNTKYuoI1oavMHX/y+90UHXEnnlCCf
         ZNiFTOHV8ZnPEzN6CBEo7xB7H2AKBZxllQ58KlD5c/O3GN6+I13IUG1oBLyedN+vRlCK
         KSlmGQxnsaY9JAXNwEwGqOuNU6Sn4ZC2X5I0IFKDPbk0ii3zpLhNMPzLxPG5NntCml57
         uatMKbldCODph9pVMdx222Z2dHW2n0qpJgd7tZMfNinLg3bwYTTTRFHKOX7SKAEMiigm
         tp/g==
X-Forwarded-Encrypted: i=1; AJvYcCUquTK16KMGL/UdFu/PM0WBpwpt7ZPDVx7n7m7ZdqQ3GJWKWPXSAqOvNXZqE8V1eE8IvSB7+N/bYcdIAFLLuso6QMqoQbswPyB3v/cc
X-Gm-Message-State: AOJu0YwgkMCe8BvZFxyfRHvX9FmglvThsy+EzVzC43WEHnRrjgBXTxpS
	UYLslLcTFYInmMCHLeZ4QTpBn3qpCtlf7ieJNNYUyjf8TGZFxSnLEJhg7e5zwuw=
X-Google-Smtp-Source: AGHT+IFOULpzfkEKoKEGmcSN0BoNscI93ZPof/9O69rlmHT7S8HVoLA+6CXd6uunVdUipbdH0C4ExQ==
X-Received: by 2002:a17:902:6546:b0:1ea:cb6f:ee5b with SMTP id d9443c01a7336-1ef43e2796fmr155486445ad.38.1715761156601;
        Wed, 15 May 2024 01:19:16 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62fesm112051265ad.83.2024.05.15.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 01:19:16 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: edumazet@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	laoar.shao@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt performance
Date: Wed, 15 May 2024 16:19:01 +0800
Message-Id: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Set the full package write tcp option, the test found that the loss
will be 20%. If a package wants to write tcp option, it will trigger
bpf prog three times, and call "tcp_send_mss" calculate mss_cache,
call "tcp_established_options" to reserve tcp opt len, call
"bpf_skops_write_hdr_opt" to write tcp opt, but "tcp_send_mss" before
TSO. Through bpftrace tracking, it was found that during the pressure
test, "tcp_send_mss" call frequency was 90w/s. Considering that opt
len does not change often, consider caching opt len for optimization.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 include/linux/tcp.h            |  3 +++
 include/uapi/linux/bpf.h       |  8 +++++++-
 net/ipv4/tcp_output.c          | 12 +++++++++++-
 tools/include/uapi/linux/bpf.h |  8 +++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..74437fcf94a2 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -455,6 +455,9 @@ struct tcp_sock {
 					  * to recur itself by calling
 					  * bpf_setsockopt(TCP_CONGESTION, "itself").
 					  */
+	u8	bpf_opt_len;		/* save tcp opt len implementation
+					 * BPF_SOCK_OPS_HDR_OPT_LEN_CB fast path
+					 */
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
 #else
 #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 90706a47f6ff..f2092de1f432 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6892,8 +6892,14 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Fast path to reserve space in a skb under
+	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
+	 * opt length doesn't change often, so it can save in the tcp_sock. And
+	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
+	 */
+	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ea7ad7d99245..0e7480a58012 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -488,12 +488,21 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 {
 	struct bpf_sock_ops_kern sock_ops;
 	int err;
+	struct tcp_sock *th = (struct tcp_sock *)sk;
 
-	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
+	if (likely(!BPF_SOCK_OPS_TEST_FLAG(th,
 					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
 	    !*remaining)
 		return;
 
+	if (likely(BPF_SOCK_OPS_TEST_FLAG(th,
+					  BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG)) &&
+	    th->bpf_opt_len) {
+		*remaining -= th->bpf_opt_len;
+		opts->bpf_opt_len = th->bpf_opt_len;
+		return;
+	}
+
 	/* *remaining has already been aligned to 4 bytes, so *remaining >= 4 */
 
 	/* init sock_ops */
@@ -538,6 +547,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	opts->bpf_opt_len = *remaining - sock_ops.remaining_opt_len;
 	/* round up to 4 bytes */
 	opts->bpf_opt_len = (opts->bpf_opt_len + 3) & ~3;
+	th->bpf_opt_len = opts->bpf_opt_len;
 
 	*remaining -= opts->bpf_opt_len;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 90706a47f6ff..f2092de1f432 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6892,8 +6892,14 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Fast path to reserve space in a skb under
+	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
+	 * opt length doesn't change often, so it can save in the tcp_sock. And
+	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
+	 */
+	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 /* List of known BPF sock_ops operators.
-- 
2.30.2


