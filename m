Return-Path: <linux-kernel+bounces-383595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4A9B1DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A451C20D0D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00D156242;
	Sun, 27 Oct 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4aY9y4j"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82321DA4E
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730033985; cv=none; b=o1rNjTgcdwXht+RUWeLZ7pAGqfqu0y6ehKMTIOPhkNFutve48tSlXgXCWLgfZW/MGllz736mpHvz982nHUwMXFrgNdbsvftwoj6ByIVoJveeYtKJRP09yRvcwmZ+JpdF/xKAmVX5nTVtmKbFugaXQQCDybi9548HZm8oDTrm+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730033985; c=relaxed/simple;
	bh=+7HFqpPetYd0/9qVrvLQ6aY8jVUyHYCRGOtQfWsf5hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOfmqb6kycdT8MfVhgoPn7Hs4JApisQuaKDAkEfCGUKBIg7J3FaIh1aWfZrLH0Uwrw0otZoquMUOLbfXrzDT/A28XeOaUvdODW7+lPQUEMUmuIJcrsizjKKMUWwxO0OKbCacSa1mZw1R4bZmX6oxMb4LaDxA2vogr/R6p0dz/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4aY9y4j; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730033980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YhO//bO621t7BGGosVsytQ78SLPgR+dQxqYbb4Ol6B8=;
	b=S4aY9y4j2u25q+5w64LIMfW+SceTZ0oFz4KZJll4T/0CMfFDNLfMgUywZrDyUSrS9xE1yV
	kYBIahAphc/lRjwveWm2dDeNIFoOoDU+cCzhG4LdAzylYwNV3lMopu0mPw7PZR3BZs8Xd/
	27YuIyH3+PX3ep8Q0VsMbjCJUZrofX0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: Add str_off_on() and str_no_yes() rules
Date: Sun, 27 Oct 2024 13:58:59 +0100
Message-ID: <20241027125858.1804-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In addition to str_on_off() and str_yes_no(), add rules to search for
str_off_on() and str_no_yes() replacements.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
index 375045086912..93de05aeded2 100644
--- a/scripts/coccinelle/api/string_choices.cocci
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -282,6 +282,25 @@ e << str_on_off_r.E;
 
 coccilib.report.print_report(p[0], "opportunity for str_on_off(%s)" % e)
 
+@str_off_on depends on patch@
+expression E;
+@@
+-      ((E) ? "off" : "on")
++      str_off_on(E)
+
+@str_off_on_r depends on !patch@
+expression E;
+position P;
+@@
+*      E@P ? "off" : "on"
+
+@script:python depends on report@
+p << str_off_on_r.P;
+e << str_off_on_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_off_on(%s)" % e)
+
 @str_yes_no depends on patch@
 expression E;
 @@
@@ -300,3 +319,22 @@ e << str_yes_no_r.E;
 @@
 
 coccilib.report.print_report(p[0], "opportunity for str_yes_no(%s)" % e)
+
+@str_no_yes depends on patch@
+expression E;
+@@
+-      ((E) ? "no" : "yes")
++      str_no_yes(E)
+
+@str_no_yes_r depends on !patch@
+expression E;
+position P;
+@@
+*      E@P ? "no" : "yes"
+
+@script:python depends on report@
+p << str_no_yes_r.P;
+e << str_no_yes_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_no_yes(%s)" % e)
-- 
2.47.0


