Return-Path: <linux-kernel+bounces-537062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D0AA487AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD21B3A37B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555D232792;
	Thu, 27 Feb 2025 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lb+0b8s7"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD0206F15
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680281; cv=none; b=uhk3P+6R/xFOlITDQHGs6/zzgsSCU2mgKOOgPzIBGcU2frAbHDplSGpZIhezY4d1V/Wre7wcZEzfaP6z2LUvQYaY+FwvAQ0bGbqbcsPeJev07vHXe7ofNPs3Q3mH1rgXD27a1RUJEylQfANNpftdZnRwZqAM9CRZYN4eP7CTcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680281; c=relaxed/simple;
	bh=yROXWz5RPIqMRSS9HSXpl1oGHLGodzFWkAFk1uLzGBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQDWQTI0BwtuLkfhczszgmZyWn6PXqyyhbBO4eghpWkUe//aPchA+dpbg44XMG88UmE4WkN1Ghais+Tng6IxT/HzV7xf3CBOqu81HvHN52OoWCjfNP2Y5+cPXdjXiAmRAq7oVR/0hQMKHMn9NHsKaPhlGRXqmUgIZ9t4etlzMs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lb+0b8s7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so11314675e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740680278; x=1741285078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lj8uuu7iWZsAclpHD2qzdXk8KQojj805ab43KuXmCc=;
        b=Lb+0b8s7jM+kmrlh/3sASiSqBHAqeNDwQrU4jplGygXmulwhyHy9/+e2CBD3F/oPao
         bO2vmK4R2ZmsVbZZNQJ/QJkI0wwa4F37no30M5K1PriDR8XOaiyOY9O9wOlrKJkfBLPz
         CERU6EsnMNs5VLFY7fF/a2OxLsGORejSJROz9MXjcZedQbZZDjWL3mlJH20GdHx2HGDS
         ObwFjN3Qvc/OZx2ZV2MTTNLBbewTxd4gcxAAZeRuO943k7931v8diONIOeJerB06nvhc
         xyI/S63zQeLUKxyqcuGmOp45DAgkR0kQZk4AphfgIFFKzga2vu87nnImtP4Axf4OCT42
         1m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680278; x=1741285078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lj8uuu7iWZsAclpHD2qzdXk8KQojj805ab43KuXmCc=;
        b=ZIV6BDp8jaLt3tNDabwARVLVnX1j3tUah+bHQMokJhhbx95PQ2HzMcfQmDiEP4MuoR
         sT8Ckwu76JiqQjJgVqgLEkdpbYcHPGocDjF8uIEh2kgTGzm9Ez2z6HrIrMaDHvvZrbab
         P34oZlzurEnKAPShmWrSGzqrz7q5oQeTKWQQz13v0ckejt3Qr9B4fyYF16WgBE6C33QG
         HUmtq5u+WURBy1ojdCPYB/xCNar8UkrKh6azEiFStFQDihPm3yOND+ATuPjS/QpAsAhR
         MkLefbQ7vgVxFRNJtZpgENVg5HUoLhReTLHwoL2Um6ZBr5EpieCVJlYeLUXoQuDgiMQw
         bM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtzRm1iXoxynsLHK3a10WF2io5r2MP6aqz4Tq4GmdfPdQFZ6lL9GyOPcl4+2ckor9qoYEmQG6sgFWGP88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZ96wtbY9PflqqiZpls5Fjj3p4A5VE5yU35MOtvqixCtnpoqM
	NRmAO7vkJE3AkoD9fgbH9YUjLffiqJHNrZblcSFQpi6K3TEP6JmmyhU5Qyw2bNV12xKz8XYWOQu
	vlIi/2B0S5ZBOfHSRo3RgB+33sQ==
X-Google-Smtp-Source: AGHT+IF2Njxm5dDDIzoh690S6dlDK7FR8OBLvtmE8g2ukm7Bwq0tFN/UVviqT95gpNUzFNzheKYgVxT063PkICiN5Uw=
X-Received: from wmqd1.prod.google.com ([2002:a05:600c:34c1:b0:439:65f0:b039])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fd3:b0:439:a255:b2ed with SMTP id 5b1f17b1804b1-43ba66e5f09mr2558785e9.9.1740680278652;
 Thu, 27 Feb 2025 10:17:58 -0800 (PST)
Date: Thu, 27 Feb 2025 18:17:47 +0000
In-Reply-To: <20250227181750.3606372-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227181750.3606372-1-sebastianene@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227181750.3606372-3-sebastianene@google.com>
Subject: [PATCH v2 2/4] KVM: arm64: Move the ffa_to_linux definition to the
 ffa header
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Keep the ffa_to_linux error map in the header and move it away
from the arm ffa driver to make it accessible for other components.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/firmware/arm_ffa/driver.c | 24 ------------------------
 include/linux/arm_ffa.h           | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2c2ec3c35f15..b02b80f3dfe8 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -61,30 +61,6 @@
 
 static ffa_fn *invoke_ffa_fn;
 
-static const int ffa_linux_errmap[] = {
-	/* better than switch case as long as return value is continuous */
-	0,		/* FFA_RET_SUCCESS */
-	-EOPNOTSUPP,	/* FFA_RET_NOT_SUPPORTED */
-	-EINVAL,	/* FFA_RET_INVALID_PARAMETERS */
-	-ENOMEM,	/* FFA_RET_NO_MEMORY */
-	-EBUSY,		/* FFA_RET_BUSY */
-	-EINTR,		/* FFA_RET_INTERRUPTED */
-	-EACCES,	/* FFA_RET_DENIED */
-	-EAGAIN,	/* FFA_RET_RETRY */
-	-ECANCELED,	/* FFA_RET_ABORTED */
-	-ENODATA,	/* FFA_RET_NO_DATA */
-	-EAGAIN,	/* FFA_RET_NOT_READY */
-};
-
-static inline int ffa_to_linux_errno(int errno)
-{
-	int err_idx = -errno;
-
-	if (err_idx >= 0 && err_idx < ARRAY_SIZE(ffa_linux_errmap))
-		return ffa_linux_errmap[err_idx];
-	return -EINVAL;
-}
-
 struct ffa_pcpu_irq {
 	struct ffa_drv_info *info;
 };
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 74169dd0f659..850577edadbc 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -475,4 +475,28 @@ struct ffa_ops {
 	const struct ffa_notifier_ops *notifier_ops;
 };
 
+static const int ffa_linux_errmap[] = {
+	/* better than switch case as long as return value is continuous */
+	0,		/* FFA_RET_SUCCESS */
+	-EOPNOTSUPP,	/* FFA_RET_NOT_SUPPORTED */
+	-EINVAL,	/* FFA_RET_INVALID_PARAMETERS */
+	-ENOMEM,	/* FFA_RET_NO_MEMORY */
+	-EBUSY,		/* FFA_RET_BUSY */
+	-EINTR,		/* FFA_RET_INTERRUPTED */
+	-EACCES,	/* FFA_RET_DENIED */
+	-EAGAIN,	/* FFA_RET_RETRY */
+	-ECANCELED,	/* FFA_RET_ABORTED */
+	-ENODATA,	/* FFA_RET_NO_DATA */
+	-EAGAIN,	/* FFA_RET_NOT_READY */
+};
+
+static inline int ffa_to_linux_errno(int errno)
+{
+	int err_idx = -errno;
+
+	if (err_idx >= 0 && err_idx < ARRAY_SIZE(ffa_linux_errmap))
+		return ffa_linux_errmap[err_idx];
+	return -EINVAL;
+}
+
 #endif /* _LINUX_ARM_FFA_H */
-- 
2.48.1.711.g2feabab25a-goog


