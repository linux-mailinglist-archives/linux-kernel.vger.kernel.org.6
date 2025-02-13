Return-Path: <linux-kernel+bounces-513536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06BA34B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4D18882E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB71FC7DD;
	Thu, 13 Feb 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="by4eZ+uK"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB28A1FDA76
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466334; cv=none; b=UFAEWveKOUOTFydJx5udUR9jUoZ6II7lyaVuCeKUof/SkrQDRZYJ3WhPwTOuLKT1p+k2L2ymKCBjyTs9HAAJglmRwnH5ee+T+Tpf1kOwBUTjgFialyxyjiiMU1tcwVJKOJ+A9C6wYPUSTvmqLB8B/AwjSNTTdrqx6CaKIRXLyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466334; c=relaxed/simple;
	bh=2cHiBqkS/LD3shVbQD3h3daEXcL3c6Up7LUMhL+YVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJSlxTqsv1nmD6Sd1WtKRWyHBK9QV9gyRpF9TwDDjwnVV6Fd8mU2zQYqT6qJKyr1UGp35YcXOjhTr8PQYicFscI50fcmOVvpJBSkTPLgajoRZcGQ1HI/eaWwTfNcrAzjyOzQ/LYjXmJ8qclnL7GANmdIr7WaMPzqfOnDgskOb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=by4eZ+uK; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-21f8f3bd828so2474405ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739466332; x=1740071132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0guEuJNvlGkwonkHXf3ZKU0sySDKrB2+MAVSsNCun0o=;
        b=by4eZ+uKuRDeKuXIlo+plEnmebBMsAQfFINrBsTg+93QQNvLNAy61qRTLb8XjJKR3y
         sLlDwBYrY0pti8XkaNa2L4tjFJo6r3bQ0k8ftz8SYr+vr8qxm1ryU5+xoAXP1psikH9x
         Ru9j7HeBql9vFNr+LtytsZP86+YENFaFEoWB4LmEDjpmDs02IU5rJDEuOE5u6Eisi1C8
         SOngDBLftk1apC0gPLPX4D68dTwP5QVy7OkZDQJFDXlYo/wYpqwbC/vEFlzq0O7CkmPO
         eX8YIIHbRkYbHs/fxcJaRnPZkXe6ajCzV669GSi2dZCTm4eGaMBFCglguI4RzePJkm/U
         A1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466332; x=1740071132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0guEuJNvlGkwonkHXf3ZKU0sySDKrB2+MAVSsNCun0o=;
        b=BTlVLErDcy/atOLr2TsTSm7nr8Gx8AZctvsmzZGVUYSAFu3OKoBVZx2I6tgpt7Ed6T
         MEKPQs1yc4xA/KLTO5rTxnm72kIeP8lhvqdc5bZT4wLxHssJlgUlL77ksnuEWYz0fF+Z
         LRqQ30xRYuKTl+XY2BKAKNg68nhByEuFByYjDqT0xPW6EfVdOhy+7vA+rxE+RTb9faRD
         L2Sk/M4ij2/d6MC2DbsH9ug5LMGRlbfvxattfvCpCYQE7RTDx7lBFNn7ua99aH9GC+Md
         7VMv0DiEbOBd67jXL3lamo1xSxc8JpMvrehkQAnZsRokLnR81iz+7ZyXdaDShl9fx4xk
         Aa1A==
X-Forwarded-Encrypted: i=1; AJvYcCWu6DZYQHluQs5vync3DkBGkFDB12SQlMY/EIF8yr5KTx3utBNEknyq/PynC8eDtXV4p5sPplPiLTi6xgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQeaHhxAun3LrCTIRGkij7CkHIYpYmMf8O3rmdZOrbyUQc4ist
	hA4K1BKZkq61ABkXuKGZ3PZBL4lvKutsZAxG0qlwqoPDwdlzYreqCB7TP3s6c2fJVOeIFU0Pl07
	YpDXsilTnomc5y6OsjBX41SIw6TFaY1XS
X-Gm-Gg: ASbGnctJHnUllDpHXmIzMGNYLRKfshpvgkItKpj4G17cjpe4YVdXwu4dL3acet6KIKD
	DAfkTDKwcRDrTD8DHQDZmlxysWhqIzdtJA8zqUCl5AVPUeN48XavDyqiJYRF2wULopkd43HNkkB
	rgv0lo0IJFSiwkYX0rrFtmqNloa9TvT/97ZA6gwTXvJelELaXZeAH+Su9rVVrGjFQ7nRXLYhNkR
	jtPnQzs7yI4PPY1zi6JEGlnsXalR3yqEF9hjfKHkO6ByL41iUxtbrkhBVUb5sdrrsoVa+ygnaXq
	YH5bslN9jBQSoj3KLSEu1k8jBu5xoApDz//DMg==
X-Google-Smtp-Source: AGHT+IHURWcUxjpQh1hRezwaV451EcRATWFvIcuc8EXv7EdaGhXS1xW89EtTfCobKSrnGs0I1/3+UwR9EHZz
X-Received: by 2002:a17:902:ea01:b0:20c:5da8:47b8 with SMTP id d9443c01a7336-220bbf3284amr50146265ad.5.1739466332019;
        Thu, 13 Feb 2025 09:05:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-2faa5d0caa1sm63457a91.1.2025.02.13.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:05:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 633E934022D;
	Thu, 13 Feb 2025 10:05:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 57A64E416E5; Thu, 13 Feb 2025 10:05:31 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme/ioctl: add missing space in err message
Date: Thu, 13 Feb 2025 10:05:14 -0700
Message-ID: <20250213170515.4027908-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_validate_passthru_nsid() logs an err message whose format string is
split over 2 lines. There is a missing space between the two pieces,
resulting in log lines like "... does not match nsid (1)of namespace".
Add the missing space between ")" and "of". Also combine the format
string pieces onto a single line to make the err message easier to grep.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: e7d4b5493a2d ("nvme: factor out a nvme_validate_passthru_nsid helper")
---
v2: combine format string onto one line

 drivers/nvme/host/ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e8930146847a..b1b46c2713e1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -281,12 +281,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 					struct nvme_ns *ns, __u32 nsid)
 {
 	if (ns && nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u)"
-			"of namespace\n",
+			"%s: nsid (%u) in cmd does not match nsid (%u) of namespace\n",
 			current->comm, nsid, ns->head->ns_id);
 		return false;
 	}
 
 	return true;
-- 
2.45.2


