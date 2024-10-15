Return-Path: <linux-kernel+bounces-365078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485399DD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DDAB22125
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6069172BCE;
	Tue, 15 Oct 2024 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMNwVgC6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62FF231C83
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967517; cv=none; b=eruH6oOhu12Lc193AuuJOmFQLAWlVsFu4yOyGsHqzCYW1iv3QDqu622VxEM+MpJIprEoE7EO+h5biepxWpD7VpfDEp/LBfABh52tGIfUsuwoidHkodvym3dDdu9/2h0lnQFVLxFRaeda0F0sBJLxwtWYoi5vzPAEBQ9dOkH7c6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967517; c=relaxed/simple;
	bh=nr7vPqhNXyEM90Os8vUTn4xf6V8sQONXlgNQRwPAmic=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FtF2Nt59kmoHXEA+FG3q9AekCJ/0pOQ+kUkCSN7tJj0YWCBqbm7qMXg6uvsmKHUHFNecyjyYeSD2lLdxmdy2zlgeReZG2TaqcmfwjyCOmVDImz51UvQJfCflE/JxkE0cu0bPH+pjIfpNusvnc1XtfAkJx/6+5/rkEy558R9ZAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMNwVgC6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cf6eea3c0so11915405ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728967515; x=1729572315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Cq5fuPhEPF9ag2SmpAcodhv3GQamv100yrE+kyx8E=;
        b=bMNwVgC6BMB9JZzNzsNG/PiXHVRFhRBOmiNEXKdeMvHtDOCpm/crH3Q+J5FfNl6ZaT
         PQ1JLvyRveB05Spubm9ef/vpTnAVeZ4U87+6pfkw2k5XbeQJURopqCQBYML+tZm15z/v
         M7aPd7LVQWK5cs1xdB3mLgNg8gOVps7ck7uaB8DdAGvVs0DpPyiFnZrq7HPhP8majHJg
         akJk7jWNulq1fVWdyyR+tiAS+1ofLgaRX+PjLMKiQ1EA2k7Ftv1Vcs6QXwxRBrZMKQVB
         C0psq4alHk56tQ85BV82bouYHccJGwWQ4t8NJvBdTt00/u7auEeTURz1nC3/qRSu27XI
         il+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728967515; x=1729572315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5Cq5fuPhEPF9ag2SmpAcodhv3GQamv100yrE+kyx8E=;
        b=hfAnva99AcSGNHLp+eGmFrVWJ0bPYFP/jOlSw/rcFHISdbgQG2Nrfx5AqzYQ2ZDRUD
         8XxCKUs2xDOt2hhgkVRVgmtGirasKsTP5BtoVPfZmF6Y3HSJl3RxC54/r4WBP7gV+Zjj
         Q6MSR2zX/lHoZwwHRC40xFuTvlC+cXLXOI+8h/nhxo/xbwtHH5jiDvKRhsG/ARQFHkyS
         4FhHuWlwGnfbGSrEhvHx5GnwnTkWVdeam0hYP+t3bEreaYlCuyr1boPKnaTTvSY4JF22
         4d49G1dUCgAQXfjTwpsKWI5y7btjLwSjmXVarOKjDUCgvCbojuvhQmvGiRUzSlhkYtsR
         tBww==
X-Gm-Message-State: AOJu0Yy2XmZZmiok+aHA17h7LIrm72Mcq/q7UjGGaAqD54+7MH5aj8Rw
	370hd7+ROamRCnShmEBFfDsgCpu53LpAaH18UUCqz7GOz2DPm7dT
X-Google-Smtp-Source: AGHT+IEap8jxtB7gtd5ELzblEsL8eqtZ29+LWepnInI9qDW9UvDu4Xx8gtVbFal2p0kngcth3RbK/Q==
X-Received: by 2002:a17:902:cf11:b0:203:a0ea:63c5 with SMTP id d9443c01a7336-20ca131b66bmr194795635ad.0.1728967514697;
        Mon, 14 Oct 2024 21:45:14 -0700 (PDT)
Received: from august.lan (76-198-31-149.lightspeed.sntcca.sbcglobal.net. [76.198.31.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f87d2bsm3667325ad.56.2024.10.14.21.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 21:45:14 -0700 (PDT)
From: Abhinav Srivastava <atg271@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Abhinav Srivastava <atg271@gmail.com>
Subject: [PATCH] ethernet: Improve formatting of conditional statements
Date: Mon, 14 Oct 2024 21:45:07 -0700
Message-Id: <20241015044507.1177265-1-atg271@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve readability of conditional statements in the Octeon ethernet
driver by removing unnecessary parentheses and adjusting line breaks.
This change focuses on three functions:

- cvm_oct_common_change_mtu()
- cvm_oct_common_set_multicast_list()
- cvm_oct_set_mac_filter()

The modifications make the code more consistent with the Linux kernel
coding style guidelines, specifically in regards to the formatting of
multi-line conditional statements. No functional changes are made.

Signed-off-by: Abhinav Srivastava <atg271@gmail.com>
---
 drivers/staging/octeon/ethernet.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index a5e99cc78a45..77044b7b40da 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -248,9 +248,8 @@ static int cvm_oct_common_change_mtu(struct net_device *dev, int new_mtu)
 
 	dev->mtu = new_mtu;
 
-	if ((interface < 2) &&
-	    (cvmx_helper_interface_get_mode(interface) !=
-		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+	if (interface < 2 && cvmx_helper_interface_get_mode(interface) !=
+	CVMX_HELPER_INTERFACE_MODE_SPI){
 		int index = INDEX(priv->port);
 		/* Add ethernet header and FCS, and VLAN if configured. */
 		int max_packet = new_mtu + mtu_overhead;
@@ -294,9 +293,8 @@ static void cvm_oct_common_set_multicast_list(struct net_device *dev)
 	struct octeon_ethernet *priv = netdev_priv(dev);
 	int interface = INTERFACE(priv->port);
 
-	if ((interface < 2) &&
-	    (cvmx_helper_interface_get_mode(interface) !=
-		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+	if (interface < 2 && cvmx_helper_interface_get_mode(interface) !=
+	CVMX_HELPER_INTERFACE_MODE_SPI) {
 		union cvmx_gmxx_rxx_adr_ctl control;
 		int index = INDEX(priv->port);
 
@@ -346,9 +344,8 @@ static int cvm_oct_set_mac_filter(struct net_device *dev)
 	union cvmx_gmxx_prtx_cfg gmx_cfg;
 	int interface = INTERFACE(priv->port);
 
-	if ((interface < 2) &&
-	    (cvmx_helper_interface_get_mode(interface) !=
-		CVMX_HELPER_INTERFACE_MODE_SPI)) {
+	if (interface < 2 && cvmx_helper_interface_get_mode(interface) !=
+	CVMX_HELPER_INTERFACE_MODE_SPI) {
 		int i;
 		const u8 *ptr = dev->dev_addr;
 		u64 mac = 0;
-- 
2.34.1


