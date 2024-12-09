Return-Path: <linux-kernel+bounces-437622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DA9E9618
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E176188501B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EFF230D26;
	Mon,  9 Dec 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fq4HLxx8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77823098B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749619; cv=none; b=VSkq70Bm1o4jSKIdRKrqIPu3e/j7pkCbFC8CZyFK4dtbP7U6HTQOKzuhv3LQjoYTrPFwftvI30RhuQzul5eyAldY5MDjtINwDexOswuGau+YelQJMeP5R/YznZNEBn15qAme9lNXHBR9kmUCgbMun7Cwu5+D7axzkTT3kqtp+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749619; c=relaxed/simple;
	bh=mRkzqov/CYtFiWjgkuQOlRqwmB3d1pt6U/jB6t5Syi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2Se37TJBafR2XE1KKd/0+X4ORY22CsA2TiZ5RfflPKEfRyKmkXDr+z+99ruFGA4na+cFHxFNSRo397+gAkwcFHyzhe7NvSHEb8ByxJGKbEhU7ePKsWLZplur2JZVIJFnXKIm8dOjIvEQELp88i2znNHwGS1TPrnZSYP9dqfRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fq4HLxx8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
	b=Fq4HLxx8shz+hXz9Ie5ZHNeZW/4VPOHWx1FxZ2IqBM2S7fA8+uJK3AhOadiVI28z42d2D0
	QtBubrvr++4zBhbh3p9mgIcQnsSXrydI+lEXBMlzsdNtVTLi+4qtHUhY8PjPiwSf5kdYWz
	xI5JpOzu6P55PWIqu0LaFWpaWhivc90=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-oLxv0FHoOmaFQQngka61Yg-1; Mon, 09 Dec 2024 08:06:55 -0500
X-MC-Unique: oLxv0FHoOmaFQQngka61Yg-1
X-Mimecast-MFC-AGG-ID: oLxv0FHoOmaFQQngka61Yg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e1339790so2818317f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749613; x=1734354413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
        b=uDMLAZ7Xf2pYeRSrB1wWmSAcbKlrKWSxRMXlJfEJDT/3+JYGBHpuW162qnZ0+FZ0lI
         /qL8Uo5F5Q1OtHibNgJokdIqP8bpmrSy8psRt2iQW++xwp49N5zLgdOzTKJuogg8gAaw
         hdCaYxvqoGjFdx3Fvq/qXdIQiNTXvVRSj46HrtKzp0bRm/Z4V5X0l4BMyrfgarVyyAIw
         Lbmw07Zf/yyGUSuxIfNZRFplFmbxbuCcBYpHnHYCYmI+QNwuKFdEpiEHnAezOnYOGv9z
         /FfzMWg0k6tG2gmur6dtZoEB47D/uIKEWx1vft1WQ/XXWa7B7GIItZQVleTu5dH9mUty
         QeWA==
X-Forwarded-Encrypted: i=1; AJvYcCV+lGFRtWw3Ax/QvlY9u2yXLxNJbojAeUiwT3BaAshhvM8bZ+kyrc2Ew/+Lv5q7PiSXpivuajl8yWY8Bno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY17Wk0UVGTALlo6tENUtt++5UbiU/SWz3WFrzz2xVVNFbLYk
	xRAQPoOQAP6zIAGMjA6pU9ziRLB5LzqjvvEQlTo65EUYajym4ygMexDsTrLERCq46Q56XL9yXFQ
	6d0dw6sWrvVBwIUFuRIMc0I0728ovfYJMsYOXGdpAo5xR3VkrHn/Q6+R9lN5kLg==
X-Gm-Gg: ASbGncuMr7bkHsfM8lxfSWq56g7MBT3eS1olshjF2RqiX3ZPVe/FG9RD4bJJGo2t6A5
	Nw0F3yFbB8x5cFgGSyjXD7s63gCYzbfuOp6Twl9HIdpBWNnBD/Ru4Vrp29NR9OtHxM6mS7rYaj8
	W2FVfB8Io3dwlkEMiJjWjdX2i6i/f1decaQGD9zxByvT13DfYfZ5osHQY5tEVGVaMaHN52GcpwE
	SNlutJJUghPow7goHR8XT5nbfcvNyAb2G1ympmXIwAELyxK22Kf3Rrl2ILSugQ8IinTGA5Ieig3
	0gX0mLYa
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188115f8f.54.1733749613291;
        Mon, 09 Dec 2024 05:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj1wppsmKOkdvfdKSfuff+I9JjxqlZHOEEdHEk5K3zylRh/0qa/2JfnJnGp4etqXepLTEqow==
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188043f8f.54.1733749612866;
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: amien Le Moal <dlemoal@kernel.org>,
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
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ankit Agrawal <ankita@nvidia.com>,
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
Subject: [PATCH v3 03/11] net/ethernet: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:25 +0100
Message-ID: <20241209130632.132074-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209130632.132074-2-pstanner@redhat.com>
References: <20241209130632.132074-2-pstanner@redhat.com>
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

broadcom/bnx2x and brocade/bna enable their PCI-Device with
pci_enable_device(). Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 drivers/net/ethernet/brocade/bna/bnad.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 678829646cec..2ae63d6e6792 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -1669,7 +1669,7 @@ static void bnx2x_igu_int_enable(struct bnx2x *bp)
 	REG_WR(bp, IGU_REG_PF_CONFIGURATION, val);
 
 	if (val & IGU_PF_CONF_INT_LINE_EN)
-		pci_intx(bp->pdev, true);
+		pci_intx_unmanaged(bp->pdev, true);
 
 	barrier();
 
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index ece6f3b48327..2b37462d406e 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2669,7 +2669,7 @@ bnad_enable_msix(struct bnad *bnad)
 		}
 	}
 
-	pci_intx(bnad->pcidev, 0);
+	pci_intx_unmanaged(bnad->pcidev, 0);
 
 	return;
 
-- 
2.47.1


