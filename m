Return-Path: <linux-kernel+bounces-234357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D12991C5A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C750C1F23F60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062F1CD5BE;
	Fri, 28 Jun 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoWMVGLu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886D1CD5B1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719599114; cv=none; b=joYwdcuaibjUBDKQeX7RHTWZG1rb04DB5qjU4+zkkkLkDC4qlUm3zOcL5a2bXmvP00rZnxkYWNGe+4huamXzE725jsjFurfyDP+ydqf5p+vSmlroTcHVKsTyhVdKMaHUtHdUtIMHk8EARRQFJn20ji66oLg6yhMRzsAD9Hc3XgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719599114; c=relaxed/simple;
	bh=fzAsrdt60MstXHF7l4l7ln7NvtUOnR/fubuunw72GaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAcGR1JOI/HTKPTluIgBis+D28tuZ5ZorvHMzcAtoQP4IUQpiN8RQF/2ZEnTFoAZwgnT2OU3eqGebyvDoDpIeZA/JMtSg0t3pOZMxoJkTh1OprdRIJgBvIKsMnpwg0OntGlLgENJ1u0GKNufqzaJV4rLqp2nGuwawBy+P80yhWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoWMVGLu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f9de13d6baso6164445ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719599113; x=1720203913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YL3jtrmeePtQurERmfNixNvqVrYT9nKGr4ecJGhPs+w=;
        b=YoWMVGLuAj5q/XSAe6dpujIp9e5a6NMglhrKmb8cdYgKGF2nrGQgiG9fsv4xMqW0oa
         l52AoIYnUDrRGjFHvspic/+nEyRyQlZ8AYCPxHtJ1YqdyMNL/n7ceK5xvytx+hTSwJlP
         w1erqsY7O49dBaNC2m/2BUAibdeNH6VGdHzQeC/WPCG/z9RZCLFjSb3Z+Lmw/2uEFDM4
         JpS2NeWWzp7+azW4Rtsd0tifK0r9VWm71ox6WM2JnOuqLpOCRy/Q8vYRV/8KCyzbtdiD
         GeuySQJD3I2hLuquVbzTerNqHsR23kOzlI4wIpMNHPctap8DajcaVCnKi7HMElt3nCgp
         pijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719599113; x=1720203913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL3jtrmeePtQurERmfNixNvqVrYT9nKGr4ecJGhPs+w=;
        b=i/fd/jEUVyhZn68PDQeWxI6k778+8wWMHbg1vqOid6J72PglpCKJS/ZL5qKZVEba9W
         m0jU/xowF3JtNanES0s+288Ro4Xs6BxZNBPk+5R8iUrW0QAIk4AZ2aA+7Yw3mTxhJ/aH
         UaHYt3HfMBxzYv0dL+wud07/+Inc8A+uaya7AN2SCpGdyQq3ZP1SRhcakOr1oBT7tZPD
         pedytksCWti4632PUj5Wl65AiBiMguXzg0nDKY+0xEsBcTNFfcCe5bfy3mBXEwrrn2YJ
         Nj7h5lhlCFjIseWEUY4uPqhICwxJmioz13K1K/ECp9hCgUSeTcnQdMgo6Iw4098DZUfb
         IUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbr69nSPr1uWHxfrWHh8LawIWRpMXpdKOE8yi2HCQbIcutgKgat1OcRjtF/5/uII5y/h9wAaL7bXuu1pEkrniLGIgS5BSI/d+2SCeB
X-Gm-Message-State: AOJu0YwMh2p1XkU4QDqQ+NPwvnroMyYM8Y0piheV8InEa6dE3Lv5+pFE
	op7tGi7wWspcPaxrraAG59AkAcXBJZABThcXpzttuqkjBQEzM6yL
X-Google-Smtp-Source: AGHT+IHWul+W3Ya7cO2sLkkSA2kaNbIJ89loGgMX/KHG9nxnMJyolOoM+Ke9Mgmu9U6OA6i46Ih68Q==
X-Received: by 2002:a17:902:ec86:b0:1fa:aa62:8b5c with SMTP id d9443c01a7336-1faaa628da2mr54278565ad.29.1719599112544;
        Fri, 28 Jun 2024 11:25:12 -0700 (PDT)
Received: from distilledx.localdomain ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e21aesm18557465ad.64.2024.06.28.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:25:12 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 0/2] add more multi functions to streamline error handling 
Date: Fri, 28 Jun 2024 23:54:26 +0530
Message-ID: <20240628182428.171031-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds more multi style functions and uses them in the 
startek-kd070fhfid015 panel effectively.

Tejas Vipin (2):
  drm/mipi-dsi: add more multi functions for better error handling
  drm/panel: startek-kd070fhfid015: transition to mipi_dsi wrapped
    functions

 drivers/gpu/drm/drm_mipi_dsi.c                | 164 ++++++++++++++++++
 .../drm/panel/panel-startek-kd070fhfid015.c   | 107 ++++--------
 include/drm/drm_mipi_dsi.h                    |  10 ++
 3 files changed, 209 insertions(+), 72 deletions(-)

-- 
2.45.2


