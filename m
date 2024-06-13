Return-Path: <linux-kernel+bounces-214023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A617A907E14
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EEE5B24F58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD46F13F421;
	Thu, 13 Jun 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmLwJuE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257C213D250
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313858; cv=none; b=N7aRufm/9V6txkBn0he5RivQu3Xb/JgpOK8QTWKIljHeCmKiu5UcPVe76F6hREug1T+oiSIfjjsU3ZoHWq6pRDMnuU/+PjQWsUgUKuSpm2z2xHbBLFFyEY/+f3zf4JPD0K4du5tSHySasZw5ue0bWegfKhI2QJ2zXT9ZlD0e73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313858; c=relaxed/simple;
	bh=IQ+3JHVA2PWF88GTO4tRQJNhKDQ1FaKKe5LgyHsYHtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FB9hR9ek2L4RVq049BZAqXi4q/EudP5VEioxEQYUE/OjxQOnGIJURevjdi9g42LVmuPqBsN5VVuSKWWpneCYZe0gbzAbbhcbEg+3WRH/L9JTPOY9FcG60EVUPmE0WNW+vrB+Y1X6Q7Z0KfFheEfuaNWUje4yxtpvfURgvVvawM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmLwJuE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5043C2BBFC;
	Thu, 13 Jun 2024 21:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718313857;
	bh=IQ+3JHVA2PWF88GTO4tRQJNhKDQ1FaKKe5LgyHsYHtM=;
	h=From:To:Cc:Subject:Date:From;
	b=JmLwJuE+mZyIa48jIFpcYBIOzo1Xwl9A2KmPtQ3vyklHxsQTX6zlatwKH6m8q3lwa
	 qnESOMzXxJ4TootilW9zzepc++CWUNPtCkJ9wAqPwuj2QV8AVfRM61fe6JEXtZ+k1L
	 aJGIqdrjcTyf4MM+rTDABgQUSYzCMepMpCEVWMIi+B5It3uN5jxYtbU3LbBi0Zz5NV
	 IS1x4kkXBOHyYp9pusKoCfSWGrzM4AqJWQwr3fceWj7O1XthYoX55wEvMiRAB2qlaf
	 aPvvqly14V6X2DRgcXhBeUC1ZOTBYu+EaEVKfJLMeZmEj1UmS7ufPoyhVxIC2ojsrw
	 V7Kum4N8Cs0SA==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xiubo Li <xiubli@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Improve handling of -ENOMEM in dev_err_probe()
Date: Thu, 13 Jun 2024 23:23:51 +0200
Message-ID: <cover.1718311756.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=ukleinek@kernel.org; h=from:subject:message-id; bh=Vr84X+HHzs4AAJ3vcICzHNQMd4oUdg/PjGFH6wOP9cw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBma2Np33vfnerHRAN3C24ql1o/nr4wb1ivAGrsR 4Rr4zeDK8aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmtjaQAKCRCPgPtYfRL+ TgSeB/oCQkK7LWP7JOxemPE9aNeauxuGyUVstmMyaSjST8aqHsot4kg7HIoBlmR8K5NWJWva8qp Ck1JIhhHRQnuWOtarxBcegfJIm8BDGEFX+Oc9J8KIC7yvbdA7t5IsYxVQMMQhrLL4P3sGKYE/KT PtQWZIMapO0mxRayJP21AZPn8byI0N9ncNL92IL27IVmYq4VjUeDlrly3uyd9Ltgzf2b7z7h4bl Ii08Pw+nA0VIgtnKXksXqj1RIFqgQ5xap0yLGhoc/KD736jy+HqrJrxMztn6b051NYnWkAhoKzB xqJQ480a2qQVomRftVeooDV6xzruRVDAoqJJA3WyvJu36Mg1
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Hello,

the first patch is just a (trivial) forward port of
https://lore.kernel.org/lkml/20240412164405.335657-2-u.kleine-koenig@pengutronix.de
to today's next.

In reply to the above mentioned patch submission Andy Shevchenko
suggested to make passing -ENOMEM unconditionally to dev_err_probe()
(i.e. handling the return value of a function that can only succeed or
return -ENOMEM) a build error. I'm not convinced, but for the purpose to
show good will and get the first patch in, I implemented that in the 2nd
patch. See the comments in that mail for my concerns.

After some discussion about Andy's concern the (implicit) v1 thread
died. To get the discussion going again here comes another patch
submission for these ideas.

Best regards
Uwe

Uwe Kleine-König (2):
  driver core: Make dev_err_probe() silent for -ENOMEM
  driver core: Don't allow passing a -ENOMEM to dev_err_probe()

 drivers/base/core.c        | 21 ++++++++++++++++-----
 include/linux/dev_printk.h |  8 +++++++-
 2 files changed, 23 insertions(+), 6 deletions(-)

base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
-- 
2.43.0


