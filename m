Return-Path: <linux-kernel+bounces-574196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48852A6E1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4999D1887D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9E265638;
	Mon, 24 Mar 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dHhhIl5c"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C826560B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838576; cv=none; b=DQYgTbjLPbiyAp7nXoz82GNYfAH6VBVdXoiaZlQFJiMhUVpJe0u2SK15gQsn/I7wLs/s2QG4nUZ19CTfOg5L94INhMzMBdkF1YheUgMN7EsMxAU2fyQNeezhDI+Xb1KjAJTA/pXgoOtgLzASd/xX4nPUXbnEwoZJAKkOgxoJrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838576; c=relaxed/simple;
	bh=NvpKUbZByuSKW9bHafcSIFQL9GuEh4t49QLqLTJyTz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrKa0IFu7GBmtfcImDoN33AEir8T9SJk2SBx3VASe76lYbhYWyAOlxDOaMNaB9movjRJJ40Nz9hAuqnv9jI0bMigcjV+u/9IiC2AMFhI1RgnM0TR8bOk4YWdguONNk8j+ZcwJaj4EY/lG/2GqGYo6J1hmBs+Sj86nWixJgwsLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dHhhIl5c; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso5791835a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838574; x=1743443374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGbQAwYC/qXzJVLkpejFk7xs3lICNMf5WqGsg+WnFMI=;
        b=dHhhIl5cXBHxTga1seF4G/mZXGF3IFk+m024SU/0WFjdYf1FG2CxFUjqHdkPLh+fWq
         3jYbNV1UqReuWRTEMaV8lRGwsieP1CRMSsEBbrxTVDBEJNg4bKbeWL4wLuBh2FgtOCqB
         uApUZ7AqzBCsAQ3+BxIirCySLKgLpRj86r08vSICuORUn46BjmwPJmlmR3f6FES8APKf
         JtqeeLJ+cces4eujjKUx+5V0UVJq5lsYxEJh7Ov5e0t6dHA922wirvrtXC3Rhph+y/bC
         wOiOzrbk3gz40S8zQjNgzd8ZPJ+YgBlLp3Sx612peY4VYCbwrrclg3jgxQglCrdybhdE
         AG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838574; x=1743443374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGbQAwYC/qXzJVLkpejFk7xs3lICNMf5WqGsg+WnFMI=;
        b=JJPX0L3ULZdldfvEh6nwupGc/pFZVLN22AkbMqgykA3Wzzm9snmaAvvHBgLAPqYVvf
         BuqDhqjADozaLTHjVCr4Cc/BOOx0lGF3DTeF+r+6vTYIcdNnVCozVtEJAeOU89NquKsB
         0ACO9jg0hv/5/DW5QOkrVUHb8X2UvOQSK3h92i4IdCkgLs7sUKubC5lCA5haVgPb5gBj
         RsgNShGPeb2RlVYiDY9N7/8hZUzRz0imcTyWnloR/znWhPAvOXF44aDKAWkKeOOWrYPX
         fL3Pashzr6mjhcA0JDrj04QN4tTWjeqi5dkKFEEQckb7dGMpE4yTmzsWzhA7vWv0YMGS
         Jorg==
X-Forwarded-Encrypted: i=1; AJvYcCVZJDJE/PIYmENWvuNKJhGabVtpU6vEAIIGea3+TvS7gP7eGkn9b7OL6V2tvhS+uwi99qaq8UzHGuC/bf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZu8mmjH4W//qjCmVbIjPumuPtneg/NpOIQ3eqqCqxvMqfHci7
	RlnepKb6xWSQAnKxVCM2zXeITBu6sh55mgyavuqi7U7DWb8A35nLkDQVIdi5v7kH/AkSqInpVjp
	2
X-Gm-Gg: ASbGnctST77boUKiju2IbgVxU7N16jVFugskCvgBhai8pjWTXCKD0i06pPlU5le1PYl
	s5D7KT5N2gI2EtQnJBQrFu3ZKYzVilKxiLeWIE9cppdPSerEU/hu61cjlY/0V+KpShZgGNApDPR
	LksDtN1Yao2O+QqZ0CWVX1PWVHykD9pVWKu2QmBbP5ybDeDhZkPV/KwX/PkXNteTjTxs9N1H6lG
	/cehb2rV2rstilHkYX5SLKeuf4F2DRBj/79/sXiYAbWf5suWpEGCAcbzkNMG0zxfbyB5xqGYfmD
	OSeE2nnHywQkwtpw76sqgTXr3DF89PE9EopSE5QntYbVuQ3Nl5g=
X-Google-Smtp-Source: AGHT+IFSis3qpdLEBYFKAL4qcOoGMbvAJXOq+PxPYOsX78q8bD6vStLlrP+A0BFOH0+WadEkOtNfpg==
X-Received: by 2002:a17:90b:388e:b0:2fe:afa7:eaf8 with SMTP id 98e67ed59e1d1-3030fe8bd20mr16478776a91.13.1742838573932;
        Mon, 24 Mar 2025 10:49:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:33 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 2/7] nvmef: Add nvmef_req_hold_timeout_ms() to calculate kato request hold time
Date: Mon, 24 Mar 2025 10:48:55 -0700
Message-ID: <20250324174909.3919131-3-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme request hold timeout is the time sufficient for target controller
to learn about loss of connectivity to initiator and quiesce inflight
nvme commands.

The timeout has two components:

- KATO timeout is the time sufficient for target to learn about the
  connection loss to the target. It depends on whether command based or
  traffic based keepalive is used. As per TP4129 the timeout is supposed
  to be 3 x KATO for traffic based keepalive and 2 * KATO for command
  based keepalive.

- CQT is the time needed by target controller to quiesce in flight nvme
  commands after the controller learns about connection loss.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fabrics.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 21d75dc4a3a0..483823d430d0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -214,6 +214,13 @@ static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
 		min(opts->nr_poll_queues, num_online_cpus());
 }
 
+static inline unsigned int nvmef_req_hold_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000 + ctrl->cqt;
+	return 2 * ctrl->kato * 1000 + ctrl->cqt;
+}
+
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
-- 
2.48.1


