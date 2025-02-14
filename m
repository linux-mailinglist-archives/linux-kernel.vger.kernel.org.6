Return-Path: <linux-kernel+bounces-515526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2129A365E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC381894E45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39619750B;
	Fri, 14 Feb 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL5QjXD3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E131193435;
	Fri, 14 Feb 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558818; cv=none; b=drte6PO7kNMQsqBy4GJS5iyPbnL46yrGuW9nGwG/E7mHu+p427epSUNGwOJK/970TBzlXObkhmnYqNVQENhaqAKOSxiIOg+78nlDkFyGFUDmLQjySfc/rd3ESCC/erEs2xgHROCK9ZDSbNgl4R2LgwfxmvaCI+/fjOxhzhxsxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558818; c=relaxed/simple;
	bh=j76Dso+lvHql/WnntoLkEASAw1W6oVMPhEsmqfGq3e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwmkltR6kfedYQH8B6AfzUbBADkZsqztAr6DZDawycDhO7evXWF9b9g2SA9ay02j5q5oeSr7CWOt1h3lUgfLcResclcXUyxgOjWTsyrMADYJfSiBpPA2E3vULWBHFiloxGxDmrqv8rWx6y3AUr6EDfwuE06k8ZcVBe83CnJ1myQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL5QjXD3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220ecbdb4c2so32353055ad.3;
        Fri, 14 Feb 2025 10:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739558816; x=1740163616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvtBYB/97otGJ2jpua78++vpzqj8t8PaL+yJVTrzLLg=;
        b=ZL5QjXD35WTmknUvV/lBmbbKLOEcjXBKlopN26CNIU07oZnZkuH6rpdtwot7aCwYER
         7tQeEvoS4IP0G4mRmruIvhoKtlUIC5AzEGA+ZN9fz7WIzDe2ns/yCM79z/j9B11yhlkn
         1hq8nOjPKV+u2CL1t4Ogsfie5/hhMLGtIC128sQDpszTTHy1okob+7wkUvUV7JB/N+0h
         Cb2t4sgKETHUb083uE1zVPzUt02BWRm5f3seV1Tr0WtP5U6TJ+NxbWuBtgy8o4T6a/v6
         C4b+oSi1exlrW8EjB7YNeoIP3YfgYM69AcPR0TeNwObpKegBm1EpD6dYfNCc4CDUQ94/
         CMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739558816; x=1740163616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvtBYB/97otGJ2jpua78++vpzqj8t8PaL+yJVTrzLLg=;
        b=Dtmb1WeBMwzKnChEX7ExrNyuG5UWdpaKw9/xMyNHRlFvWaa4mqXdiZWT9j5OwCeTKL
         N/MMlZDrKXwD3y/KtdqucLQ/aMfQnB5cyKYXbaWk85gu7g1caPVlIWs6QFFDXj7gDYj7
         AkCFw1t0P0FpNV3Ae1ri0RIECdtSzju0TaeoZHJRJ37Pq4S1SH+TCV5RBILzionaOuZ5
         NmiP6+xw+qfTfmVHBvvYU5qWJ6Z34vSj4jyovGqZa4NRRFYeLLzCSvJ7zjOI5wBZWYbx
         NAl6DxH6jpF3DNXuIQxQrmEqsnqTio5RcyQgbuC6jX3cP1sUe7Ql9BCvIrfx0F4C8Z8G
         HDDw==
X-Forwarded-Encrypted: i=1; AJvYcCV8S8hDKtbO9smPDUNxA8N0E6dumhXGyHDROeHxKsz3iGWTwgV2htmczBDBkXKulTj2trZx03s015AEXkw=@vger.kernel.org, AJvYcCVb28DEgLaSOAtTv5o/P2OJlNBo5jk0MJ6lScNjl55Jt/gKHUrPiUw7ymZ2FQZR1q9DyrRASnOX9BZK5yH7/0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNV12pqGe7gSSNO5JuqxlWKZFNeTRct5CvzIvv1wYC45I4OF4O
	8KT6Cy/xQMqP9Ewu9balcSulKV4Ziinz9mhgfYQdD1ETiXwaLCraslpra2xx
X-Gm-Gg: ASbGnctqlhLwiNqTjNsN6kPHsW3L3HPk/QcIv9Jfayfi0ru69TPvbwc0j0i8r5jb7RT
	247nZNvuVxdQSVDMErYm2wn1yd11EwyeS85OjUR5Xp846+NVpdJGfeGjOwT+FomopCVcBKhHQaP
	ZeTUhimOua0DxT5Ba6ZQHR0pzrzjDZ4ixAQrjNXasYnks2/kaaJHK7BvVceSMmM0iEYOQDUTgmW
	nniqnQGGCWKFfUi2xs2fjC/C4iv5xfhhM2cNHZKKnEJJjfYR6dv1RKBYo3tuiovksb2epp6aGIV
	9f2aqJUgc4jM3cK092zNwHOD
X-Google-Smtp-Source: AGHT+IHWuC7B5WLE6Hp5I9ovuYQpYv6XpWpsy4TGYkIc55ebZe9RLGeMelJrtLnj/OCLbRkeImUwIg==
X-Received: by 2002:a05:6a21:b97:b0:1ed:86cd:d6f8 with SMTP id adf61e73a8af0-1ee8cb0c97cmr1046214637.3.1739558816574;
        Fri, 14 Feb 2025 10:46:56 -0800 (PST)
Received: from linuxsimoes.. ([187.120.159.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546841sm3438637b3a.1.2025.02.14.10.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 10:46:56 -0800 (PST)
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
Subject: [PATCH V2 2/2] checkpatch: throw error in malformed arrays
Date: Fri, 14 Feb 2025 15:45:50 -0300
Message-Id: <20250214184550.120775-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214184550.120775-1-trintaeoitogc@gmail.com>
References: <20250214184550.120775-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In module! macro, some fields have a string array type, and we need a
check for guarantee a good formatation.
Check if the current line contains one of these keys that must be a
string array and if so, make a regex for check if contains more than one
value in array, if yes, the array should be in vertical. If array have
only one value, so the array can be in the same line.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 scripts/checkpatch.pl | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..89fbec713bf3 100755
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
+			my $herevet = "\n$here\n" . cat_vet($rawline) . "\n";
+
+			my $counter = () = $line =~ /"/g;
+			my $more_than_one = $counter > 2;
+			if ($more_than_one) {
+				WARN("ARRAY_MODULE_MACRO",
+						"Prefere one value per line$herevet");
+			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =~ /"/) {
+				WARN("ARRAY_MODULE_MACRO",
+						"Prefere declare ] in the same line$herevet");
+			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
+				WARN("ARRAY_MODULE_MACRO",
+						"Prefere a new line after last value and before ]$herevet");
+			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
+				WARN("ARRAY_MODULE_MACRO",
+						"Prefere a new line after [$herevet");
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


