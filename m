Return-Path: <linux-kernel+bounces-407592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1779C6F88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC061F21F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8149206E7B;
	Wed, 13 Nov 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQjxxlg2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3E20605E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501771; cv=none; b=onSDHHIxrS3/yer80LvcMobYOuCzbJWG8UMZSJpjPPCVAlTesTA6cznT15Z89cDEsA3BSZjWjKAaNPu5o7D/sdNyYaUCzm9e4nRy3PA7+U5vpUtGELBg4tTrz2eX19ZpgOuhBuI+BynNlRREmRpe9ySisbXvujsc7Zc+oLzkV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501771; c=relaxed/simple;
	bh=x/7QFhAzHkLj8+w14TM+V3xJvs5L48Anth4HQxPkvDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjAK0mi3gkwZ+yjmy5q8AbY/PmefoCKYlzh3wa32JydiK0/BlT3sRxdDQVRFwneeK2i6oytiK69FgCwBys1exWC80WYmZCrk2OP/G1bG7a4NoHSvpLfpbdMw/A69IV2fSYwAAJwZTxee7I96vvqN+vHcw/O+/mJ3OBScKPxo8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQjxxlg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsJKOkpA+QoYlzqeYDbY0Dl9xjdlxWNvzFNzd4dMwhk=;
	b=PQjxxlg2DkGN8DG4vDH2PICeQs7kfCV2vBxNb/MtQ5DRbGuhW/MiIKDE6PuOaRm40l3tcy
	W+e8/hg95847ObDgplNAfPVqeuzdo5M00Podq0E++NffN07EKi3f4GrXOUmKSWsprA6zOV
	VdeYK2RZYJzsOgN5GXYpunoFH0olmtA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-2dj7KOs5PPet9d40Tx1QVA-1; Wed, 13 Nov 2024 07:42:47 -0500
X-MC-Unique: 2dj7KOs5PPet9d40Tx1QVA-1
X-Mimecast-MFC-AGG-ID: 2dj7KOs5PPet9d40Tx1QVA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314a22ed8bso48055175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 04:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501766; x=1732106566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsJKOkpA+QoYlzqeYDbY0Dl9xjdlxWNvzFNzd4dMwhk=;
        b=HFt7dIQ9oKVeNJzrdvAox0bzcMCZ9pRzhkBrT7D7HZW7x7ThfOKD/3czfzppZvuwD6
         IKcMfZEV0PUHZtzE2DZ7rLpZUbtVaYEzYYm5ZgcIGTeHt050RMWL9raQyuDXgBD2t7g4
         ASTdh7zBw8HdXq9+xqKZnAKr+nVJPWaCWFycU/ZbOe00NWZEsRxqd4yAh4V2ZivhP7yt
         wS2NF8TdH9j2704Cf5mqN4UaZTIcPjwxQqghCXj2n2O133HAk4zdu0ffhBT4QbN4dUEb
         dFSCFQz8tPkzbBmkhLAhisCtfsJBLxD2Z9IFz0rky8hXG2MoHcM5U6ANdg78cM4caR1J
         K72Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz4iIdj1dP6IoSA4K/q8bjt/D3EFFvvOCDYpLXM+L5uS5b4ClOjCqYoYM0m1fwaexT1xSAyyekPz+Y+Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDupsw/Mq3VrqNVjgFm3nAJosvFNTNPTxZ9gCwf96wLCo3G8P
	Tnvkl83MypexGDcQUE2oOeeV/+2wp0TSDSQdlhbIK9s98RCZr8tGEme6TImEAeOAgXUXyWeAeng
	bR1aX6+THOizVFfhRzC2o4fOli0thSCY+xDtH+gncMjYzOXhGbEgxMaX1k4LfLA==
X-Received: by 2002:a5d:47ac:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-3820df6136cmr2369015f8f.22.1731501766123;
        Wed, 13 Nov 2024 04:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpjkcG3JEnob3xzqfsNCARyMkng1y9gR5mdhMcNm6Gi1JEJjom42U2s4Q7CInAPcp8pAzepA==
X-Received: by 2002:a5d:47ac:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-3820df6136cmr2368992f8f.22.1731501765706;
        Wed, 13 Nov 2024 04:42:45 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:45 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH v2 07/11] PCI: MSI: Use never-managed version of pci_intx()
Date: Wed, 13 Nov 2024 13:41:55 +0100
Message-ID: <20241113124158.22863-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113124158.22863-2-pstanner@redhat.com>
References: <20241113124158.22863-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

MSI sets up its own separate devres callback implicitly in
pcim_setup_msi_release(). This callback ultimately uses pci_intx(),
which is problematic since the callback of course runs on driver-detach.

That problem has last been described here:
https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com/

Replace the call to pci_intx() with one to the never-managed version
pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/msi/api.c | 2 +-
 drivers/pci/msi/msi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b956ce591f96..c95e2e7dc9ab 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -289,7 +289,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			 */
 			if (affd)
 				irq_create_affinity_masks(1, affd);
-			pci_intx(dev, 1);
+			pci_intx_unmanaged(dev, 1);
 			return 1;
 		}
 	}
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..53f13b09db50 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 {
 	if (!(dev->dev_flags & PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG))
-		pci_intx(dev, enable);
+		pci_intx_unmanaged(dev, enable);
 }
 
 static void pci_msi_set_enable(struct pci_dev *dev, int enable)
-- 
2.47.0


