Return-Path: <linux-kernel+bounces-185698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A818CB902
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7019D282CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E326757E3;
	Wed, 22 May 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDHH/GXu"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317573189;
	Wed, 22 May 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345570; cv=none; b=uSp0mDfLS0orOgZsfkCCsEvC+o301xCyY7/toFAj/mKm4guFdoWqLF3Q8YedhboMS6y+qcgY5lcCQje+GezpzyIELgbvUd6R/Ol+3kIYl2rbS1wDN4FDt025zhyufKzJYicu12CJb2+Odc6bGxL20vNyxkCoZw0vcSuDofhcSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345570; c=relaxed/simple;
	bh=5vYKAz0vYuM7ZmedsvMTR6TOI29PHirgtV9WSXn22lg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2f9jZUG+6g8MGQxoGRM9lFyL8ZL+LYXcW8W7JCixgJUBzCNB9vk7QGw6INo3pi+AH49q+zpOALTLA/M0yIraCpYlPJprtvDNMm9wL1z1TcUiGFArZ3O4J/gRPuZwr+H+iQkPvRAvee1C/OFVkEvKjrzv9BjEeVSboJWdxXC754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDHH/GXu; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bda88e2b23so34492a91.1;
        Tue, 21 May 2024 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716345569; x=1716950369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhRERJ2JMt78LFDeSWT8MFFp6Nkr6mefqh6SZ/M3HyM=;
        b=MDHH/GXuMHtbCxmeNmt2c5YQgmVnqgyFx6lAeMaFKPqvy16xZrj4Yc9GMuB6eSLUk2
         QHP5WmCgqmBDvH7KicFQjdoGyustIY45zNtR8K2nTuKh33R4IXLeOoKL80IyWdU1XimR
         Fqk9/Y6+o7X2X147mKY2yQtCESLZOAGmbGLLVALBxI4aFG0oKn5efHKDyxSIrMtEK/GD
         ijkKMV4bPA6dKwqXny1Actp71sutFM8LzYXQGLvi9yzdmXaI2IJ7uBaOqOCZXm7uOlTi
         J2wpsDvWzpoR28rs3JFa7Ru0ncrcc5vGvFOnWPXr4vVWKi53T3w/W1hssBZ11cXB+S6j
         qV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716345569; x=1716950369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhRERJ2JMt78LFDeSWT8MFFp6Nkr6mefqh6SZ/M3HyM=;
        b=UEJ7WBeHThg8+0MhCkApt+66tYgtqOG2QwZfHaVOUT5ix7AfFDA0pKCdFco0jbnSVY
         N5r6Tl/eHtQ8kSdnsXUxF16ehd3Wwrurwnl9N9xSa4qAvscwabTmKb4dT6R5MONJw8+e
         SvwajGNurkQjFq9ifXPS6dfl/F5NnRZg80/igRmateLzF6CxFIR/pJjyyWrpgbRvcv46
         c4CLTAplnz3+mvvW/VkoaeOjrIQCAT5l7Ess8Wkkj2/iHr2PzBQjbqnQp2hC27rcHwDS
         p59RJnVFDFBXWPVjSVMGTvOayE/QypRNhFNuPr0gywWU5yz3sjueOU1eOuTP/+A91z1z
         lQ6w==
X-Forwarded-Encrypted: i=1; AJvYcCWVCsi2bop6HUE3sLKPfyyGR2vXnkorYP9VhMrPhEQu8foY5ULXCBjbt9NGl/nD7wjeEhSnxtZ+oy6mQ+WhMfw1ShzUa7ElqM9Ju7YY
X-Gm-Message-State: AOJu0YzN6+ugDqUhlcQ9LHNe2QTsB2c67IjhAcs8hpFeMludnOCFe198
	/y0anaj2eCy0TYJR0SiVvkib+GBlJm7rVLF9CPiIw5FJoeIn968x
X-Google-Smtp-Source: AGHT+IGDovZdlgBmcAC2bcCcTpreEMoPAy9xWW4vdpGDARNp9iaeOZMWNHMjKnjkRWNq6bMsXdtXrw==
X-Received: by 2002:a17:90b:10f:b0:2ac:69b:886b with SMTP id 98e67ed59e1d1-2bd9f4688c7mr887237a91.1.1716345568820;
        Tue, 21 May 2024 19:39:28 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b973234901sm14593157a91.19.2024.05.21.19.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 19:39:28 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com
Subject: [PATCH 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI host
Date: Wed, 22 May 2024 10:39:18 +0800
Message-Id: <20240522023918.7613-2-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522023918.7613-1-ki.chiang65@gmail.com>
References: <20240522023918.7613-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk for
asrock p67 host"), EJ188 have the same issue as EJ168, where completely
dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.

Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ef513c2..a0beb41 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -31,6 +31,7 @@
 
 #define PCI_VENDOR_ID_ETRON		0x1b6f
 #define PCI_DEVICE_ID_EJ168		0x7023
+#define PCI_DEVICE_ID_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -238,6 +239,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
+	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
+			pdev->device == PCI_DEVICE_ID_EJ188) {
+		xhci->quirks |= XHCI_RESET_ON_RESUME;
+	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
-- 
2.25.1


