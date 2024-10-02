Return-Path: <linux-kernel+bounces-347788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65398DEDF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52EF2B2D3FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9A1D0E1D;
	Wed,  2 Oct 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX+9nMYu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FA1D0E07
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882147; cv=none; b=ut1HtebQE1u5YRxDfUgwe6YdrP3nQKGfM8BH+1u/N4a+JFgSMCNLqZZvJPyTCWcyLOq5TU/6+JWu9lHGoiXBCkxWCDRk+UNP3WqVl0LMbTTmlDZOvqSfHQesCrMKuUqMzJqoCZXo4YW5iVxV1LguTC0VpxdY9q0WD/pyyLEBhkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882147; c=relaxed/simple;
	bh=5QMy8UAx4GiWIgJZbBhQCqJfx6nJBu+04Es8YVj67O8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6NB6F3aUgth06S1En/nV2BdjryYFfPeGxVc/CA/n1ms2Yh4rNFRLiG+JnpVl2zaV5lxUNlKyFsjKABJGqEQy4el3ow7oHR9ekIXlImr4kkrNxst5UX45v7RW2+Losu08/YDxT80CLMh2huUmfiIua3omuXQxNSl4DsyEPaRg/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX+9nMYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4762BC4CEC2;
	Wed,  2 Oct 2024 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882146;
	bh=5QMy8UAx4GiWIgJZbBhQCqJfx6nJBu+04Es8YVj67O8=;
	h=From:To:Cc:Subject:Date:From;
	b=PX+9nMYu8Wp+khtNQjzCzxQG37KFSmGG2Xo7khxtdprYf4IRKb40ix7JtWu61N+Dq
	 1VQU618XOqSPOfjmBqfm2O5J/MTaLNOxxM8HQTXGkqgR7vRRmwUru7BXrpu0XCMRTh
	 e4RVz42dHnaAXRSN0qJcfVG7u6ZsRimX5nIszzIUR8fXW3oFGlxX3dUAoUR+CY4RbE
	 Z5wy4VqX+cx2cm9c5gh3cCUAA8edNVGIHVIRzJCrStHcQUHhe7gDtVThaJRiquhaX0
	 ETWQOcIyJSYKXmFYS3wuuM/Qna+1D4cBNhvMinOoFwiar7xP/EIPjXsaHln3H2MWOL
	 Ocp6ag0kVrVHA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] mfd: wcd934x: replace MODULE_ALIAS() with MODULE_DEVICE_TABLE()
Date: Thu,  3 Oct 2024 00:15:32 +0900
Message-ID: <20241002151539.43762-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b4b818305578 ("slimbus: generate MODULE_ALIAS() from
MODULE_DEVICE_TABLE()"), modpost automatically generates MODULE_ALIAS()
from MODULE_DEVICE_TABLE(slim, ).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/mfd/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index fcd182d51981..3c3080e8c8cf 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -284,6 +284,7 @@ static const struct slim_device_id wcd934x_slim_id[] = {
 	  SLIM_DEV_IDX_WCD9340, SLIM_DEV_INSTANCE_ID_WCD9340 },
 	{}
 };
+MODULE_DEVICE_TABLE(slim, wcd934x_slim_id);
 
 static struct slim_driver wcd934x_slim_driver = {
 	.driver = {
@@ -298,5 +299,4 @@ static struct slim_driver wcd934x_slim_driver = {
 module_slim_driver(wcd934x_slim_driver);
 MODULE_DESCRIPTION("WCD934X slim driver");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("slim:217:250:*");
 MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
-- 
2.43.0


