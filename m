Return-Path: <linux-kernel+bounces-395915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BA9BC4FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF621C21451
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9D1D3195;
	Tue,  5 Nov 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5bqBcjU"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67961C57A5;
	Tue,  5 Nov 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786041; cv=none; b=UdKhbhTYHZrqF9ieJ424k1JZi9DUnew3Xk88cPd9cgxRAnFipQ46QLElrHXR+1/3rSd/MtIhx3379HXjHH3+Kl4YgGtuztSGlEiVyD+C9a9rChUP+B+r0LbfmEMnj/qjmm4YA6MH+1UCRorXkebSqxEVM56dsnqp481EpqoAy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786041; c=relaxed/simple;
	bh=sff61bTbuR9UH/reQV3ajHlxr1VuucvyDBh8LrxS6Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUjrKPc90I1lftIm7D0qvzzTnpzP5jFLIXjU28jA/DEaRhQiCy2gJorUgJoSYyODHyAny7UTo9HePBD0qray3BUh3TwB9+UJ0rdWE1kUNmd6Bg7Rk1CqQmc5qznjKe3k+dffl84DKpSYj7Z2Gotwe+E68BdOM4WoA+phPuaLO4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5bqBcjU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so3803120a91.2;
        Mon, 04 Nov 2024 21:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786039; x=1731390839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HXw37Ptzu3bimMSf6CQ8Y9edFpEMJyd3FD+X6maYWNw=;
        b=C5bqBcjUTyfs7WKX6qlhXuuDF+h3a6RvQKCcY4l+8iu/sVNgXjC6uKYA6wYui4kdbv
         ivNUr3TdNeINCLuOZHB/XLHvYkM/FEhRYiVnaqEmDBigkfMws+segkwaEibq+Y7WS8K7
         lwEZwazkBOXxLVF6GF3lO9rf5jXzZiwuP+6dPOU1Bie2wh7ZBMTK3+lTSbeY9n+VAfhT
         01wp2tBOpfSDUzhYjHoBmVJp0jv3oym08uxkEBVdEHjFaxCKWB6k9fqeshOqlXtwfD4X
         ZjXAptPFwzevRVJBfaZh8HVu6/4tEbGRTiEuzoHWkJEr5Hr72RyWsQiKWUPKNJnr4Dry
         c8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786039; x=1731390839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXw37Ptzu3bimMSf6CQ8Y9edFpEMJyd3FD+X6maYWNw=;
        b=Uq+5bxgjczuMUZwurL5LtrWwozgnr3pI6UA67km2PG52b0EXbYKxVr2YDLX/7jwWML
         tkrsKWxDURmNnYPhqAQ4hkcCvnK6GoavsWc1Ytxo7uUvIiPHvznr4H6AzMtfVZwpXEUt
         EbM+J6YFLrbTSgZ2pH9zSsLJLPo2S6NppIrRWS2O1vSci6tqhsadQvnKEMkKacHAcxiL
         UPdaDies1hEwbK2MTzABcSx3PHEYK6+fS0vqL/UWnp4hXXBKmOWNljRJIXrRRkpbw+Sj
         ENtvYfet7GA8AT+1ZlUbzTBopINIENproAYuZe2Gm9J+LJqOSGtD1NgDLXNMIy2cBy9O
         Ww/g==
X-Forwarded-Encrypted: i=1; AJvYcCXRN1MJTrnmVJ98M7ca6nx1HsZnBeCQQHmyZgEmVdDmCAAnJACv6+lgMnZi44QppFDZdfNyd64oMix4@vger.kernel.org
X-Gm-Message-State: AOJu0YxARNEXW11Je5NH6m0MDUwkas0qW3VfpmJM9fF4HNB+odtu6LK1
	vbzfYXbjL7RPAST9a2Jhc6w73tMqtoG7gAW6pwr9uKIuEiDreZFSKL1XDlvw
X-Google-Smtp-Source: AGHT+IGE8hLPgyIsD8XZ5fAG8QHLyPTIRX4wdhKnkWxPCzFaV/bk2LDqzjSVdlgHw2RBoRD/r1w3eQ==
X-Received: by 2002:a17:90b:54c4:b0:2e3:b168:70f5 with SMTP id 98e67ed59e1d1-2e94c2e472emr20606914a91.21.1730786038268;
        Mon, 04 Nov 2024 21:53:58 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:53:57 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/7] drm/panel: nv3052c: Fix Anbernic RG35XX panel support (and add RG40XX panel)
Date: Tue,  5 Nov 2024 14:52:28 +0900
Message-ID: <20241105055239.1577275-1-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix support for panels used in the Anbernic RG35XX series.

We previously decided to use the integrated vendor and device name for the panel, but the recent revision of the RG35XX series has a different panel that is not compatible with the old panel.
Unfortunately, these two RG35XX models have the same name and cannot be distinguished without opening them, so the name `anbernic,rg35xx-plus-panel` is no longer suitable as a unique identifier.

This patch series fixes the situation by:
* Renaming rg35xx-plus-panel back to WL-355608-A8, but with a vendor-prefixed `anbernic,wl-355608-a8` for the older RG35XX series
* Adding new panel, YLM-LBV0345001H-V2 (`anbernic,ylm-lbv0345001h-v2`), for the newer RG35XX series
(Detecting the connected panel is another problem.)

Additionally, this patch series adds another panel, YLM-LBV0400001X-V1 (`anbernic,ylm-lbv0400001x-v1`), which is similar to YLM-LBV0345001H-V2, for the RG40XX series.

This patch series should be applied after:
[1]: https://lore.kernel.org/dri-devel/20241020083836.175733-1-ryan@testtoast.com/

Hironori KIKUCHI (7):
  dt-bindings: display: panel: Rename rg35xx-plus-panel back to
    WL-355608-A8
  drm: panel: nv3052c: Rename rg35xx-plus-panel back to WL-355608-A8
  drm: panel: nv3052c: Fix size of WL-355608-A8
  dt-bindings: display: panel: Add YLM-LBV0345001H-V2 panel
  drm: panel: nv3052c: Add YLM-LBV0345001H-V2 panel
  dt-bindings: display: panel: Add YLM-LBV0400001X-V1 panel
  drm: panel: nv3052c: Add YLM-LBV0400001X-V1 panel

 ...-panel.yaml => anbernic,wl-355608-a8.yaml} |   9 +-
 .../panel/anbernic,ylm-lbv0345001h-v2.yaml    |  68 +++
 .../panel/anbernic,ylm-lbv0400001x-v1.yaml    |  65 +++
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 396 +++++++++++++++++-
 4 files changed, 530 insertions(+), 8 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{anbernic,rg35xx-plus-panel.yaml => anbernic,wl-355608-a8.yaml} (83%)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0345001h-v2.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0400001x-v1.yaml

-- 
2.47.0


