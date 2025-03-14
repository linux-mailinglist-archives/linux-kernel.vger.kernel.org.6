Return-Path: <linux-kernel+bounces-561985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A105DA619D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD461462B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1FE2046BB;
	Fri, 14 Mar 2025 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyzJoHi9"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DF1FF601
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978263; cv=none; b=OtpednPtnyfsLcsGQeEnQQbAn+SOOG8cJ7CtYRJd5HF9Hx2cokyG3e1+HgxeownvWDF1LgwMVbXlAb58sS2WcM11Rjps3q/Zp8jG5XO/Eo3f3WyhMVz9pE20zuvZM4MdPsoVIh8zWrBr/d/AZxbkiOdY5fKqEZryVNocLScrCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978263; c=relaxed/simple;
	bh=biTMhZyqbSZ5OpjoUKkXxxrQGtvdeJJW2CqyCCdcrPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p1DTkU7n1WcaFhfrPaX/vbURb7SV2MUOlnWdAQoGvoGebu+VHYEJs+hsYy1vgBrwdYIH3fbGp5ZEJZN4hFS/RogLKSiWfuUkB32KOg/V1MrWvwfgCdm4+hVFxo+devJ4ifU09xs/dUJfYshcnudxF4kPGfjiLJv9eioKVp1rFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyzJoHi9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22403cbb47fso46256335ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741978261; x=1742583061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR1q/p4dv/c/p+PdWJis9Ue2zjgGhBL8/ljRGUVkwv0=;
        b=AyzJoHi90jr0i75VhzmODePM1772fZEsuPM/+kLBbt0m5usnCkJk+OBwur7fioPq+y
         ym1RrvYZbYmtfG4KXwzoXa1fTxVGRQarAUqEIedetfUTwyn3qR5XowjN0e1MzXll1/Fl
         RgBS9PDAuuYScmX+JPMAKyVeBi0Wd18fu02FT3/I46LQGYL9DEnsbs3LWjn/MRHcoL3p
         9pQ+W+POcrvUnZYZaVpHNSOYayPCIMatarJQsLnWtJUMATW2rrX6MysB0vRxoHqVd2To
         5l6IUvEjK0glQEvM5kYJxz/9zoSvJ7Agokzk9yuDLwEVqfG6GT2nYinTREmxaiBBzmEB
         nmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741978261; x=1742583061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR1q/p4dv/c/p+PdWJis9Ue2zjgGhBL8/ljRGUVkwv0=;
        b=FTsblKmUJSTveSav+mtPjEWfnGqm63sMDtmY3xBqGt65Wjbb+MbBqUQRyZlIsPXtmE
         1dZiiPGMXXaFxqRjoePiT1rmEML8nFRPdeO4Q8l405Kpwl6t9rJddcAmfZpsdgEq/abT
         pPJA0cFSBtAqZFxexb9+qR5LoCwWKqx1jVvC9hs3zDsuCnaJU8USNvd6O0wI9RfMPR+n
         XLcnumsK4GnXFak4unvPFGA/Hophd8MT/q5oKEjglD8lsdbyrrbOBwnPU7XzN2UDYjUX
         xe9nvoChPW+b9fEETLRpzUJfgYKwx1CdIbDeG369C2T7UZ9uNprHVNmaGC6Fzl4YsXBe
         L1Fg==
X-Gm-Message-State: AOJu0YydVHrul+uj0bF0l0Mo8L9IwSn89fqfJSkUehHhv1ZfTsg4+a5j
	QwClT3y8Yh+cmJCajz2aUHFesDqSX7MHl2s2xlhXmu0t/yxTyUN/
X-Gm-Gg: ASbGncvIUEW4YlHd4Mq2qGF+21Q3PHVZbxSsJ4FjQnobc2qolb45tl6Ga5Cmf8LJIOF
	1oD53joeroCkw6QdKR1+nrxkMhIZVeZ0/aKpMRTimP5y3gcSNjy/O5eCaXPyhlwb+zsCTCypipa
	oQqGPJZL8QFSWcCIkzDVi6VYvWQXTXbFGzh0/cnkOJ00b261k7F4X51iv2pst2u8pi4ZqQxi9sf
	gYXzufi4NXaJqBSUGjuNmxboCpEipObVYnGVZjd+32rRnR096JCmZ12RMYTLUXWRGDTNV5PXt9Z
	o0zqJDSaGFfUX0F5Y/xqVnSuGpwWaKyupU24/lQliKVCEMpOiy+5
X-Google-Smtp-Source: AGHT+IG4QFsTgyYvmWd6ggoZobed9wE7WmEtjhmxkW9qsuaaHrmco+HhfjePUaAOt9YnENLqT5jY3g==
X-Received: by 2002:a17:903:8d0:b0:215:acb3:3786 with SMTP id d9443c01a7336-225e0a754e6mr51556465ad.19.1741978261113;
        Fri, 14 Mar 2025 11:51:01 -0700 (PDT)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167e018sm3285703b3a.91.2025.03.14.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 11:51:00 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com
Cc: linux-kernel@vger.kernel.org,
	trintaeoitogc@gmail.com
Subject: [PATCH] checkpatch: check format of Vec<String> in modules
Date: Fri, 14 Mar 2025 15:50:52 -0300
Message-Id: <20250314185052.1126157-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a check to ensure that the author, firmware, and alias fields
of the module! macro are properly formatted.

* If the array contains more than one value, enforce vertical
  formatting.
* If the array contains only one value, it may be formatted on a single
  line
* If the array is not indentation aligned, enforce indentation alignment

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 scripts/checkpatch.pl | 77 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..3b8db30c6972 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2775,6 +2775,12 @@ sub process {
 	$realcnt = 0;
 	$linenr = 0;
 	$fixlinenr = -1;
+
+	my %array_parse_module;
+	my $expected_spaces;
+	my $spaces;
+	my $herevet_space_add;
+
 	foreach my $line (@lines) {
 		$linenr++;
 		$fixlinenr++;
@@ -2851,6 +2857,11 @@ sub process {
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
 			$in_commit_log = 0;
 			$found_file = 1;
+
+			%array_parse_module = ();
+			$expected_spaces = undef;
+			$spaces = undef;
+
 		} elsif ($line =~ /^\+\+\+\s+(\S+)/) {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
@@ -3567,6 +3578,72 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
+# check if the field is about author, firmware or alias from module! macro and find malformed arrays
+		my $inline = 0;
+		my $key = "";
+		my $add_line = $line =~ /^\+/;
+
+		if ($line =~ /\b(authors|alias|firmware)\s*:\s*\[/) {
+			$inline = 1;
+			$array_parse_module{$1} = 1;
+		}
+
+		my @keys = keys %array_parse_module;
+		if (@keys) {
+			$key = $keys[0];
+		}
+
+		if (!$expected_spaces && !$add_line && $key && !$inline) {
+			if ($line =~ /^([\t ]+)(\s)/) {
+				$expected_spaces = $1;
+			}
+		}
+
+		if ($add_line && $key) {
+			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
+
+			my $counter = () = $line =~ /"/g;
+			my $more_than_one = $counter > 2;
+			if ($more_than_one) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer each array element on a separate line\n". $herevet);
+			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =~ /"/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer to declare ] on the same line\n" . $herevet);
+			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after the last value and before ]\n" . $herevet);
+			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after [\n" . $herevet);
+			}
+
+			my $line_cmp = $line;
+			$line_cmp =~ s/\+/ /;
+			$spaces = -1;
+			if ($line_cmp =~ /^([\t ]+)(\s)/) {
+				$spaces = $1;
+			}
+
+			$herevet_space_add = $herevet;
+		}
+
+		if ($expected_spaces && $spaces) {
+			if ($spaces ne $expected_spaces) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer aligned parameters\n" . $herevet_space_add);
+			}
+
+			$spaces = undef;
+		}
+
+		#END OF ANALYZE FIELD
+		if ($line =~ /\]/) {
+			delete $array_parse_module{$key};
+			$expected_spaces = undef;
+			$spaces = undef;
+		}
+
 #trailing whitespace
 		if ($line =~ /^\+.*\015/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
-- 
2.34.1


