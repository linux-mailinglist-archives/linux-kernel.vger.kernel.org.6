Return-Path: <linux-kernel+bounces-568368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48874A6948C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FA8189B3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB21DF26E;
	Wed, 19 Mar 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i/34csIt"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BC2FC23;
	Wed, 19 Mar 2025 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400726; cv=none; b=P+jmclmeHlEBUKOJwQbkEmg35uuEO6U0g8mYu91MDsUKHnv93fsnqyldBP1VNxASYNn9wRdFHEK16jd/oplZ6iwhz8nrK4lubKGPGotmh+kTpL0pf9wmZQFpLvzESeJkhfo5g5UGhq6EVNWjSe2PdDxAOW979T+2ytMu5UJpIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400726; c=relaxed/simple;
	bh=rZlCLMs8PyhG3jDuWHpbiGO9CuFXuE2SOPhmZDcYMmk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BKAveOQpEEh63KhnpU8YHGWZJ8BlNxjWTCN/gjFxpwcz9n2NlRl5KPb9XzBntsuJNIW+qzdnwd1Tmg5RzGTFIZuKbSmGh1OksZwEyLgoT/sJUffN1JQ26bSvmZlrJFguTZnO/HC5Rvrn1rQlZ9yEv111w3gDQ+2VEzKdKArhimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i/34csIt; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9245420486;
	Wed, 19 Mar 2025 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742400714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SodT/5qzilR1qcWaMEGgSEzryVT80uuoE6CCx+QlTjE=;
	b=i/34csItDRVgM7bNUBaprmTmLJAO+1TO3pAUiVjPGjIdS8tmWtCCtbqMtJ+RNMH8nP5KM+
	XZf1G2p1Q1BpXCnmaj47PKK/pGNkM4w8iTd+02S3RvTmVGjJoGLAU9k4zWwW0VOeA8bkj6
	Ek5xhxDXuNuj5fMsq8odmTZYvTN9WUtM/s53oLvH3NRW9C8AnH4AUGrSkPimC/pefuP3ml
	uA8/hJUnVNj/cW0iZ+JX9ODtZLqSTmVMmD9BsX1byJmxc4JTP6FrvfBkzM1uXjYGzaR52I
	uEryO3k/UaG32o1je7d3hx7W/4wYCXKkjK4WRpNRwWoDTgwpHUskY6WVavW0/g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/3] hexdump: Allow skipping identical lines
Date: Wed, 19 Mar 2025 17:08:09 +0100
Message-Id: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnr2mcC/12OQQ6DIBBFr2JYFzOgQu2q92i6QB0riYIFJRrj3
 YsmXbTL9zPvZTbi0Wn05JZsxGHQXlsTIbskpO6UeSHVTWTCgeeM85yO6LylHS7NPIxUKoBrVUC
 RKU6iMzps9XL2Hs/InfaTdeuZD+xYzxJcuWAiFkUq8wIYZXTQ7xn71KnVqP5eWTv12qS1HcjRC
 fzrxmsGf18EToHKtlRCybJkEn79fd8/C3mZV+gAAAA=
X-Change-ID: 20241224-perso-hexdump-7a008b5053a2
To: Petr Mladek <pmladek@suse.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, John Ogness <john.ogness@linutronix.de>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugfefveegtdfhvdehudfgkefgheetveefvdelheeuiedukefgfeejheefheevueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdegiegnpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlf
 ihnrdhnvghtpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhdrohhgnhgvshhssehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

While working on NAND issues, I used print_hex_dump() a lot to compare
data. But I am mostly working on embedded systems where the kernel
messages go through a serial console. Sometimes network support is an
option, sometimes not. Anyway, I often print buffers both in kernel
space and user space to compare them, and they may be full of 0's or
1's, which means lines are repeated a lot in the output and this is slow
*and* hard to compare.

I initially hacked into lib/hexdump.c for my own purpose and just
discarded all the other users, but it felt like this might be a useful
feature for others and decided to make it a public patch.

* First patch creates a helper named print_hex() with a prototype
  containing a flags parameter, instead of an entry for the prefix type
  and another entry for the ascii boolean. print_hex_dump() now
  falls back to print_hex().
* Second patch adds a new flag to possibly skip the identical lines.
* Third patch is optional, and adds the offset at which the dump
  finishes in case the last line to be printed would be skipped.

The Cc-list, as provided by get_maintainers.pl, was returning 330
e-mail addresses which felt to much, so I ran the script only on the
second patch (the printk/includes/debug/Doc changes). It gave this
Cc-list which sounds more reasonable. Hopefully this is a smart move,
otherwise let me know what you think would be best.

---
Changes in v3:
- Drop the tree-wide changes.
- Create a print_hex() helper with the new prototype discussed with
  David and Petr. Create a fallback from print_hex_dump() to
  print_hex().
- Include a new patch to print the final offset if the previous lines
  where skipped.
- Fix the typo reported by Randy.
- Link to v2: https://lore.kernel.org/r/20250110-perso-hexdump-v2-0-7f9a6a799170@bootlin.com

Changes in v2:
- Rebased on v6.13-rc1.
- Manually fixed the diff in many places to fit Andy's requests.
- Added a real life example (code diff and output diff) with the
  modification of the API as well as the use of the new flag introduced
  by this series in the cover letter (at the bottom) as requested by
  Andy.
- Link to v1: https://lore.kernel.org/r/20240826162416.74501-1-miquel.raynal@bootlin.com
---

Here is a typical diff showing the code change with a perfectly equivalent
output:

 print_hex_dump_debug("", DUMP_PREFIX_OFFSET, 32, 1, spinand->databuf, mtd->writesize,
-                     false);
+                     0);

Here is a typical output of a NAND buffer without the new 'skip' flag,
ie. with the above code snippet:

00000000: 55 42 49 23 01 00 00 00 00 00 00 00 00 00 00 01 00 00 08 00 00 00 10 00 2b 10 f1 92 00 00 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 db 93 e9 fc
00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000001a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000001c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000001e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000002a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000002c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000002e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000340: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000003a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000003c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000003e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000004a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000004c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000004e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000005a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000005c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000005e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000620: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000640: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000660: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000006a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000006c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000006e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00000780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000007a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000007c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
000007e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

And with the new flag added the code looks like this:

-print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 32, 1, spinand->databuf, mtd->writesize, 0);
+print_hex(KERN_ERR, "", 32, 1, spinand->databuf, mtd->writesize,
+          DUMP_PREFIX_OFFSET | DUMP_FLAG_SKIP_IDENTICAL_LINES);

And the output is easier to parse and also faster to show on a serial
console:

00000000: 55 42 49 23 01 00 00 00 00 00 00 00 00 00 00 01 00 00 08 00 00 00 10 00 2b 10 f1 92 00 00 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 db 93 e9 fc
00000040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*

00000800

---
Miquel Raynal (3):
      hexdump: Simplify print_hex_dump()
      hexdump: Allow skipping identical lines
      hexdump: Print the prefix after the last line to show the dump is over

 Documentation/core-api/printk-formats.rst |  4 +-
 include/linux/printk.h                    | 43 +++++++++++++----
 lib/hexdump.c                             | 76 +++++++++++++++++++------------
 3 files changed, 85 insertions(+), 38 deletions(-)
---
base-commit: d5d7d26716afd36b8c2a49a3265fff0b16e3694b
change-id: 20241224-perso-hexdump-7a008b5053a2

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>


