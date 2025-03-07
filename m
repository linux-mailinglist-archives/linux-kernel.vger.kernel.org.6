Return-Path: <linux-kernel+bounces-551141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B807EA5689B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7313B716D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C021A945;
	Fri,  7 Mar 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK0D/Sbz"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA98219A9F;
	Fri,  7 Mar 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353279; cv=none; b=FVogJhKPNaMjq57g3aQyUgG4lldbc5wFGuJ+KaNBlJ6jfQd+j0DVRMY+GTleypphBweDMc7v+5qnEmMfgMtrTHR1rwnpflUT4Jrmg1KrCSIB6BWnXqANGEIi9SreQA81X19SlxZ9M7DfpjqTXcI2/LlN21NtZOMhgWR0maXiTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353279; c=relaxed/simple;
	bh=hA+AL+YkmFHDqEOTVvDJnon/Dsjcg3uYfNOntsX5TuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csbzFLDcAP9JXHbs09ZmffS5YHQAOIKdjepZlO0Y3vrxUagbZQqtY+jhd9kyL2kc9aePk4Y7HP/TTniyjly8D8Lj0EH1IynQCMsHKhmWUCqRvOIlwF0vI7G+DDesOxrdpyD+zTNFJ244Hjiuiw6HskGBz86h6iqMR/k1gz+v12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK0D/Sbz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feae794508so2886956a91.0;
        Fri, 07 Mar 2025 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741353278; x=1741958078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muSHbuLdeyMAAgXAmJf/8jxjECvkvJugZR3BtpEzTko=;
        b=DK0D/Sbz4pBBkKSke71zIKT3nZJSwtgGphQZjPcZn+vtpS5IH0p0NUAHm7ASO9f3Qt
         IgkI2xKhqUDqzalz9ETbzwQZqtCgbXvC2RqKfR1HG7HjIop5qwRp5nR5cjoX2pGU6hsJ
         sDAUXBw1ARh/mlx0SrNRfBHY5+SfdEop5ahDl/eBOTQwZ64h5Sw3DXiv4dnY6BKNXcSG
         vTynj2va6OOAiXIQQtePSgK/h/lWup+Ae2TVxBkYsRkjlQdsKsI4FmCI+mwFoNP6Un6K
         DHHagosB9nwOcruhjO3Y03FkFTZcW6y8/kAbetl7KUu8zywWCsXWPX8GmheGCe8oFMc5
         A/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353278; x=1741958078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muSHbuLdeyMAAgXAmJf/8jxjECvkvJugZR3BtpEzTko=;
        b=Z2bKDaT54wGYV1f9J9+hTAPsr2LrWej2QM/I/rP2wNGaWwzVTcVf0wgfQnLM8dj9Gy
         mTMd42ljtfYX3E0xLuU1emsSFbrEUKRNk+PwYBoQXUsWmxpTWQlcF5n0maoGp1bBtTXG
         ad+s+4qNo04p4K578Ixf7sobbdEDuBqX/hbc6To0dioMJblq/u04k6sOezGWnLfEMguc
         lHgRKckHCgRKqxSzbnT3KxHiBAla9HgWfMmCSKGyHzwNncKQD0wfwYCnjnNoJDvfBxum
         m4AYSHB6ORzI1SZ/ycYfmT6czE+hn1M9UTc8UYELT7Cb6T2gPQbiZwnD+2v/7XPEJMFJ
         T/MA==
X-Forwarded-Encrypted: i=1; AJvYcCVDwnU5Z6/gVTs8FkqviGlzMop4XmyV3OUlVs1dy9I1rTeiKHl+x94Pf+VAyznaq/d/J6eiMPiewiJ6t3Q=@vger.kernel.org, AJvYcCW4QA/C6CZyDRs2NTrh5NYjcCrxEr4oE+O8Cp8Dy+hX9fMFK+M4o8ew/hNhU0Plpve2hvzOr10ILFZNtqTUh8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY1g/5rnSWDZKKtJTQf2UJyeR9Zq+LslmpXL+wyIVj9G9HEWNw
	4VTub/Vt6jL7tIML+7yfXixae3hNkKdePl6kHo6quGjuhzx/nN2P
X-Gm-Gg: ASbGncvoerPLAypsLz5Q/YFhP9xtfe6vMxc4seECuDdNAZIvde2+IUh09ngGks53oxe
	1BJqS1R8uph3g1J20Kf9+fkawgFCX0pYJ1WyM38Q3EFMYctkt91E3/G6EWyw2XFyxtnduDHQe8T
	R6dmv1Qwy/3jQevB31iZKo0GZr1GzG5dwiaOEiOde5rsQa+Xy6cXRmK9BCxFsFWlm/84JN8+89a
	lCbediYR5FCbXLbPDEPuUYzyoHe/9xEz3RtyD7B/ar2apNnrjvT4gy+heNlvYgd7d2LhJRguMbB
	0L4ioRoW0mgRjixzsqJNCWc0kw0eLDbTCezTGrzSJtX8IzV/CgXS
X-Google-Smtp-Source: AGHT+IEuVDheS/PgY4zMtBCT8cOnbvLwD3uZygFM/gwL/DgIFzONORW+D14zMmS34sMmJYmGxOwSeA==
X-Received: by 2002:a17:90b:4ac9:b0:2ff:7031:e380 with SMTP id 98e67ed59e1d1-2ff7ce6cc5amr5499584a91.10.1741353277608;
        Fri, 07 Mar 2025 05:14:37 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e7358sm2965708a91.30.2025.03.07.05.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:14:37 -0800 (PST)
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
	walmeida@microsoft.com,
	charmitro@posteo.net
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 2/2] checkpatch: check format of Vec<String> in modules
Date: Fri,  7 Mar 2025 10:14:01 -0300
Message-Id: <20250307131401.638820-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307131401.638820-1-trintaeoitogc@gmail.com>
References: <20250307131401.638820-1-trintaeoitogc@gmail.com>
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

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 scripts/checkpatch.pl | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..7c42c1a0ea6b 100755
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
@@ -3567,6 +3573,67 @@ sub process {
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
+		if (!$expected_spaces && (!$add_line && $key && !$inline)) {
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
+				     "Prefer declare ] on the same line\n" . $herevet);
+			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after the last value and before ]\n" . $herevet);
+			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after [\n" . $herevet);
+			}
+
+			if ($line =~ /^\+\s*([\t ]+)(\S)/) {
+				$spaces = $1;
+				$herevet_space_add = $herevet;
+			}
+		}
+
+		if ($expected_spaces && $spaces) {
+			if (length($spaces) != length($expected_spaces)) {
+				WARN("ARRAY_MODULE_MACRO",
+					 "Prefer a align parameters\n" . $herevet_space_add);
+			}
+
+			$spaces = undef;
+		}
+
+		#END OF ANALYZE FIELD
+		if ($line =~ /\]/) {
+			delete $array_parse_module{$key};
+			$expected_spaces = undef;
+		}
+
 #trailing whitespace
 		if ($line =~ /^\+.*\015/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
-- 
2.34.1


