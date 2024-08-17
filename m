Return-Path: <linux-kernel+bounces-290719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A5F9557D2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D551F21E3C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC2614D452;
	Sat, 17 Aug 2024 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUL1G8wN"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F014D433
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898289; cv=none; b=Yx0pW3kfTX0D4ihF1PHUpHtiPvwRpC2XPP9HXUlqJGa4LJ1JjBBDAsFdZyFtD6hxi1Zd8x5qAv9q6Nyh11mfcezv/xr+b8AJb+pE+yFbolO0+tOf8j9Abt0ExH2XcaBrgZfYcVy2QhnjfcP6WIz3E0XfFGE4/uKgEhkDIi9mc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898289; c=relaxed/simple;
	bh=0wWL/IoKNLNgZCYplzIeP/dR/xb2IxqxppoSIK6MOqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gX4rtzH8P7Q7xUbDgrbpdLyJIDftqnwlN3hNZR8djCUJ7EBJriAfiY62D82RyKDviqp1GKRwIK4Md4iuRAQlA2OXmOCVtUWiwTWVsvsjpvj28hJ0j340yF0bgKXlW/Kh4htHEDp9jYHfERM82wZQOGUGVdDV/nR/X+UUx7L41tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUL1G8wN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3718706cf8aso1694504f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723898286; x=1724503086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbZmF9tOucLancvvkfZPaX47E5zKJzvRx4MlcTZ1+9I=;
        b=HUL1G8wNZSWwYGNKfqWLXvo0xUNWVf9a6ULIY/57TFdZFi5Oa3qO1G2Z7kckkemNZx
         ktRZIEgJnkPJuwvxOrBI6RhS5yztRVKJg/R4r5lKR+5pTTSFCkOyKEe+DbgIUpfRPrBm
         tZey1iEtOCG3Vpj+nkbcsGrkgu9LiE1i0aLZFcMs1ZfeSEislqPkAuwTY8rZzLSZNJgz
         1pCWWgQhXcmQiPzROxbF0I7TaCDY4etWRmVeSSr0Bzd6/84Ro7vF/+nwvU3mT89lhpu+
         BBjzR+Y6k93fqwHvHSbCGNsSML4VvaTxCYi36OJDi6bPkFLKEptXedgCYKUX9Oc0w1m2
         idYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723898286; x=1724503086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbZmF9tOucLancvvkfZPaX47E5zKJzvRx4MlcTZ1+9I=;
        b=Ki9Q/OQyKxJ09nOdZENyF0w387wo99QjwgDQ1wg5p/+98HXKpzS6qKSaMK58fVlrdm
         UhiVP+LThEyXMlAvNmUfbO/Ip0JxxVHPOysLLtXuOeXvnAkuC0gaLGw0oaIp+g4v9cQr
         ViFXazQ3/43JHLcHVbXeGV0/yePheufZXmOV9V1Ao2LQ42C6xqJck/gym29tr2X3KKAf
         nv0t6k6Ncwcw98e/XMRf2E1OB/J+kUG0PykyaOR25JBM742lE+uUzIoFgoWtm9aWzUTs
         tyPHkNuppt+nRwXmoq470Ce+rcq3mWOHt0OzCN3YvgHG0El2ObAot/jyHUGUA0GF4Cba
         f3zg==
X-Gm-Message-State: AOJu0Yzok3P6inue3naxGoSvNhuDrt5BmUltmq4PKntubnZf5rxTb7v/
	vw0P0Aa0/zGjPJLdpxdkrKkQazBhNhMgIkDN7OYq7CRumYEP11rR
X-Google-Smtp-Source: AGHT+IGK544d35dZ7nJ9p88TgfEC+/D0NCs0IaJprQDCIC4UoZ9JkQo+jVI1FypDAfOu1eZt7fBesA==
X-Received: by 2002:adf:f285:0:b0:371:888d:7aaa with SMTP id ffacd0b85a97d-371946b1ae9mr3259001f8f.49.1723898285837;
        Sat, 17 Aug 2024 05:38:05 -0700 (PDT)
Received: from f.. (cst-prg-76-86.cust.vodafone.cz. [46.135.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897034sm5822436f8f.67.2024.08.17.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 05:38:05 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] ratelimit: convert flags to int to save 8 bytes in size
Date: Sat, 17 Aug 2024 14:37:54 +0200
Message-ID: <20240817123754.240924-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only bit 1 is used, making an unsigned long a total overkill.

This brings it from 64 to 32 bytes, which in turn shrinks user_struct
from 136 to 128 bytes. Since the latter is allocated with hwalign, this
means the total usage goes down from 192 to 128 bytes per object.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

./scripts/get_maintainer.pl --git was most unhelpful showing nothing

I have no idea who to prod about it, I think it is pretty trivial not
needing any discussion.

Andrew Morton pulled in some of the changes to the file, so that's my
primary recipient.

 include/linux/ratelimit_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
index 002266693e50..765232ce0b5e 100644
--- a/include/linux/ratelimit_types.h
+++ b/include/linux/ratelimit_types.h
@@ -19,8 +19,8 @@ struct ratelimit_state {
 	int		burst;
 	int		printed;
 	int		missed;
+	unsigned int	flags;
 	unsigned long	begin;
-	unsigned long	flags;
 };
 
 #define RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, flags_init) { \
-- 
2.43.0


