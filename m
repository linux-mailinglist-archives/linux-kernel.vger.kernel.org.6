Return-Path: <linux-kernel+bounces-576916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C389A715F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CD7178C13
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CF1DE3C1;
	Wed, 26 Mar 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YY4rNBwU"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B01E1DE1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989152; cv=none; b=Xh+VVdx5V+d2gHdLftwINqwXuZZbchsJsgJQKttBTzp9ZtSMOS6wX0sF3KpwLjdECjU7KU/hSTNGH20mztaYRxJg8DrmPp0L3uXOh/49zk7lNeeUC9i6KifeXpplNKdqMGFg4WotFCbBDNH6cUyfK7TlDe53S98/U3xzDYWjjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989152; c=relaxed/simple;
	bh=UgBqeTaDk5nYZ0B//mFPRrazdUKQag+EQMWMdNe4gdk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pgERWUShD23aeAJfPUkJbYbZdAKFyrBt20SgEj/iMtR5k+j88ZiaSjSQj98dHXzMoHoaoVUhz0VfTciKEpuwje9uyVrnpf4L0ICiG0yRUXt+2EoEtKQKbihgHKObQ8E93+QD/4BiUNYdL429FBM9+0KRMuP2FGVln5uH+hXMbZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YY4rNBwU; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso3442196f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742989149; x=1743593949; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8ajkpiQTqtR9VJRMGj5F4HjopRvHwcyjLs80bQ1Ix0=;
        b=YY4rNBwUGTPonl32KfSUZjIFbY/kVrgzUU87amtx9+y2hZZmQBv7pLLlg8SBBgHWoc
         2ZB9beW0h4AZMk7gZxtbViSFPNBElhhXh73DKiapVLyRf8gKY66hCV+2R4NTbbMWRQEP
         Ia4TnPdEk4iPWledF0yIf7eNqkqlpFaufE0r8NfkobeRYZTkgN0yyqPm1cYwX5UT8ik2
         Fm5y4Czd9MdDIEIFKknzUVc0xUWMqSp1zrY78cniLFWQSLX5cy/T9eikeolIIXxf/PRo
         yRRa817PtcNc3nSq10g14qJew74Tl2Wz+w5JMxydrlytFdcIZJZsG9FWAY1tpqQUqEnI
         hPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742989149; x=1743593949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8ajkpiQTqtR9VJRMGj5F4HjopRvHwcyjLs80bQ1Ix0=;
        b=e0vtc5rF6ue9Qp0hQANyB5jsxf1/seFY/jJj1ojRuE9jool/pNOk3HEQTNQUomvuIn
         HVyNxlApTlWBjPzqZwNPJ5HIvhOModl0jqU0E2BTqlzxVtc8tKBIxXpJfeua4aOHOznp
         8VZsZxOzggBDObJsPQd7Acmj55SGmPmiVLae3ogrAJXZIM8JBc04VUdAeixAA8rEIpCN
         /TdHXDd6F2tMCHIxz7zDaWJsIkW3odVqRFoKdT2ekmQVZl580OMVbwmemjcFo2cBu5An
         4TigfC1fCQuef22B7H9QULM4KCIsbSYZHGbCnZjk1jf2HlYwfMM3TLvv1oWR4eek9n+6
         9VdA==
X-Forwarded-Encrypted: i=1; AJvYcCXHffdR7xLxq69f0fq1bfaYtrsD0HhLobln3fMgOGcHfsJ1SnGBm4IDMoXcqkZRBp7cszk2NV4wq3VHg8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/1hCiHy+rhis5nSH41aaJt8JMZtOeGn3RYr90kDdH5dPILmV/
	HY64Q0mMWwCUo+WZ3jQRCg0ytg3WpGPYnWeRrBUcY+OU5BwzdX0derkrCTj6lAZsyd7aMm8o+A8
	lviMUVsSbGLJ1TFbnJCRiwLx+fA==
X-Google-Smtp-Source: AGHT+IGt24UV1F1gn3DBiJA89bM8xyxzcFBTUpe7uN0vVj4Q/IEqACUFIlVuS9cdYKWGLRea4OJ8IMRq4qWmWhdzPh4=
X-Received: from wmqe22.prod.google.com ([2002:a05:600c:4e56:b0:43d:8f:dd29])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1882:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-3997f91202dmr20021811f8f.22.1742989149185;
 Wed, 26 Mar 2025 04:39:09 -0700 (PDT)
Date: Wed, 26 Mar 2025 11:39:00 +0000
In-Reply-To: <20250326113901.3308804-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326113901.3308804-1-sebastianene@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326113901.3308804-3-sebastianene@google.com>
Subject: [PATCH v4 2/3] firmware: arm_ffa: Move the ffa_to_linux definition to
 the ffa header
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org, 
	oliver.upton@linux.dev, sebastianene@google.com, snehalreddy@google.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, vdonnefort@google.com, 
	will@kernel.org, yuzenghui@huawei.com, qperret@google.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Keep the ffa_to_linux error map in the header and move it away
from the arm ffa driver to make it accessible for other components.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 26 --------------------------
 include/linux/arm_ffa.h           | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2c2ec3c35f15..3f88509a15b7 100644
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
@@ -238,8 +214,6 @@ static int ffa_features(u32 func_feat_id, u32 input_props,
 	return 0;
 }
 
-#define PARTITION_INFO_GET_RETURN_COUNT_ONLY	BIT(0)
-
 /* buffer must be sizeof(struct ffa_partition_info) * num_partitions */
 static int
 __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 74169dd0f659..cdaa162060f4 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -223,6 +223,9 @@ extern const struct bus_type ffa_bus_type;
 /* The FF-A 1.0 partition structure lacks the uuid[4] */
 #define FFA_1_0_PARTITON_INFO_SZ	(8)
 
+/* Return the count of partitions deployed in the system */
+#define PARTITION_INFO_GET_RETURN_COUNT_ONLY	BIT(0)
+
 /* FFA transport related */
 struct ffa_partition_info {
 	u16 id;
@@ -475,4 +478,28 @@ struct ffa_ops {
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
2.49.0.395.g12beb8f557-goog


