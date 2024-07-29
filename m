Return-Path: <linux-kernel+bounces-265250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CF93EE72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE28281B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE50784DF5;
	Mon, 29 Jul 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="0cSzNKG1"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE812C522;
	Mon, 29 Jul 2024 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238205; cv=none; b=HU1mDO/x6theU9ptbmP9LW4/fPn71smscX/8RmrkHpjoAiTcceGBMvap21qgViFESmP6Bju74LMadiq/CdFljxdbszd92YBIU8TJhHQNB61uZyh40WISNeTG21oj+BZ62SsUmHX5HEVWtcoWVdFyadJBNwbSenC3h+CJuu+attQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238205; c=relaxed/simple;
	bh=YudSCHZ0V0eT0MMmsGzvIfH1abP3rNGEXEmxWw4lJeQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oedkVbhDHLXDRhDE3xjoPo/RQ5+6TbegUsuZ0qMnI5qsrBwJBZ93fD/11A6euf79LzmyfNCYtpJ/ZcGChrwOkzy1hS5CGXXZy63rXsGN5i6OWQdwlvpKrGvo44A3Iyqx3Gjl2nd7xDFrkj5xhAuKvXCaDTv3ByQJuoyDaBCx0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=0cSzNKG1; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SKW1XQ019054;
	Mon, 29 Jul 2024 08:53:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Dg0E8JSDSPWfXnNnTf/7dL
	WMSkni9o3yFL7NSZMm0Ak=; b=0cSzNKG1GpxJ3r+Pt9FSbf78U/jP6dvmYxaqIh
	1DUATFWG8eKhks9LBXTavZs/3/9P5363NDiMLSbgI1Z82v7YKKi/hBAGxmj1GHrv
	BpmPQq2YK7It8vfvU4Y+gDtqHIdRvHZG8hXqBtvBghiP+hkI9YlUAPRXYvhhIk/A
	6s8EFPCgrN3VZFyMOQ0WjZ3KZBVXFQuAM5Mfl17HVu2xG9iAhw5c95uiu35wafq+
	KobjlHnhYfem6lXSGcPpwxpASc3V1WysHASTxGrMjsAtwBwRN2brYNteJBaFpDtn
	m6nE+1aAQVycUWDIOup0NWTza2ExV0u3LBVhpw/vr0X1gZVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40nbuhkfb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 08:53:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7A02C40044;
	Mon, 29 Jul 2024 08:53:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E691214545;
	Mon, 29 Jul 2024 08:53:11 +0200 (CEST)
Received: from localhost (10.252.16.53) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 29 Jul
 2024 08:53:10 +0200
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <linux-kernel@vger.kernel.org>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        Etienne
 Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH] firmware: arm_scmi: get only min/max clock rates
Date: Mon, 29 Jul 2024 08:53:06 +0200
Message-ID: <20240729065306.1210733-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_05,2024-07-26_01,2024-05-17_01

Remove limitation of 16 clock rates max for discrete clock rates
description.

Driver clk-scmi.c in only interested in the min and max clock rates.
Get these by querying the first and last discrete rates with SCMI
clock protocol message ID CLK_DESCRIBE_RATES since the SMCI clock
protocol specification states that rates enumerated by this
command are to be enumerated in "numeric ascending order" [1].

Link: https://developer.arm.com/documentation/den0056 [1]
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/clk/clk-scmi.c            |   4 +-
 drivers/firmware/arm_scmi/clock.c | 184 +++++++++++-------------------
 include/linux/scmi_protocol.h     |   4 +-
 3 files changed, 68 insertions(+), 124 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d86a02563f6c..abe59da06324 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -234,8 +234,8 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 		if (num_rates <= 0)
 			return -EINVAL;
 
-		min_rate = sclk->info->list.rates[0];
-		max_rate = sclk->info->list.rates[num_rates - 1];
+		min_rate = sclk->info->list.min_rate;
+		max_rate = sclk->info->list.max_rate;
 	} else {
 		min_rate = sclk->info->range.min_rate;
 		max_rate = sclk->info->range.max_rate;
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 134019297d08..88fd240052c0 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -404,140 +404,84 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int rate_cmp_func(const void *_r1, const void *_r2)
+static int
+scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
+			      struct scmi_clock_info *clk)
 {
-	const u64 *r1 = _r1, *r2 = _r2;
-
-	if (*r1 < *r2)
-		return -1;
-	else if (*r1 == *r2)
-		return 0;
-	else
-		return 1;
-}
+	struct scmi_msg_clock_describe_rates *msg;
+	const struct scmi_msg_resp_clock_describe_rates *resp;
+	unsigned int num_returned, num_remaining;
+	struct scmi_xfer *t;
+	int ret;
 
-static void iter_clk_describe_prepare_message(void *message,
-					      const unsigned int desc_index,
-					      const void *priv)
-{
-	struct scmi_msg_clock_describe_rates *msg = message;
-	const struct scmi_clk_ipriv *p = priv;
+	/* Get either the range triplet or the min rate & rates count */
+	ret = ph->xops->xfer_get_init(ph, CLOCK_DESCRIBE_RATES, sizeof(*msg), 0,
+				      &t);
+	if (ret)
+		return ret;
 
-	msg->id = cpu_to_le32(p->clk_id);
-	/* Set the number of rates to be skipped/already read */
-	msg->rate_index = cpu_to_le32(desc_index);
-}
+	msg = t->tx.buf;
+	msg->id = cpu_to_le32(clk_id);
+	msg->rate_index = 0;
 
-static int
-iter_clk_describe_update_state(struct scmi_iterator_state *st,
-			       const void *response, void *priv)
-{
-	u32 flags;
-	struct scmi_clk_ipriv *p = priv;
-	const struct scmi_msg_resp_clock_describe_rates *r = response;
-
-	flags = le32_to_cpu(r->num_rates_flags);
-	st->num_remaining = NUM_REMAINING(flags);
-	st->num_returned = NUM_RETURNED(flags);
-	p->clk->rate_discrete = RATE_DISCRETE(flags);
-
-	/* Warn about out of spec replies ... */
-	if (!p->clk->rate_discrete &&
-	    (st->num_returned != 3 || st->num_remaining != 0)) {
-		dev_warn(p->dev,
-			 "Out-of-spec CLOCK_DESCRIBE_RATES reply for %s - returned:%d remaining:%d rx_len:%zd\n",
-			 p->clk->name, st->num_returned, st->num_remaining,
-			 st->rx_len);
-
-		/*
-		 * A known quirk: a triplet is returned but num_returned != 3
-		 * Check for a safe payload size and fix.
-		 */
-		if (st->num_returned != 3 && st->num_remaining == 0 &&
-		    st->rx_len == sizeof(*r) + sizeof(__le32) * 2 * 3) {
-			st->num_returned = 3;
-			st->num_remaining = 0;
-		} else {
-			dev_err(p->dev,
-				"Cannot fix out-of-spec reply !\n");
-			return -EPROTO;
-		}
-	}
+	resp = t->rx.buf;
 
-	return 0;
-}
+	ret = ph->xops->do_xfer(ph, t);
+	if (ret)
+		goto out;
 
-static int
-iter_clk_describe_process_response(const struct scmi_protocol_handle *ph,
-				   const void *response,
-				   struct scmi_iterator_state *st, void *priv)
-{
-	int ret = 0;
-	struct scmi_clk_ipriv *p = priv;
-	const struct scmi_msg_resp_clock_describe_rates *r = response;
-
-	if (!p->clk->rate_discrete) {
-		switch (st->desc_index + st->loop_idx) {
-		case 0:
-			p->clk->range.min_rate = RATE_TO_U64(r->rate[0]);
-			break;
-		case 1:
-			p->clk->range.max_rate = RATE_TO_U64(r->rate[1]);
-			break;
-		case 2:
-			p->clk->range.step_size = RATE_TO_U64(r->rate[2]);
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
-	} else {
-		u64 *rate = &p->clk->list.rates[st->desc_index + st->loop_idx];
+	clk->rate_discrete = RATE_DISCRETE(resp->num_rates_flags);
+	num_returned = NUM_RETURNED(resp->num_rates_flags);
+	num_remaining = NUM_REMAINING(resp->num_rates_flags);
 
-		*rate = RATE_TO_U64(r->rate[st->loop_idx]);
-		p->clk->list.num_rates++;
-	}
+	if (clk->rate_discrete) {
+		clk->list.num_rates = num_returned + num_remaining;
+		clk->list.min_rate = RATE_TO_U64(resp->rate[0]);
 
-	return ret;
-}
+		if (num_remaining) {
+			msg->rate_index = clk->list.num_rates - 1;
 
-static int
-scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
-			      struct scmi_clock_info *clk)
-{
-	int ret;
-	void *iter;
-	struct scmi_iterator_ops ops = {
-		.prepare_message = iter_clk_describe_prepare_message,
-		.update_state = iter_clk_describe_update_state,
-		.process_response = iter_clk_describe_process_response,
-	};
-	struct scmi_clk_ipriv cpriv = {
-		.clk_id = clk_id,
-		.clk = clk,
-		.dev = ph->dev,
-	};
+			ret = ph->xops->do_xfer(ph, t);
+			if (ret)
+				goto out;
 
-	iter = ph->hops->iter_response_init(ph, &ops, SCMI_MAX_NUM_RATES,
-					    CLOCK_DESCRIBE_RATES,
-					    sizeof(struct scmi_msg_clock_describe_rates),
-					    &cpriv);
-	if (IS_ERR(iter))
-		return PTR_ERR(iter);
+			clk->list.max_rate = RATE_TO_U64(resp->rate[0]);
+		} else {
+			u64 max = RATE_TO_U64(resp->rate[num_returned - 1]);
 
-	ret = ph->hops->iter_response_run(iter);
-	if (ret)
-		return ret;
+			clk->list.max_rate = max;
+		}
+	} else {
+		/* Warn about out of spec replies ... */
+		if (num_returned != 3 || num_remaining != 0) {
+			dev_warn(ph->dev,
+				 "Out-of-spec CLOCK_DESCRIBE_RATES reply for %s - returned:%d remaining:%d rx_len:%zd\n",
+				 clk->name, num_returned, num_remaining,
+				 t->rx.len);
+
+			/*
+			 * A known quirk: a triplet is returned but
+			 * num_returned != 3, check for a safe payload
+			 * size to use returned info.
+			 */
+			if (num_remaining != 0 ||
+			    t->rx.len != sizeof(*resp) +
+					 sizeof(__le32) * 2 * 3) {
+				dev_err(ph->dev,
+					"Cannot fix out-of-spec reply !\n");
+				ret = -EPROTO;
+				goto out;
+			}
+		}
 
-	if (!clk->rate_discrete) {
-		dev_dbg(ph->dev, "Min %llu Max %llu Step %llu Hz\n",
-			clk->range.min_rate, clk->range.max_rate,
-			clk->range.step_size);
-	} else if (clk->list.num_rates) {
-		sort(clk->list.rates, clk->list.num_rates,
-		     sizeof(clk->list.rates[0]), rate_cmp_func, NULL);
+		clk->range.min_rate = RATE_TO_U64(resp->rate[0]);
+		clk->range.max_rate = RATE_TO_U64(resp->rate[1]);
+		clk->range.step_size = RATE_TO_U64(resp->rate[2]);
 	}
 
+out:
+	ph->xops->xfer_put(ph, t);
+
 	return ret;
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 3a9bb5b9a9e8..fe4b464419a0 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -15,7 +15,6 @@
 
 #define SCMI_MAX_STR_SIZE		64
 #define SCMI_SHORT_NAME_MAX_SIZE	16
-#define SCMI_MAX_NUM_RATES		16
 
 /**
  * struct scmi_revision_info - version information structure
@@ -54,7 +53,8 @@ struct scmi_clock_info {
 	union {
 		struct {
 			int num_rates;
-			u64 rates[SCMI_MAX_NUM_RATES];
+			u64 min_rate;
+			u64 max_rate;
 		} list;
 		struct {
 			u64 min_rate;
-- 
2.25.1


