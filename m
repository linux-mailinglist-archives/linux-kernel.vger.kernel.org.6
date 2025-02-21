Return-Path: <linux-kernel+bounces-526433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA5A3FEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46728167C20
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5AC2528F5;
	Fri, 21 Feb 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NffydXzh"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD91F0E36;
	Fri, 21 Feb 2025 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162155; cv=none; b=sz5ol7izJpcyOvMUVeZa1pemDWB3Prqg7UnlOQE+V1g4aftPy7R0w72L47/EdnC6VeP04DT9TDa5o7Xqhl3CHDhsYdzLaYqiVyBc84bdJNvzusrIn5hgDNpU4uHCEDNxG/HuPERmBT9eTTy7oRJBkKiOb6EvZwzXKYpVoAkSGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162155; c=relaxed/simple;
	bh=XEJSkpcRT+l1bJmdwz/TSZDGUSyUv+uf4slwZFfLi/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSNnQ2sSuMgS4xYB3Pb/6W75wd4ywsUqZuqnsu0rL1Mq1B9N6crZRZU3h5s4m3akyEdCIUAWfsIWEvR9CSnKwgd5gjlCrj2p4pfJ0ifPhjy4WPvm6fJM6Gl5W17E/+JwonXYwM/KE1ROHajDnxgYQOnIk1D3ObwKMLdVT4ggX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NffydXzh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22104c4de96so43838245ad.3;
        Fri, 21 Feb 2025 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740162153; x=1740766953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHL7vPjPelCu7vXwBnwg1cjqjcfxa3A6QUyECJhbzJ8=;
        b=NffydXzh9IPIoG4OL/t/sc/FEJBqCCpVR+G6IXTYlYebp3SzCUabpNEuhXoc5+JBjt
         MyBQ2BEp8EmVcMsiLzsTiDnHJcd8w5JM5wZsIdQkBfCM/sx/CiODgjPtqxvcd8DJL6B6
         Ic3ZjvqzzMlwioqJlw2OiV24L5bWhJHmbItCmfAbdgOyQG3FSzsdcjzbwo8pettvZtxt
         nmsw+RI9A4q3kyvAsyqXQadKYABNHESM7OvElw1UQEWKRmaAzp5YbHW5Y7DEeybqk1YM
         45ScR9eRC7Jzl+6ANuDmFc8yrT1+xpk1jV0a7eVuLhucW00oGipExBqfRCyZm7S8an4q
         kdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162153; x=1740766953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHL7vPjPelCu7vXwBnwg1cjqjcfxa3A6QUyECJhbzJ8=;
        b=bFoYiYVUA4Kd38DEoqEVLeSemLZTBHWkQossf/VXqZGuNPmkpQlpXPOM5czcQJ3381
         2McawOQq0eqalp7fRklQSKRdMlZfzMxFJFMuIySzygNtt4t7ssbGT5+xQA0PDsPAloRK
         6Of7SOxTbwCL2IN+P9wOY2ot+s61uFZRoKnkBjBs5OeZmDBqeguZHyhtUrWpFdd9BvfN
         gYS7T6CyLz4/xtiWUGWmbMXX01u3tIlTjOlZ+69We9c9eMwQ6bUJdYQoOm89yEwFM7++
         8/d45Uzwa2edSUcKIpH0mM5DLehOBM2UpNNL5lMKiNawyNwZ8Ljct9XVdxJ8jwQXTEfH
         ni6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIi/up3w9c0Jd5L/90YMZQUS8ODSNFJWoSL/WqwRX7BRtFTVumZWReznE00gk6w4zxHzfmM1BVWdQvfr7V/kA=@vger.kernel.org, AJvYcCXeTFyanxTaq9gZLJv7o00zPfw+ht7zyH7n6dxxxKcL6h0QIgpnpNrOIg0oLNgm0h1uMB9mR6F0Iyfdr68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeV5oVqNFDOqVrfgu5ucXqNgK6MotkLl7Oi4r/Gk39X4RmF8TH
	Nel9mnLjEEnmNC3/T33Av+RI97MOKlrcFOYWOb2nVsro63dAt2bS
X-Gm-Gg: ASbGncsElj9Jhbac/c4srzAJHaOhIlkS28QIqGhj8eBQhIEM8RhTwi+13WKgtMbwrtb
	XOmbIDvyZpeP8E1crrY3AWMIeLTMKva0hvnSomnSYxuTdiUlQBp2b/JjsZTqjR2M28J+GR7M4vq
	CVe6VhbrN646SdvV4nwJ2jiBu9Xi5nku286JEDk5A9vKNtIiGi7bVvv9AgaD4V7bIWjzt0TGksX
	+AplGg4oQzk+woJ6DAG5Ee0VsVlMXs83PWEUNsRKhrWABBpRbprGQvTYr0No9rRaIegga00xQs/
	uYTMrH6kr4HYMOGVZ2bDllocr23M7YHrGg==
X-Google-Smtp-Source: AGHT+IFmSCg5zSc1oP8FO256fDI+PNQxG+YloMlQVhJ8OyzeMb3h/2ZIeEAZdH4eT9dksJQ3BfEOXw==
X-Received: by 2002:a05:6a21:33a4:b0:1ee:e785:a08a with SMTP id adf61e73a8af0-1eef3da4c68mr7421042637.29.1740162153171;
        Fri, 21 Feb 2025 10:22:33 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a52aefbsm14767948a12.62.2025.02.21.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 10:22:32 -0800 (PST)
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
Subject: [PATCH V4 2/2] checkpatch: throw error for malformed arrays
Date: Fri, 21 Feb 2025 15:21:42 -0300
Message-Id: <20250221182142.42134-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221182142.42134-1-trintaeoitogc@gmail.com>
References: <20250221182142.42134-1-trintaeoitogc@gmail.com>
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
index 7b28ad331742..21a5ef4fd8b8 100755
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
+		if ($line =~ /\s*.*\b(authors|alias|firmware)\s*:\s*\[/) {
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
+				"Prefer each array element on a separate line\n$herevet");
+			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =~ /"/) {
+				WARN("ARRAY_MODULE_MACRO",
+				"Prefer declare ] on the same line\n$herevet");
+			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
+				WARN("ARRAY_MODULE_MACRO",
+				"Prefer a new line after the last value and before ]\n$herevet");
+			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
+				WARN("ARRAY_MODULE_MACRO",
+				"Prefer a new line after [\n$herevet");
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


