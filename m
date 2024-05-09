Return-Path: <linux-kernel+bounces-174944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F298C17C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23FC2818ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E98564E;
	Thu,  9 May 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KlVFEFjD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876784A5A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287419; cv=none; b=fVhSGKHSqooJr57rG8m70yx2X0EgqV0Bm7i+sxgi5BlYJD5dIXbDLuB/gcdjsAExY1ZD+NCdHlOYkPw0M2DRSgWfov2BFYn0oqOiNQl0mGYxe2BdDtJxWM/Hmtikg+hPiUttxfR8IIUZh5ihSTB2FGz/O59OliJO3ZTY1eoZdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287419; c=relaxed/simple;
	bh=29Ogzu8HUgDu3PF9FKvjcGb+SavKhmrv7g+xDkNBUkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=GVYKVIe1FHiYc50Cio+MczrHWtw4OlfKxy3kS03jQtTPmDjJiFuQmpt9j2MzLvaNyYiOfDjz5vQ1yKIFE4gADTEUQusVocvTzu2c2+EMyASEY++6KmvvjaNn4rhUuvf7UnZ4Na9TwR3BATx/058AD2Qzu/0QPLVnU/UPPycwUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KlVFEFjD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715287416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8WReQiv4GBqlDuegj32JcgtpHrEsWG68ox5pprOL3Y=;
	b=KlVFEFjDjoa6kRIL4jQtff+VV3e8KoaBb1hj9kQdILjOJKJYjztPdTgh68vsPV/J04YQxu
	qMdKmid2oaGPRKpsZDCEowaIUh4rinc10vnjMve8rjsxJYPxV9JYJc+nRALZnqDOzaDTKJ
	ln4NwFvdAfz13XchmeVwPf2R06Qohcg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-MVAV1Q_mOD-RwikX89Y0GA-1; Thu,
 09 May 2024 16:43:30 -0400
X-MC-Unique: MVAV1Q_mOD-RwikX89Y0GA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FE3829AA389;
	Thu,  9 May 2024 20:43:29 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F25061C4DB56;
	Thu,  9 May 2024 20:43:28 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	aviv.coro@ibm.com
Subject: [PATCH v3 3/3] nvme: multipath: pr_notice when iopolicy changes
Date: Thu,  9 May 2024 16:43:24 -0400
Message-Id: <20240509204324.832846-4-jmeneghi@redhat.com>
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>
References: <20240403141756.88233-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Send a pr_notice when ever the iopolicy on a subsystem
is changed. This is important for support reasons. It
is fully expected that users will be changing the iopolicy
with active IO in progress.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e9330bb1990b..0286e44a081f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -67,6 +67,10 @@ static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
 		}
 	}
 	mutex_unlock(&subsys->lock);
+
+	pr_notice("%s: %s enable %d status %d for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[iopolicy], enable, ret, subsys->subnqn);
+
 	return ret;
 }
 
@@ -890,6 +894,8 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 {
 	struct nvme_ctrl *ctrl;
 
+	int old_iopolicy = READ_ONCE(subsys->iopolicy);
+
 	WRITE_ONCE(subsys->iopolicy, iopolicy);
 
 	mutex_lock(&nvme_subsystems_lock);
@@ -898,6 +904,10 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 		nvme_mpath_clear_ctrl_paths(ctrl);
 	}
 	mutex_unlock(&nvme_subsystems_lock);
+
+	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
+			subsys->subnqn);
 }
 
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
-- 
2.39.3


