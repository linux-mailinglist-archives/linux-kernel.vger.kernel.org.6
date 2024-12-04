Return-Path: <linux-kernel+bounces-431830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419879E41DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1634D16872B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CD71F03F9;
	Wed,  4 Dec 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/OZePwO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCB1B81B2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332247; cv=none; b=LFE0gd72Ku0Nh4QGaxE9whAaRyIbPS/MtQaKouG/kAJRAaMIRmc9/Hq6hf/Dg1bqaJb4h3bq8s4s5Kpe0dCvPu6t8ynMym+hjI5dNjhJKi+GIluQCe8dXt/VpzY6fjB63Nu9SZ/lpAfasdBbZy7IVfq+sUMLRm44ZmkxmFCcvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332247; c=relaxed/simple;
	bh=252WJHRqmYyVE9xuwzM+nBJzmQeW1IVIrGa3VR42U/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAlgR1ZBBa44MJ+37eTB8dbA5lwnv523ltVDE0sH+9K7yu7l2CWRAfoMmIRZBnbuU6cOyg+8cqY9dKCzESujyrlO9rLO33YIuTvqFuDDlrVxGlVChuIcgHnoV8kRZiJE08AppJcRgTjJAplV410PJDtHsRKneCrW3/+/MEqcCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/OZePwO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733332245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qhsSuK/y6haVGH5HmM3lnvDB6cMNHNIazjRPI+Nr94=;
	b=M/OZePwOULcenXTD1VJysySj6xoxhirw/FqjvilcA55SPKhEKLad12+1VL15F5nIMe2N7Y
	0VK8t7A+ADsYl+WzcU4umiEAo+opXTf4nsThA80z171R227AlwaQYiij1yuGWxFF2JqmBS
	hkpnFK6pSCybmjs6Py1YAcBvbsY22N0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-eEvfftJDNb6rCmb6wHkTcA-1; Wed, 04 Dec 2024 12:10:44 -0500
X-MC-Unique: eEvfftJDNb6rCmb6wHkTcA-1
X-Mimecast-MFC-AGG-ID: eEvfftJDNb6rCmb6wHkTcA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e5e3bf60so19284f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332243; x=1733937043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qhsSuK/y6haVGH5HmM3lnvDB6cMNHNIazjRPI+Nr94=;
        b=CgHobkV43BnnHI/Smy8JNvYnoDBJZgCZnd94rPsmoFAnB8NbAqaWJClnp5CedWuf4O
         RWLYafu3MORrxPVmOV6XPt8HIjEce6htdFgEu2x2+TDO97lNJr/dDpowhjrOazN/2sT9
         K1A9nfhAVKat2ed/gyp+qsYRsmx4vMC4BM56BOteZHXk2sc5YPx8fimb7W3mzu7AKMlJ
         dD/3Fr87FTunNYllxf7UrLZDNaApKhiHVggkc5f8ZmtNDz8sC/R3iWefeSzbndO0ow+q
         5BABI5PBekQ/ndvs4Iw4EpFlAMyHztaJFZDzsUnFyJV3O6kIh2mWf7oJ/KoBDavzCv4o
         73vw==
X-Forwarded-Encrypted: i=1; AJvYcCUwL2hC7KWXiIyQvqFZ2NxC0Ie/Z6wuYRg/jNRsXE2x1IW7mPGrtz7v/5nCHHPjlknZ2eLzGhzIgO4M044=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mM6svr2iHq3aET2rLT2fzMadMzhXU605dCpe4uwlnt/ZNj9l
	f3gjdJ3HXdZcFSg2ivglhanquvhMXQ/DDUv8CsLEyt3woCM9FDk62C/FsgzcyMbVPIKqJu+sa49
	YlPgABm/bZQRVuLSVLdr5RuDtAEA+stL7iislH4tePeINamLp4HadrQ5ZXPE9fSroaD6Sd72m
X-Gm-Gg: ASbGncug67/Gt8ZwGe8fKetWiiJg84F0FJFVbaVdOzlXKR3uLTM3o0yPotALQ2g4Pff
	t/dpXTZLWHo62lftRtRySY5sWH1aYiFAJIWShPoR+lTebj+KFCAF5uB8Nc8dXQWCapq7AlNx7Wp
	OFiCJs4AX9+Eb05czQP+qnty8EwQhp4tFHBk7uEsiF9ovhkhwBc84lh2V30Af0VBmUzK2WzKaYs
	m1IxGB58Ds0qL3i9jBa6IAzUeHrn13HIrWW4vzi2xdeJVkHRy9c+SMAd/5lJSQ0DZRln6nDVTIc
	UgS0uGLU
X-Received: by 2002:a05:6000:1a8d:b0:382:3efc:c6d8 with SMTP id ffacd0b85a97d-385fd3c687amr6454466f8f.12.1733332242765;
        Wed, 04 Dec 2024 09:10:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/GF6sPiBa9HI2oPIKp0PMZ57apURu7dhWa3Yf8IMYFPURi79LO0lLA26zp+/eQVZs+3r20A==
X-Received: by 2002:a05:6000:1a8d:b0:382:3efc:c6d8 with SMTP id ffacd0b85a97d-385fd3c687amr6454447f8f.12.1733332242416;
        Wed, 04 Dec 2024 09:10:42 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3860bbba038sm2179511f8f.24.2024.12.04.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:10:41 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 1/3] ata: Allocate PCI iomap table statically
Date: Wed,  4 Dec 2024 18:10:32 +0100
Message-ID: <20241204171033.86804-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204171033.86804-2-pstanner@redhat.com>
References: <20241204171033.86804-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ata_host.iomap has been created and administrated so far by
pcim_iomap_table(), a problematic function that has been deprecated in
commit e354bb84a4c1c ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()")

Ideally, drivers should not need a global table at all and should store
ioremaped BARs in their respective structs separately. For ATA, however,
it's far easier to deprecate pcim_iomap_table() by allocating struct
ata_host.iomap statically as an array of iomem pointers. Since
PCI_STD_NUM_BARS is currently defined to be 6, the memory overhead is
irrelevant.

Make struct ata_host.iomap a static iomem pointer table.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 include/linux/libata.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index c1a85d46eba6..d12a9627c96e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -23,6 +23,9 @@
 #include <linux/cdrom.h>
 #include <linux/sched.h>
 #include <linux/async.h>
+#ifdef CONFIG_PCI
+#include <linux/pci_regs.h> /* for PCI_STD_NUM_BARS */
+#endif /* CONFIG_PCI */
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -615,7 +618,9 @@ struct ata_ioports {
 struct ata_host {
 	spinlock_t		lock;
 	struct device 		*dev;
-	void __iomem * const	*iomap;
+#ifdef CONFIG_PCI
+	void __iomem		*iomap[PCI_STD_NUM_BARS];
+#endif /* CONFIG_PCI */
 	unsigned int		n_ports;
 	unsigned int		n_tags;			/* nr of NCQ tags */
 	void			*private_data;
-- 
2.47.0


