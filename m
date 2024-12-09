Return-Path: <linux-kernel+bounces-438164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88529E9DB0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE0165505
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E51E9B2E;
	Mon,  9 Dec 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSR6tiXU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC061D63FD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767090; cv=none; b=X4vHJsup8/a5JdvVaRuObcnhpvevjCQ2SLz/TQoperPrc4FcsA3NAMfh7hAxntePo0cQOqFRsaS8yD4bYlWvwQudkXqnPNQRgLRnmxewfHp1g2KGVYRSwCuz05JRaXav0ISNI9S1A02CR2tXaDJbUIlpsloR+hEnkAVZxq+nbZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767090; c=relaxed/simple;
	bh=VaTHl5CWYXaEUg5GJy076IuF06Ppro6TIwGO5pxBuO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pBmzLq2yJha9+lK3AjXJvUqTStsOtAl0YUSuLWad3TEwMhniqS3oe62/ZdaggM0UKfQimPc5+yzVwMvDSWkAIDNuVk9LumDvxW1GgeYOHxZ52U6ZngsJgRu5kHWgmr7/2PT3e0XzN7nmo46lDkhF4DN9jm+Z77qPcfPniGnNbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSR6tiXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733767087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGHdr5xe6OO2VfVdzoKzmBYzOtEMeKKpC50tlN0vOu0=;
	b=JSR6tiXU68WrYqLO4qtoE0TVWw4YwKc6q3DgWMbD90c8suxtJVFn+pIfMPp2XP+wtux6VT
	nDWMlZFH7WZsMTrLYIZv333tsrmBDdQWKC5ib1ofGqiRluZQ2p+Chj2nXmOuKs3ClWs+Ki
	k/cTcO4gk5Facw49lbEbZxsCX987TNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-hIhlvnUsMiWopcay2Ie4Qw-1; Mon,
 09 Dec 2024 12:58:05 -0500
X-MC-Unique: hIhlvnUsMiWopcay2Ie4Qw-1
X-Mimecast-MFC-AGG-ID: hIhlvnUsMiWopcay2Ie4Qw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FAFE1956088;
	Mon,  9 Dec 2024 17:58:00 +0000 (UTC)
Received: from starship.lan (unknown [10.22.82.46])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37B70195606C;
	Mon,  9 Dec 2024 17:57:56 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Long Li <longli@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 1/2] net: mana: Fix memory leak in mana_gd_setup_irqs
Date: Mon,  9 Dec 2024 12:57:50 -0500
Message-Id: <20241209175751.287738-2-mlevitsk@redhat.com>
In-Reply-To: <20241209175751.287738-1-mlevitsk@redhat.com>
References: <20241209175751.287738-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
added memory allocation in mana_gd_setup_irqs of 'irqs' but the code
doesn't free this temporary array in the success path.

This was caught by kmemleak.

Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e97af7ac2bb2..aba188f9f10f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1375,6 +1375,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	gc->max_num_msix = nvec;
 	gc->num_msix_usable = nvec;
 	cpus_read_unlock();
+	kfree(irqs);
 	return 0;
 
 free_irq:
-- 
2.26.3


