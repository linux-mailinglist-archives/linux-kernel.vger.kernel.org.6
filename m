Return-Path: <linux-kernel+bounces-433538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D429E59B9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FB91885448
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF021C9F7;
	Thu,  5 Dec 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UW27LnFo"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC3221C184
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412668; cv=none; b=UgLKX6hnEoM8kAmBbI9D27LMULUw0/0aUaZk8kUcJYdtHB9ERAWHa2EuuRsrdhxbxI3cBtdE7Q00YfEjiQyvni7XxB4EoYqAO2rI81Rjr7uXPRF5bW8IlQY4/AKSc65irVc9b98Z2/xk2utTzRUbPglZuRJRvDqHqpikUHkOEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412668; c=relaxed/simple;
	bh=FVQB62YfVdS6LV25/gpSV866FvSEUm9K/5r4tQYw+TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f9Y6DaHz3qTSaUbqXz+y9Xq8s5D7X0T5swTVC5gOBsTZU7nu4AtcudjN5e/5QwdSx1OwteqtzabvRKhIMLpUqPFr+l118DctS0w1UySE23LGHK/AazBSreTmA0Y9Ij1szU6J2DmfchtVP366dFYkG86QkRFDXy8WmXJoTrP/WuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UW27LnFo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4349fb56260so7351655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733412664; x=1734017464; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dtS1bKOZ3hPKA4NVU4gutae53nEuJSLIZSDEzMhQ8d4=;
        b=UW27LnFo0oZRewV1FVhxbpiu1Q75Dj0u6DxAXMtTqwyWal1sydS2NvX4b6rP+8LtkA
         VfiWc5ycN/hYYaTYtTrongsCfGYYWto0wiTavCNiGM4QSNJ2ptyEC/Uma7TayFea3+4i
         wI1e4sQp1aNlYnzrYYIwYclfXObzjGcqL6bk0wj408WSJH5uuAqpE8oXAAT3C2gnNhGM
         7xY1xaATXc5coH8J93tw9MdQjj7bX7J3/d8I9c+XdHDODc5udzMygBlsfMvcbV4yNfV2
         wlWKJ3fEBC1zZOCFgTYVtQiznjHs5tbM8HI7sOMlD0mh9O9dNSOgd7ONwpgqfNIofNUC
         WcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412664; x=1734017464;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtS1bKOZ3hPKA4NVU4gutae53nEuJSLIZSDEzMhQ8d4=;
        b=osfq7uqU8eVDGmJGmHwo3WNLv5eevTcoyFNFNCymT8qcHYhBq2SLqzEOLY3h9BGRmo
         P8kzappkQxMmFEsD+gHMhFNtq7roiTTOOONulj+FiHriC7qOfznIzxabF1iRBkMykCmX
         DdshV/MHd727UYlXaPLyk0NYhXR0Rasr6TsOEqiatCVccpMB3h5HBiLOQj2myqeZPazD
         2JixyxJ85NEnj5Za5czryXqe8EzT77J879/T2KPT8Kp7XTtqUwWAliBLGYIkqdpeIjvd
         N+4eCwTMGgq9LfkvpDrcukyktX9VsoDDJHt11/yJ4ztQjKCH85BLZCI4/+tW2S6n/DCM
         Outg==
X-Forwarded-Encrypted: i=1; AJvYcCWe6WDLhQJApJUIImir8YL0Y0ZoGSOzxXzX5D7N/b85dC4gUnn6SuWXxw6X2CkY1SeXea1vjJILBzxTglE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYba/blQIVkeU7PIyBwhfe5Zs5IUd8TPAvfRft9K8NkHyKYDwB
	ZLMHGYfCpfSENDnyd+voZvSaLkGUSIk8rfecm1ZSHQblEDiJ4UvxeZ3DolkRRDGMQujgp2iG/n0
	+b94=
X-Gm-Gg: ASbGncu+lWkBLm04mOiErkmE5h54r4AM/c0rPrNtpm8UqKD3c6KURF4nEiouhRtsXqD
	NUS/AN94T5n7LNY9zCevZCDkIOZuUYx13PwU6eFNjTTMk2U0+J2xuW7BAm4RwDKcvMhf3fpzABK
	6hs4rSZBFDSZGNdjbUaLjj+Kcz1+KK1WAE5tsfg6m4r5xH89u1GW+GLSBFrV022yh4BRkQd3KLq
	igEU563OutraoAUy3uLK1LGp29hc76rGelQBw==
X-Google-Smtp-Source: AGHT+IFykNNt5I74DWAWk9fEIuIL6X0Y3aoyfQBFjOQdIdFjY+RLYTWdqmooS1ZbDOTp+bzVO9jxvA==
X-Received: by 2002:a05:6000:2a85:b0:382:49f9:74bb with SMTP id ffacd0b85a97d-385fd3f92f8mr7466485f8f.35.1733412664560;
        Thu, 05 Dec 2024 07:31:04 -0800 (PST)
Received: from localhost ([152.250.153.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078a86sm3411309a91.35.2024.12.05.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:31:04 -0800 (PST)
From: "Ricardo B. Marliere" <rbm@suse.com>
Date: Thu, 05 Dec 2024 12:31:01 -0300
Subject: [PATCH] riscv: Constify ctl_table variables
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysctl_const-riscv-v1-1-04231ca9a78f@suse.com>
X-B4-Tracking: v=1; b=H4sIADTHUWcC/x3MTQqAIBBA4avErBPU/qirRETpVANh4UQU4t2Tl
 t/ivQCMnpChywJ4vInpcAkqz8Bsk1tRkE0GLXWptKwEv2yufTSH40t4YnOLeWoLa61sVFVDCk+
 PCz3/tB9i/AA7C0jpZAAAAA==
X-Change-ID: 20241205-sysctl_const-riscv-ba93ddd07156
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1802; i=rbm@suse.com;
 h=from:subject:message-id; bh=FVQB62YfVdS6LV25/gpSV866FvSEUm9K/5r4tQYw+TU=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnUcc2NFGiCmkdwwlB23DFBjbPBAsnKPwrp+Aex
 V/vWo7CSliJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1HHNgAKCRDJC4p8Y4ZY
 pqkdD/45o5I6UbMj9rFLqPyz+SFZ+dS9mlwTzLvaaMx4cdZcda5P1645pEhypH81gaOnOiXbfTi
 fWurP1ALzm5PHH+wOWNNEd/W0jeZCkPhkIiv1UqmvFjOMS132V4+lQwXd6/ecSFrsHCGH/p6X+j
 FjxLeTZ4ZAHZv2xSDVPEp3NOUyM9OA+e+LKwXcQ+Xn7aMhXJqFrtGeEtyN1PdaxY9lhcxz2rlM7
 UqzwPjnS7pGiL7b61JWdPgjdy7Cu97Jg+TqnnNIHQ01jDwbEGXS8UZB3vBQODBJ1k9l2pXwDhfe
 xB4D9VpBBMGSNojPJhtUd3/RIHYD81fwV20lfQHL89lD6k/B77fkP6Nw8N4KUQr+xpVdoXPUU/T
 A/e0CRB4Mi3vkNo6Q6fvWnwgyz9gDfpFXCkOlL1qzsZLMVW6bOXnawcAzPHzJA+anDVZJcksYf3
 E8d5PTz6dHEo4Bi6uSYHIbnygemaHf3IbE44brYUGjofACXP/FJMPp7g96JUc2CO5Rx0ZckUblp
 CTVVLeoaI+hWG0NU7C7C0M036aBOEz0mafWZCDOyCM7QP2Mw+iiKG/55wL+ntvNPR7kFuumeXIn
 /dteHOOqDyDCi/R8ypNQKAvpNRe+XM0+pJklB6s+cZ0/cb1zWtfEEbwvk2bJ4xJpa0Y825sBiYm
 8AR9dnCJ1HW7PjA==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), it is possible to put ctl_table variables into read-only
storage. So, make tagged_addr_sysctl_table and riscv_v_default_vstate_table
const.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 arch/riscv/kernel/process.c | 2 +-
 arch/riscv/kernel/vector.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 58b6482c2bf662bf5224ca50c8e21a68760a6b41..7891294abf4937de3c7e440573844253e856b39f 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -364,7 +364,7 @@ static bool try_to_set_pmm(unsigned long value)
  * disable it for tasks that already opted in to the relaxed ABI.
  */
 
-static struct ctl_table tagged_addr_sysctl_table[] = {
+static const struct ctl_table tagged_addr_sysctl_table[] = {
 	{
 		.procname	= "tagged_addr_disabled",
 		.mode		= 0644,
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 821818886fab06aa054e2ba3266897e9b4d161c0..d022b028ac3ff5375f522947d34166266ceb424a 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -287,7 +287,7 @@ long riscv_v_vstate_ctrl_set_current(unsigned long arg)
 
 #ifdef CONFIG_SYSCTL
 
-static struct ctl_table riscv_v_default_vstate_table[] = {
+static const struct ctl_table riscv_v_default_vstate_table[] = {
 	{
 		.procname	= "riscv_v_default_allow",
 		.data		= &riscv_v_implicit_uacc,

---
base-commit: 8d4f1e05ff821a5d59116ab8c3a30fcae81d8597
change-id: 20241205-sysctl_const-riscv-ba93ddd07156

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


