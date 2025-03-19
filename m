Return-Path: <linux-kernel+bounces-568369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07272A6948A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87C919C1965
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79281DF248;
	Wed, 19 Mar 2025 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YXaUQrDf"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A41DE2B9;
	Wed, 19 Mar 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400726; cv=none; b=UZ7eJsmb/gnB3nsEng2tLn/ofTjCCAZKu5oR5K9PGK4P/KqxSMl2F0ERraPM64+j1UHLqvxmWtLoJZXj+uF9DxdArMR9Lt83B2D+J4wArtNeKAYv6KorwnyTzHh0fNEArRkQGO/jascFRc6ZZFxanmFFX+UPPOpJDx54bUSyeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400726; c=relaxed/simple;
	bh=gvzv+JoKyTfzZBnuQVo92/nHh4afUX9iQfLLKtCWUSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oanaYA76TAkB2kM7rWzRzntWfrm+TjwyDzJGCpFpuOVyAbw7dENJ0QIKX39MYNemPN4bJx4r9X6Kxe1i7IvdqpQftB90qIMUOd22PeeWWC3DBrBzRO/tkgCfZPFaI6nn5ndVPAZ9Cp9Q7WlcXwj8rHaTvS9EMEjCDWafxRpxpC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YXaUQrDf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E07762058B;
	Wed, 19 Mar 2025 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742400716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m555aCLnWKiYrn41gUCNlBZiTLZxQmM5uW++76DvNe4=;
	b=YXaUQrDfATdDyNAa78V1Tc/SezMyPuoLoOnGdpxgbUfrtestNRz65wZuuOBMLQK1dZxecz
	G8uG+1Ps8S8WFCIGZ+7c5clWJ7yql0jiWWBeIgNPEQHgVrPyvFM6YtPI5fT4PfJG2r8Tqe
	RKj/7st1cFDNB4521RSxRI3MsAKVGbqUSbHQs45PRVGGOeER/LP8wzj9KB76IsMox49JLE
	sY/jJWbKlcUnMr2XEUgbAmN9b715OskiyOwFjmI7K7mIQdf7To1NLqpUi0xc9AE9EzLEaZ
	kKPqeZw1ZLkMY5NrRxGJcJ9vEbwnx5AVyXNChdFEEvqrLHlFIwSIid+kXzCtpg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 19 Mar 2025 17:08:12 +0100
Subject: [PATCH v3 3/3] hexdump: Print the prefix after the last line to
 show the dump is over
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-perso-hexdump-v3-3-a6ba3a9f3742@bootlin.com>
References: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
In-Reply-To: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehrohhst
 hgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhnrdhoghhnvghssheslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

When skipping duplicated lines, the end of the log can just be a
star ("*") which may be confusing (?), so in order to clarify the end of
the log, tell the user how many lines where skipped and mimic the
userspace hexdump output, let's add in this case a new line with the
next offset.

With the following data:

00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................

When skipping identical lines we were seeing:

00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
*

And now we will have:

00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
*
00000080

However if the output was (first bit of first byte on last line changed):

00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000070: fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
           ^

When skipping identical lines we would see:

00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
*
00000070: fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................

And in this case the output would not change with this patch.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
This change is not related to the two first patches and is just an
addition that was requested by Andy who felt like it was not clear where
the dump was ending with the 'SKIP_DUPLICATE' flag when the last line
was skipped. Honestly this never bothered me, so depending on the
maintainers wishes, this can either be applied or skipped.
---
 lib/hexdump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/hexdump.c b/lib/hexdump.c
index f0d1a7f1ce817fd53a7ffd259fbe9b9c8348db16..c0c9a13838513bc7dec2ebdeadf622cd319ea4f8 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -302,6 +302,13 @@ void print_hex(const char *level, const char *prefix_str, int rowsize, int group
 		else
 			printk("%s%s%s\n", level, prefix_str, linebuf);
 	}
+
+	if (same_line) {
+		if (dump_flags & DUMP_PREFIX_ADDRESS)
+			printk("%s%s%p\n", level, prefix_str, ptr + i);
+		else if (dump_flags & DUMP_PREFIX_OFFSET)
+			printk("%s%s%.8x\n", level, prefix_str, i);
+	}
 }
 EXPORT_SYMBOL(print_hex);
 

-- 
2.48.1


