Return-Path: <linux-kernel+bounces-392150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB39B905A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358CD1F21B64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFF19AA41;
	Fri,  1 Nov 2024 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbSjRsXh"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B9154BFF;
	Fri,  1 Nov 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460935; cv=none; b=WP+dG7XupwzUiuVdWEbBQlQc0ukKd4de/6+Gaah0sLjBDrdddA63zFMQoaZ8of8Snfcuuj++U8u7pZ3fub6OaFTorjAD/FSpGBPjqiMBKAgx/B9IPS4tJ2V7R0QS4oVTRvepiF77UqrnUdVuQlGaE+FXGk/R96oidPTYcFOFfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460935; c=relaxed/simple;
	bh=k6JQbu6PpYtn8v4f8CuUib3vAJKpW7tVOmfbfudfjqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti2BLIFCpPOMbfGInQHtowxQHAzUa4Tv+XvyRTCvGhAgUanJL8N3y8VPbbceebhH1yurTNezsTrBssTzqL0jfl2bHHMQumWWhV1M8/RcS5XYP/BUsPig3WVA6ZobnQv3VzVdurIudR5rVhz8xQ1YonLNiwqI0FF9lJ+RQdNspJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbSjRsXh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f7606199so1925275e87.0;
        Fri, 01 Nov 2024 04:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730460931; x=1731065731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ocM6qsHD1g3AZoZVDeUSxH6IEi1eJiiX2Z5o93terdE=;
        b=lbSjRsXhEFxosFaf1freFHVt0YslHOwerPXRiVCzjJQd87+V5zuTwA3TlJDIoBuOj3
         3b+pMPGaZQLPV8A8RGiqvPpQi9Pk3Ie7t0uXwjKqrTnYfKmzJwPxYaO/4ccVxRENMB9x
         hImmH2FdHxOzA+ZviIUrnC0hKv52jTvXqDNmSh5FOGuElU3qwuEtcgyJmJS7Vbvw/Cfj
         NqX/ui56gO1fZqon6WCinE+P31AyCcYUNXHVAkq5omSl7IbzCDxZeZS5saO0fXA156XH
         +ODpJWbhADX6/pBHAnhxmzlapHQfIbes2JTRso/JnzUbSmhMUsDRuz0Dl7zP86N6KiMk
         F3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730460931; x=1731065731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocM6qsHD1g3AZoZVDeUSxH6IEi1eJiiX2Z5o93terdE=;
        b=Xba2K6JZHJSoBBBxMfrllRL7Ovc/eGS7BEoJAPCR6N3/unV4rcSoQ0fFcQcy/C1fUN
         75IjgN6tpdMkP2Ift7fwNo9Z8pmVcgBBUAGMi8rpiiCQTaMkDXMb0C4psI7BBiTs+wyM
         XC5+6ZiQ4rOttKuFhVHYCYWEqLsBfUUAaqyW5VJE1Reyjw2OFZIGWzLl4rp3zlqS75Cn
         /QNVKyX84Z4pV1aINlU2iR4UaxSj1GKY3E1MzbOYoNXPSBjnM9GRdGqkF4iDWRCerKPm
         RqUjJP2SG0072AYgABsFUdK7RVp6yIgZIVzGVKDbvc2jH29bB6hH3yOuSGfAkkUq0evA
         Uneg==
X-Forwarded-Encrypted: i=1; AJvYcCVHOseZG2K/MH7v1aQ564Ppe8EHnWnO3ZTMdX1aLIMe5lGYL7r7emfWvPXCQ8etGV90yclNmJqhRIB9V5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVBQSs7XsfueLEx2mKB3MlSw/4+eoO6rI20EMKiU6wUirWiKC
	dacF8VDQTr+21cLukwjdFVzNMp3Q6I//j0dN++YhlHZ3G/TIyR9VqA5tGQ==
X-Google-Smtp-Source: AGHT+IHllTneLAxy+qXFJ3/z6VpHbw47kA76Mb+VwmUXvAOK9KDgpKVJuIoPDD0pD80wF7WbKZhX0g==
X-Received: by 2002:a05:6512:1283:b0:53b:4c7c:a7be with SMTP id 2adb3069b0e04-53b7ed14732mr5843931e87.42.1730460931113;
        Fri, 01 Nov 2024 04:35:31 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdebf80sm525163e87.306.2024.11.01.04.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:35:30 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: daniel.almeida@collabora.com,
	a.hindborg@kernel.org,
	linux-kernel@vger.kernel.org,
	dakr@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	wedsonaf@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 0/2] Add dma coherent allocator abstraction
Date: Fri,  1 Nov 2024 13:33:22 +0200
Message-ID: <20241101113422.2615566-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the dma coherent allocator. This is based
on code developed by Andreas Hindborg for the rnvme driver. We adapted
this for basic use in the Nova driver to access the GSP via DMA [0].

Changes since v1:
- Fix missing info in commit log where EOVERFLOW is used
- Restrict the dma coherent allocator to numeric types for now for valid
  behaviour. [1]
- Build slice dynamically [1]


[0] https://gitlab.freedesktop.org/abj/nova-drm
[1] https://lore.kernel.org/all/6CF29D3D-C930-4274-9BAC-365C0F32DF56@collabora.com/
  

Abdiel Janulgue (2):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.

 rust/kernel/dma.rs   | 165 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/error.rs |   1 +
 rust/kernel/lib.rs   |   1 +
 3 files changed, 167 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: 718c4069896cabba5c39b637cbb7205927f16ae0
-- 
2.43.0


