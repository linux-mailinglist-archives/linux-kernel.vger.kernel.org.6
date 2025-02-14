Return-Path: <linux-kernel+bounces-515422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 434CAA3649B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A169D3AA8F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1726869A;
	Fri, 14 Feb 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIshMWhz"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61A222DFB1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554227; cv=none; b=kerJzi4WZqwtsnWNHCVtTcOHQe8r7l0saj+ycgJDJDhZGN4a1NglkPRtoYv+3ZKC4t67USpKyOt8LlUpNUgAnGStT7f2r9fcYlcDj0M+gbCS958i/9n4Cm/L7CWczlTjFOewJCNzkUYbrvkUWQF6rP2L/t/WoK4OpmQAjFsRbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554227; c=relaxed/simple;
	bh=ni1cnacbGeNt2dh3+imeccnzktnAWFoqfWdboOnM+6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ctr6qILhtxyvK6f9G1L4vjAMmwInVsxzwktiuzs0/es2Kgoer3Q04r8Gkq3SEh6bnu5aWsFEo7Wk8BPmFZHTKLHQTOcx/tMbWriAdk61r6PztgC3tKuVVEhXKDV/OvScIbwb0GzgtDPm9ORrhaWtNm6RejDZN5OZjEhck5S9Bng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIshMWhz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f2339dcfdso36697825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554225; x=1740159025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkPPG8sQJ/dkzJo9ge0ZgjfZ0ePqc1wnth/y31xhuiY=;
        b=JIshMWhz4kMBa/yBQEZEF/+pNTWIG8adkI6YUm6p0QDnGeWm+lY4qiVwt7t5ewZhJV
         pjtznQwBNB/GrPphUzH1Am7kko0cGsi+JUEjlbvrB696NzW1KDJQk4l7eAUEHIhKYraM
         gWGmE2HrSfHh3PlFnUmAb2gLO0OBJLBKWARmGyD9v9gCEKEZ867cAonbKQ/mFzbGou9c
         hNyEvILtyPxqHS2q/2/+MsMIrQ1TsoVQpjhYF1EuN/7qIZB+9L2oxjAA1g8M62YxZOeG
         2r3kdX/RQUfzmEn0tfPrNBc6jiIt5W/Je1G5TUN3WZ8GkCk/+MDooO0/yamefwDejjhs
         OwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554225; x=1740159025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZkPPG8sQJ/dkzJo9ge0ZgjfZ0ePqc1wnth/y31xhuiY=;
        b=JTmvjQJn3YsrPJBmBot7E1dc3tt2u0JEtecwaQoHYa4tLkJiuPwGHzPuMGIqpSDEp/
         Fdt4vMYPdf8g63HULK5DmxP61JrM6jLNJ4HCe0xsdXSrq8DM1Yut64N1wV+ByMw4Tqgr
         FlyCfva8HWC8qOToxnPhHXSOmqvh6qGPUST5QM71+CYIVICea0mbo3BJcbSfT36grd1u
         epbiOpteCdHRiqZctQ8qfWUE8qLJ+2x7h82MEm3aSw7QYz0638l0WHqreMGc6MUb8aee
         6JIzNTKKs3+3o0JyOxjJbFjZ+zZ3Qv0zoeWBbO5XlR4zXZ45ougAhnLWRV/IEn/UKeaO
         o1Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVC9+rfZlr7Mxw2NtFTQjqnqD87G9FNOTtJwCGlZNsjxM+rPZhni7dU3+1eKczz3Y118Wbl1qu8+CxR7D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdVOYlqYDqsthw67TLrcelLW5ntLLwUT1qNRoCqLZtly6cGTT
	FsXeJM5UqdwvtPbNRvS8bMg2OvbNdMRKxWeVjJxXr4eGlk+QpUbC
X-Gm-Gg: ASbGnctFPQ4GXf/EGKn7aiqIa4CvOv7tbydLtUVaDn4oHy+yiAiz8twThZRnNzNvD8y
	4JZmJw1H8l8eSfzM5Ggt4AIBLE/NqOxGnCvleskyOzlrGJRTTUgJf5kM+GpGk1+Yr+2NVT1pfva
	0EiDrqdy0ls/GL37w3yk/JAXN/NMnHm3QH+V8pRPE/9RwzanFq6dhYdsTyMBERQ1GCROzIZcnOz
	Xgzdu6Pm6cMRCzoM/nLRzQJPppM/UOAsvArmszpPpy5z7lIEuxWrrEL8f5I+lMk1vQrJjbwbbXg
	wbh+wp2oLFVbOlVWc4IqFhC4htg6Y4NmJA==
X-Google-Smtp-Source: AGHT+IHVigEZ77FLJCbcyafP1of8/GkjwCmumHLRWykHN6UYUvRjkWZraa1IjFh+vyNgXjtb3t2uiA==
X-Received: by 2002:a05:6a20:1587:b0:1e1:bd9b:40cf with SMTP id adf61e73a8af0-1ee6c61ac98mr12151993637.8.1739554225014;
        Fri, 14 Feb 2025 09:30:25 -0800 (PST)
Received: from distilledx.SRMIST.EDU.IN ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adcc6fb20f8sm1355138a12.37.2025.02.14.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:30:24 -0800 (PST)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 0/2] extend "multi" functions and use them in sony-td4353-jdi
Date: Fri, 14 Feb 2025 22:59:56 +0530
Message-ID: <20250214172958.81258-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes mipi_dsi_dcs_set_tear_off and replaces it with a
multi version as after replacing it in sony-td4353-jdi, it doesn't
appear anywhere else. sony-td4353-jdi is converted to use multi style
functions, including mipi_dsi_dcs_set_tear_off_multi.

Tejas Vipin (2):
  drm/mipi-dsi: Replace mipi_dsi_dcs_set_tear_off with its multi version
  drm/panel: sony-td4353-jdi: transition to mipi_dsi wrapped functions

 drivers/gpu/drm/drm_mipi_dsi.c                |  42 +++----
 drivers/gpu/drm/panel/panel-sony-td4353-jdi.c | 107 ++++--------------
 include/drm/drm_mipi_dsi.h                    |   2 +-
 3 files changed, 47 insertions(+), 104 deletions(-)

-- 
2.48.1


