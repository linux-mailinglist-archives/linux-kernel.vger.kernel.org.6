Return-Path: <linux-kernel+bounces-248830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B6692E27C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A501C22CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE6215AAB8;
	Thu, 11 Jul 2024 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k71gBFmM"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFE15A84E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686798; cv=none; b=Z1REiF+XmAlF9/vgRSGXGd9AzHnZR2zfH+/Ukr2PFJQXIbTk4YVIG66Dge44ECIkKvOEPkGu3SqehR7Oz6u31/ZCHamipphC2x5FsW6PX8ALRMpP7/nP8FyN6Tk2VezcTQnN78TM/K5c84AtthFAPJX+fVenOYEtsE0N3dFCGg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686798; c=relaxed/simple;
	bh=5p7mKlZBB7cq2x9ObgxrB+VmIQA8vPWZ1rxsNvkxwGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeNQmDjdLMlUfpJPxrMnVd3KBSwo5gIy+KcDJX1e+nb1vuNfGLNnSi8oLPk2cIcbw4EkzQlBy1nIf9J/VIeP8Nd8UrOzCnwayfaFHbuBS+corse/ta5aV8r3XVaR0YfRbgiqRDZvJNBjM49xoj9PZ9FvsAm6yl/Pv6PolUoLH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k71gBFmM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b13791a5eso593897b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686796; x=1721291596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t85OV781BymUmEWmSM0A7uB3A8jTq9hfBdV8Et0tDX8=;
        b=k71gBFmMsyGhygt/2Vjin2SGJLqBIn23h62iBJ0/LsyyRmWcHZTBmElay9GW7K/ZI5
         AJK3C06p5IpWrM44DM3/QShby94w33Jy0vn7MLuX6BHIAPJEaotVBzO55g/0//YZZZCj
         CNS8H2xDFdrRnuZ0Sr8py9Caj2wPhiICPjvpX+VfdqiOlo30FNMXVBLV8h0hh0SoZOm/
         HlGap5qjS3vCWjSIRznQmyYuqMou0qeQaDO9BTn9U7eQouoH+qJyfIiYHgK087gL0IzM
         RFzJpt5x9XMyUQExVpzZBg+zMdd9E88rMA0phwMn+LPjmv2AeT4VxLESKDiidRe/BDY1
         BGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686796; x=1721291596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t85OV781BymUmEWmSM0A7uB3A8jTq9hfBdV8Et0tDX8=;
        b=azKOaytindHIzQCKBX4MxoRDogGJ3+kPHlHRuSJu5Tx0xuiDbvQapwrC0xfUGWAYTg
         o7Nyflq19uZtw9/dazndbi9CnV8DCI2jKSLwzRbYNzb4T/EJMHbp8r1GSYT2OoiZQov0
         PPAMA1GNQiE6QO9oU5xhuCv/BN3KaiAFgV4ccapj85NmZfxzoAJC7vR0X85yxgJsrg2c
         eTVtqWueexQAIN7YAh6XMiMi/7R50hLzmWu301p5YgPGG6WzeMRBW2CzhC0yBRGgKiOA
         zfsdCRZbaDWePIO/GAxjl9LFQtLREckyiF9PLhDRZe6IM1fl0Yu57EaPzgMYGhNCHbiy
         tjdA==
X-Gm-Message-State: AOJu0YwBbA7vCesxvDB9Cx2E6Ix/erN8Y2RBNQCVIOTkTcNpFrBfZA9d
	Teu7VH4Pp5EbihbgPfZXJ9Mf5fbkd7FAixTK1WCLcHwuLmOPYuNfddoTQQ==
X-Google-Smtp-Source: AGHT+IG7bTnGernIehdExOsL0JOIK+sJMIY45PHo7562RtA/o7O4dAKT19bP+tzPg40VyC21PG4tPg==
X-Received: by 2002:a05:6a00:21cb:b0:705:9bd8:4f57 with SMTP id d2e1a72fcca58-70b434f57cemr9507129b3a.7.1720686795732;
        Thu, 11 Jul 2024 01:33:15 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439673c7sm5094039b3a.131.2024.07.11.01.33.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:33:15 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5/7] workqueue: Remove the argument @cpu_going_down from wq_calc_pod_cpumask()
Date: Thu, 11 Jul 2024 16:35:45 +0800
Message-Id: <20240711083547.3981-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

wq_calc_pod_cpumask() uses wq_online_cpumask, which excludes the cpu
going down, so the argument cpu_going_down is unused and can be removed.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 01d5ea1af60a..97ddccf8cd0e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5135,10 +5135,8 @@ static void apply_wqattrs_unlock(void)
  * wq_calc_pod_cpumask - calculate a wq_attrs' cpumask for a pod
  * @attrs: the wq_attrs of the default pwq of the target workqueue
  * @cpu: the target CPU
- * @cpu_going_down: if >= 0, the CPU to consider as offline
  *
- * Calculate the cpumask a workqueue with @attrs should use on @pod. If
- * @cpu_going_down is >= 0, that cpu is considered offline during calculation.
+ * Calculate the cpumask a workqueue with @attrs should use on @pod.
  * The result is stored in @attrs->__pod_cpumask.
  *
  * If pod affinity is not enabled, @attrs->cpumask is always used. If enabled
@@ -5147,8 +5145,7 @@ static void apply_wqattrs_unlock(void)
  *
  * The caller is responsible for ensuring that the cpumask of @pod stays stable.
  */
-static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu,
-				int cpu_going_down)
+static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu)
 {
 	const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
 	int pod = pt->cpu_pod[cpu];
@@ -5244,7 +5241,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 			ctx->dfl_pwq->refcnt++;
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
 		} else {
-			wq_calc_pod_cpumask(new_attrs, cpu, -1);
+			wq_calc_pod_cpumask(new_attrs, cpu);
 			ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, new_attrs);
 			if (!ctx->pwq_tbl[cpu])
 				goto out_free;
@@ -5378,7 +5375,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 			  int hotplug_cpu, bool online)
 {
-	int off_cpu = online ? -1 : hotplug_cpu;
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
 
@@ -5398,7 +5394,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 	wqattrs_actualize_cpumask(target_attrs, wq_unbound_cpumask);
 
 	/* nothing to do if the target cpumask matches the current pwq */
-	wq_calc_pod_cpumask(target_attrs, cpu, off_cpu);
+	wq_calc_pod_cpumask(target_attrs, cpu);
 	if (wqattrs_equal(target_attrs, unbound_pwq(wq, cpu)->pool->attrs))
 		return;
 
-- 
2.19.1.6.gb485710b


