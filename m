Return-Path: <linux-kernel+bounces-417407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 125DB9D53AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650C7B209E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B894B1C8317;
	Thu, 21 Nov 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/16Svf0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED113C3D6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732219092; cv=none; b=TYEs/q4g5QIP3oESAV9afIvE0H9ap/2aQf2Jkph6Hs/ujdAkPfmxBny7Zi9GZ5Aa513V7g7XlLA87V8dmqE1Tg1yl4LynoOkej/YlW1qEyeJDD2+5MI4OlEcCUycjVj9/uR5aBS5Sf+OD3ftbh1PK1Z+6ZA0vspE6Sx0mvWUyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732219092; c=relaxed/simple;
	bh=Ci5rgaKMcbABvz0Hq2okBdlgbreLxrd9dmDVHdg4jHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSK0Ea2wP17GbfyKSUTFQ5vFo9D3WC8MTVXMTSlZFIl/goe2VTzmdBKFKlMpMTCZPrJQZb2aVc50PzeJWTlaXocdai8FaPmt4QwZ/WUMtB3oAIuNTbG2QBPG5ou8wgBmUGm+BghygE9YjqNLAIZgRI4lK+ddVKfPXmpr0ArEz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/16Svf0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732219089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=juFFITBwgxbTeEGzKvrIeAZUrlzxGf1mZ1vezYeX2J0=;
	b=Z/16Svf0R8ThKY3Z4q53UGRjkRKd0aYLm0z7dTnDI1vBlzhjuD+IacVS5fPGhlkgfsHT99
	C6D67VXgJjUvq7A1WGEse8KH7OnYhwIvQfyn02tqZmYjLePCIw4fip/Ccaux1KYmXVH6AW
	ZsZ2SiE9fDwBMV8LhGExj2Pk5U1+NBg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-2pHAeHQmPamg41BoqhOqSg-1; Thu, 21 Nov 2024 14:58:08 -0500
X-MC-Unique: 2pHAeHQmPamg41BoqhOqSg-1
X-Mimecast-MFC-AGG-ID: 2pHAeHQmPamg41BoqhOqSg
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2fb3f99c9a7so9977801fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732219086; x=1732823886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juFFITBwgxbTeEGzKvrIeAZUrlzxGf1mZ1vezYeX2J0=;
        b=ONxBkpp1+WHaF1Q2NFC1ht3FjZk0mF8cauKxDNUh3+JEiQuOyTziropiekftRCF9xz
         lkjIgjDdT1DI2GXtIqfnKV43tSc4fhg/BqxEDLbVhPH63AZg+szRHH7rpCw3SsiniN6r
         Gx/tXCVWUbNzML9mBHeeu412CtFqIDfnV2AhQAFnZx8hRllrzCtn5Pltk4R01WVrGpn0
         GlVEJqK89EVDCHw6Dh2exp14CDTSXF8vycA8qXj5jUMbcnHK4dlJn+/XjtMTl+qTfb+g
         Qq48lH6AJQQad1Xe+2S+D0Yx6NuNlM+gfl0WNwY614plEiv9nTOL8wXtj3dVeLStKVl9
         mMug==
X-Forwarded-Encrypted: i=1; AJvYcCWEs+tuRDz10/+YS6aTUOJg1bwt6krZU3did0W2rEuKNyzcRGcjO7V98SFKoPHxLlil98Lc2PZV579r7bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAqSxJ5ADZ5BuocnC7M701hpX4HitTNvkm7Mp0EV6QJvUCCoGc
	N+vATfPfmvhdPGAKIH1wxFwLdESl00ziS8XojmZPs6hg+d8mu13M/+Fcg6+3Bdeea7vnvq/K+L6
	erpjGEC/B6UGbG4dOs3YyxYMysiuTVPvjgDP2QY4QoEE3bU3DfIAG5vz7HRRVjw==
X-Gm-Gg: ASbGncsisduWIN1Qc86mQiAmeKQgmOpecH8njAFIwaS4LzzpUA6L04UA9JcrtmoYYYR
	MZbTYPm8h2s/QVkADwwHJtoOtvCQXyNX7hyIjotv3fEIvcgmuUVI7C1YacUrNbJ3OArAgboQ3PU
	uv+pBq8OiF7PS3Us/m6Y65oSGwoscFyvEmVWch2xo50winpDXxAoHHVmKGWpG8agZ1eBeLEOqkf
	MtT/az1w+JNjjR1dfRLJGfrC3cTGmr0WI1JOSDxIvaE8q0TJ3tN27kmG81n1Ys=
X-Received: by 2002:a05:651c:2106:b0:2fa:c014:4b6b with SMTP id 38308e7fff4ca-2ff8dcfeeeamr43367191fa.41.1732219086540;
        Thu, 21 Nov 2024 11:58:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHld/7g4KDxVVzct+EU5FiZIyFo1DaNYX143LVFTQdBZBW+2hhFCe7EG9OaPHgNPlxajfp9pg==
X-Received: by 2002:a05:651c:2106:b0:2fa:c014:4b6b with SMTP id 38308e7fff4ca-2ff8dcfeeeamr43367091fa.41.1732219086170;
        Thu, 21 Nov 2024 11:58:06 -0800 (PST)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:3400:37d7:1f36:6e6a:3d66])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d401f64sm119592a12.70.2024.11.21.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 11:58:05 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] i2c: i801: Remove unnecessary PCI function call
Date: Thu, 21 Nov 2024 20:56:25 +0100
Message-ID: <20241121195624.144839-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the changes in

	commit f748a07a0b64 ("PCI: Remove legacy pcim_release()")

all pcim_enable_device() does is set up a callback that disables the
device from being disabled from driver detach. The function
pcim_pin_device() prevents said disabling. pcim_enable_device(),
therefore, sets up an action that is removed immediately afterwards by
pcim_pin_device().

Replace pcim_enable_device() with pci_enable_device() and remove the
unnecessary call to pcim_pin_device().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/i2c/busses/i2c-i801.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 299fe9d3afab..514d3f8277cf 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1676,13 +1676,16 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!(priv->features & FEATURE_BLOCK_BUFFER))
 		priv->features &= ~FEATURE_BLOCK_PROC;
 
-	err = pcim_enable_device(dev);
+	/*
+	 * Do not call pcim_enable_device(), because the device has to remain
+	 * enabled on driver detach. See i801_remove() for the reasoning.
+	 */
+	err = pci_enable_device(dev);
 	if (err) {
 		dev_err(&dev->dev, "Failed to enable SMBus PCI device (%d)\n",
 			err);
 		return err;
 	}
-	pcim_pin_device(dev);
 
 	/* Determine the address of the SMBus area */
 	priv->smba = pci_resource_start(dev, SMBBAR);
-- 
2.47.0


