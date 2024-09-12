Return-Path: <linux-kernel+bounces-325930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F7975FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60CE8B22E21
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DD718890E;
	Thu, 12 Sep 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7PcvFzq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258E188587
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113865; cv=none; b=axcnOjy7hkxKKCxKB9Znxo4Y939noFxIoWcMUnZqR+PK1/HN+U1vH8Z3+4uYupUmVKIVGuqaahDYtD7WdHH5kjjnZ7lkHuAswojtlKyAhbvRbvDe0onYjng8XTNOi3kAVHKVkFwYKmAv9hU2TbuJtYWVESRYAuo2PlM5Cidcv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113865; c=relaxed/simple;
	bh=p+vypDuDMOvowsiMhk7OveGdNLolZp1WdAqRhn25tPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJX9pRA4OTk38XsTUS2m8IBJkbJAOs2aWVap3iQX/1+1Y8/djNBICobu4tkwZz2lD/6MxLMcbHu5CQfLKL+VcIZLqrDh/ca0ak+vJ+tOGG4a4zfXvRDy1LZLq+bUcgdkLsT8JsVVx1bZ90dmGvTAu6c59OzsdZrtzepp6Grtcjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7PcvFzq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-205909afad3so6119535ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113863; x=1726718663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zoSbD/XElrdewN0Z48FWs9MJU7wP3FXNvULxVd42pw=;
        b=a7PcvFzqDduN8zZ1kpWNU2iTzeMT++0dmL6UQTI+VPIGnmA+yV+U6g1toPZNwSGDVj
         iclCPBS7YFl+8nBAu3Xg1O8kE5haWStbaZqoR6MMSGx+peVIfDZiamz3Voy3V91kc35d
         51MqoQ1UqHiT/hRNIOevJiKgLBavK0vji8SqxFrSw8FxQ5zvvxBCxLJJLIwP/dzf0Ksg
         do2U4EL19PyNRGy4DmFu0xjJyO9HBZf025kSYEy65sLYQDlISK4dgScOwkpVxACF4qRU
         omAqhpwMp5K+W7SMGTMA70qbP/i/ZJIOj3yQJ75X+ciYJNM9OkTWhbHgLJthWMcQWMYs
         J3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113863; x=1726718663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zoSbD/XElrdewN0Z48FWs9MJU7wP3FXNvULxVd42pw=;
        b=KS9fG2eD5BQ7j3Cd8N7AwqQkb1dnq2P2DTtEkq+StE6Lv5JEkai9CwCqE3pNntfulf
         c/NyS7bi2tEmsnXrWj8j4Z8RpHaU6mtPiR8UF+ppD0y+IqnpKj0YfbYPnvv3evomydxS
         df2xsJfFmo8cPZNDShKp42joEShrvszjbo1bTkPtMT6YP6Nl6znY4sg/MSc0prTb4afc
         lDwSR5wQj9hHuoilqPkcOtFOcpjbb8XptcX+USG/GvQhbBF4AcA50sWDwR3au87s8Bjv
         RBc/Ifkdl2gaB5QDAzS1PJy5zGpQXRvMto4kxAiGgW63ZIOO27jh4wxftT+ahLJewb3w
         ONfg==
X-Forwarded-Encrypted: i=1; AJvYcCVc06DbeQ7GSPuM67/i/hD0HQgPQKpaX9WXwOjbtRFMZRTpDIbLmfv7rSp4QI42IjgzKhKRJ3A+62hDnac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVfkrwN0a71KOZEgbRz6EPE60JV056i3I3HD+e/TQLJHWRqFJ
	3ntC139wQb1F81PCz1GXDNeDBY0v0Txd73HOe2rYnfq5lf3FWVLX
X-Google-Smtp-Source: AGHT+IH/7Gpo8Sq2l3q2Gt7692KhXZvLDIe/Gd1lAKuPM0yfbKM+867cpJQPRyaP0NsS+PPEuahJQw==
X-Received: by 2002:a17:902:d546:b0:205:9112:efea with SMTP id d9443c01a7336-2076e39c879mr21496385ad.35.1726113863229;
        Wed, 11 Sep 2024 21:04:23 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:23 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 1/8] staging: rtl8723bs: include: Fix open brace position in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:02 +0530
Message-Id: <20240912040409.3315067-2-sayyad.abid16@gmail.com>
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

This change improves code readability and consistency with the rest of
the kernel codebase.

Reported by `checkpatch.pl`:
WARNING: open brace '{' following function definitions or control
statements should be on the next line.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_security.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index c3e47d52687f..953076667b4d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -190,8 +190,7 @@ do {\

 #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
 do {\
-	switch (encrypt)\
-	{\
+	switch (encrypt) {\
 		case _WEP40_:\
 		case _WEP104_:\
 			iv_len = 4;\
--
2.39.2


