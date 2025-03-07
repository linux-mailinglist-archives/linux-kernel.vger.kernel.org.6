Return-Path: <linux-kernel+bounces-551494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F22A56D27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC316A43D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95A224AFA;
	Fri,  7 Mar 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXX0Xh++"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1F224AF1;
	Fri,  7 Mar 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363651; cv=none; b=UW26wBHqRiHtgvqa2Vn6kzCxgPkuqxUg/fHRELyfNWmCruXzlgn+C7Knwo7pJsDyNhpZTSifqnLeddO1M0sw8kFuTMKwkidqDEE30gIVuOLNt1k2ftfMSywNFe980NMyhfu/7lw3l1s2I37nyP2G1eoxWRViKqO3BJrlRiXbdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363651; c=relaxed/simple;
	bh=hA+AL+YkmFHDqEOTVvDJnon/Dsjcg3uYfNOntsX5TuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CehwgzWxSJM4lwnTk/ZTCtXKC3/TiXh8UVwBLKKFQy7QI7NBP07zNeuACSki8NDDY0eHpzFP3DSPFnhRj0kox/4bORyVqBldHMLCNPiHYPV7ytZQejg5yjcwxBx7PFNSqX+vir+C7G1vNu4acQrv4JFVzRNouTEnuQYOpz87DMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXX0Xh++; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2feb91a25bdso3310081a91.1;
        Fri, 07 Mar 2025 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363649; x=1741968449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muSHbuLdeyMAAgXAmJf/8jxjECvkvJugZR3BtpEzTko=;
        b=bXX0Xh++fqkCwZJ9fjvstyd6bJXUegSTtug6Rzuz3QrXMHRW6lRrzB9iydX05qP0Ka
         SErcdbXmBcWnxJF8uOmkSEUjpIIfWHsjeJaQ+tf8v2PAKg8MJqQ1Tts5m2XsH6fzBGy8
         Y4O49+ChZkOoG3m2MH/k2g+z6uIi7yTrCrQ5LCkvZ5AVMLIGXVN1kjmMnVQl++Xs9S6x
         EhAIjTnBBrsK05/cFzxeNwQ0j9Kax+pTGdEatILPDncyvD4Xz3IxG0MRESgQuyvG+1mg
         3MvJ3K0tUhNhtrI1zwSfPV6SC50LqgZxQYqgFRAD2zPxzcnCpeUBmVEQgj7Xy+nirfc9
         AsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363649; x=1741968449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muSHbuLdeyMAAgXAmJf/8jxjECvkvJugZR3BtpEzTko=;
        b=vWvro7J2OAi2jwfvpfMoh/EHmrc6eOMVv9GNOdRgdbDcr78KLI2zF1D9xbelfAgfKa
         wqatOdI504MtuQACEYakaDJURo1NWORswPR1ltszT7uBM69lrdJYtSao0mMuszr7DOxi
         oNg4e2B8Anj874MaiY6XouE32ADOPBwnp9uv0WzDSkjmWqQh2Hk4f8tE5zr8NpFNHjpq
         B5OmVsdqxMj6vcY26FjSwbUhqgSP4+DXuIywOX3cx0sCGrqRhcdsYwDGPllumvNTxFoe
         ElVivz8pQ1o/0qv/gL6X4aEYAwqAYeqMIyGiKO67fIvTEpESgDvOshmuMC8CumufImx4
         rAbA==
X-Forwarded-Encrypted: i=1; AJvYcCWfTbqoZ0WsLwlkBlCskgTFS0/CuiwWfw8SL598u28KBll3/WjBhrQ2sXTwcj0r0ZOB66Ylgu6VMMETxYYWHsU=@vger.kernel.org, AJvYcCX/f4bSWjTKtOBjR7bcBYgnIZmbZMMEBZskaUXjetmSOPCHiG22ZF5Db788KyA2Wyr0QIAfiEtsMSrugMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/T/hcoD1Me37abPYMxuLrNuqaxyeUkqEhVNhU8rfx2yWZP0F
	34y5lGBBkxbM1qzmJWLPgJ/EzYwV4SGmWSi+4A/MTFHXfRDjmy00
X-Gm-Gg: ASbGncvJNQi8S1ITyRV5nTO7Educ2+ONqMA6Uv7Rv1JLXXReBXYCuA7UzNpYXSzQKxH
	Desz0x+HHzM3m1rgS5TYLZ+McS9vQzr8lmr5gGlLNpk5FkNQBkus3P3l3xN6em3/f8uPXfunmTG
	xjoGkW1tuLvX4kz9JoS7ADl0EhQVk2jVZUvt1Ess05PpJ0IoJYZ66iSp/cTrej9QPXPRCbH5MIo
	nz9K+SkWKqdL68kYbiLj1/0uK7m5WpC4Z6PGPaaA0Qx3g6/senjM7gSlok0JbrmBh58W9pPBB2E
	ZU9c6vLmADlAwskv8z4RfCkTLCa4k/RPe0XasjTfBbp2ub+fZiz4
X-Google-Smtp-Source: AGHT+IGbVVmSwsbZ/9unYd5P33Ov3VnOcA7398ApJfdmkFjWzqlBhHbHlXRQjTiV7Gl20J/wA/FuEg==
X-Received: by 2002:a05:6a21:2d08:b0:1ee:dcd3:80d7 with SMTP id adf61e73a8af0-1f54493353emr7708311637.0.1741363648889;
        Fri, 07 Mar 2025 08:07:28 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698514f58sm3508421b3a.133.2025.03.07.08.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:07:28 -0800 (PST)
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
Subject: [PATCH V8 2/2] checkpatch: check format of Vec<String> in modules
Date: Fri,  7 Mar 2025 13:06:57 -0300
Message-Id: <20250307160657.641014-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307160657.641014-1-trintaeoitogc@gmail.com>
References: <20250307160657.641014-1-trintaeoitogc@gmail.com>
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


