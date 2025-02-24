Return-Path: <linux-kernel+bounces-529861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD7A42BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5533A8A25
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4A265613;
	Mon, 24 Feb 2025 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="X4rhBrlH"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D2D26139E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422905; cv=none; b=NnbrHRREhTi3sobmkDY01oD4hpYj3JS727Xk+QpmkMA+DiJwOPenDi/btldRIrQ/rNIQ4LZ/fhh4SRTQmhdeAKH3gM1pCC4q09NoNZMMe8uSN29khYJoP51RrkuYPaL82ydegImsPSJpl0dO8Nrfw86gOO30tzEqpHkjIHSVPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422905; c=relaxed/simple;
	bh=c9FmoDp3PaHrqE+N50GB08xtmwJnQhv8KhJYRlaoG70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFksU4HGZfrX5B7rNQeV7/CNvCuf955aUBNZNNgqBt50NGhfrfRMAqdibLjsj/XbtY9+227TgwFXA2lXD1Uru7Y1klL3T89hkNupoGBJsvKIAXofIaYSCyb0EeP38FNhRSJyFQVAyThcILYyxcvfTArP9210oGp/ZWmvbHZDly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=X4rhBrlH; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740422874;
	bh=LdznF9ERV5Exu9jDB/bXwYEnrEHTC5zkEFrUdZXh1Og=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=X4rhBrlHkk+vu098EaMxtbd1zYud+lCqS96UWpSCcP2L7aaNGdGDhABiWja8aJEH9
	 LSE09+fd48nS++wq/b7pERPiz1pjDf1um9WBdCR+lX51j6Rotb5ffM8v7hUGYpBwgL
	 a+7ns9Hbnw/7ZZh/QZ8BgEyr0ABP3ujfhxzFpZ+I=
X-QQ-mid: bizesmtpip2t1740422828tcu60qx
X-QQ-Originating-IP: 0fqbesBvKRsKb+H9rroaWBcv1B2Tw7pk99o3FdnQO6o=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Feb 2025 02:47:06 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5810614758835693709
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: wangyuli@uniontech.com,
	maobibo@loongson.cn,
	guanwentao@uniontech.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	chenlinxuan@uniontech.com
Subject: [PATCH v2] LoongArch: acpi: Eliminate superfluous get_numa_distances_cnt()
Date: Tue, 25 Feb 2025 02:45:55 +0800
Message-ID: <0301CBCF511C5594+20250224184555.1562943-1-wangyuli@uniontech.com>
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
X-QQ-XMAILINFO: MIXpHopat2Ia+jYOASITMX4mQZUsdsMEGV/SCRAoATfkCW7195w41Qn6
	QO2HKssy72X4Lc7I95C0l0xJz1j4BNQCRlltVH9//itcf023+UdoQIXk8xWPFIZEzR1WMS+
	hyvzb0S3aKmkru3SJoN5R9/RRHYmsqwG6FEngB0SODj67iQyx7fqhG6Zc72V07DG8oGE4yo
	lrz3Vme9Ay5qd3oWKoTGvSx07Ligmc/WF6UH2hoDRefO8XbnBXirbQoxIbCrkjk9YzxRm+i
	5Ue/FuMjERTKPuUGZYiL/iwoEbwsuy57TGpfiBKJy8Ifp0JMjBvmek9eh0qB6U9SzTnXUc9
	nN2G/LfyYY9vDgWyIfrS+EWOY+rycfW9y7Z5fUKrO6Mlcs3EH6ONXNe7aI0z86742DETTrg
	mqdmuC6z9xUeF8vG3NHP9G6nZh1yHDPD9t5OYq+epU9vq4UOJRGH8B5wWtQuNy+sUHlERlD
	bGPB4sjEBiBtSXqN4jBeIJ7yKi/PZlWuVCOstOIbgOsxNCFfNUTwYMO4rHBHeNp6K8T9o7R
	cAUzlmTDrjRxgv5lfOhzwPAt4KgG6pGKTCUK+raI1Qk7KGYhLzI9DBE0ohkKLh/RGK0J9B3
	N1rFv+lxmGGkGdEIkSEuuLcW1KkHFaWNQxQ4SF//5o8OALp4Iouf1q2E0W52ZP81xSSXMw1
	SRs98mdsS01s/luQo8HTXljVLOHhPEYfG9KBKEAxWDQkYWr9ZWRzunzKJ1nemJdfLnr6k9f
	Lr/NW8HiRSA6WmaN/5XPTDTTLkG/fsLRUQdoe5FqT1X66HnTRAUq6hB+qTbuDy6/MvuOnu4
	rXzNi6rHFrge2aBrWVj5hJ/gJh2t8WU1CsbUNvr0LK8e7pKxBOjqPxwQGb3klK9C0ejyUnk
	G1D61ojgqlp4Boe6sGYXJut9qIJWQMM/UlWjVoirQMf71lpQHpAyXH4joWXJbAx+6AKmBas
	NTeis4DqnAJTrtzxDUm7KImIhCxxCuHA2e3muDQSCBA9mmxk0nIbGPCldHhjm2lT3odkm9X
	1zEGz53PieS1FdqA/vO1YnNqfC3q44+GyJaruKQaM7GMWR+I5jWuGdlpw4asA=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

In LoongArch, get_numa_distances_cnt() was not in use, resulting in
a compiler warning.

Fix follow errors with clang-18 when W=1e:

arch/loongarch/kernel/acpi.c:259:28: error: unused function 'get_numa_distances_cnt' [-Werror,-Wunused-function]
  259 | static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
      |                            ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Link: https://lore.kernel.org/all/Z7bHPVUH4lAezk0E@kernel.org/
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2: Drop the relocation and one more useless variable.
---
 arch/loongarch/kernel/acpi.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index ee471a80763e..193f81920074 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -249,18 +249,6 @@ static __init int setup_node(int pxm)
 	return acpi_map_pxm_to_node(pxm);
 }
 
-/*
- * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
- * I/O localities since SRAT does not list them.  I/O localities are
- * not supported at this point.
- */
-unsigned int numa_distance_cnt;
-
-static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
-{
-	return slit->locality_count;
-}
-
 void __init numa_set_distance(int from, int to, int distance)
 {
 	if ((u8)distance != distance || (from == to && distance != LOCAL_DISTANCE)) {
-- 
2.47.2


