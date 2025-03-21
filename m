Return-Path: <linux-kernel+bounces-570905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0FCA6B614
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8473B4223
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9E71EDA12;
	Fri, 21 Mar 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iTca1BuB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OdgZlRtq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EA1E5B7A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742545899; cv=none; b=mp2zJ2N8K4SMDFS5CckQZaGnkJlNWoczUKJNSbrKZPet6LlOKlr6RoPB02fzzDKtDH/4bfK8waDP7WZxAja/AqMJD8xWRU3V2CgHSMNKbOQiSAN5SjBXwVK+qPiWBk9YZDFoG0Akp+/AatBHxDcXmLnMHLLWdpAQEiS76eaQD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742545899; c=relaxed/simple;
	bh=w67sV3RD+2GRSUy/DQRUHA5lQkEDkf+DskhxkbJH2TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pnONpku+4RsMosgCNXUhs4Ez/+NdHnDn6pO6TRSpi8X/pfTIeaZSYTeM8JiWxt3vRVcyMNUxElX7I4zB/2hbTFpqgDM8W9UVR+NDreJO+AuR1Y9RS460FJDeIwabpw2jFvxHG0zBy9yAapi1uugJDhJR3j1qJQ7cVfVzLgarKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iTca1BuB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OdgZlRtq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742545890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u1AkDLAGIDODrtA3jsifi5T+wp1kqKH2Rd6dxGPn+j0=;
	b=iTca1BuBF13GOmUd7mdJuHkulC16jBoqhpHDfulGVuiKyLkljPXh66uQowEKZp2vfPCA0t
	hZ17mg24s4WJvVplN1GKO4GzzIlyN6Rb/RmTFOzjzaG7fItnyA7uapkMw5bf3Y2wIqsYLT
	2xhbvIEFDoB70eUrreskRooqwEAzAjFimspmKDpN4QmM2ECccjkamBMQUashnsTFzn/Af3
	u/HN+EfAi+9gRzgXqYGzpYF1Ibm5X8+97Ddx0rc6zZnnBRjyyc6tgeFdQXuTO3WGcVf97e
	TQBI0B6NZ11pPK6sMQnwhoGDbh1AZs84tMcUOeV856FvKxwyNZLhkruGUO7gZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742545890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u1AkDLAGIDODrtA3jsifi5T+wp1kqKH2Rd6dxGPn+j0=;
	b=OdgZlRtqcWH25bg8Qt1fp9CvT3DLAYe0YR8ZJLNiiOwuDPvgaEm119hp2cwn1gCpm2ELp7
	A1iO6NG/Hk+FmdCQ==
Date: Fri, 21 Mar 2025 09:31:17 +0100
Subject: [PATCH] tools/include: make uapi/linux/types.h usable from
 assembly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-uapi-consistency-v1-1-439070118dc0@linutronix.de>
X-B4-Tracking: v=1; b=H4sIANQj3WcC/x3MTQqAIBBA4avErBP8yZCuEi3CppqNilNRSHdPW
 n6L9wowZkKGoSmQ8SKmGCpU24Df57ChoKUatNRWGq3EOScSPgYmPjD4RxjXd25R2livoGYp40r
 3vxyn9/0A4b+Es2IAAAA=
X-Change-ID: 20250321-uapi-consistency-38648d1235c1
To: Thomas Gleixner <tglx@linutronix.de>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742545889; l=1614;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=w67sV3RD+2GRSUy/DQRUHA5lQkEDkf+DskhxkbJH2TU=;
 b=NeZHrOruCOfCpqctrEtwL0GI653LhSDc56BWNxWDQZlikSUNW9eyZ5ZDxiMufD4srR/YqRaHe
 wF99uUBQd1YBncHmvtFQ6CNRCa5BiYeYCD85HlqpW3qwQsSRCKnRzPE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The "real" linux/types.h UAPI header gracefully degrades to a NOOP when
included from assembly code.

Mirror this behaviour in the tools/ variant.

Test for __ASSEMBLER__ over __ASSEMBLY__ as the former is provided by the
toolchain automatically.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/lkml/af553c62-ca2f-4956-932c-dd6e3a126f58@sirena.org.uk/
Fixes: c9fbaa879508 ("selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Intended to be merged through the tip tree to fix the arm64 selftest build
failure there.
---
 tools/include/uapi/linux/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/types.h b/tools/include/uapi/linux/types.h
index 91fa51a9c31de1496db9a31c90fa95760adc664d..85aa327245c6874e673f9ed0466698487215c655 100644
--- a/tools/include/uapi/linux/types.h
+++ b/tools/include/uapi/linux/types.h
@@ -4,6 +4,8 @@
 
 #include <asm-generic/int-ll64.h>
 
+#ifndef __ASSEMBLER__
+
 /* copied from linux:include/uapi/linux/types.h */
 #define __bitwise
 typedef __u16 __bitwise __le16;
@@ -20,4 +22,5 @@ typedef __u32 __bitwise __wsum;
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 
+#endif /* __ASSEMBLER__ */
 #endif /* _UAPI_LINUX_TYPES_H */

---
base-commit: 652262975db421767ada3f05b926854bbb357759
change-id: 20250321-uapi-consistency-38648d1235c1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


