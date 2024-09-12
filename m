Return-Path: <linux-kernel+bounces-325937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50E3975FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E001C22ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4D18BBB7;
	Thu, 12 Sep 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpzROK5n"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B818BB91
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113888; cv=none; b=NLzS50f0lKTnJ0cYCJUGfThNe+UMBC80MWYFzwSkUN2OIX7yqs9okkhUMAy+hhF91uVYXqkVQDjkJmJDcgvAJu4qMPZy4MfyMyq20y5W8Vj9J22mXehS7ewC/MreJQgHWUdSEeTEebn2D/WDDjzll/g+GILqrRQN7P5ydjZA8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113888; c=relaxed/simple;
	bh=1xoHqAHfyWBPaCqgVEeynTfGrsLp/kPMfAmcN2bELyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGcfGyjjW9J4XOQmyJT+a4jJ+Jh2spfDMSNB/QtBnpLmb5znUFOV8GU87WiG5RZ9EEdl1LzEjP7TmLhQlOookUVZKc3HiCj9aBUxPp3hyBhzbtnPY1okHpibjCnvpmH9jYj5yHXPLueAGr8UJ4tzt7J8IU/OK2WRFKiwvI3io0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpzROK5n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-205659dc63aso6188035ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113886; x=1726718686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThvSFW7vmATU3IrvCKmeBsRE8HH7xmkKY2e+o0JIjds=;
        b=XpzROK5nFVj5jHAU1vD8T5A73wG/Ze0twmcMQnLIdkFx1oyTwkS6CibE0E8tiJfXu5
         6Oy74S75y/xrGhmSP+a8SffFwPYwnbp4YtzN9fI8U+zLTZkiYAALSi0PNPm+iPirhWie
         kZzsyG7URILsqbx1Thd/EybY2a1HldnpMeJGg173BU7hw+ZaQ+bH1O6DYy8Q75ddMPcL
         X8ZwBBCC37+/RVwRVvJYhQZlGzkWknkUsjjdgHgrC/0qxEJvtbV/QRwntEFCUvG5RG3C
         jVpCqwqyb6E9KJ+Gqw9dLSU+0FMTPDy3FdDzXPfjyjb/y+P5DtFgz8Pn5C5/ISZFw0Fl
         78DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113886; x=1726718686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThvSFW7vmATU3IrvCKmeBsRE8HH7xmkKY2e+o0JIjds=;
        b=xBok5HcuAlYfTPFPgQQ++babd14sAtbNasSrQGfLr7VfEpy0QSS7LpFZf0wfyzR0q5
         94ni6CagJ+S/8H/fjXs9cwwRgIQBE9dQRcrg0ZsZnOtG3PNUS2zfV2tQKccBLSxFXqWk
         ZJH4OL+J2vp0rJF8vWgggvOJP54lj4Qj+GuYb7oLdmkGeswxp3lxy/q7gn1XFpUYW/Up
         /ssJMl3R41RSw8zTCBe5JxnUmOSoZfEslTrK6zY99bQEZUkZD0wP+yJV4wT+0Hi7RlHJ
         L6zLOP4QVILj0yozHgSU1F2HfAUiJIJKkASRE9IloFf+/PzkVlp1aBv14OFMzE59A0ul
         EezQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuPZ7sLRsYDLhqrtoOSgEIDHCIbD9OCb4KPTyjP7bBxghwb0EAga38hirCCZZOQNO3x9slhZL+6IGVgn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwECDIOsGGZFjAM3aNPDVTwFRNCxIuSif8G10dvYQMA2E04Y6ry
	8m2f042c1v/WQ91fqu7mgnuNl0h+Xr8AU4DnHMOfF6j3id1GW2WE
X-Google-Smtp-Source: AGHT+IFNFRu7l+HraQU6DJHAWwbySTGcg/HyrUZN0ku3fYnYj4nLDdazVhQ77+wjjm0IOsfYtwyAsA==
X-Received: by 2002:a17:902:e74f:b0:202:2e81:27c7 with SMTP id d9443c01a7336-2076e3f77f9mr23236475ad.35.1726113886161;
        Wed, 11 Sep 2024 21:04:46 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:45 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 8/8] staging: rtl8723bs: include: Remove spaces before tabs in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:09 +0530
Message-Id: <20240912040409.3315067-9-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
References: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change improves code readability and ensures consistent indentation.

Reported by `checkpatch.pl`:
WARNING: spaces should not be used before a tab for indentation.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 09ed298782a6..32f6d3a5e309 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -81,12 +81,12 @@ union Keytype {


 struct rt_pmkid_list {
-	u8 				bUsed;
-	u8 				Bssid[6];
-	u8 				PMKID[16];
-	u8 				SsidBuf[33];
+	u8				bUsed;
+	u8				Bssid[6];
+	u8				PMKID[16];
+	u8				SsidBuf[33];
 	u8 *ssid_octet;
-	u16 					ssid_length;
+	u16					ssid_length;
 };


@@ -162,7 +162,7 @@ struct security_priv {

 	/*  For WPA2 Pre-Authentication. */
 	struct rt_pmkid_list		PMKIDList[NUM_PMKID_CACHE];	/*  Renamed from PreAuthKey[NUM_PRE_AUTH_KEY]. Annie, 2006-10-13. */
-	u8 		PMKIDIndex;
+	u8		PMKIDIndex;

 	u8 bWepDefaultKeyIdxSet;

--
2.39.2


