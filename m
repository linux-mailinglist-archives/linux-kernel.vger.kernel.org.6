Return-Path: <linux-kernel+bounces-572119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8C6A6C6B2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605A31B61B58
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B46522A;
	Sat, 22 Mar 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDR+mbG9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295729A9
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 00:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742603568; cv=none; b=XpT0FPf1H8A9mDOAZwUoXxo2+uYG68tzcwxsidRG5TsVONwGmXrHqe2AlDLlGreDGypMwDeZz5gGcoCnq6tlYkt2FEcOG8MpCqlEB6x9sWYxSZHRNb5wT/xYQfxK0NWJA1rW+oMn7U6/A06yxy781U4kCujB8MPIWbJQWwqfHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742603568; c=relaxed/simple;
	bh=KpilHOOJo67Z4VWOQXgm4x9QaziC64Nge4Tp+ZLbApY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GsDZoIAb0VZVq61U7BHl7oSTEhaeZ7D/jm0ie6BEYt2s+N25F6uv+Z63+TZqqd/aKki5E7nFzpcjyaONdaiSIto0xjXXd1VpYwJhCz5Y3c82bgIIS7Hi9N5QSDZ5CxwtI5tpfiVFZHdiZt2rhDkxuHfuQ7LA+0kw2X77cMJ+/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDR+mbG9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso295708166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742603565; x=1743208365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUyR3Oe6iYVQ9/r3ijgRJfklg/wMi4nHhN2lq9dus2Q=;
        b=mDR+mbG9CXP8Zq+9NGEukt3OaRi5cCvjjOqt0TOmPOQq/tYWVOESDhRhXacYYOIMt/
         e9q+gzKaMdSzXIHX9d17GbmzR32EJl392vVrH4b/+Kvcbhc1bXhp46V5Zor+5hR9OmJ4
         3sKY+1bR3XQR2G/nELThSCHavv7Ul6u7vm8fqehxaZK+yBpGuSh4VrWzE2nSQkNI9XgG
         PNe3+FSsxKiYoLrvg2YSH7AP0VdnykZtZ97gYrY6q/9/TOfaBgt7GYvUBdnC+3I5JTP5
         r7MLG7tRSaKa3PLXMKbyj1UuP3RtxNrkZZq81C/TF8JnJM131UQUnqre+mGi5J2RXttO
         q5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742603565; x=1743208365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUyR3Oe6iYVQ9/r3ijgRJfklg/wMi4nHhN2lq9dus2Q=;
        b=sAhsFMxLjWgxl0jjWdEl/EI7SkoAmXh3VOlRedditEhsq+HyGzk9PN5uwvI0H9a37F
         3qVhIwlrSDOFZlgAYnwP6i201vmO2yPkxR6MpBSySrLxWHWaSQN+mt+B3C6fQfRWmSy2
         H2DdGhXNpdB9gvrcTc2W4SKwy6W4CSu+toiet81d5hgak/FRlElLS2vC5HCa7qmiI/wM
         WxakYdQWxeTLSe5k5Xamf4UEotAsbE/4HWoycouRatHIFys3qETY/tGuJtXLh2E7LbSC
         2CgIA8m1DPn3IEqDDEvzo4+Q541tOSgTdTkadYjPVNcMZ2BBulpsRsxOeetIEXUUEuAp
         aYKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAuHFUlI4UPTs1TzY7Mmd8jTGB2sY6jAaglMS+mNoSFTO+fNOCac8jKAUTEO1PzUz/9796M2F6k7lM1Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGUYY91Br9XxXDyOSyA2zkRDu8P0PvkB3eiakw6ZaNXtYWXC9
	AG9cJw5x/5BkLoM9txeHAEztMOk1Yt3LppjvwxwMBbNmku9q75vO
X-Gm-Gg: ASbGnctPCTTJgeNlEfIAn8t7w1+1BOXdaPtzy2XsT2kg5IJjG1Aio2XkVUs7tN+HQh/
	vS8w8UN36qoDF0ojPIBVzvyvtzwYLe12WzIV1ZKUo6pac7nCP40fxedz8tWW6iyubtV15sinFJO
	PhTUgO6jxYGChFdWPB1T96HCyoYJ2gC12EdlWmM18UL7qvBHzzW/0BBFrMVboqU/4b7Z8Vyj4Hv
	XM7F/0RnWwK09QzVITxOfFrYKaN87Wrtq5uFP9+uCLZSwXNOb52OgZJ1+akb1aNSBDuajwgjvS9
	4eVitdFSIUBfyS96e82rltChLs2WzZsKS/lBpkGjR3j9prtV+tQEpw==
X-Google-Smtp-Source: AGHT+IHIkZl1HZ3bargOGIgRuUMDY14pB1ok3aEaaqULlgerkBIsFuLlNFDNNZ7Ob1Cav44bb3EPlg==
X-Received: by 2002:a17:907:3e8b:b0:ac3:d0e4:3a9e with SMTP id a640c23a62f3a-ac3f251f1fbmr502782566b.43.1742603564527;
        Fri, 21 Mar 2025 17:32:44 -0700 (PDT)
Received: from localhost.localdomain ([41.90.66.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbdfcc7sm236983166b.146.2025.03.21.17.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:32:43 -0700 (PDT)
From: nancyenos <nicymimz@gmail.com>
To: "outreachy @ lists . linux . dev Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: nancyenos <nicymimz@gmail.com>
Subject: [PATCH] staging: octeon: Fix unused macro Argument 'x'
Date: Fri, 21 Mar 2025 17:32:18 -0700
Message-Id: <20250322003218.14134-1-nicymimz@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

warning found by checkpath.pl

Signed-off-by: nancyenos <nicymimz@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 44cced319c11..0155f3c41657 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -8,8 +8,8 @@
 #define OCTEON_IRQ_WORKQ0 0
 #define OCTEON_IRQ_RML 0
 #define OCTEON_IRQ_TIMER1 0
-#define OCTEON_IS_MODEL(x) 0
-#define octeon_has_feature(x)	0
+#define OCTEON_IS_MODEL(x) ((void)(x), 0)
+#define octeon_has_feature(x) ((void)(x), 0)
 #define octeon_get_clock_rate()	0
 
 #define CVMX_SYNCIOBDMA		do { } while (0)
-- 
2.25.1


