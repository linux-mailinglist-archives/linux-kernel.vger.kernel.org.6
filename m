Return-Path: <linux-kernel+bounces-573616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC44A6D9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297173B1C45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23625E83A;
	Mon, 24 Mar 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDChiOHZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66B16F0FE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818092; cv=none; b=O6fO2Fg6/RfPsmeKPLyEq5ktglCB4D3+aENuaMg70bifbmgX2jYrFEiaPHzBq/R4PuH1ZanmXw+pr0RuPM5k2Bt+EQ/rcdkChwAeLb3K/A1zOtOWX/900c+cE4SlblUnbzc5/L5EcXeH0Gt0ttZgiCPQRd9IgVOsnALrCw22r6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818092; c=relaxed/simple;
	bh=C2XCpY3/qQ09F5paYDzzuRlhy0cJivYvdQwEXeEVWOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBajTLnJrh8h7j0EP8PExQn6S6YqqGUNdPTOk/N2fZO+uNW5hsq8AuQzjWBfW0SKN2Prkf+f1ajbe+KM8p+kBiSYLGJVB7469Q/V93c1TRDlhbYcc+6nLJrCxYgBAh61MU7YHvtcMzpD/i72lOwwsqfZNGt0g5b6DMZWu2ZijjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDChiOHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47B5C4CEE9;
	Mon, 24 Mar 2025 12:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818091;
	bh=C2XCpY3/qQ09F5paYDzzuRlhy0cJivYvdQwEXeEVWOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZDChiOHZujBnlf+IRJC/ofdiGpttxnijSwB1RPzx+zHQZpYesLEjDKulJ8T1KFgTG
	 UEfeLq84e4CRqc8YbyflCsicnI47vkAMIx64RTJBNXBd5A8YhU/yr1fH4fv4FLSgzZ
	 M6sbYuHGOs1jT3X3MUEjrZJCjgdJsZ9whq9y4qTeVGnSIA2AkZUAHvBuzBunUXS/Rs
	 FY/7FLGY3cSTpo0gBSKQJOHQ+I27SGuG/5BjUxlAD+l59JWpJBf+EisrNMAsgcSlOA
	 U3uTA4S8/3lkXYy648PHp4u3bzemcFQVv7C7okcPL0szDRZz5TB2bzgjxultYKhB5J
	 w6z3zDmr4zFkA==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 24 Mar 2025 13:07:57 +0100
Subject: [PATCH RFC 2/3] nvme: store cqt value into nvme ctrl object
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-tp4129-v1-2-95a747b4c33b@kernel.org>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
In-Reply-To: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40046770f1bf0b98261d8b80e21aa0cc04ebb7a0..135045528ea1c79eac0d6d47d5f7f05a7c98acc4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3380,6 +3380,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
+	ctrl->cqt = le16_to_cpu(id->cqt);
 
 	ctrl->cntrltype = id->cntrltype;
 	ctrl->dctype = id->dctype;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e950c3faa764514daf3808009e223..7563332b5b7b76fc6165ec8c6f2d144737d4fe85 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -344,6 +344,7 @@ struct nvme_ctrl {
 	u32 oaes;
 	u32 aen_result;
 	u32 ctratt;
+	u16 cqt;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;

-- 
2.48.1


