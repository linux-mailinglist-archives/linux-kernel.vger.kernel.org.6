Return-Path: <linux-kernel+bounces-189033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F62E8CEA20
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFE01F21598
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8346B433C9;
	Fri, 24 May 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j36Ju1ge"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A508493
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716577114; cv=none; b=eELVgH001Kt6CkzudnlcT7e85ohJu1OqaieqkdZKpJE7sAmaexj0jTr40jeF+zTJHEGuyEpGfN40QdcNEk9Wc0xNuF+xRtnMjIJPmJxQ88GUWYpZALiINTTmzl0TUlRjpqqcWdOLuTxyCEACowBxzdeFCP53Mbdy62hRVktHQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716577114; c=relaxed/simple;
	bh=Xh261FhzfMdN4p0leAnX/OS4tocPTNjZvsxKpcv3dLQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=eUBZx8WQB3+i1AgxguUU0F4Fy5AJEBCC4yFvUNSKL+NPFfaNjPwSG4JnL4CfxV6NdsNMYgziF8VPylhICbOr8hJ/vCagTufJmlkx/Ld+frq8yiPzkwX8wyhFXA+Cw4WNiDWI+wPNA81GN3w1KSqbRd5zIVZcUscHgnMGOvd43zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j36Ju1ge; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4f2b1c997so3642544b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716577113; x=1717181913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RrKP1I0hzARrkB4G3OpG80xbsCt9+3A50HmWdCi5acQ=;
        b=j36Ju1geg3fXlmx1T70lEFLEwweMCo2yAkE9knGEFRoNauo+itILq2YOsW1NyiWyTW
         J2WegdOB+LONwjc8BT91OsPmkG2k+l0qbdOWiGEQaHhgbt/k1XNI1VBrnv5IUbgOFrq4
         2Z3k8Fwyp2NKMKzIuCfquW3wBcMc3BuyiJfrD/kuZC7oOLMXxSlEqxXoMHQO6qhvnWTM
         aA57GXZ1VxAJH0Lthg1rhaJ55kgAY6CKteCk9mW2X4sZJvDvF2eB3lTr6jBDzyxDmaAc
         ngXbGeyw5cJJazIDctoUN6tL/mwfw+U2a9rqaFnid6dO0H3I8V6Xr/5Zl/c4TbaAD4cV
         C+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716577113; x=1717181913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RrKP1I0hzARrkB4G3OpG80xbsCt9+3A50HmWdCi5acQ=;
        b=QP/cUvVO7U2XBm06A7l6OnUcCuvzZuPWWd12D1bVmM/QH+gARBnYdxyRiyxLLJaa5y
         t2ShTP44qr7iLbV95QkEadTYMwjs94b4e+dVlOTxGj+YkIXWhdDzBzFoUc15MiwpiMnp
         xqwgIrMGhOA1/sFTFf2lonkE5sNbsAKpVCp/hkojCg+YmUESDLGRyho82zPHXBIp/unC
         rtDqQxTUs62o14iTToPIVpupEs9aVBR+mvvCc/w81GdPEziyqmUrAjFbN8ORdRuTtG1L
         5+MDYLADlewRXnoyeXCjMMgMJGAC7giVuDppbwIUE12hBOUCHNzH9w6jL52c4aT5YRtu
         ECsQ==
X-Gm-Message-State: AOJu0Ywkmv3nehc/RHOw+PGDLgYTQhmDLQErsQbqovTPAVPgzUrI4g4G
	5l0/3o94IdZJSoyNwEuKr390S0UFnwwzI9BR11+5NMOzOgH2l1o3IoUtzQ==
X-Google-Smtp-Source: AGHT+IEeOL4+DDfFVDCWa8ix6IV4an4tARFBIkTjGZ1JnvwYcecDalOsqtQfE1U4f/+uWyL6qDO1lQ==
X-Received: by 2002:a05:6a20:da87:b0:1b0:278e:34a6 with SMTP id adf61e73a8af0-1b212e14496mr4006548637.49.1716577112642;
        Fri, 24 May 2024 11:58:32 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ebcfsm1413059b3a.4.2024.05.24.11.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:58:32 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH] cpumask: introduce assign_cpu() macro
Date: Fri, 24 May 2024 11:58:28 -0700
Message-Id: <20240524185828.1582494-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that assign_bit() is a thin macro wrapper around set_bit() and
clear_bit(), we can use it in cpumask API and drop duplicating
implementations of set_cpu_xxx() helpers with no additional overhead.

Bloat-o-meter reports almost 2k less of generated code for allyesconfig,
mostly in kernel/cpu.c:
	add/remove: 2/4 grow/shrink: 3/4 up/down: 498/-2228 (-1730)

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 23686bed441d..06ce329741e2 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1083,44 +1083,16 @@ void init_cpu_present(const struct cpumask *src);
 void init_cpu_possible(const struct cpumask *src);
 void init_cpu_online(const struct cpumask *src);
 
-static inline void
-set_cpu_possible(unsigned int cpu, bool possible)
-{
-	if (possible)
-		cpumask_set_cpu(cpu, &__cpu_possible_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
-}
+#define assign_cpu(cpu, mask, val)	\
+	assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
 
-static inline void
-set_cpu_present(unsigned int cpu, bool present)
-{
-	if (present)
-		cpumask_set_cpu(cpu, &__cpu_present_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_present_mask);
-}
+#define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_mask, (possible))
+#define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
+#define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
+#define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
 
 void set_cpu_online(unsigned int cpu, bool online);
 
-static inline void
-set_cpu_active(unsigned int cpu, bool active)
-{
-	if (active)
-		cpumask_set_cpu(cpu, &__cpu_active_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_active_mask);
-}
-
-static inline void
-set_cpu_dying(unsigned int cpu, bool dying)
-{
-	if (dying)
-		cpumask_set_cpu(cpu, &__cpu_dying_mask);
-	else
-		cpumask_clear_cpu(cpu, &__cpu_dying_mask);
-}
-
 /**
  * to_cpumask - convert a NR_CPUS bitmap to a struct cpumask *
  * @bitmap: the bitmap
-- 
2.40.1


