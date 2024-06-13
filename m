Return-Path: <linux-kernel+bounces-214024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4078E907E15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EACC31F22D13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715E813E03E;
	Thu, 13 Jun 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWEkGkVT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF724145B0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313861; cv=none; b=L7PfWJnVdUc57B+S8iUo5oDlvJrVu64n+qU3HRpcnP8+dIPQYMbv2kAxiVzqQEVJrXS6inanQ1Tkw2VPQEBHxtQfZVo01B37oNGxLHiYyjPg+/aiLAe/gmJI/L+QzT3RcuHgE/DX61VdaQpYRRemRiQesZdyED2OhdNeu1PQLfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313861; c=relaxed/simple;
	bh=QqIZGQrv9K9dFTDC4hhikRKHbakIW9rdGXmIfQu5mAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5LIabZZohw3nP5+ISHqfeUTOeXeaCVZceKKqzBtLOUbijhCOK9a7GaEzmGWwXELkRWjs78R0tzZb+unm7IMYZQFsWmExDdW4nBb1HUTLztRX7i6iownFElLdBBhuzVAwy6bmgM1ALkRg3aH2LR35UyRHJNsDQeyKR1vzgxxlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWEkGkVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85D7C32786;
	Thu, 13 Jun 2024 21:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718313861;
	bh=QqIZGQrv9K9dFTDC4hhikRKHbakIW9rdGXmIfQu5mAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWEkGkVTXrodPqwOgggH8ksH9Ee5qkdS6doocU2oZyxoxbYn3st36epV0iHa/IRiC
	 Bdy6v+6KKnVJypfQbQ4J32Af7hY2io5DTIq8IB5b3Pk35jrAFL7KNj1nbH6SuYXUI9
	 svM/4R9O3HFYctAqTIuPbta1u1mWZTxy+P6NtI0y7qYJKyzxiVc+KJRB/VH7ybZaPW
	 PZamalWsU4dJupLdkHj7fY0NcWz/wohh40ojr/lZSognMtJWCSqI2wC6fi+0XCLD9M
	 /4QlXlrrDhI6CiGV1CROlKeexqHxokK2ESTr0KtEJZYqvShA89SytsqjgxTd8+gS03
	 MvsFLZ2EoV86Q==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xiubo Li <xiubli@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] driver core: Make dev_err_probe() silent for -ENOMEM
Date: Thu, 13 Jun 2024 23:23:52 +0200
Message-ID:  <3d1e308d45cddf67749522ca42d83f5b4f0b9634.1718311756.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=ukleinek@kernel.org; h=from:subject:message-id; bh=Dotl1bfqLlXCsRdj5v3PHckfnU3L3wSLisYZtV4R7zE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBma2Nt0FZh/2duhsf1tku7zP32b+aOuSak3Wenz sa8Ldnh8oCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmtjbQAKCRCPgPtYfRL+ TsOPB/9Ecjcs74Z6Cp70GzJTAWl1+Qeaej2hbARPkAtyk3x/26FgsKzAIPPVHVfLD4JyQZQ4ky7 gl+dh+EHgf4EakFHz+weVel1cn4A+O+ykoQWk2yH4yl4ZgSjwG2TP+W/oa09lQAeSsB3uaqhajM i1BRnmIY0OM4LVfvaioANJ/PnQi9O3iD9xpPK5DdGJWOjHiU9L3/u+oHA9VI0m6KyJOdL5fAC6Z tkGztIw9dW3ZcioJKF9g0hCWUR560Vr+WdcxPf55CW67yrGCpUUzCEfLXNWrAXGqSAAEVDEKaSK 1F0cQppfarIKmG6vc8k1dmxpN7rqo0RNH4gdoemuRDL7sWel
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

For an out-of-memory error there should be no additional output. Adapt
dev_err_probe() to not emit the error message when err is -ENOMEM.
This simplifies handling errors that might among others be -ENOMEM.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/base/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b704..730cae66607c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5021,11 +5021,22 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (err != -EPROBE_DEFER) {
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-	} else {
+	switch (err) {
+	case -EPROBE_DEFER:
 		device_set_deferred_probe_reason(dev, &vaf);
 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+
+	case -ENOMEM:
+		/*
+		 * We don't print anything on -ENOMEM, there is already enough
+		 * output.
+		 */
+		break;
+
+	default:
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
 	}
 
 	va_end(args);
-- 
2.43.0


