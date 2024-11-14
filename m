Return-Path: <linux-kernel+bounces-408499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE59C7F94
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1663284440
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1612746B;
	Thu, 14 Nov 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="scOIeuk4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btSZIxdp"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355C11CA9;
	Thu, 14 Nov 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545814; cv=none; b=Ca6Q0W12BNbYLw4Fx1O4hMogkdXyC9XE0JUw9eYcQZXZuooEBjUBr5oJFe17e7BNIIK6J8YVkJVFiU8c9GgRjdTVRdxEZjef0MkasTz5oFXnqxaifeBfUrU4BJ858SjAWl3uhq3kNAxR5CjbjBmyayNXBuMvqOnO4xcSS0Rj8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545814; c=relaxed/simple;
	bh=8CTpy5XgifioLxP6Qh2pZMdAV+qTvmOjPzrz8vkW2EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kD45vIzSL3+uQgylqzg39A4B/ax0gJM8aizFzeztYt4wOIEenS/zyrPiyhYOG98vpsoWme/suFXFdxkByQ6RjAhvKGl9etg4rIdVTvARwBwceH/p0QvGla7Gpgbp9xwqQh8Lm+vk3CNUEzRWWQ1gSoXOZCcFoxJNTXLzLuUwj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=scOIeuk4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btSZIxdp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 896B52540213;
	Wed, 13 Nov 2024 19:56:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 13 Nov 2024 19:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731545811; x=
	1731632211; bh=Qhhi/RnmTfbZ+0bbwtUGV9mixNqBtZzvb7H9GH7C+oQ=; b=s
	cOIeuk4ZyEu9U0IkS/lb5IY/wLGHZ/tkbAV2HFAD5Xk1cA7jaEGm0FOzcyz7favm
	KLvvdohQjBIZVCMbrLFU9q4bH8YqzyBkmzOajaCI135mstti0FDdC7VSjkQcy2IU
	LvHr5t8JJPiiNdIFKD+pSPI+K3zBipEvtGAjYg/CcCjbfK3aM2QxabIFMkBHHWJD
	z8HI+gFrdOxlOzY3bb6KA35imq7VHAmpLPpdN+KcEhSUrP1kbnUweQj63ogGEi3q
	fTrvw4AuYe4lj8WUMnOGG1DR3tjRiavjlD5M17L291gJDfGivvI0bNKVah3WFhY+
	HAmKYYwFuoxTIhIpTmUeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731545811; x=1731632211; bh=Q
	hhi/RnmTfbZ+0bbwtUGV9mixNqBtZzvb7H9GH7C+oQ=; b=btSZIxdpCgm7NAB5k
	h+Kd1E9Ngh28dDbc7YBJ+thp5oMS2s1Gci3IUvQmuEaDuoyDsKYJp/cynPAPiDUK
	geNQvI3AZFFRHRInxqL+0fhnmghuy9v8FVlG7SgqWnNzG+UTSSqKzE8sQtg76R+D
	NniE60/2+2Afz8tCXrdoWY0q50/MdYCcYdgI+wXwpMpppvPGAYj9+jdR4pOPrtUF
	KPHnVuW7HcAWA8LsWD9AhnFxA4TnvCrGBZ3hgXWJicFT+VyG8z/bCx1/m+nYmM2O
	53OIBIt21V39/86JJAGIFZaggijq3lxfU0QQsY8+RzIzUlmYHOYW8fZTHvtRB9aD
	Cd/UA==
X-ME-Sender: <xms:00o1ZzrUAUJvlilAPzs1CYLEUNgac-eTwmWAiGJ7Pc9M5g8efSXrlg>
    <xme:00o1Z9qU4fgN5JkfVn06L1VoYYz6szieSJn1ZMle2Y-TpsnCXd1kYi9fDSgReLpGh
    ysY8xxIMUU_XuWgej4>
X-ME-Received: <xmr:00o1ZwOVIOA6GVMJ9MYXrV632C3Tp0WK276unF6BOlCtozefyT-83O8IlTMUlv4p4eEnzQW1KP9d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeu
    jeffuefguedvteekveejjeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdv
    fedrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepsg
    hoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehklhhovghn
    khdruggvvhdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishes
    figutgdrtghomh
X-ME-Proxy: <xmx:00o1Z26QZ_Fyd5sp6mGr0qwOhbAwkGKw5IKv5L7q49D-qibAl972IQ>
    <xmx:00o1Zy4Xh5rp1PAZp9IXE1wSDi6gzPCkUihpdMnz6mxeh4tbsdYGjw>
    <xmx:00o1Z-jOpu1KqgNI6BUI3cFGhUdYY7nOQbqWHsXz4fY2L7EyBt_WNg>
    <xmx:00o1Z04aaG4O74OlS5KXg3tZAjE0N5hCG_eddAAb47szpedA9GnsXg>
    <xmx:00o1Z-pMO2tgc_8f5-FZvNixmRW7Idzakq2OTmoyW9eZzpw3pW2NwFa3>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:56:46 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	me@kloenk.dev,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v4 02/11] rust: helpers: Remove blk helper
Date: Thu, 14 Nov 2024 10:56:22 +1000
Message-ID: <20241114005631.818440-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me>
References: <20241114005631.818440-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 rust/bindgen_static_functions |  1 +
 rust/helpers/blk.c            | 14 --------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100644 rust/helpers/blk.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 1f24360daeb3..42e45ce34221 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -4,3 +4,4 @@
 --blocklist-type '.*'
 
 --allowlist-function blk_mq_rq_to_pdu
+--allowlist-function blk_mq_rq_from_pdu
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
deleted file mode 100644
index cc9f4e6a2d23..000000000000
--- a/rust/helpers/blk.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/blk-mq.h>
-#include <linux/blkdev.h>
-
-void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
-{
-	return blk_mq_rq_to_pdu(rq);
-}
-
-struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
-{
-	return blk_mq_rq_from_pdu(pdu);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 20a0c69d5cc7..426b0d7f6587 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,7 +7,6 @@
  * Sorted alphabetically.
  */
 
-#include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-- 
2.47.0


