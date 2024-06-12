Return-Path: <linux-kernel+bounces-211569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDC79053E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15E31F25AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6217BB17;
	Wed, 12 Jun 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbQAmAlK"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FEB17B408
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199412; cv=none; b=dNr6Nn4EWQE8VaqDgclvq5atpGSNKhTtCzbWCKm5A96ZG5OIA35ylvDKs0iNc65Gk3dM9/BjcTtCTIruHHMEXTFjI57QjyKwXNuaU8bevbdKaj7k1CDKILBAKoizJfq1CkKdAb2qHwusWErwBTNJgNcFQWvEPvfg9lxi3fzkDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199412; c=relaxed/simple;
	bh=Hj446fOHni3fZSVNrcAqYqHSQxLozFsONePUBZICr3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYDt20UTO+322sK26vWW2fudJ9GVI8R8y1OzX4m+knMgssetUwixAITVAGSHRh/cL4w1YzDBDPMfue6RNeYsmK0w05rqL9ZJ2HoTR2FHjD7/JIjz97p0RDSKj1Dy3i24QwNgOywQulmWxWoDosZzeYyLD9X1vuohVifIP+3nJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbQAmAlK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f64ecb1766so52835585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718199410; x=1718804210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jalggb5KAXiKiH+TC/KM4w8VMC75sAk2yBUzqDTF5+g=;
        b=gbQAmAlKILZaQd1Hh2uUSFrDmlhV2yeF9ZHMhGoOVnuh83VrWJYGzOdGraO4NU4w+X
         l6iLYQuGoe50TQf/gHQhu+Y4FjyQhTVvnGmbTVywZ7xjAtRSTNhJBaNPBSPel7sfav/X
         kyooveIvDaJ7vCek89PMZ2R9MJnhNXcE7nUGDuhh1+zXFYcKWSoo9O9C7aIUFzW94Zgt
         8ptq31wAaYGTsltuGIiAzdkeoBZ83ONGLmAa6FLzx6HSsEaQs2Kw1AKwJdg2dua5nsC+
         3rnvdH1NPJEQ04MjLY+0ywoS8wAPrbnhqGbgEcLYnffe7pSfkuB+GBMT6i2Dcd+hKEMd
         MSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718199410; x=1718804210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jalggb5KAXiKiH+TC/KM4w8VMC75sAk2yBUzqDTF5+g=;
        b=XzjqQodW42RqHxfgCDQawVQKaE7vzEB9yje1BapX3aSj5c6d3e66AVpTfEkKGAdZ7D
         vkqK5tlQkulGhwkYmWIHCtacWij0khx5yXVMSIbVHccCFSoqY4gjGzq/qnmnQU7N6GnS
         DUkah1nnbh5GOPvmIfSBDrm6q1K413vnhGuLUtDlau8Mdmj6Jv43xanQmZ+1kbvvrAf6
         s8RV5qoW/7Fm4xB7F80/s2ZRzrLSyMY9UqHMVIuHqG5GOC5uT8zP+8iz6D5ouYWBvHCI
         puJEekOgbdO8O/CXSMEpjaPJACHmiP+TtSAqBiiAcqRIJDKIy5xleZQ5QGdoY2PWB+ee
         weQw==
X-Forwarded-Encrypted: i=1; AJvYcCV8lZ2hUVepGjkGf/bY9vrZXBJDJlWkuVkww7DOtgvlWN5K+nSErFeY4Y7MKcIGzB8AFAkUGhS1ntt1GZWWoC39ZlvhV6zutkW30TZ9
X-Gm-Message-State: AOJu0Yy0iHjkH6QyPhu0y/kKGgRKhMG38ekAjRxK+IMrAO6a/jfCAH0A
	FhgSrnefKsg9I/3BbvJJ047vtHkFSYuRWBYrOysB8gPk0X8wGg8M
X-Google-Smtp-Source: AGHT+IGJXOsSf9sVXW5Q5P3oht0VLzqOpHaHDBQ6BtEZVDQwNdrvibraCh4yXrfl2vD1iK5zCr/CIg==
X-Received: by 2002:a17:902:ce92:b0:1f6:612b:96eb with SMTP id d9443c01a7336-1f83b7ae9d7mr23032955ad.50.1718199409822;
        Wed, 12 Jun 2024 06:36:49 -0700 (PDT)
Received: from distilledx.localdomain ([103.246.195.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f845e0ca86sm7291815ad.0.2024.06.12.06.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:36:49 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: Tejas Vipin <tejasvipin76@gmail.com>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linus.walleij@linaro.org,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix handling of incorrect arguments by mipi_dsi_msleep
Date: Wed, 12 Jun 2024 19:05:41 +0530
Message-ID: <20240612133550.473279-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mipi_dsi_msleep is currently defined such that it treats ctx as an
argument passed by value. In the case of ctx being passed by
reference, it doesn't raise an error, but instead evaluates the
resulting expression in an undesired manner. Since the majority of the
usage of this function passes ctx by reference (similar to
other functions), mipi_dsi_msleep can be modified to treat ctx as a
pointer and do it correctly, and the other calls to this macro can be
adjusted accordingly.

Tejas Vipin (2):
  drm/panel : himax-hx83102: fix incorrect argument to mipi_dsi_msleep
  drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep

 drivers/gpu/drm/panel/panel-himax-hx83102.c | 6 +++---
 include/drm/drm_mipi_dsi.h                  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.45.2


