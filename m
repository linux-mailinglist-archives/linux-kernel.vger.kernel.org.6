Return-Path: <linux-kernel+bounces-384512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5449B2B17
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69721F21BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836BE193067;
	Mon, 28 Oct 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX+Yh9aY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E4F192B76
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106808; cv=none; b=X/S+LoyYHmKocLcf3BvtLufUXEkecpFNv+Pdwd+4f9NFgk6M4aUC+F+GX1IbN2h4f2TdqPVYZEQBgNeAtBv7JeqzR44J1ubk3rdHbbZDqa0Z3PZT1CrOJGT3M4A6Fiwm219Ly2k/xdw5YK2XHZTerNKs361ihbRUBuh/SdAWn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106808; c=relaxed/simple;
	bh=G8mQbc6rB6Tph32tQsb7U/J0yIX1zGT8Ftv6HRDkbiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYRCeOzYfFuMstcD9hjdspZrL6aPYIrGjsRArkbEjiDeHF0FxiuUrMz2fqFBigsfgM9rHCfFtFwMO3OtqZ5kmZJ7rstBGWvxZCegEGW1bsb2tldZHCXiTWhKAez4LrKhTT4HxYcXZwcdyLi20UCPrYjorhOb199e5wAxfNssPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PX+Yh9aY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730106805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8mL9AnFpvR2FSeyCUCVsZyVlwtWLR5Tt1r0vRldbLhI=;
	b=PX+Yh9aY93BLzeXgUhfiNbLBECexVS8Tr3D6x/CbNTD7svQAX11A7vH0Ari5t9Wq0Exp5z
	XcLt8i6gUaGr87Im2vpUWy61xp22/OWyTnq435jlDIYznvl2bDcu/HjyQkv+kVSzbkPtZq
	mkCbGw17XmME3I4AcQgIbmM95Z6lmWI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-iN2oMK7qPXmAKWZK3MjTfg-1; Mon, 28 Oct 2024 05:13:23 -0400
X-MC-Unique: iN2oMK7qPXmAKWZK3MjTfg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4314f1e0f2bso30191405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 02:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730106802; x=1730711602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mL9AnFpvR2FSeyCUCVsZyVlwtWLR5Tt1r0vRldbLhI=;
        b=su0SIJ4jw2USfj7P4iqJGfs+fBWniaiAi/8ZOJU0K8o6LiPe9osWAaF+WOputrjXR5
         c+S6yMH5A54nt6wLXj+FbZ0pkCNtOXDNLCM7ddYVu0JdHFcAYXZJqnnAreekzufqOrZn
         XuET6497VlO1Xl8a01x/lF98jkP7h8hFw5WmWm8/iHlEIjHuMxmRJ8txBvVOU32JlApN
         u/LctOPh3A+XXWSQ2ZdhnAFvDQU6FFveC4uSjFpUZxu5vleJUOO5GPvpd/GCErExZEgs
         8HTJUxfn1hR9n874CCcFCOIpaHyLhxMJczg9vyfi8udUWz3vuq4Ll7ksQf7NuTm3zP4H
         es5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMAaK1JalmqkVCcZ/LUWknajMkLzln3FtfCyemw5Zb7/604fGx6hDqGW3AnQiJBRZaGcr4U2NZt/pnqHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdDXwFHxMuDK6SQGc3JRv808eTIb5WYUjPEML0vc8ne2rjggB
	1SM/P01TKy/QpqW8WACjE3eMIbe8Ou9KkwZsv8LcXv0ohG1AUXqvPuLldn9Ya4UyVUTlmN02TZY
	KqGabeiYXhWIFJ6y90+cfH6ERMx8ow1N3ZwrL9jH5LZMbn6j41TP6YmTfXuemoA==
X-Received: by 2002:a05:600c:5110:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-4319ad36874mr70631555e9.34.1730106802226;
        Mon, 28 Oct 2024 02:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLRTeEMPXMzQVxdxTiM2sxZawcWWohp2DQMruQZSAWoGfBb8mhKObRqq9Iqzltt0ErRbieg==
X-Received: by 2002:a05:600c:5110:b0:431:54f3:11b1 with SMTP id 5b1f17b1804b1-4319ad36874mr70631245e9.34.1730106801644;
        Mon, 28 Oct 2024 02:13:21 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935a5921sm104543305e9.28.2024.10.28.02.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:13:21 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] counter: intel-qep: Replace deprecated PCI functions
Date: Mon, 28 Oct 2024 10:13:13 +0100
Message-ID: <20241028091312.17045-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

Replace these functions with pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/counter/intel-qep.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index af5942e66f7d..ee2bae27b728 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -408,13 +408,9 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	pci_set_master(pci);
 
-	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
-	if (ret)
-		return ret;
-
-	regs = pcim_iomap_table(pci)[0];
-	if (!regs)
-		return -ENOMEM;
+	regs = pcim_iomap_region(pci, 0, pci_name(pci));
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	qep->dev = dev;
 	qep->regs = regs;
-- 
2.47.0


