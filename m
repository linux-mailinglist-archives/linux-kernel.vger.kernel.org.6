Return-Path: <linux-kernel+bounces-527858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659C2A4108C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D5C3B8B61
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3750F1632C7;
	Sun, 23 Feb 2025 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTNKRxuF"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD07158558;
	Sun, 23 Feb 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740332560; cv=none; b=H1Lsqrj9Sp2MqvTCHhijBVzTnOp1AaJkGhA/vDNQFdQF7mSj5KgaKP3K+/wHo6DdtcIUgkGhRG8Vs+vp7P14y7OBs+ZuckRMbuDQOnB1HxUODNXA6ulfua8W0N7KJnBBaM/yInZVwgygczWaL+uUgCLW2+XLAf5SrcI9YiXupMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740332560; c=relaxed/simple;
	bh=Z9EHzj/9TMsdRybcSGrBxIUApr0DZUACq6j0urRmUsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8n0xGKRPP8MTgE2ZOoBm1aHoKOB5en2Z/V1deuQydnN5SYL43DnE4xy+L6Fx5NCLUKfgOdp6ifp1pwBXllt1niI86oX6tHt2ielitdjIK16hu8OyxmvB84OnLlbmRMYqgKj6glzfGaLkMT+1Qd8fAE9VYNHjjeXY+LhZyA365c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTNKRxuF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fcb6c42c47so5693450a91.1;
        Sun, 23 Feb 2025 09:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740332558; x=1740937358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+/OYTmylIIw4plgNkwf6eTBea+h42xj2aKz3F23uVE=;
        b=HTNKRxuFGVXCH9RPih7FnU9R/H/7CSE1NcztR7wsptyPWhAt0FDsuDvUXdhJdRBBH3
         b9Dc6zI3tCBW2z9kZkSdg9t1dM+gPJwfFg65msFM3msM8ntNK5uE1T85FfXnSDQpWtvK
         JQeZglVg7cc0c1kCeHtiHqJLbZetWAX+s+w+LDWmvIxXgDQf8YyYsE74f9W5PfDN+FLG
         Mi5MaSwINNPe8vy38hyR0vwGnPZ2HeJJA0v+6ZphQi1hl1v/BCOnVrhw0SqwziFBebUr
         LH4ioYwcZ44us9jp1fFobmdk5p5w5KSrMwtAcpmhhOSj4/Zt04duK3XqLlzBNIXMIJfK
         cRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740332558; x=1740937358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+/OYTmylIIw4plgNkwf6eTBea+h42xj2aKz3F23uVE=;
        b=AbInw6iqCgHWUORgAjUvitGsXynWq4HGLHwly6Be+nrvZHkYquWcSWe2B3uJP3PeLR
         ceskmiTNACUcIi6G65dB4kBfkrnZhVzoTZaZp7zTHx0FVsf/ICLpvanhqu43xh7RvCHy
         FLUkJPvi3EO6EaKDebZ5WUEULzi4pHAlcvDAGKvwLlL7vjt7B+uQmBzWohBP0ugmPhkI
         PzjMmRPbX+ZlSLgCwVAFxIKzZqG3KtjertIFIxqvU7okJl1mTKJ+0uXOU6Mk1Lrm7IX+
         /4e+ekgeKEMlpVhb1CYNPleRNP3LwNWEBqcg6WFmkOfFElvyxk313/NsZq7lnWd6sYfa
         SZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEtm0okF8lPMV7Mp+S+bFOWeddkjT8ibIYZvz/GUQzsZrQQ5bEXPbW0uXI3mvLcsawb/gWXVfk7Mh1TivsJYQ=@vger.kernel.org, AJvYcCWhdcIsQq/KTxnwRVq+FFW6aPAnKwTtsviSYvgiidcE1rC2gx6+B5UtiXf1gWaqIZJeMA0doqT3fybcNI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CjsXitkycjbGwnDgP6bg6YvKE19YgHcEBDo/lZv2S7XhtZqm
	IPLTg/S2armU6nOEi4z7Fg6A7hxLfOU/kgiXrXd4q+jPAdA0vIvv
X-Gm-Gg: ASbGncu2DcgwlpuPqP0VcYEAsuUHQn+8DJ1owGN9zuWrO+SNY/BEW0EInlayzglMlGK
	AMziKfRDQuUtHQc0/LQIxrvaa/L27HTT/pxcjwOzzo5E4tLHOJFpD2ewvTNiNK9NrMdJ6fR2426
	Oj52rbXfjjguLoVRygLr9TYv6GDY4Vlqp+t2HQuQi1SezD5+z/vcNiWxuCz366PO9ZsqdfznG6s
	zBl8vT2sp8Tuaabn3+hZhGC2EIP2xCIO7bRbsUWGLKx6ST3TItoTle+rii1JuT/7wSL3akcOHTb
	i8T8lO1ZjfaJkPJzZUqb2xGcyQDrTu888Q==
X-Google-Smtp-Source: AGHT+IE7wAeQ0OmTe+ASeV4iyklAhyLabEc7dmvwMoDTWTlzoTjT9dcAh0mXSC4no787TtfbCR7Fxw==
X-Received: by 2002:a05:6a21:9218:b0:1ee:cb08:d0a8 with SMTP id adf61e73a8af0-1eef3cb91d7mr19610972637.21.1740332558209;
        Sun, 23 Feb 2025 09:42:38 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5aa21bbfsm17433834a12.74.2025.02.23.09.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 09:42:37 -0800 (PST)
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
Subject: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
Date: Sun, 23 Feb 2025 14:42:05 -0300
Message-Id: <20250223174205.48404-3-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250223174205.48404-1-trintaeoitogc@gmail.com>
References: <20250223174205.48404-1-trintaeoitogc@gmail.com>
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
index 7b28ad331742..54e1893d13aa 100755
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
+				     "Prefer declare ] on the same line\n" . $herevet);
+			} elsif (!$inline && $line =~ /\]/ && $line =~ /\"/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after the last value and before ]\n" . $herevet);
+			} elsif ($inline && $line =~ /,/ && $line !~ /\]/) {
+				WARN("ARRAY_MODULE_MACRO",
+				     "Prefer a new line after [\n" . $herevet);
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


