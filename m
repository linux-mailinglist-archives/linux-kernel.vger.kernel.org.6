Return-Path: <linux-kernel+bounces-213520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECBD907665
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EBC1F228C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEC3149C6A;
	Thu, 13 Jun 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCWuNHr9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEB144312
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291863; cv=none; b=YOPJ6uTFw976QoXdN4j/zjiLwLxixvuyJqlWcMuhv6LQQ9a64chtJWN8XHS1HMhtOqWmHdgwMFIilx91kSsUknGZS5c6B8ec+1YoHGZREgog+r53wPRAFC9KuMXEGbsMipIbVJBcvFnB+NZEqMHGoVSjvR8bNfHg9/rlSq9g9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291863; c=relaxed/simple;
	bh=7k4aQBPIY7VXjwledGhr2hpwVjyeNFq1b0YYDaLYpAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bu+2lqEx0WE82T3pVlc5Fk9J5K+SNfUSZY0n0sAc8ZhMyHR8etjYp5H4N5QTiekpsRCJTd4VmCZ7bFlatHxHx0O7qW6eSPnKPD9WoM7H7Fndv1c5JReZ5YvB+Fr/rX3J6xbJuVclnpgS4032nTEtN5ZOXeTuq9G+yxh1cjeKz2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCWuNHr9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebed33cbadso11290031fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291860; x=1718896660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOMvYW8v+/gfHgXfZ8t+AJs9E5nzbKnAHaRLNm28O4s=;
        b=HCWuNHr9A7Neyvede4xp+gn++jrpQtverpAdLF2b7SDM3MVLdZJEheD5lFPvfdmoSu
         M2dbrSvhLbV2u8AeAyFLp1drXaEl3jd1pReJMoNh6ehzSfTsAqXPaEPetKCfzVAYu+rz
         5wm9X5a1fX4QaBf7hAWKGhUkiH/+4dZNB0qfplTR/NuNXQWgOxcmmBsujQY4ZDIc0/Bb
         3JdWXyxAu0lLrrFudLgJraegk9Aem4URVvJFO0ECSUv62ebRcptZkj0O64NtsPzwQPkY
         3sWv8eXOfGUJZg7uDJIv3nWFkj2n0pBcmoOT2pjvLP81Wdt08HL2Gvw3AoxciGDbdGqZ
         cF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291860; x=1718896660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOMvYW8v+/gfHgXfZ8t+AJs9E5nzbKnAHaRLNm28O4s=;
        b=EqU896JFIdWI4moFY4ZeCpKSBHnKTu4MxL1eK7G4qBUH8Z+T4vKEUJvSi5xzpb7osO
         2ri4gy2I667ySPv1cqIqNwjuVgOhT0/xcmQ7yQQYdeRqtuYlJat7+yFbWwTaNMn7SJVN
         2GfCFcG3LPwlSi8Sf3yv9OEkdzuDVqCEe8yg/kwrjGz8TAe9ZwznGi95BG/J3ZRqEQWu
         zu0K1NnDrTPhn9HsXNTLaEhd7qGawm04HF6KCwIcoJVqqxF4qBqBrp5eMlqEHZzT3QwS
         Evq9cTtKKrctAvy/w7RGWSNrnvtQzYCR18uEwP84+eNVyQuX6hCKIXo3azrR9t6fKRM/
         n14w==
X-Forwarded-Encrypted: i=1; AJvYcCXAmlkdO5uJRC3oA+/HoqXYh2bC9iPUguwyVAuyO5LxccJ6D++jFXC+G2lmjpJD3V3wry8uSy+Iv42RaESfb4kZcfQSobbdePQwiOti
X-Gm-Message-State: AOJu0YxVm1iQzy9m6o3Dm4UfUPzMsw/IhZcZXINB4d6HM1g9PD0cyydF
	8ogVnKoSkIqsGaV5V+M4XJfdtanlJ2NQwdt3ZfwE3nervRefcmC1
X-Google-Smtp-Source: AGHT+IGukcD4qlZInGkajgjuT5XG5uaxfEaxrKOdWOsXFTQnXavupB0xwpnPvuzcLBx18FyDlA2TIg==
X-Received: by 2002:a2e:8250:0:b0:2eb:ed3a:9c65 with SMTP id 38308e7fff4ca-2ec0e46e7aamr889691fa.15.1718291859932;
        Thu, 13 Jun 2024 08:17:39 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm1856978f8f.76.2024.06.13.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:17:39 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH 1/6] staging: rtl8192e: Remove unused constant IC_VersionCut_E
Date: Thu, 13 Jun 2024 16:16:32 +0100
Message-Id: <3e3de9ddf37b4c20813c9293b81d0589020266db.1718291024.git.engel.teddy@gmail.com>
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

Remove unused constant.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
index 2cab232bbf30..486397d7db84 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
@@ -89,7 +89,6 @@ enum version_8190_loopback {
 };
 
 #define IC_VersionCut_D	0x3
-#define IC_VersionCut_E	0x4
 
 enum rf_optype {
 	RF_OP_By_SW_3wire = 0,
-- 
2.39.2


