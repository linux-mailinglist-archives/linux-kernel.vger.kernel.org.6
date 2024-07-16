Return-Path: <linux-kernel+bounces-253802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A345932736
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21FF1F226B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C019AD5F;
	Tue, 16 Jul 2024 13:12:27 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B119AD4E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135547; cv=none; b=G33qEbMKIbDMWPWcIDbiHVmOuUKkic7rQdrJx9ypGb8iiCR2xFfKZLCVAG4IlN8dGC14dbeQD5TvCYzSotF9J91J0B6nEEl7/Dk5Z4YEO3V79tOLyenVhI6yRpfpumhMjVjRT8PqU+jq5hgoC3E0iY44+xPPVk3OvmUvnyU6K+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135547; c=relaxed/simple;
	bh=89eKhLjmh9pK9XKXeeHqM39D1cInD+Qdggol4Xw1vBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e42rcDs4ubxB4GDFqMDkqGvPs1iuCqQ2n2WzJTKdeAP9fjR8fouGwUi8iDcaoatfpjASRlgHnPatCx7QXtYtStKsBEqK7YOaqLrPY1R3s8zuZtLQK+RYuwMzTT5MbNcQCooo0y1grtgvl2yNKBCYnM9FXQWwx8hNs6jWHQpNw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2ada:8dc9:1826:6616])
	by xavier.telenet-ops.be with bizsmtp
	id oDCG2C0073EiDc401DCGf8; Tue, 16 Jul 2024 15:12:16 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sThyK-002MTq-Fh;
	Tue, 16 Jul 2024 15:12:16 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sThya-00Fq0z-58;
	Tue, 16 Jul 2024 15:12:16 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] firmware: qcom: QCOM_TZMEM_* should depend on QCOM_TZMEM
Date: Tue, 16 Jul 2024 15:12:14 +0200
Message-Id: <74947f7f132a811cc951749907b01bd25dcf23e6.1721135509.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm TrustZone interface memory allocator is specific to
Qualcomm firmware.  Hence add a dependency on QCOM_TZMEM, to prevent
asking the user about these options when configuring a kernel without
Qualcomm firmware support.  Various Qualcomm drivers already select the
main QCOM_SCM gatekeeper symbol, which in turn selects QCOM_TZMEM, so it
is auto-enabled when needed.

While at it, add "Qualcomm" to the one-line summary for the choice
option, to make it clear this is not related to generic TrustZone
support.

Fixes: 84f5a7b67b61bfeb ("firmware: qcom: add a dedicated TrustZone buffer allocator")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/firmware/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 7f6eb41747346a4f..c607574397e9a7e7 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -15,7 +15,8 @@ config QCOM_TZMEM
 	select GENERIC_ALLOCATOR
 
 choice
-	prompt "TrustZone interface memory allocator mode"
+	prompt "Qualcomm TrustZone interface memory allocator mode"
+	depends on QCOM_TZMEM
 	default QCOM_TZMEM_MODE_GENERIC
 	help
 	  Selects the mode of the memory allocator providing memory buffers of
-- 
2.34.1


