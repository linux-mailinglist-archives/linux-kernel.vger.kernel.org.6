Return-Path: <linux-kernel+bounces-296290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE97095A8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABCD281AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501BBA45;
	Thu, 22 Aug 2024 00:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhzT4WUc"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403268F5A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286245; cv=none; b=BMNjON3Rrq0vxkQfI3M6GHTg/CMBmc0MGCNj2waMHjofNRtUAAe6RC6iVi1qMfMvh7ME49fUjSx2UhxQtj/yhSVZ38n4ZD45lEvj08X3+FTzHNPKfcslH/wEnQKYXlR/CNo1xLsw0udnerigWGkUw4RW7mFd3WWYi/XvgMsxMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286245; c=relaxed/simple;
	bh=E43a4QxGfWfleu4yve62uTS5HZZeuJ03AnjlfmpEJEI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TJFDLf8qV3RKCCVb/9AMEsoCMF/gtz2FaKuO66oiNniVRHaRAazUXiqOiY1rSaViwvLtvvQkOG9WyVBI2+G20Mw2ltRY4Xkz5UqMYXcKm+jAyg4xWw6oWTKxVm/na9L2bxcsR1dMN/A64cqmuTaN28L82SDsVWfGWfwoGHV38Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhzT4WUc; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2021537a8e6so2168185ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286243; x=1724891043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BI/Cuoavg1EZmfqc6I+MaekM6R5ly8VDmqCakm/t8U=;
        b=RhzT4WUcfZJ8joMu/kuOeswfn8t1qjW8c+70mQza2Hz/uhI6yM9T9L4blkx75neIyk
         eF1mBrLrtjmC1DSM7kwu86FSzFM368yrbjJzhzUWP9WIpeIQitD8cryyr22gqBPT0cdA
         qHC6kEzTW0ip6bYMNKDZ3mW5QqdRpMcV1tepq8cC/z11BQfBw3yGMzIbZj6OkAJzxAAk
         kAbIBj/EyqlCpATqFipsis/TvOXleSURM7fTtsn+ANww4GcJBcWFMxGZOhGrcO9MegvG
         kYGZcYoov1g78fJXlG/n3xGeHkvPXdXvxCM/a5VnRIcglWcNdObzeHO2imaOJ5Ub0GYO
         sxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286243; x=1724891043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BI/Cuoavg1EZmfqc6I+MaekM6R5ly8VDmqCakm/t8U=;
        b=YeivOF2bim97dP0V/1L79JYMJehqawXFiGb9exZexiE1B3idqqo+H/ytKcqR9Lwfjb
         TG2dNkpqmRVFksG1O5YftvGB1VOxR+v6OPIGF1eoaWwLMFuqilWsu5mCjpQSi69Jtx+9
         6SNizm2LSGseM/9BpjV7T/3ahCrVEOwFiyag/HbVuKp1H0iyKVnu2LJGEevWqZ7/fMGH
         1Trf0hcVOm2ooltKv9TzsR6F0/+nd5QcY6NA3kTwd5eft4wyfpcF78ReCGLWnRbBLTYM
         /ss/Q+RbOj71L8DhTFQ/OkM3IBZZ0txZ/0NPI4gQHDOcbNKNx9OMEiE0UGA4BSvc/df2
         Tr2w==
X-Forwarded-Encrypted: i=1; AJvYcCXNtXW4/sZcruXY5YywHVb5PmS7Tx/jm765kQKClcFSZtSDjE+wgrQwzMi6CjoGsWydUvPTbSuUdOOdX1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxVUpmpahj3x6Bs8kEVBKtDzabk5tICQuAs5UijjrC4Tllgrs
	KYw0+MetJdMRp9+GwVzMXt/BCjv3zqnKZv9OleNJVKKuxTravIiJ
X-Google-Smtp-Source: AGHT+IEwilWiZTOg6ZITaUWHFGun0J3N4EgPXDiH1J4YUnbPthL/Jc/UdeHpFyvVCe0ImoO7+SYAhQ==
X-Received: by 2002:a17:90b:1c84:b0:2c9:4c3:3128 with SMTP id 98e67ed59e1d1-2d5e98bcd51mr4459011a91.0.1724286243246;
        Wed, 21 Aug 2024 17:24:03 -0700 (PDT)
Received: from broom-closet.unicamp.br ([2801:8a:c811:1:92ae:ceb4:3338:3fb3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm2559443a91.17.2024.08.21.17.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:24:03 -0700 (PDT)
From: Gabriel Maciel Raad <ffunctor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] Staging: rtl8192e: Fix parenthesis alignment
Date: Wed, 21 Aug 2024 21:23:43 -0300
Message-ID: <20240822002346.3555-1-ffunctor@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix parenthesis alignment and unnecessary blank line in
rtl92e_leisure_ps_enter to fix the following checkpatch.pl warnings:

CHECK: Alignment should match open parenthesis
CHECK: Blank lines aren't necessary after an open brace '{'

Signed-off-by: Gabriel Maciel Raad <ffunctor@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 5aac9110bff6..7b6247acf6f4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -204,12 +204,11 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->link_state == MAC80211_LINKED)))
+	      (priv->rtllib->link_state == MAC80211_LINKED)))
 		return;
 
 	if (psc->bLeisurePs) {
 		if (psc->lps_idle_count >= RT_CHECK_FOR_HANG_PERIOD) {
-
 			if (priv->rtllib->ps == RTLLIB_PS_DISABLED)
 				_rtl92e_ps_set_mode(dev, RTLLIB_PS_MBCAST | RTLLIB_PS_UNICAST);
 		} else {
-- 
2.46.0


