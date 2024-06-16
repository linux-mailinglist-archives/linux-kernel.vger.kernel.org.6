Return-Path: <linux-kernel+bounces-216349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C3909E37
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA03F1F215AE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942B714A8B;
	Sun, 16 Jun 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbBmv3yA"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B119D8B5
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718552757; cv=none; b=Oo7x5NzfX2+SCiD/VkdHXwWDq1JWlPUyGxELdha1RHjsiW8oHqzv5KduX/eyVD4wYG8EhByl7RNC7Ku2Jf2WhFf21tQi/S9zV9+eXgF8S8weCVv4IAENBI58erbiymYzQCk3EDYtaHZR4c7qWYHnlSNmteI2wCR7nnAdMWu+fHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718552757; c=relaxed/simple;
	bh=3156DIFjETCUi5nKVvfuBuAomo8aSmJgHYXpWsdSxO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxhs6rgYExYiK0vuwgDcbt+q7ZPU7DKdflvfQAGE/Wc0MGnzoXput5S1HoVVyXSRGqQAJX7B2FaQN5i1Ij3IkMxx8flxNzg40tFrvyrqh2LQOy9Xpkb51s2UM8a/8aXsT32kbrsiY+zqmrlOm7XWYASzJhYnD0MAJ5RghDc35hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbBmv3yA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-704189f1225so3267878b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 08:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718552756; x=1719157556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7fp8UlyhTZugwgUTVEakWeUaqJf9C1Xu5hu6Y3OppA=;
        b=mbBmv3yAWkm0lfollc0JE4G4xtqUxFjHhKgKwpTUeiyjOwqojk7qGzkpCvHXY3BEAp
         PLIp8PMp1k23dsrA3oommP26K7ga6td8rAKbu9gQWuntSkoMr3BvVjw/Uw+zADQah+Rm
         UWjofRvB1ohOu8EMrGgOIrRgAv8RUtSMx3rrDAHmRaKfo+Z7mCK+Et7BTLeZLaqP8Ahc
         PtGDr98BATIabE8Vjn0pPP86IMrXL6gspzY+nlTlZ0Qs/txrN8JC22wQY0VSfaCUnEyH
         E1u01zYSc/G/dJ6DowUl9ohfzS3Z2yaA2UA80B74qpbSml3oFdRG82SdVAWoY8gcSnq9
         rO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718552756; x=1719157556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7fp8UlyhTZugwgUTVEakWeUaqJf9C1Xu5hu6Y3OppA=;
        b=hqxxcHSn/3JkmYgCU0Jwndh30SZj1xbLNV/M0oYurIMuufC02Flho+VIuDofoKGjRE
         6UP+QssJZJpJapyTAmOGQDLLZPJLKqZjVSgn/NVBtZc0oaTZ8KcFTCug0u3/FKz9MVPp
         hyI5w1vNL/CSK+QnVi5EqIpCk95zINqc1UFHUwuKWvSIURkqBKkTk4ympiPqwgMJWOGi
         Q6c/DpeslIcz3mrh7jS5MRK2BM33GOJQioGL+SBkGJn9Po+7qsfxztDLiM5UFvTRy7u3
         qMRCQyF/zTQAQtdRihcyKMVYNDMlfVNP+41jPD8q/o2DQkA0K8rr6fDhk5PqonudYBJf
         bjGg==
X-Forwarded-Encrypted: i=1; AJvYcCW76zj34TEnM0GiFsbBua/PtvdPCCVILz0PlMiWpgjBonsiILS+UpoXLnmqdrb3cxa+jkLl6NG1DxOcAZ6SX+8XZmVNq15jvyLYsbZr
X-Gm-Message-State: AOJu0YwA7IYbCaoD5HUBtjbGKGky9X/mIyEsbaEnyqcypQFiJ0Eiy6i3
	mwMyVlH1nipHfMqXqzk5biMkDf+yOgf0BxPX/EER6NnAgERNy4OOd/A7SvJa
X-Google-Smtp-Source: AGHT+IEeNwqXRCUbagaIZHN5sqtN03OgsiynC+a+Fqu36/lStwWRvh4U2rCQN9zhCCob0OV/1fcstw==
X-Received: by 2002:a05:6a20:7f95:b0:1b7:8d72:d00c with SMTP id adf61e73a8af0-1bae7ea1002mr7842615637.31.1718552755613;
        Sun, 16 Jun 2024 08:45:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:10da:1462:7d9e:737e:f8b0:47ad])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb90a33sm6063560b3a.187.2024.06.16.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 08:45:55 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: srinivas.kandagatla@linaro.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	rbmarliere@gmail.com,
	skhan@linuxfoundation.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	av2082000@gmail.com
Subject: [PATCH] slimbus: Fix struct and documentation alignment in stream.c
Date: Sun, 16 Jun 2024 21:15:31 +0530
Message-Id: <20240616154531.38232-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The placement of the `segdist_codes` array documentation was corrected
to conform with kernel documentation guidelines. The `@segdist_codes`
was placed incorrectly within the struct `segdist_code` documentation
block, which led to a potential misinterpretation of the code structure.

The `segdist_codes` array documentation was moved outside the struct
block, and a separate comment block was provided for it. This change
ensures that clarity and proper alignment with kernel documentation
standards are maintained.

A kernel-doc warning was addressed:
    ./drivers/slimbus/stream.c:49: warning: Excess struct member 'segdist_codes' description in 'segdist_code'

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 drivers/slimbus/stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..62661211a409 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -18,7 +18,6 @@
  *		and the first slot of the next  consecutive Segment.
  * @segdist_code: Segment Distribution Code SD[11:0]
  * @seg_offset_mask: Segment offset mask in SD[11:0]
- * @segdist_codes: List of all possible Segmet Distribution codes.
  */
 static const struct segdist_code {
 	int ratem;
@@ -26,7 +25,10 @@ static const struct segdist_code {
 	int segdist_code;
 	u32 seg_offset_mask;
 
-} segdist_codes[] = {
+};
+
+/* segdist_codes - List of all possible Segment Distribution codes. */
+static const struct segdist_code segdist_codes[] = {
 	{1,	1536,	0x200,	 0xdff},
 	{2,	768,	0x100,	 0xcff},
 	{4,	384,	0x080,	 0xc7f},
-- 
2.25.1


