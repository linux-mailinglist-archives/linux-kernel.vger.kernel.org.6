Return-Path: <linux-kernel+bounces-412546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C4E9D0A55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A32228224A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6A1990AE;
	Mon, 18 Nov 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FscPVe7h"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759E195FEC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915002; cv=none; b=Oyjgx+c1dumSRnO1uM7gmjhwCgyI/z6q+nnDnxh5lueWuQl5i0Lpa3jBvxowF0breAzRRjLU/lb29Pjg3O8Js+hwjxi6GYdqd22bJt+j89ESSZB5eN5XlsqhTr+OJ52hsf+i7mq1UuCx5URZbXgsClINFduUDxerwOE5ygPZNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915002; c=relaxed/simple;
	bh=f3o3098CzLZDUSZTfVt0VWZ3ZadIGqmHuY1Oegtq9dM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u6ATVAIVjrJtj99ED82hkLZ7rVDq8SfJ0YIfo9GrrDq55D436ih7pkNTEUqor+EdCJZHwJBAHRv+72baUT5bghe58n08QLE1k5CIPLV3SSAx4JxsmfeaNw1gzPu/c3wapa6D5Vzl+mA7KXixC9UIV2ZYYKtSftBcfPADDmSlJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FscPVe7h; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=4mLliVVW6iKzF/knQYa+1jIwAJwPns2cF/3h1Vv+nTM=; b=FscPVe
	7hhkydcZEDUwMG+waEjWQO34MFPUqqriDrdsi1a9sMTYwbpkfpSYrN0SMEoTYmUk
	q07IUE0NjY8yxgsvgRlfLaeufpSPfupt5m75xUeXi+SdVX83DJiOz+NCXrmHlex9
	NhLSns9tipuAdZKRqASyf3qfiPA/VClH7Dv3iZqy6olnvuUtX+IcETOltRlQ9zSN
	iposHpLllHC9JWFV6PW533ERc7d7stHGRUId5ABD5SWhmBsS6A+YFUkkmLvHJGcz
	lSNNq+5h+S95i+mOfSaMhVNl9R7RNdF+NueIgagkNBlT892RmIjJG17Kr3QJ45dV
	FdwwHpRB14eHczAw==
Received: (qmail 112590 invoked from network); 18 Nov 2024 08:29:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:43 +0100
X-UD-Smtp-Session: l3s3148p1@QLte4SontoYujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 14/15] usb: typec: tcpci_mt6370: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:13 +0100
Message-Id: <20241118072917.3853-15-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/usb/typec/tcpm/tcpci_mt6370.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_mt6370.c b/drivers/usb/typec/tcpm/tcpci_mt6370.c
index 9cda1005ef01..bc5fd2557e6f 100644
--- a/drivers/usb/typec/tcpm/tcpci_mt6370.c
+++ b/drivers/usb/typec/tcpm/tcpci_mt6370.c
@@ -11,7 +11,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/pm_wakeup.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-- 
2.39.2


