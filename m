Return-Path: <linux-kernel+bounces-185697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219238CB900
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA221F235A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935B43147;
	Wed, 22 May 2024 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYsJSkFL"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8662868D;
	Wed, 22 May 2024 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716345566; cv=none; b=YLK0/MpNvI3jwDvBQTyhFqG+dHsdd4AXy6EXMLNPVGmks+RZmDGM6779QUzGbFt4Gcj17bVA+koWMmtIH8O8v6smOG3b9xj7B6tc3Z9InvuO+Vs/JaFXFlortmyfZynM8vTy4vcaWKNQLiyT3l9pdFLDkL8LfUlsTF8hiAzwS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716345566; c=relaxed/simple;
	bh=h2HgAoSFoJiHImBeydoLp/n4ksxfUd81iZib2AUe7so=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dpDuT33WJpGZ2ez7OVz6U1VWpIsxfx22ejP9dqHzeTy0iULOr7xrBkHOQwTvvqJQwB6G99QIZZ+gUSh8q//Fi8fBz8llXp0lTY6wRcHuo6Lpl3t10XCJkVoVfZ5J9zmbbxcLEFppTSCvGgoCczYezCF9mbmYWSq8OPM3s30sjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYsJSkFL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ba068e59f7so137173a91.3;
        Tue, 21 May 2024 19:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716345565; x=1716950365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0Cc6f8Wxbw9qk7J6AWYBvS+QsWTsyrW1OOHPqmY5vc=;
        b=HYsJSkFLqpbOA6SV9hkK6ikuI1fjO22UhBb7pulXytyyAcE8iK0jTScNozUs3RBM0f
         l/m1r67CSiDrRDQf1NsZo245cjMGb4soUx11O98jmm+QQszZ+Q78k9EgrqI1CdHfrXL0
         yVZORQu66/dZjG/JzpRYahpJsJbVPMxLUajWYiWakiWXbYwJTJhKKzcLqCMmN9Npy8Ca
         +vwD63WZ4ScsA6t1EjwLl0ujXSnF+IvbSmSKxvggaaIPnoRB+1DKOFeZhJ9FdQTMWPOl
         em9cyD50y4cIuNjwYlMRbC+Ruu2BcuCCUJoiPcdml8d2dva3af9hhKXlmDD+ipDSzdeO
         boQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716345565; x=1716950365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0Cc6f8Wxbw9qk7J6AWYBvS+QsWTsyrW1OOHPqmY5vc=;
        b=Z9joSt1998DrlYBqMhgXHQsP5ptDbebHqQY7s3X/YLaFW/6LfpAcRKvnI1/U93ssbD
         SIWgo5RdycebuUj0l6RHsgcvEPOSe8qCdYkYEMVdNCbbNRIGcppp3cG49nm9HbXnzYHo
         jl6iP80JXZAN5GIpG04J/yTuCrVeIth6ZeCaDRDN1QTdC20T1OVH8j1xzl/xUgwqDUhy
         L5H9BcHFI8GRQlsizikj1KYQA5DgQhNdEsxuwOnHhsvXfqhK/af92AWSC/RIlFt283TE
         9Q4MILc27G3Umy3GqGEJSQegci553lKK6pZCyPyaE7d/khbOrklnS/8vxnEBEAuZYEgo
         VoJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2+KCJgLri7pT/L6tFB04k1iaj5AEpLCns1g11eLqvDgLS483uCk9WA2wBJcf7YAxmkxmMXs4sC6MZ6iw3gI+ppm4aigF4yBQhEj0y
X-Gm-Message-State: AOJu0YwxfVKgjrjAAxNum7Bww7JdWun2XkKvThOQ7G8kzUqGnb1pfzdI
	ORd/aedZ1afqQ9G53gyGVmzwA1Pr70DDkxpICaQe3Nv0Oooxr6aSdokodRyr
X-Google-Smtp-Source: AGHT+IH/kX3lRWAD201VbcdYkNrmRRoPW15d/qI3S5WKDwdT5C7Y4Y2iKk6oF0TWC2T+dABWxCju6Q==
X-Received: by 2002:a17:90a:f492:b0:2b4:329e:eac5 with SMTP id 98e67ed59e1d1-2bd9f5a179dmr849427a91.2.1716345564724;
        Tue, 21 May 2024 19:39:24 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b973234901sm14593157a91.19.2024.05.21.19.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 19:39:24 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com
Subject: [PATCH 2/2] xhci: Apply broken streams quirk to Etron EJ188 xHCI host
Date: Wed, 22 May 2024 10:39:17 +0800
Message-Id: <20240522023918.7613-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit 8f873c1ff4ca ("xhci: Blacklist using streams on the
Etron EJ168 controller"), EJ188 have the same issue as EJ168, where Streams
do not work reliable on EJ188. So apply XHCI_BROKEN_STREAMS quirk to EJ188
as well.

Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a0beb41..5591e6d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -242,6 +242,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
+		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
-- 
2.25.1


