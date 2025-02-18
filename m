Return-Path: <linux-kernel+bounces-519037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABDA3974B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3560016EFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7D323236C;
	Tue, 18 Feb 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XCqMvkqn"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5822FF2F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871735; cv=none; b=mNhEX37JNFwVfn3/U89927tcD7hYL0KGuUa+qOTqJC9hmQe3OFXtCxlhiZg6fctoyrwMJQduNxOq247j2m9uog1dgtOpSEpPPUIA9u1jbGdNky5zksMx0ITFajWEoBjNV7B03arguuSdiwdzMnXZBSFnsVQBLjJLISR/PuaBK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871735; c=relaxed/simple;
	bh=TejqLV8/gQQd3iSRf5Ewdd9ea8a07L1bcG8RSJcAkh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elEqDA9YoAVHsS+bc6w3FxsXhrpJzfxQyuIWk8lZJVobGNFmB7oFYc46Qn6tj4SmeNe75OBOkYIBfBwjdjlWYbrPhcGm9/pHbuOwAXAcAHgOuqlOE+5fOK/fpTstUEf3XN/LuHw7Rt3//4d1JwT2Dye1lEHc4FHfuecevvkQznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XCqMvkqn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739871646;
	bh=pbNiPFnphCXaR8Xz0VxXvVAaKoyRBthGhG+fK+dOAyA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XCqMvkqnRcLX3GhoPuUTkPG54k7FQqIYW55W+d7B7d2bN85tuIBok6cY015x1TFkg
	 ALCBKuHaN9XMK2uuSsu3pYCR++zU3mAKW0DcqQJleEBI9+OhxuOkt7gwRhwCkIs2zH
	 3GXQkLCn24rhRKRkaW6cMl7GvH03WMyIhtQPKQ/Q=
X-QQ-mid: bizesmtpip4t1739871634tllm831
X-QQ-Originating-IP: 4izNvgxeXalz9cGRpks6g/RcGnd9vLQrdnF24eieh7A=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 17:40:32 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1971567560806955168
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	guanwentao@uniontech.com,
	yangtiezhu@loongson.cn,
	maobibo@loongson.cn,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH] LoongArch: acpi: Make parse_acpi_topology() return void
Date: Tue, 18 Feb 2025 17:40:27 +0800
Message-ID: <C832CAEC20DE4FC4+20250218094027.482396-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OPa5+/AT2oWtCjDBOWrZ7+T8NQB11AfrBsliGRpJZFcnGRxk1MLCpAnK
	gSsSbqBEprI0m/+rAbHxvrzgPYRWrw3NVsnvziFqvtJ0XABQoeK2Vhruoo6lXwcASNTEM9U
	AJv6YWFkHjbjFfhtJdOHRkg4rQ74ALX9YssZoH8h3RRDWSXLjCSdJbjwHnhSUHygnxnsU7s
	HcEPhT/EOn1KN2QKUrFtSDia7KZq+UtR49PETBZ8KDcVg6d+6+YMuYTFufIdUKLa7Xnp0Tt
	1XnajW1813Q9hrBLWEZPKC0l/3UmcdoxwLbV0Z9yq4LeLFMQRiUKirzZ9WIB/xwU5If4Scj
	7JovYFrSM4fApZ36UZpm8LvqVWFsnLbNdAuOMVLD1KwTO+uEzNMYJHfYKVBwh79nUVfMz7s
	GdhJtrNyMYefZAtPnx5c5NfPZQuacHdBCjGhFy0ueoYN8knIWInWeIlpvsdAb5AD3S5wGtC
	XPYL1LHVlcCvvGHO0XUdT1d6lctbCmFyj8uV5H3DRgtR+egtDFlOpIaW9u60gaL7SdeoOG5
	1CmnOFOBr4XRfs0X7iKIE+gMCVPBuVBhwmP+oF2bxrbsUDIZSfxW6uddtFq4Uq/P20d/sTK
	qqxX+n7MNjW6p6z5MFq53MOnuaNeCTfuxqJ2yREmkyBNwckQkdVVzrv/rK9/4X1qvqxK+sy
	IAy5bu5WBrlTPSNvWjO9pUqT7kFPo9+W9GJCBXcTCScDDAy0ZRM9mnVekIsM8KyZNgplMIt
	Wm5Rw0pQYaIATMaUEb4XwSIb6GjiutSQ8nH0qan2PxPbkmLjYZvu3tBeuF3CAkBOpAyRtP+
	58wClubp8jnhx7iy6evLBb4i538AI3BB9Q0abXPN3sJdYQr3sMa9t6c+JO6n3yESsVOGz63
	gGL/OozMj057FRIJzG4vbSATYY5UQUp8nG/0dsHNEQRI3A9tRr9AuTzbeWfWy1/XiWxfR/e
	1Ehh1L0CXmt1CzWx1iKRl7StmEDkXYDlqVIzWTs8GQzjnkqbFluqyCFfDxekX1V4iO9y5c5
	RUU8xoTI9jdJKIPFZtroqbZ+EEYZEixywfVXknPgJaMZfVXqq+
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The return value of parse_acpi_topology() is both unnecessary and
unused.

Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
 arch/loongarch/include/asm/acpi.h | 2 +-
 arch/loongarch/kernel/acpi.c      | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 313f66f7913a..c1b90a90e28b 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -38,7 +38,7 @@ static inline bool acpi_has_cpu_in_madt(void)
 extern struct list_head acpi_wakeup_device_list;
 extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
-extern int __init parse_acpi_topology(void);
+extern void __init parse_acpi_topology(void);
 
 static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
 {
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 382a09a7152c..a95e8a7dd5a6 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -173,7 +173,7 @@ static void __init acpi_process_madt(void)
 
 int pptt_enabled;
 
-int __init parse_acpi_topology(void)
+void __init parse_acpi_topology(void)
 {
 	int cpu, topology_id;
 
@@ -181,7 +181,6 @@ int __init parse_acpi_topology(void)
 		topology_id = find_acpi_cpu_topology(cpu, 0);
 		if (topology_id < 0) {
 			pr_warn("Invalid BIOS PPTT\n");
-			return -ENOENT;
 		}
 
 		if (acpi_pptt_cpu_is_thread(cpu) <= 0)
@@ -189,15 +188,13 @@ int __init parse_acpi_topology(void)
 		else {
 			topology_id = find_acpi_cpu_topology(cpu, 1);
 			if (topology_id < 0)
-				return -ENOENT;
+				pr_warn("Invalid BIOS PPTT\n");
 
 			cpu_data[cpu].core = topology_id;
 		}
 	}
 
 	pptt_enabled = 1;
-
-	return 0;
 }
 
 #ifndef CONFIG_SUSPEND
-- 
2.47.2


