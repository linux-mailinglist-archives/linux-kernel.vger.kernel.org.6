Return-Path: <linux-kernel+bounces-283773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F6E94F88F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046551F22BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88319922C;
	Mon, 12 Aug 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JFngCM9k"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959491946C7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495829; cv=none; b=gL/1NnLF/uZdsP1K052fCGiYxN1J0hbJFrcrnVXe8QhXsETTu/Y2/8KXKtk9jf+rbdPQyLgm6H2N/ULMuihQrkO43jN1imMwkELRO/WjEW4TU7owuEtrLQQMWacP4++JyoUZrgJ1xyWU12xbymH0F984K0znPZuDm4LFCYPJE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495829; c=relaxed/simple;
	bh=ZNeFBu2r+MPt0NFXyubnSviQFodwSXA7ecOazzdipzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mE9DAAwe28OMR5DjYMYfeEuqcyoTmZ9m+e/ououiPYiDArgS/dVk0cSdspMntMeToe6w8y37GQXJPbfAFVN8nf5R/Rcptt1LHAP2fT6IizZ9ApNr2QIcAJ+QePvDaT8dd2RSk0Y5Ys3Gq6J8ls5k9PBBwm6Mro5J1BF+TOR9t5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JFngCM9k; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723495825;
	bh=ZNeFBu2r+MPt0NFXyubnSviQFodwSXA7ecOazzdipzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JFngCM9kl6nySRjgm5DallTnL2GSYHDADB8arPNiLVbi23HQApOyI8TO9KehskfK/
	 Z5GOOSrMNVhzeaKl+eOSbiHh1W5yooMD0ZorTcuvF/rRdK3clrz/TyHM7uvu0J0QFE
	 ayj7OadDb0cniWvDvF7ZoRom5zOBlFAbiRYu2pU4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 12 Aug 2024 22:50:17 +0200
Subject: [PATCH v2 1/3] tools/nolibc: crt: mark _start_c() as used
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240812-nolibc-lto-v2-1-736af7bbefa8@weissschuh.net>
References: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
In-Reply-To: <20240812-nolibc-lto-v2-0-736af7bbefa8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723495824; l=912;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZNeFBu2r+MPt0NFXyubnSviQFodwSXA7ecOazzdipzI=;
 b=P2xx4qaKTCNzu9ebCHiJR1m5SdUzV/UC7fKa728DAjj7geenVVmJgtYa1FPzTvN9OgMaqRhlf
 mkSJzXIbuy3CFc/Zo/17qVdSGplWEXlq9jGW0cJqzfR0Y9wQ610j+jw
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
index ac291574f6c0..bbcd5fd09806 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -22,7 +22,7 @@ extern void (*const __init_array_end[])(int, char **, char**) __attribute__((wea
 extern void (*const __fini_array_start[])(void) __attribute__((weak));
 extern void (*const __fini_array_end[])(void) __attribute__((weak));
 
-__attribute__((weak))
+__attribute__((weak,used))
 void _start_c(long *sp)
 {
 	long argc;

-- 
2.46.0


