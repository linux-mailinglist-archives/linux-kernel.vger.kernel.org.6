Return-Path: <linux-kernel+bounces-440304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5FD9EBB85
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0708188418D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB26230270;
	Tue, 10 Dec 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COAFYnz2"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DB22FAFD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864902; cv=none; b=lgl0TmBtkwIFUDppv2C9rG8d2ZBBOCYykrcJaFTI8JUoMBM8XzuDk3b+1CvY12FyyHu37nVt7fdD+CriqObzvqZcVWB4yEJAGVmfyC+b0xL3XjxONF1UQiCqWwDzbR9VN3fP+UrUXKuBGkNiGXZye7k77azanJP7lEDZdQ3eWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864902; c=relaxed/simple;
	bh=+2Xqrpvz1YenH2keEsjBCW3bT3euCCI/Gd2YI9cj05E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHq5U1nmClvxn+33E5nMqQ667WDr9Ik9IkElv1Xn+R1ZU9HHdtEqg/qeI2b4P/M9tnieHAOooen7fmuBj/r2p2yxasS0IMkdXuUhb85nMy/RJ+bRTRRylpWdD4XQjcJqYnASOMwuwoSNRK7FuMb8ZM93N9yJrMIcAjp+OASdb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COAFYnz2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so2524030a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864900; x=1734469700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wme4X18VN8xA7KAuqfQ7sWF9XXzuE8s+l4Pv8ZaGRFo=;
        b=COAFYnz21znz3yRB1O3vecJwPioD56JX6jacsDCKijiNwD7vgXK96LQ+EN+LWF261r
         UTCX6HdaVjXk+zkMWLYNwDDRsPQC6fbqj3SUr9fxSuNrxTyfn4GzZJGJ8URTVTegp4uI
         WzqkBB7p78ixAYXF0ckVtRL3QYl7IYOfrFaMEnI/UwZfeALs0JCazf/d9o6tcodDoEXr
         Hbe1jEo/a8ztF9NvUjo73KUDp3qskS7WP/kyz5KOb+ONkiSoIpOB2GGIdKNJOi+cqVeZ
         1p0wesQbj4rDhaJXTqMi8g9WeR/no25aZxE4HoB6wHChx+r2+nCnXE0wzV6/ib09ZRNY
         ohnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864900; x=1734469700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wme4X18VN8xA7KAuqfQ7sWF9XXzuE8s+l4Pv8ZaGRFo=;
        b=qy0bhhv4WSRRdUg4eCjdkV3pNP4g44mdojwdv3ovgkR3vZErmNW5gSwubJlNaBbbTD
         AdZKwgKQeoGax+mqOA9tyiODWOqUDkROOFvOcrfSVevxdLYGi7iawCXn8ALDc0DGGkUE
         1KTicCEMQuh/PwWDt5tDz1Frh4+Ok0d1nkBouvDtbHsYgJjo710V4a/SCywI5GkH/P1O
         3VHcU8v1qgM4+d+0IHTS+K4IqgBQ1Rd6VhuvyiJSZULyg/UItCp2a5ANm/v79jJLjTqw
         fcbavzagIGj15CyylFqfeiIdL77m4VOAvlZnvdPXcYRjqEE4TIEQgWwBUzrHHO/rLFLc
         Eicg==
X-Forwarded-Encrypted: i=1; AJvYcCXZf7hxxaeLN3+VFstECMu5CdvF5sbAt701E9XLvSO/w7LbBh3GFZ0CAUFi89A5rQO+JTtIkOM7fvDM7dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1rNU/jRMKuLdPL5cpY0f/FRLSWihOC8bbOk4YmrVk43CS3CY
	I6XLluWShLGnswbpIMNI0B4ko2ArsGke1HMZHvHYp74YrQANACcv
X-Gm-Gg: ASbGncs8q3fJ3IxWlBQ1dEwuHSiovZxBOvzvcLOHpZNvHvrSwaJGxRHKPyfrxTT+9NB
	rdsBA3j7qIsZlv0d2MWrxoAlvNQHymCFPzNJKSbHXVzjbbhDVrEq/RYjYzZT3f1kHu/ohty3sIb
	TaCnAQg4L+e2RbOYq7IRcmOjTxQeEemfqVcbvurst6nIES8oG20ZiEXBT+PsS9zc+/RNkaQL1wN
	17Ac/5Em3Yt8xzXmFJ0x7ZeKUEJzJ4Fl1s9oIMDXgLwBVt0g0WMjRHFou8CuzwNINVUQQA19MsN
	4Q==
X-Google-Smtp-Source: AGHT+IHkUtC3WQHDqA2c6GfGiPYF/ugEdICoxhxajdJe5+hEK0O3IpMAU7nos51NQXFN4kipl+ZZaw==
X-Received: by 2002:a17:90b:3b49:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2f127fea904mr727992a91.20.1733864899475;
        Tue, 10 Dec 2024 13:08:19 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700979fsm13385731a91.18.2024.12.10.13.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 13:08:19 -0800 (PST)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] staging: rtl8723bs: remove code depending on cflag
Date: Tue, 10 Dec 2024 17:48:17 -0300
Message-ID: <20241210210741.17101-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split previous v3 version into a series, making easier to review this changes.
The proposal is to remove the code isolated with DBG_RX_SIGNAL_DISPLAY_RAW_DATA and
all the related code since it was not compiling and there is no information about it's usage.

Third patch depends on the second one due the enum removal.
I think now is more cleaner.
Tks again and regards.
---
Changelog
v3: https://lore.kernel.org/linux-staging/20241206230110.11893-1-rodrigo.gobbi.7@gmail.com/
v2: https://lore.kernel.org/lkml/20241125225308.8702-1-rodrigo.gobbi.7@gmail.com/t/#mf22f30a9c689bd793988d7e7a58c0b119206116c
v1: https://lore.kernel.org/linux-staging/2024112500-authentic-primarily-b5da@gregkh/T/#mea4fba3775a1015f345dfe322854c55db0cddf43
---
Rodrigo Gobbi (3):
  staging: rtl8723bs: delete DBG_RX_SIGNAL_DISPLAY_RAW_DATA ifdef code
  staging: rtl8723bs: delete HAL_DEF_DBG_RX_INFO_DUMP enum
  staging: rtl8723bs: remove HAL_DEF_DBG_RX_INFO_DUMP caller

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  1 -
 drivers/staging/rtl8723bs/hal/hal_com.c       | 55 -------------------
 .../staging/rtl8723bs/hal/rtl8723b_rxdesc.c   |  4 --
 drivers/staging/rtl8723bs/include/hal_com.h   |  5 --
 drivers/staging/rtl8723bs/include/hal_intf.h  |  1 -
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 18 ------
 6 files changed, 84 deletions(-)

-- 
2.47.0


