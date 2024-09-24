Return-Path: <linux-kernel+bounces-336956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E598432F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F092819D3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F016EC19;
	Tue, 24 Sep 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad5A8Jpw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8015C13F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172579; cv=none; b=WpqAqQa5E8TW8ytXHlalf0cNGc1uTCvtaMvp893tySOlHfIBj8DvzNcQN1Y0GIXUUM1/Y6ep0GP2KHfBLfbN8Gd02dSZnaXRC+f73qFCP9k3UNidFIbJxcdpAK8OXqbGlnixTEbXkUdN+lDoL4bU06IwMqEFnNeva9QhdJoCwps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172579; c=relaxed/simple;
	bh=21gzw8X4CfgdeTMPWUWRiLXO1PQAT7xyURRtjw0CXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rhNGpw5Ev5DAdeGs2rb/a7Ob4HLhi3pFVZhuhmkS91DS6+VfxadAlCN1aVpTpPb3Wjx7xBx6YXCcLi2kmgDkofzs0nH33rrStShMX3XJMT1B6VD/xI7lLTtbcyTmlA9gVNdswOYwSn5kLCjnT0HQr+nctRYboeVNnA2oGFThP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad5A8Jpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169F3C4CEC4;
	Tue, 24 Sep 2024 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727172578;
	bh=21gzw8X4CfgdeTMPWUWRiLXO1PQAT7xyURRtjw0CXsk=;
	h=From:Date:Subject:To:Cc:From;
	b=ad5A8JpwMOlXsTzMpSQYzQF3nwKrx9K16t168hIoJ/ay6gSPC54f3L/ZGjuG0vwgJ
	 UXM6tn5pcBYJ5kOyEC2h0TpPRsK3pstmuHSR1lU2tcToYm9kmLU4MbDb/0LWoG/Ilr
	 Vnu+2zdL+AeCxFsLK+xtwPyo2q38u7qSxR+cD2kHe/VYNr/W65fMUDlcR4E578CxxQ
	 a0s45ei+Pa9H/x26GmYT6AjoIX+gVQ9TNzX9ujtf1SASocBgqnZE4LrLYJsYcJixbt
	 kUFrzklY3NiSiBDa+/Air3Xj9KbpZd2fnHps6hlqCoeX39k/eRLMRicmjiyvmnZD4b
	 yiS8wT+ugmKiQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 24 Sep 2024 12:08:53 +0200
Subject: [PATCH] regmap: Specifically test writing 0 as a value to sparse
 caches
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-regcache-zero-value-v1-1-8a1224214b52@kernel.org>
X-B4-Tracking: v=1; b=H4sIALSP8mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyNj3aLU9OTE5IxU3arUonzdssSc0lTdFEtTE0uTFMM0c4NUJaDOgqL
 UtMwKsKnRsbW1AL42dHhlAAAA
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929; i=broonie@kernel.org;
 h=from:subject:message-id; bh=21gzw8X4CfgdeTMPWUWRiLXO1PQAT7xyURRtjw0CXsk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm8o/fHEvVkpm5WZQDQj4nTSqv4PTw7Nb1gOKl/
 1nhLXATvtWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvKP3wAKCRAk1otyXVSH
 0KuCB/98RxXLWz+GnN1k9GbxjIBneyamrTa+/9Wy9bXFIYg+y5ic/tHVYoncBFALl9B4TM0EZ7F
 C8aXJ5E1NwzHSGpO0AJ4eUhnNMA7b4tQX+yYvLb5O9rL2XXBGSK/BqZrFBouJU3YlA1VGeSy086
 Ptphn/Fq3wEWGcruL8pcQIRk76fAU4FdAsWTS1vXMATV/n1MA/MCQ9ZNKlNkb4iMqA0QZwf5duJ
 sPf5zYzLcbSWtWUVmlvM2Mwk+UVwMyek6lsRcZhBUK2hD7tRX/fpNpzqFzeGx+oNiHpzbDGwUI1
 usq8W3DKL3+195X9E9ErtLz9ckTcQJ5aXN0Ido5SKE9RD41Q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since 0 can look a lot like a NULL pointer when used in a cache some clever
data structures might potentially introduce bugs specific to handling it.
Add some explicit testing of storing 0 as a value in a sparse cache, at the
minute there are no issues and this will stop any appearing in the future.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index d790c7df5cac..64df047d9d53 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -1486,6 +1486,48 @@ static void cache_present(struct kunit *test)
 		KUNIT_ASSERT_TRUE(test, regcache_reg_cached(map, param->from_reg + i));
 }
 
+static void cache_write_zero(struct kunit *test)
+{
+	const struct regmap_test_param *param = test->param_value;
+	struct regmap *map;
+	struct regmap_config config;
+	struct regmap_ram_data *data;
+	unsigned int val;
+	int i;
+
+	config = test_regmap_config;
+
+	map = gen_regmap(test, &config, &data);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
+	if (IS_ERR(map))
+		return;
+
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		data->read[param->from_reg + i] = false;
+
+	/* No defaults so no registers cached. */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_ASSERT_FALSE(test, regcache_reg_cached(map, param->from_reg + i));
+
+	/* We didn't trigger any reads */
+	for (i = 0; i < BLOCK_TEST_SIZE; i++)
+		KUNIT_ASSERT_FALSE(test, data->read[param->from_reg + i]);
+
+	/* Write a zero value */
+	KUNIT_EXPECT_EQ(test, 0, regmap_write(map, 1, 0));
+
+	/* Read that zero value back */
+	KUNIT_EXPECT_EQ(test, 0, regmap_read(map, 1, &val));
+	KUNIT_EXPECT_EQ(test, 0, val);
+
+	/* From the cache? */
+	KUNIT_ASSERT_TRUE(test, regcache_reg_cached(map, 1));
+
+	/* Try to throw it away */
+	KUNIT_EXPECT_EQ(test, 0, regcache_drop_region(map, 1, 1));
+	KUNIT_ASSERT_FALSE(test, regcache_reg_cached(map, 1));
+}
+
 /* Check that caching the window register works with sync */
 static void cache_range_window_reg(struct kunit *test)
 {
@@ -1999,6 +2041,7 @@ static struct kunit_case regmap_test_cases[] = {
 	KUNIT_CASE_PARAM(cache_drop_all_and_sync_no_defaults, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_drop_all_and_sync_has_defaults, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_present, sparse_cache_types_gen_params),
+	KUNIT_CASE_PARAM(cache_write_zero, sparse_cache_types_gen_params),
 	KUNIT_CASE_PARAM(cache_range_window_reg, real_cache_types_only_gen_params),
 
 	KUNIT_CASE_PARAM(raw_read_defaults_single, raw_test_types_gen_params),

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240923-regcache-zero-value-d95494d1f70e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


