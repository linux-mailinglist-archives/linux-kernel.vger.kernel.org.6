Return-Path: <linux-kernel+bounces-265319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8593EF72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCBA1F22991
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4836F13AA4D;
	Mon, 29 Jul 2024 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kApuzOnA"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FCE13A257;
	Mon, 29 Jul 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240482; cv=none; b=fPSPmdb6Y4BSgqy/WtNM5hTs8naGW9DnSLAPLIKeOB8V19UGxC/YfZw37QWP8/u9iu/fYL5G00shE3oVKvljKUL+QpK9bISbW5CBadomg43z50jR/LvnIhq6W35LeIXlwsLyD/CQD/quxPbcTXPQgimw6qfJE63P2+vQQDoUMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240482; c=relaxed/simple;
	bh=I7McRNfd0YFb7EoluPSGSJoNcxLGn/rQbtZYiaNosA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BhlRkH8L/hTrNj6IOjvVkxO8M6zgnVDPw7c/jy04QZaFptXXF9Dak+iJ+29sR5OfElWXHbg1OhcA+JpwMwKzsFccB6r0eZul636zL/g2RZUudKJe30JXZLtLmysfR4YHVazsqT7XKr8ZaXqRox5ikW8DLdPg/8uT7bz7h7TAWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kApuzOnA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so1795037a12.3;
        Mon, 29 Jul 2024 01:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722240479; x=1722845279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oHGbGSlCPxUn+ZqN5G7b/1110cnb669ZP9PtOzndk3A=;
        b=kApuzOnAwiWdGZc+imQSKofYSvk9oC8j2ELq9P/ynHAA2RSMngntsVwBCVhSmfqWaU
         Bv1sg8WyLJxG0vPweiaEQPKN0rKZlLYYz4waJH/l6vgocNQfhQulU9TTPqZnUZC1IqFz
         d9S9KzU8+Rn4Hly4u/mJsyoZYLT3bxqRGx/Y8EjVjQ42dUNofNJK7u/nHutU+0m0ai/U
         NBZDUPtEuVTp215LnJXUItDwv0O4XEdlES6SEm7winXzdzlDpNO0mVFVe959aN61taGb
         qLTiJD00Y3yRKH0s4KmPS56F5Gmhla2ssRO4db5Yt4xHlHcwFUu/uhrNmaZljvZ6boOZ
         m5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240479; x=1722845279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHGbGSlCPxUn+ZqN5G7b/1110cnb669ZP9PtOzndk3A=;
        b=gNluWwO+/0S6pmvbI8/wADjWJtbVWVaBlvz60TWajfjCnfoFTAHs8oSR0FsjLS0X/w
         NeBCu8yDOnEhUTURRlndzbL32M2KfiZXK76URW+qXmNgd8t6A13IxSCAVwfJFXMptZe1
         O1/G1MMlOuWjAJxsqYt6nf1AGsD8pk0Bsd5NlEDs/Mz3Q8sIvDRK2AyElXjSgRXCZkNT
         97gmn3ouYiwTKO4PbcXDiAKEJWRrOhPE66zmtWHIEzrsUj3VrEOgFKmOG76DmTQGL5DU
         9jULDxfudIMhi06zJAW8xoi7+yBvK6bmCluh+suvvkjY6dJZByFF0V4KSDtm4wjBRFsX
         VSHA==
X-Forwarded-Encrypted: i=1; AJvYcCU7F1atfpnXkylQc8IJL/km6RNDFYw2U3k6gi4eC8sGlO1pKymAcitgMocQMlsoiIe0R8fN9gHLvEQUtae3bk6sUA7OuxGzOdVTlcNO4Lx5OBSbX2KYeFiBU93ppZdI4yVU0/xUNfOR9g==
X-Gm-Message-State: AOJu0YxHWRdXQZqejf2/SwIxQ0wU0c7kPprciVbmErMo3nf68hvx//5z
	wtMFW+eDxlOr/TtkJLQaNN7v9xAArZwHn0uhauLtCksONdD7Z2pJ
X-Google-Smtp-Source: AGHT+IHs9KgAcOa/+4tdLzWcVj5u0ONMW3rbCctkdL6TLbFc9+DUAUi+r78D/O91WFvdo0PaUJ2YXQ==
X-Received: by 2002:a05:6402:13d3:b0:5af:758a:6934 with SMTP id 4fb4d7f45d1cf-5b01d37bd25mr6190904a12.0.1722240478838;
        Mon, 29 Jul 2024 01:07:58 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590cedsm5352868a12.29.2024.07.29.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:07:58 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org,
	John Thomson <git@johnthomson.fastmail.com.au>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/3] nvmem: u-boot-env: error if NVMEM device is too small
Date: Mon, 29 Jul 2024 10:07:31 +0200
Message-Id: <20240729080733.16839-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: John Thomson <git@johnthomson.fastmail.com.au>

Verify data size before trying to parse it to avoid reading out of
buffer. This could happen in case of problems at MTD level or invalid DT
bindings.

Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
[rmilecki: simplify commit description & rebase]
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: New patch in the series

 drivers/nvmem/u-boot-env.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 936e39b20b38..593f0bf4a395 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -176,6 +176,13 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
 		break;
 	}
+
+	if (dev_size < data_offset) {
+		dev_err(dev, "Device too small for u-boot-env\n");
+		err = -EIO;
+		goto err_kfree;
+	}
+
 	crc32_addr = (__le32 *)(buf + crc32_offset);
 	crc32 = le32_to_cpu(*crc32_addr);
 	crc32_data_len = dev_size - crc32_data_offset;
-- 
2.35.3


