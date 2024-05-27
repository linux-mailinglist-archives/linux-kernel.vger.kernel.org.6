Return-Path: <linux-kernel+bounces-190633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4D8D00B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4AF1C22E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8AB1607B9;
	Mon, 27 May 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aIXTO/vM"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F815FD19
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814618; cv=none; b=XtY6HRXFJH6sObktRUDsd+epuq4MrxUBkTqaQ5WeVBbdCWbcsCLRZS5SojcceFgHE6mKsquCsSlxvrB1NexlZ+snTkEPV5BhE+r5xbwGMu9D5r0QjERe5X0aFo5bKhW3bF+vG/cJJtMlTaCpgEaRhDHjubfwQHKqJyZj9wLSz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814618; c=relaxed/simple;
	bh=7usPQxKJEPAx4QJ9RLR0hEJtXFsj7tD5SpE06YCOFNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGmlhcnPMjvL5utUBYw5iwERDTtAwF0nthevn1IzVcNJDz660MSAMDf/NLJPZvRttH57NpdYCjMdTdrSZEFRU/YCHzE3VFFIJqtTqENy5jMW5tkYSS+E8bQjkzIk5HpT/EQ2DZXpkE/5BeJY5FlLty/4QUikIEkj001wUW5EL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aIXTO/vM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so81422985e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716814614; x=1717419414; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksQbuUv3wvF1KrbncOR0XgoHg0w7/4eT/UR2a/c0TAc=;
        b=aIXTO/vM/GnJrcxWyUhUI44tJbp3qJ93CXGzCGcq7gzkZkLVuYonsXUWn83FY0mPnP
         ftSAG7hJ6wOliDNDmE/DNvtArHASlqAVLBBjg5ngD4LhWIfSDYDMwXcac+deVof3s7bw
         XGqIVAtj9oIdPbT84cSHtrBOV0j1MNtB1bT4OUFdXFcj9eo0CQR7odA7RQx1NlYo32bm
         hVPJnaZ67enK5CbyUMxA8efnPKV6pSsbGZwjbeN5p95pPat0okogyM7euYs07YY7uP2y
         zLNjiDVYs6Y7GDDcLsoUaVMr/gbJZ1MUbNF+GYu8qDpplPnKk8dlSAwg5hMicJw9pEZX
         nqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814614; x=1717419414;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksQbuUv3wvF1KrbncOR0XgoHg0w7/4eT/UR2a/c0TAc=;
        b=iC/25quoWsJ1t9dpnNeWnYpkYGzGlNkIp88Nz3XoYinNc7h2r4qqYxtF4+uZLNsyx1
         hlI9x+vpl69UC1BTmhPMzEj+MbHsg0SaQhIZpDjFdplePZZZtPOgt27Vc0VZFMVGMFSW
         jMt4jk2XxnUNibBMzJqkPh7/3eEKXsYcTbdexv9UPRCmKwAsJX17tv1IkpOMJUPDI1ig
         xA3ZQLn2a1dPUB1NHkwKPO1+nphWG96T24KQrsyt+lgjyRJF9Nhvrc9J1GfRoBCoSDZn
         QQx1+ad6QaH8BUsL2HBHPR7CdFVO0lA9Q4DtEINWyFT0xyQtfJZmkkZFZDG5E+fzcvNU
         TLrg==
X-Forwarded-Encrypted: i=1; AJvYcCW2lxkeLFDvMHOz1UGFmUxkLoUey9y7hruqUZafvLOMgkI0lZJ+j6SbbJGhiQf1Y1AiejryuOHsUfZVLMrc+IIeV8voqVpd6MAjnoUq
X-Gm-Message-State: AOJu0Yy6PzAvJN5cCnphfExfieivj5xTwjRWxJgUc8Qi8mGZh3VdZN0b
	CAnHZehOl5OG6qHtPOPTR+cYtosw95/dOGzU9za5VHin73nnEEfrik6YnVeYgWE=
X-Google-Smtp-Source: AGHT+IG6j65E+SjTVgHro64hQyB1RnR2cw++Ee1P82qfXrQBW5PaNGbV71QC/6llE+OdIsaU008igg==
X-Received: by 2002:a05:600c:68d7:b0:416:605b:5868 with SMTP id 5b1f17b1804b1-42108a21415mr83248855e9.35.1716814614473;
        Mon, 27 May 2024 05:56:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:c322:131e:ff9d:ef41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f64f98sm138753635e9.24.2024.05.27.05.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 05:56:54 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 May 2024 14:55:00 +0200
Subject: [PATCH v10 10/15] firmware: qcom: scm: add support for SHM bridge
 operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-shm-bridge-v10-10-ce7afaa58d3a@linaro.org>
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
In-Reply-To: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Arnd Bergmann <arnd@arndb.de>, Elliot Berman <quic_eberman@quicinc.com>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>, 
 Deepti Jaggi <quic_djaggi@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4340;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+iNGZ5V/p/53bNnp6+mOwcvRHK3V9jzsewmxOel2Jas=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmVIMKyUP2NGnM341pjVvgYTdtROR6DcmIhzlzp
 pp1R4Tr/iyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlSDCgAKCRARpy6gFHHX
 cq1jD/wMkIWv5Lxsx5yZpCRSv1sYL8sA5UF3M3R+RdaZ4LMlFAlCuQ58GUHD/xLM98TNabA5qy3
 QTmQR4JVNYhirdptI/QgIFCNSVU/uQr26X57ddA89wjd/apXnt+eajGIL1a8Jp7lxUBHraM0lem
 6oUR441nF6/LyRUXSwV6RVbJO2pfHLYsijLy8LjO0c3YHyq+gkC+0AuI90rauDBIumjm3i78Y4d
 NdxcG3uAuy9UzVEV5/DiPBg4ogPMl3MyweHfDyG9oRHlD7kuObK6Aqn5Kc3ZoCRuZjRcMd0CAAT
 lmcWFSvaZ6IsZuXqN4vZgzhSZRtX0dl+NNa5/ZMW3V/6TfiFCnv1hZuIKWCL2TdMbYONZsjkuJd
 Mb3JtMHtQVNvKcIOMR492d5RauFEl+yN3f4I6jnL5ZyfjAptK4vp4Fea3Dv3PVQtZI7MPiU8RYs
 C0ykf9TV/41iOYk5UMseS0DUJg9xJJZElSqysxRvnBUPQcfF0HlGHb2YrO++98vDh6xe5iWqn1Z
 vXmw/3BgB6WcUC5Kx9i6JMhir+8+uRKp9+MgZmIslM1Q04yeceLKq1blifDwLzI/D5UeNRe17TW
 nolkKHIMW/bnrs+crSD2sTDLzKmut8neOOC2Vpu0FUT+Z9r06vh5/H8BxgT/WsRmgyWNsm/pGfx
 q8QBX8HzQt/fqTw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

SHM Bridge is a safety mechanism allowing to limit the amount of memory
shared between the kernel and the TrustZone to regions explicitly marked
as such.

Add low-level primitives for enabling SHM bridge support as well as
creating and destroying SHM bridges to qcom-scm.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 60 ++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.h       |  3 ++
 include/linux/firmware/qcom/qcom_scm.h |  6 ++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 04131e60b63a..94c34cde8179 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1344,6 +1344,66 @@ bool qcom_scm_lmh_dcvsh_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
 
+int qcom_scm_shm_bridge_enable(void)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_SHM_BRIDGE_ENABLE,
+		.owner = ARM_SMCCC_OWNER_SIP
+	};
+
+	struct qcom_scm_res res;
+
+	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
+					  QCOM_SCM_MP_SHM_BRIDGE_ENABLE))
+		return -EOPNOTSUPP;
+
+	return qcom_scm_call(__scm->dev, &desc, &res) ?: res.result[0];
+}
+EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
+
+int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
+			       u64 ns_vmids, u64 *handle)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_SHM_BRIDGE_CREATE,
+		.owner = ARM_SMCCC_OWNER_SIP,
+		.args[0] = pfn_and_ns_perm_flags,
+		.args[1] = ipfn_and_s_perm_flags,
+		.args[2] = size_and_flags,
+		.args[3] = ns_vmids,
+		.arginfo = QCOM_SCM_ARGS(4, QCOM_SCM_VAL, QCOM_SCM_VAL,
+					 QCOM_SCM_VAL, QCOM_SCM_VAL),
+	};
+
+	struct qcom_scm_res res;
+	int ret;
+
+	ret = qcom_scm_call(__scm->dev, &desc, &res);
+
+	if (handle && !ret)
+		*handle = res.result[1];
+
+	return ret ?: res.result[0];
+}
+EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_create);
+
+int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_SHM_BRIDGE_DELETE,
+		.owner = ARM_SMCCC_OWNER_SIP,
+		.args[0] = handle,
+		.arginfo = QCOM_SCM_ARGS(1, QCOM_SCM_VAL),
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_delete);
+
 int qcom_scm_lmh_profile_change(u32 profile_id)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index aa7d06939f8e..cb7273aa0a5e 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -116,6 +116,9 @@ struct qcom_tzmem_pool *qcom_scm_get_tzmem_pool(void);
 #define QCOM_SCM_MP_IOMMU_SET_CP_POOL_SIZE	0x05
 #define QCOM_SCM_MP_VIDEO_VAR			0x08
 #define QCOM_SCM_MP_ASSIGN			0x16
+#define QCOM_SCM_MP_SHM_BRIDGE_ENABLE		0x1c
+#define QCOM_SCM_MP_SHM_BRIDGE_DELETE		0x1d
+#define QCOM_SCM_MP_SHM_BRIDGE_CREATE		0x1e
 
 #define QCOM_SCM_SVC_OCMEM		0x0f
 #define QCOM_SCM_OCMEM_LOCK_CMD		0x01
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 2c51987fb70a..767bffe20766 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -115,6 +115,12 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 int qcom_scm_lmh_profile_change(u32 profile_id);
 bool qcom_scm_lmh_dcvsh_available(void);
 
+int qcom_scm_shm_bridge_enable(void);
+int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
+			       u64 ns_vmids, u64 *handle);
+int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle);
+
 #ifdef CONFIG_QCOM_QSEECOM
 
 int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id);

-- 
2.43.0


