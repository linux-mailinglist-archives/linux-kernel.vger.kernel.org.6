Return-Path: <linux-kernel+bounces-178786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1E8C57A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95CD1F235BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3F5147C84;
	Tue, 14 May 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLn+SxlD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB1144D0E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695535; cv=none; b=h1S74MQQCi1NSQ12XOrwhhXN77vKn4h2wMWaqSaoWDAY5lQw/uiRsRr+nV2lpIUuYa91fHqfJRO1rAzlpoqm9sP62hU+KCLJ49YiOJ8jiJXjAleZJNQJ86LTTNnLQX8aUxSwMME6giGzm5xzcN13m5pWDGNgWYDpCQt+e1J3qqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695535; c=relaxed/simple;
	bh=QKyUQtzdUFj7E7VWNazUrxKopSKCrJnxnXXoOO9I0K8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1NCSC5DOmKABnvRjNwL6MA5kqAgCx0XdZZ+kL4mQGrRpqhw3pDKiH8D1Po/t5omJM5AQ78zgMB5wg8i2Z8Zvga7KLZ7/HqxlBQMAFGvNBlWyVsZPKaAH5qT0ThOr+g44Blra5sAebLNyqNITgmwn8UUEx9kssY4zXAWorAV2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLn+SxlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83515C4AF08;
	Tue, 14 May 2024 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695535;
	bh=QKyUQtzdUFj7E7VWNazUrxKopSKCrJnxnXXoOO9I0K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLn+SxlD8a96Vi/A8lM2sysKVhH0gslhMRcG6/RFuCTRCj2QJXz/7tp2j4DwGGwTh
	 3s6+5SUO1nIjpJAF+WtJvgA5aYItK96Sb3keVQ5qAfR9fAiDhQy59AoJmhOA2XrWK0
	 ayQTEDyQFC54D6M7YKYx+IH/4KGsZRVrjgQhbTKhXcfDLpAlCxTd0vf7jvzMqhg10D
	 FNo9crb1rFcLhNsxwlSJXLQJLbLFUx+Vn0fV6a2SnBO6Ql/K2f7S+Cub2+7EHXyNVt
	 uL67hybo+QeRgGEosWl6aS/r8OQD0+M4q/Pkdwp8hNvF8RE8kn0rk6udwYclskf6Ei
	 XJ5CR8WHHNG4w==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 7/8] virtio-mem: Enable virtio-mem for RISC-V
Date: Tue, 14 May 2024 16:04:45 +0200
Message-Id: <20240514140446.538622-8-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
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


