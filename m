Return-Path: <linux-kernel+bounces-563626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6CA6458A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2C816C81B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8EE22171B;
	Mon, 17 Mar 2025 08:32:02 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E66D2629D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200321; cv=none; b=NrwaMM1piDXk3WjpYah1OEbSCcApMPW4CnkksaAYpQ4y3BTcD5WTrtoTM6d4/hjyPYcctEXKZ9IfZkWApR26pGYCccLlK/onZGs1f2AqrodYlJTAa6k3ooxDRjUKaradP48QnKo5n0WQBya8e8jDVmii/KDrS5uIbdA/xnwspEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200321; c=relaxed/simple;
	bh=0hTlN1XUzNR8sJlUM5E9khwlIeJtFbebJeQTl3tA4ts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXsvgwOhIs3J48kUYu/4UP3XrAzo/L0Eb0ec7onr0iJYMM+fRIACacGqjPh8J+gJNNXdSDbivlDFS9CfoLDSGL0x27n6enNvEpl0hjhyq3HDFkwoaw3Hl0cS+aphpN6OMvJQh5ncZTXX9MpFDwHU2ykua7mB37gPcYPJ5derDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 42bf6580030a11f0a216b1d71e6e1362-20250317
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c03f0eb4-6149-4105-8cf3-b3466abafae2,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:a224ae872dd280008ad123e8ee58416e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:5,IP:nil,URL
	:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 42bf6580030a11f0a216b1d71e6e1362-20250317
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <zhangxi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1236381295; Mon, 17 Mar 2025 16:31:45 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 1256716011394;
	Mon, 17 Mar 2025 16:31:45 +0800 (CST)
X-ns-mid: postfix-67D7DDF0-9653161327
Received: from localhost.localdomain (unknown [172.30.80.11])
	by node4.com.cn (NSMail) with ESMTPA id E08491600052C;
	Mon, 17 Mar 2025 08:31:44 +0000 (UTC)
From: zhang Xi <zhangxi@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: yangtiezhu@loongson.cn,
	yijiangshan@kylinos.cn,
	zhangxi <zhangxi@kylinos.cn>
Subject: [PATCH] selftests/bpf: fix the compilation errors caused by larchintrin.h
Date: Mon, 17 Mar 2025 16:31:42 +0800
Message-Id: <20250317083142.561104-1-zhangxi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: zhangxi <zhangxi@kylinos.cn>

On the Loongson platform, the header file 'larchintrin.h' is provided by
the package clang-libs, and it is necessary to add CLANG_SYS_INCLUDES to
the compilation command.

Signed-off-by: zhangxi <zhangxi@kylinos.cn>
---
 samples/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index dd9944a97b7e..f459360c99bc 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -337,6 +337,10 @@ endef
=20
 CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG))
=20
+ifeq ($(ARCH), loongarch)
+CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
+endif
+
 $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
=20
 $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h =
$(src)/xdp_sample_shared.h
@@ -376,7 +380,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_CFLAGS)\
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
--=20
2.25.1


