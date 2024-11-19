Return-Path: <linux-kernel+bounces-415011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782D39D308B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E33B2347C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7CA1D4148;
	Tue, 19 Nov 2024 22:34:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A81C1F36
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732055662; cv=none; b=hmSJrAutyKnWB6hBlwGPYkL/9N7nTmW1DJ0YXy+7G1KpV5yDyRkeRB5Kq+fdIE6G6Fja/YhEy/LFwdekTq0HgRV3nlmQDFb/X4RDS/gHUE0oCxiIyjRikdaCMqtw3EIrArMosxoZcFAB9lgAm2IayviIt0hOfGJCIcrBbiEuEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732055662; c=relaxed/simple;
	bh=xo+f+Z/MbbmZhDhS+LV9xI5/rsuToR9buhsVAmftXS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBRzx+hn2Abpum/XaUoky+umIWuSv+y5migWtVCfwpEFG/nsQeM9CDt0BVxlRpTG8mJRs4b0dK6X90S2pMmMdE/KquUWOhYIKfTlxD6lI2H/G2awOvmaO62a50kS/uhIw+t8zjigWnKr64KOAzgIrHHcdMUGc7pfzKuzmueGBZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1tDWnF-0002gF-78; Tue, 19 Nov 2024 23:33:57 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 19 Nov 2024 23:33:51 +0100
Subject: [PATCH 2/5] firmware_loader: add support to handle
 FW_UPLOAD_ERR_SKIP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-v6-10-topic-touchscreen-axiom-v1-2-6124925b9718@pengutronix.de>
References: <20241119-v6-10-topic-touchscreen-axiom-v1-0-6124925b9718@pengutronix.de>
In-Reply-To: <20241119-v6-10-topic-touchscreen-axiom-v1-0-6124925b9718@pengutronix.de>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
 Danilo Krummrich <dakr@redhat.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.14.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

It's no error if a driver indicates that the firmware is already
up-to-date and the update can be skipped.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/base/firmware_loader/sysfs_upload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index b3cbe5b156e3..44f3d8fa5e64 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -174,6 +174,10 @@ static void fw_upload_main(struct work_struct *work)
 	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_PREPARING);
 	ret = fwlp->ops->prepare(fwl, fwlp->data, fwlp->remaining_size);
 	if (ret != FW_UPLOAD_ERR_NONE) {
+		if (ret == FW_UPLOAD_ERR_SKIP) {
+			dev_info(fw_dev, "firmware already up-to-date, skip update\n");
+			ret = FW_UPLOAD_ERR_NONE;
+		}
 		fw_upload_set_error(fwlp, ret);
 		goto putdev_exit;
 	}

-- 
2.39.5


