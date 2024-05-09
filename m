Return-Path: <linux-kernel+bounces-174274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967F88C0C66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0DC2829A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698BF14A4C3;
	Thu,  9 May 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y9DsulsY"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8F14A4DB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242700; cv=none; b=PySJd+m/ZzaF2IEPirkf7YmJuA27JkiFne4oRBFicmTp/PSUYFgNlP1tqO9Iw9702JwH/wTBEtkkQ6PNrbuDeKzmySWcnMJeZOsQGGPZcOY9Ke9RFCbvLc3qKZ344iVFbx2A5KMHTDcECorHnAxZgthNr+ZqM3MX/FZ0A97ZUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242700; c=relaxed/simple;
	bh=WWkRZNcU1ZOfKgeuPdomK3ItRurd92AN6Edqxlu76Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=OqBMnCFv0Njjp0q0M0ugj+DlNf8RuuwP9cgRnbqolKtWJYjeL0g+QBZ/dnF8DYymkvnMOGQIg/8iDdru/7GWIrrLODRCP5nP24n2ilzycGThmIkjnSAdBQL/tayB35BOTPLyE8XEnJuXh3qt15D0wyVDBLauvTyUzUk4/omFmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y9DsulsY; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09CB1FF807;
	Thu,  9 May 2024 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715242681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnhTHq3+chm+k9TwdAZbwwShRi/4O5m2qm/IN/fZxRo=;
	b=Y9DsulsYAveM94mSWZN47X1XoH5C1n1CSExouwEBREvufNAhxzxfjJc+g7MDhvpB1Nh3Ue
	Fda/NykOsZ+IrF5ZI3dzPZfXaCa+Om+Qydmk/T1U08zk6pAgBbDvVs/vEpTGOEjLMDel+o
	S96U0XpwRwMcNgVVSotTrQs9Lx2gkZieIWbZrxwPz3zTz9YyAqsQnnNN7FirFcC7A4kxEY
	+VZlt9ooeL5kDglSH4LB7ndy/W6tGauQbSTbgbJkD2JR+z49fBX1WJ40diqsEUzfdDLjwe
	0WI/kugf8r6uhlbX/TQJ6fR2+l/UkWDzUr/sfr45OsvJsSA4vhlBzznc0bMovQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 May 2024 10:17:22 +0200
Subject: [PATCH v2 2/3] scripts/decode_stacktrace.sh: clarify command line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-decode_stacktrace-find_module-improvements-v2-2-887fb6d5acb9@bootlin.com>
References: <20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com>
In-Reply-To: <20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The syntax as expressed by usage() is not entirely correct: "<modules
path>" cannot be passed without "<base path>|auto". Additionally human
reading of this syntax can be subject to misunderstanding due the mixture
of '|' and '[]'.

Improve readability in various ways:
 * rewrite using two lines for the two allowed usages
 * add square brackets around "<vmlinux>" as it is optional when using
   debuginfod-find
 * move "<modules path>" to inside the square brackets of the 2nd
   positional parameter
 * use underscores instead of spaces in <...> strings

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 scripts/decode_stacktrace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 7f3fb5e82707..b56e79060e9f 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -5,7 +5,8 @@
 
 usage() {
 	echo "Usage:"
-	echo "	$0 -r <release> | <vmlinux> [<base path>|auto] [<modules path>]"
+	echo "	$0 -r <release>"
+	echo "	$0 [<vmlinux> [<base_path>|auto [<modules_path>]]]"
 }
 
 # Try to find a Rust demangler

-- 
2.34.1


