Return-Path: <linux-kernel+bounces-366503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426599F66F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CE11F23A65
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9511F5836;
	Tue, 15 Oct 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frpMRkJO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB031F582F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018337; cv=none; b=C5PeMG2fKmeVK/xzMFsSfR1ZYjOj8zKntNUaM8ersnKbGXy6UrxN34BKEyYcpU6BStm7XD0qtpiuIVtgBYldD3SGH+VdYMzZ83FAEwpEi0p1bpu/SoJKdC19kddrQR4OwxHu0uYRTNadbdChlFXfoHNjdECdiSQRmCFuLqUg+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018337; c=relaxed/simple;
	bh=/SfxeGkmkuFBzJlcm9he7bsLCj/mubu0nn2+ZKQiN20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEZHj3XzUrtIODXe4G1NFlFeq9qOBzxS1Gr+DUi7uOHkd7hCCTKSW27AJBftzpHI4g3sExtGHEVhL34eNelmTrI722Aj3oV/5ynr/6PT+Y779B3xevQhLOQ8uexzH2zLl7Vb/k37Fiz+EcIEryOEp6w4S4RLVi9b7/ZW/cgf+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frpMRkJO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8By1s5DNgX9TQd6/BhnQDktT5vhu3DwbP7hhC4pXIE=;
	b=frpMRkJO6ak5yMtXNb4idmpqXEfjcyoO5pd1dBlMSWHtBB0acQ0xEtXzPLHo4cvWDMPnjf
	ivv2tojiYy04cVoeUk+9fh4FRSUsTyol/NwVWXAjaKfFaskYftZYoMC4uKBMSiX2zsCXbo
	n95/Hq5wcClCfBhLMzYnRTHZQvls1cM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-cBaROq9VOeiGHgN23PA_NA-1; Tue, 15 Oct 2024 14:52:13 -0400
X-MC-Unique: cBaROq9VOeiGHgN23PA_NA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a194d672bso150899866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018333; x=1729623133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8By1s5DNgX9TQd6/BhnQDktT5vhu3DwbP7hhC4pXIE=;
        b=R9klCEzqOnnrodzHeIhRuh8uCBvB1aSSNytBj0sy0nzvlh74HbVsXAdOvZ0QHmYlSA
         XhO2N2uww5Fe5o9UKCnDIdr4bhfR9lZhkz7iweHOZRr7gRkuoxE5rpqEkejNvn1dHzAD
         qNZ6r7gUEErQDJktIBrxRBTbAokmrCt+QHQVWIrX1PwOoWqQU3eyLc1ImUYoXwmTPNVA
         5PcrRwqJ3mT1XfIjnZG2Hn00VrAIPdyNtpNm1epyVoKQ18PqhAQ6/DLDJMNdFdPPi+R/
         xPmXuiOos5Z2GtA1yfbyHkQrN11Dd47X+KWLOMmm39aEabNr9TnNhh9hJy5+tbxPe9rp
         1o4A==
X-Forwarded-Encrypted: i=1; AJvYcCXLPTtlk6jd9kHHP/UN/iNVrjD18NIaJyvpLaRWsm4d6lZnfE2jVPj9935399wHCEDd+6rDOm+IMM4OJVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Mb/srRSiyEMJRQn/8k1Gl2WcXk7/rS18E6kw/TACogHpJk2C
	xXCyyazDI3htnyjmFR3Pihq2aL+7EOHJluM3KaWKWYqdcTWL7MkmjLGGPPNPHutBQGvuQ/fYfFr
	rxW742lphLBQBfthk+niPpvAbYqYSMVLB0gyyfK2O0WHiVgBDmkiLG251JnxRSA==
X-Received: by 2002:a17:907:7296:b0:a99:398b:59a2 with SMTP id a640c23a62f3a-a99e3ea2b27mr1249218566b.54.1729018332723;
        Tue, 15 Oct 2024 11:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVMiEMyqRAKWpWp2L+WAD0bOjYiITCR1i/AfinVgUXX5Av5wUs1Mv5vuWKI1T3DD0pJ93RAg==
X-Received: by 2002:a17:907:7296:b0:a99:398b:59a2 with SMTP id a640c23a62f3a-a99e3ea2b27mr1249213666b.54.1729018332219;
        Tue, 15 Oct 2024 11:52:12 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:52:11 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
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
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 10/13] wifi: qtnfmac: use always-managed version of pcim_intx()
Date: Tue, 15 Oct 2024 20:51:20 +0200
Message-ID: <20241015185124.64726-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015185124.64726-1-pstanner@redhat.com>
References: <20241015185124.64726-1-pstanner@redhat.com>
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

qtnfmac enables its PCI-Device with pcim_enable_device(). Thus, it needs
the always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index f66eb43094d4..3adcfac2886f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -204,7 +204,7 @@ static void qtnf_pcie_init_irq(struct qtnf_pcie_bus_priv *priv, bool use_msi)
 
 	if (!priv->msi_enabled) {
 		pr_warn("legacy PCIE interrupts enabled\n");
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 	}
 }
 
-- 
2.47.0


