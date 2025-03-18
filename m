Return-Path: <linux-kernel+bounces-565968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFDA671A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8017A2B84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6120C006;
	Tue, 18 Mar 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL/03HPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5020B817
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294435; cv=none; b=XfmuPEQo994v5KgnHkiZnHOheHhpcOHmINF/BB1nlnI4ybARpzSv/YaksGb1fD98jyoFdsYXnKZrRkyk4Omz+Hxf4oWtgPhwMlt9mDQBouSQsnbtYrd6lu06SXb38JS0S9sylr7uI6gpeWF+F5/RvP30EHAbZCZI8fwmItWehDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294435; c=relaxed/simple;
	bh=/92ooGbeabbacagz1kQIT/ubrVZ4C6yUg1CR20B0YxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAZPc9UnSasdjWU/xdzem31i/AvzdoRmc98HrwdWTXwgfhv3EYbXCt5i9aOauNMiEr2t0PfV+Kb3xUIQ7QtG6Tq0PXyXW5Pu6UTbnCYi7J3a4wOKdxIj/qSW1WnDXe3GlcSi9a/E4FfxtNabdhTsP+CrV2y7tdtJb48uWcWnFXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL/03HPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E68C4CEF3;
	Tue, 18 Mar 2025 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294435;
	bh=/92ooGbeabbacagz1kQIT/ubrVZ4C6yUg1CR20B0YxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SL/03HPGNwlREGydN6Z0gKEfEMj5caRwP1rBEclgoam34Ou/2MN+ovavtWppGa4oL
	 NGuHQ7etSy8n/WCOBXceAezPSFtBzQTwhGBahEqXxCByiI/u28YRPnHmPu8BUX6Rrj
	 I9mXlBqa6tOkD59bQVibquaAlNuCBEMPugXKY6fzMjeWi6tYDxq2ruaTQ5tn4GEvxV
	 vz20RX/z9D6PgGwbOyNhYm/+DcBWosMf/jQvmUNbJVmsYNnhPGIUyVBnnWDUPNVON4
	 VMg8y/gNxSzITAQsj6m2cy0bpwEcvX5Tizm9RxRqTo2rmAnC27FlpLRyp2YL2GAHvX
	 NZPVAA8BdKYVw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:07 +0100
Subject: [PATCH v3 13/18] nvmet-fc: update tgtport ref per assoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-13-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

We need to take for each unique association a reference.
nvmet_fc_alloc_hostport for each newly created association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 20ea3acd7a5ff6f7c27b55b8c00f22b2a0768b7b..8b14947906948c8b4914932837b4ec90921b419d 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1139,6 +1139,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		goto out_ida;
 
 	assoc->tgtport = tgtport;
+	nvmet_fc_tgtport_get(tgtport);
 	assoc->a_id = idx;
 	INIT_LIST_HEAD(&assoc->a_list);
 	kref_init(&assoc->ref);
@@ -1238,6 +1239,8 @@ nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc)
 
 	pr_info("{%d:%d}: Association deleted\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
+
+	nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *

-- 
2.48.1


