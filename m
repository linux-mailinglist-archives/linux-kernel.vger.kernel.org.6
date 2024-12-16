Return-Path: <linux-kernel+bounces-446742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEEF9F289D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BD518860A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A919415D;
	Mon, 16 Dec 2024 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1OWYE1N"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F719258B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318744; cv=none; b=XKeldMzTNfTdiboF4DidaSF8TlsAO/c//CEL6w/Fb2tc91HCLGNkrTsUnn9wV5Hp4GU9HBHQ2XAe+wHaC6nRbt9XJTFp/0auUSjGZzx79TF4u/XxSSB5IeFU5uKk9iD+OHRT3YtyguI9Gsb4LASwHj1oYirW+ej4bahPf93XVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318744; c=relaxed/simple;
	bh=GZDtGSP3knc4XfhDJndoAF3aAtv9DQSb0onbM9mot6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq7cNy4Koz++6d5BpAJecXVn3X7Frd/dPZSNGFazjTRT1kNiD3d0AyZawo47MIafz35NNyM4kwDzz5Gr5Q+pBYREkO8iKU5iTVSMOjuNEXYQYmdm9lQ5OqXhK51l1Qc9DpEacqL83n97FLZbArJcV+pSJVjkRlgX7V7W3d8LKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1OWYE1N; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728f28744c5so3111724b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318742; x=1734923542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qwdnhpnNZ/kDLebmCqGGOAqoWdsfoXXWVd5XUHDoNY=;
        b=P1OWYE1N6A6si4wPljkyOY6rSknFQ2XTH4cdMBxqiFINzD2IQt6dVSzDIAB9QHe+F1
         ePlm0Vx75Xo4IrPdentab8KtPxoYlSfXKx6vDI7z7hQv/Nj3mFKbJNLL9Wfx2qDwmUMy
         68qO8kYErkXttG+o2eFyxJTY8d0l3dpCiFy09VbS1fPqEl77PcrUEdafe6g/+gT9g973
         NCYrAedz3ke2jAraas3+FOZ0r6O8hP5QuPC3s4WC3VB9UUS0oAUZGcOlslY2PXG3Atp4
         I2A4p3pmCYJia+Rao3ovExiGU9GM6CsLK/SZHzU9OePGu4Z6om85C9IQVbNxXvL/bby+
         j1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318742; x=1734923542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qwdnhpnNZ/kDLebmCqGGOAqoWdsfoXXWVd5XUHDoNY=;
        b=U1qN4T5Oszn9TDrgvIY9n7ncb+tx1bOPk0SjeYdJpe1iumKlRHryLeh/02BDF7KWN4
         jEcOspTOLmsNnRxNb5UCINAKh3aRzNHGgTuMHzrEfhbaHvaH0Jlvy8c2f3YizmUvZ1ha
         k6m5IYWhZXMJi2MH/YHv4MqwHUa24/t3WC9SApjLI9nwaP/SNW6/Vo+EDW1E3qxgzg0Z
         pJKC7FNxRl4yEvFSW1vWppRvpMyspj0cjx0Wig57nmxDpS2WEIVg3wUAXeDU4u6rFT24
         g5iXoCTM9tv5jiX43RF1rujbeV4e04NXHfRGnOfUEFouZShuoWmZgtZ6WZ4LoYpy1twp
         Cfbg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Yh/90kDfPAob42yISLn33F7koi2rpnhhbOVgILhlsTRcLdWsnkXPIR5ZSsuWp00WX0w7mYZu/DO11H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+BvaoAAQsdrF7vrk9sWzKICMSSsf/v17/F1ASo/FPyC3IhySx
	4TUtb5Emr7jBxRJUYFeE9SyukauoaSDXw8bZ6gSFCyqSAOMqw7lc
X-Gm-Gg: ASbGnct4zv2ekORKCw7jSHY/wJN6hTpU3x1d5Nr+GzSCFkZD2dehSN2jLeiOKavAo/g
	SS0gEFcAk3P3M5GnzS6M1hW/lwlK4UWW0ZFS8hP1LLQ3nwA0S2SZCI34U32b9qDA1w/HBXzV5eN
	cqI7vzWpgiYdzNQOj8to0Louj0qO8T86zEtQVvWr00oWhTX46bMH4YfjS9KaolEJZpf47+ytMD5
	7jzjcJ2oOgSiTUwQwG+kkykdYZRphjYqEl/88SpuUl6WOhu2jH8H/Cso+U64OQ3+WVwglb8NXra
	13dyB91LP7gb
X-Google-Smtp-Source: AGHT+IECXXkjMF2cE+MK1ecDOadXetISrI342qnY5QQmSTp/jMki0OfIC4i3ujBXJzrYC7ApnXLdGg==
X-Received: by 2002:a05:6a00:188c:b0:725:cfa3:bc6b with SMTP id d2e1a72fcca58-7290c0de7b8mr16346546b3a.3.1734318741945;
        Sun, 15 Dec 2024 19:12:21 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad55dbsm3650518b3a.43.2024.12.15.19.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:12:21 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v5 3/6] sched_ext: Add scx_bpf_now_ns() for BPF scheduler
Date: Mon, 16 Dec 2024 12:11:41 +0900
Message-ID: <20241216031144.98097-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216031144.98097-1-changwoo@igalia.com>
References: <20241216031144.98097-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_now_ns() is added to the header files so the BPF scheduler
can use it.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 1 +
 tools/sched_ext/include/scx/compat.bpf.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 858ba1f438f6..79f0798a5350 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -76,6 +76,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
+u64 scx_bpf_now_ns(void) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d56520100a26..2f16f30ae741 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -125,6 +125,11 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	false;									\
 })
 
+#define scx_bpf_now_ns()							\
+	(bpf_ksym_exists(scx_bpf_now_ns) ?					\
+	 scx_bpf_now_ns() :							\
+	 bpf_ktime_get_ns())
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.47.1


