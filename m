Return-Path: <linux-kernel+bounces-517370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A22A37FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383F2188AF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE0A216E1C;
	Mon, 17 Feb 2025 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2d+EPkL"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3342185BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787477; cv=none; b=aKswjHjBvgmQ/+8yHIkg3ZmyLOAoXboAF/lZDFAZWJ21BZNQbDL1CPk84Hb/O2U1G5WtlQIVTDraBoo++k9J0Z6YtTpO64IpLpZ2YdNUOReYjRXcubL9PXMY5bR/VfIxKxxReK1zYq4JYAGaRKuTA0UXlbuGrG4pLfsWggzuvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787477; c=relaxed/simple;
	bh=u5QzLaMGCFkT6QzP4xgn658e+DtF0u9SlOsNS3Z0kwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFKKikvs9OaSV+9MiJgWvc7YCHQn+z9JXa2nHeBlku48J0yGXTQ2HhhvS3nDLpbLeVYK46p2puWosjVgtQ+jIJzPukY/PgQUvEExiaUW7liC4cYpFsrnI0eCJhLgTFWCkf60s+0X79iBis8PMOK6MCbIsiaRoaBOA2oGkN/sv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2d+EPkL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso5952911a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787473; x=1740392273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2yIlVyyOPbQ4NJXMaimxxzGIHYKCdR1oZZmLPUjNQg=;
        b=j2d+EPkLrDxgowwfi3qhRIjWh3BxHHmKPmoHbK4IV0P+8SGyo9EQQIWVd48uMfhqS2
         f7Kz649HjUrXieGFnC479UXFrUu+YnIyAMN19eow9Jt/CWSOaDI5q7QgaypOuGFvakVj
         IFUM8iH1DOXSw7fnVuEb3SLDWRIwpqdC8Q6DxK8YhJlXYqUredVfSnlAbNIHAxT6zE9/
         dxoFpS41YZoz/wQvNEJ0+O3/zoHPLvDLvAkVLtp3vsj4KlnJK5Hb6yH8t7BTRSbJqtss
         srGGj2DXfBDjZU+Jq9/y3ESE3izbGb6LWueJAgyQz481kIm/3rXeciXfjbcIbLNLtVdm
         7Ygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787473; x=1740392273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2yIlVyyOPbQ4NJXMaimxxzGIHYKCdR1oZZmLPUjNQg=;
        b=L1mRpri6IXm64AI9yfMMgh+8Jj2cDfLo7cojoyXQWKZyrZ6az09KL+JNR/du92zl1N
         /6An2q/INtIg5Gqqbby83Y9C1/HiRz2DikO4l7Bgg9ToyIFr87tP/J3lrrJpNeI5AiTR
         LJaOiAYTCG82SUu//YBH726UGV/iR29M0VPsZpAJmCyxYpsbQC6w3Nu2HOi5Eno5bBoX
         jrbPIIAWncSREpV2Ux/aTJ9cDkMXgXxVZtDPqvZSBkrC6zjvlqqeeq2L0BQbKlYuJA/s
         QBXK/1ltOC+oL0tUaGjTin6aYUGUk35P/FBU6HHsegC5pJt5JdENeuhRC0/i8updxXPC
         yxKg==
X-Gm-Message-State: AOJu0YzuIE8vjAFcFpEseYxmlCziyeI90K4aFgqUyPRsYhVQeUPKX8CW
	kJDTJgPCIxgR8ZykOQX3oKVjTqFINqUG00SzFoie9lar5TFBSjz3W1Nivh086xbnjA7sbbXD+eV
	mzzc=
X-Gm-Gg: ASbGncujflI9h30WWnlpR/dqnC/2NPr1aJvMJNh8CGljNKvhqfx8bV4wfiQerDR9+Ab
	DH+EXEaeaBNkBwuV678TwZWbC1SSHAFHykCb2nEVrdvfvMWZTDxFI5LDQPRue+pq25HuFgkByFW
	u8cDCRnUxv3S7i+lJSZUJt+0sRj7Nm9rs65ZL9qjU/J8cjq5jMAwkDwFff9V7b7t2XCp3lw7WfX
	F6SUVm6h5P7rc6K6ENvoGFe5xEYvODmDL1EsI+w4h1AkCPWgXB+GsapjljQWJoq+kajBCZQ0le3
	cSYDL8ImHxl6E3ZQvEC/kO7O
X-Google-Smtp-Source: AGHT+IGpx0/whONuJWGo4HwkqVqYsCJmEUhrUJNrzL9FCk0mF7dow3SMs9U25x2XZBwWQZmzKpeEtw==
X-Received: by 2002:a05:6402:5107:b0:5dc:ea7e:8c56 with SMTP id 4fb4d7f45d1cf-5e036139d68mr21109346a12.22.1739787473355;
        Mon, 17 Feb 2025 02:17:53 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:53 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 05/10] pstore: implement core area registration
Date: Mon, 17 Feb 2025 12:17:01 +0200
Message-ID: <20250217101706.2104498-6-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement core area registration mechanism.
Implement directly mapped zone corespoding to core areas.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 fs/pstore/platform.c   | 67 ++++++++++++++++++++++++++++++++++++
 fs/pstore/zone.c       | 77 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore.h | 16 +++++++++
 3 files changed, 160 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index e20e60b88727..32448d9dd316 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -68,6 +68,7 @@ static DECLARE_WORK(pstore_work, pstore_dowork);
  * the filesystem mount/unmount routines.
  */
 static DEFINE_MUTEX(psinfo_lock);
+static DEFINE_MUTEX(ps_dmr_lock);
 struct pstore_info *psinfo;
 
 static char *backend;
@@ -99,6 +100,12 @@ MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
 
 static void *compress_workspace;
 
+static LIST_HEAD(rec_list);
+struct rec_list_t {
+	struct pstore_record rec;
+	struct list_head list;
+};
+
 /*
  * Compression is only used for dmesg output, which consists of low-entropy
  * ASCII text, and so we can assume worst-case 60%.
@@ -271,6 +278,66 @@ void pstore_record_init(struct pstore_record *record,
 	record->time = ns_to_timespec64(ktime_get_real_fast_ns());
 }
 
+int pstore_register_core_area(const char *handle, void *area, size_t size)
+{
+	struct rec_list_t *rec_element = kzalloc(sizeof (*rec_element), GFP_KERNEL);
+	struct pstore_record *record = &rec_element->rec;
+	int ret;
+
+	if (!psinfo || !psinfo->register_dmr) {
+		pr_err("No pstore available ! Bailing out.\n");
+		return -EAGAIN;
+	}
+
+	pstore_record_init(record, psinfo);
+	record->type = PSTORE_TYPE_DMAPPED;
+	record->buf = area;
+	record->size = size;
+
+	if (handle) {
+		record->priv = kmalloc(8, GFP_KERNEL);
+		strncpy(record->priv, handle, 8);
+	}
+
+	mutex_lock(&ps_dmr_lock);
+
+	ret = psinfo->register_dmr(record);
+	if (!ret)
+		list_add(&rec_element->list, &rec_list);
+
+	mutex_unlock(&ps_dmr_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pstore_register_core_area);
+
+int pstore_unregister_core_area(const char *handle, void *area, size_t size)
+{
+	struct rec_list_t *rec_element, *tmp;
+	int ret;
+
+	if (!psinfo || !psinfo->unregister_dmr)
+		return -EAGAIN;
+
+	mutex_lock(&ps_dmr_lock);
+	list_for_each_entry_safe(rec_element, tmp, &rec_list, list) {
+		struct pstore_record *record;
+
+		record = &rec_element->rec;
+
+		if (record->buf == area) {
+			ret = psinfo->unregister_dmr(record);
+			list_del(&rec_element->list);
+			mutex_unlock(&ps_dmr_lock);
+			return 0;
+		}
+	}
+
+	mutex_unlock(&ps_dmr_lock);
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(pstore_unregister_core_area);
+
 /*
  * callback from kmsg_dump. Save as much as we can (up to kmsg_bytes) from the
  * end of the buffer.
diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index affa4370208c..f9e2dc4252ea 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -35,6 +35,7 @@ struct psz_buffer {
 	uint32_t sig;
 	atomic_t datalen;
 	atomic_t start;
+	void *data_ptr;
 	uint8_t data[];
 };
 
@@ -822,6 +823,38 @@ static int notrace psz_kmsg_write(struct psz_context *cxt,
 	return 0;
 }
 
+static int notrace psz_register_dmr_record(struct pstore_zone *zone,
+			struct pstore_record *record)
+{
+	struct pstore_zone_info *info = pstore_zone_cxt.pstore_zone_info;
+	int ret;
+
+	if (!info->register_dmr)
+		return -ENOTSUPP;
+
+	zone->buffer->data_ptr = record->buf;
+	atomic_set(&zone->buffer->datalen, record->size);
+
+	ret = info->register_dmr(record->priv, record->id, record->buf,
+				 record->size);
+	if (!ret)
+		atomic_set(&zone->dirty, true);
+	return ret;
+}
+
+static int psz_unregister_dmr_zone(struct pstore_zone *zone)
+{
+	struct pstore_zone_info *info = pstore_zone_cxt.pstore_zone_info;
+	if (!info->unregister_dmr)
+		return -ENOTSUPP;
+
+	info->unregister_dmr(zone->buffer->data_ptr,
+			     atomic_read(&zone->buffer->datalen));
+
+	atomic_set(&zone->dirty, false);
+	return 0;
+}
+
 static int notrace psz_record_write(struct pstore_zone *zone,
 		struct pstore_record *record)
 {
@@ -906,6 +939,48 @@ static int notrace psz_pstore_write(struct pstore_record *record)
 	}
 }
 
+static int pstore_unregister_dmr(struct pstore_record *record)
+{
+	struct psz_context *cxt = record->psi->data;
+	int c = 0;
+
+	if (!cxt->dmszs)
+		return -ENODEV;
+
+	while (c < cxt->dmapped_max_cnt) {
+		if (!atomic_read(&cxt->dmszs[c]->dirty))
+			continue;
+
+		if (cxt->dmszs[c]->buffer->data_ptr == record->buf)
+			return psz_unregister_dmr_zone(cxt->dmszs[c]);
+		c++;
+	}
+
+	return -ENOENT;
+}
+
+static int pstore_register_dmr(struct pstore_record *record)
+{
+	struct psz_context *cxt = record->psi->data;
+	int c = 0;
+
+	if (!cxt->dmszs)
+		return -ENODEV;
+
+	while (c < cxt->dmapped_max_cnt) {
+		if (!atomic_read(&cxt->dmszs[c]->dirty))
+			break;
+		c++;
+	}
+
+	if (c == cxt->dmapped_max_cnt)
+		return -ENOSPC;
+
+	record->id = c;
+
+	return psz_register_dmr_record(cxt->dmszs[c], record);
+}
+
 static struct pstore_zone *psz_read_next_zone(struct psz_context *cxt)
 {
 	struct pstore_zone *zone = NULL;
@@ -1110,6 +1185,8 @@ static struct psz_context pstore_zone_cxt = {
 		.read = psz_pstore_read,
 		.write = psz_pstore_write,
 		.erase = psz_pstore_erase,
+		.register_dmr = pstore_register_dmr,
+		.unregister_dmr = pstore_unregister_dmr,
 	},
 };
 
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 8360d94c96b6..85f3f964b268 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -290,4 +290,20 @@ pstore_ftrace_write_timestamp(struct pstore_ftrace_record *rec, u64 val)
 }
 #endif
 
+#ifdef CONFIG_PSTORE
+int pstore_register_core_area(const char *handle, void *area, size_t size);
+int pstore_unregister_core_area(const char *handle, void *area, size_t size);
+#else
+static inline int pstore_register_core_area(const char *handle, void *area,
+					    size_t size)
+{
+	return 0;
+}
+static inline int pstore_unregister_core_area(const char *handle, void *area,
+				       size_t size)
+{
+	return 0;
+}
+#endif
+
 #endif /*_LINUX_PSTORE_H*/
-- 
2.43.0


