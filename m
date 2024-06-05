Return-Path: <linux-kernel+bounces-203024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A528FD549
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226322838F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609015380D;
	Wed,  5 Jun 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XH5mJeVg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD915380B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610592; cv=none; b=fvQ3aOVk88067TZw1MoHDxww0NrFYFujjH9Z2oe+IxX8lGbxBf1rm2bgZX9tTJKbSyqDofMk3PkHFk4EIJW337fY81nrlfsm+B+UHLphdU956ABXatGrsb36iu31DGd/6naHtqTiqwwmuK4cXypYxoLxQ/C2Jmp/plMOSmEVK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610592; c=relaxed/simple;
	bh=e26lRTuAGuJgmNX9Kn+IMmOklmBtw9bMfbnFAWkr9AI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFsBcjU90PAGWolMrfDHX7qNT9i7YPfFFPzm9ZunNfro4bwc1XLG+Uj6SANzd/ZtbTcX2T6+pgT/tb7DgBSr1ZAusCmjm0P2EQgDmHSXL4ihvQ7hmyVcbZ+x9av0wbpUGo/bXyY3MFkW/PK36AQIop7S8X3D/4jp0PZcqCjDGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XH5mJeVg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629f8a71413so473207b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717610590; x=1718215390; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqJdwI0kfu08l8zta4NZb2Dhq8rse0Xjye+A2f9mH7A=;
        b=XH5mJeVgmcHl8j+yAfDOF16fwTYZtKejt7N1AtlCr+jCLGqcaGoPbC1Z1OtBWbLeqR
         qu79bjTNXUQMB96hPCihyWcQ7C6/Xdw+CBz8yYYRpPef1O1wHiiuWHHNBbDn6basncKb
         feIXaxtnwyQFOXnN4GFHve22CLjHAlNw4tytPP/A1BS6KFsL/yDzrPALUUPMTBYiZfhz
         /ryZI+W919gn4EVH3x641KfCaNVJQjgsw4/EZWvrftTVoVBJm8vaVE+cvQcDoqWXj/KX
         CClLti2T1o6M0md9Eq1LS/CykQoF/EIHK2zXiNh5MwW8WJgwpltYQmZp/slPCc7x/UQZ
         lGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610590; x=1718215390;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqJdwI0kfu08l8zta4NZb2Dhq8rse0Xjye+A2f9mH7A=;
        b=qiWwqyqQwmYpuT16mp4G/nv0hwjUhwMN1OONVLrqrZetEKawuA74f0WzDN4H23/zeG
         byXQMwBmWQejfpcLXpy/aNXk54kBB7lViUV2kpIeQ2GtVza+q9TnGGU8CiivnEqeVueJ
         tshTnkTrAGhZcYHf/TEgd1bT90s7V51296szwQ0hcqqso+qdphxdU+dAb2k4RVp3v9YF
         44Q1fbp+KsW88/qrksdW4UJbkyqTwcQJBfS4MrHSF6Vu6nhrNuIUNMYQwaF8ug984SpR
         A3KSY57qmWiWbkUZ7TgR/b6ejJKEQsqrJ3/17JeLInOJtUmCu79u0ioJyhl9WwozrEzz
         XGAA==
X-Forwarded-Encrypted: i=1; AJvYcCVy52pRaCZ4i9lCZn238/czTqf6fy0MtZUHFlI/2Hy0zPbEnTvBV0F8dNS5qf4S7ZHLcXWnw27bZOzU/Ho1wbXPb33fhkZ7uEygIOgR
X-Gm-Message-State: AOJu0YyBKlkogdEg/UPlboEe7XgVzauCHKhKxmlbxYcTnUaVPK26cFyZ
	HX2fCj/VA+BLXoaeVQQ1JKfdebMXcuc0vguk0eTC+2PKQ5biUQO3o+4dHNSdklwJcqa0P2s5A58
	0wrZABB6SIg==
X-Google-Smtp-Source: AGHT+IFarMTHRQyaGAXOhvjvZC3Ev9S2zTS3Kvs5hpqZrMnxro2/BzrazXCSnRirdCi4qPaGa/c0QONTMKwCWA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a25:d608:0:b0:df7:d31b:7a29 with SMTP id
 3f1490d57ef6-dfacad1dc1amr763889276.12.1717610590398; Wed, 05 Jun 2024
 11:03:10 -0700 (PDT)
Date: Wed,  5 Jun 2024 18:02:37 +0000
In-Reply-To: <20240605180238.2617808-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605180238.2617808-1-joychakr@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605180238.2617808-7-joychakr@google.com>
Subject: [PATCH v1 16/17] soc: tegra: fuse: Change nvmem reg_read/write return type
From: Joy Chakraborty <joychakr@google.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, manugautam@google.com, 
	Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

Change nvmem read/write function definition return type to ssize_t.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index b6bfd6729df3..1b067dd8a585 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -96,8 +96,8 @@ static const struct of_device_id tegra_fuse_match[] = {
 	{ /* sentinel */ }
 };
 
-static int tegra_fuse_read(void *priv, unsigned int offset, void *value,
-			   size_t bytes)
+static ssize_t tegra_fuse_read(void *priv, unsigned int offset, void *value,
+			       size_t bytes)
 {
 	unsigned int count = bytes / 4, i;
 	struct tegra_fuse *fuse = priv;
@@ -106,7 +106,7 @@ static int tegra_fuse_read(void *priv, unsigned int offset, void *value,
 	for (i = 0; i < count; i++)
 		buffer[i] = fuse->read(fuse, offset + i * 4);
 
-	return 0;
+	return bytes;
 }
 
 static void tegra_fuse_restore(void *base)
-- 
2.45.1.467.gbab1589fc0-goog


