Return-Path: <linux-kernel+bounces-213323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A29073B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AF828C407
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCE1448DE;
	Thu, 13 Jun 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDScTybu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12635144D11
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285388; cv=none; b=uIVzbrpq3qTisvFHe9DyXaLNZ+KyH4xrn2aW69VTTjdiELEbhm5TfNRE40nhVe+xYwZEcxWcUbZJykqat0TwZbnXVJ/uIuyygXuK8MW2pdtIBwSH4PUIIfyPlrLsASemIIEe0nyQeZH39MpA6SXjJ9Msnff+Vl+oeroMdx2m46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285388; c=relaxed/simple;
	bh=9YjZ0mNxtiI0w3TDnF6tuEkwNoMXfJVq5u/FUSPFA1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qZWEfrk7OifXEFxMo2VE/sN0vJpgMyM8WETbIT+nVzr1M5LYsRNlj/xqGwuPqDhSTmtWHJsIU2t9ox9MZNOyRHE/WRQJcA+1Cfdvd/1MsGsNwDmCGKkV6peE5nGFzH43aKrOYBZQ42yoM1XE/OPWSd1PpMwtzbiDsAL4ikdA4M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDScTybu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-422df2a81f2so7000645e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718285385; x=1718890185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aj73urKvgW9wZChdKp/grUo5S7WR7EBtNMzzOYz9T24=;
        b=mDScTybunNOD0tFDls83WMhzu7AdNBqKg7jqHv/XDAi+c/GZTMcWU7F7LhY9c7d0jU
         Ga6xIg8bYBtdGeklzB8DChca4g7EdX/oDkIZW8onjjTU6x4wDV/B92xhRvRbP/7X4roM
         5amtZHwwd5gUPjW0BAu/+dQgI5G3EBpL54wMsZq9muplQCz4m+mfXaZo2KbQvvxBrX6G
         9SVdnP6UYbFqudsu0Yx+0RSA98+qEIWuaVw1guB2ZzFLvOfFU6thn9kSRr+4cCfGOaUY
         erPQo+W5QmfEnQKqJnnbilF3fWdEPBIbiW3BGcv2dNXNU4MwZVtoK7fzCENVl2MsREE3
         KJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285385; x=1718890185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aj73urKvgW9wZChdKp/grUo5S7WR7EBtNMzzOYz9T24=;
        b=ltxvV/+2XL9ZWyuhpV5h0TSpvpVhwYBOcG+yGZsDO8KzMmWTMcxmtwshHsUWDlKtUg
         /onTRgnc4yELSkn7DF2a/sjEn9JaoI0IhgDQk3Huy3IkiXDlfneWM1/P2E5XYuGYBqZm
         n6N8tfab7cZe/+Ia8cHWZGnAAtjRIL7+sL3XZbTY8y7TzYVsuUlnOfNnYguK1KGVwsJM
         dOiqWn2NRM0r0vjkjsYyc8WWNMjVzCXC1t2eS6qj2m9mbZd1MK+VAxilJ688vyt5i5jt
         mjpKk2rZsBV68Vlykjudf/e5tkJxm/2CNQf25+QX7uvlKC9pjNsKYZLpAZF+UMhZtAkM
         0H5g==
X-Forwarded-Encrypted: i=1; AJvYcCXmVzeHIPXThkHv9xOkh2tNb18XwsS4KpKrrC/QwWULPvuKolA5xghYGYE7zh35ad//q5X//sBp4IbMlf7wsb2wb6o4bHtW1pgWKPaj
X-Gm-Message-State: AOJu0Ywqxa0/BUVXLHMR2LaEEAtI3G9ItSarqystcGfka+Jdjjm5Jv8i
	n2nsFnLjf3BVMn26/pUrLyRrAko0VJHzusiQauiFKb3euPtuXbXK
X-Google-Smtp-Source: AGHT+IGN3ewMVPxG6hTEa9MKx/jd9wdA02rG/0ezuJmL2oalAxDGMCY9OKmvZ+w1oQsMikOP8XdAZA==
X-Received: by 2002:a05:600c:1c83:b0:422:1609:a7db with SMTP id 5b1f17b1804b1-422861ae833mr42397645e9.8.1718285385168;
        Thu, 13 Jun 2024 06:29:45 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422d0be1424sm29981455e9.12.2024.06.13.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:29:44 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH v3] staging: vt6656: Remove line from TODO
Date: Thu, 13 Jun 2024 14:28:53 +0100
Message-Id: <20240613132853.2249-1-engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove checkpatch.pl line from TODO as no valid checkpatch recommendations
still present.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
v3: Bump version number + add version history changes.
v2: Revert the parentheses removal changes.
---
 drivers/staging/vt6656/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
index e154b2f3b247..876cdccb6948 100644
--- a/drivers/staging/vt6656/TODO
+++ b/drivers/staging/vt6656/TODO
@@ -11,7 +11,6 @@ TODO:
 - switch to use LIB80211
 - switch to use MAC80211
 - use kernel coding style
-- checkpatch.pl fixes
 - sparse fixes
 - integrate with drivers/net/wireless
 
-- 
2.39.2


