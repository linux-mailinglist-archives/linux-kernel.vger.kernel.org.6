Return-Path: <linux-kernel+bounces-395129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041579BB8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A9BB24432
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBF1C07E4;
	Mon,  4 Nov 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdGNPRct"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F471BDA8F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733870; cv=none; b=I6f2KE3B3GnCvlYSPTtxmgLD3uyuxwlNyNM2oafI71VPMvLz+c5saixol5n3jikegLEkbFq4V3dR1IksK3ptaPvgR5JxhSNl4UxZjMZV373SMPAvN8s27ayQwoWTvmMRFeXkhuQd/PnbeiVcXRvpIy9oo/V1FGe8PTSseuct8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733870; c=relaxed/simple;
	bh=aqqySA5j1pRC8DlotVBJm64W8spUlvU7b8sAN3b+Hw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkOZe375mbJ4LwHpv1i8TfBFscfrnGfvOdpFrKiYyj1DEjN7X8qZG2eNIsfGSSe50n5yhW7TQhV7dstX9/y5CKUkqWNbmqgiS8u/FfOqAwX+5l+84UdjC/DcdBgbWk51y/qhi/DCTPfgAupXCv/CbmmT+oDXLD3j4vPExrKdBOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdGNPRct; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730733867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPzGH1HlDZhak91zgf6eRebX7tyu+Q8KoBevHWuFYnk=;
	b=RdGNPRctrI/69BJCcHLOS0LuSQ0tUI53l6uBkN1t1og2Cl8YQlBhj44PEfLiXsU8GHg4T9
	ppaVfUosBbJDscSQ2N7gnkE1Gp5IEEhPNAP+5ILmZ3fNidoTHeyuMr9kqB8Sofioz6/yC1
	x2hAzDlF7OzxjrmFTIvYqld5i1vs9NA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-30wXvptRMiuD3xPgc_lAng-1; Mon, 04 Nov 2024 10:24:26 -0500
X-MC-Unique: 30wXvptRMiuD3xPgc_lAng-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-288610d6bf3so2976335fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733865; x=1731338665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPzGH1HlDZhak91zgf6eRebX7tyu+Q8KoBevHWuFYnk=;
        b=oH+4j/PWLpiBMh7YJr8qpmuQjP3OD4swRbLgyU1UDQM0WMqDxj+bNDDtIw4ihMohcS
         hb79Z8bMwqdF5ca06pPYrntATgJwfeFrK6E/yrUMYQDpikdtG0dPY3gEk4wNNoAU2Pmc
         UZZhSxaIqAhwiIkPYJ16tYmjKgQWkqbliGEXp3VX2CYDwzecDAcvk2ULP1f5zpvfgJQY
         KHCjPdP0rmODXbQqme+mxFNQDISYBkZQcjdIhnIPEzrg6xFdrDeCcXr9mxftoJfb+5JV
         hPgRM1qL6se23gQT/VwH+tT/oIusZQVOCJlZbGSCXepaOFdQ6e4OpRLnoewqczeFhzOG
         MEjw==
X-Gm-Message-State: AOJu0Yyj2xUN/MdWBXJeICUdk6LaJwXYm8LalenZnNT9bobqWRfh4KBt
	u08qcb+KPL1izCNHIsoC25Q55a26NT2iJy6krRDl/c7GdeFJJRAp3R1INEi3/G+aYTrbX6E0/KK
	wYlfey+LXOFshOXlrKGH7iJ5DQjvs3kM3pqSqQIfRMWzLlK3Wn7qqN6f+WbVhhg==
X-Received: by 2002:a05:6870:7b4a:b0:270:1f1e:e3ea with SMTP id 586e51a60fabf-2948452db4cmr12813056fac.28.1730733865363;
        Mon, 04 Nov 2024 07:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj98NljZQR88JEe0VSxR7EtOeVfTmAEjC0GbewfUtzio2cZ7PT81vFgnQCx8EL97YVmfE07A==
X-Received: by 2002:a05:6870:7b4a:b0:270:1f1e:e3ea with SMTP id 586e51a60fabf-2948452db4cmr12813025fac.28.1730733864961;
        Mon, 04 Nov 2024 07:24:24 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59b45sm1980847a34.6.2024.11.04.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:24:24 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v3 2/3] nvmem: core: add nvmem_cell_write_variable_u32()
Date: Mon,  4 Nov 2024 10:23:11 -0500
Message-ID: <20241104152312.3813601-3-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104152312.3813601-1-jberring@redhat.com>
References: <20241104152312.3813601-1-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function allows nvmem consumers to write values of different sizes
(1-4 bytes) to an nvmem cell without knowing the exact size, akin to a
write counterpart to nvmem_cell_read_variable_le_32(). It discards the
higher order bytes of the passed u32 value based on CPU endianness as
necessary before writing to a cell smaller than 4 bytes.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/nvmem/core.c           | 24 ++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4a5a6efe4bab..4c26a5e8c361 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1815,6 +1815,30 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
+/**
+ * nvmem_cell_write_variable_u32() - Write up to 32-bits of data as a host-endian number
+ *
+ * @cell: nvmem cell to be written.
+ * @val: Value to be written which may be truncated.
+ *
+ * Return: length of bytes written or negative on failure.
+ */
+int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val)
+{
+	struct nvmem_cell_entry *entry = cell->entry;
+	u8 *buf = (u8 *) &val;
+
+	if (!entry || entry->bytes > sizeof(u32))
+		return -EINVAL;
+
+#ifdef __BIG_ENDIAN
+	buf += sizeof(u32) - entry->bytes;
+#endif
+
+	return __nvmem_cell_entry_write(entry, buf, entry->bytes);
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_write_variable_u32);
+
 static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
 				  void *val, size_t count)
 {
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..955366a07867 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -56,6 +56,7 @@ void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
+int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val);
 int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
 int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val);
 int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val);
@@ -128,6 +129,11 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_cell_write_variable_u32(struct nvmem_cell *cell, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int nvmem_cell_read_u8(struct device *dev,
 				     const char *cell_id, u8 *val)
 {
-- 
2.46.2


