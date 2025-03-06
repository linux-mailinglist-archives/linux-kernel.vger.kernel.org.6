Return-Path: <linux-kernel+bounces-549554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E7BA553CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CF8189B258
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75876270EC6;
	Thu,  6 Mar 2025 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/nQTPBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCEE2702B8;
	Thu,  6 Mar 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283963; cv=none; b=pKrJZ3bgQCyhVsECLt3VUDySan+n2PSZkWsozmVAj0H/iqEJ6TY2wbCRDHuP+BYQWzWBuxUx+HFERXaBcUQINfIZdG4jl37K/QRfVOVGcrYH1Hil6QIDVaD2x9kTDJuzj7okOALz/tQcFlnj5sPlMW851AtN/VDAoCVmoxNMvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283963; c=relaxed/simple;
	bh=MsBfeedR0E0avwOTjpu2VsFxt43snXdrtNBJJKsBtYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUfmnqPwWhcsrdbzQzRk720/6RI+Ql8UhHjdPvMk1ROTw2ET06ufMoYtttI9B1+6/sGtNCohhNwoDPSGpNpiYyRzVZEqqSjrovXAYF9b+oUsRSaQK/LWzwMNpdqJGodIAWwFZ5lP6MMLPijR6L8isnpRJoAnnzbUy9HkkRbJh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/nQTPBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1167BC4CEEA;
	Thu,  6 Mar 2025 17:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283963;
	bh=MsBfeedR0E0avwOTjpu2VsFxt43snXdrtNBJJKsBtYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/nQTPBzQrtpc5jfIx22kSnzs/KBPP9QCYN85wNLoqhwXrsVCXcSEy5U+RE50RNnl
	 W7dqDVpn1T1x5/GZwFQTa0Uew+C/LSV/h/l5T07mMca38oJUdAJJYEQuq7HXQxrcKJ
	 gypqc4h2FpWf0bqO7keCsYhEEP7IuJBBQIejEhxuZiq7v9EjFPGK2Gp3n5TAQsn4E6
	 ZSQVQCW+INhCa0N1HUhw2mMqzA2wiXsYqGCM3e2yYvLKhXMZ7Sc1tFMQUYW2Wmzf9P
	 LS/b7ym8umSgYcZRIpoy6mswvy0yiAv/3qfwagcc/JgcaMpFQW0YnSzblrJF7pVLVO
	 t18FzFkNOb65w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/13] mm/damon: remove damon_callback->private
Date: Thu,  6 Mar 2025 09:59:04 -0800
Message-Id: <20250306175908.66300-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field was added to let users keep their personal data to use inside
of the callbacks.  However, no one is actively using that now.  Remove
it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index eed008b64a23..dab4bb0fe39d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -609,12 +609,10 @@ struct damon_operations {
  * @after_aggregation:	Called after each aggregation.
  * @before_damos_apply:	Called before applying DAMOS action.
  * @before_terminate:	Called before terminating the monitoring.
- * @private:		User private data.
  *
  * The monitoring thread (&damon_ctx.kdamond) calls @before_start and
  * @before_terminate just before starting and finishing the monitoring,
- * respectively.  Therefore, those are good places for installing and cleaning
- * @private.
+ * respectively.
  *
  * The monitoring thread calls @after_wmarks_check after each DAMON-based
  * operation schemes' watermarks check.  If users need to make changes to the
@@ -630,8 +628,6 @@ struct damon_operations {
  * If any callback returns non-zero, monitoring stops.
  */
 struct damon_callback {
-	void *private;
-
 	int (*before_start)(struct damon_ctx *context);
 	int (*after_wmarks_check)(struct damon_ctx *context);
 	int (*after_sampling)(struct damon_ctx *context);
-- 
2.39.5

