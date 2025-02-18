Return-Path: <linux-kernel+bounces-520451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75558A3AA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366853B1DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD881D7E54;
	Tue, 18 Feb 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XFz2QqZG"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00E1B041F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910878; cv=none; b=J55V3Wai1ZHaaVnVPp7xNXzUzJuFcYwyClEcfsd3Ol8aqCYAy/ARqwf0TyJYVK5TkpD/uP+Ag+mCW8KZOnNfEpPooxX1zRm7CqflRMiyVa7Fttj34hTQhkC06OMXRmHNw4+c86SLSp372FurUBVljxEhDMjAXQYx2f4RUTtUgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910878; c=relaxed/simple;
	bh=YVI5exqhXtTK6AnQzPNoWRQDD3V/AhCHKs/nyX3bdIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uTJkcdd/8x4DIGQ/iJaJf3bxU8tOJOt+oRC4hirntQfTRYoMWX1LsEwjYznx/qG8H5BefyeK4HKbkH6x3HOuNDV7z3KHiNyOtMkeDcW6qPSs2ZH5lU1OnqKheJFWHukDrD6sq5rHH9kEtBCkvHD48ZpO+bBWndI0ZnNDUAJVhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XFz2QqZG; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1739910441;
	bh=YVI5exqhXtTK6AnQzPNoWRQDD3V/AhCHKs/nyX3bdIg=;
	h=From:Date:Subject:To:Cc:From;
	b=XFz2QqZGXPNEBUB9cMN1Yi/BFhCh/ELD75YfUtW7mq13eBDBc+NSXT40rme2mIGjW
	 SP+qAbHTq5/Lr/a6lKdRKxl2xry2ZEOE/YCNqRXBlZPGvs5/nnMgT9/44/plzNLojc
	 mWdqj/WYxMyW+PxZGEnMTCVGvtObgaHO8wY29NEceOHhubsd0othXg98p1UglBFUJZ
	 5b+KxgHbkLSszBF9CO34djoKEGtrrNvgp6+Pjpgmml8UV945ZKFw8nxV6mmcOi5Ztz
	 0G/PnyS44l5q2As9sqRvEKQ8ZBYsbaZP3ny0fEC1StVHl44KvSzTi1qawoIV0nJ5lJ
	 a9aTDkakeoEAA==
Received: from smtpout01.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4YyB091DLFzwhg;
	Tue, 18 Feb 2025 15:27:21 -0500 (EST)
Received: from laptop-kstewart.internal.efficios.com (laptop-kstewart.internal.efficios.com [172.16.0.60])
	by smtpout01.internal.efficios.com (Postfix) with ESMTP id DEA352A4B6;
	Tue, 18 Feb 2025 15:27:20 -0500 (EST)
From: Kienan Stewart <kstewart@efficios.com>
Date: Tue, 18 Feb 2025 15:26:39 -0500
Subject: [PATCH v2] kbuild: Add missing $(objtree) prefix to powerpc
 crtsavres.o artifact
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-buildfix-extmod-powerpc-v2-1-1e78fcf12b56@efficios.com>
X-B4-Tracking: v=1; b=H4sIAP7stGcC/4WNTQ6CMBCFr0Jm7Rim5ce48h6GBZSpTCK0aRExh
 LtbuYDL7+W9720QOQhHuGYbBF4kipsSqFMGZminB6P0iUHlqsxJ1di95NlbWZHXeXQ9evfm4A2
 2dVEwaU32oiGtfeDUOsz3JvEgcXbhcxwt9Ev/OxdCwqLMU6mjSlX6xtaKERfPxo3Q7Pv+BYxLi
 nrBAAAA
X-Change-ID: 20250127-buildfix-extmod-powerpc-a744e1331f83
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>
Cc: linux-build@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>, 
 Kienan Stewart <kstewart@efficios.com>
X-Mailer: b4 0.14.2

In the upstream commit 214c0eea43b2ea66bcd6467ea57e47ce8874191b
("kbuild: add $(objtree)/ prefix to some in-kernel build artifacts")
artifacts required for building out-of-tree kernel modules had
$(objtree) prepended to them to prepare for building in other
directories.

When building external modules for powerpc,
arch/powerpc/lib/crtsavres.o is required for certain
configurations. This artifact is missing the prepended $(objtree).

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Acked-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
Tested-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Kienan Stewart <kstewart@efficios.com>
---
Changes in v2:
- Added Review-by/Tested-by/Fixes/Acked-By
- Removed mention of possible work-around for external modules (while
the build will pass, `make modules_install` will fail)
- Link to v1: https://lore.kernel.org/r/20250127-buildfix-extmod-powerpc-v1-1-450012b16263@efficios.com
---
 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f3804103c56ccfdb16289468397ccaea71bf721e..9933b98df69d7f7b9aaf33d36155cc61ab4460c7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -58,7 +58,7 @@ ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
 # There is a corresponding test in arch/powerpc/lib/Makefile
 KBUILD_LDFLAGS_MODULE += --save-restore-funcs
 else
-KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN

---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250127-buildfix-extmod-powerpc-a744e1331f83

Best regards,
-- 
Kienan Stewart <kstewart@efficios.com>


