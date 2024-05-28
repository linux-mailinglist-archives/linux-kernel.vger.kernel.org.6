Return-Path: <linux-kernel+bounces-193222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7319A8D2898
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8CB1C23399
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E3413E8B8;
	Tue, 28 May 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ZYwygdX6"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97817C6A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937906; cv=none; b=B2eWqtyX4NSK4dKtkwMkAOxU26Eel/ut5ZHljVlJGWYn2PGuUtxZ7YmlW7pghD+dCHQpFqk5vFX/cU2i/YKPXWQGlanA4Obk7Oeb5toGFwHYR/j+eVYJexZ20QOoRQXZ4+NJw7v3RBw9RR2Q59NMZBtQCfl+nPlqCIe4LBHRXaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937906; c=relaxed/simple;
	bh=0Mw2bO5HPCwhV4h1bRRbWXQp2zclCNTEK4WzztmECcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nS8D0iLvQ4q22hT+ICChTNAYC1SZRfH5Ud4+FLKDCopTpsjJrOZmEW/JNfKd24BlY0NY++060xz4iPKygy8P6MWe4x/86v4hIA2T0vCtIDYMDe+cdV7yGB3CPV32lHGWffFUBLe/vt2a4VpzMk6BVtVtxOksrTkKIKNzkXVinLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ZYwygdX6; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=3wUIq6xPCIaufvK7kGIrfKOEwglQoa8/BC0hS2GpGnc=; b=ZYwygdX6i2mjHuOg
	9KAkc4OvywX8+xDgcmCOxN+z7eWExNP0nnHD5fKMFc8hBtgGy+nyJRuqLFqHkAwqw2LcsNl6Yd+z9
	kW/Sy63lqc5HDgarrxyxvBU17cRbOIgKXArVYLFrQQlpNtyT+Gb2lRMr8nqXZAFV876WSxwPt7o0Y
	s4uOVigETN4QRGUUgEK8SY269Ril3I7R+PwVQWeoAkjC4/JWQlxIvHhTn91MKokPTCV3r+aaXTMIO
	MeTDvToH4WnMNXtrfilC2SxhZSqtwk50mjclgxEb0KVpsF/a1OSMe144eWQhtSrtqjWTSoqZ0qUgB
	s8Mu1VNpSbowa92Ndg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sC5yX-0033zb-0u;
	Tue, 28 May 2024 23:11:25 +0000
From: linux@treblig.org
To: sean.anderson@linux.dev,
	camelia.groza@nxp.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] soc/fsl/qbman: remove unused struct 'cgr_comp'
Date: Wed, 29 May 2024 00:11:23 +0100
Message-ID: <20240528231123.136664-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'cgr_comp' has been unused since
commit 96f413f47677 ("soc/fsl/qbman: fix issue in
qman_delete_cgr_safe()").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/soc/fsl/qbman/qman.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 7e9074519ad2..4dc8aba33d9b 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2546,11 +2546,6 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 }
 EXPORT_SYMBOL(qman_delete_cgr);
 
-struct cgr_comp {
-	struct qman_cgr *cgr;
-	struct completion completion;
-};
-
 static void qman_delete_cgr_smp_call(void *p)
 {
 	qman_delete_cgr((struct qman_cgr *)p);
-- 
2.45.1


