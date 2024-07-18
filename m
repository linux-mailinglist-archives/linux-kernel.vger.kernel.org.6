Return-Path: <linux-kernel+bounces-256654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BD935196
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BC0B21F15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8154278;
	Thu, 18 Jul 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpUxQU4T"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63F1E495
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327428; cv=none; b=GBvLHOciAnI+u/BC3rNhrgYI8ATT3rwHKVg9XQNsVgRm4sopXZ507mLqBQhaREW5qTkWbMDqg4K1RGgkaX8piZDxk1fYls+I1hFUo3pddse4sjFHcRXCDwh0EnylSRzCYnvixbm1bYs0GW/SuMSU807BWY9lniHbpctmaYegdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327428; c=relaxed/simple;
	bh=TD1+61nPDe9jB/4IMkUiQtOBgJX2zOKDPnI9xvRyrmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZCQstwb5Zvu0piaoaQvFhsCSK8lTCY4oetGPZSwWJDlToHSpUPolBUm9nEEOVpcoIalGpChIQYWQFGq3zP4MlyDEXYjJJY9AeoWGwcXZgciOUfSATwpJr0T+xmQ2sp0iBVr53BZLclbB3wZvG5n02JjNaIH8HwX00STH5Mndv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zpUxQU4T; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b9778bb7c8so561205eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721327426; x=1721932226; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bu3L66gXFcN3QKFM4M2IyGwT//LPj6mk9IKjJSFoji8=;
        b=zpUxQU4TO26i8UraVGq12dc8lXpwW8VwUIi4sOTAqDqlwtCHCCPyP5k8Mzsc2tGMJF
         tZV9N/b/sSC4e7Yq419EflIuF9L5UXaZsUKlHHYRI7KBN1BniT/jdliDTCgzGiRtxl1S
         SxtH+22VzYboTs05bcyUqD+tE0DUm5uMDAbsnwX65JLaFGHjJU9BludFXmvpbsS9NmLY
         IUcwW++7fHhbKLXBPE95lZzAk92NPmt6BZO9SM9B+Tm/MzIa2wlhkdL1BZUSfx6XkSil
         4ciukqcl92liPcdipKH5oYnHhufyHUey2MnWfRjUPA0uxL/QsSLt2Sl7sFg0lA4ipAqq
         W4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721327426; x=1721932226;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu3L66gXFcN3QKFM4M2IyGwT//LPj6mk9IKjJSFoji8=;
        b=Q3LlkCoBAjUaTfrlNv7/5vK2TDQ/qiTU9gH4nlSHzlIJkozxrdUEE6f9/l09EVBots
         vWWVRMZAsaKB7aMpPQBwnLPhBgfFVafQwS4AfvYhGcSQ/Qakz4Fd8DGqxeHj+3MClojC
         fYGroEdP0r4P8pDSkNv4UmZQlE3gwbnYaRsareTU2ni88MTXtCW2KeWS2uS9ha0hDldd
         ob+1zS9vvI8wQELIZiPpG1mLwjs8de85m/l0WR9C7nSejdOUUgzLI+O5W7t3BQwzodTf
         jjJRl+MojsTP2NYN5eMknR94kbhYvMEyd+UTkDl6VZZiucqnmzgr8ZqF9OMkHbvKo7rc
         Skow==
X-Forwarded-Encrypted: i=1; AJvYcCXefTAGgBOF0jY0N7nM5t4O07A9ED0JPA6VgiK2gFsGRE4rv8xOy15VfxPScpfZYyW3GYSiAeQOSBOaA73rLXtknfkE92YUSw2rgxEL
X-Gm-Message-State: AOJu0YyptyK8IM2PL/6hkVdpw+gVO6cYdQ/Ta01pr1smYQ2OD4BEP3sT
	qW4xhaPttssvrGe8Evm/xO6lTGqMmV4CEeyfOGBWUcNAiujm97Gpvoe2v4kNBW4=
X-Google-Smtp-Source: AGHT+IHfVnIuNs7e/rNBEuwsyQLUJ7M7eNZl5L5eDW+zD/V5s9h31Hxelwx+b54/gMeTAXhX7pudZQ==
X-Received: by 2002:a05:6820:2788:b0:5c6:61b9:20ba with SMTP id 006d021491bc7-5d41a4c1e69mr6849785eaf.1.1721327425729;
        Thu, 18 Jul 2024 11:30:25 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8d5a:14eb:55d7:f0ba])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d3ca788101sm641622eaf.16.2024.07.18.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:30:25 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:30:22 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] i3c: master: svc: Fix error code in
 svc_i3c_master_do_daa_locked()
Message-ID: <e017edfc-da64-496b-8516-958bec27cd9a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code has a typo so it returns positive EIO instead of negative -EIO.  Fix
it!

Fixes: a7809cb368b9 ("i3c: master: svc: Improve DAA STOP handle code logic")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/i3c/master/svc-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index e80c002991f7..0a68fd1b81d4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -874,7 +874,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 				 * address this time.
 				 */
 				if (prov_id[dev_nb] == nacking_prov_id) {
-					ret = EIO;
+					ret = -EIO;
 					break;
 				}
 
-- 
2.43.0


