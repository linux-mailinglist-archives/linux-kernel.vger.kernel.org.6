Return-Path: <linux-kernel+bounces-395925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556249BC511
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870C61C21645
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C11FE0F5;
	Tue,  5 Nov 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXA9l8q+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F06E1FDFBE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786130; cv=none; b=CroitHR3bGKAv553QfPsIYjJxJa2Z5uvMOwrCmDjJ+vU+4zo/rB2TAz0R4zSfxQysAJYfI5vDvYqNnKXJ4Uc5T8ZWXpF6jn1svUam9tgQVU9t1/VdWZdZf8u1OHYe9j+NoOBcizEMUpkVgQLN4+ts/XJyNT40RuMoGGOz6VQi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786130; c=relaxed/simple;
	bh=mPq80eFRl2XtSXtNqFZH9m1jZ3/JKV2+6yqg72JG+NU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMpkHkJ4K+kw6OTaWy+AxXEh8bnuKeUpimKCSmiRias2YtLPcvQxVFtHGqZ6JYOtuSGrNMhkxooCbIOuLLFHp1+HoBv7pN/W4HNBY9WRnCcPjOaiQtsbtJ4M7DYIZLXpCJmmO+Rd5WvvO2Xoro1KUhBssWyFvrdxA0eRNPIwUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXA9l8q+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0f198d38so851185566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786128; x=1731390928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhNXg8PIe3GehDMcVl6Kc8dJRsqYwjSzBH96w7wiKxY=;
        b=JXA9l8q+4PoWEZlWLdARtHYooBSWU6bN2xF5TyiU61xdDQfpjl6GEe1P044yjg+gGj
         dfzFeB4jeSzeHecfUwKmCRyLmJltEHDIh/DsdEi+jG4H+LX+RPvt5mjV9ETp7zjvm6nY
         i4krxwWzluGv7uoQm8XJSWRuaLKyg3a+TkHACOFur5J994/S04GRQqW/oRypAnEhY13J
         Gt1Bqerz+lQ1isfRWLAsUDeTfYcN4yZIEBsd61v3DjuuheiPbKbV1DMQh96X9Y/iVWgF
         gLnH5saK8GbarZlmTzpodakJPpIz2EQLw4cLGmCxBtRdUTJcMr/vQvmpgcYhWP669Sh6
         7HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786128; x=1731390928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhNXg8PIe3GehDMcVl6Kc8dJRsqYwjSzBH96w7wiKxY=;
        b=PAztTtwITMIGkHO2g3ULmEgQlY8jeajdY31x934G8MY1ulZRTHJFs5a9KMc8MYECs8
         F7vecc+xdxGgv1MN13qZTI3DPMaGSvGWJVT530DwD6hfr8H2MTV1qAGZVvWAIwpNDpP6
         aUrF3rjlQOyH6S/J6rN/4qB52F43DigzHVU2O9HDz5II9Q0YXqcnypJGIaaEdWmAMdwe
         Tp8yL4LUoJHtgiT+7QaRasZVzUs3iK8bpe3rXx8ARGmnfGpFimklyy5WH1/UThN1sgnM
         FADTrKHvmv0EKGJVWMLQEXjEn6WASDUSVH+3fNkgT9mhS1giVlzZGa9X3E99Juw4W5At
         JzFg==
X-Forwarded-Encrypted: i=1; AJvYcCWpm4vhUmJSvHy3ewlpMd53pUy7SCMiIY/avwIW/iG7S+MjxCRZbYqc8lIMdIKgg2RQ2bs5PbNfm0UjrU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFrUuvf28kettzkpgAewY1w63atpvXUBYHN7pkCjhk1niDE1q
	l+zH2kpnKyqvS3UD1baRz9XGx+a/a9jDStpfinZqWeT8rkNUx/62
X-Google-Smtp-Source: AGHT+IHLC/DCZT3ID7+Joe+6g6Prw6Eaz0Kl69NWdZUlO0033lAVucKbrTt68NyUvJos4FWVCybq/g==
X-Received: by 2002:a17:907:2d27:b0:a9e:1fc7:fc11 with SMTP id a640c23a62f3a-a9e655b931cmr1558333266b.40.1730786127363;
        Mon, 04 Nov 2024 21:55:27 -0800 (PST)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb181451bsm78775466b.201.2024.11.04.21.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:55:27 -0800 (PST)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 00/16] staging: rtl8723bs: Replace function pointers starting with UpdateRAMaskHandler
Date: Tue,  5 Nov 2024 06:54:47 +0100
Message-ID: <cover.1730749680.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace function pointers with functions to increase readability.

Tested with rtl8723bs in ODYS Trendbook Next 14

Philipp Hortmann (16):
  staging: rtl8723bs: Remove function pointer UpdateRAMaskHandler
  staging: rtl8723bs: Remove function pointer set_channel_handler
  staging: rtl8723bs: Remove function pointer set_chnl_bw_handler
  staging: rtl8723bs: Remove function pointer set_tx_power_level_handler
  staging: rtl8723bs: Remove function pointer hal_dm_watchdog
  staging: rtl8723bs: Remove function pointer hal_dm_watchdog_in_lps
  staging: rtl8723bs: Remove function pointer
    SetBeaconRelatedRegistersHandler
  staging: rtl8723bs: Remove function pointer Add_RateATid
  staging: rtl8723bs: Remove function pointer run_thread
  staging: rtl8723bs: Remove function pointer cancel_thread
  staging: rtl8723bs: Remove function pointer read_bbreg
  staging: rtl8723bs: Remove function pointer write_bbreg
  staging: rtl8723bs: Remove function pointer read_rfreg
  staging: rtl8723bs: Remove function pointer write_rfreg
  staging: rtl8723bs: Remove function pointer EfusePowerSwitch
  staging: rtl8723bs: Remove function pointer ReadEFuse

 drivers/staging/rtl8723bs/core/rtw_efuse.c    |  4 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 47 +++++--------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 33 ++-----------
 drivers/staging/rtl8723bs/include/hal_intf.h  | 28 ++---------
 drivers/staging/rtl8723bs/include/rtw_mp.h    |  4 --
 5 files changed, 24 insertions(+), 92 deletions(-)

-- 
2.43.0


