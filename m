Return-Path: <linux-kernel+bounces-423280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE49DA54C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C3C165711
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BA2195803;
	Wed, 27 Nov 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfC7LK94"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB84194C9D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701764; cv=none; b=XaxoyDih6XB1xYSwuMGVVe1k+88K4JtCI8t3Q2kI++4OVuLhIpSGfaIDOkIxRBk6PM2eiW/gdSxe7Yuq7XYh0GF1vfdjxAuwr9z8xoS+UT9wyU/iGlc3JF5b3myg2reKdnjHYqt1wteiuhKdYlyLwARGhOnoV7IUAafCE6QJeeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701764; c=relaxed/simple;
	bh=XNEC7iIHSTU5fR/qTaKpYUDlCvFBkQwpXNcdnLbp8KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxETfQHcn+hou4LVjUSzl5X5oKKQQB1vLBVMjiXGaxOsvaV39J9YClvL5sS+wWWcQfNay/Rlrhpsr4eUICwu6tAun9y56EjI4HKgCpmvzoW8fIeQsyydFERdv2pAsJzRQ0YtvSBBqJBOUmzpE4HetgdZwkdyIWmFWRoc0RPd6Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfC7LK94; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfc19065ffso8427826a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732701760; x=1733306560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBSQENuLPfogqNhh0dno3u0E0BaTL1Weh6wKo3FlqE4=;
        b=UfC7LK94bzQMHtvMxtks187MvWdhaHYHvwD4LL3M/qTHPKzcxbuQqXbtkWP2VxVuVI
         lt+OLe0r0v9vCVxFaGbClEAbsMlu9LklL34ItQ1KeJdnmK75wsSeuV9ijSUcjNX767w2
         AGnPnUEyy4PYRu9ZlrsTNTbx9IgBTMmRqKAbbPiwZH+qFF0xgW262ximGwLexenKcG/k
         137Q+5HeknPFYLg3HwRknwb2fsJh3pfuYODku+xGebRs6lTAm7OsNkuMs+hQQY5sbYrs
         M6GkEzRe6l4SrXwRlvZdHFhRFbhxtdb2Y0cFacHNuCayqx86u0Dp+eAZ/2jSvGFhKzU3
         yvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732701760; x=1733306560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBSQENuLPfogqNhh0dno3u0E0BaTL1Weh6wKo3FlqE4=;
        b=qIZjiYk4Aa8zNGfAYPJVa/1PY8CkmkdK2FdBzybkoSmtT2Akb0wkIx1tGax6SkzeMG
         lZJzXmQvLJ7B4Cl3r+kvTx6ZPbIbjGhJajs80yPkMCZpzEKyRN0YzgTayItJi8UF+16U
         9bTOgBFHmGTOCpQS0DpyymxThPzWgsjmlT9kjGrwK1C00BYJw/SX/o7NzOMWs7crjdWz
         nKDoUVjPukkP6hUxr4F86tC4YkpVwImzj8zi6KQR+3OUSwKaeriQOE6ji7l5sZKOuRRp
         zIqW/zVuxemsTjMY4mT5bcpjtuWvEYMT+v+R4BWZkbjjXCCnJjVLGpfB0+nFyBD3t+dV
         ckdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc6LDkHvBhPGVayqnaBQz6ejLDJXTLQZOtiR9eNm47A4zSInrFTSmkTChD0QBSex2kjkNqYzrSLh7Fqq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTBQJGQ1lGqPA9YpKPvQ6KGzEzmHreMmML1YBS/aZ+VONQ6g+3
	NiiySEP7WgowIESrsPpRMB9IGe/OgH8SuZPnRBuczoZMAlSfaTvgmiOpfnRPtWQ=
X-Gm-Gg: ASbGncvIV2JjY1yHamCUiuMMO72fAPq2IQTmsIVROlBiOzjrxfH+uFPbcCCSPxRY4mn
	F/7G54W0g3nIhbhehz7xUKoTTx0xzbOzt+tT3f3mFydqk8NhLRxNOx5KuoZ45uiwE3xkRZ/P+ri
	OYUvycIHWrrgatjHrdcMb7uTxw3WMqkLYPg6G++azIccHFjnO/aLjFdiY2H1gzRQe1R8kF4hTiS
	Eu3q6iNWK5j0e0t/mBRlkLnzgfPdGjPZUop5FAbjGi/GgaaLg==
X-Google-Smtp-Source: AGHT+IHqOxkrSEz0HJyXpwM0CcWfCEkT50w7pUcr6dYwlxQ8Y59TC1jt2D2TiNSkkhVgmFR8omZUGA==
X-Received: by 2002:a17:907:2858:b0:aa5:29b8:15ce with SMTP id a640c23a62f3a-aa581062cc2mr147125166b.56.1732701759774;
        Wed, 27 Nov 2024 02:02:39 -0800 (PST)
Received: from pop-os.. ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm421887466b.62.2024.11.27.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:02:39 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: maz@kernel.org,
	kvmarm@lists.linux.dev,
	oliver.upton@linux.dev,
	suzuki.poulose@arm.com,
	coresight@lists.linaro.org
Cc: James Clark <james.clark@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	James Morse <james.morse@arm.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Fuad Tabba <tabba@google.com>,
	Mark Brown <broonie@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 8/8] coresight: Pass guest TRFCR value to KVM
Date: Wed, 27 Nov 2024 10:01:25 +0000
Message-Id: <20241127100130.1162639-9-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127100130.1162639-1-james.clark@linaro.org>
References: <20241127100130.1162639-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

Currently the userspace and kernel filters for guests are never set, so
no trace will be generated for them. Add support for tracing guests by
passing the desired TRFCR value to KVM so it can be applied to the
guest.

By writing either E1TRE or E0TRE, filtering on either guest kernel or
guest userspace is also supported. And if both E1TRE and E0TRE are
cleared when exclude_guest is set, that option is supported too. This
change also brings exclude_host support which is difficult to add as a
separate commit without excess churn and resulting in no trace at all.

Testing
=======

The addresses were counted with the following:

  $ perf report -D | grep -Eo 'EL2|EL1|EL0' | sort | uniq -c

Guest kernel only:

  $ perf record -e cs_etm//Gk -a -- true
    535 EL1
      1 EL2

Guest user only (only 5 addresses because the guest runs slowly in the
model):

  $ perf record -e cs_etm//Gu -a -- true
    5 EL0

Host kernel only:

  $  perf record -e cs_etm//Hk -a -- true
   3501 EL2

Host userspace only:

  $  perf record -e cs_etm//Hu -a -- true
    408 EL0
      1 EL2

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 43 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  3 ++
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0..afe56e1b9364 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <linux/kvm_host.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -271,9 +272,23 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
 	/* If the CPU doesn't support FEAT_TRF, nothing to do */
 	if (!drvdata->trfcr)
 		return;
+
+	kvm_clear_trfcr();
 	cpu_prohibit_trace();
 }
 
+static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
+{
+	u64 trfcr = drvdata->trfcr;
+
+	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
+		trfcr &= ~TRFCR_ELx_ExTRE;
+	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
+		trfcr &= ~TRFCR_ELx_E0TRE;
+
+	return trfcr;
+}
+
 /*
  * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
  * as configured by the drvdata->config.mode for the current
@@ -286,18 +301,28 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
  */
 static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 {
-	u64 trfcr = drvdata->trfcr;
+	u64 trfcr, guest_trfcr;
 
 	/* If the CPU doesn't support FEAT_TRF, nothing to do */
-	if (!trfcr)
+	if (!drvdata->trfcr)
 		return;
 
-	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
-		trfcr &= ~TRFCR_ELx_ExTRE;
-	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
-		trfcr &= ~TRFCR_ELx_E0TRE;
+	if (drvdata->config.mode & ETM_MODE_EXCL_HOST)
+		trfcr = drvdata->trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
+	else
+		trfcr = etm4x_get_kern_user_filter(drvdata);
 
 	write_trfcr(trfcr);
+
+	/* Set filters for guests and pass to KVM */
+	if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
+		guest_trfcr = drvdata->trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
+	else
+		guest_trfcr = etm4x_get_kern_user_filter(drvdata);
+
+	/* TRFCR_EL1 doesn't have CX so mask it out. */
+	guest_trfcr &= ~TRFCR_EL2_CX;
+	kvm_set_trfcr(guest_trfcr);
 }
 
 #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
@@ -655,6 +680,12 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	if (attr->exclude_user)
 		config->mode = ETM_MODE_EXCL_USER;
 
+	if (attr->exclude_host)
+		config->mode |= ETM_MODE_EXCL_HOST;
+
+	if (attr->exclude_guest)
+		config->mode |= ETM_MODE_EXCL_GUEST;
+
 	/* Always start from the default config */
 	etm4_set_default_config(config);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9e9165f62e81..1119762b5cec 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -817,7 +817,7 @@ enum etm_impdef_type {
  * @s_ex_level: Secure ELs where tracing is supported.
  */
 struct etmv4_config {
-	u32				mode;
+	u64				mode;
 	u32				pe_sel;
 	u32				cfg;
 	u32				eventctrl0;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 05f891ca6b5c..76403530f33e 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -42,6 +42,9 @@ extern const struct device_type coresight_dev_type[];
 
 #define ETM_MODE_EXCL_KERN	BIT(30)
 #define ETM_MODE_EXCL_USER	BIT(31)
+#define ETM_MODE_EXCL_HOST	BIT(32)
+#define ETM_MODE_EXCL_GUEST	BIT(33)
+
 struct cs_pair_attribute {
 	struct device_attribute attr;
 	u32 lo_off;
-- 
2.34.1


