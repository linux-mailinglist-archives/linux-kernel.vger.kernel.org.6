Return-Path: <linux-kernel+bounces-302030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CBE95F8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21991F22DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A18248C;
	Mon, 26 Aug 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuYRjDLl"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4582B677;
	Mon, 26 Aug 2024 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696751; cv=none; b=Idz+0ZEt+I+BnNpylVAtaHP8LexbeGolqHxQyCWWYaNojZDhiIGS7cvizYtoBtt8PdmUC6nFjI2NepfVKDIt4wzQA0BlajYcPAs5dcgGyGQ5V7jtxjr3XfslvyW/mM4XnxArjseCdEDk4rmf6uMQrp96EOHzgi6kHgAhw4F6c3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696751; c=relaxed/simple;
	bh=mImBejdDjCpmXj8Di/I/HuyYPVoWvfKJBu1QEeSsOCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a6IAqk120L6XVveqhf+qX3Zt33DFhQomI98RnsN3MjbW+l+HVsOBepGVjDAied/QkjuotEtUcpXlHL4Hnf3SQMuOn3n8q1rrH2vDauzYpXpXiAiuUBsPbe8awWZiYKB2XlDsom6HbaaZbs/e8P+9fJrNmz85FZ3U/Eo0xEArlww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuYRjDLl; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f50966c469so20112391fa.3;
        Mon, 26 Aug 2024 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724696748; x=1725301548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mb4ZRd/HYSDhjIzksDC7j+rAhxPX+JataK0xq/4974Y=;
        b=FuYRjDLlPiKYVhkf2EeR7BQj4oAuLvYYUAnC7hyVNvFjOoTlQTPI45m6T8SJzWFdVZ
         2xRb00zKr1tHr1Jh5TzDvR14YOhYP5erzVAwjNWQRt+9uasucpQo0jWHDt9VEl+RK4w4
         +fhUIK/BDIDLYD0VH5fdR5RgQd1c5QjNpT/YJ+CWc5m/obBxljoiV4abiDOpznF0cDHL
         zvdZGK9H2PjMymF3Ae4lI8tNhd5AvY0/6HT/QHs/+S7KG+tfqDkeGMoZWTAbwQ5gdiY5
         ZaR+ukbAZrDynY57cZlvwSefA4rIFgvSYFiKftmXA4SKCG00mHAKrdCnarPC7hkCNMTY
         cBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724696748; x=1725301548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mb4ZRd/HYSDhjIzksDC7j+rAhxPX+JataK0xq/4974Y=;
        b=rFo8QY7+2SBq/hb+PXDIZTtd3pZQxmEGzEkznAiCMxIjPPba/Eme8x86SL5Hfpexnz
         37F28A9LoCWMBAFLxmncfQLnts7FF8aG+FXojG5Bd8AVSKM0hxc0UDe7rf2MugcI99Sw
         5rlb3vRFbgA4VMj8ybFdbxK80V42MgoEPAffcrWXOhkIc//NrOf2v5iOFeCU0ZegBsC6
         S3TbF0oYvNl8LIomO0OU//BK7fyco8YNinCGLJh1UKp4Dk5/pdbwtJEQn9wp76KzcKJs
         JssEvow+aEHlkIahSkJqnOLVWbrtWy+UWpI2vQHJEIWk7OI+XPKmTd2irwcRfQMHfWex
         cybA==
X-Forwarded-Encrypted: i=1; AJvYcCWyPh+agK62MRUNtqqNodCvdAAXPz7qDRobQdSAdNkjFTm02xrXc/6SHNtTFt/KLPrfn6zf2/rFN+tzMFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIfVHRMqsfwj+IxQ0bHFm642c4URs17Y67vyMuCqUkgqdqhN+5
	DAuqVZUzPlRLOoUCMFtc5VVyJtQ7HgN2njSoyS3tmeV9js5E51I/
X-Google-Smtp-Source: AGHT+IGfIubUWy4+G9XbvlH4YSyyow/qjoMcdvdum2e0UHJt52Y1f9rr3awhlwJkEU0p9G4B+VKxxg==
X-Received: by 2002:a2e:8014:0:b0:2f3:ee44:c6de with SMTP id 38308e7fff4ca-2f4f5776474mr58901701fa.27.1724696747016;
        Mon, 26 Aug 2024 11:25:47 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb471e0csm39753a12.78.2024.08.26.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 11:25:46 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc: replace "enum sof_comp_type" field with "uint32_t"
Date: Mon, 26 Aug 2024 14:24:42 -0400
Message-Id: <20240826182442.6191-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Normally, the type of enums is "unsigned int" or "int". GCC has
the "-fshort-enums" option, which instructs the compiler to
use the smallest data type that can hold all the values in
the enum (i.e: char, short, int or their unsigned variants).

According to the GCC documentation, "-fshort-enums" may be
default on some targets. This seems to be the case for SOF
when built for a certain 32-bit ARM platform.

On Linux, this is not the case (tested with "aarch64-linux-gnu-gcc")
which means enums such as "enum sof_comp_type" will end up having
different sizes on Linux and SOF. Since "enum sof_comp_type" is used in
IPC-related structures such as "struct sof_ipc_comp", this means
the fields of the structures will end up being placed at different
offsets. This, in turn, leads to SOF not being able to properly
interpret data passed from Linux.

With this in mind, replace "enum sof_comp_type" from
"struct sof_ipc_comp" with "uint32_t".

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 include/sound/sof/topology.h | 2 +-
 include/uapi/sound/sof/abi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 3ba086f61983..449e93c25184 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -54,7 +54,7 @@ enum sof_comp_type {
 struct sof_ipc_comp {
 	struct sof_ipc_cmd_hdr hdr;
 	uint32_t id;
-	enum sof_comp_type type;
+	uint32_t type;
 	uint32_t pipeline_id;
 	uint32_t core;
 
diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index 937ed9408c23..c1b158ec5dab 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -29,7 +29,7 @@
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
 #define SOF_ABI_MINOR 23
-#define SOF_ABI_PATCH 0
+#define SOF_ABI_PATCH 1
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
 #define SOF_ABI_MAJOR_SHIFT	24
-- 
2.34.1


