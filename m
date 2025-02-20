Return-Path: <linux-kernel+bounces-524203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8EBA3E07B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9EB317E01B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385FF20D4E2;
	Thu, 20 Feb 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYe2WYKU"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B841C3BE0;
	Thu, 20 Feb 2025 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068425; cv=none; b=hYPNc9malfd8T7y6zCwqEYbKmd0Em8Fq0ajYUnmGXc1GHgQZeXq/4W7ztaG3JfM+OHOz6YGB2VHQErF44U94UKY/MJWB5AMWBwRKblNNS7kwa2RZcF93veJzDveIFabD8TDW1iC10nJAoY1YiA4RD0xzPGHBtH+LZ3urlcUQKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068425; c=relaxed/simple;
	bh=guogj3y+P7Pi0BeCcNdzvEnqnzDhTZwGUnlfgQM1mLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVfcpBK74GwW+5WKlsUgYb9tacvJy/jwF8GbusZJzZ5EE/DAuLR9AGram4Ko81muc77iedgu2yk8G/YoroUjmshRv97LkF+dd2LVdHXGcmsO7daMJ7FQVuXwB4bh2CUZYZpLIKGajbTibkunC2HaIGFP8lc6RYYV7pvHfKuVuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYe2WYKU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220ec47991aso15620885ad.1;
        Thu, 20 Feb 2025 08:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740068423; x=1740673223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m35314KpzK46gpcYRFPo8w1pzpvFqAfLP65RS4pzhwc=;
        b=mYe2WYKUKBKEDttU0OluYs1C0FctLv+0ZeJkgGOq6vgapmYQoAQtyyhUM8dR+Td/2C
         xnuDln74hACIMryxRo9IE5ZykWOAiXzirgvAkgiCcPjTCHUlRJmUSxS1VydAPL9KTCC4
         B49kt+/PE2nC8FmsBdpViWl4y6xSYMkXQ1UlSnWGeiCpgkXMxnM0lW6lxIvtGLnyCflf
         KL2gKOyfn8Ae6wm9hks797dMQEladCJbyusOp0245vCCqAT76VaWOVllEw6zGVWZ/mpw
         LHL55yizRC7Q6DZQJKbEHqLtPQ8ZroN2tj79aPMN+x7RkUmHPHboR5QhKLD/LefaIpaf
         3tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068423; x=1740673223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m35314KpzK46gpcYRFPo8w1pzpvFqAfLP65RS4pzhwc=;
        b=gEGBnYyRWSpv6RRJXg7XUoZ++Ax0kjLKqaDGaQ9AhqL0WdFZ663YB93mlO2XF9BKFZ
         7qFq3Lpz7JLMKkHHoYAWBQ5TQS3eapDKlYlF6blg2o3fSVdkCQL5byvs/aiXsciIvjBp
         siANLRO0/TPlwbGwPUcQVIuwrpT/jTpbGMO7GmjC/2MgY1uOze+bXpRO/cK7ebGwIrYw
         N+t+Nz3ln1h8ZDqQ4QS6FVkDzhOmo87E+U2oW6HYo0s8k3mYk3mz2IvudKM4p7UjOem/
         gPZoxNlV7/NPV0vgSfuCxiMcS9G1bOAlmzuClHgX0VGPqyahRygkGTjUwpoQxg//MZw2
         hunw==
X-Forwarded-Encrypted: i=1; AJvYcCUG+adkXveGjCTWJvAsrj4BiLd+qjCe6BkYa4aVoSn8JnuSIBJ9Eh2UKUWZQstCu9XpDi6KYLMSfjs4rgE=@vger.kernel.org, AJvYcCXr2h+Yao/E5KOEN9UQGLXkod1zCNA/egIRYz10JeGRTKB5zwMg//tOZ6TobXi7RDX8VRcDlRzwLyGRPXC4VZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsmRxe2jwPTy5Za0a5wRM6AY3ep8iAT+5kAJ8G5VIh1CZ0Lrs2
	cYuRQ6A5ahlibWxhlAYpud20Gu2ZA846/7EENWbpxxmtisn0K81Nr52uL743
X-Gm-Gg: ASbGncvITExozqzuqFSILcR4QTo7tYcoc7Gz29Ydux07Ooj3diqToGziz8gZJONbg/4
	5B0+0yDN+O4etJQ0YogEBGDoG5in1eDNhH1xZB5pmkzqJ97M/8n4DNbjNDcDOVpQsLZFNT4g9iH
	fHSQDVrqCa0EIRXqOkPW7Z/mO2nsBHEW0RGy0ntFdTuzSV17ZNfHGr+oYtG2RjJlApK53GrLXxU
	lQC8wYqVMfYM/KTemaQ6eSQu56zbyO1WeoHRAcMw5Bw/kvb0Dkf78kYlxBOsWmwAWs5zA7syb/P
	BwU2U1aQ/NKp/Va1WauERQs=
X-Google-Smtp-Source: AGHT+IHmSIiGta3r3CZMbfAGsZelk/nWOw+xjsGTGZkfR+siWKpKItpXaxt9bzaRT/MhG2oMGz91fQ==
X-Received: by 2002:a17:902:d50d:b0:21f:bd66:cafa with SMTP id d9443c01a7336-22170968ad1mr128803405ad.17.1740068423004;
        Thu, 20 Feb 2025 08:20:23 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a540aasm120910545ad.245.2025.02.20.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:20:22 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	tmgross@umich.edu,
	walmeida@microsoft.com
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] checkpatch: throw error for malformed arrays
Date: Thu, 20 Feb 2025 13:19:51 -0300
Message-Id: <20250220161951.844367-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220161951.844367-1-trintaeoitogc@gmail.com>
References: <20250220161951.844367-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a check to ensure these fields are correctly formatted. If a
line contains one of these keys that should be of type Vec<String>, use
a regex to verify whether the array holds multiple values.
* If the array contains more than one value, enforce vertical formatting
* If the array has only one value, it can remain on the same line

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 scripts/checkpatch.pl | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..1133fe68054b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2775,6 +2775,9 @@ sub process {
 	$realcnt = 0;
 	$linenr = 0;
 	$fixlinenr = -1;
+
+	my %array_parse_module;
+
 	foreach my $line (@lines) {
 		$linenr++;
 		$fixlinenr++;
@@ -3567,6 +3570,46 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
+# check if arrays has more than one value in the same line
+		my $inline = 0;
+		my $key = "";
+		my $add_line = $line =~ /^\+/;
+
+		if ($line =~ /\s*.*\b(author|alias|firmware)\s*:\s*\[/) {
+			$inline = 1;
+			$array_parse_module{$1} = 1;
+		}
+
+		my @keys = keys %array_parse_module;
+		if (@keys) {
+			$key = $keys[0];
+		}
+
+		if ($add_line && $key) {
+			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
+
+			my $counter = () = $line =~ /"/g;
+			my $more_than_one = $counter > 2;
+			if ($more_than_one) {
+				WARN("ARRAY_MODULE_MACRO",
+                     "Prefer a single-line value$herevet");
+			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =~ /"/) {
+				WARN("ARRAY_MODULE_MACRO",
+                     "Prefer declare ] on the same line$herevet");
+			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
+				WARN("ARRAY_MODULE_MACRO",
+                     "Prefer a new line after the last value and before ]$herevet");
+			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
+				WARN("ARRAY_MODULE_MACRO",
+                     "Prefer a new line after [$herevet");
+			}
+		}
+
+		#END OF ANALYZE FIELD
+		if ($line =~ /\]/) {
+			delete $array_parse_module{$key};
+		}
+
 #trailing whitespace
 		if ($line =~ /^\+.*\015/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
-- 
2.34.1


