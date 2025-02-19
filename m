Return-Path: <linux-kernel+bounces-522235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6221EA3C7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0429B18935A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9C215042;
	Wed, 19 Feb 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8catR7v"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC11FCF57
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989933; cv=none; b=VLaBhpA56cQEV0GHozrH14gLS4lZ/UN/EVyRfVSqdXsCvrP0/xCfvx3MpEBnbbtGaR5QAwlz6vg/Q59aadP44ZT/oN5Li/1TQlYrZTguFqGCYQlMs/sAhYUiCkuvURxPEj9YBhgG/mCMnxLGjTJt4EIN8HRRJNqhXC5syPp/2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989933; c=relaxed/simple;
	bh=wL9Ik+xXqHJbN2qyPDcr0qOQkl3NLgnRawCzk52jTc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHF5v0nmT+SKrprQae/bwpUb6s9jP9Om6LtLGWnQqSFbV1djbq+XPDy2E3hhA7S2cGkTd3C9KnBf06uQj3xkZcGV8st5pr7gDc9HJnzKyknziF7gI9ySzaqYGL60EuTBu2PMqOMvhF//09Lo+fDrzBRedeWIuL84KI+Zst3vPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8catR7v; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22185cddbffso11674755ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989930; x=1740594730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PyA/qxLpHzDa7m7gleRh0GHVhCDPWxqWnpSwv4G7nqs=;
        b=V8catR7vJH3QDeJIPwKnfhX1qwq/DbKjh9swdzHcsz7Bpy99hlQyB/zgKuCWtyDnB3
         v7yjyGoNErRClrcr85U7TWaVSihPp2qb2CDb8FWWmStCn0ALEzsOK4Ud77V3mjEYm4mI
         10L7VDb5GCUxSzk/TKT9K6F4Aw+VxtBJJERxr4mOJpb9f361YxGwlY6U8932pxptiRWQ
         JF0LSYw9uvge7nGH90kWmXSVJPqXu/kPtUPkrWnuldfgMWvzgvyFQQpkDAjPcST6FvS6
         G5x4WSqtrROOkfblXmjbsgC561HzPOhvj9haUCKXUBQ14CtlYmSB4GDf+6tYrlGJz8NZ
         s0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989930; x=1740594730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyA/qxLpHzDa7m7gleRh0GHVhCDPWxqWnpSwv4G7nqs=;
        b=Y9C1ifs0CdKaIOnVThv0ON8JitXFM0Yv+9RN9hdyFfBW8KkJzKh3SALocEL/coOoAl
         p+4Mp54Sz9C35gVKYmparw+jjlI0UUUTCgAM0Ckz0z7KW4sNcQxlLqf+TZAv3PEIUWT8
         9KoTNRnzTVcOCfcgxyDChGzOV643/PsHFxxB6W84Dye4u5wd5h7HcnCvpheTLSkoiUYk
         30uV1yClx8/7wIiQwaPD6WuriYCQBc96k8y6hN5MEPPqaKrcNPrgd4C6XOg37ueSe/mP
         Df9kYsnohyVPHplTYUKGUgEzWSHfm7B+7Vde6QS2JVqgXFy2OlVF00s+UVtctExLDzgR
         InbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPGyFUnY87fwlnKNv2GuHBSEI+tHohU4m4lLGECJ6AtZ0PEGwZPpRuZLEWwIZUU9a9WnPWBEItxgtJb7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzYXcJjC2j9WuuOc6sXd8fUs0d8XmkCMGQ+WeXEb5t6gM+Pu7
	3abDjMADWk9Jhd/LIZ4yyVF3KCZ9v2Ja5Mgt0hGTzI/DldCZctl2
X-Gm-Gg: ASbGncsp4QVRTA1XYk7tWYSWlKHfmeZoIBO23UwUOm1xtwLdJu5jTzG1LB/EKLywwlG
	4RFwwsViOZJWNge/D9bVLm7+1slG2QXRDWmWyA7BlVl1A5FepO7mizRhOwFgP5QhGjtZ+bbWLEw
	XmP5Fg4pOGXuJsXi5AOBxaH3WITgabN8RB3Mw2o40WQNVy4xR/aBj6huHtM2bua55kQOYrw1a2f
	29Y/N5LKTM/SoNLoEzeYmCZVV7bHzh814u6Bg7ysgsWemJYG0vZcXvkIkghBxro+FJHCVROa427
	fpHFCt06K0MzcZqkGLEj
X-Google-Smtp-Source: AGHT+IFefd+I9cxI3fFqatvOSUGEJg/3d68Lrk2bff0rX/jEQ4q4CVE9+5Eg0UIeohwYYZFgBlLjfA==
X-Received: by 2002:a05:6a20:7f8b:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1eee2f09d2dmr461059637.19.1739989929842;
        Wed, 19 Feb 2025 10:32:09 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:e1bd:18fd:9875:3b67])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73256a5680dsm10254605b3a.112.2025.02.19.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:32:09 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH] Cleanup of most_video_dev structure
Date: Thu, 20 Feb 2025 00:01:50 +0530
Message-ID: <20250219183152.176679-1-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

This patch series removes unused synchronization primitives from
struct most_video_dev to improve maintainability.

Patch 1 removes an unused mutex, and Patch 2 removes an unused spinlock.

Ravi Kumar Kairi (2):
  staging: most: Remove unused mutex from most_video_dev
  staging: most: Remove unused spinlock from most_video_dev

 drivers/staging/most/video/video.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.48.1


