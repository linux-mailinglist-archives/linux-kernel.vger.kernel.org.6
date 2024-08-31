Return-Path: <linux-kernel+bounces-309813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6519670AE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8D9B20DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D4417BB32;
	Sat, 31 Aug 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc0UnoN2"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068F14EC64
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098924; cv=none; b=DTNfFSLZfAwAvFmzhFO3PRwnk6f3H8Evvr4WnWwd11SKrUXUsNl84c3PdEhUEfJWioTjCT1/48mte/O6GgvXyvb++KWzlIQ85wAzFPplzvuesgOV5iQj45j41KX0QRQ13mpGBkuO5qZTLXyRQYIRpf5t28ohffmOdqBHuV6LS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098924; c=relaxed/simple;
	bh=lRt8QXBAEMDEHudWZcs6l/mS4eKC8igXg3gXJoGRItY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwnOibQvLuhS6/s5NFBedoAR15MhDaxUbztiKa9cRnNPiOe94h/R8kS7oGZmrtsJj1XIoSMW7MI3wcX5DkJHwipKDuSL4Lyk/QYU5RwUJ4ms4j61ZthDI6w1ViWrv493NtRWyhk8aKwIPaXf3xwGmFexeqTCCrN4OgyYHzrbLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc0UnoN2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8682bb5e79so322819766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725098921; x=1725703721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ACjwtThAqKgLa7HyubbEeDyJr1LzZplkXNL6wUC0YY=;
        b=cc0UnoN2W3vPTxswCxEWAmkzfJV3LfeMujqAumM/4hUkfGm018yPigW+FPMKHWNJlE
         Ep00S9XgYoY4bftmBWwzFExzLJR73SRf7+IQFiUA2l07cOmjbDFQ4vNX+eL92qWymYJu
         Y+//o9arIqOjnkXxxwL4+m+VXRXJZDneFUfKM74tfMOQm/9m6o4qEI68a9KVGAeswnNh
         j5eojVfE2B3A8W0Yk+LtHpBZiCOmemib45A4kgp1SiQcSdMv68GJjoE8nEsrbXe8wp5c
         ZGfAPnqrLwgtHQsgPTZix/or8bIz13CdMYEF9AZttYymHMaioFIi64B/b/ihp8GzT0iU
         ya1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725098921; x=1725703721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ACjwtThAqKgLa7HyubbEeDyJr1LzZplkXNL6wUC0YY=;
        b=nvEDBZtz6O5qhnoroM3VrlX1WhsggN8btSq10nngotnxw5pmxRY4iHrvLwcuOTpjCx
         8KA///KNrowewKzgFN4/VkNkxaw7rQCTrQ1mG9ZvdMxLC5/knel59yiDJAkEANn0eqkN
         6SCqWxmCIJh6UrgfR7x6i7aUyZvKtJbSswhztllsZsj+nn9niX2RcYQR59ANUen6wBYr
         ZpEOosPdkWpkxhy1Zz09CUhg4skxYlM1QuUYm6U16Ku2eS4hyyabSSQFJajUbhiFC0ss
         fWwXvzjsBNvFXwisnEPeeP9lO3v7csRdaidPTDEqzIb3VzvvUI+4c5UJrMyg6vE55mwx
         CdOg==
X-Forwarded-Encrypted: i=1; AJvYcCWsfZ/ChmBzK18DUMdjJnPBHdfm3MhOnfK80Tbj3XNViREdBJ8SUDxnP7YxE0VirCFPBs4R4t1FOI/vfhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HJf3srbFcAaT7Ce/RRTRrD36zhyQTRqlRyoe/Q8aiN2gPUjJ
	IQzyZyxHFY7KDFfzsTahXQ2G/IhEN0jK3JjMFi/0n3EpiUAZ8jkF
X-Google-Smtp-Source: AGHT+IHuwwsZPbZeLM2KykUtGIG0bkb6V/bzneibw2uMu1Ny0nAV+YxFoJsYSTwR0eab8RDGY36vVA==
X-Received: by 2002:a17:907:2d12:b0:a86:938f:e84c with SMTP id a640c23a62f3a-a897face2f4mr580232066b.66.1725098920183;
        Sat, 31 Aug 2024 03:08:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aba11.dynamic.kabel-deutschland.de. [95.90.186.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989021973sm307444966b.82.2024.08.31.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 03:08:39 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/5] staging: rtl8192e: remove RF90_PATH_{C,D}
Date: Sat, 31 Aug 2024 12:08:04 +0200
Message-ID: <20240831100809.29173-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the unsed RF90_PATH_C and RF90_PATH_D from the
enum rf90_radio_path and adjusts the size of arrays that are indexed
by values from rf90_radio_path.

Compile-tested only.

Michael Straube (5):
  staging: rtl8192e: remove RF90_PATH_{C,D} from enum rf90_radio_path
  staging: rtl8192e: adjust size of rx_pwr for new RF90_PATH_MAX
  staging: rtl8192e: adjust size of trsw_gain_X for new RF90_PATH_MAX
  staging: rtl8192e: adjust size of brfpath_rxenable for new
    RF90_PATH_MAX
  staging: rtl8192e: adjust size of RxMIMOSignalStrength

 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 3 ++-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.46.0


