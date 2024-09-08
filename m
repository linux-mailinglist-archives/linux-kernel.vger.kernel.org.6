Return-Path: <linux-kernel+bounces-320122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05174970660
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12F8B21859
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC914D715;
	Sun,  8 Sep 2024 10:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBrHu8RC"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B794514D2B2
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790285; cv=none; b=CPJ3K2TjnWNjxWNqTJ9U0ZKJQreSvqLpr5qT1YyBBjyGyVBY1MGi4SvBu27IZ+ttm6ua3tkeSRhoJ34clhwJZyLN7cJNQzeWzsb/qYOj6AQrpP7fcHmnA7syXopYVyF51Eey1I8MuYVZfTd0DuJZ6IgUBER/v7R5rLq0KKC2J6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790285; c=relaxed/simple;
	bh=zugrtpy8HQKGTLbItF3tOpzCTunCd2sbjwm26rME4/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9lyvZSb6DTKXIzU6Te6d/XlbI0pktuOnP0el5e5brNchQ8cXGkf1BQIsgpb/V/sfVh/D5hgXCq6mXWMv4ghNYWqVvWWYm4ShRcki6zwdardrhGc5xjVu0DiK7WnCqQyUBZQDDOPRXdEx3aJpYs4HLE34P2CE8UfEGbjku51ZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBrHu8RC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2da4ea973bdso2512247a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725790283; x=1726395083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDj+76Ht7YTSwIwMsPXIYloIAdd0jmxLruLjjnwxVx8=;
        b=TBrHu8RCuubaVLaH5RRBD1c+lf7+F0qdldVLuV54pX+VsA/OGmAjAz3TaGhCm451HR
         hMOEcCZk2M5GxIgzpkk2RHWCoMbgXl8Z/DlL/G0rjygJj3AojyNWrSlPNFTAuXuGbypx
         AvhkEdA7ZhVjwup8YTGAgob17kqn3MvyuiuYZjZSR/uz7tGV/5c3ypngrpHapLmoEvLT
         2THD9Imz1Fiio9r6a7tTVZqhcTUgTU4KNraIGvGSGqzgE5l77dvYsK0/4RSLAmq6084B
         4Jx5P5uPiGTfap0J3rTOoyMQAemntbbxkPnKyyiaTXWbxwiilpptYvvMWKoWYTYtAPhH
         NHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790283; x=1726395083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDj+76Ht7YTSwIwMsPXIYloIAdd0jmxLruLjjnwxVx8=;
        b=oTZp8R8j1zoPZB0oHZx1TgdBM7D67qFZ1ugclHOXKAmf9Xr5TmqM8hMQmFbbICYHPE
         lK+kgvO98n8qgFQZyNzlEUk9MrTSvLn7rk7WstzUahVuXvhhMR7yQ5neK6Sj2Rdtcpd8
         xBpKENfuMqsdjVDNxKgbKPTJMl4uBgkOujD9t+Q55nItgFBQfcWnBC7aedQBnPMnT0Kj
         jEgMZtjZ1W14R4wsxr2J/Hqj+ojKMGEsr/6CquouVFWuXoN+EvuH7Y8ZRbxtDYJkUI5t
         TH0QOoFVGQyIlBjqBTfRct13PQnP6ADt1iwkHNxV67p6Ihxu+E+LjxkGBCU7Vo1c4idX
         7T2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNVBR+kN0bW236TlRTCbDW2936nmj9rUdNYtuGs0yHSB6KENAopxG+/MyjeB2/DceUdo/em63+ll4FgCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaidTAukZHpTKpVYDX2hFK97eI6SuOL5GmaiH3vccq9ToLtVb7
	P0cVWYashbtlMCnXSdqZqlG6Z9GzUZusOIyYG+ZAJ06IGaJIS0rs
X-Google-Smtp-Source: AGHT+IGKCIA36df33OrsbYoi/vzgzHn1MjleAmwl+5CsQe9Y4r+q1uNWB8a7fUIRoanrYZyTH8PcwQ==
X-Received: by 2002:a17:90b:4c48:b0:2d8:8d34:5b8 with SMTP id 98e67ed59e1d1-2dafcf1b325mr5511414a91.10.1725790282926;
        Sun, 08 Sep 2024 03:11:22 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm4589379a91.34.2024.09.08.03.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:11:22 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 1/6] staging: rtl8723bs: fix use of tab wherever possible
Date: Sun,  8 Sep 2024 15:41:05 +0530
Message-Id: <20240908101110.1028931-2-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the coding style issue by fixing the use of space
instead of tabs on line.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>

---
 drivers/staging/rtl8723bs/include/rtw_security.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 98afbd3054a4..487d69460cec 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -75,8 +75,8 @@ struct {
 };
 
 union Keytype {
-        u8   skey[16];
-        u32    lkey[4];
+	u8   skey[16];
+	u32    lkey[4];
 };
 
 
-- 
2.39.2


