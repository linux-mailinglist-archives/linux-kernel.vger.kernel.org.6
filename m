Return-Path: <linux-kernel+bounces-297865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC80E95BEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D992B230D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E31D0DC3;
	Thu, 22 Aug 2024 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPW2vXZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E731D04A8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354142; cv=none; b=V9syqXSaGnJI2A4ObX2rIe4heGQJzonzOivP/P9DfHz8UN+7RAVjb8LuYkng3TcTa9FfZh6W7ArOtzj4bwXsCjeedYP2T8iPZkytkx+v40Ky9MZOfJ+v5S5P+NjWAACME/JsnCOqILpNBjwu+HYb5H+kdhn5QWQ2aVsIGikzrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354142; c=relaxed/simple;
	bh=Gqu8IKz5ZDmSH1qLlC/PQjAsOLa/MoeoFtoKJgAk1OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SeICOzyP3EV0f7jLFqzB6WKGon6/cK09oR9/n/c4vp0MuAcaYLmFyV+WsJnlt0w7nfIaFVR5Q9yyCcmuZYyfUuIiJFd/R6wQ3+E5Q0PctIYH9FtvHbnwW2bE9jmKNSHiFqYMBHkqLEzTWvIY3k/3K3d3DJfOV3sNboEgIvh47FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPW2vXZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8F0C4AF0B;
	Thu, 22 Aug 2024 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354141;
	bh=Gqu8IKz5ZDmSH1qLlC/PQjAsOLa/MoeoFtoKJgAk1OU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kPW2vXZ6T4WX6SqcSVvQ87sShPfOSoI3xRmeRX74DLMs9qD3/ERN716bUlNvLJbLr
	 keuF0jio2tPcQXDawasMd4lbqUVeiojs2KnNGabvua3cBVUH89haltHTNbBamjRnms
	 rx6sCuG0bGgV2774klnzMYZ1H6LhEgI1RBvRxVUzR15XOmAn0/vnPRXabJCcyvWqwz
	 gPl1bix1AkeNi8qPG/yQIZxnw1rkRSPprIaXrklH8n+rLYbrSKWh0u00P1N4xtzZlN
	 symNkSXDWJ0bWyVo5H1AxcxrTKW7fInileEOZ9eVq8l8ZHlpyoD4fHirU08zLT6s2L
	 SCKB7rYyHT4Vg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 20:13:35 +0100
Subject: [PATCH 1/5] maple_tree: Allow external locks to be configured with
 their map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-b4-regmap-maple-nolock-v1-1-d5e6dbae3396@kernel.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Gqu8IKz5ZDmSH1qLlC/PQjAsOLa/MoeoFtoKJgAk1OU=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrTjfWFP1/QxPVx18BDrR8NLM3vXH4uPO2je4NJyyy9G1
 9nlG7tEJ6MRCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkXvK7J/ZbVd+TOs9tNrn
 NYuW9dq1MxNdTXtOagm7KpxbXsdbK3ju2pKreZsUWSVjitr/hWlPsQ+2XPS5iSuz3uBasud3c9l
 1D60lzV9/2mWzTETFxnnR1lU1Yt+s0iNjuPdE8G04WqI+4ZhmxW62HzLrZe/7RV2yYqy4V/Cg/K
 W9/88TGvy9mkd+qQvwRu7pKC1k6rtTva0iPdV7w1mHn5NOyk6NTlbpnRbgIX7FN1hQgo+TU+aqy
 calQrVf2ebdWyqr0nBrYQQXT8MWj2kG7ofXWXwpkOw4xec/R3PXPLZAhS38bDKBhQVPf9Qmsp7l
 01WYIO46PU9jp9rZ4lIWjxfOHQs6KhhV9VTuCMw6dRgA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the maple tree code allows external locks to be configured by
passing the lock itself. This is generally helpful and convenient but is
not ideal for situations like the regmap maple tree cache where we support
configurable locking at the regmap level and don't have the lock type when
we are configuring the maple tree. Add a helper that allows us to pass the
dep map directly to help with these situations. Since such code is already
peering at the lockdep internals enough to be looking at the map no stub
is provided.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/maple_tree.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a53ad4dabd7e..bdc6b133abdc 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -193,6 +193,9 @@ typedef struct lockdep_map *lockdep_map_p;
 #define mt_set_external_lock(mt, lock)					\
 	(mt)->ma_external_lock = &(lock)->dep_map
 
+#define mt_set_external_lock_dep_map(mt, dep_map)			\
+	(mt)->ma_external_lock = dep_map
+
 #define mt_on_stack(mt)			(mt).ma_external_lock = NULL
 #else
 typedef struct { /* nothing */ } lockdep_map_p;

-- 
2.39.2


