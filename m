Return-Path: <linux-kernel+bounces-527531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1777FA40C5D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE8D3A9223
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99BB666;
	Sun, 23 Feb 2025 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCfajinI"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E6134AB;
	Sun, 23 Feb 2025 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740270110; cv=none; b=l/uX2XDgG5eeNQ9jIiHapJu31cjIBivWcJO3F7FMbCxyMQbNzT12ywykRtILy/PQurtjs1cjStSfP8USdpD88V4IDx8gVHBvQtpl1XgB+AWyCb8HRJtGlfNJtlCaEZ8dLkALwB2Bba4vqFRt2wqjb3uZz2m7+BQ+DGjXbzg9RB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740270110; c=relaxed/simple;
	bh=aIQF0VjJbSXHZ72DQimlTtZ6Pmme+Na10sdPJDlgdK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2WNyBPJ5A9OznkxpcOdDZb3rjHmYTJNQQti7K2wuofVbwYC5PgA3i7YQNt7RWkqtwtRVjtPtM5OhuIoJxi/WQ+JvWSYlXdJkJEWkGcBW4UawL6qs3I4OoIKiRnOI6sBzYbRhCxobGdHMjTVmM95MFHtaLB/zpg/qC7DeJzhBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCfajinI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c8f38febso69546065ad.2;
        Sat, 22 Feb 2025 16:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740270108; x=1740874908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTodO8r+ADieF7Gyqi4xgrDtswLQsWqUNliQrvX6LWE=;
        b=YCfajinIVhw5zL3ZetSz7FtzsV7GkSuY4vGGukybhvd6FK1Gc5vNCjCIgLaAgL3/NW
         Nk1g5xvJkvWtUVcRHLp9EkXX2jf+Ox5AI3fe4T0fJKZtdgXHIvpz6NU0SL5vfvqusXRS
         A3fUTwxRCjASLlFaSPIVL+amAyQi2WzBXjg3TE4Y/FBsg8p8yqPTsyGTHFwVZMigvptX
         AzNq/pustANpZztFtddM8eaeQzTqiS49RdkIXJ5CadZFNKV0N4APM3oLHMshfyCtPn6u
         LnpoSTve5V984f0mAC4jTjRiJSUCJUiTuU10P9Xo1sDUQSZf0PI1KYZ0g4HQRastOEQF
         p8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740270108; x=1740874908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTodO8r+ADieF7Gyqi4xgrDtswLQsWqUNliQrvX6LWE=;
        b=KCUxYGZQP6AHDf6umUYkxazEOJnabpjWkBZEIojm/etAkE8zGrXgCGYm2vESvpkRF/
         afFHYx/l6FB4qlO0lITT89PIu2gv9WTzkpbEGi8oFWyHk8QIviVsvvmSIdaCesOySow0
         Cz2QVj2Ny+UgUBJuVUVawWuppRDKB1TM5+uOEt8eeFevstMWkY2WNVs8kPzOM3cra3rh
         ZMBDggdDjOZPH+AUzx4u3OKEy7QLoMktvH4nWt9Gtpb044D1GOxrBZbYj3D1KoIgVCcd
         CMjTrc2FC7IwlY0Y+Rfi2u2tSoD44KroL8ozhvwjU3xr3FQ1e/fwChylcqanfVfqFTy8
         AtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVApjpRO/jAkpybF0v0eXwroH6X/nnG3OwCE5+RytUZKxpPfhk4hDsT0UzADdZASzbtUeOEhWQTVnmzmwx8znc=@vger.kernel.org, AJvYcCWaYPYSByxg8v2btmgtxlkJ08YkhVbGgzLh+OGbfkH+QbGAz0a/nf9gUk2JAReAYT4kDt7zKsLjx//eowM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSSMyc58ce9ujF7kSn7OssM7TpsG1IhKunjXH6xmgE+OFPlqT
	uUl8gnM63bV88BDiqe+R44R/Z+cMF8QCZeR7KERbxe1MnupYDk7i
X-Gm-Gg: ASbGncuZIXCqo6GfboZtNnM8LhQVINdaPaq6/ndApnLqgSRA9jObK7IMehWGcfKGyZr
	gVpQkgqjjmEA9xIWoxYjB/wZ2KKS1pSlD0p9UHdJAJPrKc1YZuZk1pi1QcUruG0EbkjXNC7LfOR
	MSq9dySAMecmmlTi5jd3tqfFmqeQc02plCq+guGFFgGpbXSsXddIcGBpYtYU75ChZXVhukKpchk
	eE8w3c8OBNnVwzH6P0S9GE1/6gUeB3Oau449fRAYoLA9+tbleiTOIKPvd5dRkMwgYdZZtqpPbz8
	IRQH4ne3oNKdN/6VGN0UZkaYxJmQgEZztQ==
X-Google-Smtp-Source: AGHT+IFmqw7s2Vd5i/YJJtLo/dTNpT5bpAn8DIwjCjrRT/UH1nPHdx2AE53fT1Q9k3rtj4lpGB9Ydw==
X-Received: by 2002:a05:6a21:4613:b0:1ee:be05:1e2 with SMTP id adf61e73a8af0-1eef3c889c7mr15750077637.15.1740270107810;
        Sat, 22 Feb 2025 16:21:47 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add2e0ad0dfsm14248587a12.78.2025.02.22.16.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 16:21:47 -0800 (PST)
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
Subject: [PATCH V5 2/2] checkpatch: throw error for malformed arrays
Date: Sat, 22 Feb 2025 21:21:19 -0300
Message-Id: <20250223002119.2432-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223002119.2432-1-trintaeoitogc@gmail.com>
References: <20250223002119.2432-1-trintaeoitogc@gmail.com>
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
 scripts/checkpatch.pl | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..67a9a2e33f9f 100755
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
+				     "Prefer declare ] on the same line\n$herevet");
+			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after the last value and before ]\n" . $herevet);
+			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after [\n$herevet");
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


