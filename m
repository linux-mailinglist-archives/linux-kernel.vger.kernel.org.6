Return-Path: <linux-kernel+bounces-539116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08FEA4A114
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426337A4689
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC6F27182B;
	Fri, 28 Feb 2025 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxJuChTO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630C1F09AE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765894; cv=none; b=n+UFI81mnwV5saIMZ6KwQBeonM/aKdta+49H5C3KmNNdRWpKr3AR/iYyxrkSI8isqs5fjmmWQVDFuc70rpaqXfVzcPBgg2yXTECreDH4CBvONP7yeN4el1fUoMNlleaMvvv1SnE28a/Xt4O0BzPqZCnzg5NPOS2OP4A0YE06uxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765894; c=relaxed/simple;
	bh=p5YNSl+tACPhKTbX5xBy7X2QQnkmsEDw2DUatYNaNT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVadKGmEBzAT4updzn/8M0RCId5tuk3eMv7p26iqQ7RJOWVZ/lXY4KwrOM1ToQlPPH1mA+dWIV2lMiQ+LSQdzUQVvT4/lx5P4zTCI/Bsjiv6osFkozCUEIQH/AVXu+ElQzcmK7T3DaZ3It+2ps2Z/djXVt1d+66OPBrX9eP+QJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxJuChTO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740765892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGAryNfhIHltDXBhImLJg9FkqIv+XeRGH9VzW685p/w=;
	b=HxJuChTOrgWrGB99PcTwZ0DsB1jjAiz129YOJ/eAy5iToHB/F+dCxG1rnLEpMP6xjxnlYL
	e1+gIeKGzOBxIsDuj/AP43aPzAy9qOkVUF7C6ubtLUC3e4ob0Ky7zPNQDNIsDDwWyt9JiC
	BA3ASyjdCyCwuNLMlR+d1Y/REp0Rjkk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-62DDB3_fObiAsG_nmvzUfw-1; Fri, 28 Feb 2025 13:04:50 -0500
X-MC-Unique: 62DDB3_fObiAsG_nmvzUfw-1
X-Mimecast-MFC-AGG-ID: 62DDB3_fObiAsG_nmvzUfw_1740765890
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b9242877so579899785a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765890; x=1741370690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGAryNfhIHltDXBhImLJg9FkqIv+XeRGH9VzW685p/w=;
        b=E9lLilVUYeDcR7BYuzbcxIPr9GQRLsAKKGUi1fG4KQsJDKaQpBkqPgX8jHusiDmbhe
         bbXvVeL8YMpQVvhytrrc9ox5Han8hbj4F9IIxQetlZi5P/fMiRoK0L67mN8jMQRpWQKb
         7RAO01PGh7SZCmK6G2XhHDzU5CEvWVmSm5nYNG72UK4wVhHOExDKTtGYEo9g4aS3fiGZ
         KNoJ7/h/o2tpcW1pybmDC3xF0dl9bd9glIdjT1+st+n6sCpKxQcSxY6R0GzSwneA5PWc
         siD89ngtRQrXlXEPdI+f4wT1nHge0yxKa042901kr800xbYfG151ZcQAUGtADJxO7JFw
         Dtxw==
X-Gm-Message-State: AOJu0YzNZbN06gm8MJAbKC2Vv+40jlfJ0E4U9Lbu2dDtNQD59NshIb80
	6VtZraNnCzZqlFN1aqnMAiHRe/AnWdnIX7dS0bWXhEy0nWbuZtuWt4cr7GCiGs8txGGiaAD24S0
	J+6T6nqIvJC7IgOWUy9GNPCnjeP6OMxaSLDhJ2N9zVQ7XOukn183B/GcY+fZbww==
X-Gm-Gg: ASbGncuOD6FeeOcLBop57U03d5MoyI4qU+3AacLsTf6Yhxkm96580c34exBhr1nUJs9
	UDZMJTwGOlp2hBoNGsu7HOAZWvM4BWpJbeubNHPWaot1YxAJeCEB2gw7ojikN2WBSwH20f0ADoB
	ifW/HqEcrJJxETVESv6x709FZEq+XWQTMQnOmqRqjy6e285afTEQQZjh/HpsbM5GqhYf/z9Lp20
	NXNIIhrFlgI+hzhYUxUxIwCCZPFAI2puSeKRewjwzyxyf5g24blfYMut35QFpkTvBMWm+CFNUYO
	KPvdDoVKZArnHuJgj8KlnViTBovzbmW+/SCmswhHuz/TfSPNcdajzlSRW4Z6nnU0kfffBcyR7cY
	=
X-Received: by 2002:a05:620a:f15:b0:7c0:b523:e1ad with SMTP id af79cd13be357-7c39c66d27emr632612385a.47.1740765890049;
        Fri, 28 Feb 2025 10:04:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEj/2QsRAB/VCS/BBKQ2yHSEMwWhZUBp2Kj5DgJewvlBgCUKZXnHJSnP4yCZQbD/+GMC6zkJA==
X-Received: by 2002:a05:620a:f15:b0:7c0:b523:e1ad with SMTP id af79cd13be357-7c39c66d27emr632608985a.47.1740765889755;
        Fri, 28 Feb 2025 10:04:49 -0800 (PST)
Received: from rhdev.redhat.com (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee8a08sm274654485a.6.2025.02.28.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:04:49 -0800 (PST)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v4 1/2] nvmem: core: add nvmem_cell_size()
Date: Fri, 28 Feb 2025 13:03:25 -0500
Message-ID: <20250228180326.256058-2-jberring@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250228180326.256058-1-jberring@redhat.com>
References: <20250228180326.256058-1-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function allows nvmem consumers to know the size of an nvmem cell
before calling nvmem_cell_write() or nvmem_cell_read(), which is helpful
for drivers that may need to handle devices with different cell sizes.

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/nvmem/core.c           | 18 ++++++++++++++++++
 include/linux/nvmem-consumer.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d6494dfc20a7..4d0cbd20da48 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1624,6 +1624,24 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
+/**
+ * nvmem_cell_size() - Get nvmem cell size in bytes.
+ *
+ * @cell: nvmem cell.
+ *
+ * Return: size of the nvmem cell.
+ */
+size_t nvmem_cell_size(struct nvmem_cell *cell)
+{
+	struct nvmem_cell_entry *entry = cell->entry;
+
+	if (!entry)
+		return 0;
+
+	return entry->bytes;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_size);
+
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
 	u8 *p, *b;
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26..a2020527d2d3 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -54,6 +54,7 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
 struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
+size_t nvmem_cell_size(struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
 int nvmem_cell_read_u8(struct device *dev, const char *cell_id, u8 *val);
@@ -117,6 +118,11 @@ static inline void nvmem_cell_put(struct nvmem_cell *cell)
 {
 }
 
+static inline size_t nvmem_cell_size(struct nvmem_cell *cell)
+{
+	return 0;
+}
+
 static inline void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.47.1


