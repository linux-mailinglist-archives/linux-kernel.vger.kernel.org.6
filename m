Return-Path: <linux-kernel+bounces-241948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AC69281A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F221C22761
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE013D28C;
	Fri,  5 Jul 2024 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK4XiiLR"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23B1C6A0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159530; cv=none; b=dKnbQhGbwqjrACiez7taiEs/PCYdUr9Ysi6rxTqvpMpRlzHE2kdIIVKxfqPa83Nhxcu8fWzPObPXqhQbc2Yg0DWbG++vInHgAC4v4wp+SBowmlbpDjvmzuuXeIP9cCxxUjXCMRqMvnPSS1PTSKn+tmy/qLj8lIXufK2V/hIR5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159530; c=relaxed/simple;
	bh=ocWTpp4xe20M3zX37/BRgdZMFUwjybjL7mOwaBB1GT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VMItN+jwmjV6OTsAALJf5N57iKxYyDgneemSBFD5PzF6wVBNeOxEkskx4RCsMbI4V7Slg3OVIvTgos72MAtXw4KMIX5eS4LV+fyh8gIxXw9wEE1wG9pTncnlLcgxldw3KA7urpN2wkUz9unRPaXV4+JYz4XriTrkgtxsH+Q9CD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK4XiiLR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58b966b4166so1532127a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720159527; x=1720764327; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CEGiUaZLdnHx0yMh5c5wWBK9rx7H+2K8obOdncrBZg8=;
        b=KK4XiiLRKU0TfJxn08yGQs8OuwwzJ71eLBdsYURBcI3RqcoOuzS7uxZ6ehzpaUZrIn
         EAn73YcE8IBl+6rJm6kQ5EwCzS1B+vzkJhgE34c+8XFLZ/8v9bbxBM2kkcfw78IxkDMo
         7Gl2twpyuqCRPgt5B1V1ngNoNAaAN6nmDE5/9suvdMdi5uRyHtkfhazCwi0xWVsAuafL
         5EbzW/YjpVoWb8fAy9U23KPg1skrALyEFU0My+pqi7U8yBaKFbpxs41n+t5hGgGJw8gR
         gUKteTqKd48mOdpdGbN1DHpsN94b4t1gMx1lK/CT0nwijbu2YaiEEP86XZG3u7j9+RF5
         Z4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159527; x=1720764327;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEGiUaZLdnHx0yMh5c5wWBK9rx7H+2K8obOdncrBZg8=;
        b=vW75gaBv0ffBcBXuMFFM4EgL62JgOiHngNFlo7s/ElE2Tu8VeXXhtv23vx0b6iB3+c
         H7LowwCd8ALFZ9gZyWA9NylwUDZAzTWiOzUJJ+BlHvfWPzSnTzZvPfsKbdCLbuVv0uHX
         VaTED/KC6eZ6dhKCxEdx1iyQYpMY6VwlkPZb6s+sMmFDHA9esOgp75/CxaGmmJld+y4v
         wMON4SHXQflUxGTsqn4PyKwvmvIUiTmJcKDBPyuVpfU1Se+O8J3jvdLujfjPhtPNZHW9
         3ArdbwJJ44QCQps3ugGVdadFnKAwkGd+YsKQ6RZpZsyvPrMdIuTkDZ6QM4Az5XJv79Ak
         hixw==
X-Forwarded-Encrypted: i=1; AJvYcCUVO3DE7f+fZsaTGdow8fmcVXfTnG4z4iQBrvfGa/ArtxVw/7eZUAX6x+PRSQzt9nxzbH30pqVR+47qZX22hGj6o61JO3OlDXAj3I29
X-Gm-Message-State: AOJu0YyXoMCIHbSFOjcbzORvYR0VdPN+l3kT7b9EMLfugYkIbzVipVb+
	JR17MZWYSbV/PjlxQ95GmwX/MRERS3txaI5TKcV9JEVu/Y8uM23tW3J/XGzw
X-Google-Smtp-Source: AGHT+IFUj5fhyTMHVVSInQGpgKofNVfDPkvLiND5Roh2i0SEAetOK+ekHpZEazZs0rz4hPCrfZivMg==
X-Received: by 2002:a05:6402:2792:b0:58d:45af:43dd with SMTP id 4fb4d7f45d1cf-58e5b4aed24mr2500973a12.36.1720159526937;
        Thu, 04 Jul 2024 23:05:26 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58f86619b5fsm521351a12.44.2024.07.04.23.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:05:26 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 05 Jul 2024 08:05:18 +0200
Subject: [PATCH] bus: sunxi-rsb: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-sunxi-rsb-bus-const-regmap_bus-v1-1-129094960ce9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB2Nh2YC/x2NwQqDMBAFf0X23IVolEJ/pUhJ0qfuoVF2tQjiv
 zf1OHOYOcigAqNHdZDiKyZzLlDfKkpTyCNY3oWpcU3r7q5j2/IurBY5bsZpzrayYvyE5fUXPgF
 t8PC1j1Qii2KQ/Ro8+/P8Aftv86VwAAAA
To: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720159525; l=958;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ocWTpp4xe20M3zX37/BRgdZMFUwjybjL7mOwaBB1GT8=;
 b=2SZJutRFCj2jCTpLniijzBGhIb2SG1TuD5ER+pGGwsq+QPEHY6uSupbgFn8D7Q/4lEkl7+1mg
 swVrpaiyqrqBLskhB+0vp0txpZpckD774ZSq1SboNiIzh/OR4VJIk/b
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`regmap_sunxi_rsb` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/bus/sunxi-rsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 1e29ba76615d..ac6c7e4900f4 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -457,7 +457,7 @@ static void regmap_sunxi_rsb_free_ctx(void *context)
 	kfree(ctx);
 }
 
-static struct regmap_bus regmap_sunxi_rsb = {
+static const struct regmap_bus regmap_sunxi_rsb = {
 	.reg_write = regmap_sunxi_rsb_reg_write,
 	.reg_read = regmap_sunxi_rsb_reg_read,
 	.free_context = regmap_sunxi_rsb_free_ctx,

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240705-sunxi-rsb-bus-const-regmap_bus-3cee4a3e313b

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


