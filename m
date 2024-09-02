Return-Path: <linux-kernel+bounces-311496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B28A09689DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD99B22782
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C1B20FAAB;
	Mon,  2 Sep 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2VslTIR"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BF179AA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287118; cv=none; b=byYqc4xqMqW2qbLbkwODDHyTxA1ykmt8jg+2Hzb1KgoFCALFhtJXzdS9cuZ0KulAtRYu4thf2qUBXnjtWxEGfv0uoPnlTlhsEvCAD74n2EHqSy8dwWQVViMeGd+9ZcU18IK2RttyISZjM+6T4mq9fe6pg5mwfnuzdtpNnuBWEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287118; c=relaxed/simple;
	bh=4CG8oq/vYMuNBOCx5s4uX05YG38PDhPb+WCpJA8/AUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrb24P6180SZLSpBQUIxgEUfQsW+4DJmW8zUnvlxSmB36+71r0of3znrhaDxaXnfuEE7oh44A8rJnblN5j2aueiDAmdwS+LpGPIqcdNpma3YW/G99rfQTTn45zYkfT0FAsPAbsc0I+y01Rikp2ALP96Mfzy+xU+EMHTiShKGbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z2VslTIR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so1426881a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287115; x=1725891915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgCbNmppKyX8JEumeR17XtMqetawKNlr4IbyYbzBYRU=;
        b=z2VslTIRVSutrQix5TTyyCtb8tROJqbgHybHomxTC+OvhGQwpHdU6xY90TD8RhV3Kz
         0+qIEh6oD0s0kOzU8eLZPj+Us9GHOOi5DF3DkmBy0xS7u6rUi0582kmU80X/OvbcuKf+
         QYHJecCKiXpRYhoCSf6rf5v3qFe4cl91Ef3bonmCdYXVedfeBA/G9xAConQLIZLxNp0O
         OsaqQQuy74Tl7HsV3Nxiu8P1yxI9lDqy6GBGWBdu9rAL0uPyteV+dZidPTbFcN6l4xYk
         pUTmk1E6V9cibrXkO9ze/c1q+ss4wCtcQB9bRq3J71YDhdbBvGoI6QVx8Kf9XnGulr+A
         f2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287115; x=1725891915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgCbNmppKyX8JEumeR17XtMqetawKNlr4IbyYbzBYRU=;
        b=XP37pXBcHYNGSbzF5fmu9HWvk8nCBPs3RyhkAOvB80O8NKfCeogxhC5N7Z1YagHa59
         F4gCGNcMdzq0s5bTyl2kjZRFtxP6v2dxDwfbuf2aazoDB+QHKmdJify9cq6jz9CFsbJV
         iLVppICLOsXpWXy/qgQ9kbzX0IVgVkJpyPwWMGd0vPpPANDByRP4ipymOclCz0a2+k5C
         GM4GcP646ZvdH+apbSiAdaK3LRSe9J8Sqt/1o2xwFcUdTM3x6bb54fAqIojETh2RrLcb
         KbjfFnzIP6kP8uGZ26GcV2u6FUmfwZ2N+28Su+bfC5Xs5hjOsSkIlBUiR10hWACa5mv1
         bQtA==
X-Gm-Message-State: AOJu0YzyKpW/p8kOoRf3ruXA6PMCvPS+kcodbEyeKfU4bptTQ9U+i4W/
	1FNInFMXpHleARsNSs9z+j77p+LISp/aNUrhff8WQhtAOjeKi9A0A+pNhy2jVos=
X-Google-Smtp-Source: AGHT+IFFp1dBCdzUehHmLwIA/IE5g+B70U37ICGgcdUYC55a33rsoTKERbMwfTVi1uy+6ryWFnfcMA==
X-Received: by 2002:a05:6402:51ca:b0:5be:cfb1:ceb8 with SMTP id 4fb4d7f45d1cf-5c25c3ad708mr2530881a12.13.1725287114897;
        Mon, 02 Sep 2024 07:25:14 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a3f5sm5308881a12.2.2024.09.02.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:25:13 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	John Thomson <git@johnthomson.fastmail.com.au>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] nvmem: u-boot-env: error if NVMEM device is too small
Date: Mon,  2 Sep 2024 15:25:08 +0100
Message-Id: <20240902142510.71096-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
References: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
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
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
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
2.25.1


