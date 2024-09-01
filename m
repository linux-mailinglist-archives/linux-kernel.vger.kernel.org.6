Return-Path: <linux-kernel+bounces-310193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA111967611
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4811C20DE1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5371607AA;
	Sun,  1 Sep 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1MbiZIE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0FF183CA6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725188820; cv=none; b=Qr6xJtUdyEttSTKMcyh0auLPNeC02VdumrW5IKSMOu+xUSDKbCJxVspVlfPoCB2UpRyGZFmftet2kvyf8JNbnELjBj6mol632AzKXaqV7X3/M+Ovavui7NJZtlAAKlzKRZeQTUVkgNdm+QqYDYzxCCr1+pK6PbGPzjH6G5q4Wnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725188820; c=relaxed/simple;
	bh=Ol2Ogp1vxUneIXMR+//2nqdCVShC973yDcYgLGzcCPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cotl/NRghy7JywE3Iweb52uAYN3IwljWcf4JJtb9CJ0OXmSZF1WSjwxdjszaqbFNYFwiBLU7fnKn8TjkOi7cMzwpiDs+pAtaa17iISVMFvfhVbOVIZqrgkRAb5HpzbXTHtL2MC8bws9V6Zz7xK/e6N7neCXU8QHmlU1AaQdxtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1MbiZIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2CDC4CEC9;
	Sun,  1 Sep 2024 11:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725188819;
	bh=Ol2Ogp1vxUneIXMR+//2nqdCVShC973yDcYgLGzcCPQ=;
	h=From:Date:Subject:To:Cc:From;
	b=C1MbiZIEMg8lN7I6qfY13sf1eG6/8ywkynTxk9WS/KH/0a6D1GsGIk8oTHvaKs4k2
	 uPI4h6fPKq+Wc7Xn64PPdNL9V1lGhnD9dVrh9tGpWdudoqgyLAhBbpvrqquuGcO+Re
	 JVFx2Pv6RA8PCOC05r67T798eAZS6tFgRyT7x2A1jNtdfo7qDgcGFonNsYJ13m8F9f
	 W2ChqWQyYNR8jD54hmM5PgLDiUECdo5ZRfcQFGnLDcfTIh1hyEM6AvuwWfAWFCwJzi
	 kCOrSUcB8GahNtSBQL1vyelGeduaT4EvcRr+XAlDUEtjbhaq+lGMxTiwwdAjuyGa1/
	 3rRpmsOnigM6Q==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 01 Sep 2024 12:06:14 +0100
Subject: [PATCH] regmap: kunit: Add coverage of spinlocked regmaps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240901-regmap-test-fast-io-v1-1-aad83a871bcc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKVK1GYC/x2MywqAIBAAf0X23EJp0ONXosNWa+0hDZUIpH9Pu
 gzMYSZD5CAcYVQZAt8SxbsiTaVgPcjtjLIVB13rtu5Ng4H3ky5MHBNaKhCPi7HD1vXEa6uhlFd
 gK89/neb3/QDT1hLtZQAAAA==
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ol2Ogp1vxUneIXMR+//2nqdCVShC973yDcYgLGzcCPQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm1ErRMkv2+svBUkfkZk3zEmFcVwPiJlKUrAwNV
 uo5fyReaCOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZtRK0QAKCRAk1otyXVSH
 0MQFB/4lTRNOB4/sQU2nnD2J1ZkVHejux/VHRAB1J5CGjyEaYY/8/1dDqhn4GL7dAawwafN/M1X
 FDG7aKdUfEYq0Kv7Lw6XmS5BHSSwbArQLKQkFoZbJJRfGFuD4WSOuyTdTILUA9pDlnmLDZm6H7K
 yhFbM42zaC6E2oc5GVoAu6pL42JwPlD74+gLY13AXrot8XvCiS92VwGaqjlVXWUB9sawXVvr/Tl
 3o/sStMQOd83Vkxe9mlr2fngCgsRIl5Ij7qLmulYONNSxXyh5PX9PRKuAX9eqq4DLJQqWruWOYR
 9J5C69hstm9Fe4jN6iQZY32N2GUSn+UJNGLydVW8xwH/1ta+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

By default regmap uses a mutex to protect the regmap but we also support
other kinds of locking, including spinlocks, which can have an impact
especially around allocations. Ensure that we are covering the spinlock
case by running tests configured using fast I/O, this causes the core to
use a spinlock instead of a mutex. Running every single test would be
redundant but cover most of them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index b80b447c87a2..4bf3f1e59ed7 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -22,6 +22,7 @@ struct regmap_test_param {
 	enum regmap_endian val_endian;
 
 	unsigned int from_reg;
+	bool fast_io;
 };
 
 static void get_changed_bytes(void *orig, void *new, size_t size)
@@ -80,41 +81,52 @@ static const char *regmap_endian_name(enum regmap_endian endian)
 
 static void param_to_desc(const struct regmap_test_param *param, char *desc)
 {
-	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s-%s @%#x",
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s-%s%s @%#x",
 		 regcache_type_name(param->cache),
 		 regmap_endian_name(param->val_endian),
+		 param->fast_io ? " fast I/O" : "",
 		 param->from_reg);
 }
 
 static const struct regmap_test_param regcache_types_list[] = {
 	{ .cache = REGCACHE_NONE },
+	{ .cache = REGCACHE_NONE, .fast_io = true },
 	{ .cache = REGCACHE_FLAT },
+	{ .cache = REGCACHE_FLAT, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE },
+	{ .cache = REGCACHE_RBTREE, .fast_io = true },
 	{ .cache = REGCACHE_MAPLE },
+	{ .cache = REGCACHE_MAPLE, .fast_io = true },
 };
 
 KUNIT_ARRAY_PARAM(regcache_types, regcache_types_list, param_to_desc);
 
 static const struct regmap_test_param real_cache_types_only_list[] = {
 	{ .cache = REGCACHE_FLAT },
+	{ .cache = REGCACHE_FLAT, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE },
+	{ .cache = REGCACHE_RBTREE, .fast_io = true },
 	{ .cache = REGCACHE_MAPLE },
+	{ .cache = REGCACHE_MAPLE, .fast_io = true },
 };
 
 KUNIT_ARRAY_PARAM(real_cache_types_only, real_cache_types_only_list, param_to_desc);
 
 static const struct regmap_test_param real_cache_types_list[] = {
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0 },
+	{ .cache = REGCACHE_FLAT,   .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2001 },
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2002 },
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2003 },
 	{ .cache = REGCACHE_FLAT,   .from_reg = 0x2004 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0 },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2001 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2002 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2003 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2004 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0 },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2001 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2002 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2003 },
@@ -125,11 +137,13 @@ KUNIT_ARRAY_PARAM(real_cache_types, real_cache_types_list, param_to_desc);
 
 static const struct regmap_test_param sparse_cache_types_list[] = {
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0 },
+	{ .cache = REGCACHE_RBTREE, .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2001 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2002 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2003 },
 	{ .cache = REGCACHE_RBTREE, .from_reg = 0x2004 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0 },
+	{ .cache = REGCACHE_MAPLE,  .from_reg = 0, .fast_io = true },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2001 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2002 },
 	{ .cache = REGCACHE_MAPLE,  .from_reg = 0x2003 },
@@ -151,6 +165,7 @@ static struct regmap *gen_regmap(struct kunit *test,
 	struct reg_default *defaults;
 
 	config->cache_type = param->cache;
+	config->fast_io = param->fast_io;
 
 	if (config->max_register == 0) {
 		config->max_register = param->from_reg;

---
base-commit: ae0acef3822ed8908e83cd24f337891e6be64eba
change-id: 20240831-regmap-test-fast-io-b3f9d78aec42

Best regards,
-- 
Mark Brown <broonie@kernel.org>


