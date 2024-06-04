Return-Path: <linux-kernel+bounces-200185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC8A8FAC89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 371DC283176
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524F31420DB;
	Tue,  4 Jun 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjDXtJ2B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921431411EA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487555; cv=none; b=mKOKLq2FFltjywabskOGqFl9+7afpyJe4vy1MX80WhMI7YOEPKuDCuO4zIPI3XqbD+EA+EAN2NrlcUyFFi7Poev57UAz5OKYKfhGs4Gl4DgDaZunzwVeGajl174RIdMPKXr0N5iCRDNZ644Q8AYdxFmlIY9Uo6jPOJlM0snXyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487555; c=relaxed/simple;
	bh=b3E/UIPslsT8I86wbPoMlWOJhjF5vCXYbMseh+Nd3tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwb+0HfxWmjorU7ja4Q2dyQC2IpQk2AiT6yd9OhBPR5AmtIzu084uWrMcH28bwrqTP+iu2uU8A1EOyyTr4V1J9Sf9sXFC/p87p4T9sev+4+mKJJ+vbIVBQUe3/87LO2B9Y2duTtCWgTM9RLB9DDp5NsP01UUO5hlxDgTdnclqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjDXtJ2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17191C2BBFC;
	Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487555;
	bh=b3E/UIPslsT8I86wbPoMlWOJhjF5vCXYbMseh+Nd3tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjDXtJ2Bnfn07g6X0XM+j297fga5v438KKDbcNVYwW2D+xQhMkkweVBBOq3AS1gnX
	 LAT0S0hHXiRAbW0abuhjIBsb7zRZd9Vov9GSssIzB5IvYRfy0nEstMHIRPPAskPjwZ
	 KPCRv+C8IrQHxklAXbga205F0kcrlnBKjckpEDIv6XiTukWD1DeFIjNuDugks8XN2e
	 +NAcE3ybEZRC3RsKxXDrnGMEICl+VqRqArskLYTKbqPdtGalr7LhEMxDRIXFolzZ/z
	 GvzdKSHVxQ/eknLuUFdKt8ZRyfKtv+2m3GlZTu3mNahck1+jtV4OGGQI18symujISv
	 W1td3s2pCk3Mg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sEOy9-000000005QR-3RBp;
	Tue, 04 Jun 2024 09:52:33 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 3/4] soundwire: bus: clean up probe warnings
Date: Tue,  4 Jun 2024 09:52:12 +0200
Message-ID: <20240604075213.20815-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240604075213.20815-1-johan+linaro@kernel.org>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the probe warning messages by using a common succinct format
(e.g. without __func__ and with a space after ':').

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/soundwire/bus_type.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 3979be0f8b65..43e732ca73c0 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
 	/* init the dynamic sysfs attributes we need */
 	ret = sdw_slave_sysfs_dpn_init(slave);
 	if (ret < 0)
-		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
+		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
 
 	/*
 	 * Check for valid clk_stop_timeout, use DisCo worst case value of
@@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
 	if (drv->ops && drv->ops->update_status) {
 		ret = drv->ops->update_status(slave, slave->status);
 		if (ret < 0)
-			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
+			dev_warn(dev, "failed to update status: %d\n", ret);
 	}
 
 	mutex_unlock(&slave->sdw_dev_lock);
-- 
2.44.1


