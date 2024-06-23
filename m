Return-Path: <linux-kernel+bounces-226002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F959138F1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9911F21A27
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82B25EE97;
	Sun, 23 Jun 2024 08:10:42 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B449633
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719130242; cv=none; b=SubaCGUgUfDKWPowvJeHdWUl6xJMobkMIPPinLizQGc1taQtpZfLz1uuW7kk746B0+78Ln/4hvcRW97UTVlcD5lwKQug5uCkD6ddZB9XHy9dLc+oKruW81NDuW8HXDP4yUOAOXHf0jaxmMnP/qwq3hx4GcpGv78X39Fa4/aP2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719130242; c=relaxed/simple;
	bh=kCK6IPv5OPzpGgedxrm6dWcFY/D5ctUj9i6OlvCN9xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRoAkPJ3PhqdfAzd0GoChxr2nJHU3nZR/QvyOhonGYM3N0056knlhtyog4bgQwPCYeyY0jk2FU6+ZEnFWQXUN+fvN1v4pVCvpnW2yBfaXJL6f3COIbxqUOC6VpYLXAlWk6eaEVnrIF4hmgK+/oVkpuyU8evFcSATZvKcjYw3uP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79776e3e351so266907485a.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 01:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719130240; x=1719735040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXvH3gyii/Xm7CIZXdZvEhVRkZXsV+/DxyPTAPTr/9I=;
        b=ndSaGdHI0t2Gy4mrO6moMAGqexfeOaQvsvz8qxN/5ITqWdBVShKy680U3qkdQqOxwf
         rOu1MMIqf7/wYN13IHYT9PruqO/Iab36POH4hXoL7i5+FiQbXIm3VZM6XeeSqAKZbdSX
         I30mBwGIoynbf+ICCz2mDbuYOmpPzYRhXKtUY7JmBA13m6XgFk4sMlRzlL3qnapiy9pq
         dRqZZULy02vQmNWaiG3qXHZkPqblYrY2enI+mmIDVHLu3p0DmYrkQcA4eAi3aEtkyBhi
         JCZzZ8er0ahYqfYXitaam6F4oO3O+BtWsDv2Ob5Xtbv7TZFByx95IaQ4kgPguO/fXhq5
         zAzA==
X-Gm-Message-State: AOJu0YzNW1bHNdYiWFOA/dw8woJZq9rwF7+yiuX1OgXA4G9MSkuayumC
	cFLKxURcJmwOugbwccf3h2OadTkK2EOM5ckhb1sNowPl778mehz1
X-Google-Smtp-Source: AGHT+IH70lxho+dqQEWs7Khearrpx8fKhjx9wsOsLX2mF59q6/HE5jP2ruZyz0+FkLHwZJTP82t/6Q==
X-Received: by 2002:a05:620a:31a5:b0:795:4e89:53b2 with SMTP id af79cd13be357-79be0dc262amr236489985a.70.1719130239654;
        Sun, 23 Jun 2024 01:10:39 -0700 (PDT)
Received: from localhost (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8c4e83sm217904385a.57.2024.06.23.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 01:10:39 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] sched_ext: Make scx_bpf_cpuperf_set() @cpu arg signed
Date: Sun, 23 Jun 2024 03:10:36 -0500
Message-ID: <20240623081036.51867-1-void@manifault.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scx_bpf_cpuperf_set() kfunc allows a BPF program to set the relative
performance target of a specified CPU. Commit d86adb4fc065 ("sched_ext: Add
cpuperf support") defined the @cpu argument to be unsigned. Let's update it
to be signed to match the norm for the rest of ext.c and the kernel.

Note that the kfunc declaration of scx_bpf_cpuperf_set() in the
common.bpf.h header in tools/sched_ext already listed the cpu as signed, so
this also fixes the build for tools/sched_ext and the sched_ext selftests
due to kfunc declarations now being emitted in vmlinux.h based on BTF (thus
causing the compiler to error due to observing conflicting types).

Fixes: d86adb4fc065 ("sched_ext: Add cpuperf support")
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 28f7a4266fde..8e8b44f2c74a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5893,7 +5893,7 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
-__bpf_kfunc void scx_bpf_cpuperf_set(u32 cpu, u32 perf)
+__bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
 {
 	if (unlikely(perf > SCX_CPUPERF_ONE)) {
 		scx_ops_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
-- 
2.45.2


