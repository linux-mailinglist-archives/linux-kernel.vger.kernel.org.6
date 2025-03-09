Return-Path: <linux-kernel+bounces-553266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DCA58694
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6347E16708D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C81F09B4;
	Sun,  9 Mar 2025 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpYyIJdn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648F1DEFCD;
	Sun,  9 Mar 2025 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543064; cv=none; b=rsoRHDl+X8yTXXzW4U7jJ1WsW7VqhdTfBYALrI/HVr/kwOFftbSZ9KRo2f2CFYgq8qxIBKsEOcnXS3PCo1cbqowYiPIWfBJanlZ9HLgm/L300LwiiSdrvwAbanDXWFXHddoJy1lGRc7j64dCvpluvebA/CGKL83b6A/3VAsFd5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543064; c=relaxed/simple;
	bh=KE9IESEtCkoJrMIAAiXk6ocqr27htlDirj/MxdU439o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3BlW89M8YuHGbkUifRfYMtCA5e56YOjFhU6yjeiVjAkgh6ShmZhOYtMWb49Ae0D27yyLlcwcsYFZLhjabl2crNAynG0M0JRumGs/wTOmpIN7iDZpsgBfx6P1ltzOWm6loEn/i5cYL5s1OlnhKxY69jXYF/9SHcqbgvKbtWfefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpYyIJdn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso60643485ad.2;
        Sun, 09 Mar 2025 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741543062; x=1742147862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq0x2h1DIzoTL0oLbffmbZ2PvairrfstI9Dgg8MRk8A=;
        b=GpYyIJdnfd69yo4I9epnnnVgr3el9z4ME097wAsMYorOIAhyGs3G8XhoBr8wGg/AIj
         TFFDirTZKF8vE6oacjtKnl2klz2PyY4zpme9rt0nsWwrEqagRngKpcWyrG9ZonImPgn9
         jRMo3uJcYkFkyBCnVsFV2EDZzBwJ+KcbaQmJAPFf+bvBThDqjZLRqyXA954EYqwsO7Ok
         QJ2KEWRPeEIUWSSpbH5wt0KzHw6cf42q8eHha4UZEUacWGRQzuPjlDA42Pr/yrjaa6fn
         bjng0eHZnaeLMF509e7CSaadOMVPEJ6H56FGidQJAptfs5GZrcOqBDCrtZ9+1ZnXOIHv
         5FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741543062; x=1742147862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sq0x2h1DIzoTL0oLbffmbZ2PvairrfstI9Dgg8MRk8A=;
        b=lcS78zUBfcEHDUKco1SL19Wst4bi3IgEJ6Tlfu2PQ+Vd/QmzeBpFL+Z8YWYUZxksPQ
         mTNXrhYHT7T/8caApgkFiHw1YpDAfVBaMt7ck/kMrwNh3JhkNfxAWQiUuJpTbnSZywn7
         BAIMm6BcMlJtK01Ho5LQeKjHF65IlZ/PruNsc5A56NzZgDpsy0wtYNWWB9z919dTAeqh
         ROJb2gsAcG0bw7uiX3DGV3yZg4NebQvCdMMzurmYfhLHoKzi6HKRnaK8h+lTVgi/DaqB
         SuU+aUIYxK3Y0ogfMvfAEbtl/+cjDqrqsOgi2HoNzs5cWcq6iC9ceNt4V473jRfpePkM
         xksQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOMpgMfHwwmu09x9muQyUUu+vkMdtVY99Ffad4QzCQElM5v6J1JxK9ODFe6S3cqLdi9cWTzHxC9y06H5k=@vger.kernel.org, AJvYcCUOjxbwXRKnR3xhskSQAel5NU0AWkuwHrNE0dwUvCfMGoYBXcHiSPBCoPwCAdnVPBH7j7oYOKivRohIIq7cbPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqtYfvDuwLhuVDP/7eCECPCTSHfEC/WDpzg1KeiRilyR9qaHxB
	rLGaFl4oMURXKboY5t+ZXTO36hAH13KWBe34cRy62xR8PBErGB5+
X-Gm-Gg: ASbGncuwk1jTi4bxnPmI2Vl8Pcwk2ZNmSznWypra/ajI8Sozb/bka4kH2E1jwiNWXPD
	jroTXPzwwgixhYNSZcMea8kiKqj8OBlOrz8z+qsyJhlmIWTFruSuYcpMmEByUMYGqM395gMCbj1
	PFgCsaoygRn86CuqhL0fnNEHACKJn7ppC3pmOSxU9afNEB/1GR9bifI0VHmwA/8o1+YFAT9b/qe
	YFiQqdHEXnKC3VcDPVoyKlkQyvICXlc4UxqjcNs1kjfmmg9PEVKsLFNm7eryFEdXGNqXyXuyAqO
	x5JAzrrOn/VgNYhZWbeJIkpSsZL1vqEOlLgv0x7knxHWzieP32Cea13brSinVAA=
X-Google-Smtp-Source: AGHT+IEExef/AatcpGlIuzT1Dp5e6/YXCkSrikxpnNgsA5brOhWF3jQHsn7ltG8iK1auy0jbF4FYbw==
X-Received: by 2002:a17:903:1b63:b0:223:50f0:b97 with SMTP id d9443c01a7336-22428bd456dmr163822125ad.52.1741543061587;
        Sun, 09 Mar 2025 10:57:41 -0700 (PDT)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e944csm62675505ad.74.2025.03.09.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:57:41 -0700 (PDT)
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
Subject: [PATCH V9 2/2] checkpatch: check format of Vec<String> in modules
Date: Sun,  9 Mar 2025 14:57:12 -0300
Message-Id: <20250309175712.845622-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309175712.845622-1-trintaeoitogc@gmail.com>
References: <20250309175712.845622-1-trintaeoitogc@gmail.com>
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
index 7b28ad331742..dda89ffedd1e 100755
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
+				     "Prefer to declare ] on the same line\n" . $herevet);
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
+					 "Prefer aligned parameters\n" . $herevet_space_add);
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


