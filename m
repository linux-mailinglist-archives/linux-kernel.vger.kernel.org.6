Return-Path: <linux-kernel+bounces-446262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292879F21F1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5444D1660AB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E289BA20;
	Sun, 15 Dec 2024 02:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N7B9eI+f"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301D79F6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734231123; cv=none; b=Nhig78MHzpCZFwNEgXvx4gDXUfokx+qkPD8C3b87rGlOp36m+IBmU9543tgbNJdI6OTiPuRG70fBHYq6XeFZtCVkz8QlM2fyC2L4s3NKUiIuqqZRnF2SzIJB9einb9y+itWlpBwLUt5t+/69X0GD8NgP0L+lofTqBQXDx9FScXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734231123; c=relaxed/simple;
	bh=sBTLeAKAWriF5EK34NxzRKfwSlhDuQaEeAIsiG9SY2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvtOY5yTrNMNE9tf5wdsX2x3nbD+HIPYmvjqr/5fqC2vNpFZYNowmm8bXJGB6HjVFp/szQweGNv76NAloZixfSl9EgUyB5v62i+rMTxBeD5EPdaOcgIeXq35/0xNxUEaRZEWLXPJMSi4vmQ8TtYSw9MzmIcmAGykRV4TWEJx8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N7B9eI+f; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de [5.147.80.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F154F40601;
	Sun, 15 Dec 2024 02:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734231112;
	bh=aJa4CkhV5f4MrOLrg0+Cq6KqTzYPXq2200mWVK4cHAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=N7B9eI+fmn3AmlO6hxr5SYR2NIx7TAEUJH8Xp55zYxDtMzDNF5a5Cx2BTm9n2xzyQ
	 K/QvBOuNmdgSlMSt1LUd5W2KMQxuayM+DWqxJBgz/wL+GDix9Sf08JKP/HzuALSNWa
	 qHRJBfvR2XTWiiA8zvjfkpLBpfWr+4a/aQV+5d9VO9wDGPa9BdRymyGVs+xDJOdfz2
	 mtN9uto6TAlk1BLh5nxz9CeHaaUy1McgrjK6Wa96FtN9uRdHQXwp3ksZ6092E3Mt/v
	 Pbr3dzQpxj+KInw+ss2LBDNKw/KTktq8MpffB0d2Mtd+iy631GoRp53N+vOR4lKalr
	 pZwd9lpiESwdQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-kernel@vger.kernel.org,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] scripts/spelling.txt: add GPL-2.0+
Date: Sun, 15 Dec 2024 03:51:04 +0100
Message-ID: <20241215025104.70096-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
References: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct SPDX identifier for the 'GNU General Public License v2.0 or
later' is GPL-2.0-or-later.

Link: https://spdx.org/licenses/GPL-2.0-or-later.html
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/spelling.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 2decc50f5a6e..8cc59ee68928 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -772,6 +772,7 @@ genric||generic
 gerenal||general
 geting||getting
 globel||global
+gpl-2.0+||GPL-2.0-or-later
 grabing||grabbing
 grahical||graphical
 grahpical||graphical
-- 
2.45.2


