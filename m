Return-Path: <linux-kernel+bounces-260956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFCF93B0E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D7F1F2482F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBB9157A4F;
	Wed, 24 Jul 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLibdxRm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C663AC0F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823904; cv=none; b=UGJX0T/Z/pQVobdrcrcLMRV8m0i18TVHSJRL0c5Ts/l0CUyQDke5eD+G6ELk5IbOAsBDAtOVoiD4i+OiB4wI13YDuXZ1dY+IJogw/sqnsON/ZI83LGrXyGL6sCM8YYD/LltRQ1XLgomaZmcb+Y+fVRH8MG5qr+VdmtEa9aQ3tI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823904; c=relaxed/simple;
	bh=+pWCiNNquB4af1qu0U80YJIB1HrjPWRH3gmVEWsNn1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JNTag7hyGkjB6giiJa4pP72bfIiblAxzuSoHICXFkWG0tJgTjJDmT3HrW62duzvYcTE2aBOk4TD8q64/ERmhI10jEwzI2hMnKGVwZYmGEG7H1ou8YL9xVJr4LI/JIVUzzqnV9gxcUk4XgnSr/ckYZciz7PLxrbEJCNCeE+UHlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLibdxRm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc587361b6so8683975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721823902; x=1722428702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6joYOx0BmGiTZxFoD0gHd6sgxiMC43Zesk3xRX+VQmE=;
        b=PLibdxRmKGKmm8E1dcIMhYFO8ktTEUwWiycUri6PYVzymqHV7yZ5eMOuUllchY/BW7
         FaB0psV4A04Sd3funz8vlzw0MLbhM5CyJb6I0X2PqhA3nN4CNBGzUb86LF7AMsYY114m
         mCCR1K5BWXk4qf89yitsob9E/foD7av56Pcnx48lS21MvEY6oI5a06gKUynTmgq4dYlZ
         fZUz9jkc6jE1/+3VEu2SimdvIlHaOYZoeM3SykrLam+FEF8MlQLosvS7e9eqPTG0gNhr
         ZjLu9mQvF519LJ+pXq/wfviZ9JrxEfmgTzoyPLmsHr97RlK7mJf98X6VMYkzJv0v42kz
         HKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823902; x=1722428702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6joYOx0BmGiTZxFoD0gHd6sgxiMC43Zesk3xRX+VQmE=;
        b=e3ST6VhIIZBgzd5Gjcr327VtHD1Kjy+S0/d5jo3NP39HeMZUWiic5UiriePfWydV7/
         eFaElBhx6Zjd5HWQjTrhbD9xosVl2NivIBI5btx+adz/lFuYvmck3aa8WTQnF+IIQrP9
         lLWMyae5QwgsFBrfcjbtT4CVfK1lS7Pb3m9sLpLM+txXNHGZn4gJDUITF4X+uOF6SUEB
         uwBIaAxZKKf66lfru9KBNXTP+VotTkXkk57zqtnZA6z6+Wh04EQQZr3qPlPByBoyVKLW
         Mg+Wai0Qt1rjGJdVlZ/HuTslUN8d9y428B3okpEBfc9UATzfXDfNh5a+IPS86U4blj3F
         M7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXKk+IzyQft7dp/mUYCEeTGPhphgsNXkaazMmwZEA+2R3DI/1Uy0OF9oVG2HlCxzW3g3fVPYJ2fP1Ii6ufP7qjjlcS2pPfUGG0BEFaM
X-Gm-Message-State: AOJu0Yxt6f1voHHHNsV3sbhWctbBlFv7zxsDvVYWyE6efTOJ8KDZDgzx
	jLTexzzIYOVN4AOi7o5TAZGzdjJC9rOD6kbPG+x7I8IJwAA/ji2R
X-Google-Smtp-Source: AGHT+IEhv78htgJIo9VcY9TZwJxBejeM8ZwITF+GEbARpUDs7CsIgvsAhhu44kAfmwaD3+tS/G78fA==
X-Received: by 2002:a17:90b:1c03:b0:2c8:87e:c2d9 with SMTP id 98e67ed59e1d1-2cd2751d7fdmr9586493a91.39.1721823902201;
        Wed, 24 Jul 2024 05:25:02 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb76001d6sm1481454a91.48.2024.07.24.05.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 05:25:01 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 0/2] Allow errors to be silenced in multi functions
Date: Wed, 24 Jul 2024 17:54:45 +0530
Message-ID: <20240724122447.284165-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multi functions so far always print errors when any function fails. This
may not always be desirable, so a new member of mipi_dsi_multi_context
is introduced to allow errors to be silenced.

The larger implication of this is that all the old non-multi functions
can be replaced entirely by the multi functions without any loss of
functionality once all the panels are changed to use multi functions.

Tejas Vipin (2):
  drm/mipi-dsi: Add quiet member to mipi_dsi_multi_context struct
  drm/mipi-dsi: Change multi functions to use quiet member of
    mipi_dsi_multi_context

 drivers/gpu/drm/drm_mipi_dsi.c | 20 ++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 10 ++++++++++
 2 files changed, 30 insertions(+)

-- 
2.45.2


