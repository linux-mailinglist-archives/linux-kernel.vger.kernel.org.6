Return-Path: <linux-kernel+bounces-551221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D031AA5698C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02911179862
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EF821ADAC;
	Fri,  7 Mar 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="AFjqASyS"
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C721ADC1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355618; cv=none; b=Rp5RsJw/kYRibCRJZ944Ex+LI22yistHqNyRkmP8nYTIHgIPg6nS1nI+vo31bWimFV1zcH02YyksAF+3bG92YHdtqEipgvPPzc1kxk31bTokC8mGpC1QyoJMAL8AV39knAtZM5Yrx4kHBgO1LW9wdJoPMruRpt3YAdAcXzI/o2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355618; c=relaxed/simple;
	bh=cUKKOBIA6AnCtzbT1MqxSkVVKShO6X5VCDkFmfJSlNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knENDcAQGYhmCkp2z4Irwa/uXzeVs1jYdLpxZdHWJCJIRWLp9u4S6Kg5hsMJ6GCiO9T6aPwuKPZ3UoAndV9//N9c0K5QCzrmqELhzqZhzCBt5+czSvr2U9fHrP1CHupV3o8jJhFyJi1fW0HWuMDt2ghyaCg5CdxWxFNo8/Hc4tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=AFjqASyS; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250307135325f67685f376872cb33d
        for <linux-kernel@vger.kernel.org>;
        Fri, 07 Mar 2025 14:53:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gTZ/5YY+d6HrO592o2qXwOahDlenU2BclkBMG+f5nAs=;
 b=AFjqASySXU/F7WaU3Wt0kAYT03HCFqwxmmlhBTDWDO4kifKJWVilYU/SOVdWYHMD/ZSZbm
 EBPKeN3e0ISGtrPTTnSJPmSOxMaq08UILbi+8Kijm9SI7s6RWxlmCLnlWfcSeqCkFUaYOJiZ
 LCsYzQFLW/ywcNNRIcm/z1+HsP0pW7JOGDaYnOG4Y6ROtjN5U3brenYOnKcamc+ZtMhTiWo4
 AAByvLuZVHQ+MIlsO3daK5L+Kn4muGfUGgx+IgMZpwmb4svtvxQbcQAuHFb6XlF9de5pMHVK
 apyzn+as1f5e/zEDJkm1eRlPG4QAq+rQ16G1n9CD2QxGdTsewx13BTvQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: devicetree@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of/irq: Refuse to of_irq_parse_one() more than one IRQ if #interrupt-cells = <0>
Date: Fri,  7 Mar 2025 14:52:18 +0100
Message-ID: <20250307135231.4080272-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

An #interrupt-cells = <0> property may arguably be a right answer for an
interrupt controller having just one interrupt and no options to configure.
There are anyway already existing examples in the tree, both in DTs and in
the bindings.

Now the problem is that of_irq_count() called on an interrupt generating
device having one of the former controllers as parent would result in an
endless loop. It's especially unpleasant in the startup where
of_irq_count() <= ... <= of_platform_default_populate_init() will silently
hang forever (unless a watchdog bites).

Prevent others from spending the same time on debugging this by refusing to
parse more than one IRQ for such controllers.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/of/irq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6c843d54ebb11..b3a359c7641d3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -381,6 +381,13 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		goto out;
 	}
 
+	if (!intsize && index) {
+		pr_debug("%pOF trying to map IRQ %d in %pOF having #interrupt-cells = <0>\n",
+			 device, index, p);
+		res = -EINVAL;
+		goto out;
+	}
+
 	pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
 
 	/* Copy intspec into irq structure */
-- 
2.48.1


