Return-Path: <linux-kernel+bounces-315296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C723896C095
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E5A2840FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0820C1DB55F;
	Wed,  4 Sep 2024 14:31:08 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8C1DCB2A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460267; cv=none; b=CxNH0WboT1+lpjC9jvM+T930tnQ9iZJrmo5icCUs+X+RV19wlGJHPvr1u2In0Par/+x/y0OZ0OF/wPasTdneCdehidHKCR3JBpN4wWL8gjiczN2fAJ+jOKCljq6irl8TBq2qOZ510d0GTrS2DsxSyYQkrjsh5k4GON/uNyDyBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460267; c=relaxed/simple;
	bh=PvIExtq/8JZw+HWVjYfMbNbIIf4VpurgjJG5pvlFfk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhOgGX1cu0ctzHl6r85VydXyYPPLkYOtkKbM3RWLYs9aI1fs1WxZXdmJ5xk2GIrPg1qSHjFjJjcF2co9fjxAfVIOWsAyBhJ44Htfe/HeaCW1EEckH6EyTaIflgtrfJftPHYwMSrx/KKaznC33AFYGl8MAaBNtVljgyIqC7xAhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:ef52:68c5:eac1:f6b5])
	by baptiste.telenet-ops.be with cmsmtp
	id 8EWv2D00A3m5in101EWv7F; Wed, 04 Sep 2024 16:30:58 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr24-0028JT-If;
	Wed, 04 Sep 2024 16:30:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1slr27-004MyI-AF;
	Wed, 04 Sep 2024 16:30:55 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Taniya Das <quic_tdas@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/4] pmdomain: core: Move mode_status_str()
Date: Wed,  4 Sep 2024 16:30:47 +0200
Message-Id: <18ed6fb2bb92860f3af1bc7e5e4a01e9dacf2126.1725459707.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725459707.git.geert+renesas@glider.be>
References: <cover.1725459707.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move mode_status_str() below perf_status_str(), to make declaration
order match calling order of the various *_status_str() helpers.

While at it, add a blank line for consistency among the three helpers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 912bdc131fc0e2b1..2233daaa4168be14 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3311,21 +3311,22 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	seq_printf(s, "%-25s  ", p);
 }
 
-static void mode_status_str(struct seq_file *s, struct device *dev)
+static void perf_status_str(struct seq_file *s, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
 
 	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
 
-	seq_printf(s, "%9s", gpd_data->hw_mode ? "HW" : "SW");
+	seq_printf(s, "%-10u  ", gpd_data->performance_state);
 }
 
-static void perf_status_str(struct seq_file *s, struct device *dev)
+static void mode_status_str(struct seq_file *s, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
 
 	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	seq_printf(s, "%-10u  ", gpd_data->performance_state);
+
+	seq_printf(s, "%9s", gpd_data->hw_mode ? "HW" : "SW");
 }
 
 static int genpd_summary_one(struct seq_file *s,
-- 
2.34.1


