Return-Path: <linux-kernel+bounces-526252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B688EA3FC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA1F8651F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45BF1F236B;
	Fri, 21 Feb 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Xqq2Lg89"
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE6E1E9905;
	Fri, 21 Feb 2025 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.119.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156534; cv=none; b=HvDFdQFGCYZcAwVjYXsK2+zV5G/yuh8Jl41MnEEoVbwKDKtix7SDBbb+QaPdfuUBIZJ+qTjoJSJ//fNdJpbCC8uDrHw7C5iVt+SOkx2ktGq5f06CXONcdoGIsUyAJ3Zpu+MZhWS/JYZahCodsAB+ODdX34CyWkHYuMbjaJEkjOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156534; c=relaxed/simple;
	bh=Ky5jUaP2qmS5NbmgGsFR+u9GagS7rz2kC4/x5BHGlyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biUcmf3rSBC1SYSyFq8ayFroIgUtgZdT5ggPm/X23WHbWAJpXpUm/Fl9Iza1p1vDbGPc6n2vPuhZV6PhfqwQuJIe0inD2mdh5sviKpZ866ug/R6n3G4llW1gBMjpeo7PGIevVk0cZ254S56uoGcgxgGLDIznthPEfYbhIlfWMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Xqq2Lg89; arc=none smtp.client-ip=217.182.119.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id DEB843E87E;
	Fri, 21 Feb 2025 16:48:43 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id F0B77400B3;
	Fri, 21 Feb 2025 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740156521; bh=Ky5jUaP2qmS5NbmgGsFR+u9GagS7rz2kC4/x5BHGlyE=;
	h=From:To:Cc:Subject:Date:From;
	b=Xqq2Lg89OupE3/eOmBb4bnzA6NDfptw5fLdXHwUz2/fplUmwpQfjbPyKfMD8jNJX6
	 Z1iE0QvLvg5iHHt5qHWCIEUuMe0Abd+j9v1536JGQce9UjVw2DCvKoKQyKRxr0Nq7m
	 SStqdzXqr3KjR7RB3fDPeAsyPnlr+aPBMzSsefHE=
Received: from JellyNote.localdomain (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 53D8A405DE;
	Fri, 21 Feb 2025 16:48:36 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	Fan Yang <804284660@qq.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e
Date: Sat, 22 Feb 2025 00:48:24 +0800
Message-ID: <20250221164825.77315-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F0B77400B3
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,804284660.qq.com:server fail,xry111.xry111.site:server fail];
	FREEMAIL_CC(0.00)[aosc.io,qq.com,xry111.site,hmh.eng.br,redhat.com,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

Based on the dmesg messages from the original reporter:

[    4.964073] ACPI: \_SB_.PCI0.LPCB.EC__.HKEY: BCTG evaluated but flagged as error
[    4.964083] thinkpad_acpi: Error probing battery 2

Lenovo ThinkPad X131e also needs this battery quirk.

Reported-by: Fan Yang <804284660@qq.com>
Tested-by: Fan Yang <804284660@qq.com>
Co-developed-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/platform/x86/thinkpad_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 1fcb0f99695a7..64765c6939a50 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9960,6 +9960,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('G', '8', true),       /* ThinkPad X131e */
 	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
-- 
2.48.1


