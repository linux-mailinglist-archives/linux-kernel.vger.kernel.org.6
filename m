Return-Path: <linux-kernel+bounces-245021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112DD92AD1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD81C28235A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8334A0A;
	Tue,  9 Jul 2024 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="b9i60mlp";
	dkim=pass (1024-bit key) header.d=xanderlent.com header.i=@xanderlent.com header.b="UY7iJU+q"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C450D10F2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484742; cv=none; b=WTEDr/s4iDE3K+inH5H5nVqvvBzxL4Aw0TfBtIXctqCgDqT27Hwm2WS0MftFoEEcfac5dnpEgP/PRafFN/6l/37g71IdGjxdvYuCyBZBOEv2ZFwowTZLvzC26rNLfJ6f/hFCztgQdPXddJahlDBl0HdBWq0SZMwAXS4iOqNvUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484742; c=relaxed/simple;
	bh=Jg/fyH7UKVIwiUWlPCTGYCi3w6sML/69oj+YOKqujis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ikmfg1QG6bmQTEkqb3gw+OH5y5qLHrr6dPiNFTD8rXyuWHIQZiZQS95VHpWIpFNiMcHM6/2EYruOeEmHKJMVMPIkGd/tCMxJ2Oz7wDqPvAstmK3EtuHZY4ha7SyPW3NXf+yhuXpLjH48Tz3lGymYwyf/J9JCDoGSs5UlJrFKmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xanderlent.com; spf=pass smtp.mailfrom=xanderlent.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=b9i60mlp; dkim=pass (1024-bit key) header.d=xanderlent.com header.i=@xanderlent.com header.b=UY7iJU+q; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xanderlent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xanderlent.com
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9555A2502F;
	Mon,  8 Jul 2024 20:25:39 -0400 (EDT)
	(envelope-from lx@xanderlent.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:date
	:subject:mime-version:content-type:content-transfer-encoding
	:message-id:to:cc; s=sasl; bh=Jg/fyH7UKVIwiUWlPCTGYCi3w6sML/69oj
	+YOKqujis=; b=b9i60mlpdETCvX++SK+3/+LZil5UQfLmOA4m+O35JgiR0gxY1V
	BliaZbtG8qv1AdYaKH6SfLTsKRPE8aUJUf+vw2FVriDstGKd0osM0kZb0o+xfxYz
	IBIPkitxx4jVH6witcDk8y1GaRPyxY3FQNZsSW8XwM5MQeFYSfaN1XOHk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C3122502E;
	Mon,  8 Jul 2024 20:25:39 -0400 (EDT)
	(envelope-from lx@xanderlent.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=xanderlent.com;
 h=from:date:subject:mime-version:content-type:content-transfer-encoding:message-id:to:cc; s=2021-09.pbsmtp; bh=Jg/fyH7UKVIwiUWlPCTGYCi3w6sML/69oj+YOKqujis=; b=UY7iJU+qlCKayLB+HxAAL1w5pp72/VNMVXo+aKUPVMNsilaHWFGa07C+3WWvujmoWwxF25EBfxbn2KL006Oa0j/XaC6fUS/sIvAcFjdtnF0VJU4wF2Gu0nqo+oykYWwlVrTcqkBULdMDUbAWGdc5gce0hU96euBSONIIApaiLBY=
Received: from ultralight.local (unknown [172.58.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44A3A2502D;
	Mon,  8 Jul 2024 20:25:37 -0400 (EDT)
	(envelope-from lx@xanderlent.com)
From: "Alexander F. Lent" <lx@xanderlent.com>
Date: Mon, 08 Jul 2024 20:25:26 -0400
Subject: [PATCH v2] accel/ivpu: Add missing MODULE_FIRMWARE metadata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-fix-ivpu-firmware-metadata-v2-1-78b953172026@xanderlent.com>
X-B4-Tracking: v=1; b=H4sIAHWDjGYC/32OzQ6CMBAGX4X07JpSfvXkexgOC12liRSyrRVDe
 HcLiUe97ST7TWYRjtiQE+dkEUzBODPaCOqQiK5HeycwOrJQUuWykjnczAwmTM948PBCJhjIo0a
 PkGmpWl3Kqqy1iIKJKX7v8msTuUVH0DLart+Uv03buDfOj/zew0K6Kb4Nxb+GkEIKsbOtsrpQ+
 qQuM1pN/CDrj904iGZd1w/X1ln89gAAAA==
To: "Alexander F. Lent" <lx@xanderlent.com>, 
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, 
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
 Oded Gabbay <ogabbay@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Daniel Vetter <daniel.vetter@ffwll.ch>, 
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, 
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720484737; l=1820;
 i=lx@xanderlent.com; s=20240705; h=from:subject:message-id;
 bh=Jg/fyH7UKVIwiUWlPCTGYCi3w6sML/69oj+YOKqujis=;
 b=9rsy/xGAWfm0mmS7AcZaDR5U3eTRs6P2LO2AaJAlt70WUjBxulFQsBTMN+Ft6NEZT2Gp524P7
 TrN/KR0yEODAE3ACcj0MBHK9ZosfpzalC43Y4LLC+WZEt+DJxOqQzBA
X-Developer-Key: i=lx@xanderlent.com; a=ed25519;
 pk=T7WKAI9F1J7lcthsLG4aBF+wzehTsa3GPyzJkh5is3k=
X-Pobox-Relay-ID:
 C494A6DE-3D89-11EF-8113-965B910A682E-45904678!pb-smtp2.pobox.com

Modules that load firmware from various paths at runtime must declare
those paths at compile time, via the MODULE_FIRMWARE macro, so that the
firmware paths are included in the module's metadata.

The accel/ivpu driver loads firmware but lacks this metadata,
preventing dracut from correctly locating firmware files. Fix it.

Fixes: 9ab43e95f922 ("accel/ivpu: Switch to generation based FW names")
Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
Signed-off-by: Alexander F. Lent <lx@xanderlent.com>
---
Hi Jacek,

Thank you for the review. I've updated the patch based on your recommendations.
Please let me know what you think.
---
Changes in v2:
- Only annotate the module with the production firmware paths, per review.
- Drop macros for de-duping firmware fileames, just use string literals, per review.
- Link to v1: https://lore.kernel.org/r/20240705-fix-ivpu-firmware-metadata-v1-1-704b73852d92@xanderlent.com
---
 drivers/accel/ivpu/ivpu_fw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 1457300828bf..38125cdc8510 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -58,6 +58,12 @@ static struct {
 	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
 };
 
+/* Add module metadata for the production firmware paths.
+ * This needs to be kept in sync with fw_names above.
+ */
+MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
+MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
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


