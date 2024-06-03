Return-Path: <linux-kernel+bounces-198946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B508D7F90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDCBB25411
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528D82872;
	Mon,  3 Jun 2024 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTOz1gzZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9629A82488;
	Mon,  3 Jun 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408835; cv=none; b=pSy+urC5ejJGX2G+6xPBxLLgKvdEo1qKb+18CJFtEb3RvigsNOh/dsFgU51UHlJsPgNCgv+tiDHqc8l4Bs2S3kyywpsVvWqhIu/ZYIR4JLknVr72hfFfW5W7xzJq9SZkJ/8+JEd3qQg0I0gA0GiX26+zjz6tDIdDVrE8mRLarwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408835; c=relaxed/simple;
	bh=zphN7mY1rk9z9RMfM8gHUHec+O6NyV8ZCJII5Fn/MOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6nyn1wLcnEsd59WuKnYfZslKAzXZvjsyVSsT7/WrXYJDFZJRUKDADSxFOpqqI1zJHOwYOD23Hj6FD/Gy800FwkqTxYq52is6NoHaUi+4dJU78rSgVaEOsHCOw5KTWvc8DN2bciROj75++TDZtF6zv6ReEkH3h3nkSZLklShuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTOz1gzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18747C32786;
	Mon,  3 Jun 2024 10:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717408835;
	bh=zphN7mY1rk9z9RMfM8gHUHec+O6NyV8ZCJII5Fn/MOE=;
	h=From:To:Cc:Subject:Date:From;
	b=WTOz1gzZa0+wtxvoGn47PPKoTBElZpJ9DkWbnK9XzbINBL0yHQsVQjZEAN7YlyQoM
	 PtIyXKIELWo0WB91kXWM3rFD3zmJzI1z0sRg5YIN02tlqr9a1qAnwJHp+4aXWWmBP5
	 5glhU9D3088QOkb/CLEh5oKEZlaaDHvJk0koy8pnZGQQCG7EKx2PKnZHM23+8ss7D8
	 7aWziBJAhKmlmlDL/AnQT/YtbSOX5ocnrMXAtvlV5pZD02gwHusnvCaoSMuxT7eJJR
	 d8YE43PRBj1IdyNrOLmFeUa0c2A/6xktc5EsUTND+v/lGewF4wWhnkqGKfVquPCDDQ
	 fQdI0d+ACMTig==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sE4UT-000000002fY-01OD;
	Mon, 03 Jun 2024 12:00:33 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] usb: typec: ucsi: glink: increase max ports for x1e80100
Date: Mon,  3 Jun 2024 12:00:07 +0200
Message-ID: <20240603100007.10236-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new X Elite (x1e80100) platform has three ports so increase the
maximum so that all ports can be registered.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index f7546bb488c3..985a880e86da 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -14,7 +14,7 @@
 #include <linux/soc/qcom/pmic_glink.h>
 #include "ucsi.h"
 
-#define PMIC_GLINK_MAX_PORTS	2
+#define PMIC_GLINK_MAX_PORTS		3
 
 #define UCSI_BUF_SIZE                   48
 
-- 
2.44.1


