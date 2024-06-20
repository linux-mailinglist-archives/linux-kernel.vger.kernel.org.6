Return-Path: <linux-kernel+bounces-222219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F00590FE66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C42C281BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689321741DB;
	Thu, 20 Jun 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="wR5hHjUP"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB258AC3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871271; cv=none; b=U56/yV9BuX3EjBsbpsCU1w7BZ1mR0/jjtLJElhzyZ4TZJX6HO63duoj+kB9bCUQ92ouWB2RcwYocZcG4DjUkYfXGK7WQQG71VFlBBQEwk+yKcN7ZZF1eKuIm10WJKxZz4n1XwFV7BjRzFI7Y9zPof6S2z/pDXSlkXy30UPsBwCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871271; c=relaxed/simple;
	bh=FlscvEDDcu13eoF5Wl9PsqwF+BZQhWYbeFw1m7NAi7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZj6Tbx3icW1UTku6alcxHBrlFLpS0sfURmEtPMQimyK+a7qh4qsEGY+pEn+3F7vksDUAIoM8BYzwUeRvBL+4wH92Tw6u+mRghAdwUaQSBuNCiQwtcDfaEulrpDB+5mcww1ap3cTCoxtTORco/ihLN3n4x+P7DP33jwLNUuohvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=wR5hHjUP; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: linux@leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1718871264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F0qRyJa+zNcoSXZSbnNp2Yjcsi5txCSu3tLo/Qr5tLo=;
	b=wR5hHjUPGjevcNdcBucyES59srKKZ11IKAUU5jV9TlhQL1DEbusysYo+3XaC2Fs5dN+eeG
	9zqnY4J3NJgYnWBUJFcS0+MvoBUePRYJ6sgLqUkrrZomnPFfi7sHJgSuPaexAvlfTVBzND
	z0yaljnNjdicJ5D3pHmfTqHBkcMrd3W+0Yfd0q6efOfKpORQ9ZOobM8KauCP+Eh2hwP23e
	ruPhq+KY7pPkZ2YZFaZ8qSpV4h5zTfFGROTFHE6aNHZvhvqk7wF1QU38dQfM6wwUIfL4GS
	8zOR6vAb7/H2bUg7cEz3kL5SJCvjm1Wb8X4cnbOruKs7gn7aHTd3xSdUpAs9cg==
X-Envelope-To: corbet@lwn.net
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] docs: verify/bisect: Fix rendered version URL
Date: Thu, 20 Jun 2024 10:13:37 +0200
Message-ID: <20240620081355.11549-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When rendering the documentation, the 'html' file extension replaces the
'rst' file extension, not add it. So remove the 'rst' part of the URL.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 .../admin-guide/verify-bugs-and-bisect-regressions.rst          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
index c389d4fd7599..6281eae9e6bc 100644
--- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
+++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
@@ -23,7 +23,7 @@ mistakes occasionally made even by experienced developers.
    up in the reference section, then jump back to where you left off.
 ..
    Find the latest rendered version of this text here:
-   https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.rst.html
+   https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
 
 The essence of the process (aka 'TL;DR')
 ========================================
-- 
2.45.2


