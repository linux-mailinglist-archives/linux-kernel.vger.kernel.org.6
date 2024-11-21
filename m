Return-Path: <linux-kernel+bounces-416989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE419D4D51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96251F22FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD64F1D417B;
	Thu, 21 Nov 2024 13:00:36 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C801CCEC3;
	Thu, 21 Nov 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194036; cv=none; b=ghbKuePI1CS3IUFVCXE1cE0A/uuqN44xzc+h+t1DxS04+JXPIV0ltV0lXK/yw+olGHnZDpeIRqcaxyapp6UNljjicvhc5Plrg9mW1r2zbiVlzjKDZhi+QCmgz0gLnw3g8LnAMVmLQKbl/6l35tDB/eUT8czo5TItvZHcpKg9WAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194036; c=relaxed/simple;
	bh=pNxMM+jCRLHZcp2/hz4VhiG1zswitaV2W3TVBT6z5X4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uAdOkmAW4D4Qa7ip5x+6BuLIkvVApl3cT8loco0VD094LfjsdfikyhRYyXg+c3dmmWQShi662zcw03ldMXCA2BVVI3q277gnOjob201ZgVTQzO94n9ghiVl1XHM4vVuHnBRrQ4plJhhLogMtGrAhz3HH+sdM31ZswFIY+qZaCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5673f2ee9fcb-5efe2;
	Thu, 21 Nov 2024 21:00:29 +0800 (CST)
X-RM-TRANSID:2ee5673f2ee9fcb-5efe2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.69])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5673f2eed70b-d8ca6;
	Thu, 21 Nov 2024 21:00:29 +0800 (CST)
X-RM-TRANSID:2ee5673f2eed70b-d8ca6
From: liujing <liujing@cmss.chinamobile.com>
To: srinivas.pandruvada@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Fix the wrong format specifier
Date: Thu, 21 Nov 2024 21:00:28 +0800
Message-Id: <20241121130028.6259-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because clos_config->clos_min and clos_config->clos_max
are unsigned int types, the output format should be %u.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index 07ebd08f3202..5ecf24bda6dd 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -617,14 +617,14 @@ void isst_clos_display_information(struct isst_id *id, FILE *outf, int clos,
 	format_and_print(outf, level + 2, header, value);
 
 	snprintf(header, sizeof(header), "clos-min");
-	snprintf(value, sizeof(value), "%d MHz", clos_config->clos_min * isst_get_disp_freq_multiplier());
+	snprintf(value, sizeof(value), "%u MHz", clos_config->clos_min * isst_get_disp_freq_multiplier());
 	format_and_print(outf, level + 2, header, value);
 
 	snprintf(header, sizeof(header), "clos-max");
 	if ((clos_config->clos_max * isst_get_disp_freq_multiplier()) == 25500)
 		snprintf(value, sizeof(value), "Max Turbo frequency");
 	else
-		snprintf(value, sizeof(value), "%d MHz", clos_config->clos_max * isst_get_disp_freq_multiplier());
+		snprintf(value, sizeof(value), "%u MHz", clos_config->clos_max * isst_get_disp_freq_multiplier());
 	format_and_print(outf, level + 2, header, value);
 
 	snprintf(header, sizeof(header), "clos-desired");
-- 
2.27.0




