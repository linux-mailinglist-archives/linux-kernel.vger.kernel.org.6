Return-Path: <linux-kernel+bounces-524939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21123A3E8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F19E3BFEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7346A265633;
	Thu, 20 Feb 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FTh6tavi"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D41DED6F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095567; cv=none; b=ZjsD0SUkXRyyfccUZJHdrKkMNl7Z+KdVbt/9e65bSIIgYGh6LrIh49F3fUmvDETx/myop8mRPptJcwz0FmjgWK3qtnZV6xOWkUZEEPp4pSaXMV8VH58hi9xsQmwcrNMwmmrvN0wypoUkrI9g3/gYf7z8Jc28Ko4OBhzYll/krKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095567; c=relaxed/simple;
	bh=j4EnZGi2bMw5ig9ID3NQOLCzja5xfLZqwZzUYf0AlzA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OR+OxK6QDyM95H4RbF5umr/6f7rMAW59yuOBDSnEQy8QDF3SlTeFPuLv8/POHEwPERyAYmSHrK+99JGPvTAZL4BYlpBmA+Bip4Ua7l6kyPB5gqAjLg42bS2jCSh1a4fnKJfO3dFA872dAxiqtQzfaamSiaFrY55OFLvxN69xxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FTh6tavi; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-220e83d65e5so29631965ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740095565; x=1740700365; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb82QdOEL9q3mJpzUxuc0KVFE2hzgugePghKxy0L8JA=;
        b=FTh6tavit4vL6s3entSLbj+NcZTcSpdIM4ytSJBt4GY9vzkhLqRzdjj1tUOgSoCDdL
         ysENkr5mKmIvAgkXDWRP2msKcT4xkUsAIs+vwosRkgUEcueyckS7RXGr8KapW7/Kn2Hq
         4eFfkO4zljvA15adgvjEfkN3rz9TY6K7y6pbMOZ2capRfsLJga2i/LsdmYN9uKRhkrdD
         /fweYNuRGoD5j6sT2QxNF5haZJAU0XKbcv12SSf5CX9uCAtETf0fcUckl6W5hGDtpEox
         hcvPTYqqb1R1jPhLT9tdVJPhB5vkc8l0pihdAyI1ExQIg/ZTfuRItIHDIj128Qf78M1u
         m/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095565; x=1740700365;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qb82QdOEL9q3mJpzUxuc0KVFE2hzgugePghKxy0L8JA=;
        b=AkL3xJcHc4G1PE6CmfW+059gbzah+CtbYKtzw+TfzauCKLuWlbmJ2hn5GZYBLmy+I5
         j2nYDZMbVYVlYr4Ndl/wsGpW50N11k/yjIWkmfb0gH1zlOAPOEKL5CgRdBf6zC6wz0Yh
         z9a9rcW8Tx5+xS+6O+v9pe4WY2SoE+nHH+YluQ0I6EbturlE73HJxkND4KbvhmS8JkjU
         48Rbycu0Y6VN726cykiKkLvrSqfpzSP4vcQdTdZwqQgP18QvtBjgNWI9L2qTN63VBJir
         yFTJI/I8iL3LVdmAnji5IxSXn1H7fpDT58A5gG7mHsmr5cg0Q/vtRRAl2JGeG7tSwX5e
         hZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUin1ACrbt77lUaRXNlbNK8XQfYQ4S02WE4jtOHmKD/6m4AEAoSzI2H6oCQmhoD1vdd0KAC2Vz1hFlLSNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOWBXv3KS5GFU0J3we24+JbY+yPBjZup95hiuftkcU6h64fRF
	EQN3i3p3WPpSEVc9U2JKPw0cq6LBIsaVU9xKPgWZZmuRYNlp2i/lUc6nRrm4Vtg=
X-Gm-Gg: ASbGncs4jC6LOo+nx+igKxqYCBm+KiLnUvOGmuLrbnIgqoCbtFjepy+8IcSwlupSMuY
	qOPz+ocGTUZnULmWh/B2RYhmXMbVFsb6sKNnIW8bVprW0KYuvjYRKFZLDPbBBUa8H3Sf646VlX9
	qzHTgwNpJqoAZ23Z7BQf5I6meSuxjVqQCYtlvdWFmFKO4VuItebISlKKG1yTkn9gHnHMdJzFdm9
	5XNIq3BaoBEgijBCiICQe8+ERjHvBIdABzvE2rAAKS05P3ht9kNQ9rI+An9VWbCrOYIOBqVdQnu
	xYaiCaNRv5qs+xciuXXXXsw7teDw25nSDdMkCg==
X-Google-Smtp-Source: AGHT+IHPfERffkN1yiWBiHEUUXrcX2jWn6zdn8HouuINYaCsWF9tdVDrEmJti5NpNdDaRnhRRE2+Tg==
X-Received: by 2002:a05:6a00:3e1a:b0:730:9768:ccdf with SMTP id d2e1a72fcca58-73426ced023mr1243720b3a.14.1740095564969;
        Thu, 20 Feb 2025 15:52:44 -0800 (PST)
Received: from dev-xizhang2.dev.purestorage.com ([2620:125:9007:640:ffff::c49c])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73249fe96b4sm13610720b3a.75.2025.02.20.15.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 15:52:44 -0800 (PST)
From: Xinyu Zhang <xizhang@purestorage.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Xinyu Zhang <xizhang@purestorage.com>
Subject: [PATCH] nvme: map uring_cmd data even if address is 0
Date: Thu, 20 Feb 2025 16:51:01 -0700
Message-Id: <20250220235101.119852-1-xizhang@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When using kernel registered bvec fixed buffers, the "address" is
actually the offset into the bvec rather than userspace address.
Therefore it can be 0.
We can skip checking whether the address is NULL before mapping
uring_cmd data. Bad userspace address will be handled properly later when
the user buffer is imported.
With this patch, we will be able to use the kernel registered bvec fixed
buffers in io_uring NVMe passthru with ublk zero-copy support in
https://lore.kernel.org/io-uring/20250218224229.837848-1-kbusch@meta.com/T/#u.

Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 60383da86feda..724ab542b4c33 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -500,7 +500,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
-	if (d.addr && d.data_len) {
+	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, 0, ioucmd, vec);
-- 
2.17.1


