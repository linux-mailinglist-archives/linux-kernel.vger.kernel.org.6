Return-Path: <linux-kernel+bounces-370125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B9E9A2803
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA6284056
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83931DED4B;
	Thu, 17 Oct 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PShb2/MB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E01DE2A6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181370; cv=none; b=mWL3FneNQVwXgMbnmzUYtjCsN1ZmSKHVDnryOFEHooGkfK76Am10IQ33/vtY25UmPwZtLBvrdjDFoOblt/hUx6yDQZY5BW/dAk44ixI0SL8bAohXT+CFsqxDNTXSIM+9yEjImFy/NXIWvtAgOx4g6aI4ctDdMJDnBlxWSkpAUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181370; c=relaxed/simple;
	bh=XWK2CQKBoDnkFJt4/MwIKSAF02nWN2yyjN0bWXOENEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtbEE/xH0gLaXu+eRjEIxwxUST0HznxiCqdW7KWyuBLCnCi+vG9ysfew8l5h7D1RK9ncunlhcC0oSWwxTij1M9Kwr1YeHqxPTrpMy17H3TbX62FEQbqLfg4l5R4lPBV9dkgdaCJu83bouAHYxY4QC7yZXz0zDcBx5kYsZFmsmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PShb2/MB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729181367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DkS5RbL+ncBye36HbvV2swXtYfvhlqwDI5lNtBAyr/g=;
	b=PShb2/MBs6/0s1wdeq/Mnwawl9BXNs4Rxll2YImQHFyVgtDrnfoTYYn13FjrNPPC4vkEOV
	A7YQv+6ORTOmNHQdMLkQ2dD6KKN+WszuyNxiQIsEfxgf37cvVhzH7GpG8Zzth7KgbxC4W9
	h6A67UcEaReDoOAkcnujiTkY0C3wM1Y=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-s0RgOp0DOqyhL-pAZW8xSQ-1; Thu, 17 Oct 2024 12:09:26 -0400
X-MC-Unique: s0RgOp0DOqyhL-pAZW8xSQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-716a7c1cd30so854072a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729181365; x=1729786165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkS5RbL+ncBye36HbvV2swXtYfvhlqwDI5lNtBAyr/g=;
        b=SIDquQ2/OOaR159CvJoWmY3anhl4PkzyDfav2pFNaebBI2fYxdkiZ34WNEwN9FaHpg
         zyqYrVPUWjYZFdAZ4wbNW6v8cM3gGWK+SJXpLTX2eq+nDaOV2gEpflaQi69dGGoDwkG0
         NCcjRie/yT7viUwDd9kmc3yziY+hE40bo15+MrVRhst6ipN3BAnYKonG0vrWmHG3T9TK
         FSetmg7AqVkZ3fnVyx+ZwccIg0FwXAAjftaupcrMDEHs/YUDrZ/jrZB/Xc+bCO6JqddY
         QkLJffrz39+y38jRQR2vErU/WwH1ScjA/bGCjlrSk+yeGhrMiffg5yTx7gJEQeOSVBNu
         rwsw==
X-Gm-Message-State: AOJu0Yzv5ZfD5T0Nm4GEY/qMHKGIM+4xtPP92NKKC6Az5OBpqjce+HdB
	I+jUe1DnasqLFgGv1H4gU4+qZWTLvS+zg/sY64wZVuBAZQnuzzNOySeei46sYgN1aISRv8Q+KvL
	4OtWC54U6WLwlueQ0BJ7QKNMiuAV+0C2ZkhHD7ZnPCTAf42kd9/ovchO5ruKmBQ==
X-Received: by 2002:a05:6358:9490:b0:1c3:75c6:599a with SMTP id e5c5f4694b2df-1c3784bf6admr683541155d.21.1729181365634;
        Thu, 17 Oct 2024 09:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfPycPZTZP+D3KLarN8Q1dwMVP6y29vgjcgbThfVJWEkcsbXkg/dm4qCNq6FkIFwCOC2vr1Q==
X-Received: by 2002:a05:6358:9490:b0:1c3:75c6:599a with SMTP id e5c5f4694b2df-1c3784bf6admr683537955d.21.1729181365317;
        Thu, 17 Oct 2024 09:09:25 -0700 (PDT)
Received: from localhost.localdomain (2603-9001-3d00-5353-0000-0000-0000-14c1.inf6.spectrum.com. [2603:9001:3d00:5353::14c1])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50d7b2a5a67sm881914e0c.42.2024.10.17.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:09:23 -0700 (PDT)
From: Jennifer Berringer <jberring@redhat.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>
Subject: [PATCH 1/3] nvmem: core: improve range check for nvmem_cell_write()
Date: Thu, 17 Oct 2024 12:09:02 -0400
Message-ID: <20241017160904.2803663-1-jberring@redhat.com>
X-Mailer: git-send-email 2.46.2
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

base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.46.2


