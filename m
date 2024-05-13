Return-Path: <linux-kernel+bounces-177622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E138C41B9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FFE1C22DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C68A1534EE;
	Mon, 13 May 2024 13:21:10 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2159164
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606470; cv=none; b=KkK5Oovw6ih9uB2RQVj3nLZzlLO8o+JWsInIfljH7lM3TKeItICXW7GGoKHEtljTPmnZGf0uhjiJZ8lgYGJ7fDCT4ySYsug4USy6PG1yizgy53X+59kSqlmXRXBJN6Hkro0FyR1Wkd0P1HLQG1nLxUwjEwiNxjH2auiymnRg6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606470; c=relaxed/simple;
	bh=p8vL6YoySFXtH7yBUGU4yZJWG0hMGXiTflCKpNQf50I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fFWS7UFxud1FNF61wSk8HvGAjyr370EFPlZjIxH6ETmnKYRub+m2gf5tKT3XgP5OTO04jGJQrJ6qI6H0qe/xFH9Z4pLSB4lK2bv/H97QzFkQjIUc7iMaTj+Mol+MLg+nRiw9JfCR97VWqOEFBNPKchwjrf6Am+3m3HXu5ivKRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:c85e:4b6d:1f91:1410])
	by baptiste.telenet-ops.be with bizsmtp
	id NdM02C0065V4kqY01dM0nt; Mon, 13 May 2024 15:21:00 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vb7-00399h-RK;
	Mon, 13 May 2024 15:21:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s6Vbv-008tqO-U0;
	Mon, 13 May 2024 15:20:59 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] sh: Fix missing prototypes (part three)
Date: Mon, 13 May 2024 15:20:52 +0200
Message-Id: <cover.1715606232.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series fixes more "no previous prototype for <foo>" warnings
when building a kernel for SuperH, namely when building j2_defconfig.

Thanks for your comments!

Geert Uytterhoeven (3):
  sh: of-generic: Add missing #include <asm/clock.h>
  sh: smp: Protect setup_profiling_timer() by CONFIG_PROFILING
  sh: setup: Add missing forward declaration for sh_fdt_init()

 arch/sh/boards/of-generic.c | 2 ++
 arch/sh/include/asm/setup.h | 1 +
 arch/sh/kernel/smp.c        | 2 ++
 3 files changed, 5 insertions(+)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

