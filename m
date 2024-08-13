Return-Path: <linux-kernel+bounces-285365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5A950C95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8BD1F230F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3021A3BB8;
	Tue, 13 Aug 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwMrEPAh"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3E1A3BDF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575399; cv=none; b=OCOVUwkTNUdjMwSyUGdl/zgOrU8BqgKEthN0O7BL+qJg7BtQvtz3eyrkdyFrX81+KfQ0ySazCgzJ8w1GX5PbEFS5GzcRlCBtApAAzqhgIJBAWV+q7HjImmbavHCmo4HHvl1IPdj4q92sdq5WoHrYvJCVUCbep9Gz53LmGYL5jIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575399; c=relaxed/simple;
	bh=sxl3Q/M50FoEVLaFI487kfJRqkxBTh9NlombsgH24Bg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jYvX+B78gRpsQLyHaNu5RcBxMW2pjUphiNDCAoSmkmO0ew956BgqHx2mko0BPQyIFBGf2HnJx/QZ5wJijJLPfMdfkgPeDive6mftA3z7AJEdMiF2w7qY1Ul4Ea6+WlCquID57t1iGmFgjlSOW1lyVQvMk0U63HZYnFXubCT/TBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwMrEPAh; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70945a007f0so3544923a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575397; x=1724180197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uZPoZLwwYwjeoVzOm1/fGWvSJYOkVNi9fLZREpsKc50=;
        b=SwMrEPAhge2QLO7R8AiY4UV4YuhIxUgxIrS1M5cEENNZI8NOWQr8EgaraTR/ms+/TR
         SXt0bjNOrndAAPCyfBtsvEceijm1BO/s0DJj/oIaX3cWC2ikdhGAIDv6tyODcPrJubmr
         RkBTZ1EoxkD0mzQxiR+7ONP5sWTnmaZRFvwR00isR9gGiPg9jT/jAcIdTWbaNA3DYcWq
         tcd8WfgC9ns3RxWzKma0EfHgWLhjXuOeYXw20rtP53dGPxBmOMfZxWV97e1g4/Sktd/b
         Y9pRdwafj6TVp4K/AlMQKb01baO6rN+xYNfbBYnY3O+XxyIi2U1HT3IRplUbTPbqgmE3
         +/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575397; x=1724180197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZPoZLwwYwjeoVzOm1/fGWvSJYOkVNi9fLZREpsKc50=;
        b=FMuWWqbSQSiTJqq24gOJC3SCymKwvjptVMFRt36de7RCIj5N8yZfB9otLiLBhlKucb
         3jhjGvo08L5Jb6QrstuMgK8FuroJ1XlsDDc+yHTd0OrmCpy/6iibvW3pv41Zr/lor/AI
         11ESGylTFSaG5IfcDBlTqop3UvvtTLSPHNbATL1pSnSdB2Ws42v5ZXcambGxTa19CkzZ
         sE2pSA7TbEC2MXy/GIO+xoKTpbkB85Z//phErSdbHSiGc4I0szn539MheV1i2T8AdtGx
         Hjy6ribC+49L7GRF9l4ClPT/pVAbo6DDDFFckRuwcOtf/+4O3wK/Ulvpj5M07j14Vswy
         40sA==
X-Forwarded-Encrypted: i=1; AJvYcCV2x0JhBUxiwEo4ST0jHD0bDPVB/DY4UD7Efef6xIOHMD8WliCk06tJmeiC3ZCDCIHWG2txgrEvB0G+Q1OkuX8KGts5yF4oBScOBrgO
X-Gm-Message-State: AOJu0YzmKqyJUnXwUGgbgKUUcMdNpMWd6d4gdxwx2hd0BxDPv4PQVb+V
	dY3+voSYQ7aiPNaiXhNIxk/X7aXQYbuWqVsKBu9aPdJvO/cC5hqONwMxwQ==
X-Google-Smtp-Source: AGHT+IGI01OmA2yTXOPZ5CIrfgBK4+YbufSTzte+mnqLwGHZJ4GtekvUuYSRQCTZktfT1wtgne62+w==
X-Received: by 2002:a05:6830:6e8b:b0:709:4c6a:b98a with SMTP id 46e09a7af769-70c9da04c91mr766060a34.30.1723575396875;
        Tue, 13 Aug 2024 11:56:36 -0700 (PDT)
Received: from localhost (fwdproxy-vll-115.fbsv.net. [2a03:2880:12ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c7b829b5dsm1959618a34.42.2024.08.13.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:56:36 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: tj@kernel.org,
	void@manifault.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: define missing cfi stubs for sched_ext
Date: Tue, 13 Aug 2024 11:56:25 -0700
Message-ID: <20240813185625.535541-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`__bpf_ops_sched_ext_ops` was missing the initialization of some struct
attributes.
With
https://lore.kernel.org/all/20240722183049.2254692-4-martin.lau@linux.dev/
every single attributes need to be initialized programs (like scx_layered)
will fail to load.

  05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_init not found in kernel, skipping it as it's set to zero
  05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_exit not found in kernel, skipping it as it's set to zero
  05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_prep_move not found in kernel, skipping it as it's set to zero
  05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_move not found in kernel, skipping it as it's set to zero
  05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_cancel_move not found in kernel, skipping it as it's set to zero
  05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_set_weight not found in kernel, skipping it as it's set to zero
  05:26:48 [WARN] libbpf: prog 'layered_dump': BPF program load failed: unknown error (-524)
  05:26:48 [WARN] libbpf: prog 'layered_dump': -- BEGIN PROG LOAD LOG --
  attach to unsupported member dump of struct sched_ext_ops
  processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  05:26:48 [WARN] libbpf: prog 'layered_dump': failed to load: -524
  05:26:48 [WARN] libbpf: failed to load object 'bpf_bpf'
  05:26:48 [WARN] libbpf: failed to load BPF skeleton 'bpf_bpf': -524
  Error: Failed to load BPF program

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 kernel/sched/ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 143c4207a826..3560d8bed06d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5111,6 +5111,9 @@ static void cpu_online_stub(s32 cpu) {}
 static void cpu_offline_stub(s32 cpu) {}
 static s32 init_stub(void) { return -EINVAL; }
 static void exit_stub(struct scx_exit_info *info) {}
+static void dump_stub(struct scx_dump_ctx *ctx) {}
+static void dump_cpu_stub(struct scx_dump_ctx *ctx, s32 cpu, bool idle) {}
+static void dump_task_stub(struct scx_dump_ctx *ctx, struct task_struct *p) {}
 
 static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.select_cpu = select_cpu_stub,
@@ -5136,6 +5139,9 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cpu_offline = cpu_offline_stub,
 	.init = init_stub,
 	.exit = exit_stub,
+	.dump = dump_stub,
+	.dump_cpu = dump_cpu_stub,
+	.dump_task = dump_task_stub,
 };
 
 static struct bpf_struct_ops bpf_sched_ext_ops = {
-- 
2.43.5


