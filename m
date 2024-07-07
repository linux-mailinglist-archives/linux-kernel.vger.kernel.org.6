Return-Path: <linux-kernel+bounces-243590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B420192981D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 15:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64082282242
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFEE1F934;
	Sun,  7 Jul 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="QMPzPjEp"
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13C1CFA8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720358645; cv=none; b=IYw68Dx91zhLDjKNt2mXx71aSMRsrB3fdzGil7Vr0Aq9v13qfL9sjyB4m+mnGLCE2nR9D4dTTMvVe7npL3mjjLSzRW9LiuU80016hl5gH3ZyzBMXwd9yW2lLXJ7ae/l5RgYBp7A2MAPlPQllYo8FMOGpbCq30zlLe69G05OC+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720358645; c=relaxed/simple;
	bh=hOtfMf7YITsToXKe0Sm30k+rl8ivMg9h0b6/sWLTt3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Drr5yrl/NkMXODPvwC9ancUiGkg/LA9YWY31xp8j+kUBT18Gr7T0jeb3+FO7GX+rkERwLGQBTssqs2QbjQvVT6/Pp6iBS36IJ7/rhX/NBgskwM499iEHyhczpBzQ7w1MQfCo+Xzt7OlsFelD01G4vs1gttkVMOvX+f58DMjSwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=QMPzPjEp; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1720358643;
	bh=SXMLlX0Aj8KdHWLHBTcDsTgIPAEEfy0Fi8U2zAC91Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=QMPzPjEpjp4kSVn/xBw2RTh8AgajxLPAPGg0Hd3g64fNdGsphCGWUkVUiRQOI3G77
	 DMeQ5KJHB6DFzZG2oOu18BjZjE+2LWBHs4hp5nTzI8nIXZL28hWf1EYpxt0mQ/5RXw
	 iaIceUt9IfsCLTAYPDu/QO651W9noIdQPFKyjeXxApKOWyJhrgsSdtmDGKFhMgO8xM
	 UZedDVfMBoYzY5VfjAojr6XS6eS1xjhn/pElrydGykHvY4OwwMOVBcbEFw3F164Llj
	 2aBNG02buYsVEzt07WKPj8xwyF9Re35dfEq11cO8cbUFgWcQCO3mopsAnvLaVbGaix
	 n6UordDi4zM8A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id B1D6768008D;
	Sun,  7 Jul 2024 13:23:59 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 07 Jul 2024 21:23:15 +0800
Subject: [PATCH] driver core: Fix size calculation of symlink name for
 devlink_(add|remove)_symlinks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240707-devlink_fix-v1-1-623acb431cd8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMKWimYC/x2MQQqAIBAAvyJ7TrCwpL4SEZJrLYWFggTi31s6z
 sBMgYSRMMEkCkTMlOgODG0jYDts2FGSY4ZOdVoZZaTDfFE4V0+vVN7qwaHzOPbAxROR9X+bl1o
 /OQI/C10AAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org, zijun_hu@icloud.com, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: lV9OVF1A11SGedNhLxWxen53mteYY7_2
X-Proofpoint-ORIG-GUID: lV9OVF1A11SGedNhLxWxen53mteYY7_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=759 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407070109
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

devlink_(add|remove)_symlinks() wants to kzalloc() memory to save symlink
name for either supplier or consumer, but forget to consider consumer
prefix when calclulate memory size, fixed by considering prefix for both
supplier and consumer.

Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..f14cfe5c97b7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -572,7 +572,7 @@ static int devlink_add_symlinks(struct device *dev)
 	len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
 		  strlen(dev_bus_name(con)) + strlen(dev_name(con)));
 	len += strlen(":");
-	len += strlen("supplier:") + 1;
+	len += max(strlen("supplier:"), strlen("consumer:")) + 1;
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -623,7 +623,7 @@ static void devlink_remove_symlinks(struct device *dev)
 	len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
 		  strlen(dev_bus_name(con)) + strlen(dev_name(con)));
 	len += strlen(":");
-	len += strlen("supplier:") + 1;
+	len += max(strlen("supplier:"), strlen("consumer:")) + 1;
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf) {
 		WARN(1, "Unable to properly free device link symlinks!\n");

---
base-commit: c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
change-id: 20240707-devlink_fix-0fa46dedfe95

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


