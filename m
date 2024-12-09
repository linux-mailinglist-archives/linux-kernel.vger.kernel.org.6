Return-Path: <linux-kernel+bounces-437677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD769E96E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E40B51616FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B831B0416;
	Mon,  9 Dec 2024 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rmtwx3AI"
Received: from ci74p00im-qukt09082501.me.com (ci74p00im-qukt09082501.me.com [17.57.156.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB11B040E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750765; cv=none; b=ZgjRW46Mhvhmqu8V9yRJhOugJD/awWn5rJ9jfm36H1iyUEMjNA+SpioAz0lw0OxNJw9gFtUPaPeQB9hqPCred0dDivxL4mIcmjGzKEHt3UwF/oxRZHpNygFpy1aeYswXKit08jsoe0qrB2qV6qoeUpFg1sLtQLJk7+PYxhzvAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750765; c=relaxed/simple;
	bh=lunfMj+OkQF1YbU/Hvegdk+70uQ6ogQFARMPAWKoCRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqwtrhQU1uBFY6mcFwJwtm7uTt3aHaFGFitB4YGM8V1yTqhaRJv4c2YOv3RpiqN+bXcgWYD8RgO4LVso7twN7lI59VRjv2H4T04ga1wMO8wi21+EhWLR7KU/vzBNQSmhFesEaqt7fl+cPVYPtfLIh6KaIH5TgoGl1T+6buPAo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rmtwx3AI; arc=none smtp.client-ip=17.57.156.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733750762;
	bh=4VVA4adu+gEU1vT76JzxHosCOPZrovp9nyCp9xo0Oyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=rmtwx3AIgG9xuJV+aEqXgTvzQNj0F4zHLYHsyL/ZrxWSLOcWMC+EZvEV2bQQJOVac
	 sP9m8ZzkI/Bk9LrpJ3yfx7Ck4uLzMr8kxHVHQhj2vQMNCxXV/EPeirGMS1laCirkN9
	 qYqcQqc/4d89E3RJ4K0/ausS1JHTA+hgy8LIpJRls29O66fgAdYQelvvWeBqspLAR3
	 qGD2LYNh+LLMdsWi+KuGWoPMv3o+iKcOdVD85+SumsSBTSiH22/X03jANFhrs9gkfm
	 7J9qB6udI9J/QrFWKiJYOX5tOipHuFfjc83VXx1/AjM/v+zDLnzeSeyFzl3w7+u+Jx
	 A0VzzbLfrFNlQ==
Received: from [192.168.1.26] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09082501.me.com (Postfix) with ESMTPSA id 1E1D74AA045E;
	Mon,  9 Dec 2024 13:25:55 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 09 Dec 2024 21:25:00 +0800
Subject: [PATCH 2/8] of/irq: Correct element count for array @dummy_imask
 in API of_irq_parse_raw()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-of_irq_fix-v1-2-782f1419c8a1@quicinc.com>
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
In-Reply-To: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Stefan Wiehler <stefan.wiehler@nokia.com>, 
 Grant Likely <grant.likely@linaro.org>, Tony Lindgren <tony@atomide.com>, 
 Kumar Gala <galak@codeaurora.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Julia Lawall <Julia.Lawall@lip6.fr>, Jamie Iles <jamie@jamieiles.com>, 
 Grant Likely <grant.likely@secretlab.ca>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Array @dummy_imask only needs MAX_PHANDLE_ARGS elements, but it actually
has (MAX_PHANDLE_ARGS + 1) elements.

Fix by using (MAX_PHANDLE_ARGS - 1) as max element index in initializer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 43cf60479b9e18eb0eec35f39c147deccd8fe8dd..758eb9b3714868112e83469d131b244ce77d4e82 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -171,7 +171,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	struct device_node *ipar, *tnode, *old = NULL;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	const __be32 *tmp, dummy_imask[] = { [0 ... (MAX_PHANDLE_ARGS - 1)] = cpu_to_be32(~0) };
 	u32 intsize = 1, addrsize;
 	int i, rc = -EINVAL;
 

-- 
2.34.1


