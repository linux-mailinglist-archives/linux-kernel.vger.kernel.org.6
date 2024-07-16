Return-Path: <linux-kernel+bounces-254141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861DF932F71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10CEA1F23E20
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3D1A0725;
	Tue, 16 Jul 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/R2kCYZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FE1A01D5;
	Tue, 16 Jul 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152337; cv=none; b=RP2Ifog/7TZlZCYG0czb4YxTSELEIT92ouiNO/xedHSnviCA792GIuwK2uYSMd0FMf1idPoF7rpnAtT90QlYlBmKYgN0nLd6xLKkHqhFX5d7g3mo5D4z5CJtnxZYe9oJJfwNERrBDo7kII3iPr9tuc9rWZb38r7lQ/C80s1Dcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152337; c=relaxed/simple;
	bh=DfS+ZGQlpkyRoXAydI0Q0HXfxyiuVuX7x3ZtcbMPeEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NDMSSX3yRlB2H/r7H6L+d/QuBHIB706Fk3gVOec4OZaY2DkDimPf05/VzAWnCFwYEzleXXZaNA3O80tx0JX+Gv7jHFj1Q5wD5HHGJD6qraqIDNHJawnxhgxYWBhX2hkAvhCIbv3l9BGcojikzRQVcKRsTQElxvc4kCi37PhcLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/R2kCYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2DFC4AF13;
	Tue, 16 Jul 2024 17:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152337;
	bh=DfS+ZGQlpkyRoXAydI0Q0HXfxyiuVuX7x3ZtcbMPeEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/R2kCYZUjl48aS27/ayNifpOMy28BVb23DLwHZGfNdfaq7AeZA8cyrnV4G8yYsw3
	 TAGMYKmMZ7dmDy/plp2S3SGUnGgy4wHJl8SqIFm56el1SaFo4Wr467q9loG1UNQg/K
	 19GlQAztgI+OTXys1Tdgr9JrMUgk6L7HgkPsE/EouYsew7phd15oUFgYJ3Fh4E2jhz
	 Oufwfw0al99fPKmia5Lnk/q4cr40sR/vDzwHcUXxKOuVMVxVCZ0YIItJ5aqPK1LM7j
	 rygcOfngoiA7zmrZa4z921Gsc1RIiUzmT1Fs+PQNyuyEP+CXM7AMKc/TUQm4hFcTNX
	 MDJs/8Z/FPI4A==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 6.1.y 3/7] minmax: fix header inclusions
Date: Tue, 16 Jul 2024 10:52:01 -0700
Message-Id: <20240716175205.51280-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716175205.51280-1-sj@kernel.org>
References: <20240716175205.51280-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit f6e9d38f8eb00ac8b52e6d15f6aa9bcecacb081b upstream.

BUILD_BUG_ON*() macros are defined in build_bug.h.  Include it.  Replace
compiler_types.h by compiler.h, which provides the former, to have a
definition of the __UNIQUE_ID().

Link: https://lkml.kernel.org/r/20230912092355.79280-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit f6e9d38f8eb00ac8b52e6d15f6aa9bcecacb081b)
Signed-off-by: SeongJae Park <sj@kernel.org>
[Fix a conflict due to absence of compiler_types.h include]
---
 include/linux/minmax.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index abdeae409dad..e8e9642809e0 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MINMAX_H
 #define _LINUX_MINMAX_H
 
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/const.h>
 
 /*
-- 
2.39.2


