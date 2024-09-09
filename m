Return-Path: <linux-kernel+bounces-322068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C6972388
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CF6B2398A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579E1891BD;
	Mon,  9 Sep 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0PhXY9y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439418C31
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913284; cv=none; b=eLfuCExJpWd86A6yZldDIQVmfxT3UyVTr1FkFKRhqdM/NFVxmYbteRHyix0CVw7ues6TFsYtBkOZu7QFSTjyjn+RwQwZU4+R/yXcANNN/5Nnzrh0le1HQrc8AqEsTBhnV9LlRSjPDCApyQiE7UpaFRSD0KyEuMpHtz5IAj/am0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913284; c=relaxed/simple;
	bh=XacvQmLHyej2ATwCXc/vBK/JKb6SROxDmmREBXVWFbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mWezsRjiHROS1niqf9dhPhduRUnNG+SEIs0nJiFJM4WsvqfXXPOE9Vl3GOgRuY4MfVVGZyMgN+4on/hYowwtBMMMH5QjSwnrcnKjzTqb6OyCM8PvyXNXT9w5eFm/YbluZH+n+cC+4qcK5PRP30R5niEotbQgKPA9M+bVAVeRwxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0PhXY9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6406C4CEC5;
	Mon,  9 Sep 2024 20:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725913284;
	bh=XacvQmLHyej2ATwCXc/vBK/JKb6SROxDmmREBXVWFbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=P0PhXY9yvs/DbpLEGQztlMariq5JE01WSDTNdfTRHbCi09JYGgmgUV+KiSkW3Ymuj
	 YJTLyAL3IKjsQtFeE/4YZpH+7AnQfHFr1vLx2yky5BK/Hvnv0JuDe5pG/xSwY5KgWm
	 8Yhi6QuFtV/DiJUhdNgCURJOYues4ftXSFXF7iSOXwarC/4sv2juJfPhQ+XqrrOwi1
	 riOEJYQbiReqmbrURI1LIPpKowlSj1Un1JTjqXUBIkPIvNQwImZ43a38t4mxgNZOnr
	 ea1VLXaU6qDdpGIkaf8LpujjgPNVso11LlHlY7vyiEQQwkrUKpTtt4F9j+vCVl9xN2
	 Rr0ijI7BviNFQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix link failure for TCP auth
Date: Mon,  9 Sep 2024 20:21:09 +0000
Message-Id: <20240909202118.811697-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The nvme fabric driver calls the nvme_tls_key_lookup() function from
nvmf_parse_key() when the keyring is enabled, but this is broken in a
configuration with CONFIG_NVME_FABRICS=y and CONFIG_NVME_TCP=m because
this leads to the function definition being in a loadable module:

x86_64-linux-ld: vmlinux.o: in function `nvmf_parse_key':
fabrics.c:(.text+0xb1bdec): undefined reference to `nvme_tls_key_lookup'

Move the 'select' up to CONFIG_NVME_FABRICS itself to force this
part to be built-in as well if needed.

Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It may alternatively be possible to rework the code so the
keyring is only referenced when CONFIG_NVME_HOST_AUTH is also
set, but this version is simpler and leaves the code unchanged.
---
 drivers/nvme/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 883aaab2d83e..486afe598184 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -41,6 +41,7 @@ config NVME_HWMON
 
 config NVME_FABRICS
 	select NVME_CORE
+	select NVME_KEYRING if NVME_TCP_TLS
 	tristate
 
 config NVME_RDMA
@@ -94,7 +95,6 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
 	help
-- 
2.39.2


