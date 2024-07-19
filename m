Return-Path: <linux-kernel+bounces-257209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE2C9376B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BA01F216AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33483CA1;
	Fri, 19 Jul 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqUEIEKr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4404548F7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385636; cv=none; b=jEZEVRBs4kLPsmvcRPwu7QMprz5zArJrsq0qmk/UIe85FA/s/xIYezw/lVz6f+YtQJDptUEoSI6zCSl/QIspRl6knxhu05RaFg+rYvpKKwsKF04p9FBJt5OLlNVF7s4ONvMsCHAeYOH25xWgdfJT2BM2gUzV63V6H06oa/GVb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385636; c=relaxed/simple;
	bh=otxByGRbgGXdSpNWhBDtrzaTFR9ycy2O/8HXktzpNT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eVmf5PHUQvj0H02zrLO0zOOEid0b3XYc3bODe/tPXZ6i7CZAqPmBtZm1Z9WVCEstgI8Vx3D8hQVNWqCYKaPE4tZv4Qe8W+5s+jDiBHqXM/iy+0Ep6a7I8zHiVDS2e0SV2z9ea7ootUJmntJz2FQyQc/V0BVDnjACT6vSRBMeMtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqUEIEKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAF8C32782;
	Fri, 19 Jul 2024 10:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721385635;
	bh=otxByGRbgGXdSpNWhBDtrzaTFR9ycy2O/8HXktzpNT4=;
	h=From:To:Cc:Subject:Date:From;
	b=gqUEIEKrMOZCFW19LLfOjJHCoNWDEXfSQeea3GB39/clLHY5NwVj9A4+onFIYH7/B
	 pzj6xfwc3bs51mmyy+FJQb0ucRkVdt2OG8oK6cGTjJKRkt/KaCGxZiuOfy5vfjbsgl
	 qz+/Zvrj5D9Y5FxmSEUa4ZyX5nqhPHOPjHKYb5nRql1OuuqZAqEFlj7MnOSpDUdPKP
	 I5UbGAeL4giKIP2E/zduDmIR4Q7U8pYnx/QKfgCDNTBNEPDGhLUMRl9Z+HXFQLIPvr
	 HW5MZG+DG+26I9hMpgUsXQGzPuG04v2mJ7Ma+ed8HATCku/NfgSP9jd8lvabzfpRyQ
	 Z6FKFawPW3F/w==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Colin Ian King <colin.i.king@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: maple: work around gcc-14.1 false-positive warning
Date: Fri, 19 Jul 2024 12:40:24 +0200
Message-Id: <20240719104030.1382465-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With gcc-14.1, there is a false-postive -Wuninitialized warning in
regcache_maple_drop:

drivers/base/regmap/regcache-maple.c: In function 'regcache_maple_drop':
drivers/base/regmap/regcache-maple.c:113:23: error: 'lower_index' is used uninitialized [-Werror=uninitialized]
  113 |         unsigned long lower_index, lower_last;
      |                       ^~~~~~~~~~~
drivers/base/regmap/regcache-maple.c:113:36: error: 'lower_last' is used uninitialized [-Werror=uninitialized]
  113 |         unsigned long lower_index, lower_last;
      |                                    ^~~~~~~~~~

I've created a reduced test case to see if this needs to be reported
as a gcc, but it appears that the gcc-14.x branch already has a change
that turns this into a more sensible -Wmaybe-uninitialized warning, so
I ended up not reporting it so far.

The reduced test case also produces a warning for gcc-13 and gcc-12
but I don't see that with the version in the kernel.

Link: https://godbolt.org/z/oKbohKqd3
Link: https://lore.kernel.org/all/CAMuHMdWj=FLmkazPbYKPevDrcym2_HDb_U7Mb9YE9ovrP0jJfA@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm still not convinced that this is the best solution, but I had no
other ideas here.
---
 drivers/base/regmap/regcache-maple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index f0df2da6d522..2dea9d259c49 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -110,7 +110,8 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, min, max);
 	unsigned long *entry, *lower, *upper;
-	unsigned long lower_index, lower_last;
+	/* initialized to work around false-positive -Wuninitialized warning */
+	unsigned long lower_index = 0, lower_last = 0;
 	unsigned long upper_index, upper_last;
 	int ret = 0;
 
-- 
2.39.2


