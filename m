Return-Path: <linux-kernel+bounces-571920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A90A6C453
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5091B6084C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DF230BE3;
	Fri, 21 Mar 2025 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C4rvaEyG"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F01EE019
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589410; cv=none; b=SxwAQUT8G86MUa/hwFB8CBMwk2JJ4UsS/ZKNazNZ5Q7bHFRutj0KDH0kzSCvS1crnjpzy5bYWwe7JFBgIaHFgRA3E0fGOCAn1CdZeOgtfVyWz1MqkPDteUuKcNN1Q84kUw6kwePimkYltTrHrFJUKUhq5GL7qZCIca4wvhbdKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589410; c=relaxed/simple;
	bh=FqJVruJuk3jZA1jNU+P7yclz+mvpP/olvfNDLk1TT8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC4tLudBMbxj0ND4h6zYUKjhyg8xLKME43dENVjq1NVVD/oFBT2C7AoHqUGLhYNoaWq8FacnYwvPVTAe6DPiXCYTAb82LvHKAAu/UgwNgXX+eqhcsYkIwSZ/hjM1pUZmLyvcbgXvCkA5DwflGF1yNGs7Id5Yb/KViS59RRL6DJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C4rvaEyG; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-223f7b10cbbso6037285ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589409; x=1743194209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=C4rvaEyGo2I6IPHggrz+DW7oeOQ6Uuy6MIdTPIgUplehT6R9Y9lGwB00w3xE9vjdcA
         aPXylfvq7j8odweRkP0Qjazj9oc5eERChZTRfzQuG4J4xhFQwyLPuv2TG9MZnWQvW1Cj
         LOL0PJk0d5uvbA2lFz8RY6IVWabczYO+Kk+8jAJX0maORoDKdXJWB37mDaGXD2lA+TbZ
         RXKAM2efhwjwSeWyZ9/yqEhIcuOkTOfhB0emwy9UWGrvj66tLehux6CfqiYsZMTNOxX0
         +XOhf6bV25Mx+1b0bWuOR2nKyHtHKnQDLi5VqiqWejugpToyh0EymIaGmamJzF7BXXtG
         mM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589409; x=1743194209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfs9TktRKcTUn1O+77Hfraf6wVpzVMFzjRcu/Aef4Bk=;
        b=B8Bo6/x615ApkvizeGoils6DSvVv8rP+azVcsV8PHNtfDQgh5QaVPSrHIeomKV4G6Y
         jOR+JtrWCFnxJfMPFgSBnzGDwjHu4d5gDghj0QVkBPPgpncQZmUnYL56vfd58RTH9bgn
         9n+To7Kcgt9T+KqtGkyRQOqXY49xST5FINVPzyVS+hYI0je2RHugPa9KJA35GZB8Be0A
         LZ2mBiIUZBrKI3+OZd/cDy2WL7KYOoVr6HUR0ejBe3ZaZbVBLJlMYtYsdx4dVvl5n/6C
         9V9TmcCv4AvKRekNdXjDuFsQjeX7FPCqVMLnQHu/PyDp4h+kNE/Vq2KXjkTdMyXWVfCw
         abDA==
X-Forwarded-Encrypted: i=1; AJvYcCXUggaDlCkeIOur7+Nz0tja9rMO72GHRFyTCxShzVcONXJc/8N9UKXIyuITajPdK9PTVcqdyb2QZ5FxI7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbKjSwOdidjYo4S/wTMqAsMfWh0AKvTfqYvoW8SOw34SDpRBx
	QJ6W4nJJU4CXtLUT8v04HxOC52j0FjG7lS0MAVvf85JixDsjuRZfIBDi/vj58F/GGOBlNxWQif6
	D3K37s8ch2UZOhGhMC5P01x902S58c4jWJrrtSxiHo0pRvg6e
X-Gm-Gg: ASbGncsDrD9EpIik7qqdO3rrv0fxsGMUNYHDpUB158W6ZCjgeYnHflmMQqKFt2dMym3
	MT1H4f7FoAbPmeUp7GKesscJteOnEtyYW2neAYpsg5rxJbSeEioIwCDXFpcPklrRjEC+3TNUzvn
	FLDJxTVgR0dgOmNVsVHp/NftLf3WD42IkEhXoOc+Dirv3F744Nf7OQLUsR/rteMa8LOSdBhC7sk
	kHTlNmCrAG7kw7auVIZRpRol+GYQS+PkX60jwb7DGlPfuipDoHopQVFwmabK5m1pSjiEKbD1oY6
	71/xMK+n3HoJJ4HHadIHXkIQKvqKF2U1Kg==
X-Google-Smtp-Source: AGHT+IEBwTUZcvBZMFhkgIDcLlplm3myBfiqu+iU5CfAiTL0eJfnM+kmb1uKhIfNIQG1e0czBKqqLEKuonuM
X-Received: by 2002:a17:903:191:b0:224:88c:9255 with SMTP id d9443c01a7336-227912f607cmr12626355ad.3.1742589408570;
        Fri, 21 Mar 2025 13:36:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-227811cee54sm966935ad.84.2025.03.21.13.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0BE7F3400FE;
	Fri, 21 Mar 2025 14:36:48 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 00E0CE4195A; Fri, 21 Mar 2025 14:36:17 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/3] nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
Date: Fri, 21 Mar 2025 14:36:02 -0600
Message-ID: <20250321203604.3911446-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321203604.3911446-1-csander@purestorage.com>
References: <20250321203604.3911446-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vectorized io_uring NVMe passthru opcodes don't yet support fixed
buffers. But since userspace can trigger this condition based on the
io_uring SQE parameters, it shouldn't cause a kernel warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 23fd22e55b76 ("nvme: wire up fixed buffer support for nvme passthrough")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 41907b4e1869..6c27d72e8cee 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -139,11 +139,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+		if (flags & NVME_IOCTL_VEC) {
 			ret = -EINVAL;
 			goto out;
 		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
-- 
2.45.2


