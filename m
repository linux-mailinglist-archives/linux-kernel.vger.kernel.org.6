Return-Path: <linux-kernel+bounces-380240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B19AEACB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A242284208
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC71F4724;
	Thu, 24 Oct 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuLsbS/m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C851F76A2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784489; cv=none; b=f7CL++6yb+lKLC5MyuKCckys3bHFGzplgFRM7quInfyOd1eFTWkgfek/uuZR1CVORvKCX5VYkbioNrpgqK0yFqgwckeGuVU0jL2UowLb7XbXZtih9FJtDPARABZ1VwpUKG45KpoqTroiurvWDY+DmyVjnACAufMLE/4cFJ0Rqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784489; c=relaxed/simple;
	bh=Vq0hwZOE+pwsen4g/SemCbnquuCGs6MC9R+dxIZBdGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNRPL8KV3PN/2x64clDJrDU5hLsMAXWXZNiJiIk7a/7wqXNGgo9LnyhiR4al0rZwS+IFq24Qa9683Kzlm7/3Gcbb1AAZrjxC8UB4ZX6Tpe8O1KhVdg2lHSWOUwx2SqgBRNQuxZhoLZ8QPRLPG0ApQtJRBHtnPl0KaUtLZ2/ENA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuLsbS/m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729784486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MvysEEBZ+T8FmbTZPAMUhj3c6tELoccFnLFV1SGbJM=;
	b=ZuLsbS/mJ63UAKiVUaQZvKENXslP7fYO0VDxm2muYaUEvOQSX3gZPlAFyCzjUY9LK88rAr
	NX14ngEsoutUHsku9wZsXEQ/keMSR4zV1/PpX0Bw71zkYRwWl8FoueFyiEjBCa9sq+t9xQ
	so0AvHUD7dnprFXnXkhgU2zMH4mUBwc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-f7_lm37hOzuX56j1BCG6rw-1; Thu, 24 Oct 2024 11:41:18 -0400
X-MC-Unique: f7_lm37hOzuX56j1BCG6rw-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-50d6bc46348so314436e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729784478; x=1730389278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MvysEEBZ+T8FmbTZPAMUhj3c6tELoccFnLFV1SGbJM=;
        b=ZXxho1vanCF7L/d8Hb5fVndb2pjUB0YS2+55Xqt0mWg0iz66BWMXthN3PIvnw1RXsk
         gHHVmGGHIQ7NRf8XBH0732TVFQdaSq9oI81WZatRER0CVD8af6mhoTLnDvTLU/0VhXOD
         sJPxmY+1/xf5leyicQGolsfmTuJynppWjYNrz7dY2hbR/ygrxL3GzmYQVi4j4D1WIhJ4
         RwwgE8iKJjJYhq2m9/F/xTvfxlAMtwQmdun9ZMCC2ibL4PY9Gd0oCBAY86DznkYwHvzr
         n6CIp+iseMHwxMdVVKpo4du+WmaSTDwkxQHk60vUc9qc7zxy63AcbhwzJeZ2SQQ1EbqA
         G2Fw==
X-Gm-Message-State: AOJu0Yxk3AF2oLPQmx9NA8prtUD4MrZ6S7my5HLcxFkxyXSRiRASyDvS
	ZTvDc0bhYub9BtRXTqzus6AHqJ6rfhR+632dtX/pTtkpT090Jjk3qfMMMSvNfIUD3t8wIo/6XgM
	1G1K1B5StbzB0P2ankD8MAtRaLTI0KLBeSctjwxSqmmMMs8uC91itBtwv3B0jpA==
X-Received: by 2002:a05:6122:3108:b0:50d:5f75:f7d9 with SMTP id 71dfb90a1353d-50fd0328be1mr8094119e0c.9.1729784477786;
        Thu, 24 Oct 2024 08:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd4qMACX9LG+miS3COD2mtSEKu3z3IOg5e0itCY/rx1mnKITe4J+oT57bQeldmULjWLlgWyQ==
X-Received: by 2002:a05:6122:3108:b0:50d:5f75:f7d9 with SMTP id 71dfb90a1353d-50fd0328be1mr8094092e0c.9.1729784477455;
        Thu, 24 Oct 2024 08:41:17 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19f5fad0sm1364301e0c.40.2024.10.24.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:41:17 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH v2 1/3] nvmem: core: improve range check for nvmem_cell_write()
Date: Thu, 24 Oct 2024 11:40:48 -0400
Message-ID: <20241024154050.3245228-2-jberring@redhat.com>
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

When __nvmem_cell_entry_write() is called for an nvmem cell that does
not need bit shifting, it requires that the len parameter exactly
matches the nvmem cell size. However, when the nvmem cell has a nonzero
bit_offset, it was skipping this check.

Accepting values of len larger than the cell size results in
nvmem_cell_prepare_write_buffer() trying to write past the end of a heap
buffer that it allocates. This patch adds a check to avoid that problem
and instead return -EINVAL when len is too large.

Rather than unconditionally checking that len exactly matches the nvmem
cell size, allowing len to be smaller when bit shifts are involved may
be helpful because some devices have nvmem cells that are less than 8
bits but span two bytes, although no current devices or drivers that do
this seem to rely on nvmem_cell_write(). This possibility can be handled
by nvmem_cell_prepare_write_buffer() because it allocates an
appropriately-sized heap buffer and avoids reading past the end of buf.

Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")

Signed-off-by: Jennifer Berringer <jberring@redhat.com>
---
 drivers/nvmem/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 33ffa2aa4c11..74bf4d35a7a7 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1767,8 +1767,7 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 	struct nvmem_device *nvmem = cell->nvmem;
 	int rc;
 
-	if (!nvmem || nvmem->read_only ||
-	    (cell->bit_offset == 0 && len != cell->bytes))
+	if (!nvmem || nvmem->read_only)
 		return -EINVAL;
 
 	/*
@@ -1780,9 +1779,13 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 		return -EINVAL;
 
 	if (cell->bit_offset || cell->nbits) {
+		if (len > cell->bytes)
+			return -EINVAL;
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
+	} else if (len != cell->bytes) {
+		return -EINVAL;
 	}
 
 	rc = nvmem_reg_write(nvmem, cell->offset, buf, cell->bytes);
-- 
2.46.2


