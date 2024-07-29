Return-Path: <linux-kernel+bounces-265799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870D93F61B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE862825C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE29147C60;
	Mon, 29 Jul 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="t/VjHoDO";
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="XPkyrht1"
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF31420D0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258306; cv=none; b=jdwNyDDs7zYYpZjAqOm4b/NcjCWcXbWT3Z3sqNw7M5jek+vtulTxyq/jjpfHY8je2mjEBn9kQ2v0Uh7KJh5ZlRjmDPnhb0kWqDYMQfespIlZEI1+mI065kx3TKPT8rcGkWjtlhznT4Rz5/nb5lQ2tQeM3rtWMTArAOwQbkdiTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258306; c=relaxed/simple;
	bh=fGthty7C6esIumYGqIzrxlqlpxbrhLZaFxwxdpGGnTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdzAcde58mKmfBUXIpAVta1cg3Vry0OAlUH+BepUkuEiUW2L/JeETJ8IaUowNX+UVMJCB7Jy5NDydzuCZGWgE0uBsbeyR4Z8xdJL6Q+Mg8sTjjya3ylJf5oxtbjEFChupchHGgov802MwG3XYZ473ewh4lOr+1qpH3Pp2T+UQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=fail smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=t/VjHoDO; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=XPkyrht1; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=syntacore.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 5D8D8C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-04; t=1722257972;
	bh=VJQhFLrYSDYECpfTBcXJ8qZ5pAXAxGKKGJucnT6K7zY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=t/VjHoDOvm1N+WG2LVVTiKJloNIUqfWXW3bxqLbXACr/TcSBI7Fb8Tfe3W81plJ1F
	 /XilYDISaaLOEmPW678m/qC0WBjnUaXY28+CPJOtWXb0cLUYn4VED1/9sEXYntFw/z
	 j5exWNy5B6hdtQRrrsAJ5YsrjT1yGXvAtMqqjPt4Xd82ge19yk9cfGPwCP0y1ydyJl
	 LqMS84edKdhf69D71OaEzecg+GP4ubmXyD0DDDfyGtpeKqRDRngQ9ttqH6zeGOM30M
	 OuGDE9U6u6saiSUCWcmqYY8HELKznPwuGgJIaFjUi1lrHs0iFwg233h5FGeU+dk8Qf
	 ylH99A1r6LvQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
	s=mta-03; t=1722257972;
	bh=VJQhFLrYSDYECpfTBcXJ8qZ5pAXAxGKKGJucnT6K7zY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=XPkyrht1ONvfbUbxvVjN+v+cDFYJCGY0PMqfBl6oBv68sxewEXSt2C/T0tu70LhtB
	 0NPzjMtaTscKfZnxEn42ZmxIpEYK2W18qBmRmkS55a6Mer+iEU+w4nZ9paI1iWPgAV
	 Ma2kjtqxeBWMEDx31q1pbABjsRKHIW047SSGKz05pxETEAb5nb9xLSDQnycvkE7z8D
	 WQhrtQLLcPcD+Hec4Q0XANyx3SK7d0iWV3useFrz7H7e6vmGYZUu5lDdyohfoU41FR
	 LuwKvDF1vhSe5I9En483bQkU/Wt9/So9rwJMDK+kX+IMi/loTxz1pBB64hRv00PKY6
	 jwil6En9O+/ag==
From: Shifrin Dmitry <dmitry.shifrin@syntacore.com>
To: <linux-riscv@lists.infradead.org>
CC: <atishp@atishpatra.org>, <anup@brainfault.org>, <will@kernel.org>,
	<mark.rutland@arm.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <alexghiti@rivosinc.com>, Shifrin Dmitry
	<dmitry.shifrin@syntacore.com>
Subject: [PATCH] perf: riscv: Fix selecting counters in legacy mode
Date: Mon, 29 Jul 2024 15:58:58 +0300
Message-ID: <20240729125858.630653-1-dmitry.shifrin@syntacore.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 S-Exch-01.corp.yadro.com (10.78.5.241)

It is required to check event type before checking event config.
Events with the different types can have the same config.
This check is missed for legacy mode code

For such perf usage:
    sysctl -w kernel.perf_user_access=2
    perf stat -e cycles,L1-dcache-loads --
driver will try to force both events to CYCLE counter.

This commit implements event type check before forcing
events on the special counters.

Signed-off-by: Shifrin Dmitry <dmitry.shifrin@syntacore.com>
---
 drivers/perf/riscv_pmu_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 36d128ff166f..bf14ab282e11 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -416,7 +416,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 	 * but not in the user access mode as we want to use the other counters
 	 * that support sampling/filtering.
 	 */
-	if (hwc->flags & PERF_EVENT_FLAG_LEGACY) {
+	if ((hwc->flags & PERF_EVENT_FLAG_LEGACY) && (event->attr.type == PERF_TYPE_HARDWARE)) {
 		if (event->attr.config == PERF_COUNT_HW_CPU_CYCLES) {
 			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
 			cmask = 1;
-- 
2.34.1


