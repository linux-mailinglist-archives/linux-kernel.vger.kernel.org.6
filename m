Return-Path: <linux-kernel+bounces-320380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A04970979
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 21:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E622F1C212E0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA9186285;
	Sun,  8 Sep 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="PG1EVOyh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A417C9FA
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 19:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725823607; cv=none; b=AAXJJzYdlq0MvI5qOgL1NtWSqoCM5UmWpWuqEiTJbnnI6bqCT4zWHZ625+i+kUrwejJ+M+y1csr9liGyh3IJxqyo78FidbAbhMRKV3+ePysD8gdv1iFCIWoT3Pvm8nRim1eqtG8YzqGAzkvIdxuI9x7F4aHkJFV3WYOWN1xjpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725823607; c=relaxed/simple;
	bh=L02lVgIrPVpyX1TYuHNwcoDskfqxKULdXO2b/ru4OiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Le2V82/0BOk7Ao864SDU9IcsnPn1z994ePXs+1znxwF+47qgfM6eesEEUFUcTe50FS1FDiNPD8LM3z0P3Q0S8XO7TG97JSS+fKNOaQfWb65cwEzk7L9yKKx4xkiZDy94M3M179oL+Ta78pRVespyoWtkp4Y7QwtNck7ULIGtfu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=PG1EVOyh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2021c08b95cso35049805ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1725823604; x=1726428404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6pmwMlirClkh1arNo035bBhvK2xtwOFwf4bLdJcZv0=;
        b=PG1EVOyh4ajz8u/4Vs/B88Jis/zMuTrYxFP6WGIwJ8f2a99vA/7vMa+eG0d0M5Y9NK
         GFEX0B2BjxVr9xkUYWONMPdr/PjrSaKIJS46kh+9X/FsvTzf1ZF5drMkiUI8jKeYIHRs
         qm+S+m+8m5OmxFKP7ey4JSHUUW8AbeJD5RGwip3DkO0ExY40XLwNACUXwFTmjUQMPfsy
         c5XlntalHVIfw9yOIme5RtiiRMv7jJ2OCD6tligfK04JRKB4sab4PTQTqeQJizU9F2BA
         GR/lwSuaq9h/PVbMp3QMEcaqn1Q+r+m/DzyNzBjgbBtC++y4D+X5Ii+0/abGrZ0bfadm
         K8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725823604; x=1726428404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6pmwMlirClkh1arNo035bBhvK2xtwOFwf4bLdJcZv0=;
        b=qEwtmNf6aOeJLN8XrFrppQvH9RvXeboglOoCKpovv4xIiR5fXlFCo/WxVHBi8kC5s4
         INPw0LXz7iCSecyBfL08zNTfwddib/4XAoQcDpo+GlBjxBbic2TA4ZBA6heERbZmVY07
         9YwMKom7C1o5CDRmhfkOJU59SVj1t0zZ1BAD52gWUylkhfEPQdF9e2FOl3dVYLFk5ebi
         EUo7tX2r96eQap+RTB+QaQDPjLi25vUoLzpcyoGN/FUBanAfR81drbJbzR4BOVN9/6nJ
         DqrFVmN1BEJo3D+TvrsC7zcY/Q7eWTHeTpdppWJ30Bnx/U7qzCVQFWdntYGPtD4M5+V1
         CTJw==
X-Forwarded-Encrypted: i=1; AJvYcCVAwRtZBFkYL7CffzOxW2B2OwM2rUrmclJ67w9HnCyaINIHADVQAQ2xP3b13PeHbZLgRCZpqSoT7LBmlzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4/NqUJ5zMdiOeymRsc3rqA3q7y5n98V76wm21izXCrHhCtYS
	wMGzIMUhkkgtto04vpYiNrAVlBaXqr1E+Uz0HgSVPP1ksTeGWIClM3Tf5zcndU8=
X-Google-Smtp-Source: AGHT+IE/8ODkzgxNwDLCGK+TWiTrZJsd1x1ngShkhBybZ/34KWM3l3AWoD1iX3aQ2MbOa2GOwmQb4Q==
X-Received: by 2002:a17:902:e545:b0:206:892c:b758 with SMTP id d9443c01a7336-206b833e57amr266089905ad.13.1725823604553;
        Sun, 08 Sep 2024 12:26:44 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e1b085sm22703305ad.36.2024.09.08.12.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 12:26:44 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/16] Staging: rtl8192e: Rename variable bAssoc
Date: Sun,  8 Sep 2024 12:26:27 -0700
Message-Id: <20240908192633.94144-11-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240908192633.94144-1-tdavies@darkphysics.net>
References: <20240908192633.94144-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bAssoc to assoc
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 3621f27b083b..b599309b70ff 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1726,7 +1726,7 @@ void ht_set_connect_bw_mode(struct rtllib_device *ieee,
 void ht_update_default_setting(struct rtllib_device *ieee);
 void ht_construct_capability_element(struct rtllib_device *ieee,
 				  u8 *pos_ht_cap, u8 *len,
-				  u8 isEncrypt, bool bAssoc);
+				  u8 isEncrypt, bool assoc);
 void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
-- 
2.30.2


