Return-Path: <linux-kernel+bounces-427230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DB9DFE5F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0882809A7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD6C1FCFE5;
	Mon,  2 Dec 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ4CyjQx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0E1FC11E;
	Mon,  2 Dec 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134069; cv=none; b=ggQ5dBsWuz7VnPqpZnrTe6JmHpF3HrNcxcvqGp9HiWvaY5pmVlMqveGNsapZPC7R8t/5Fmo3ff6C9kMByXjnmCpyPkUlOEp0KxosRaqYGRWqyzz9xxMJ6sQPI3Pqv9G3zCS4akrrEAMjIrcGxQCbS6pDTSJ+Fkc0P+u/9DWp8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134069; c=relaxed/simple;
	bh=q6a8y5F/7qxUW4GnoosIz5h3c/BqGka4D1h+YEyYgdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTckX1OwnRL92/FBjJ1PUMQMCntV/34rNmShCkVi6kToYb4dh48041g9Snp5HYLPMZ9jMPD5ESS20nliOeTQOuGTQez+8GoeKL05kguaR9jyNOz4E+7myQdG1y/dJ+VOIqEKQIu45GIGHEGNZIFPr/nUXS4/LHP4Aw4UQRZtivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ4CyjQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F81C4CED1;
	Mon,  2 Dec 2024 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733134069;
	bh=q6a8y5F/7qxUW4GnoosIz5h3c/BqGka4D1h+YEyYgdE=;
	h=From:To:Cc:Subject:Date:From;
	b=eJ4CyjQx+TkM8o+DubdoG6ZI4p0b8XTvysQ0H3ecC8OcApgQix6KYAQv7n1ppdnyD
	 CiBcNz4WW6bMR91QQbAf5rfO1Ef0ge8XZ+Dd2Bi3mAoHSgvsd+GQU9qBqETG13MVXm
	 fX9z9tRUFKe17bDwxdWMxABKmKOxzeCF8KTaUhKZaEhFR5J+J4hswC3sait9YpysXu
	 Xju1HvbBNsJkJN0sqn4+ZbeKuofiMNVds7NYWB/gRaytSEr+v5qb43Hiqi0ZfamDZa
	 zDeHxFTTdtFdrpWtX7vsE6El+wApcjL6UgR7/WzSTkonG5zZgXYWsmOxQB7tdTwRNo
	 m++ASNsFSxyHA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tI3LE-000000007cn-3BK9;
	Mon, 02 Dec 2024 11:07:44 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] Revert "clk: Fix invalid execution of clk_set_rate"
Date: Mon,  2 Dec 2024 11:06:21 +0100
Message-ID: <20241202100621.29209-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 25f1c96a0e841013647d788d4598e364e5c2ebb7.

The offending commit results in errors like

	cpu cpu0: _opp_config_clk_single: failed to set clock rate: -22

spamming the logs on the Lenovo ThinkPad X13s and other Qualcomm
machines when cpufreq tries to update the CPUFreq HW Engine clocks.

As mentioned in commit 4370232c727b ("cpufreq: qcom-hw: Add CPU clock
provider support"):

	[T]he frequency supplied by the driver is the actual frequency
	that comes out of the EPSS/OSM block after the DCVS operation.
	This frequency is not same as what the CPUFreq framework has set
	but it is the one that gets supplied to the CPUs after
	throttling by LMh.

which seems to suggest that the driver relies on the previous behaviour
of clk_set_rate().

Since this affects many Qualcomm machines, let's revert for now.

Fixes: 25f1c96a0e84 ("clk: Fix invalid execution of clk_set_rate")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Link: https://lore.kernel.org/all/e2d83e57-ad07-411b-99f6-a4fc3c4534fa@arm.com/
Cc: Chuan Liu <chuan.liu@amlogic.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

#regzbot introduced: 25f1c96a0e84


 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0d5a2293a8b3..936c0b79c169 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2539,7 +2539,7 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	rate = clk_core_req_round_rate_nolock(core, req_rate);
 
 	/* bail early if nothing to do */
-	if (rate == clk_core_get_rate_recalc(core))
+	if (rate == clk_core_get_rate_nolock(core))
 		return 0;
 
 	/* fail on a direct rate set of a protected provider */
-- 
2.45.2


