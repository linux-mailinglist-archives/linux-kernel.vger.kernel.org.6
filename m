Return-Path: <linux-kernel+bounces-421752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A539D8F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA48169B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 00:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0D76FB0;
	Tue, 26 Nov 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU0nAuGH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0664440C;
	Tue, 26 Nov 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732580965; cv=none; b=eNuux7a/G3cBpndSsSKNxFMSy8H+THld6XKxdczVCHTLC82uoixFB0zyyH+TK4Qt+PzEkRX7ozNGfq2d5VMhCVP/MyoC3jKCFDqDrb4pnufv1+wyQatnfzbZoVJQQfAZd+8EZVKNd/EeJWhkP6BPQeKdAy1Yw/O3/7SyssHg4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732580965; c=relaxed/simple;
	bh=f6ufFFbST1iK9JOmRgVJyaZ4psK01QmjedArsoSNU7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FjZAdKa/aqdXOU6y0npXP7CBUS2ov6ISErgbBcA21K7Lpgqqk2t1nEjwHF9/pky5vBRHHV7EpMrbOjWexCcgJHTAaJn6tMYrfsLgRzgrh4GsEbBqWBj7yEFRo/LlO0uHZmHbguifKgzhkq/3rUToxWMW9SpPKYHEUNeJ9u8jscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU0nAuGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB77C4CECE;
	Tue, 26 Nov 2024 00:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732580964;
	bh=f6ufFFbST1iK9JOmRgVJyaZ4psK01QmjedArsoSNU7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=mU0nAuGHkTCe/pKN7RpZ06upTbIPXse6VXfFkrfkN3xqYGRE9k30Od1qgpQuT1Bp0
	 iKAKktDZto3xSIfEbN6B2WX3itJTqU+WDAbdyKU/6n8zyGTrHSRSi5L9wN/mUdTcKl
	 PZPT2Kf4K3rYEVMzk66XovJAkfZo641jc4dHHlALUPKnrn4c83TKJhsmw/7Eu3Z4OY
	 6OtpmlqSinDTKqyeEECp9vJwVoweuWrxJbM5iboF8IoSz0+H+gymy3V0ok50DepK9n
	 Ws0wbwLcddBXaTWRWwH0+3pU/hmzTmLGrZN1vfeGKeCKMfXeoeKYoY4HvPlhx5ADui
	 rfrj9bioGWgAQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [RFC PATCH] mm/damon: explain "effective quota" on kernel-doc comment
Date: Mon, 25 Nov 2024 16:29:21 -0800
Message-Id: <20241126002921.50035-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment for 'struct damos_quota' describes how "effective
quota" is calculated, but does not explain what it is.  Actually there
was an input[1] about it.  Add the explanation on the comment.

[1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043

Cc: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a67f2c4940e9..a01bfe2ff616 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -193,9 +193,13 @@ struct damos_quota_goal {
  * size quota is set, DAMON tries to apply the action only up to &sz bytes
  * within &reset_interval.
  *
- * Internally, the time quota is transformed to a size quota using estimated
- * throughput of the scheme's action.  DAMON then compares it against &sz and
- * uses smaller one as the effective quota.
+ * To convince the different types of quotas and goals, DAMON internally
+ * converts those into one single size quota called "effective quota".  DAMON
+ * internally uses it as only one real quota.  The convert is made as follows.
+ *
+ * The time quota is transformed to a size quota using estimated throughput of
+ * the scheme's action.  DAMON then compares it against &sz and uses smaller
+ * one as the effective quota.
  *
  * If @goals is not empt, DAMON calculates yet another size quota based on the
  * goals using its internal feedback loop algorithm, for every @reset_interval.
-- 
2.39.5


