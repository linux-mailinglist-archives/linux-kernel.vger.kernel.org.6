Return-Path: <linux-kernel+bounces-573518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B54A6D891
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58623188E0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373325DCFA;
	Mon, 24 Mar 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2526C1o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D30125D558
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813234; cv=none; b=Ih1cgURimxL1tjDoP85gI41SMOkjMThsMiVIk3d1556MglCeQSagBlVtFNwULasl9AFRKIBLkKHRfyyGrGU9bHUnEMTYH5AUV12VI1OFKlCy2qQFf0DZdb2sJOakZGXTRrkOh/4f9I4SkH2IdZ/D+h8LS/JiUA3AAr0wYNiQqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813234; c=relaxed/simple;
	bh=VGky2X7R0BqRkgR/rmPA6Zn9o6b4Oc0GAhRciwiCiGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZpqRMYs7mbVkV7KCORndGGR7rzudRhxlKP8PfCoIUMK5lGmm9XpU86o4haUsiTxKqErfHmLNLtW6Gc8bZqWnVXhflcBV7Mx5bQwSdYtC1doenIXCVerGjv22W3zvbj9kp1tcrEtKOqzudiL2OUwFsDRKcdaSjhRLPXoRCx6Q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2526C1o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742813232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3ofNKkLlwWze0oEt1bz6Y5Zm/5JtrpuEhbONzfCg84=;
	b=R2526C1onyBZw/eP01+c1z0XSS+umRpmvr68KySWIS9tMYyDFiFRCVzUivPNDXF3SJws30
	5UL7LkTTCelrT4INwkBGW0bIaI/1vMGQ0J0h959RJW3ZDkqsC42QAOJlF6cViKm9mltnHh
	HePXAaDR2SUQ2lACStpS4xlkFvpZiBk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-04cHd0IDPSWXeYrOgFTC5g-1; Mon, 24 Mar 2025 06:47:08 -0400
X-MC-Unique: 04cHd0IDPSWXeYrOgFTC5g-1
X-Mimecast-MFC-AGG-ID: 04cHd0IDPSWXeYrOgFTC5g_1742813228
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39142ce2151so1631524f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813227; x=1743418027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3ofNKkLlwWze0oEt1bz6Y5Zm/5JtrpuEhbONzfCg84=;
        b=ekZBC7ASsJxGMJwcqiQrt5cGWPfsRGuXYbsKnFWwJRQUqTjwl0YxkdExAtVYvbRoWv
         51h28aTKE9mA2NKiOwc+/ldKLSHPxCXRR3b5cNOrLqBo37rinIsM2UQG6V2YDXrLPgzI
         6qIzPu/rTzvcEMEaii2wE9ojEYnJslP9NWu7/fv3KvwZl7JlMUvvZ3WwF8/mc0luUL5W
         edMDkJRqXoc4OvOAjr8jO/otAjEbkKkrteqVTC26QdV/yPTRyC1shhc8NIjkAtXyG4TM
         /59vjZ0lDbrzx6WM4ixhCPy5JOIaQ26H+Wpn0VpvH7w6lURtajz8ea+pF1sOsaTh2Zyp
         AY/g==
X-Forwarded-Encrypted: i=1; AJvYcCXzKke5sO+DWkrsjMHwV4629XhE1TPRhAVsNUbW6csEe0VeeAjQrRDDkWMiQ1euRuQcaHlKfiju5qK+cAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiH+KNvYlZkSTr7h3UB007NtDrKpmBVKIbUVeFxVFzamhG3TjK
	FpSsNB9lljjqyaJUJ7CJQY19AvvLxniqmp20BT2JOvwV4N9+HsVo/aRpOWkML5yKmnw+AFNYefA
	K2kEMa+Vi9GHNfrMW/frF8NGKao34hVvXOVKvG2+CyCKU4w2fSBZ1AW0KdLHk6Q==
X-Gm-Gg: ASbGncvW6jTlDOudQMNCb+r9x2xOzMxuT2yhW3Y2CvGdHeKp20v4KUrlY3jfa4oaTac
	oUn7Mbr1hKKS5l9YJz+hpICiN6oZRi5MEjw6dAoCFL7sEZzUwyGlmALLAMHwDhURPMT1AyYXXaD
	08fX4BGq+iHBtzRcjjS17RqwitwMJNFIQ0SzwPPyTqE+/GICk0N8s7bbKo8PPwEkbF/Mtja4fJU
	KTqfaWFuRdhHLr72vWRfZfh7ZKaR47REj9vxLLeLFtR9All9CnzTdNlRVvb0sxCKC/cCUELPKnV
	jjRi8H6zzHCFcVb/av+RvBGeUKhKCFW72KHOuF7ShB2zplW5CrfwL3tIxGY061JZCA==
X-Received: by 2002:a5d:6da1:0:b0:391:31c8:ba58 with SMTP id ffacd0b85a97d-3997f8eefe9mr9222459f8f.10.1742813227534;
        Mon, 24 Mar 2025 03:47:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeA29Zi2YUeUijn9LA3N9z6ryWBOskTdw0WtG15UsubeQ8FdCLGLqSLeIH79wulVpz8VsxXQ==
X-Received: by 2002:a5d:6da1:0:b0:391:31c8:ba58 with SMTP id ffacd0b85a97d-3997f8eefe9mr9222423f8f.10.1742813226949;
        Mon, 24 Mar 2025 03:47:06 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b4ce9sm10712355f8f.53.2025.03.24.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:47:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 2/4] svsm: add header with SVSM_VTPM_CMD helpers
Date: Mon, 24 Mar 2025 11:46:47 +0100
Message-ID: <20250324104653.138663-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324104653.138663-1-sgarzare@redhat.com>
References: <20250324104653.138663-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by
the AMD SVSM spec [1].

The vTPM protocol follows the Official TPM 2.0 Reference Implementation
(originally by Microsoft, now part of the TCG) simulator protocol.

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v4:
- used svsm_vtpm_ prefix consistently [Jarkko]
- removed __packed where not needed [Jarkko]
- expanded headers to avoid obfuscation [Jarkko]
- used `buf` instead of `inbuf`/`outbuf` [Jarkko]
- added more documentation quoting the specification
- removed TPM_* macros since we only use TPM_SEND_COMMAND in one place
  and don't want dependencies on external headers, but put the value
  directly as specified in the AMD SVSM specification
- header renamed in tpm_svsm.h so it will fall under TPM DEVICE DRIVER
  section [Borislav, Jarkko]
v3:
- renamed header and prefix to make clear it's related to the SVSM vTPM
  protocol
- renamed fill/parse functions [Tom]
- removed link to the spec because those URLs are unstable [Borislav]
---
 include/linux/tpm_svsm.h | 149 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 include/linux/tpm_svsm.h

diff --git a/include/linux/tpm_svsm.h b/include/linux/tpm_svsm.h
new file mode 100644
index 000000000000..38e341f9761a
--- /dev/null
+++ b/include/linux/tpm_svsm.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ *
+ * Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by the
+ * AMD SVSM spec [1].
+ *
+ * The vTPM protocol follows the Official TPM 2.0 Reference Implementation
+ * (originally by Microsoft, now part of the TCG) simulator protocol.
+ *
+ * [1] "Secure VM Service Module for SEV-SNP Guests"
+ *     Publication # 58019 Revision: 1.00
+ */
+#ifndef _TPM_SVSM_H_
+#define _TPM_SVSM_H_
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define SVSM_VTPM_MAX_BUFFER		4096 /* max req/resp buffer size */
+
+/**
+ * struct svsm_vtpm_request - Generic request for single word command
+ * @cmd:	The command to send
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 15: vTPM Common Request/Response Structure
+ *     Byte      Size       In/Out    Description
+ *     Offset    (Bytes)
+ *     0x000     4          In        Platform command
+ *                          Out       Platform command response size
+ */
+struct svsm_vtpm_request {
+	u32 cmd;
+};
+
+/**
+ * struct svsm_vtpm_response - Generic response
+ * @size:	The response size (zero if nothing follows)
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 15: vTPM Common Request/Response Structure
+ *     Byte      Size       In/Out    Description
+ *     Offset    (Bytes)
+ *     0x000     4          In        Platform command
+ *                          Out       Platform command response size
+ *
+ * Note: most TCG Simulator commands simply return zero here with no indication
+ * of success or failure.
+ */
+struct svsm_vtpm_response {
+	u32 size;
+};
+
+/**
+ * struct svsm_vtpm_cmd_request - Structure for a TPM_SEND_COMMAND request
+ * @cmd:	The command to send (must be TPM_SEND_COMMAND)
+ * @locality:	The locality
+ * @buf_size:	The size of the input buffer following
+ * @buf:	A buffer of size buf_size
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 16: TPM_SEND_COMMAND Request Structure
+ *     Byte      Size       Meaning
+ *     Offset    (Bytes)
+ *     0x000     4          Platform command (8)
+ *     0x004     1          Locality (must-be-0)
+ *     0x005     4          TPM Command size (in bytes)
+ *     0x009     Variable   TPM Command
+ *
+ * Note: the TCG Simulator expects @buf_size to be equal to the size of the
+ * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is returned.
+ */
+struct svsm_vtpm_cmd_request {
+	u32 cmd;
+	u8 locality;
+	u32 buf_size;
+	u8 buf[];
+} __packed;
+
+/**
+ * struct svsm_vtpm_cmd_response - Structure for a TPM_SEND_COMMAND response
+ * @buf_size:	The size of the output buffer following
+ * @buf:	A buffer of size buf_size
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 17: TPM_SEND_COMMAND Response Structure
+ *     Byte      Size       Meaning
+ *     Offset    (Bytes)
+ *     0x000     4          Response size (in bytes)
+ *     0x004     Variable   Response
+ */
+struct svsm_vtpm_cmd_response {
+	u32 buf_size;
+	u8 buf[];
+};
+
+/**
+ * svsm_vtpm_cmd_request_fill() - Fill a TPM_SEND_COMMAND request to be sent to SVSM
+ * @req: The struct svsm_vtpm_cmd_request to fill
+ * @locality: The locality
+ * @buf: The buffer from where to copy the payload of the command
+ * @len: The size of the buffer
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static inline int
+svsm_vtpm_cmd_request_fill(struct svsm_vtpm_cmd_request *req, u8 locality,
+			   const u8 *buf, size_t len)
+{
+	if (len > SVSM_VTPM_MAX_BUFFER - sizeof(*req))
+		return -EINVAL;
+
+	req->cmd = 8; /* TPM_SEND_COMMAND */
+	req->locality = locality;
+	req->buf_size = len;
+
+	memcpy(req->buf, buf, len);
+
+	return 0;
+}
+
+/**
+ * svsm_vtpm_cmd_response_parse() - Parse a TPM_SEND_COMMAND response received from SVSM
+ * @resp: The struct svsm_vtpm_cmd_response to parse
+ * @buf: The buffer where to copy the response
+ * @len: The size of the buffer
+ *
+ * Return: buffer size filled with the response on success, negative error
+ * code on failure.
+ */
+static inline int
+svsm_vtpm_cmd_response_parse(const struct svsm_vtpm_cmd_response *resp, u8 *buf,
+			     size_t len)
+{
+	if (len < resp->buf_size)
+		return -E2BIG;
+
+	if (resp->buf_size > SVSM_VTPM_MAX_BUFFER - sizeof(*resp))
+		return -EINVAL;  // Invalid response from the platform TPM
+
+	memcpy(buf, resp->buf, resp->buf_size);
+
+	return resp->buf_size;
+}
+
+#endif /* _TPM_SVSM_H_ */
-- 
2.49.0


