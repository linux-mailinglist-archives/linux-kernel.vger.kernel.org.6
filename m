Return-Path: <linux-kernel+bounces-389105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C19B6891
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E725B21317
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFBC2141A9;
	Wed, 30 Oct 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlrdZHFI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7C213EEC;
	Wed, 30 Oct 2024 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303853; cv=none; b=osjVMHtO83fGWPd4PUOuFp8noWKEeoDpS+vM3354k5N+g2id0pL29kGsgmudvcbBYJUaPHJFqkDM/JZCIS21v6D5eGK6O0SfNfhuoIuiaD1ydzzzzf/25ICOrsZKgpCh+X8SwP1m7/ZgUisKoX2WsDlE6PYwFxmUYnWnvGwKEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303853; c=relaxed/simple;
	bh=kNn6yVtxGO/Yo8W9cIjthmdVONNF455zFnORPlULS4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NMke1XPw8vEiC/aCxWdDIyQHhjoZKqD0ykc7L4VSITwPhEpxrexQ8yx0RsHpREV6XQRr2l1U17NaliQFjdGdv7ZJolT0bcEVhkaWoK1aiI3AhgXDmqDllsLOQLOTeyHmg4rNRaQ1/u2qYkl3LlKopni69zPjfv3ev2Lv9NPCClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlrdZHFI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cf6eea3c0so11795ad.0;
        Wed, 30 Oct 2024 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730303851; x=1730908651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKBQQRyBnijRoqoRqmBb6hQgU1uV8yL5Bv3ozKPB0u4=;
        b=GlrdZHFIsKvf9mqLT/56vjuIDXEHwJfTfEWV5LPZ7nE2eafICXvpPXXC1XjeZ9lhL3
         cN9b9ixsP30uFDieyAVTdYyaLTvukRclaZz42bjHsb8R3dAqV91XqOMBZRoAEO4aqf+l
         4fy0qjwWgD5Kv47bJEzlUaf1L/420zRogHzwETplUhcIjBfnJinZAxmCnIWGPN+/INZP
         4yszA2EUTp6Uhnv/Qj2h78XcQASJgYzjirDu3myW5eqpVJHzaOV8kOXUrvXocEnEFyUE
         fsxmPLTFdN4fAe7f75zvi901sfAWMTAGYzvIDuYegyuxtFw85Ypk86N03vfblYH0GwNK
         jx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730303851; x=1730908651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKBQQRyBnijRoqoRqmBb6hQgU1uV8yL5Bv3ozKPB0u4=;
        b=MtDbkJxYukyLdRFjAYSwsXaHVTwH1KcJQymdtolhk1Au93GNMdK/DRZCibb1azPGdJ
         ubGDq8Y1UXkse8PsXwx38Nqh6YyyAVnldRZQ3ogoDaBmrm15e9I3m0M79SW6PLQtoTj3
         boP+9wqdQqGD2hyfkabdQHKgNVTaBP+xCPHfO0R72wS88fh5EK4UnzHFNXlkZ+OvoPZ8
         tLY1hXyZxge+kb4A6f0hWuQ5jMwpWPExLhzlUlqkrm0Udm+foRTmf2VPxDr7XKfQaEBy
         Kt2hGzKFPBZEII9PdAe2gFIM98FmI+Uzr7qlNA6jaNC546xBcn6uhOUwy8BsKQUU8klq
         A+7w==
X-Forwarded-Encrypted: i=1; AJvYcCX7e4PpyxBSQmbRqwSmevWVXNTaGQt78yq+sIpoj9XknfvhPNEt7Rt12NriXpXSbvkegj7yatysbK/RwqI=@vger.kernel.org, AJvYcCXuJUHm3Zp+D014m7AKkAqhYc3Hwzk0oXqgyZzCloLUcuzasCCTKKXCs5xL7MI9eeb+PZa4O+72dh/Mwtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjqsm1j3QR4SFzavInm3niCQOrGHkMyBWqEwr7o4U3o2GxQXNr
	Y6jcLALMTu0OrK1D0lB5d3LYJOsgndsCLMeohmGWDPBCMN4vaoih
X-Google-Smtp-Source: AGHT+IHfeBY1wLOHJcfuuZr4MGMWUhM8UccQKJCNVpY56jJ/Pe6fPK5w13eoK8CnBVK1TJPXN4y+8A==
X-Received: by 2002:a17:903:191:b0:20c:5909:cc48 with SMTP id d9443c01a7336-210c6c3453fmr205801475ad.40.1730303851061;
        Wed, 30 Oct 2024 08:57:31 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40f2:e:4b75:b7f1:6e21:98e0:5a37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02dbb4sm82346195ad.183.2024.10.30.08.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:57:30 -0700 (PDT)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] sound: fix uninit-value in sof_ipc4_pcm_dai_link_fixup_rate
Date: Wed, 30 Oct 2024 21:27:05 +0530
Message-Id: <20241030155705.31327-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch tool:

sound/soc/sof/ipc4-pcm.c:615 sof_ipc4_pcm_dai_link_fixup_rate()
error: uninitialized symbol 'be_rate'.
sound/soc/sof/ipc4-pcm.c:636 sof_ipc4_pcm_dai_link_fixup_rate()
error: uninitialized symbol 'be_rate'.

These errors occurred because the variable 'be_rate' is declared but
may not be assigned a value before it is used. Specifically, if the
loop that assigns values to 'be_rate' does not execute (for example,
when 'num_input_formats' is zero), 'be_rate' remains uninitialized,
leading to potential undefined behavior.

To resolve this issue, initialize 'be_rate' to 0 at the point of
declaration. This ensures that 'be_rate' has a defined value before
it is used in subsequent calculations, preventing any warnings or
undefined behavior in cases where the loop does not run.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 sound/soc/sof/ipc4-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 4df2be3d3..d08419859 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -600,7 +600,7 @@ static int sof_ipc4_pcm_dai_link_fixup_rate(struct snd_sof_dev *sdev,
 	unsigned int fe_rate = params_rate(params);
 	bool fe_be_rate_match = false;
 	bool single_be_rate = true;
-	unsigned int be_rate;
+	unsigned int be_rate = 0;
 	int i;
 
 	/*
-- 
2.34.1


