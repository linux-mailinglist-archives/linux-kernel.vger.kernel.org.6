Return-Path: <linux-kernel+bounces-211633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4409054AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF2F287EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BB817D880;
	Wed, 12 Jun 2024 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="PD796aNp"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEA917B4F1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200993; cv=none; b=XZ+nKew/WGR+TawxZZdgvLW7LmuIRZl7Z2M6XYLbkltooo5/JPawcKl4n6Zgc7vEj+Mdwjvu3uBkmmCQ6bsNT2Ff9yrLMuw88hEh6RF2g2+pmH35c5o9xnXKxlQPIPJR9n4ndpSJDfbTGX+37ktZshD6zVr/HzSfGhxIPBAyyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200993; c=relaxed/simple;
	bh=lKi0c8jAEfL3qdMzM21uvINYprAZcpnmkKF5YkiTWRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Mjz3GJnlHFa6zLDXqVTJox6brTvAu8wrkF+++6NweZOwiEHddZaEo+q50l/0dO79fgIfSysYVDtZGdo1tyHT4FEbFu8QXs/EO8ByjDsawZKkDu7/3O4A5zquxA6KEf3gKOZqefEpLEmEY9BsMj1E2bFIdui6hYrJgVa3cCTsZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=PD796aNp; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12F62DACB4;
	Wed, 12 Jun 2024 16:02:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718200980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=bYjuWPJtQLDvvNKeuoBi+ek+WEDnKSAN6kpuXyK3u9k=;
	b=PD796aNpkXHvz8SAhnG7fTfPeHYl7rHIPpI2lEGEsNcS7uYKFqqp/1YgWIJnWX9tW4ExBO
	bAoFpATYy5TrdzbtMa4JtInjBqPMZdDbHv1F9RHQ1BBUFIXDNsWMX62x+OkbUHOempzkaC
	anYJdCIckPKsHpQssp83kRk9A8HAK1j0Sdh6AQQneicfUO19YKJFwTv+McAReEo/+Dybzo
	M21nty71dQPdaAK/R/UnxL+RCb5p8RHvhnzS+mtuVcX1z47YbL4dx76GId50TYuhX/m72t
	wgjnxOAgExDprlCgZKDLoxusSk/b/gGFimhh8YbdOIiVy+EHGJWJ/MRv2k8M5A==
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 12 Jun 2024 16:02:40 +0200
Subject: [PATCH] nvmet-passthru: propagate status from id override
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>
X-B4-Tracking: v=1; b=H4sIAH+qaWYC/x2MSQqAMAwAvyI5G7Ct+1fEg2i0OVil0SIU/27xO
 AMzEYQ8k0CfRfAUWPhwCVSewWwntxHykhh0ocuiVhpd2OnCcxK5rL9x5Qerpirn2qy6My2k8PS
 U9D8dxvf9ALgLIIBkAAAA
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3

The id override functions return a status which is not propagated to the
caller.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
While reading up on something else, I discovered this part and it looked a bit
sus. Only compile tested.
---
 drivers/nvme/target/passthru.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index bb4a69d538fd..f003782d4ecf 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -226,13 +226,13 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	    req->cmd->common.opcode == nvme_admin_identify) {
 		switch (req->cmd->identify.cns) {
 		case NVME_ID_CNS_CTRL:
-			nvmet_passthru_override_id_ctrl(req);
+			status = nvmet_passthru_override_id_ctrl(req);
 			break;
 		case NVME_ID_CNS_NS:
-			nvmet_passthru_override_id_ns(req);
+			status = nvmet_passthru_override_id_ns(req);
 			break;
 		case NVME_ID_CNS_NS_DESC_LIST:
-			nvmet_passthru_override_id_descs(req);
+			status = nvmet_passthru_override_id_descs(req);
 			break;
 		}
 	} else if (status < 0)

---
base-commit: 6bfd66808f973cf1bb234e54d0cd51a15bba2996
change-id: 20240612-nvmet-passthru-fix-5754c63f2938

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>


