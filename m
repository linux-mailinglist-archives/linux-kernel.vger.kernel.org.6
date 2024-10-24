Return-Path: <linux-kernel+bounces-380238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D679AEAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F711F2355A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842111F6673;
	Thu, 24 Oct 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7+Ei2XS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E541EF08D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784484; cv=none; b=EGEqc1bIpfY3b66AoYOKRC9NddWZ3YD+TH6KVj3irEZhoe339dvaAW00S5mw3W/XVHmAQuJgO3vbSaWp2MzZxzmueec80G32xOjtA8Ki8w2ibYtnAcFn/kh3tStwxxOkTE8g4yUASWHcppFn79eyQHkn5Q6C1mCH3sfSjG4T7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784484; c=relaxed/simple;
	bh=GgG441+qTfUoiLQft6HWxhGrJtbL5tisM3DqhIipvoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTmxWb3q5VQQwmxRQvtAQvbLQkNkfABxcac4pgsAnHblFBCioUAP7K4EAe2f3DOBAuh2VX+j2VrNsLtObX6XvKtlqOjA8vdnt5rNuGr73nLrr8z6JpKhI0oIxNtkOUmDw28OCXdrPFYq2aN1hiyG0tx5UsO8au9C3JyPt6zsVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7+Ei2XS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHqXDFVh3ZcT45g2v2hygGrMf5e6MoOGi8iAV6IjSpw=;
	b=D7+Ei2XSJz9zALSbWIb1G3yLapACBG/f3Ca3Ku+rumSsHPevlH8HTr10RUQVOFiGJiz/z6
	1WtuuVdWrKMvTUhSXi+yU7LJ91p3k9v5NS6WLcVLeiCAz2CF1SCcIvJ6fuhFetrynZJHXS
	Kr1KjjgbpH4cS9tWQ8jSsCE+9sYnDpE=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-nNPqXJl_PBGGA5wKjNP2xg-1; Thu, 24 Oct 2024 11:41:20 -0400
X-MC-Unique: nNPqXJl_PBGGA5wKjNP2xg-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50d55f2eb25so376829e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784479; x=1730389279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHqXDFVh3ZcT45g2v2hygGrMf5e6MoOGi8iAV6IjSpw=;
        b=Ne9CGLE1QOg3I+0mMRyT8BKHhAKThIhJdytXFjRk630AU56I1y6VXoAhT2fLTM/21A
         84YotqIP7D6NjJ6jAjKaW/s4ouwC2xso8sd1AcgbMmrHcDAuD2/GCFTmZsqpTx2ClWBv
         N5NXUBkkbJYEJHpcQTPnHWWagZx1PUQ9OlIUkjVdtgpu9yhY0GHkHx3SlAQaV4aPOK/4
         nAo6i0HhprjMvXQzQPaJaU65ylQY7RQ2SE2BRlf1HR79onDsX1f1nY0RaPGnneJLVEaW
         oiDapOENw1pkDpFdjr9i86XGPj+n2/S4XnLfC7n1hgi7JCR6pLH2h1j8NGJV3jAS8XGd
         cAHQ==
X-Gm-Message-State: AOJu0Yweyu3D14Zzsn5kr2jYwaTU8dxMv4d9uSLjdv9nIizNPXkkZ+iz
	nEJM83QyIGiS42bQyITsLGYQwuVNAaIxTtMMLJogXWHqtyJ4QCl46YABH/e2Z/cThY97O9+mizX
	lsPR8Kb1H/yrPKLJ8x+ucIWNJJdIWyzLhzhfHVr59Y2ySwV8hqhEFvHbXVWjLvw==
X-Received: by 2002:a05:6122:1e0c:b0:50a:b604:2bb2 with SMTP id 71dfb90a1353d-50fd0345907mr7134892e0c.11.1729784479251;
        Thu, 24 Oct 2024 08:41:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVpNgn9lCj+d4tr98+ZKWvrzU2usfV0QUhO5lj1lkujg/Q0JlT//8v1BtX3dA7qH51GMsBGQ==
X-Received: by 2002:a05:6122:1e0c:b0:50a:b604:2bb2 with SMTP id 71dfb90a1353d-50fd0345907mr7134868e0c.11.1729784478895;
        Thu, 24 Oct 2024 08:41:18 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f5fad0sm1364301e0c.40.2024.10.24.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:41:18 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v2 2/3] nvmem: core: add nvmem_cell_write_variable_u32()
Date: Thu, 24 Oct 2024 11:40:49 -0400
Message-ID: <20241024154050.3245228-3-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241024154050.3245228-1-jberring@redhat.com>
References: <20241024154050.3245228-1-jberring@redhat.com>
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


