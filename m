Return-Path: <linux-kernel+bounces-202285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157CB8FCAB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A002D1F22F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD4199227;
	Wed,  5 Jun 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe2kjdHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941C199221
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587718; cv=none; b=CZLUO7JWV7/B2b1GhMpwnxrg4WOqcKQhmUaUtldY75d6iKD0ceDI7VGzlcf4n2LFnLoh0NOBAm7AK0/QcCZ6+b044iDaE7RirR52BB4bN3K6WEom12oSrxawwB1hyh5uJfjfFq0J/XDpYD5a7mS6KGOxIOK4xuoeRwC60EodQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587718; c=relaxed/simple;
	bh=cNH/faxi7/uMHF3i5ru1TGKN5bBuB3CG9oyUregFlwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBoq+KdEm8tr948anJ580GkaeY6tvxfqjAMUW0s4ytkvbbrI1aQ6hRYErXkf7evGmaVvSFjpTAOeeAuVIxXnizA4Tq5h5p8EM9h3WL4ucQvWFt/1BEeyKsUndHl9yz3QTVtwrMdRKO1YUQY/dL/rZd6HtnAVAkhZVavV5WswgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe2kjdHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9B6C3277B;
	Wed,  5 Jun 2024 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587718;
	bh=cNH/faxi7/uMHF3i5ru1TGKN5bBuB3CG9oyUregFlwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fe2kjdHr8ojoEyfXhgZTloB0ifMmIHOiG5DKKusQ7Sy/pLVBqY69c3MDTz/IU9Zgo
	 MOhwVt+ahqsvED2Vp8J9R+Q8ubBgqynFng83NWmTihwz/P2ChTKelcdKT2bUChXFK9
	 XPcoo8c3N4IbEGXTynF+kAx7m1dH5G/PPGoikssoDmop+tc7FNpWuiccwDm0/0jsfe
	 H4f2dL3LvdfbCWfFtqsONnn/c9csqEX1jG6HQnp4UkSH/eCSeScKzEtuXeHHntRU0w
	 WP5qZvrd9lyHDBzgPM4+Zt64wDTLbmT3TRs6NhwxTl4SmXf6mkzAM5N7uV58/eSTTK
	 ItWw6ywddPduA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v4 09/11] virtio-mem: Enable virtio-mem for RISC-V
Date: Wed,  5 Jun 2024 13:40:52 +0200
Message-ID: <20240605114100.315918-10-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Now that RISC-V has memory hotplugging support, virtio-mem can be used
on the platform.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6284538a8184..42a48ac763ee 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -122,7 +122,7 @@ config VIRTIO_BALLOON
 
 config VIRTIO_MEM
 	tristate "Virtio mem driver"
-	depends on X86_64 || ARM64
+	depends on X86_64 || ARM64 || RISCV
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
-- 
2.43.0


