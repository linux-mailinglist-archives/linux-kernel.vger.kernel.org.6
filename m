Return-Path: <linux-kernel+bounces-313431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6784A96A569
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0827DB24C75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818318DF8B;
	Tue,  3 Sep 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b="TlSHP2C+"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B311422A2;
	Tue,  3 Sep 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384564; cv=none; b=gJPh4HD69bTBd0bwlfWwz4mYxXv8/Wx+z43kfIcSYzzQATbclMB/EJNShGNBye5LvnWTP2QJL0JpFiBHRulJDgTWqvxoG/nPehXpNJ2gyilqNlctl81IazDj4a+1G79hVooG/fSvGyFP18bPz3wBMgfLfzkvzIPV7iDnfLDjvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384564; c=relaxed/simple;
	bh=X+It1Q+O3EWWhaFLasZspBDEgcTY0pnKmXSZoLiTvp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dggPHqrT60f/hAurXUjSXxFGZdbXdEIAGxILIi2rx1CIv+Z8MWszk/OwcubBIUjne6kliTUvYcD34D5R5sJb+uTNVEttNi/9qtn8oJwBL3uUwZMmvMk4D6S3Y29IK7xgPwNNe81gzvSjwNk2Cme1/wxTlEK4QHNrgeH3oQIUn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de; spf=pass smtp.mailfrom=matthias-fetzer.de; dkim=pass (2048-bit key) header.d=matthias-fetzer.de header.i=@matthias-fetzer.de header.b=TlSHP2C+; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=matthias-fetzer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matthias-fetzer.de
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4Wyt0B2k2Vz82xJ;
	Tue,  3 Sep 2024 19:29:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matthias-fetzer.de;
	s=key2; t=1725384554;
	bh=X+It1Q+O3EWWhaFLasZspBDEgcTY0pnKmXSZoLiTvp0=;
	h=From:To:Cc:Subject:Date:From;
	b=TlSHP2C+djXO1zdVTHIX+TjCGWXjilUH2RZk6qAxYFqLSF7McOlutkq3Uvqy0B8+j
	 D/DsbRWfOMMBZw0aKrEYvYZhbGdgqDQ1FfgBbHtpSQQF3szU6ufMXl8ZmYTaGrRUVZ
	 Oo/sJCsBhFpapIMn95JrKqkDrERDrpt3Gd9x+VGzALjgUicQeZiro0hu4O0D0i1gZ9
	 x+bNbOn8laMd8ZutJ6RrbBfTw49fmkOe13SOBwvqsIjbNdl0H4uM5R9iGxLRQEgRHv
	 06GsRCfJQZIFEz3mGVIBRxUpCVseY5bZ3UP1e5hKoVNYnaxyyA7DGaP9rqD58Kajrl
	 1Zki+oNo9kRUg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4Wyt0B2J01z82x0;
	Tue,  3 Sep 2024 19:29:14 +0200 (CEST)
Received: from mxf9a3.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Wyt094sglz8sZP;
	Tue,  3 Sep 2024 19:29:13 +0200 (CEST)
Received: from matthias-pc.lan (unknown [IPv6:2001:9e8:1a7b:9200:6f4:7bfc:1c9b:cef9])
	by mxf9a3.netcup.net (Postfix) with ESMTPSA id 9FC98403FC;
	Tue,  3 Sep 2024 19:29:08 +0200 (CEST)
Authentication-Results: mxf9a3;
	spf=pass (sender IP is 2001:9e8:1a7b:9200:6f4:7bfc:1c9b:cef9) smtp.mailfrom=kontakt@matthias-fetzer.de smtp.helo=matthias-pc.lan
Received-SPF: pass (mxf9a3: connection is authenticated)
From: Matthias Fetzer <kontakt@matthias-fetzer.de>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthias Fetzer <kontakt@matthias-fetzer.de>
Subject: [PATCH] platform/x86: thinkpad_acpi: Fix uninitialized symbol
Date: Tue,  3 Sep 2024 19:27:56 +0200
Message-ID: <20240903172756.19235-1-kontakt@matthias-fetzer.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <172538454916.15387.9593674090575639921@mxf9a3.netcup.net>
X-Rspamd-Queue-Id: 9FC98403FC
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: IrmD5ESUPMxoygiOMo4UGzgyFQ9Tu0sWPlxg5oePxK7yIb4C+64KVRv0

When the TPACPI_FAN_WR_ACPI_FANW branch is taken s stays uninitialized
and would be later used in a debug print.

Since the registers are always set to the same two static values inside the
branch s is initialized to 0.

Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 8f7053920884..4c1b0553f872 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8318,7 +8318,7 @@ static int fan_set_level_safe(int level)
 
 static int fan_set_enable(void)
 {
-	u8 s;
+	u8 s = 0;
 	int rc;
 
 	if (!fan_control_allowed)
-- 
2.46.0


