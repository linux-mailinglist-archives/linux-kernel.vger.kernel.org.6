Return-Path: <linux-kernel+bounces-235073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F78B91CFA9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3977A1C20DED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96C433D2;
	Sat, 29 Jun 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICSTS4Ho"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400839FF3
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719703371; cv=none; b=IyeNtJTas/ZKCrXbYy8hMk06HvYEXf7v/cgu85wPVxjakYE2TWujIOiSPnoSuCl8DClmI/cbPHbGSZSmoONPooBGWzFGZErYdvYRRK4XmbkGK1Jm28VoCycDSuAqyGQ6VMJMxgRct+ExVx7/6tnlvDFN9UKXn/hqd3Sp9sJlTBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719703371; c=relaxed/simple;
	bh=y++zxykpK9NLkq0lGO2nsOHzis/UJOoVXpmq2Sl2oa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TBaVYAfjY9duQPbicaKtsSGHoLhqpXPdz/QQpo7vIs9z9Rw5f4JQpkiTCtEvhb2uNBVxrrf8dvHIr9IZ5PC+HqwW1HShoK4QrNxHb7mjozJn2jT1rKjfiGGlp0NoeOpxQpet6TxDp3OPUM8ToP/gFvNJezOBOHJLPrrnrRUQlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICSTS4Ho; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa3bdd91c1so13674965ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719703370; x=1720308170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=teb0UEafOOXEAKqbKfLgAdCqPG7X0B1dC0LcXMPnx48=;
        b=ICSTS4HorIti5RBmlMhwlXDuPgFbOrDKiZ0upBohTeJmYwXCWQLsb/0LmfaOjjvMZs
         mmm5HAPuxfT2688+16i+YSJzZ6ZgigklJwFAKrSJK5dryR7HVxwJNDAa/9PK/E06HaKD
         KjJ5CRNxxO7T5Wd+HSu1sRuCAEflY2+kKkaOByVfkAJaXSenzvNZyr+GnmxFugl0NPHu
         MQCYQSQrL+DUvotuPliAEqE7I6gCXj0n0isn6q9UsOIlebbd8QOrKS0w1yBjosHcFcFk
         F50CvYPgceB4uldFkK0Pidjmbbj1WBcWpwBFWg1XjsqezZWR9/SCxF76bc9SCBk00OkF
         Lu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719703370; x=1720308170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teb0UEafOOXEAKqbKfLgAdCqPG7X0B1dC0LcXMPnx48=;
        b=cdCjJNbifL0IYqPrxJz9NWK+9B2EMlDYjV5kV00ygEChEjbgqnWVs3WvB3RBi25hdv
         T9PaiFAlmOE0ItHuGqIOnLPah1GOMPRaX52qugSW29+bXwsMKRSUAZGBF0EldezLUHC8
         UgZTWOAny/M9HRiNxw+uO/lWRR3ugdIp5wmOWkh4Ul0gGRucoYcAsSB5w138sWDoNqDx
         Ds2omrbIKCR8LH9td4L447a8nIUkLrjT85Y0h09uE6zjB9se1XXoWWw1qpfCBdpz9rM7
         09vvUUhYzqGU1bFuy/MW2rxRuvBPPWXelybIgjyS71B0q+qyP7t1HKOcl4ptsW2og+AG
         2axg==
X-Gm-Message-State: AOJu0Yw7ha0MqUye1xDY83ii/AK7FaaCMwd7guZYrDz2IGFD8ABDzBLX
	hn+BWVqs3/S7bBuJH1VhRphNVIv8hZMF08mat/ojG2Zh5Ui2Rh83
X-Google-Smtp-Source: AGHT+IFjYofaGf9zLpZ2YOJRaS7HqlHNi+SYfRjo7DN7UqHI+6dj6sFc0nv+dGyVQbKKZD8NFoyK5w==
X-Received: by 2002:a17:902:ce82:b0:1f9:ae6d:5697 with SMTP id d9443c01a7336-1fadbca1584mr26805325ad.35.1719703368748;
        Sat, 29 Jun 2024 16:22:48 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f1asm37279085ad.48.2024.06.29.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 16:22:48 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm: zswap: fix zswap_never_enabled() for CONFIG_ZSWAP==N
Date: Sun, 30 Jun 2024 11:22:31 +1200
Message-Id: <20240629232231.42394-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

If CONFIG_ZSWAP is set to N, it means zswap cannot be enabled.
zswap_never_enabled() should return true.

Fixes: 0300e17d67c3 ("mm: zswap: add zswap_never_enabled()")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/zswap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index bf83ae5e285d..6cecb4a4f68b 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -68,7 +68,7 @@ static inline bool zswap_is_enabled(void)
 
 static inline bool zswap_never_enabled(void)
 {
-	return false;
+	return true;
 }
 
 #endif
-- 
2.34.1


