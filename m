Return-Path: <linux-kernel+bounces-384396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D39B2996
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B71281B89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5D1CC88B;
	Mon, 28 Oct 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvNsGOBK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1719308C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101502; cv=none; b=BUd3Fz8JYyx8xnAM2xYTFDqremD/khsdvmlTGDZhPZbn49CskUJFBG80+9qqznzMJKr6aTHfH1P9RZWVHdx7FjMNokvtO3Uwx2SVdwAy98va6GGHXOezfnEVCK/7DF+xWCZY9UTaYS0XHb0lyCIDSlTadaTxt7/U1PdDFIFvzPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101502; c=relaxed/simple;
	bh=PEZr0dlQokSOg0EnOX8DNbTQF91ffCeHj6qA1SGw03M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tl4kxShLx34sMuf8mZ+NScL1NddFKkrvFYKLaVIoxlKfayZst5MpNgYtpFdnom7IBGhJ9tSdzCX4Jn7sXQg+FdDucTvkF2JwPBUw0Vjvla6uylXpJg/C0FHq6UDbN/0FwrHjT+K+3qyORQBuUIdhIKsLABpb6KMuG6HRa6RmaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvNsGOBK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730101498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hbIQ/VhVhZ0OvUIRysIuQ3OzP1NdlYynlJ50dCrgjTU=;
	b=TvNsGOBKVn06rVFRyUh1lwM4XkthQxFNKDtC+2ODR2aS1aAhhxbAh8TXvgymsnNNn0C6sM
	WAe7gz4VxcKh039ckt1IE/S/nOANuLuwcBcnFrGdWRdaEeVBxWQGPLNDYmw+KYvylhH2Of
	m3zB3R7HGwJywmhHqexOhfLOizuuGmU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-tDrgawoJNEml7KGmIXk6Qg-1; Mon, 28 Oct 2024 03:44:57 -0400
X-MC-Unique: tDrgawoJNEml7KGmIXk6Qg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ce2d91fa3bso69390986d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730101496; x=1730706296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbIQ/VhVhZ0OvUIRysIuQ3OzP1NdlYynlJ50dCrgjTU=;
        b=PmNTswsomNFW3sf8FDkCrLSnFhbxJmg87GWiqFS3iej0bpehBSYr8OIVKd6EfvaYM/
         csy4hdU2q3pF/4FwEWpNw4CkviGWUzNdbUKEEGgpU4Av5+1UqxPu5xyiTpnjsJ4Z/s2I
         uR/Acocj8vG7CFPS5QVFjUT3QnkAT0nhFOahAQLhdASLNtHeduimC5dhaXw9cwLwjkTD
         Wz35mIuWqQPEc2ma+RI2gaKrPyDoh1v/8zid66OyIb8FIv4jA2V6Yc63WDGmB3Dkk8dk
         I9LHMNwMlzlZxlytYkmK8Q91CDBLG+Auwcq4iX5LB+VYb0T5GsSd4tibYl+C85BqEViZ
         i3pg==
X-Forwarded-Encrypted: i=1; AJvYcCWg3rX+K/k8CbEs8jFuo7noFhWR12/ZwaseC2CJAlkQOmmYjjZMdF48M8qmZbznZZugzi9x+m/oX/TphT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoivoXAchd/rL13+0E/116Xig+3K+s4nlKcGpGFtQ6KhnNxPM+
	1lsCwIaSEYAz78YwZCCtyRqT0RLhOE97AS33XkWbZlD51wKq7da3nRGk7jgdpE6FB9sPhgirUfI
	1ucWCPXu8sx4N1jk7FkcPXIM8XnXQOFLjpdp1JS1QlR/ri/Qy39PnpT+jl8tc9Q==
X-Received: by 2002:a05:6214:2dc6:b0:6cb:cee6:d834 with SMTP id 6a1803df08f44-6d18585e762mr121038906d6.45.1730101496509;
        Mon, 28 Oct 2024 00:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYrXXTQPuJOobZASjIKDFRnHrChhHyjJipSBygd3ZhctAHecyDi+Abnul9u/vpmNdW1daW7Q==
X-Received: by 2002:a05:6214:2dc6:b0:6cb:cee6:d834 with SMTP id 6a1803df08f44-6d18585e762mr121038756d6.45.1730101496220;
        Mon, 28 Oct 2024 00:44:56 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17972f566sm30237716d6.13.2024.10.28.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 00:44:55 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2] vdpa: solidrun: Fix UB bug with devres
Date: Mon, 28 Oct 2024 08:43:59 +0100
Message-ID: <20241028074357.9104-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
pcim_iomap_regions() is placed on the stack. Neither
pcim_iomap_regions() nor the functions it calls copy that string.

Should the string later ever be used, this, consequently, causes
undefined behavior since the stack frame will by then have disappeared.

Fix the bug by allocating the strings on the heap through
devm_kasprintf().

Cc: stable@vger.kernel.org	# v6.3
Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
Changes in v2:
  - Add Stefano's RB
---
 drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 99428a04068d..c8b74980dbd1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
 
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
-	char name[50];
+	char *name;
 	int ret, i, mask = 0;
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
@@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 		return -ENODEV;
 	}
 
-	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	ret = pcim_iomap_regions(pdev, mask, name);
 	if (ret) {
 		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
@@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
-	char name[50];
+	char *name;
 	int ret;
 
-	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* Request and map BAR */
 	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
 	if (ret) {
-- 
2.47.0


