Return-Path: <linux-kernel+bounces-385282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C109B3506
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 791D8B21A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069891DE3B5;
	Mon, 28 Oct 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzWM7W5D"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62112F585
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129797; cv=none; b=T9+AiKQD4MTCiCov3iTBd8hhQ1pGXrAQNPKGZ1v4b8uebMtuWJ8usgPrsuec4okBN0umIVTWnhIC5mv87n7ot47EhxZjPu2cQNtadCWT7tdQQ48T2lyhWu068LO6Wf0KH4DxsU1cNXzin16faP2mp5e93lRD8spM4nKSRAQY/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129797; c=relaxed/simple;
	bh=j5Uo4fPx8PEHKjthtCPpv0qJhhzjgRMPRhbxvwt+ZvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=coYdWvmUOGi/7rJ453OC3lGrWfBf42dXcRbTtnz0YthzOctzDtVEWaOlhiLI7sKPcSev+BQ7JKrUfnC46fjbAAPJrc1X6YDM66SiRbHt/NQ5lsGygsOx0oJVQKK3R8ZmfvNWGYnMpLtxn6pwgYELP8DBNr3J3nd6m/HsuusqEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YzWM7W5D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c803787abso35037415ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730129795; x=1730734595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEf/COfTFGyP+xKqeIQFY/C7vxGTzZ4wSn2NFe/j+IM=;
        b=YzWM7W5DejySyf3Srx0w9LtWYqOsUcOVSAKZ7pawQpb1ZA4g0yyDLqIwegectSUfsy
         qhIV3tkZVZuuG2u3HTAqQ3LTYuvwN9jlPtWv2URoSvqWWYNy53Bmuiiml1TgAkBeBUmf
         ZYI/B5o/ss0iKA818CJ8CWK0Kdcb0Dpw6gci0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730129795; x=1730734595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEf/COfTFGyP+xKqeIQFY/C7vxGTzZ4wSn2NFe/j+IM=;
        b=IQHQQ9+QMKGljBHHUNmEJtvatJXVusLH10nRBbGFCGbzkTzmq+0qoYugD4O+sxtbtY
         VbeN9I8WKz4OBGmWBzfMLO+/FAmSO+pMkQ+qFx+XVg/ZUDw85p4oCmYs1wp57Sc/Q654
         ZtEjO6dVwGAHlL2rCWzr0wkdePWQO92Mw0GlLhORZKLWd160zV1g5SZU762xu2MBroGo
         hmgFpH3FAuW055gigd059FuONjBbficnotKPs6uuVTcQJ622XpRpHe1OwBCm2/8cU/qZ
         yRha2wp9r1+rtp50OCUvrhM74Oi1MZOhzZtSgH596mXaPMW8jfIjG91fCaFaYr9qRuaJ
         F1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwbvqXzUvFLukjt+8q4UwxUZvSo4X34A/h5fbBZ0DD5G/RLTCOewuANN9kcq7FvWKf9qF0dwZNf/sxB6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4R8hEIVbXTWGPXh5AU+XeYc824cw10UZsNL0TZ+k7/biQFsT
	VsYOrPXMIWUe8FNUr5UV6fRpg81GRAfK4GbqNnPkbey1mlZhk8oH93/Mejclrg==
X-Google-Smtp-Source: AGHT+IFP006d1m5l/vO9+b3JvcahduuvR/e3NWwLX7zuw1Wcv7iCYDzfpokbHON1Y42zJ7TmtnaEyQ==
X-Received: by 2002:a17:903:2447:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-210e862104bmr3983655ad.17.1730129794783;
        Mon, 28 Oct 2024 08:36:34 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:f1f8:97e1:9c5b:d66f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4a230sm52148315ad.31.2024.10.28.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:36:34 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 0/2] zram: IDLE flag handling fixes
Date: Tue, 29 Oct 2024 00:36:13 +0900
Message-ID: <20241028153629.1479791-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zram can wrongly preserve ZRAM_IDLE flag on its entries
which can result in premature post-processing (writeback
and recompression) of such entries.

v1->v2:
-- fixed typos and comments styles
-- added Fixes tags

Sergey Senozhatsky (2):
  zram: clear IDLE flag after recompression
  zram: clear IDLE flag in mark_idle()

 drivers/block/zram/zram_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

--
2.47.0.163.g1226f6d8fa-goog


