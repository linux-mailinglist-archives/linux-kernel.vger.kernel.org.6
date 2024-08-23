Return-Path: <linux-kernel+bounces-299363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B255595D3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E441C23555
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BB18BC06;
	Fri, 23 Aug 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLzAZCMr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143D12B6C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724431146; cv=none; b=E7tzHv1mSVEXj/8J6Wa+ultWQjInwfDQyq7PkauqH5xzle7gj3mMRO9g80Yw9bRAHLcqn1WWpQxcuPebpOltriQ58LoijgvuQiI+WYEMV3IkKU+Ub+82anMvFOrLc2YQ1anczZ3BXK3HfxGbj9RLMJt64GmCR0Yz0PRODBhEgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724431146; c=relaxed/simple;
	bh=3p8llYLNGonqe/IaVeJEcH5mcj6ObfdWOb687aPPufY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rw5sQQUCAvTmh2x+aoyeMA/Y+w8KpJiDFO22E3fsfu1GHuxz78OEqkBj6DjgJNqtd2xDYNx8fbY8izrqNzsACCTCELJtufuSqPaYLi2ZopUqOkv3GFEmOhbTEbRC6VPsVFX1uAT2yiagy6qyYV5UyiU4Co+IAVwp3sD2WM23E7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLzAZCMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71EBC32786;
	Fri, 23 Aug 2024 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724431145;
	bh=3p8llYLNGonqe/IaVeJEcH5mcj6ObfdWOb687aPPufY=;
	h=From:To:Cc:Subject:Date:From;
	b=gLzAZCMr758Wfe7rerx8L/j7HBp9WuiLFR2vp6//h1SNLXunTnx6ZMmW6yzHUPRjq
	 fAruazKxC4HfkFYAJm0zGC7aFZCn1+N4YVc/UKd29QWzFNVs/z7uWxpPIc4yYBCfus
	 rcWi77/LJDLfGbLjlTV8LxxCIgGQRJi28YoQXwUfn7xDzIiyYW1D+DZyWP5iQfiC74
	 q6mUzs+1hVDNGQSaLuK7bQ+EHVOVd16GSPEkBX1JsbAZdPF025yDvNTgn4IA9c1ksI
	 A0L3WwKEvwkjAXKu6eBy/8RKVbQGAyBK12Y95dC8I2JE1w1FoxWXvmJQinZmfJF8iE
	 5CResWhSOrOsQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1shXJX-006KwE-Dn;
	Fri, 23 Aug 2024 17:39:03 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] scripts: Fix gfp-translate after ___GFP_*_BITS conversion to an enum
Date: Fri, 23 Aug 2024 17:38:50 +0100
Message-Id: <20240823163850.3791201-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, richard@nod.at, akpm@linux-foundation.org, petr@tesarici.cz, surenb@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Richard reports that since 772dd0342727c ("mm: enumerate all gfp flags"),
gfp-translate is broken, as the bit numbers are implicit, leaving
the shell script unable to extract them. Even more, some bits are now at
a variable location, making it double extra hard to parse using a simple
shell script.

Use a brute-force approach to the problem by generating a small C stub
that will use the enum to dump the interesting bits.

As an added bonus, we are now able to identify invalid bits for
a given configuration. As an added drawback, we cannot parse include
files that predate this change anymore. Tough luck.

Fixes: 772dd0342727c ("mm: enumerate all gfp flags")
Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Tesařík <petr@tesarici.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 scripts/gfp-translate | 66 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/scripts/gfp-translate b/scripts/gfp-translate
index 6c9aed17cf56..8385ae0d5af9 100755
--- a/scripts/gfp-translate
+++ b/scripts/gfp-translate
@@ -62,25 +62,57 @@ if [ "$GFPMASK" = "none" ]; then
 fi
 
 # Extract GFP flags from the kernel source
-TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
-grep -q ___GFP $SOURCE/include/linux/gfp_types.h
-if [ $? -eq 0 ]; then
-	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
-else
-	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
-fi
+TMPFILE=`mktemp -t gfptranslate-XXXXXX.c` || exit 1
 
-# Parse the flags
-IFS="
-"
 echo Source: $SOURCE
 echo Parsing: $GFPMASK
-for LINE in `cat $TMPFILE`; do
-	MASK=`echo $LINE | awk '{print $3}'`
-	if [ $(($GFPMASK&$MASK)) -ne 0 ]; then
-		echo $LINE
-	fi
-done
 
-rm -f $TMPFILE
+(
+    cat <<EOF
+#include <stdint.h>
+#include <stdio.h>
+
+// Try to fool compiler.h into not including extra stuff
+#define __ASSEMBLY__	1
+
+#include <generated/autoconf.h>
+#include <linux/gfp_types.h>
+
+static const char *masks[] = {
+EOF
+
+    sed -nEe 's/^[[:space:]]+(___GFP_.*)_BIT,.*$/\1/p' $SOURCE/include/linux/gfp_types.h |
+	while read b; do
+	    cat <<EOF
+#if defined($b) && ($b > 0)
+	[${b}_BIT]	= "$b",
+#endif
+EOF
+	done
+
+    cat <<EOF
+};
+
+int main(int argc, char *argv[])
+{
+	unsigned long long mask = $GFPMASK;
+
+	for (int i = 0; i < sizeof(mask) * 8; i++) {
+		unsigned long long bit = 1ULL << i;
+		if (mask & bit)
+			printf("\t%-25s0x%llx\n",
+			       (i < ___GFP_LAST_BIT && masks[i]) ?
+					masks[i] : "*** INVALID ***",
+			       bit);
+	}
+
+	return 0;
+}
+EOF
+) > $TMPFILE
+
+${CC:-gcc} -Wall -o ${TMPFILE}.bin -I $SOURCE/include $TMPFILE && ${TMPFILE}.bin
+
+rm -f $TMPFILE ${TMPFILE}.bin
+
 exit 0
-- 
2.39.2


