Return-Path: <linux-kernel+bounces-233802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F1B91BD98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59F81F23BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BF15884B;
	Fri, 28 Jun 2024 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHkMu8tY"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFE157488
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719574635; cv=none; b=SQ2ClwyNSkf9OI/0i+wYYwDeotLWw6WcMnBU3p0NTUloNwYFok4CFmokdbQbK8HGS3xTOE12nlu9AxyMAVMKA/cuUsBzHisSUeEylbND81G5XoQxci9TzEr/VuC5/Ey8el82kBvStFP+ChGhq/gTjwsyAGJiuOoWDleebJU91mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719574635; c=relaxed/simple;
	bh=AB8J+iZrZaFjCJLdHR+aQydmJFfAV4W2jBf8xJ1slms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+IvQFE82p0kvXH0xWJ5ExZarXYHaeMsQ5ZZnQwDLrcqG6YQu7Kh6++GslZIsiPuK43IlW87zwkBKgVMrQeYCyVSSfBM5+yuQDhgOTh1Srvg1YJNEmsszahzaOdV6Swso+o/NmioTcVuoxx0iTNUwU4UF/OXurto3q5jcfSNhXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHkMu8tY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36703b0f914so357257f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719574632; x=1720179432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNA2Gh8U8LmpmJPYkwIg20NtTAEf9GOo0g5n9aJKVOE=;
        b=hHkMu8tYD+hyqDQ0nQY8Mek7H8gkGbaYIWblcDcfjP/loQ+1p+LpWdpxj4IuD55ruZ
         Nvt4Hz3jzKMbOGNIf05bVv1QE+jcOs3nj2G6Ne9FsDF8772rP7pP0XKHlOwzw5EBQjqT
         GzZDeutr6beTNoZNaFPfIItj4bvddxHvWBKUQwWtkmpSgd3C66RdADh0cv7Xfnp2eHaY
         TAnjH07xsSjAJaeFiyOOq3iCw+jcYcBG9BlsIC3Zgy0EYHC7k8NCGZzc7LWPFiUihJQI
         PmOzSEzsadxFH0jPGeQylaQ5zLJemevunJzTsy3YoI5CTPWdozzenwLkCGFXGKPcW1ak
         3qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719574632; x=1720179432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNA2Gh8U8LmpmJPYkwIg20NtTAEf9GOo0g5n9aJKVOE=;
        b=Ix5bQAuAzidPkT1cTD69sEn2fDQ+MGfNC0Q8fYyLeVa70I2q0JMYTHA3KOnqAc6IUF
         QPg6TJy2B007B2BHmTYjSWD3EiSXzVREydkp/qLlhiwA4vrodanMKXhcDj9IMYxeG6tc
         dCs0hhaVpEH9FQw7kv6ZVOJyGMerKfcV7KOpq8mOmAtlSXjsn5OCzvwDptX0IWt2ecDt
         ubscFQ/3GeYIg8VpiBdF1TuJetupoZd3E05K7jQIsKvFKQdMNnVg8bqzGtSN47aNC5jL
         jlMKPf1kUSzt3yHlwWXY0WsOdzIFmgaMp81BrMEq/W7BYtznqA/erAGqsBdnhmlYwna2
         YCOQ==
X-Gm-Message-State: AOJu0YzkKReYHgq9++W6pyqUTisqgRubHAaRhgZGN3fKBNr0lwcosGZ/
	/z/lYSX1Zp418dAzmDaFBdzQ5J4AgmdPUQLUvd/OqJig+mH9MNbJ33siojMDoCc=
X-Google-Smtp-Source: AGHT+IEtQ2F/ZhnVsAtxFPenxSImh3RT49kp9cUCErX/CHqLmjJQdHe8xOXur99JwYwacWedK++COg==
X-Received: by 2002:a5d:47c2:0:b0:366:df35:b64f with SMTP id ffacd0b85a97d-36760a62fb7mr1704746f8f.4.1719574632423;
        Fri, 28 Jun 2024 04:37:12 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fba5asm2048937f8f.71.2024.06.28.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:37:12 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] nvmem: core: limit cell sysfs permissions to main attribute ones
Date: Fri, 28 Jun 2024 12:37:04 +0100
Message-Id: <20240628113704.13742-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
References: <20240628113704.13742-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=Y26lcDOMAGbcgW1j/vk529VAyqPSlMBhAzffwgYorYs=; b=owGbwMvMwMVYtfBv5HGTUHPG02pJDGl1C0JmKbU+Op1tfWi7YZZQjuqXsrcfn7eY/mf38PG9L CzxMUmwk9GYhYGRi0FWTJFF6bl/1LE/j759l7vbCzOIlQlkCgMXpwBMRCyG/X9Y2LTTp9nCVnTr ndli+m93dVaJd2PcSunc+07hdZtTYyavMTcpvHRB5sfuQEHJuctjiu/Yv9u9PvCfxdO6rddn6yv Y1Uz2PuOzKa3sWiPbm4Jn/zo2zlDbqu6m/Vf7abavbkaonfYsqe8KEj1zNbVTVVO+F0dWW/os0+ 0w1TF7zuxoojvTrc+uspjvVfh7R1MpkWRpdW3eKwFSsdIxqzn4jxRmKn98+5h5Q9wmNcffryI2/ Z3/J51BVeRkkpg7k/B0XnWtlQH+9+dE7jg0xdwj/Lx8s8KKCqUufl61FY6CNz126bV+dD6617p7 +SUjpueF5Z5dr3x/vdAo7/i566/HrbtbeVQ+7tu3Zs9aAA==
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

The cell sysfs attribute should not provide more access to the nvmem
data than the main attribute itself.
For example if nvme_config::root_only was set, the cell attribute
would still provide read access to everybody.

Mask out permissions not available on the main attribute.

Fixes: 0331c611949f ("nvmem: core: Expose cells through sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1285300ed239..f8dd7eb40fbe 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -462,7 +462,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 						    "%s@%x,%x", entry->name,
 						    entry->offset,
 						    entry->bit_offset);
-		attrs[i].attr.mode = 0444;
+		attrs[i].attr.mode = 0444 & nvmem_bin_attr_get_umode(nvmem);
 		attrs[i].size = entry->bytes;
 		attrs[i].read = &nvmem_cell_attr_read;
 		attrs[i].private = entry;
-- 
2.25.1


