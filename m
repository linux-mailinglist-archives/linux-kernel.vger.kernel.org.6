Return-Path: <linux-kernel+bounces-281874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A2894DC5C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1506B1F21D42
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 10:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD761581EE;
	Sat, 10 Aug 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="htrzsqHU"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD77156220
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723287294; cv=none; b=M8+cWqxmWEE7yRxnbVcJL32gkDzsZyJn27tjQud08a61IPxLWxvijSIVaY4dDxdWqfQjaeVNzPB1f18mSvZlksQi9lB7/+yKBG9Yw38OnXoDsN6xD564+K9g14G1hNEf8+Out9n/BSge5xK70dMUXG7Tf2anvYDnJ+7a15mQ0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723287294; c=relaxed/simple;
	bh=jzKF0yba0KcWR8N26vRI2/4+qJGExpvII+5NOGcuBUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3CDwVR2tMNwq0EhFjrsaEDS+iXV+G20+m8USWq1iK2pj/oyYnxN0DIT2Mden0DYZvwgKavp1/M7TeWSEFYKQl84EOx4IUlPgdP4MwSx7ahCGKhDtYmsbyyCX0Lwm//GZZAq7ZIaCPR2HBpZaIqZca98W/r4dghIZk0p7cV/46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=htrzsqHU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723287289;
	bh=jzKF0yba0KcWR8N26vRI2/4+qJGExpvII+5NOGcuBUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=htrzsqHUYctVBc/taqurnaZ+idAnD1kfI1zP51jZDBPAmfe25pdIMqXu+b6ppJFpT
	 gq/jh5rosWdc0Di98gTavhT3o84xKHqa5wYGWUe4FrdgEYWmG4d7rDojCr+WT9RwLn
	 Xa238m8+w6Ms0qiVx1uPpjlFfYvneaR/W7LIWLZg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 10 Aug 2024 12:54:44 +0200
Subject: [PATCH 1/3] tools/nolibc: crt: mark _start_c() as used
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240810-nolibc-lto-v1-1-a86e514c7fc1@weissschuh.net>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
In-Reply-To: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723287288; l=900;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=jzKF0yba0KcWR8N26vRI2/4+qJGExpvII+5NOGcuBUo=;
 b=/w4izn8BUZmm84A+drA29mNtfFmvzx5U8N1zxo05O2VXknB75ozIl6d3dD1yahifl45bJRo6y
 YyvHG2jmR3WBj+/BiuhPHfZsSYdwya0IQcEs1iwWYB9zSImpr0awhtG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

During LTO the reference from the asm startup code to the _start_c()
function is not visible and _start_c() is removed.
This will then lead to errors during linking.
As _start_c() is indeed always used, mark it as such.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/crt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index 43b551468c2a..161557e6650d 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -22,7 +22,7 @@ extern void (*const __init_array_end[])(void) __attribute__((weak));
 extern void (*const __fini_array_start[])(void) __attribute__((weak));
 extern void (*const __fini_array_end[])(void) __attribute__((weak));
 
-__attribute__((weak))
+__attribute__((weak,used))
 void _start_c(long *sp)
 {
 	long argc;

-- 
2.46.0


