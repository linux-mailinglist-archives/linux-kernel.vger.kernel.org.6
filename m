Return-Path: <linux-kernel+bounces-213521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C46D907666
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3DC5B2134B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EFB149DE9;
	Thu, 13 Jun 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPfqprSj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45B149C57
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291864; cv=none; b=Rrlz1DpPyZkLX+5cUvxwqFY+SS1VDMmhSaYvPiCHpC47TgiJs4J9FeY2igFHRweY74Y33jEUAj8tDMNoVPMqpklg17/e7I1ZbkzKc5nCe8D+2vO0dcVCyOarHzr1hNOL9iQgM+ePHIBZxiIcY1N84he5/LA13VaV/l9rGLBSZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291864; c=relaxed/simple;
	bh=viq19hhLwhgCawmtWkzUKxe8/CYDTKmX+TRGv9BSlT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WynELYU/+2w7NcUONcWHeCB0oyoAyd2flzqGm9klTpnv+vdx9+Ok12uNN5HzwEEJm+six39LpQ3jvD0uddim3Wsha62VQ8YSZprB13klV+aF9I7E70ObvCElJOa2kTv9AhPGpPfwivvTqgljLs5EU3+LMGySwwIp8qTM939VcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPfqprSj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217dbeb4caso10190085e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291861; x=1718896661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4BpMyOlWJiT/+4vsN8G1skGb7QkBQSrOKk0zqDdotM=;
        b=GPfqprSj0Q9yMU6uxake07CfjH7W6h0YSaq1aZCjGOb2wEglHkPjxtreDx4oNJSsH9
         MjJGAQGURodAQfHj9fzckFo2FtU8bgtpAw37ucTFjaFI8hYYcI3O/zAYlXnkO9QBBvPf
         r8Wa7rPkUySXc/VyBOn+NofWxgVGSd5482o7byQOokP2U+6YgG/4cEFC+BJX8H5HIz1G
         QvMnzrVHgUEWi5ucVY2oFlqkhy66NmufoGbqWs0N3ovS+qJqZmlkYDi2+bS52a3C7Zgf
         mQZJt77n+fXFsyfRu31WUnl2CiatkOFZCtvDZBg+LX/OT7fQhMSD3rtAYBUfMP1wyTFd
         93Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291861; x=1718896661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4BpMyOlWJiT/+4vsN8G1skGb7QkBQSrOKk0zqDdotM=;
        b=XSf121v2njMjOQ7iALxQV+7hm3cTPygXsg3kuLDLMhpcwSP6qTiUv8v6xV8bOo3BAw
         Lg1q+PPru3Ai59dsIUPNfH5slwi9OSpw0NHtRd3E2VcolnEa6ys0mvAQ/LYzQdIirzu6
         H7XpKzHDn2CwmM2NNT6NBYhNM4t9rRPaLfRl8jx4IGpSiCkzHTJjcHv8ZtyD9GoydyGN
         PNmEYwjQ0JqtX0RMp+6gGfW1zZkPMeDiGNbsr/PpU+4WtJy9jPeqeURBggmWWXyMkPrK
         4DYJrZhwIvCY+B9IPgScgJdXy73Bdifmut2FxFhHOrR49P6a8UgsWvxFOkjABXxgeOYJ
         60tg==
X-Forwarded-Encrypted: i=1; AJvYcCUeahcUYIMerfejoinoKA1mbmmhtAn25ny/7qOL/ONJOO4pGmSav/6wVIaeHxiZBbVFLM4cx+KoDM1zmX6Q2d8wmMnnA6Hi2kSY0c3g
X-Gm-Message-State: AOJu0YzcZId90M1BrdWKu3H7ts+fcoGR7oUwY6mcJyWaifMh+DUUIsIc
	qWuKNqcS7Q0Rl14L6HHsahcfiQR3QNbZWyflx4U2RmB46KBwwM8U
X-Google-Smtp-Source: AGHT+IFLD8m5DZRs9ZRUmqijP357ewAEo2QVMJ9bXhryLn6W/cUEN8GnugdHVnhVG80uioWxZ9bTkQ==
X-Received: by 2002:a05:6000:1563:b0:360:7773:4f76 with SMTP id ffacd0b85a97d-3607773506fmr1543326f8f.12.1718291860992;
        Thu, 13 Jun 2024 08:17:40 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm1856978f8f.76.2024.06.13.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:17:40 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH 2/6] staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
Date: Thu, 13 Jun 2024 16:16:33 +0100
Message-Id: <0e75df4157806f9acdeaa327dcb7d2d88ad219e2.1718291024.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718291024.git.engel.teddy@gmail.com>
References: <cover.1718291024.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused struct declaration.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 486397d7db84..d87bace0a19b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -136,13 +136,6 @@ struct tx_fwinfo_8190pci {
 	u32			PacketID:13;
 };
 
-struct phy_ofdm_rx_status_rxsc_sgien_exintfflag {
-	u8			reserved:4;
-	u8			rxsc:2;
-	u8			sgi_en:1;
-	u8			ex_intf_flag:1;
-};
-
 struct phy_sts_ofdm_819xpci {
 	u8	trsw_gain_X[4];
 	u8	pwdb_all;
-- 
2.39.2


