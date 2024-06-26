Return-Path: <linux-kernel+bounces-230426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D687917CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E755B28365D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F33016E88D;
	Wed, 26 Jun 2024 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="hYPbyF7h"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCF12B144
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394706; cv=none; b=lyUoqJ8exVU6Ie84ymDkLDmuINE3RvVhUF0jW05f1XcrUesC3mAhqcA/n+eVvWeCjfTDP4G3MCWZZJZ6XAporUOUkmpMVeTm8UMias1mSOGJjXErNK5CJfn67GORMEZaV4r8cCaBsxMxrHh11aRwt5rgUSIm5ho03oGGmGrk368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394706; c=relaxed/simple;
	bh=VMgxm/Ef7XHNkgrpqem5t2A+iBBaltsqNuNFFFlZROE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rTyEb5M8mWzt+uUaRdwXf71lSUj0hY+SMfcjPSEm98AaMHS78xpg7zDHq0I1LEP17OYlVNiMOsc7LOFmLUrt1M2xFMfbk2+8V4qTjDugY3F/mv4Z7M5mpyIS9RpmAxixnk7VS9RAfTSf2LxYapH1FyYTSbCVc+XJyPpNuwUYtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=hYPbyF7h; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70b2421471aso4601238a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1719394704; x=1719999504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8+v3noNoyPjynJix5Z6KWWDUhj0ABP/SpdUpbNFskg=;
        b=hYPbyF7hEXoNJRpZ0k0dZdUb3ZqCMxZenL9iP+0zd3armOWxzF+voEOFMx3ZvG+A7M
         0rICP3hI1gTiAj2RRGphCUY3uZ55dx830DAM6lXhHiWQctnuU/N4AH1XKK5+0Xy2ckzd
         aAf+w0Q/O++2DSWO30h2PWykXH/QORroUdKKZpY1gIol7WwiOgiDpe589GVfjCTkBoM7
         FXb30Pm8aoiShIqHQPykabZiJ935Q7kT95mEX5NpFuAh0+8L19ToHVa5JtjBE1Vw2Ipj
         LU/879XXLhIZj1stAqLB/tGrFJ8uq7csopfLODifEePZ0Zbr8EMEpVWByC8rd+4m+b1J
         Qs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719394704; x=1719999504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8+v3noNoyPjynJix5Z6KWWDUhj0ABP/SpdUpbNFskg=;
        b=T5QOApAStu44eiVnOehvdZqjYy44xapQrfvbOGe3YfHW65TuRGZpSOVIKdmp2MssBl
         EGkbRJgBjp/ZndTJ3AbdfkHARlvbR8JiLO/XXS+dj3cljPW/JusjmwhLLBTVnncKhujP
         fUbGKAMp+CtuZRcf93BzSm/zncf4pC/bL2QSCjZVdQSYSzG9EKWjYl9t5lfFvHVWI2g8
         qnV1Z6wph09Vpm4FU3YHxWn+46kkvwH81dwm7RugvmAW9GHype+xBlodse+W5u8Zcm4R
         c7k6Z8Gk2RF+NK7ScAdcBEVscGwawmCe5GNLuH83Fs2samzRws4vIpkBpcQr6ai1Gz2F
         6U6A==
X-Forwarded-Encrypted: i=1; AJvYcCX4U9yeTTSSep2Bdt02nARITdq/DqshJGn0wMt7ohI0Ppu18O+Ok+TdcXpMFFEDgMDbdqRgPNkKtCeF4zu+BDcrCFx0kT7zzzzfKNBI
X-Gm-Message-State: AOJu0YyDkzKa5td0Bx+rO4TVfV1U2fTVbhEcqF6eDyuyPASNW/lMY5br
	UwsX8s++shNSSbNCuBK8JQG0zAmqMlQrfjVsuuaMc77ecMcejZXNMTzjPw90RYc=
X-Google-Smtp-Source: AGHT+IEC3KSzdYFibbSuDaV54ZQfYOq+YaBYF/YhFaYzGn4bpoJpyTfuPOdLMIDcdRzSetN4TJ0NrA==
X-Received: by 2002:a05:6a20:4f24:b0:1bd:1972:370e with SMTP id adf61e73a8af0-1bd19723884mr4741524637.48.1719394704435;
        Wed, 26 Jun 2024 02:38:24 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c6d47sm95676685ad.178.2024.06.26.02.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:38:24 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v7 2/4] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Wed, 26 Jun 2024 17:37:00 +0800
Message-ID: <20240626093659.14346-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626092821.14158-2-jhp@endlessos.org>
References: <20240626092821.14158-2-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "PCIe r6.0, sec 5.5.4", add note about D0 requirement in
pci_enable_link_state() kernel-doc.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v3:
- Fix as readable comments

v4:
- The same

v5:
- Tweak and simplify the commit message

v6, v7:
- The same

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cee2365e54b8..bd0a8a05647e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1442,6 +1442,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1458,6 +1461,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.45.2


