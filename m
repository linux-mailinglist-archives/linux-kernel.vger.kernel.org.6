Return-Path: <linux-kernel+bounces-222967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759F1910AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E381F22FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4D1B372E;
	Thu, 20 Jun 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="A8ZDck3R"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE401B14FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899256; cv=none; b=bNU5KeG0wqBgvzpMb/R08UTeV6na7sDLKE8PZV+CYwbMhqnUR6rHUDqUiEKItiXSl3M9Oib0fBnOhcZYHDtWpEQDrqnmXRT/ilNUpfcvVjDpBQdId4aUdfEH7cAY/n7GS+0oOryHjPs4zF9x5JjrKPZDoAWVjpwXcd6oT/TKVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899256; c=relaxed/simple;
	bh=uAqg6i1FR5JV9+hsH2qU+nQN2NHm5YnaYxjtZoNFoBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHr0UtPcxWTKWlo+NTJZu9OWTRkPHh6lv8yumhfhtCFMEW5IFFrTPnCt0CXwco17mLFS3YdxjxrEMOkKeLyovhgeDwqnVP1sgRqcy6X9+UUm8nnKP+kKv0LzQIUPQdpptDVJ8XqAZmMnYlGBpVwRvhdkAWevUHYy1hZjhcOwsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=A8ZDck3R; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718899249;
	bh=uAqg6i1FR5JV9+hsH2qU+nQN2NHm5YnaYxjtZoNFoBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A8ZDck3RHTgSIZl0GPrPK6sHKiZWk4DZCjcWPTafmwX4okpEbE2SkMrnNGBdDcH9d
	 ASeV0hyRx8SW3kjtJ5d+uFL3pe5YxDCW687y3tdsr1uGt5exMrwxKjHlNy79pUag8E
	 EdrtMUstAjV2/9z3mqvkHBIGyEajgf8/kOUL88hM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 20 Jun 2024 18:00:37 +0200
Subject: [PATCH 5/5] nvmem: core: drop unnecessary range checks in sysfs
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240620-nvmem-compat-name-v1-5-700e17ba3d8f@weissschuh.net>
References: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
In-Reply-To: <20240620-nvmem-compat-name-v1-0-700e17ba3d8f@weissschuh.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718899247; l=1462;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uAqg6i1FR5JV9+hsH2qU+nQN2NHm5YnaYxjtZoNFoBc=;
 b=v99R64pvdtrw/Mdgi/x7kWG51vnxlYXGRQ4ja4ax0ptKPeiG79nacgSUyTDr1vO7zFq6QYd9n
 enX4+aswZN5A+y5BQO3oSOJYpzvl09IYnar7SxlEhfjqEJGIz0OwN1s
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The same checks have already been done in sysfs_kf_bin_write() and
sysfs_kf_bin_read() just before the callbacks are invoked.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/nvmem/core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ed077d7e3998..5c1ee7f0da0a 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -203,19 +203,12 @@ static ssize_t bin_attr_nvmem_read(struct file *filp, struct kobject *kobj,
 		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
-	/* Stop the user from reading */
-	if (pos >= nvmem->size)
-		return 0;
-
 	if (!IS_ALIGNED(pos, nvmem->stride))
 		return -EINVAL;
 
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
 	count = round_down(count, nvmem->word_size);
 
 	if (!nvmem->reg_read)
@@ -243,19 +236,12 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 		dev = kobj_to_dev(kobj);
 	nvmem = to_nvmem_device(dev);
 
-	/* Stop the user from writing */
-	if (pos >= nvmem->size)
-		return -EFBIG;
-
 	if (!IS_ALIGNED(pos, nvmem->stride))
 		return -EINVAL;
 
 	if (count < nvmem->word_size)
 		return -EINVAL;
 
-	if (pos + count > nvmem->size)
-		count = nvmem->size - pos;
-
 	count = round_down(count, nvmem->word_size);
 
 	if (!nvmem->reg_write)

-- 
2.45.2


