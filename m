Return-Path: <linux-kernel+bounces-446263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C609F21F2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DC188619A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB3DDC5;
	Sun, 15 Dec 2024 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="EMQNtViK"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13D881E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734231124; cv=none; b=EpVrdHsdg5y2/zn3nBmuiXWIPfTGkLLYUNt6wP9tZcOZMVqfs0bk5eKDK4qAB5R4VoHIJeEccD9f4jU2UIBRPOsmOVwzgEdDcpmYpYy1BD6ZbhaBGdW1ON6hF67oTGgg8KNli8OMToc/KxpSNdTJUppalj+JBnwP8wyy4PmdhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734231124; c=relaxed/simple;
	bh=cagvw0j4nmba+ZvIBeK5r5HJKKwZpyNHOaFgJAhLj8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAdesAsaLmW5wwGRvWzrrzvPcwipx9Cv5wYFJqSpvvr84nBcLZLzgMBHS1relc2CrdGWMcOZs0/hsKplrZz5Gocg/jm3ZjpSov2+a/QWi2intQff1l8Gk/qsX8L4wzHUKh5zhhTyRLUDmseGlBlcEdzsGH8tNEoyz6JxSVC84mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=EMQNtViK; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de [5.147.80.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7425F40600;
	Sun, 15 Dec 2024 02:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1734231110;
	bh=FMAWHGbpjb4e021ePimfo1s3sso0VwO9gTH5Qc7B/WM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=EMQNtViKAyQsrgz6ev6LBgt5LdzJFX+Znz3kYTpF9tTx/gb6eYUYKeROIWz/1Y96q
	 /7iSHfZFHpaPJx0494KAbp8Px/xCdkNWIUPmqxE81LMKTXWx6ryVbrW3a4CE+Q6Bz4
	 4tqgJWdQNqB+tle0wFJEsIf/mvS9M38syqQs3zELC8zrAi+8vniJ0fNtHX2Tww1/8l
	 0IktxwaEOumeapIHdZRfHt4Xe1Tz3aag/oBC616kUDcYT69kjCwuPVVnI1hqtORxhF
	 rWS9mVF4mxFkGYLKcwj5apc8S7qqh0euVM/fWUOCEoTAb0nWz6AfQP5Y5gxBejDVVG
	 yR96FAHWDZ6ZA==
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
Subject: [PATCH 1/2] checkpatch: allow special characters in spelling.txt
Date: Sun, 15 Dec 2024 03:51:03 +0100
Message-ID: <20241215025104.70096-2-heinrich.schuchardt@canonical.com>
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

Checkpatch.pl uses the misspelled words from spelling.txt both as keys of a
hash and as part of a regular expression. For usage in the regular
expression special characters like the plus sign need to be escaped.

Escape special characters in the list of misspelled words.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 744328d21eb8..572411aaa4be 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -978,7 +978,7 @@ if ($codespell) {
 	}
 }
 
-$misspellings = join("|", sort keys %spelling_fix) if keys %spelling_fix;
+$misspellings = join("|", map{quotemeta($_)} sort keys %spelling_fix) if keys %spelling_fix;
 
 sub read_words {
 	my ($wordsRef, $file) = @_;
-- 
2.45.2


