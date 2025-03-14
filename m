Return-Path: <linux-kernel+bounces-562252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C240A6201A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A868A4617AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B301CD21C;
	Fri, 14 Mar 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G/k4c3PV"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1C7083D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990644; cv=none; b=Im6JfmBKAJ2Sc4S9k7Ym/TSQrDtI8aM1CxF9K8wCge/G60XwMrqrxTetPweZ2kjzuQLoThNCszs/E811nwvs+synh7Rxf8eh3gpF6bjpJVGiRPGc6KfPl62rDsOIgGrR3K4lRjNXz1UeX/jQw37SsSvHfO0SpbkTZa8l2j/KeOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990644; c=relaxed/simple;
	bh=MCa0vkcQsABiNsiBneufPykvB8LMRiVfF0XBRX4jBKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+T/XiE0MOWPkta+qB08wKiAuF4rgDkp6zGXNwl/3Zx10o0qivWUdx3xZWIv4EEXxk3bDaz62EhhGA+d8E3bx3JH1YvdNrMaXOzyaR5YtbRRrdET8tyX0rQG7AynUmPgeoagKZlRYw1BxUtE2gKlkbl5/r12UX2jMoIKkCZwn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G/k4c3PV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741990638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8HlGgSem6D58B/bo6nzktQDox6aIVXarAjOGoDX+TIM=;
	b=G/k4c3PVyqfyZ6Mrqs/U03IIgxT0LRxq/dfHXWbxRJNEVstAjMA0jPIJWldHdOZgeeJKeL
	fTKEo/ZsJt6GyE8fcwRaAX69qT0khj7pVDT0RZrtZOBqPc96v2rwMbW259DOGlLs0G8UF0
	dHOx+eW6KNTg80ysTnj+tLCBJ6LZysw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fnic: Remove unnecessary NUL-terminations
Date: Fri, 14 Mar 2025 23:16:26 +0100
Message-ID: <20250314221626.43174-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strscpy_pad() already NUL-terminates 'data' at the corresponding
indexes. Remove any unnecessary NUL-terminations.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/scsi/fnic/fdls_disc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 11211c469583..7294645ed6d2 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -1898,7 +1898,6 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 	if (fnic->subsys_desc_len >= FNIC_FDMI_MODEL_LEN)
 		fnic->subsys_desc_len = FNIC_FDMI_MODEL_LEN - 1;
 	strscpy_pad(data, fnic->subsys_desc, FNIC_FDMI_MODEL_LEN);
-	data[FNIC_FDMI_MODEL_LEN - 1] = 0;
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_MODEL, FNIC_FDMI_MODEL_LEN,
 		data, &attr_off_bytes);
 
@@ -2061,7 +2060,6 @@ static void fdls_fdmi_register_pa(struct fnic_iport_s *iport)
 	snprintf(tmp_data, FNIC_FDMI_OS_NAME_LEN - 1, "host%d",
 		 fnic->host->host_no);
 	strscpy_pad(data, tmp_data, FNIC_FDMI_OS_NAME_LEN);
-	data[FNIC_FDMI_OS_NAME_LEN - 1] = 0;
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_OS_NAME,
 		FNIC_FDMI_OS_NAME_LEN, data, &attr_off_bytes);
 
@@ -2071,7 +2069,6 @@ static void fdls_fdmi_register_pa(struct fnic_iport_s *iport)
 	sprintf(fc_host_system_hostname(fnic->host), "%s", utsname()->nodename);
 	strscpy_pad(data, fc_host_system_hostname(fnic->host),
 					FNIC_FDMI_HN_LEN);
-	data[FNIC_FDMI_HN_LEN - 1] = 0;
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_HOST_NAME,
 		FNIC_FDMI_HN_LEN, data, &attr_off_bytes);
 
-- 
2.48.1


