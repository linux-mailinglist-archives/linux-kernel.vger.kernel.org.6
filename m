Return-Path: <linux-kernel+bounces-248620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658192DFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302CA1C21811
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11E78C67;
	Thu, 11 Jul 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8Pim8Kk"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B6383B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720677238; cv=none; b=kM7iaz/p5zAyavWi3FTXq3r9pwwwuJYvH6dFJqHw1KXhffTDfZokS//5Q1LIzPFl7RDtzOr3srauRQPCak19uk2RHlJgyVPuui2AWchlEABSgAmUpjMSXEjpeUhqMhTAlQ7029Ctt7uDDDhlWzpp4N/6Mi9RmiHF/G4RLEa8WQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720677238; c=relaxed/simple;
	bh=+XY/vsBHwplKmG5CNaCfFL3IDz/Eqy6hwJ6HjipRsfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgqVhK4HBz3dzyMjUTWuT1q5GyBbYo7c9SXuIargkm78gaJTjdL9PyFixp3fL6iEFJEZVtCUXEvMpi/8nRBgvCUoNwqj0J3yrUNAXcr6QKOUogLhUavvQCjopzrx73gamdIgRwGU1VqQlJOsIWxepzjavHcao9MgyFb2EJkh7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8Pim8Kk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb8781ef1bso3780375ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720677236; x=1721282036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=leJwGVlihX42X68VHG3jC4tNZba04QL6d0fVzNIGhuE=;
        b=f8Pim8KkvwcN0lTxSgG25Knmxg05s2xW14F2F7XZUbPBegpr9MSucayvcVZ81NgUz8
         n+u6m2Y8qpwe6rDZOwHKee7ZqCy8UUrIDEqXQl8jBYVkOwLtfmtKrf2ctqgP9VUBPWxl
         u9GGKjS9hKdTuBQ402b2iKTdbt12ytD9EizyYTxISZU1FH5fGMe2CkDr+I4MDDQYbOVm
         DovHTC8On2ina2Ygsa23PoUZKS3LF8VP+SdAlbXvTVJnWe3w3jRJu+ImdMqnS9Jlu9Bk
         s2zmfaQ0hhWXc5X6n/DtDNfCZshWrggcTBL3gdzk8puI6b9GAUX1HrCEW+KeeokeOaeu
         bChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720677236; x=1721282036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leJwGVlihX42X68VHG3jC4tNZba04QL6d0fVzNIGhuE=;
        b=I89jrQ2o2mERCYjnlxWWhs42AvF8wm6TxThufvIFXPqYP/zAwMfy2+HKEr8UIJATCT
         NIr5PpBka0sdyH5Ob2WTeKoCf4Zrvmk9dDgs8/FJ+HH6QSXvjtFYP2csiop6gJB7DZ3Y
         cg/qFIRHYHeJLHTiL+XGyGnWPbIjPy7EEn/NxaAuyCVKWefjyNrTdsXCVT0VeDc3TUc7
         dxQUOV+PAllucpP+6oIuWzDhuYjStA2cQMu/G2ORl4jWtNpipNR77nEs/VU2qXSDb8uH
         BQZxA06WWP1CopdfuZ79mJXoRLJMQ+2z6DJE1WzXSTz15FFB0M0J3w2Bj/8rwWI2AxxN
         eeAg==
X-Forwarded-Encrypted: i=1; AJvYcCWUQljCdDCDtrX/00L6YR9SVdw0LtwKjwWXlYmEZt1vK44ejmghk5qkGPT6N2VYYDhm4eeDII/ebPPprz+dyG//9eumxiVL2lLyzVAb
X-Gm-Message-State: AOJu0Yy6gk4V1c/ZHnRnVH6spwSAKAoMGT6TBPNIsHoEiCP/iBgtV2Sb
	62aB9z60keOi+xukf54olMZMmep+5BUp5Owhm9jt3nJbF50wpWxnYhgpiA==
X-Google-Smtp-Source: AGHT+IHYXHUQ9Bx+gE7+JcU15WwfQ4dZG8rEOsC76EyyuSTq0dpgSDGNu1Sdt1fmmjGa7E9C34Zrkw==
X-Received: by 2002:a17:90a:7e0e:b0:2c9:7e9c:9637 with SMTP id 98e67ed59e1d1-2ca35c2a6dcmr5915977a91.13.1720677235580;
        Wed, 10 Jul 2024 22:53:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e6a252sm4757037a91.14.2024.07.10.22.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 22:53:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] regmap: kunit: Add test cases for regmap_multi_reg_(read,write}()
Date: Wed, 10 Jul 2024 22:53:52 -0700
Message-Id: <20240711055352.3411807-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for regmap_multi_reg_read() and regmap_multi_reg_write().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch applies on top of the patch introducing support for
regmap_multi_reg_read().

 drivers/base/regmap/regmap-kunit.c | 73 ++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index be32cd4e84da..eb8f0c001db1 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -295,6 +295,77 @@ static void bulk_read(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
 }
 
+static void multi_write(struct kunit *test)
+{
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	struct reg_sequence sequence[BLOCK_TEST_SIZE];
+	unsigned int val[BLOCK_TEST_SIZE], rval[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/*
+	 * Data written via the multi API can be read back with single
+	 * reads.
+	 */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
+		sequence[i].reg = i;
+		sequence[i].def = val[i];
+		sequence[i].delay_us = 0;
+	}
+	KUNIT_EXPECT_EQ(test, 0,
+			regmap_multi_reg_write(map, sequence, BLOCK_TEST_SIZE));
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, 0, regmap_read(map, i, &rval[i]));
+
+	KUNIT_EXPECT_MEMEQ(test, val, rval, sizeof(val));
+
+	/* If using a cache the cache satisfied the read */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
+}
+
+static void multi_read(struct kunit *test)
+{
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int regs[BLOCK_TEST_SIZE];
+	unsigned int val[BLOCK_TEST_SIZE], rval[BLOCK_TEST_SIZE];
+	int i;
+
+	config = test_regmap_config;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	get_random_bytes(&val, sizeof(val));
+
+	/* Data written as single writes can be read via the multi API */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
+		regs[i] = i;
+		KUNIT_EXPECT_EQ(test, 0, regmap_write(map, i, val[i]));
+	}
+	KUNIT_EXPECT_EQ(test, 0,
+			regmap_multi_reg_read(map, regs, rval, BLOCK_TEST_SIZE));
+	KUNIT_EXPECT_MEMEQ(test, val, rval, sizeof(val));
+
+	/* If using a cache the cache satisfied the read */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, config.cache_type == REGCACHE_NONE, data->read[i]);
+}
+
 static void read_bypassed(struct kunit *test)
 {
 	const struct regmap_test_param *param = test->param_value;
@@ -1887,6 +1958,8 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(read_bypassed_volatile, real_cache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_write, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(bulk_read, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(multi_write, regcache_types_gen_params),
+	KUNIT_CASE_PARAM(multi_read, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(write_readonly, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(read_writeonly, regcache_types_gen_params),
 	KUNIT_CASE_PARAM(reg_defaults, regcache_types_gen_params),
-- 
2.39.2


