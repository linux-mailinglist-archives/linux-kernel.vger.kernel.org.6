Return-Path: <linux-kernel+bounces-572692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8278A6CD43
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 00:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49503B95EB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D091F12EC;
	Sat, 22 Mar 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+7dWk89"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A471DE3A7
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742686152; cv=none; b=ct8a4pRBxHoNb/4rT56aNJAi5DnI8pzc8bQSiC010MxMomZV9hlPrpnNPUcLVzSF0u7QpOc95/dzNaJu26g3O1jg8Y9rUaDsjD0KzbymRWoGaFWhInyFaV8fN0w3uDUNCnZFSSV6TtKGLTRw6LvTUy0tyU9fYdkggAMLMcK3ERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742686152; c=relaxed/simple;
	bh=lllit0NMMQY/u2TIPZPEii8FutUN6LEKYoD6+HLrsgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=WkDc4YcCYWA91Xk+JwLns7Iqw/Qe3CuenZdFiTADPRgi9VhGDetMeBxRZhleOlhiZmUC2U4tvXom2r81xe+5XvWobqaN07w5Zp2cgv0h4CQ20/p1ItnwTFzsM679E4sO34ilXDcZb49HX/FBMTW1Uj5b22aNWgLeCt4VdpQRhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+7dWk89; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742686150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dHTI/nP8LMuZ8lpB+l5y9cpis9uyfq0/6jTpKt1DVU=;
	b=L+7dWk89dtY+BYezouXh7YMbXwnAOeM3SceVPfCI1nreCiKLQv5pqsmU90oEE1HTTxY4S/
	t3XF/oaje1y7iQ0PNmdq1wahi7RczUpTYkguya0DIE94pRnFqjfNbbBkQzvSShq6P7bHbu
	Bn2yfWarTnjWzcL4sBVvSkjRt6ZjEQQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-cPjFTpHhPh6jDJhKOJXHCg-1; Sat,
 22 Mar 2025 19:29:07 -0400
X-MC-Unique: cPjFTpHhPh6jDJhKOJXHCg-1
X-Mimecast-MFC-AGG-ID: cPjFTpHhPh6jDJhKOJXHCg_1742686145
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1B75180049D;
	Sat, 22 Mar 2025 23:29:05 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.80.230])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30167180B487;
	Sat, 22 Mar 2025 23:29:03 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH v2 3/3] nvme: update the multipath warning in nvme_init_ns_head
Date: Sat, 22 Mar 2025 19:28:48 -0400
Message-ID: <20250322232848.225140-4-jmeneghi@redhat.com>
In-Reply-To: <20250322232848.225140-1-jmeneghi@redhat.com>
References: <20250322232848.225140-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The new NVME_MULTIPATH_PARAM config option requires updates
to the warning message in nvme_init_ns_head().

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 870314c52107..b2bd8e1673ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3824,7 +3824,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
 			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
+				"Shared namespace support requires core_nvme.multipath=Y.\n");
 		}
 	}
 
-- 
2.48.1


