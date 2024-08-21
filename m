Return-Path: <linux-kernel+bounces-294865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A070B95938D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36D0284FF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC315B134;
	Wed, 21 Aug 2024 04:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J890K5W/"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9C157A61
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724213415; cv=none; b=n1krwxjXxQrptzN9/PUFhA571Vfg4K8b0j7okcyhOHO0EzGFxNETtknrbfT9WaJyQ+HgTCYngP8qEDYwfr1phN/Zx+lkW34sKv/4wsBKa6DvMHYDg3w/3NcN4Uvbj+4oIy+9SbOkYCmszREyxbGRMG/oBGESgxWmFURQZ63MaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724213415; c=relaxed/simple;
	bh=YDZNohKQqqPz/N5k8VbYl6Ec4oUtf7QY0sCd+uA3m+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Od7yHRgelhSXziM/HH3Vena2RE1QgEulCUxUvr6nR0j5keF3cF6Xl8pYUN1QLRqFkNTtadzlgB232jm32DkZ5kItonKo6dq1CPKeXvV21Z5H7Jrkcex/X/pW21VbhiNoZasNEHWcXJXrRwABFlkKq46xtff5QgJiAPsXMsd+ECo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J890K5W/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6bce380eb96so3729976a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724213413; x=1724818213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wb1BGggEIWmx1mLu9FEBtdmThLhgoJDxQRxO9C0cpI0=;
        b=J890K5W/1eE4tUTIksh3O5kIVFZTTLCezKNNgeEMUtSClU7KwA6C1b0VXB/YaULqda
         S1Yfeq1tTduU4F4wwlgB8Q5TKrGVFNpQ+tm182HrCV+6rMOb+aY7Fgh9tbllx5UZbABV
         R8fV1I3gVhepyiBQ+Et93igxokshNLjlrj604=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724213413; x=1724818213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wb1BGggEIWmx1mLu9FEBtdmThLhgoJDxQRxO9C0cpI0=;
        b=HnAYDEPM62YCkpcKDKpZF4KR3vE2C3QI1+gENuz/B1cko4i8lTRkN6Z7NCADRcIRcS
         MdN2lNsgSYRZMWY/9G293J808MJTw8QyFGvgf0zTP1uq46LH1j5cs76fhfPUcskxoLx7
         8Mx5BWd7g1bGIDSei7XggNY3a8LPlnNzUQaScJBQtG31CDva8YF2pGdKEwEPwCnKo8IG
         5rZJnUzorBU0ZNYVW1ENs7Ggz2DNuhFPhO0mFpQE1QEVOmnB7sUG61Hp6j6TxbHolbGs
         UnNMiDcqir/ozxHW0CdI2LkuXtYq5iD6IrrZXzj3VGb7H77b3J4106CGwbzULO+Ed1sM
         kGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWj48ZqvzlHVd5WN+dIkk9CiZ1PZen6f5vHAEEX6oslBNn9Wha4/LW7egFSRLRnAJ+bmdSBZFjaP/xwwms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzr1fZywIkjK4ZfFU2Gss4ZLoXb+OXQZ0XVFrUl0+CYtF2Kxb8
	AqKWNaIzlXv0E4wIh1VNGhYarkKIXxQ/TOJpZ4++S9bp6li0+YslYHlS8Lkpeg==
X-Google-Smtp-Source: AGHT+IGWCbre/KihO4WkHAHUcn8wEfYtDqXND56kswB/kXv6XyR8aIjMOshLV3AAsKFu3aOdvWQZ4Q==
X-Received: by 2002:a05:6a21:3183:b0:1c3:f4b6:6c0d with SMTP id adf61e73a8af0-1cad81a74c9mr1628745637.52.1724213413292;
        Tue, 20 Aug 2024 21:10:13 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8d56:286b:9a9c:b7d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb917006sm527395a91.12.2024.08.20.21.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 21:10:12 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoc: SOF: topology: Clear SOF link platform name upon unload
Date: Wed, 21 Aug 2024 12:10:04 +0800
Message-ID: <20240821041006.2618855-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SOF topology loading function sets the device name for the platform
component link. This should be unset when unloading the topology,
otherwise a machine driver unbind/bind or reprobe would complain about
an invalid component as having both its component name and of_node set:

    mt8186_mt6366 sound: ASoC: Both Component name/of_node are set for AFE_SOF_DL1
    mt8186_mt6366 sound: error -EINVAL: Cannot register card
    mt8186_mt6366 sound: probe with driver mt8186_mt6366 failed with error -22

This happens with machine drivers that set the of_node separately.

Clear the SOF link platform name in the topology unload callback.

Fixes: 311ce4fe7637 ("ASoC: SOF: Add support for loading topologies")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 sound/soc/sof/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index b54382131991..496162df5270 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2050,6 +2050,8 @@ static int sof_link_unload(struct snd_soc_component *scomp, struct snd_soc_dobj
 	if (!slink)
 		return 0;
 
+	slink->link->platforms->name = NULL;
+
 	kfree(slink->tuples);
 	list_del(&slink->list);
 	kfree(slink->hw_configs);
-- 
2.46.0.184.g6999bdac58-goog


