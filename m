Return-Path: <linux-kernel+bounces-214025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B968907E16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098E61F22BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163C914A4E5;
	Thu, 13 Jun 2024 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo6cC97W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6714374A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313865; cv=none; b=Yy9ueLJ6ZZ6VbSiZaPVSn0Fw+534tyDG+mNl2grmKWCwGH4dh8FtRwZPoQlFKcPZ9VI6eHhTmO+spyisg7iwM001H8gX9zhlCfNlxLh5rmPUIhZ18UIxmHFhmhgVcmt0kGZ6mqqvz9uOtiLvdn/alfLMUC4tdak2ZUNVOBeZt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313865; c=relaxed/simple;
	bh=6mmkibTeyuR8KMR9AE3vV6sfvspvbmW+pVy5HxFy7KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhmA38huIRZqQe0egSoOA/vuPxxtnhmjhUqi3AA+Jm0SXKbLj9UPmSmhNYniz3WkXXvewujMMAHj05rqfInVaf3jKXJoAay00uc5i6Alw62ih8GkxX+YoilIfW5gn2kaYqAudCswzk8aUoTZ0G9DZ8WqffObbGSIMplRSVyiMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo6cC97W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48197C2BBFC;
	Thu, 13 Jun 2024 21:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718313865;
	bh=6mmkibTeyuR8KMR9AE3vV6sfvspvbmW+pVy5HxFy7KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jo6cC97W00PkAd3eZHLJfcE2klERTxN9bMxxQr/e3K/apixv8nT2bnAighUEpxayf
	 BniRMFLJz6R3kAqC//o+DUeP0GEvXYkp5NHV0YKRk/0UQ5w0fOMDuKDRg6urvfRwln
	 zM+Z6OdpsGqxZQMJlBr24muKWJehqBCT7ntMzUOB+JhUWjCvwFrzjTc4tN2yCau2lJ
	 S9/7WJuzQQ8HYbXek4o1FVwIZmzAR8RdJVjHwypvfjJK0FB92IXBHD3g7aFj5tJAsu
	 gPdMplz3ynQaFDvAXK2gf74krjnn5iblmz/3sR6rcvsoj9qEN4ELRL1dqVlkqXlEir
	 1s5bzz6lnd9YA==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xiubo Li <xiubli@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 2/2] driver core: Don't allow passing a -ENOMEM to dev_err_probe()
Date: Thu, 13 Jun 2024 23:23:53 +0200
Message-ID:  <85a3d444f2943ebe9d64e722b1717a5f7d06ed48.1718311756.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718311756.git.u.kleine-koenig@baylibre.com>
References: <cover.1718311756.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646; i=ukleinek@kernel.org; h=from:subject:message-id; bh=qpVS61XWsB0UN4GqnaTCpmftdR2O3Sm32WA+JU61fj0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBma2Nx4pDstAUey+dwm4CR5p6NlW04ns9oiawUX 9X3f6hxC8qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmtjcQAKCRCPgPtYfRL+ TlfuB/wPhS4BF9EQMywzCIC5tyaXW1uLIngmKBtnTjAylCuXCyzRmNssirRWeTsA9nY+20KpP40 6HujRF9jgN+lizOuMMzD75GJrUZTbVlH8GwQNgiPGb5bjzOxbyTXPo9STN2mtFQROGtOxIr/WnP yZez6B53o2rEmbJgGKm8WtIeh9CfoBkIqs4pM1hAAqTsckdG0gVKrIATgQMhYvDhOOoudHj/p0q SdIzQR10p9v6yIOpgFxlM2ZYqDYmbMphSnAeAPRBAjoJU/4u24ceeOoeNO+4Cgtv4xY+KLIbuQ3 C5c8FuCKCOCBWqhR73taPx7MoQi5I2l0MC5Thlm10t8eIgDi
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

If a function returns the error code -ENOMEM, there should be no error
output, because a failing allocation is already quite talkative and
adding another indication only makes it harder to determine the actual
problem.

So the construct:

	ret = some_function(...);
	if (ret)
		return dev_err_probe(dev, ret, ...);

is questionable if some_function() can only succeed or return -ENODEV.

Catch some of these failures during compile time.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I have some concerns about this patch, I only implemented it because in
reply to the first submission of patch #1 Andy wrote that he thinks this
should be done, too. So the idea of this patch is only to keep the
discussion about handling a constant -ENOMEM to dev_err_probe() away
from patch 1, in the hope to make application of patch 1 more likely :-)

So, I think this patch 2/2 is a bad idea, because:

 - Let's assume there are functions, that return either success or
   -ENOMEM. (I'm not aware of such a function, but I didn't search for
   one and probably something like that exists.) Probably the compiler
   won't be able to know that, and so doesn't catch that "problem".
 - Using dev_err_probe() to handle the return code of some_function() is
   convenient. First to make error handling in the calling function
   uniform, and second, to not create a patch opportunity for all
   callers when some_function() might return another error code in the
   future. So dev_err_probe() can just be used without caring for the
   details of the handled error.
 - In the presence of patch #1, there is no real problem with calling
   dev_err_probe(dev, -ENOMEM, ...), because this is an error path and
   so not performance critical, and no error message is emitted.

Given these, the more complicated implementation for dev_err_probe()
isn't really justified IMHO.

Best regards
Uwe

 drivers/base/core.c        | 4 ++--
 include/linux/dev_printk.h | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 730cae66607c..87b9eda95178 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5012,7 +5012,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
  *
  * Returns @err.
  */
-int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
+int __dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -5043,7 +5043,7 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(dev_err_probe);
+EXPORT_SYMBOL_GPL(__dev_err_probe);
 
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
 {
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index ae80a303c216..84cbf67d92c8 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -275,6 +275,12 @@ do {									\
 	WARN_ONCE(condition, "%s %s: " format, \
 			dev_driver_string(dev), dev_name(dev), ## arg)
 
-__printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+__printf(3, 4) int __dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+#define dev_err_probe(dev, err, ...)						\
+	({									\
+		int __err = (err);						\
+		BUILD_BUG_ON(__builtin_constant_p(__err) && __err == -ENOMEM);	\
+		__dev_err_probe((dev), __err, __VA_ARGS__);			\
+	 })
 
 #endif /* _DEVICE_PRINTK_H_ */
-- 
2.43.0


