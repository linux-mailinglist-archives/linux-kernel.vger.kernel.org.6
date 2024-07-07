Return-Path: <linux-kernel+bounces-243495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0F9296E1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B31C1B21AA9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E49DDBD;
	Sun,  7 Jul 2024 06:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewfthhii"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6DBF519
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720335163; cv=none; b=IZhBzJ1TMUeIxbH81LccwlnbYejZIgWVmkpJT0+oJ02vCeH5bjJM/Io5Dw2k8oqS/7c5S1d1KC5jqthrW7hTyuLULfFB6dBkvkRIjiKXg0iWcAfJrfPaqGRnqHmKd54WXBF0WPUqzOq0USE1ZmOE7+Ek7YJumrhSwleHxv76VJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720335163; c=relaxed/simple;
	bh=2gHlRRfe5N0hzfS0ebrcez3lGn41AB8pRSZzX3LKbLg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtHdvJ7bhL7KKDGRoZz4j/iz5hJA71cfr4frndgdcXqGvjLc48018FobGSM8xCSYJfffwds+3bKajbyFzBG7YkveapnNItxcbvV0EDRn2pOFNTUxJsm2VGMQfwUOqwfYXnJ5Tyl5srwu4z6zckQuojkOda5nIoZ5fI7akzNl92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewfthhii; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42111cf2706so3288085e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720335160; x=1720939960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nTXTdn8BfpeIUTQTFy+0PL+rg8osqbE7sRCEcbh36A=;
        b=ewfthhiijy5WtXVroQPaGZWtTDhKhCSsXy1QiDoZ0PftOrCp12rYNqX3Z/JAF6SBr4
         Qs0n51EKu9p0g/WO9ij4AjlLpG2fVNUgErQZ9+EG2pyoxXK2Ku48O+7Kj8N2ZlbAtohP
         LiPBHHu+KgXZhw4rq54va+t7O6habKfmSB5gNKmTmw/3XUVBtyqK62hAyvaKOTGZXSa3
         3+fs/WbUZ4uhkKp6UmLZ1T7huhUnUIvxFrF7hI8TtI7b6MA03Ey0AbXDTxNA9+L4zN/L
         AsOdS/h2EOHsPcu4QhmCcKgM0vxKW9R2Mb86tNmzLC0l124Umz9Vj4r8vTJzvUDCOwMq
         fVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720335160; x=1720939960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nTXTdn8BfpeIUTQTFy+0PL+rg8osqbE7sRCEcbh36A=;
        b=t7rZeL80d38PTgQjaSKkeh8KD6ap+awYMiGUbUmuhXUpeZrEvKPntnRqLekmutjrA5
         iLOyTnEibMrBFaCTvfo7o3pjwqAGiiUVTJQ9nPezG0gopq0mLPwyawLBufjzCLkSYAsA
         WgL9eA7SM605I+VhIxWy1ryKXjmADskujXh/8hplhnrqOlL3VpyaxhWYDt4hrVA4QSsn
         CDLMjxsrdCZ92RC/9YhRlKciZAzeGYoyt7xpzMxAcE+86pDaVzmk3PP7Asub3vH863xf
         VvvT7dGXb3ssp4NW5+PyOd8ZsAvOA2HkvSSY0jWhFJvf+tmm2UlRVeaLbXmuvssHYxZW
         g2vg==
X-Forwarded-Encrypted: i=1; AJvYcCXW6PO9fz5cz0Ddkdku7PDZIlMZQkGl9jOAv2BYVBgMsj9vIkoBfTrB1xxO7vhtrSAYQIYee2kjZmfu6f4CVtQwUfq+iRCzyvn9cs9q
X-Gm-Message-State: AOJu0YwwZZZAi6euUOcGWclO8k+kVXph4fv0pQSnEeBxb4CtWXQg4DYm
	chg7jIe8WFMo2Wgzit8l7+DNRTtTOzy7gnhD/QzdOVjqadB0mT1c
X-Google-Smtp-Source: AGHT+IEkAV8bNmuZkYXMin26Xc6b6o7XjXvQBr+yzOkeoBzNz/3QpTUWJQLG0wyYeJeR+246lvNNQQ==
X-Received: by 2002:a05:600c:35d4:b0:426:4920:2846 with SMTP id 5b1f17b1804b1-4264a46b0bbmr59448925e9.3.1720335160526;
        Sat, 06 Jul 2024 23:52:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2f9b.dip0.t-ipconnect.de. [87.186.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36792881856sm10726712f8f.6.2024.07.06.23.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:52:39 -0700 (PDT)
Date: Sun, 7 Jul 2024 08:52:38 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] staging: rtl8723bs: Remove unused macros in
 hal_phy_reg_8723b.h
Message-ID: <a478e607d4fcf22f547594c4a569c27da4fb2645.1720245061.git.philipp.g.hortmann@gmail.com>
References: <cover.1720245061.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720245061.git.philipp.g.hortmann@gmail.com>

Remove unused and double defined macros.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../rtl8723bs/include/hal_phy_reg_8723b.h     | 51 -------------------
 1 file changed, 51 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h b/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
index b0b1ac1090fc..0791b85b7c57 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_reg_8723b.h
@@ -14,56 +14,5 @@
 /*  4. Page9(0x900) */
 /*  */
 #define rDPDT_control				0x92c
-#define rfe_ctrl_anta_src				0x930
-#define rS0S1_PathSwitch			0x948
-#define AGC_table_select				0xb2c
-
-/*  */
-/*  PageB(0xB00) */
-/*  */
-#define rPdp_AntA						0xb00
-#define rPdp_AntA_4						0xb04
-#define rPdp_AntA_8						0xb08
-#define rPdp_AntA_C						0xb0c
-#define rPdp_AntA_10					0xb10
-#define rPdp_AntA_14					0xb14
-#define rPdp_AntA_18					0xb18
-#define rPdp_AntA_1C					0xb1c
-#define rPdp_AntA_20					0xb20
-#define rPdp_AntA_24					0xb24
-
-#define rConfig_Pmpd_AntA				0xb28
-#define rConfig_ram64x16				0xb2c
-
-#define rBndA							0xb30
-#define rHssiPar						0xb34
-
-#define rConfig_AntA					0xb68
-#define rConfig_AntB					0xb6c
-
-#define rPdp_AntB						0xb70
-#define rPdp_AntB_4						0xb74
-#define rPdp_AntB_8						0xb78
-#define rPdp_AntB_C						0xb7c
-#define rPdp_AntB_10					0xb80
-#define rPdp_AntB_14					0xb84
-#define rPdp_AntB_18					0xb88
-#define rPdp_AntB_1C					0xb8c
-#define rPdp_AntB_20					0xb90
-#define rPdp_AntB_24					0xb94
-
-#define rConfig_Pmpd_AntB				0xb98
-
-#define rBndB							0xba0
-
-#define rAPK							0xbd8
-#define rPm_Rx0_AntA					0xbdc
-#define rPm_Rx1_AntA					0xbe0
-#define rPm_Rx2_AntA					0xbe4
-#define rPm_Rx3_AntA					0xbe8
-#define rPm_Rx0_AntB					0xbec
-#define rPm_Rx1_AntB					0xbf0
-#define rPm_Rx2_AntB					0xbf4
-#define rPm_Rx3_AntB					0xbf8
 
 #endif
-- 
2.45.2


