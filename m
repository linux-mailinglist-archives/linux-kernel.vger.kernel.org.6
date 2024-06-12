Return-Path: <linux-kernel+bounces-211673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D3905539
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EF0B21CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530517E460;
	Wed, 12 Jun 2024 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PABoon3D"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7E7E8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202858; cv=none; b=s9gNJMLPDgYYrzS4gc9JYpLQzkzR5QSDzFZM89dc21+jHwRnXHBqt24xiaGLCDLbYL2XccwZ14K02XqiFW/xCLWZ5+lxKHhOtMt8ViT4GINhEMWB6G6Mveyn5xwD0eKigE3xaQBcokO67ruimKtal5Fp/k9tT2UnknKtpCtsZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202858; c=relaxed/simple;
	bh=LFPQeU9q4FsqywsDqQ+Lwqx2MK2V0A/PxmsFBqLV0bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uaogxuRhJTWVeD2iQbCBn85de0JVmU3uavAySHnj/eomDTpxQ2EbH/j/nZ+ffRvYPxDx2SGvlcbkucayIThdiR9twKK1dsgkFYRMQvXcWscOWM0zXZWIE8u2v+ff7mNTWG57zlnQFy4ru5fvD7PPGLIvyb0Hn0+5FGxhi2YurOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PABoon3D; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so6886205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718202855; x=1718807655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45hi7CYVmDt3hhlDLfSd5gueMZgniK5jw3pCKS1O/Rk=;
        b=PABoon3D7rlEpYVeIT47uxiShj73iC+g+9fth72pGUCXqD/9qIEjhzosVDYR2Jfpyj
         dQQK7yqDmMp4MJ3U9Jhv+yZVXFkZeDoDPjTMERJ5jL7Lma/z6liHfwaIg/Jaj7shNCyO
         qoxSYWpmCHwIlC9AuHkwVsWGq9QbtHFO63elvnRu4m41enxA+C0TLJVGzme05/cs6gbO
         qktRCIByW36NbpMup+ZFqTlsilkFD1hFleIrT5FRXBqyKMTE9OtHHHoVrAgAgxXhTfdB
         Vg8zIViaP2Iz3y7p5ZdJoU+LlIn1ofeLEa493f2HYxThdbXlPbO4BgJU3vIczkjDYjvq
         nM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202855; x=1718807655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45hi7CYVmDt3hhlDLfSd5gueMZgniK5jw3pCKS1O/Rk=;
        b=SHfySdySM7bRBqOmis3UxuU2dVlb751WeYc1gI6Zh5dt+cJGu+h/sobCd9oV3hkkdA
         BwZ//4DU8Av+rSk1SDrj9Br84WhruThdk54XjJLglR5VgHJ6MeXXkuBnpWLlMQaPr8KL
         0nATVkCe4GVGeYuRdApk9hwBImyUH2EaCPZ76lkd8XTrcNl046T/GeewdiRCoYrIs1aF
         vn0YYl4tq7ldCobLlfuPP8i1pHLwWE7kGICsiKLW8Upy4jEu/fy2gNoj4izBO7PtpX9U
         LEAAAGZNiDPaHIDzt5CSGbRY7sW/HE9NUm8IvP3z6Wi3eSFbvp05m2AzpvcHOYCU356Z
         spwA==
X-Forwarded-Encrypted: i=1; AJvYcCUVkZ3/XbhPO3AaxyCvY19dQimkdw+E+21Gh0k02IhXzfGp8w6pVWVgmtne9b4/6q+xr58sB53BlXx7R51X+THD/AcvKo77T3755MK2
X-Gm-Message-State: AOJu0YydXyqR7uX81J/SMURZdTu/sMKq5aAne1eVFAsWclcBCoCMsPqn
	r2nRwMdX/OP1Yi505pzsPunNP8CZWmgyAtDudvyUmn3XKOkalhDW01SeKdduOMo=
X-Google-Smtp-Source: AGHT+IGUbEgRbUewkZ9/hJ9J3L553IVcbn3aXC5zr5hcRQzc4weBPSkFt029esQGJZ+cg/pLyT4vJQ==
X-Received: by 2002:a05:600c:19c9:b0:421:75af:e64a with SMTP id 5b1f17b1804b1-422862aef2bmr21206525e9.6.1718202854732;
        Wed, 12 Jun 2024 07:34:14 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f304f3f80sm3581136f8f.113.2024.06.12.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:34:14 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH] staging: rtl8192e: Remove unused constant IC_VersionCut_C
Date: Wed, 12 Jun 2024 15:33:26 +0100
Message-Id: <20240612143326.6764-1-engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused constant.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 8c85f1c866d3..2cab232bbf30 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -88,7 +88,6 @@ enum version_8190_loopback {
 	VERSION_8190_BE
 };
 
-#define IC_VersionCut_C	0x2
 #define IC_VersionCut_D	0x3
 #define IC_VersionCut_E	0x4
 
-- 
2.39.2


