Return-Path: <linux-kernel+bounces-547876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B905A50E97
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A68E3AA209
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E02676FE;
	Wed,  5 Mar 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPCf65V6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F752676DC;
	Wed,  5 Mar 2025 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213664; cv=none; b=JjrjapNO4i7tDAmecXtVw/IOM9tYkkyHUsb/iZANkmAy/To4dEsZQgsdKFnVZcclDoICDD4795Rzt1YM8WX+e+Q4umWGvufBs+3Qj2gXhPZw+jU5wAT77pH4CZdai0YWE0YBG61xBGE+3lNNooO3rK9plH0HVJTOlZML/yrEj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213664; c=relaxed/simple;
	bh=omzDcLQxOt4b1eAtHmmakixx0La83wEbeQMY0qApQrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkWpBa1OCE6FBQV7ORP5XuWQKL+bJ18pFjKU5mo3nA0LzqWrGppVgk6NlvHqUGApfup1sujzjuate9vJ0HefspT/BMqpnDiwcfnOMIiWyIg6FuM075J3m+TFkBScVarR/39mt1gH10L6FyFOr+TpFOphUfj80gEhGzPGTTlbjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPCf65V6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9FEC4CEE9;
	Wed,  5 Mar 2025 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213664;
	bh=omzDcLQxOt4b1eAtHmmakixx0La83wEbeQMY0qApQrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPCf65V6a35HkE8QBy7nmsiyOHOU4SuTigF0B8sRNGJ4wLWSSKyjjfhQ/STTBPP0A
	 gXEwAFSr+JuwMNcFuEzucZLQipdOf4Lcuhw5EtFtOAjwHCDJYMQv1iN/38o484Kvrr
	 U9e+rdqtUJ02+Qq1s4OSqNENlq++fM6niYZrcCNij7yecPp0P3ZLAmAzkBODE1zhLy
	 5+QQNfYKWLEmji0XggkpOLCnF2aGMu4jjDknAeenNHsfXpqD+0uukb7d3CIwEZ2s3M
	 AV8WGF0r2XHOvDfw5U9NSQZI7EAR5ojT6hwLpqi6fNdQlf8oykeH+VPXxCa7uD6ev9
	 zOZ0T9WB7DCgw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon/sysfs-schemes: record filters of which layer should be added to the given filters directory
Date: Wed,  5 Mar 2025 14:27:30 -0800
Message-Id: <20250305222733.59089-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305222733.59089-1-sj@kernel.org>
References: <20250305222733.59089-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike their name and assumed purposes, {core,ops}_filters DAMOS sysfs
directories are allowing installing any type of filters.  As a first
step for preventing such wrong installments, add information about
filters that handled by what layer should the installed to the given
filters directory in the DAMOS sysfs internal data structures.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index e85feb329bd6..b9f035f4b00f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -309,8 +309,18 @@ static const struct kobj_type damon_sysfs_stats_ktype = {
  * filter directory
  */
 
+/*
+ * enum damos_sysfs_filter_handle_layer - Layers handling filters of a dir.
+ */
+enum damos_sysfs_filter_handle_layer {
+	DAMOS_SYSFS_FILTER_HANDLE_LAYER_CORE,
+	DAMOS_SYSFS_FILTER_HANDLE_LAYER_OPS,
+	DAMOS_SYSFS_FILTER_HANDLE_LAYER_BOTH,
+};
+
 struct damon_sysfs_scheme_filter {
 	struct kobject kobj;
+	enum damos_sysfs_filter_handle_layer handle_layer;
 	enum damos_filter_type type;
 	bool matching;
 	bool allow;
@@ -320,9 +330,15 @@ struct damon_sysfs_scheme_filter {
 	int target_idx;
 };
 
-static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
+static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(
+		enum damos_sysfs_filter_handle_layer layer)
 {
-	return kzalloc(sizeof(struct damon_sysfs_scheme_filter), GFP_KERNEL);
+	struct damon_sysfs_scheme_filter *filter;
+
+	filter = kzalloc(sizeof(struct damon_sysfs_scheme_filter), GFP_KERNEL);
+	if (filter)
+		filter->handle_layer = layer;
+	return filter;
 }
 
 /* Should match with enum damos_filter_type */
@@ -595,14 +611,20 @@ static const struct kobj_type damon_sysfs_scheme_filter_ktype = {
 
 struct damon_sysfs_scheme_filters {
 	struct kobject kobj;
+	enum damos_sysfs_filter_handle_layer handle_layer;
 	struct damon_sysfs_scheme_filter **filters_arr;
 	int nr;
 };
 
 static struct damon_sysfs_scheme_filters *
-damon_sysfs_scheme_filters_alloc(void)
+damon_sysfs_scheme_filters_alloc(enum damos_sysfs_filter_handle_layer layer)
 {
-	return kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
+	struct damon_sysfs_scheme_filters *filters;
+
+	filters = kzalloc(sizeof(struct damon_sysfs_scheme_filters), GFP_KERNEL);
+	if (filters)
+		filters->handle_layer = layer;
+	return filters;
 }
 
 static void damon_sysfs_scheme_filters_rm_dirs(
@@ -635,7 +657,8 @@ static int damon_sysfs_scheme_filters_add_dirs(
 	filters->filters_arr = filters_arr;
 
 	for (i = 0; i < nr_filters; i++) {
-		filter = damon_sysfs_scheme_filter_alloc();
+		filter = damon_sysfs_scheme_filter_alloc(
+				filters->handle_layer);
 		if (!filter) {
 			damon_sysfs_scheme_filters_rm_dirs(filters);
 			return -ENOMEM;
@@ -1607,11 +1630,11 @@ static int damon_sysfs_scheme_set_watermarks(struct damon_sysfs_scheme *scheme)
 }
 
 static int damon_sysfs_scheme_set_filters(struct damon_sysfs_scheme *scheme,
-		const char *name,
+		enum damos_sysfs_filter_handle_layer layer, const char *name,
 		struct damon_sysfs_scheme_filters **filters_ptr)
 {
 	struct damon_sysfs_scheme_filters *filters =
-		damon_sysfs_scheme_filters_alloc();
+		damon_sysfs_scheme_filters_alloc(layer);
 	int err;
 
 	if (!filters)
@@ -1630,15 +1653,18 @@ static int damos_sysfs_set_filter_dirs(struct damon_sysfs_scheme *scheme)
 {
 	int err;
 
-	err = damon_sysfs_scheme_set_filters(scheme, "filters",
+	err = damon_sysfs_scheme_set_filters(scheme,
+			DAMOS_SYSFS_FILTER_HANDLE_LAYER_BOTH, "filters",
 			&scheme->filters);
 	if (err)
 		return err;
-	err = damon_sysfs_scheme_set_filters(scheme, "core_filters",
+	err = damon_sysfs_scheme_set_filters(scheme,
+			DAMOS_SYSFS_FILTER_HANDLE_LAYER_CORE, "core_filters",
 			&scheme->core_filters);
 	if (err)
 		goto put_filters_out;
-	err = damon_sysfs_scheme_set_filters(scheme, "ops_filters",
+	err = damon_sysfs_scheme_set_filters(scheme,
+			DAMOS_SYSFS_FILTER_HANDLE_LAYER_OPS, "ops_filters",
 			&scheme->ops_filters);
 	if (err)
 		goto put_core_filters_out;
-- 
2.39.5

