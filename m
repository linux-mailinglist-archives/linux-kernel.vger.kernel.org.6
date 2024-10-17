Return-Path: <linux-kernel+bounces-370126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B792E9A2820
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21452B22EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25C1DF252;
	Thu, 17 Oct 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZJ1z1a2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAA1D95B5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181376; cv=none; b=hD0ty6myDiKXH14vFrvyvneLgukR4SCgtzqkuLXXSykvQebra8sFQMeb/AqFvoq8QxVbBU07EtyqQ1ui2JrlFNyUCgwnDGzinvSLrQMpqqNRmB8PiaJx2Kd/2dLa5jkyKT3nDWfvIx7n8AClZY8Z5s8LPcJl9vzvJSjiAP7pq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181376; c=relaxed/simple;
	bh=80JceXAUMBc0hDJiSFQQcdD4iRPY5w96kB8lL1EKvV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQzFc0eUbEZ0WMdOlDkGzj76tPht0zkWjaHnBLgYadiDLUMhH2xhmefx+4gERZeQDqXWJl5Lr1tC8igZZd7jirzq8FOdbBBGrol1jgr8tNVmd4V6GX6JUivkSssTSL/kerUaVKahjphtjSMVts+kQco2A+dulwk2D+UxuSau1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZJ1z1a2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729181374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3KIi5jhT8XRqt3YLNgG/2PEMhK9NfLcor1EN1FC7Zw=;
	b=FZJ1z1a2IuUwiGqmkn8GQoBaebgiYrF5v+uBA5vIpgArT/3GMmDI25f0JE32w//iMIvsKj
	P3UnSxeEVQB0lQlWQBzIWUsPRGD6WrtkytKDfbED8VzveMgrpWmNvHdUdqZHAxtqW1xhUL
	jL8mErqocGqobwBrD28+mXunPJ5SCXs=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-dngBSlzzNy-jykH5aVL8uw-1; Thu, 17 Oct 2024 12:09:33 -0400
X-MC-Unique: dngBSlzzNy-jykH5aVL8uw-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-846b7f5c6b6so393527241.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181372; x=1729786172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3KIi5jhT8XRqt3YLNgG/2PEMhK9NfLcor1EN1FC7Zw=;
        b=CrxPro0RsTv6/vaxYWzIxB52cojVHLTTTDgJqKQql0mYqoZ6fPnzDr+b34zI2ubkT1
         GFoBFwV9yYkBE9r3M8464jI7WIbDULQ6rqBx5pe6ezkiOJ7QYBdcw3CNB3qLegt16EVA
         loCeLq8AUEOIbE3C59i5KaeeEfMxpqsvIMkE/IKR7KLtll3Arp2Vb55gSa62jjfR5e17
         +QC89KC8gY7gDNXKTMEZoV9ykMKU424kg5PWh0n2LLSLtJacKd6B3F0hcUxuhawEU271
         c04H6hoQNFznwndY/DcKQr/fCEsL7gNOIuYcXZiZlFvdmpkEE4bHk6QHAB5wsAeblFQs
         ES2A==
X-Gm-Message-State: AOJu0Yz10IhL/68+r6UoEXCLD/aEq095+PsD/MwsxkMVMibpDsIyhT8e
	Go87p2MSv02Swh+PsmPltdAwl9ESZx6nagI6K1wXOdt6mmuF29rFsSCQekGfLEod5u/CLHPKgJ2
	ow4nRSpF1aebag1zNQG3dnRjZ3Qx/eOsJ1rlIQ/djGsANe1M4S9LOhn2wLxzSonPBNxrliOkw
X-Received: by 2002:a05:6122:c98:b0:50a:49d1:f1f with SMTP id 71dfb90a1353d-50d1f5c24dfmr20606218e0c.13.1729181372333;
        Thu, 17 Oct 2024 09:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER4G+Fz95k/I+hdY6XGfAQyo/Vj4u+zF8RuE5gYuvHARx4+3Zp7k7he+8cYNhe5n804JdQAQ==
X-Received: by 2002:a05:6122:c98:b0:50a:49d1:f1f with SMTP id 71dfb90a1353d-50d1f5c24dfmr20606187e0c.13.1729181371993;
        Thu, 17 Oct 2024 09:09:31 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d7b2a5a67sm881914e0c.42.2024.10.17.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:09:31 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH 2/3] nvmem: core: add nvmem_cell_write_variable_u32()
Date: Thu, 17 Oct 2024 12:09:03 -0400
Message-ID: <20241017160904.2803663-2-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017160904.2803663-1-jberring@redhat.com>
References: <20241017160904.2803663-1-jberring@redhat.com>
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
 include/linux/nvmem-consumer.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 74bf4d35a7a7..6f7aa2beb457 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1816,6 +1816,30 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 
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
index 34c0e58dfa26..d3ede6916ecb 100644
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
-- 
2.46.2


