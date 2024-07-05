Return-Path: <linux-kernel+bounces-242406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AD392879C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E185282F32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9E61494C8;
	Fri,  5 Jul 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OaLZGqp6";
	dkim=pass (1024-bit key) header.d=xanderlent.com header.i=@xanderlent.com header.b="U+wAFR2I"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F1148FF3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178087; cv=none; b=tAdODNCy1lDT2WQJqb11vzzgKsdpIyU3m9K2EFyHs9KKEyV6GrDk+EKpaWBj5Ufw26ChZezP1tQYIKjSRl0j/A49OsldeIx3Jl6FoVgvcXzYTgvv2dhJgtyCAM48M0aCnlIJIoXFf33hAiaJ8pF/0cetUyjAreo72UJYwWyHgQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178087; c=relaxed/simple;
	bh=vqmCrZQzc6VxA7DOYVHFH11+oLx5Qm2ZRQliQz36DNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q5AfnugtHUD3ZxDBu2YJ1YPe+ntgrZsJJWZNMFZ6jqL3GX7e1SfXa9pzeOW94JFYHxDgir09IehfMtxtW4Iqv1V+qqzuqgIbPKknfKUNs8iV626mXD0YPELqRGK4/F52eCybxXdS1MPyohjgRV6y2r8rG9VJV7IqX/LOOr13nSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xanderlent.com; spf=pass smtp.mailfrom=xanderlent.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OaLZGqp6; dkim=pass (1024-bit key) header.d=xanderlent.com header.i=@xanderlent.com header.b=U+wAFR2I; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xanderlent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xanderlent.com
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DAA3E288DB;
	Fri,  5 Jul 2024 07:14:44 -0400 (EDT)
	(envelope-from lx@xanderlent.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:date
	:subject:mime-version:content-type:content-transfer-encoding
	:message-id:to:cc; s=sasl; bh=vqmCrZQzc6VxA7DOYVHFH11+oLx5Qm2ZRQ
	liQz36DNo=; b=OaLZGqp6+BQ94x2hpIg3YHLW5oqj7tUoYxuAIe+vIzO5RjqXMX
	Z6WKQozfy6ut05OXXmWbP8EMhhNkCe66CQkDKTYfQ0L1XK06uG7dY64ha1ageztO
	vYPJV6yyYDhVUpdASiP/kaMsAtgeZcayrc+jVyRrjCeLkG1Hw+Y1bDvgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D23B9288DA;
	Fri,  5 Jul 2024 07:14:44 -0400 (EDT)
	(envelope-from lx@xanderlent.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=xanderlent.com;
 h=from:date:subject:mime-version:content-type:content-transfer-encoding:message-id:to:cc; s=2021-09.pbsmtp; bh=vqmCrZQzc6VxA7DOYVHFH11+oLx5Qm2ZRQliQz36DNo=; b=U+wAFR2IFIEJEoc7kYJNMj9VSnr4+7zD2D5OfX6nfqmY0iOULx62YgnbIqXiwazkTfgrem5eGTS+gfdM9eNo7KbEB+xQDs8rXjGXDNfx9D1wsS1J6q9W4FQN7Ib7WPhGgLXXMXg5XAi0igvuAi0cKyq8nSSdiYi2MPFiRjWGYwk=
Received: from ultralight.local (unknown [172.58.228.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C756288D9;
	Fri,  5 Jul 2024 07:14:43 -0400 (EDT)
	(envelope-from lx@xanderlent.com)
From: "Alexander F. Lent" <lx@xanderlent.com>
Date: Fri, 05 Jul 2024 07:14:22 -0400
Subject: [PATCH] accel/ivpu: Add missing MODULE_FIRMWARE metadata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-fix-ivpu-firmware-metadata-v1-1-704b73852d92@xanderlent.com>
X-B4-Tracking: v=1; b=H4sIAI3Vh2YC/3XMQQ6CQAyF4auQrm0yDgSMVzEuOrRKF4ykA2hCu
 DvVvbv3Jy/fBkVMpcC12sBk1aKv7HE+VdAPlJ+Cyt4QQ2xCFxp86Ad1nRYfNr7JBEeZiWkmrDn
 ExG3o2guDA5OJv3/47e6dqAgmo9wPX/K/BPt+AEgE7j+ZAAAA
To: "Alexander F. Lent" <lx@xanderlent.com>, 
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, 
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Daniel Vetter <daniel.vetter@ffwll.ch>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178083; l=2131;
 i=lx@xanderlent.com; s=20240705; h=from:subject:message-id;
 bh=vqmCrZQzc6VxA7DOYVHFH11+oLx5Qm2ZRQliQz36DNo=;
 b=ul5+mUGLzximeBukKpfIKpzmVK7XfVt6U6onPbARLu17HW0SOtnn/lpd3am72T7GBgh5wItNl
 J7wnYPEj+ohAUgcESw6lLLiDx26C0Y89JVVg7YT2dkgOoNsAtis8Fpw
X-Developer-Key: i=lx@xanderlent.com; a=ed25519;
 pk=T7WKAI9F1J7lcthsLG4aBF+wzehTsa3GPyzJkh5is3k=
X-Pobox-Relay-ID:
 C82E6A86-3ABF-11EF-BD6B-965B910A682E-45904678!pb-smtp2.pobox.com

Modules that load firmware from various paths at runtime must declare
those paths at compile time, via the MODULE_FIRMWARE macro, so that the
firmware paths are included in the module's metadata.

The accel/ivpu driver loaded firmware but lacked this metadata,
preventing dracut from correctly locating firmware files.

Fixes: 9ab43e95f922 ("accel/ivpu: Switch to generation based FW names")
Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
Signed-off-by: Alexander F. Lent <lx@xanderlent.com>
---
 drivers/accel/ivpu/ivpu_fw.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 1457300828bf..51792a00b7e3 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -48,16 +48,26 @@ static char *ivpu_firmware;
 module_param_named_unsafe(firmware, ivpu_firmware, charp, 0644);
 MODULE_PARM_DESC(firmware, "NPU firmware binary in /lib/firmware/..");
 
+#define IVPU_FW_PATH_37XX_BIN		"vpu_37xx.bin"
+#define IVPU_FW_PATH_37XX_V0_BIN	"intel/vpu/vpu_37xx_v0.0.bin"
+#define IVPU_FW_PATH_40XX_BIN		"vpu_40xx.bin"
+#define IVPU_FW_PATH_40XX_V0_BIN	"intel/vpu/vpu_40xx_v0.0.bin"
+
 static struct {
 	int gen;
 	const char *name;
 } fw_names[] = {
-	{ IVPU_HW_37XX, "vpu_37xx.bin" },
-	{ IVPU_HW_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
-	{ IVPU_HW_40XX, "vpu_40xx.bin" },
-	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
+	{ IVPU_HW_37XX, IVPU_FW_PATH_37XX_BIN },
+	{ IVPU_HW_37XX, IVPU_FW_PATH_37XX_V0_BIN },
+	{ IVPU_HW_40XX, IVPU_FW_PATH_40XX_BIN },
+	{ IVPU_HW_40XX, IVPU_FW_PATH_40XX_V0_BIN },
 };
 
+MODULE_FIRMWARE(IVPU_FW_PATH_37XX_BIN);
+MODULE_FIRMWARE(IVPU_FW_PATH_37XX_V0_BIN);
+MODULE_FIRMWARE(IVPU_FW_PATH_40XX_BIN);
+MODULE_FIRMWARE(IVPU_FW_PATH_40XX_V0_BIN);
+
 static int ivpu_fw_request(struct ivpu_device *vdev)
 {
 	int ret = -ENOENT;

---
base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
change-id: 20240704-fix-ivpu-firmware-metadata-3d02bd60768d

Best regards,
-- 
Alexander F. Lent <lx@xanderlent.com>


