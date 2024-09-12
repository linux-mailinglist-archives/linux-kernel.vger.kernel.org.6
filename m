Return-Path: <linux-kernel+bounces-325933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6D2975FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 210C1B233C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3E1898E6;
	Thu, 12 Sep 2024 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfRhR9jX"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8B18950A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113875; cv=none; b=RhMepyZkHwrszR6WdWIK6RsorPV9lH67iTuYsxEK+iFPGYe5zlzU4KeKO3H687KLKxwoSXiN6n9LITSQudL+U3KXbCtfxFHgX8hY3l54QJV8dFU8fBTKPJwxm9mRNDlFlc0KnfUBjjRWor6LjV/cg+Xk0owN0ec5Mts6wCEMyYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113875; c=relaxed/simple;
	bh=8nxyDJcKvfaE2YoayCrAHbXJF+z+7/4qP2LTJZwR+cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bpkF4gsbjkbqA2UJ60eTLakos2m//WIO3LW9wfJttSDycxaMkKhy5kMZds0hvPI1UA5I9gkjo9xY6692eVs3d3NyrZI5vtzOUbL+rQckhyN1vr31VMfBLOAqo+rLohAfw2odJh6Z+4nXBb7scVG1nwX7AkO+UpvBhrIXv4X0T7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfRhR9jX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d91eef2eso290874b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113873; x=1726718673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I5sXZJVd6DoJL2ghSKrRMRQLAAStuHg4Or/EqIZN4Q=;
        b=UfRhR9jXnOCORVuwgjgfdck4kFSmlhlSCGX3hzuz/9ECJCaml+zJ/Gv8pITeFeWWDQ
         Rb/ZGzd9CqwbS2Cx8HFGkEESx964NWCMJx5zpUcDf9ZFz5cGEsc/vjJ3w6Pl51hZQ0/o
         Hv9DboEG7G2iwZswiDZLHlgkpaQE5wxn86+u+NDZoXVXOdJ7K0gae8BVNVaEQNQU9dVy
         IEbftR45j7zxRPZooF6MWp89nrn5IGsKBKl0Y5JKysRM8tNqmejN0fwf31qnDfX+ipuT
         ftllZqxCv3Ar5lYIKWDgDNLmsOBUAQvYTzmOafgs7wvw5iXvZSSV6C0hTPQqqGbTP82f
         5pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113873; x=1726718673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I5sXZJVd6DoJL2ghSKrRMRQLAAStuHg4Or/EqIZN4Q=;
        b=k8l8nVyVuHM5eW2+3rPrQxrHdXSSTiYzMbJdwTNym+Ih34IOnfBaxt8rsjKBww2XqQ
         E6cfN27x+K31kF2l8VLWNDFZ30OlNuTcBMCisaQ7R70+vjP+jxrFHdTr2absDfEhm1jV
         dvm9WRdSFaSV/V6hTM0DxQmx/fZLVRQzikQjyX2QYwLuxJb18jF6CQMJKPAZDdpiWUBR
         mJslAJEilK3SV8ueuQkJE074pbcDP0fg+uBziJWMScwkX3QvAJEiPp1Ig6AGDi0S1gZa
         i80Baxvv6EV6enHshUdaJ9nHbWQgeQsKJpvAOcTAJchBT1MEV3Hb3eczqWBIGvxOlmu9
         h6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWZcbuEWkbN1/fZHEhe5kHKWEOsKCsW93mzjNYzQM59m7uiZYjbl0gDyYE5urDKOQ0L/p2rfJGiEmjkl7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7IarLyz8pdqA9I4m7H+a56qT30q+D3rKyt6mVhUFKB4Mj7Gx
	awMSfeMJQeXGdkNnebn1pbM/YAczVdBIWJzfuTAsTtyf2UnATK8N
X-Google-Smtp-Source: AGHT+IElAKHNYdE2RMto0PLX8schrZEEVREC0BdUYqLm6TcPKXu5UKuxpfWQ8uzE0Cha2/hrwvNIkw==
X-Received: by 2002:aa7:8f8c:0:b0:714:21cd:a4e3 with SMTP id d2e1a72fcca58-71907f721cbmr11972046b3a.13.1726113873069;
        Wed, 11 Sep 2024 21:04:33 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:32 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 4/8] staging: rtl8723bs: include: Fix use of tabs for indent in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:05 +0530
Message-Id: <20240912040409.3315067-5-sayyad.abid16@gmail.com>
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

This change ensures that the code is properly indented and easy to follow.

Reported by `checkpatch.pl`:
WARNING: please, use tabs instead of spaces for indentation.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index ee4b5c5804fb..0c3271fb7e9d 100644
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


