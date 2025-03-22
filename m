Return-Path: <linux-kernel+bounces-572378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C31FFA6C9B0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C567ACD61
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328D81FAC5F;
	Sat, 22 Mar 2025 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNYAJqDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A41F891F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640108; cv=none; b=POunclYTSqcY1ch0SfUUhxIM2yXED2bZizuPcctTGe2g4RSYd1EZn5yxxsfifuNNaZbUHapmIRawCNHxWnJAHa7/2U/7dEvGEIt/GzsKQ5v1yVvqFsql/wJWoUl27wAqvycZSjK3SSIaq6xiTsyCrHZDR21Yqqilot3YKTBoRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640108; c=relaxed/simple;
	bh=aTXRkE0XydaINgQyfs8slD4zaVmOP6d03DD2R/YidBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KpblbRD7YGRifEu5v+ZOEybBbI5edEbXZl7A4oI2Pz+/OesYDjsdmqBYSqL9psxaKsSzpxYnARKQVXz2yGNNkJ/3AHmuHSuolf55ykYNG7aQLnDb58e0aOj3UdvebnTUq5FZCOowv32oe24Cn6TgWIC154BWUF9KvzXIl17n7ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNYAJqDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F29F9C4CEED;
	Sat, 22 Mar 2025 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640108;
	bh=aTXRkE0XydaINgQyfs8slD4zaVmOP6d03DD2R/YidBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eNYAJqDuLl2hihiBMvXZv4XT0dBnp5Pv0vakB/rZau63lv6kAu8cg27VOrxs1JH7h
	 CTDhZdPiM5wQ2LXV5cwcLrwLfI/hzBUkFMB/8UVRNyN8iNONMB86aC2vsrgekjc6W0
	 1yB3DgrDtj0HHRfFbGT9lwiF1DFWHKGUZrQ0CFJFV5P0mHBHa9tG59teRwdfVw34v0
	 NZ0Mk6HZhmWIEaPik8EbR/FpNuURaGWUl5xxGdti7I8cBTyIPwiQtJefArZwEWsrjp
	 t8GVelUZpORe0AbDP5ewsMi/u2NpXcLStSroO0hiH3tjeWMahHczfSPsMU1g1rg3Vr
	 gYOkWTAA7w/jg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B91C3600B;
	Sat, 22 Mar 2025 10:41:47 +0000 (UTC)
From: Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Date: Sat, 22 Mar 2025 19:39:38 +0900
Subject: [PATCH 3/3] test_bits: add tests for __GENMASK() and
 __GENMASK_ULL()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-consolidate-genmask-v1-3-54bfd36c5643@wanadoo.fr>
References: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
In-Reply-To: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
To: Yury Norov <yury.norov@gmail.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>, 
 David Laight <David.Laight@ACULAB.COM>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=lw0j5DDbt4xHaeCFRpUyWkzpSYATbilmvUEdK3pbE0k=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDOn3Jj//niLufKnD3jTC6+n72Eu/sp3jVnzS4C22PT/zU
 +SzKbdXd5SyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZiI91dGhquce67s/1Dt4Som
 2sKexbNwZ4nZwgOVMjz6jEdmm+yuPsfI0Hf4ssP59z3mJ9r3ra3NPvpc/8wnRbvTZS3Hf+Va+gl
 8YQcA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
X-Endpoint-Received: by B4 Relay for mailhol.vincent@wanadoo.fr/default
 with auth_id=291
X-Original-From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reply-To: mailhol.vincent@wanadoo.fr

From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

The definitions of GENMASK() and GENMASK_ULL() do not depend any more
on __GENMASK() and __GENMASK_ULL(). Duplicate the existing unit tests
so that __GENMASK{,ULL}() are still covered.

Because __GENMASK() and __GENMASK_ULL() do use GENMASK_INPUT_CHECK(),
drop the TEST_GENMASK_FAILURES negative tests.

It would be good to have a small assembly test case for GENMASK*() in
case somebody decides to unify both in the future. However, I lack
expertise in assembly to do so. Instead add a FIXME message to
highlight the absence of the asm unit test.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
This patch previously belonged to this series:

  bits: Fixed-type GENMASK_U*() and BIT_U*()
  Link: https://lore.kernel.org/r/20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr

Below changelog also contains the history from the previous series.

Changelog:

  v6 (previous series) -> v1 (new series):

    - Add a message in the commit description to explain why the
      negative tests are dropped.

    - Add Lucas's Reviewed-by tag.

  v5 -> v6:

    - Add a FIXME message to highlight the absence of the asm
      GENMASK*() unit tests.

  v4 -> v5:

    - No changes.

  v3 -> v4:

    - New patch.
---
 lib/test_bits.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 47325b41515fde2c3ed434ed6f4094925c98886b..ab88e50d2edfa2b011f07d50460ac8ea6ff99923 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -26,6 +26,23 @@ static_assert(assert_type(u16, GENMASK_U16(15, 0)) == U16_MAX);
 static_assert(assert_type(u32, GENMASK_U32(31, 0)) == U32_MAX);
 static_assert(assert_type(u64, GENMASK_U64(63, 0)) == U64_MAX);
 
+/* FIXME: add a test case written in asm for GENMASK() and GENMASK_ULL() */
+
+static void __genmask_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ul, __GENMASK(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ul, __GENMASK(1, 0));
+	KUNIT_EXPECT_EQ(test, 6ul, __GENMASK(2, 1));
+	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, __GENMASK(31, 0));
+}
+
+static void __genmask_ull_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ull, __GENMASK_ULL(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ull, __GENMASK_ULL(1, 0));
+	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, __GENMASK_ULL(39, 21));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, __GENMASK_ULL(63, 0));
+}
 
 static void genmask_test(struct kunit *test)
 {
@@ -123,6 +140,8 @@ static void genmask_input_check_test(struct kunit *test)
 
 
 static struct kunit_case bits_test_cases[] = {
+	KUNIT_CASE(__genmask_test),
+	KUNIT_CASE(__genmask_ull_test),
 	KUNIT_CASE(genmask_test),
 	KUNIT_CASE(genmask_ull_test),
 	KUNIT_CASE(genmask_u128_test),

-- 
2.48.1



