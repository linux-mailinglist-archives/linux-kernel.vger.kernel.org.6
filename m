Return-Path: <linux-kernel+bounces-429652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD79E1F22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B758164AC0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B51F4735;
	Tue,  3 Dec 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM/BhQ8J"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835B1F472A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236119; cv=none; b=uodnXAQB22Rb7H9O/eL1m5LP/cLgfVvpBTnLp7wjZyKK9aPgQ98bCx+eZ0K68mE7HIyqmH69C+U/Z2IYyWgHV7XvKAMbohiw1ot2sBiMOj6uD/Det6/DXzNQEM4H8zfgkIoBZTyZFnbcuY2IKhcKckZBvokOmyRPm5QtG+bZqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236119; c=relaxed/simple;
	bh=CiA7urzExORBNfNnKVkDnfqRTn3t7XF1Gk8zmHVsPIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKffikaTo1GgxdnhCnN/eoTVcfT+w9QcnDVoR0DYkggxTJy41phmL7KaiE1iHchr2apPl+tM7nV6qWR9g/QWgnElc/cUz+JnZ55eQWHi7XS2jylU7Ck7JPMN+kH8zUFk0eySKoc4CBrnBE2XVrt2ESXvWveiTB0/5KRH5k4Pc2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM/BhQ8J; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc93152edcso4136545a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236118; x=1733840918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5z6e0Wwzok4/c8JJ14VvrKpt6wQ9E07/XNoPDXalY0=;
        b=QM/BhQ8JzDGsh19ey/+pGkbSiSIGrq9V6L8/wjeTCekjXvCH+nsiCuwiEIJi5g3nB9
         2e1JjZbRWm0vn3r5JciYF8VtZmvWJLFlcEcCfRwAaPCOl2rpatj48i+mkwpayD6f4Kxz
         uxQCafD7eL1ZFW+QGPWvNehVQmruA/DmdpTcaX0BhPgvhsgBLsHC3AnpsiTSGAdyqhM9
         XGJUR7RYVxYBtLDchWDe4XelJyVldrgDs+T4mhm9qJyMDuvABP+bHgfkSHQP9GqYe7BW
         PVA1OgmJNsftiJ0tmOjWMt3N9SJWn1Y5oUON8BhguSrAz0U9Gr3zErqMUi/JsOn6jG+7
         36XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236118; x=1733840918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5z6e0Wwzok4/c8JJ14VvrKpt6wQ9E07/XNoPDXalY0=;
        b=iWBp2esXSU9TWomfIGCAtyW/5NMJmY7iVlNBHjWeBrSHUYv3238g7HBPHpdzGM63Zu
         YSqFZK/OsveOi0kDpJmT83qx1w2AjleEsYVOpJwscVpjoaBxe+atQHWSs7KN1TLWjbzR
         miUZ48TzlE0ILYB82r4oYgBNAXZTSzFuATgy7vcsOte8bbgfBOLrwbF92poLCF1esev+
         ur1VlBrGo4eYFb5PrMaR8lGczGwluLgGd/ChshmUiqh2XrjX4/WYi1U/FKtD4/SFR1pW
         3HLQoSZdnaDjDABSym35mWLJJ5lZRm3Dbri29hPLs8I/BjA2tuXzPjfTcPDbtQxks5R/
         XFcA==
X-Forwarded-Encrypted: i=1; AJvYcCUTPgbeELItGp3w15NIN5qMfRBftWrxh5dX3ZELs0055Ps1iZWcLk9BABwrcnGp/xnToKj8F2yasDPM+wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGFNNgYSAfVFd697/YINTm440//ouAlIRCSNMFoIggdh2FVxh
	Ek6evI/WG9YuifXyJJBT6EqHlxTHh4jQooCqEYSW2lyTLcae6iQL
X-Gm-Gg: ASbGncuu9UKJLa4oLVkA1OdAr4T8PkbFXLMBOTktLO4sH3mjWVjOMS83H1fMkxh1hbZ
	xqPt4wVkaBNfZfaQah9R+3+n1o4kzBMQ9qphT9MjqZnb5Uyjq5JA76hUri/AVjjBBo6Iejk09WD
	/JpVdRL86ERvjhxDdPhlVtnPkpChM+AIMxreLs3+b0C1pYk1DndURaycyIZh9fn8dLyNZEByQkN
	pVxZz8NhwthQXoD9jUVGeOb7dV2H3iCliP/MBg9qvnDohpG3Wp5LhGzmTR9kVPLR0Td4aZz3nax
	nlsS1A==
X-Google-Smtp-Source: AGHT+IFKmA4cKMp0jI/Mp+cRDt5ueufgdNIF0oU4f10SCH9s78uN8Zp8/PfN2JyO5T6Wlka9ORZ0DA==
X-Received: by 2002:a17:90b:1c89:b0:2ee:1ae:a247 with SMTP id 98e67ed59e1d1-2ee25ade311mr32989740a91.8.1733236117782;
        Tue, 03 Dec 2024 06:28:37 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848b36sm10862079b3a.187.2024.12.03.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:28:37 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] sched_ext: Add scx_bpf_clock_get_ns() for BPF scheduler
Date: Tue,  3 Dec 2024 23:28:01 +0900
Message-ID: <20241203142802.36305-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203142802.36305-1-changwoo@igalia.com>
References: <20241203142802.36305-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_clock_get_ns() is added to the header files so the BPF
scheduler can use it.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 1 +
 tools/sched_ext/include/scx/compat.bpf.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 2f36b7b6418d..230c7f2e8ad6 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -72,6 +72,7 @@ bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
+u64 scx_bpf_clock_get_ns(void) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index d56520100a26..d295c59e3f05 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -125,6 +125,11 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	false;									\
 })
 
+#define scx_bpf_clock_get_ns()							\
+	(bpf_ksym_exists(scx_bpf_clock_get_ns) ?				\
+	 scx_bpf_clock_get_ns() :						\
+	 bpf_ktime_get_ns())
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
-- 
2.47.1


