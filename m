Return-Path: <linux-kernel+bounces-357420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F498997111
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D091F260DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F581E230E;
	Wed,  9 Oct 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aw+Mse5c"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C441E2302;
	Wed,  9 Oct 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489916; cv=none; b=aL95RU7f6RItgIoajdwTGgBOiaS9SIAcZTgS0XcyI2OnyZjF7MaTCqhyajKUJD+fMN1bFQl5IdPfaZqZQAJqxHw8Rq32WLAHV9kmx2KvoSStaZC+PzZ3r5x46oJWB5BwSOqqcY7KMDg/eP5j2nyg/jvCpN4YsdW7crda25WMyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489916; c=relaxed/simple;
	bh=lG+fHK2MinwMYosaibHFebeA2lfmTZOvRzS/e5kBX48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DpvGxrQ90nki3uGAGRI8Jjq1dQavE46YjPaknNFi8y+TN3u7oiz/P26JHl0OXdyv0dii/rX5yYnnpLbjNNMl9TxqwDt23USUIG88Q6Tqb/KIeUpVi16sU3d6Qf48WgYweib8tHrN1YsYx47/gjFerb40YyfBKjzskWlgMZpe+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aw+Mse5c; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso77035421fa.3;
        Wed, 09 Oct 2024 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728489913; x=1729094713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIa5sZ1sQN4F9/EAh7jCAPDk1gS2+mafy4s61EUtTUw=;
        b=Aw+Mse5ceP6KDi59UaahG9QJuXawevoi2alr/vBtvvXarY2hyi3kk0vQ2F+lyKXPPx
         geb0iurX/WFxceGlAkcDO5iVzWDqb3Lp5Qs2FI0PaeNfd5BAv2B197W/t4fUlGg/BDSH
         qY/bo7TqKjOLuki2FWJCE5Ap4Xrkz4YeMfwBI9jFMH5EDckr/5AHtIbAfa2M96hfRgen
         SiS3eWhaqJMKZl0PvyBU5DLSxnPyLu1gXmvkZIupQ000EPA7R5Op0WlWZ9mNPWKupP4r
         g3uaSMitzCgRFHz4TDjeD4ek95Q3Igfg0mgvvK+R2NsFVXonj7FCCFds1Il25P+lj4ob
         BIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489913; x=1729094713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIa5sZ1sQN4F9/EAh7jCAPDk1gS2+mafy4s61EUtTUw=;
        b=PDAFPntueK2xYOMFEYQJb4USrqPb6jI9/M4rA43kS+NbN6g4h59TeNvW5f/BvOAa3/
         85+9But9AuTULkNaNflEQzWMrtLcHB/zejUdY64af0eS9rpiOLbo31IQdXhcdfNmRgsH
         STV1nQH3i51uxzuChijW+Qb3NncUKxea/6Gom9kPga0qmMrd3e6QsnCwtdcp1rNtC7uo
         2rh4CaJNSQrZgY+B/fydnWsXgRgoL8cZ9BFWNm5VFuYB9xUoMbojSP0t1pLUv2Ncmc2k
         1nS6PjJIhZZJOf+S58+pZsYO31rY/JzQr4w7KIYuRoitw3xdG+iBM2TSONWCW7wEcy63
         r4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAGYx2es6Sy5gsJkojiHgtTaGjX9/rqUAc2RoZDp1F5YBw1fkeB8FO6hCNt3Kf949UXzSf+XvcWHUetSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUQ1uqcQbwXoBOZ41MgR17BOSu/HLYj6Pj5YKW5EWtlPk3ABu
	VQwQ5y10FJncGahMDEXcvqHPFxhKZsWTEjmZHnBrgQs5zPRp/9uN
X-Google-Smtp-Source: AGHT+IHIlkFtmtsRJ++tKxL+GXbAqdTfJNdHb/CKldkqVa2DzJdvODeH4o865Vxvc5KYCgRQ2o8PaA==
X-Received: by 2002:a2e:8e6f:0:b0:2fa:bb5d:db67 with SMTP id 38308e7fff4ca-2fb187aeb2emr16410001fa.32.1728489912522;
        Wed, 09 Oct 2024 09:05:12 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e0598947sm5582859a12.11.2024.10.09.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 09:05:11 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/xe/guc: Fix inverted logic on snapshot->copy check
Date: Wed,  9 Oct 2024 17:05:10 +0100
Message-Id: <20241009160510.372195-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the check to see if snapshot->copy has been allocated is
inverted and ends up dereferencing snapshot->copy when free'ing
objects in the array when it is null or not free'ing the objects
when snapshot->copy is allocated. Fix this by using the correct
non-null pointer check logic.

Fixes: d8ce1a977226 ("drm/xe/guc: Use a two stage dump for GuC logs and add more info")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/xe/xe_guc_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
index 93921f04153f..cc70f448d879 100644
--- a/drivers/gpu/drm/xe/xe_guc_log.c
+++ b/drivers/gpu/drm/xe/xe_guc_log.c
@@ -122,7 +122,7 @@ void xe_guc_log_snapshot_free(struct xe_guc_log_snapshot *snapshot)
 	if (!snapshot)
 		return;
 
-	if (!snapshot->copy) {
+	if (snapshot->copy) {
 		for (i = 0; i < snapshot->num_chunks; i++)
 			kfree(snapshot->copy[i]);
 		kfree(snapshot->copy);
-- 
2.39.5


