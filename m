Return-Path: <linux-kernel+bounces-276927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB491949A26
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302451F22709
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A717B518;
	Tue,  6 Aug 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxgg0Hu7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D717B421
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979321; cv=none; b=Hz1z+19HBXmedGjwsKWTdfGmDuV/ZfR3qFQAKb1vDBFib76lKri5S0dV1c1ePx/YRy85xyyqdhelFvrOsVL4VIpC+k8Au5Q5K/T1w+NckECQ5je190j9OO1gu7LCPMPndwMZFPwcCcOzJ5jA7YGfRZmCGxuVim7tzOLv0cSB/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979321; c=relaxed/simple;
	bh=PeHGueIu6A9NDir1Q16OtEIXpu5W9OAUxaQCN3XQaIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aAnE9G+rTa1U7xdIOFOXggy4Ntp0uUJSNhJGnjHewfwvMgnmlnyOfDeWnieQDKeCDNYlmW/v2WFqPJ3+yfU0PlLPoofexOzyuJg4Irea4/9K8yyQpC8CfGs6rlEwZINvkmCMKY4eorAE3O8V7qq45/JSuYBasPCxNM1fuT0BQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxgg0Hu7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e08bc29c584so1919929276.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979319; x=1723584119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIxM7MXS5ywuKBbdk2V16TlFyqzq6A34Xp135s0mvWo=;
        b=qxgg0Hu7sCqA3arWhzLzlYxRlNU63s2V1Me+wEanYEvTTp+cAdFIIYhRCWgXn2q/O1
         SEkNhC2NI2tns89LRwhBTNff4/jZ4Ypm4PF549l2sGj0bqHGawQDdVg5+GV0tN+z16WR
         EOeHY2G+L4sGqlGm96q3122AS9U99i3FYBi6J2Mg7QJc1G1HBoflWcYw8Q6P4yuHeHnC
         Ct3fyHeLjK3p2N+pc5C6/eXYTGujISmCJ+mPbO5vK9Ct8lXwQXfIiP4du5w4M1nQ17oE
         UxH5/Wev08Cn6SttKsJAVq8lFGMpzJe9rCeDbufby+/h0IthFl4UPojOlN0GHwkq8jvZ
         y6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979319; x=1723584119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIxM7MXS5ywuKBbdk2V16TlFyqzq6A34Xp135s0mvWo=;
        b=cwRq7RokjOk3NfxhbVQZILOpCyi7gRZ7aFef2KaOyeuGrO39bnBq1OcAKq6GhlDEcG
         rIpeVmIQ+9JFzzszqQe25cNraC0v6FnXYV0sXpTp7ATD/FPc/9lCgvV29/Npzo/SarFb
         4TNr4MZupdlzkgn440f/TJVJmFSGVm5/1xBx5xthEIC13E9ck2oDxI6/L6/7nb2KvGcm
         chDY54IyztOJRK607cLvj1GVLENDlu6Hxc/FnajGWD2lufVbVfSZ1GYzsaHouz48tWO5
         lQY/34zXfLfmYppriwCpOaWCkBqIfAJvVi/rne3wZxs18Bgr31HjhwsOV5xpfzyfWvt/
         gm0w==
X-Forwarded-Encrypted: i=1; AJvYcCW7f7LHC/lKqKLJWwNayBM72sQNxTiKeLJ1q+OzPUqZqKsqPIMJxhqjlKWJOzC3kEc2iui+yO635LYSC38sl4NWbVhe8sfA+BnEh6OM
X-Gm-Message-State: AOJu0YxL/cPCOXUTa5dcDtmmJ2T/M/fA66/I5bU1Msz+o28i3iJbafCg
	56tHb03iqeGBwMK1fmdRIxAesnVEPm/zq/OCHe2+a4ATrPcuRHW8qnsypWDU0v7Q+RgUHcQQvVj
	w9bjpNA==
X-Google-Smtp-Source: AGHT+IE/dOY4BBF0bOHl2trWuq/uURBgtWdSBnMlFtpxYXnDrUIM7aP+OZNSkdR90xgdGT6ytbLkJI0RlN0q
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:1241:b0:e03:3cfa:1aa7 with SMTP
 id 3f1490d57ef6-e0bde1e9203mr23531276.1.1722979318983; Tue, 06 Aug 2024
 14:21:58 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:42 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-17-mmaurer@google.com>
Subject: [PATCH v3 16/16] export_report: Use new version info format
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Matthew Maurer <mmaurer@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

The new version info format has a superset of symbols in the old format.
Since this is a tool for in-tree modules, we don't need to parse the old
one with this tool any longer.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index dcef915405f3..6a37df6f947f 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -114,31 +114,29 @@ foreach my $thismod (@allcfiles) {
 	}
 
 	my $state=0;
+	# State map:
+	# 0 - Looking for names
+	# 1 - Scanning names
+	# 2 - Done
 	while ( <$module> ) {
 		chomp;
 		if ($state == 0) {
-			$state = 1 if ($_ =~ /static const struct modversion_info/);
+			$state = 1 if ($_ =~ /__used __section\("__version_ext_names"\)/);
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
-			next;
-		}
-		if ($state == 2) {
-			if ( $_ =~ /};/ ) {
-				$state = 3;
-				next;
-			}
-			if ( $_ !~ /0x[0-9a-f]+,/ ) {
+			if ( $_ =~ /;/ ) {
+				$state = 2;
 				next;
 			}
-			my $sym = (split /([,"])/,)[4];
+			$_ =~ /"(.*)\\0"/;
+			my $sym = $1;
 			my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
 			$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 3) {
+	if ($state != 2) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.46.0.rc2.264.g509ed76dc8-goog


