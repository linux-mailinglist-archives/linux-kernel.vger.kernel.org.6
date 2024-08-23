Return-Path: <linux-kernel+bounces-298493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7907695C80E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039E8B25A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895CF149C50;
	Fri, 23 Aug 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nkM8VrHE"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B301428E8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401683; cv=none; b=AKNzXH0wk0f9mlyOPgQDrPE6Yke2nhi6LydyQ7cd9JFoxYOAF5rRU0xKbIJNmkP77Jp5EJv9polQHBlWuUT4xGg9QJN8nmeLy1Rjoyj2JU0h0/n4cXl5syvETDiv5h4fp3ruLo4Mf+m6ndBAmgwotFhP+XozUUHliBLqjrGWpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401683; c=relaxed/simple;
	bh=yrptH+DQbXiAHa8Z83G/22BB8xjASWlh1dPOd3PH4Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=VdYjYE2K83LWIAVsnCSCkztahwruoel4hhOzuTGiQCUFnekI/QKXrRwr4Eypn2lqsGczqMRF+coDPEOqsCOBZvs+Cg7zBZDAd9xuMMndv7ht2aNqJl2CUBJ2r/Ud5UxKNGAh76imLo6XoU8z2ehN2bMSqxbu/Tegv5+/HMKJG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nkM8VrHE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 66B296000B;
	Fri, 23 Aug 2024 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724401680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HckJMNZywGJU3Fu+i/HC7yiULXqjL8S2dKNsB+4J6zU=;
	b=nkM8VrHEq2VoPSgWrJ5aB8Jv7XcDHl4CD48svLlqUI+Yb1fSXgDGatGOIGEFOaZQG6JBsk
	GZFXIiREd+Tov6Fgdmwc3ToK8FRppG6Czu1ZZeibR5Ttwh7p0dY3gCUNUcrdbnVjlWlZdI
	5xZa9VNxfPtUD5up4/6EVrofb9wAmRb6OWTGne/si1MANRZdoyxlPwyvw0lyVixt1X7MYQ
	+hNIodKAusYKd4a70T+wk4Q/NpzIeNNPAtbyj5ZdN7ZejfblNTwU4IpTVG+iBXlLzKybbZ
	bUBhQM+YordWM1Tx1UZUG80JT52FnGOuIQLtVlxWAS24xI0/z3hi+lqhGpYryQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 23 Aug 2024 10:27:44 +0200
Subject: [PATCH RESEND v2 3/3] scripts/decode_stacktrace.sh: add '-h' flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-decode_stacktrace-find_module-improvements-v2-3-d7a57d35558b@bootlin.com>
References: <20240823-decode_stacktrace-find_module-improvements-v2-0-d7a57d35558b@bootlin.com>
In-Reply-To: <20240823-decode_stacktrace-find_module-improvements-v2-0-d7a57d35558b@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.1
X-GND-Sasl: luca.ceresoli@bootlin.com

When no parameters are passed, the usage instructions are presented only
when debuginfod-find is not found. This makes sense because with debuginfod
none of the positional parameters are needed. However it means that users
having debuginfod-find installed will have no chance of reading the usage
text without opening the file.

Many programs have a '-h' flag to get the usage, so add such a flag.
Invoking 'scripts/decode_stacktrace.sh -h' will now show the usage text and
exit.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 scripts/decode_stacktrace.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index b56e79060e9f..e8c9976062d0 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -7,6 +7,7 @@ usage() {
 	echo "Usage:"
 	echo "	$0 -r <release>"
 	echo "	$0 [<vmlinux> [<base_path>|auto [<modules_path>]]]"
+	echo "	$0 -h"
 }
 
 # Try to find a Rust demangler
@@ -32,7 +33,10 @@ fi
 READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
 ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
 
-if [[ $1 == "-r" ]] ; then
+if [[ $1 == "-h" ]] ; then
+	usage
+	exit 0
+elif [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
 	modpath=""

-- 
2.34.1


