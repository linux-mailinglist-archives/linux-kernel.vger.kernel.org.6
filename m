Return-Path: <linux-kernel+bounces-174275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2078C0C67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B22928328A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8F0149C70;
	Thu,  9 May 2024 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AtomZZJr"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75014A615
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242703; cv=none; b=bwDWN9t8Y6nUrOX7tALCiwgu58vAL9s5U2r4c9poeYc75MQW8DCdXD7rT3kXgLn62cn4IlojVts+V7Ne/lIWicWi78oVuhLSvuyY6ZCf0eB6H1FP/CevYQYuM8/IYay+CGg1h0zsN1msdtjEvp2eQJ+fKr04LlPYJbMvOA42mP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242703; c=relaxed/simple;
	bh=yrptH+DQbXiAHa8Z83G/22BB8xjASWlh1dPOd3PH4Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=i9v5NNUW775ntf+ZgkhcybQn1xinUjghg9nbAt4DlPUifmZN/hrqE0i643pJ9z6ApEvD0lGDXT0OfGjLt+AE9nHFP7fKzHvxpvjoHuqcqfiegpIQ+L6EZhIU+49wg0YzME7d6G31+JG8LtFRoQCxsitDcjQwd2mjhEcgUqeG4gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AtomZZJr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3B1BFF805;
	Thu,  9 May 2024 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715242682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HckJMNZywGJU3Fu+i/HC7yiULXqjL8S2dKNsB+4J6zU=;
	b=AtomZZJrzwmBZuNKXLzfkY7bjA1fpXfF3kyPZSOcHm30JOaDlrC5WdALR2IpPe0WyUrts+
	bUp0SOlIQV1t4eZJtL5faAsTnNNYtHfzC2v3oW0IPR/aLN/XbZG7081Oj5KFgjLQ5/05Bg
	qwsY7xFu4ZdF5BjHXn/Jg2SYMwWn89RHxsDSvXY0+auaJoeDSbMCZ3zk2xk+bPwdvdW/pP
	q94q/xnqqRCK73yZTorZ6EVNy/50Szq/2UEomZO8R8USqVKq25IGiCs38E9dUt+oAjwZFz
	rFasM6vd8qWW+wjfuP+O9lwiBQp+371SnPo2ICSEfzTg0HxbE0twIMijDktSlQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 May 2024 10:17:23 +0200
Subject: [PATCH v2 3/3] scripts/decode_stacktrace.sh: add '-h' flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-decode_stacktrace-find_module-improvements-v2-3-887fb6d5acb9@bootlin.com>
References: <20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com>
In-Reply-To: <20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
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


