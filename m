Return-Path: <linux-kernel+bounces-377360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D039ABDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BB91C22963
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4F1487DD;
	Wed, 23 Oct 2024 05:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPUpHMEB"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983E1474A4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661100; cv=none; b=Wy+tlBIDYBC7m9Jg2cZw50ANo8t02x21P3gdWxHkZ7cNlDHHM+dN/SeA6FfDmWZ5TuLzBYD31TZjxwzYEXwv4RwHdlAeTgXjuMLZaOr9pT9f8c8R76CuvEp0Y6hWdLmjI3MqOOHnJ4vXDzhb6aP/gZIUKBHrsUAfmOcIE7vQFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661100; c=relaxed/simple;
	bh=MCmETfZcZj5n6OFijgJ/yWX5JAS0t9EX0hV8HW73GUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knQVKqMgj7OK5JpZ3wXadvAWcKJ6SpWYt3b86xKE+qoWJCT6mCXsfN6bXvte0a+HmbjVkVr5Yd+Hi4eQlPRpCths8rO6A6DElpVKJTEDUBA/BvvfVVCwBu3L9gQ9Br4Fp4XYMe/FmjA+VQYCc6KKYbLwPmO0inhV/+RvDgW+62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OPUpHMEB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c1324be8easo371090a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729661098; x=1730265898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d15nvcJtJm0xxzKGhSuaLpa/avMIoSmpwjQhzt/2TMY=;
        b=OPUpHMEBzzn/pIkJ4eEBTCeK3ii2CB3ukjxTo2LNP9G0ta8nO0i3C0ZXjF2uctf9+l
         rrmZgqvaVa7Be2kev4sOvL3GtnNmMKfy/FqOoi7qqkVCaTi06fUseqjJw1hwlvJeDvjo
         MZ0jeS3l/PvYqWvNGeNVweXbQbIVMFKzc9Vtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729661098; x=1730265898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d15nvcJtJm0xxzKGhSuaLpa/avMIoSmpwjQhzt/2TMY=;
        b=EjWS9Rgn5Qo4x2qKCcarir/7/lz9XlyMccm/sWWRJjLghr+slhH4svJ6hVNUuzuaXI
         D9pmQgT3nc9HAz69YMTUAESDOzeR8dcheCH2ecjQ/TIPQeD2lQ07NjXd94EZHJvBD4Rn
         ijjgVeegVDLNAkgIku7o5PLh6SlCAClHFpOlgUgI7x2R4zgcRW4xe6HrHRmQVcRN+ORX
         6h04zV95u1c2cYbpFT2TBUUZyzzhCachUwvW4nZ5pciBdiVvswHIV4fPHVNuuBkapoW5
         dN9gW9MNGtP/MF+6u/ExWmCY/JhiSXrYva8vmPkXMTWnWnKg9dUTZr4lpPq03iVI/ADr
         qxeg==
X-Forwarded-Encrypted: i=1; AJvYcCUEDRgEgcI9onzJ9rW8GwYATQIq86JHGWf1WLdUUVDAKWLMag4Li/uhXrkF01uvNfLNtuOS4zXWKoDvg/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmRTeqOsc2WwIam4+S/Ctl9OraiUgFVMKuuRvevGjuXIEZTUj
	JqpK6ARq8rkRzy2lGOrv+STMIWnow56V++coshF/YZ/t+/0xXiGu2+av/uH4ZXawSEA1mGN3fBW
	Kig==
X-Google-Smtp-Source: AGHT+IHl3D8Qkd/KZA/PXyc+r9DQ/C5MkJdw5siV/LSFX5r2bUqo8lUiyR9QO9wbsDE6IHWw+loMsA==
X-Received: by 2002:a17:90a:ae17:b0:2e2:e086:f5c0 with SMTP id 98e67ed59e1d1-2e5db93c457mr8706614a91.5.1729661098051;
        Tue, 22 Oct 2024 22:24:58 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:eec8:692:e549:d490])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e76e088f1fsm413112a91.56.2024.10.22.22.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 22:24:57 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] media: venus: sync with threaded IRQ during inst destruction
Date: Wed, 23 Oct 2024 14:24:22 +0900
Message-ID: <20241023052444.139356-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
In-Reply-To: <20241023052444.139356-1-senozhatsky@chromium.org>
References: <20241023052444.139356-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When destroy inst we should make sure that we don't race
against threaded IRQ (or pending IRQ), otherwise we can
concurrently kfree() inst context and inst itself.

BUG: KASAN: slab-use-after-free in vb2_queue_error+0x80/0x90
Call trace:
dump_backtrace+0x1c4/0x1f8
show_stack+0x38/0x60
dump_stack_lvl+0x168/0x1f0
print_report+0x170/0x4c8
kasan_report+0x94/0xd0
__asan_report_load2_noabort+0x20/0x30
vb2_queue_error+0x80/0x90
venus_helper_vb2_queue_error+0x54/0x78
venc_event_notify+0xec/0x158
hfi_event_notify+0x878/0xd20
hfi_process_msg_packet+0x27c/0x4e0
venus_isr_thread+0x258/0x6e8
hfi_isr_thread+0x70/0x90
venus_isr_thread+0x34/0x50
irq_thread_fn+0x88/0x130
irq_thread+0x160/0x2c0
kthread+0x294/0x328
ret_from_fork+0x10/0x20

Allocated by task 20291:
kasan_set_track+0x4c/0x80
kasan_save_alloc_info+0x28/0x38
__kasan_kmalloc+0x84/0xa0
kmalloc_trace+0x7c/0x98
v4l2_m2m_ctx_init+0x74/0x280
venc_open+0x444/0x6d0
v4l2_open+0x19c/0x2a0
chrdev_open+0x374/0x3f0
do_dentry_open+0x710/0x10a8
vfs_open+0x88/0xa8
path_openat+0x1e6c/0x2700
do_filp_open+0x1a4/0x2e0
do_sys_openat2+0xe8/0x508
do_sys_open+0x15c/0x1a0
__arm64_sys_openat+0xa8/0xc8
invoke_syscall+0xdc/0x270
el0_svc_common+0x1ec/0x250
do_el0_svc+0x54/0x70
el0_svc+0x50/0xe8
el0t_64_sync_handler+0x48/0x120
el0t_64_sync+0x1a8/0x1b0

Guard inst destruction (both dec and enc) with hard and threaded
IRQ synchronization.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 13 +++++++++++++
 drivers/media/platform/qcom/venus/venc.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 0013c4704f03..ff1823bc967c 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1747,6 +1747,13 @@ static int vdec_close(struct file *file)
 {
 	struct venus_inst *inst = to_inst(file);
 
+	/*
+	 * Make sure we don't have pending IRQs and no threaded IRQ handler is
+	 * running nor pending (synchronize_irq)), which can race with inst
+	 * destruction.
+	 */
+	disable_irq(inst->core->irq);
+
 	vdec_pm_get(inst);
 
 	cancel_work_sync(&inst->delayed_process_work);
@@ -1763,6 +1770,12 @@ static int vdec_close(struct file *file)
 
 	vdec_pm_put(inst, false);
 
+	/*
+	 * inst is gone from the core->instances list, re-enable IRQ and
+	 * threaded IRQ
+	 */
+	enable_irq(inst->core->irq);
+
 	kfree(inst);
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 6a26a6592424..6575e84312fe 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1515,6 +1515,13 @@ static int venc_close(struct file *file)
 {
 	struct venus_inst *inst = to_inst(file);
 
+	/*
+	 * Make sure we don't have pending IRQs and no threaded IRQ handler is
+	 * running nor pending (synchronize_irq)), which can race with inst
+	 * destruction.
+	 */
+	disable_irq(inst->core->irq);
+
 	venc_pm_get(inst);
 
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
@@ -1530,6 +1537,12 @@ static int venc_close(struct file *file)
 
 	venc_pm_put(inst, false);
 
+	/*
+	 * inst is gone from the core->instances list, re-enable IRQ and
+	 * threaded IRQ
+	 */
+	enable_irq(inst->core->irq);
+
 	kfree(inst);
 	return 0;
 }
-- 
2.47.0.105.g07ac214952-goog


