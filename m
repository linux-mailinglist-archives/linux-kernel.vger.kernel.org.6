Return-Path: <linux-kernel+bounces-282430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DC94E3D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DA01F214B0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684E165EEC;
	Sun, 11 Aug 2024 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="bPif1NlK"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E744C7E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723418976; cv=none; b=sQzIadi+8MzteVmu4KNYwFbhz583zEspf9+3bcqQ4LY+/Sd3CcPPL7iD6uTtC1wOE7S7WyrqogA8/Uxu5SyRvOVM1Yi1WJEDR/zQnq+rjsGMzWjdLBn/5fl9nrG9MvJX6thXDP2H48Q0LnjpnR81S1VMJr+L28/C2Jvdixjz6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723418976; c=relaxed/simple;
	bh=6asL+vlLn7HJUMgv4kf2xzgQ75iFwr4KJvDM6zYEAPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2MGDLVxffnSzTcGlATAnBiNo8my/RHQijC82B4IUstmRKM1MhPltE0X5ZDgOgU5HDEg6ZBmufJBvRGkqHio0uTtv9BpLunIBpPmwyVHUtUy0vZO63J7dqRo1UHxk89VS2gCEyLB2tzqNDfcF+eVufuFdqUdq00IKdAbV3Yl94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=bPif1NlK; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 8955 invoked by uid 990); 11 Aug 2024 23:22:51 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 12 Aug 2024 01:22:51 +0200
From: Florian Rommel <mail@florommel.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Florian Rommel <mail@florommel.de>
Subject: [PATCH 0/2] kgdb: x86: fix breakpoint removal problems
Date: Mon, 12 Aug 2024 01:22:06 +0200
Message-ID: <20240811232208.234261-1-mail@florommel.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.793181) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 0.106818
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=6asL+vlLn7HJUMgv4kf2xzgQ75iFwr4KJvDM6zYEAPs=;
	b=bPif1NlK4QJOjL5M/J6pUNWbNw9/pfvVKli6ImiIh8X3NUYvpdAMI/2FSIQb6pxltJkWD7eNFN
	x7r0C246xxVgonkiRw4FRem57siu/OAj25u4SWg6u2pA+pfigjwyH3Rj1BeTV9mx/rz0bGA/wiR0
	NcncUNfIldWA+/Exb5Iwz2XjbI6xCHhtedV542ju1DBM3TAp58PxksJiC3de47OFmZ/Oq8HZ2scO
	u/Jw7qwJpdFq70N6pdCZFYqXdmBZTRwSKXyTsttY2zNYdeiwNnQhVld2tG5pmWxMRpiL9ZVUTT+L
	y4pqs7qWPFdRHi6UeL6wOnKU7oRio49AFxFcJ/TZGpxdxvPVZ6y5MhaTm2yF0HUR5aFf+GKjeoPb
	e3GazB3nnlZgT6KwZbHWkPFIredHasG7I8AfgXDOSZpuminSPn+nXLZchhIRPPawJEz1aIRLIAam
	cZIjBPVGK6OTHIt5DxlmzOFNCJ6gYmKgq6WwFBEKHMlvJio2UF4B/JFqI2NORbOzkyjDOP/qavK0
	Wrh7rrgM4jZ/nNuEFJq6TOZwFh1tfnQDlLoyfvvmx3V7hkbVQMeWkSllzVFTguQPgP9F3CHIU2dr
	3y+GSzQA0pSeuZCT5xHxxyU2MqMf4lQ8/iBnb3spCOLAkYUwCy5WDt3hyTmysPN0zAaABI9f0F5j
	4=

This series fixes two problems with KGDB on x86 concerning the removal
of breakpoints, causing the kernel to hang.  Note that breakpoint
removal is not only performed when explicitly deleting a breakpoint,
but also happens before continuing execution or single stepping.

Florian Rommel (2):
  x86/kgdb: convert early breakpoints to poke breakpoints
  x86/kgdb: fix hang on failed breakpoint removal

 arch/x86/kernel/kgdb.c    | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/kgdb.h      |  3 +++
 init/main.c               |  1 +
 kernel/debug/debug_core.c |  7 ++++++-
 4 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.46.0


