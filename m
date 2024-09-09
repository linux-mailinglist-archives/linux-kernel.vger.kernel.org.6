Return-Path: <linux-kernel+bounces-320606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699AC970CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C0B1F2254C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAB0188006;
	Mon,  9 Sep 2024 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyZK3wNF"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349FAD2D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725855358; cv=none; b=AgVFjsrtPM8hlLxSdtS1ioSu74WrF1Fe5uAGGCrqrq0egRxELL19jS2kx0SqhHi+tjO4Grk3ax0nUCjubrOzd1uU6C3Flmw67n6b4B+F++Gs3Aad+44kJ7+KSrUhtsYjkzZz/y1p19qT15Ginj0Ci6MBuTDZsOm0+kt7Kubv06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725855358; c=relaxed/simple;
	bh=MBlBxn3t1h4ykxy71xe2ccc5K5aI1pv0S5R9Dojvn6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CG6PXGJwvJdWHWqBRRJnRRd0sRKOlVJVeKAF+0yuKFdo2ELRBqFKudjY5RJ6rgkTg/jM7SqLQLEkPy4P6uvtFaS2eV4wKswhssgJGhrDd2Db2SQMtyzj5ulMuRd0I0SMQRcHukLYr8fR/VRs5+Z0EL6o889MI3N5/vWCFl0U/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyZK3wNF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718ef6a26dbso160965b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725855356; x=1726460156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3akMNQABCnRWtQy+W1zIMIz/6+9MRKicWpteLSTpJok=;
        b=VyZK3wNFKVbzJujhAY4CU0td4yJjtdVmHyiq/Wk/pSICyN4LolKNZONQEsRp3TZlwV
         iL+vGjqcc5vFQGP0kD2UJosad7ENRHBqe9Zbxf/g9AkvYfaYpIgUaimOdPjvHpjnQPlT
         zrY54NyKfaAahrQwkqR2gqUVJmWZFg7mZ4484XVWMOGktoXGzG5ZcW21aBI8VD1WIrpH
         nVADyxRlaLEnw5TD33ZIrpwqGywQBaw3+jmyKQ6OwCJvI6q2YR2RjYd9IE0xFvirV6pr
         Is2OQraSjFBYVQTjEt/boJrh+uNN+fcVg3pM0X7EsiA6Z7gi9BvCS+TnLbXkLJV9tQkI
         wIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725855356; x=1726460156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3akMNQABCnRWtQy+W1zIMIz/6+9MRKicWpteLSTpJok=;
        b=tU7Ryo9wK+0/Q6FY3gLdNqw6Kbm1mJ/eDOmiRQAUl0IBX2oajyYD2YuvYXqsV9YLMg
         E4gLTa+X0dRNKrqme+IU9vXtD4dcIVGEmLzHTC7bVZ2kOts4cdZP9FoiXdN8dtQFk6d0
         36lyKgm8wGfT2K756r53HP0Mhb2hC3VtcN/dR78YhqsoI9+46Pf1VmmYDveF5L9+1vNo
         +/Qdyi2OD8jdAQd5LSkzIqaO3u1R38OUN9OmSXujjMGGu3dYV27KQZmN4b9JmnqNbPKS
         eNn0wx5fo0i50uLa8fkcWbAg5eBywsrlRgd0FdUBcI+6Nu8a7VZbiIJLxa93JnIz60jw
         D/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3J3KNkz/vvPcPuV2v1PqWR6VwGgKegDL0uH04qFe2E2PVm5ua7K5Z4aTdj69xaCLKRCWlJhkmjTMGquU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjnuRZcQQFA4KQ22eS8PdgS6uLyeeiBORB7GaIhIPBxwXWfJ7O
	r58OXx2xGAmJG0LuwAmcYGEZ17GcwbZU9OSk1FUb+lcUb74NP33eQ77wnbhS
X-Google-Smtp-Source: AGHT+IGpH/cQTxEBRwQSzysm7mSH4RoHBLBkFKfJnnYP8Nm+zEPk0mHyyngxSBAPbeQT5TASle2bvg==
X-Received: by 2002:a05:6a00:14d6:b0:718:e49f:4185 with SMTP id d2e1a72fcca58-718e49f4202mr2794372b3a.7.1725855356158;
        Sun, 08 Sep 2024 21:15:56 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58bd227sm2669605b3a.64.2024.09.08.21.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:15:55 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] staging: rtl8723bs: core: Fix spelling mistake in rtw_xmit.c
Date: Mon,  9 Sep 2024 10:00:49 +0545
Message-Id: <20240909041549.2449-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v2: Created patch series as suggested by Phillip
v1: https://lore.kernel.org/all/20240906141157.10167-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index b1965ec0181f..755c1bc86a74 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -45,7 +45,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	init_completion(&pxmitpriv->terminate_xmitthread_comp);
 
 	/*
-	 * Please insert all the queue initializaiton using _rtw_init_queue below
+	 * Please insert all the queue initialization using _rtw_init_queue below
 	 */
 
 	pxmitpriv->adapter = padapter;
-- 
2.34.1


