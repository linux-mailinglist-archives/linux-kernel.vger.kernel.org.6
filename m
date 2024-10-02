Return-Path: <linux-kernel+bounces-348017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16C998E18F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAB6284C2C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F881D151B;
	Wed,  2 Oct 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwbHe7AU"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7A1C9B91;
	Wed,  2 Oct 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889783; cv=none; b=dejdgHjPoxSmhbpLFuUFuA7rSxE4/9GqI5cagd9kN1aSqn5KnwdzgdIaz2dvLX9geS5FP37/Ned5kGxDdeu7FnQBa/8iFf3TYNqKEJh8LbcxL2La4sAd3nhqImW3Lg0hqEXAzsve56krJV1yQoboAf3nAogEyJ4JRBiBog3iIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889783; c=relaxed/simple;
	bh=bkAQNVWdL7EltIgNXeU2wim48SVOzGi5QGtZVsmY1NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oha3YguGbqyAuZaWZqhk+rV43GjqOkVnVygXfQ4amPqP3Vd6xAwAxhc36TS6tdi5/2CMe1ZqpDbsIoMrHHEEbYB7h5N3PuKO2Ji1hLhm7tFmvFk2b1sHfGo3qPyqQZXJt/K/hU/NyIYUnD4N3jcspYxwZEdUk5w76tIVSMn2CpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwbHe7AU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so1134414466b.0;
        Wed, 02 Oct 2024 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727889779; x=1728494579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrtYZnJmhnzVc3g3gqJpSVt6lMuSvSPEflszJlzR0nM=;
        b=cwbHe7AUajy6c8zHg7Yu/zcrOOIV1u+qTKlLylh/APv9Y/vukYSU5CaMGgjTZJLS/c
         oXD2ZUsE/5K9+ZIvaxYFZ/+OUDykdi+zYr5eBjdN8E9B0DwqaXB9pO5+uxitYh8216ey
         RYccnMZ7KkJMxY5GW5+he9VC52rnhUW39O4pvwPP7LAgqMhDMRcqsFf+ePJCZ2BBwyM3
         xGXFkU+tV0oOCB5j8our6FI7kIHLkirzeML13Lfof1sobNZpXtGiHlHBNrfKaa6dgaYC
         T5hU7FKC92nLati5qGtUlXORMLbCoWBS/Rhdrwr3/mT3lY7cdRcAURQ3pJC3QSN/tGna
         DdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727889779; x=1728494579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrtYZnJmhnzVc3g3gqJpSVt6lMuSvSPEflszJlzR0nM=;
        b=XJB5AMLTKQ9ePeSdxv9bfTWy+vG94sQxw1J/D3eqN00nOtlF8lXu8xcmwfdBBp/7Kw
         uS0XbILFAfv/9Ql1n51Mg4yMA7avmM/1h1RKx/e5SPydd/4J9zQ6KaqlcrFYaTA9DZnP
         oiNqqVZ7EqbWdMIHYePqY9rl36CgaO/TrpDOosGenuFh8hXUm6CBD5/z1Kd2i6UgyBS/
         Wj6dd/ViVwJRdCF9Wx7vMG9SR4AlzLi1w9Z8D9LLDayj1oyPxvc4bWK6up/xO60tovrL
         eNKfXyxXGLzKN6iiqH0nQq1HTqZlsqiRJ73ULpjgkjbd4Z4rGQhYB9EKtyldSsbkH0hI
         7wfg==
X-Forwarded-Encrypted: i=1; AJvYcCVn0rQAf3wiLigtMPHwOoIxLL5wgCyT6mBbtEAMMlGiTDBI+DMzctZgU1GrlU4xpu4q6l8o+5exu1/qiu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Q72Olvuv/tvCajvdmvjuNB+xjXhNnMzewba0dKuCp9knRrfH
	Euf+GiXYtdpm5iNpWZG0l99q+dojqWbTdGeeyqMl9OKHQhYpNMb/
X-Google-Smtp-Source: AGHT+IFGrsopjTclFGJVXmRNx7rFlw56ClSxMQyHigziZsbEMOUUTrVwOrOTfgup+dPCSfeklGxdgQ==
X-Received: by 2002:a17:907:1c24:b0:a8d:51a7:d5ec with SMTP id a640c23a62f3a-a98f821ca1emr383865366b.13.1727889779427;
        Wed, 02 Oct 2024 10:22:59 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c58fbsm889697266b.56.2024.10.02.10.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 10:22:58 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: cfi_cmdset_0002: remove redundant assignment to variable ret
Date: Wed,  2 Oct 2024 18:22:58 +0100
Message-Id: <20241002172258.958113-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable ret is being assigned a value that is never read, the following
goto statement jumps to a statement that assigns ret a return from the
call to function do_write_oneword_once. The assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 9f2223d3e8e1..7c91429a670b 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -1775,18 +1775,16 @@ static int __xipram do_write_oneword_retry(struct map_info *map,
  retry:
 	ret = do_write_oneword_once(map, chip, adr, datum, mode, cfi);
 	if (ret) {
 		/* reset on all failures. */
 		map_write(map, CMD(0xF0), chip->start);
 		/* FIXME - should have reset delay before continuing */
 
-		if (++retry_cnt <= MAX_RETRIES) {
-			ret = 0;
+		if (++retry_cnt <= MAX_RETRIES)
 			goto retry;
-		}
 	}
 	xip_enable(map, chip, adr);
 
 	return ret;
 }
 
 static int __xipram do_write_oneword(struct map_info *map, struct flchip *chip,
-- 
2.39.5


