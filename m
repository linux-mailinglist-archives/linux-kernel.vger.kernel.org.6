Return-Path: <linux-kernel+bounces-304171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E62961B58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9621C230E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BE1DFE1;
	Wed, 28 Aug 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmLC+8Jw"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AFF1CF93
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724807929; cv=none; b=DyIeaVIuFGYLQBnleL2C23ztbrKn1zOuMRnXywSc436+o80UwbLtrpFFBsGkzoAlICJrWxAKs1BNtbRkiPHUWY5Tq7zbu1uvKfyJzClkpls2Lb1kb4svSqtOuaQQ8C6oZVpkNkv0MoseZ5ZZVo0KFGA++yiKSr9m7zmkJ7+MzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724807929; c=relaxed/simple;
	bh=LVR7KQ+RI2uzB2W8swxziBfD2+q+EXVl4awu2dbo4FQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c6N773HHKyvB0PZHoKgQBkTFYh1orESAQNTqazR3JJvxSY21RVYDj+NUDCEf+UhF0wrmcKRe0c+UvpgnGxIgm6zJquQsu/nkjzX/fHOPkA7O0qX1pSKaJEgL28Y74jvi49gHcQWaanAAzDLUbs/gCe+BT0T1+7a2dJjmijVxmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmLC+8Jw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714262f1bb4so4526697b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724807927; x=1725412727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmkiU4TTK/ObisUSMYSUHfXcPlZXp9bAaFXV0n4obco=;
        b=kmLC+8Jw0YDUc5QoDM4tuvQw/EdYeuYQwZYXSc/DTEliA8+uHZItvW0WKj5TPREtjC
         WJ9PzJZ80X91bEboxTzN0HTlIwqsl7ePCCcDDPD02d38heVLVbTuXEcT0dgN+lO1j5g6
         FDll0n8qoMXdTyhz4fkzrvMq1rty2scKtUpQmHh+Cyhr33ImSv+uQM4Fn+Cm4i1inN5M
         C9SuOX9iab867nCcBzwgiuQcXHJcuGMrrbw1hRUJkR6PE9ibWfJzLIoWl2eosP1dbjCU
         58OZHgswoaBaMvAOkLTvnD+Ye8b+R3/D/47yO8lx9Z180PnDDzL+O9TlFgf8pb639wh9
         7Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724807927; x=1725412727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmkiU4TTK/ObisUSMYSUHfXcPlZXp9bAaFXV0n4obco=;
        b=YtNEEtbl4Rfe1F9xQNko4i5N2FZxpDebanvLYPZ2oXOoNgkIVWZErhr8smIfL8hwFs
         wY50iygCWatqj5C+RV/GYbyuiXkB6T4o6vhS8SIxDRT+8JbIppMUUsdKUcm/o4o7j4F0
         3y+6ieJm2wzhPwlveH6nRv7sJ4SWJLMLco9JzUh8vbkZAIymfBun79lMUyLjvup0FyUB
         fzoxB9ohpVGKTuXqg+zsXg//OKvj6VPIuAfOshtD/8/qxYhJ4dJiPypxksGcY2jVHypp
         YFFoeiUFWCAUF41Prpo18OpjqU+wnetvZ2U9fgfLG05y0K9YeFG2kLGgcDmDUKx667xj
         P0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6TuDB12vSBqpr+ICT78WiTirKods0IPflCoWrIuM3aC2RoKAld5tASb1t+vb6wDyqPOruUbBQHIXgB9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzLIipz0cfQlWjMeMeCFVjwuaLD70J01LPrQ503NAAuEghlce
	N826TTpzgw+0GFuqdZITiNfEk61TIf4az1/Of1lIPmlElWNodN4MuMxywg==
X-Google-Smtp-Source: AGHT+IF32G459F74ADhT3VMZy8fzDi0Nxq0gUjyPniy0Tu9tgFAWfjoEN4Hat4vqc/wuVPTHDRKNXQ==
X-Received: by 2002:a05:6a20:d493:b0:1cc:9fa6:d3a6 with SMTP id adf61e73a8af0-1cc9fa709dcmr10975086637.3.1724807926835;
        Tue, 27 Aug 2024 18:18:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:16d8:ec10:100:8c4e:d5a2:795b:a46e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855dd2d7sm89518165ad.169.2024.08.27.18.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 18:18:46 -0700 (PDT)
From: Nilo Alexandre <n1lux.comp@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v4] staging: rtl8192e: Fix parenthesis alignment in r8192E_dev.c 325
Date: Tue, 27 Aug 2024 22:18:42 -0300
Message-ID: <20240828011842.67611-1-n1lux.comp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove linebreak to improve readability

CHECK: Alignment should match open parenthesis

Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
---
v4: Remove linebreak to improve readability
v3: Fix typo in commit message.
v2: Using tabs instead of spaces.
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b25e83743956d..a80efe6c7c209 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -321,8 +321,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		if (priv->epromtype == EEPROM_93C46) {
 			if (!priv->autoload_fail_flag) {
-				usValue = rtl92e_eeprom_read(dev,
-					  EEPROM_TxPwDiff_CrystalCap >> 1);
+				usValue = rtl92e_eeprom_read(dev, EEPROM_TxPwDiff_CrystalCap >> 1);
 				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
 				priv->eeprom_crystal_cap = (usValue & 0xf000)
 							 >> 12;
-- 
2.46.0


