Return-Path: <linux-kernel+bounces-184905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F248CAD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A481F231A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518F07C097;
	Tue, 21 May 2024 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE2HJc/Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C17BB1B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292160; cv=none; b=MfV/7n1io69zT7BC6kwxCbOfU2LoRH5shqevgxPBL/8VtM4EhgptAW5ZSYEoBaBIwIInXQJ7oBWdBA+hgmnpSTmPTmu+DP7nT7rYEYdtdkl9Oku9E9M3K2ETZQnFpQpbWCyxJz+2WNs3Q8jYD43jCKBGAxkv2sHAsR0rbqbi/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292160; c=relaxed/simple;
	bh=kYHsD4H/RUxm26ELjeG4CcFUjPg7NPg0mup/+DL8qlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUVUD9qrymhS4x+e5wzGWSQf0G1HUwd6VAmHz/ZrqevqmC3L9rCBfUYH+88LiLpMGDJsbCft3jd3RUkbC/FnHirxiM6mCUcx9yPLWmltGa4nUc4G6UHcem7bB+5KHYbMrPCYo44/Q3+LG3pHcpvPp3rRc4qVJj77E8CSPP4p0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE2HJc/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D227C4AF09;
	Tue, 21 May 2024 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292160;
	bh=kYHsD4H/RUxm26ELjeG4CcFUjPg7NPg0mup/+DL8qlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AE2HJc/Zo839RiPkn077HFAru7fuQ3IdqockYIAAK4zrgbbEvq7k/6D1z1skg/3ef
	 RBh4dJwbAkn6gux0u6dNld3GBZYMx2VqFWHEMI0zvFmccCkrfEHAR2ddpZ24phAuqa
	 mI0SCQ+ctgny3cFlc2/TsvQRGX/sEZoIceuOrAT0CeIc90szt7ePzoutW/5i4kLtFF
	 qDWUDAGevJg9PqJeLprnBHn6L2mH7CMZnVN2piLag+A9h5W2rL/rpWPDEtL+u7oND2
	 9e7GTMsDYuPcl9ftqfNlKcpfbLlW30egyyPtb5iTFjfLza91IxsO77cTeetIR+UAPT
	 cyOonut+Y4MSA==
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
Subject: [PATCH v3 8/9] virtio-mem: Enable virtio-mem for RISC-V
Date: Tue, 21 May 2024 13:48:29 +0200
Message-Id: <20240521114830.841660-9-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
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
index c17193544268..4e5cebf1b82a 100644
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
2.40.1


