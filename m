Return-Path: <linux-kernel+bounces-511816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E11CA3301A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A1A3A7B24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8720101D;
	Wed, 12 Feb 2025 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVcdCs7a"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CF1FF7BE;
	Wed, 12 Feb 2025 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389769; cv=none; b=d7agrNfe2ykGvJaZjaIXQtYh/TDbvLX5BI81VzspLIOivtrWlmBYKz1Mkjma3CtYEApVOfq6lCvgkuTx9oAc9YPWrRzd2+Ft60pvHGmltlSakDSE1l5ZRhITKRPwOZ42Zj5p412bObuvd8jmka+HX8zX1YWpniCcHBj0eg+m/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389769; c=relaxed/simple;
	bh=2fBq8ETrbkAbEQfoV02Ba7BojvfFZucWqe8PSO+hrtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMa64NqW73JWKlxdh+m716LAbJcywVJ4xhko23LZOSS8FvX0hTSiDhNZ9i+EQA/Lf480HgPAst27V/maHa7z13Glja8dKiosM5JETmsi+/vho0W82p2a4I/AL5CRbAgXxQ3pduw1oqiq/UbSgbm9m7JZYi18O8MOYRnafJuZv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVcdCs7a; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f3bac262f9so46558b6e.1;
        Wed, 12 Feb 2025 11:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739389767; x=1739994567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfHuUv36qeD42E0Vtap9D8YYHwdtLSqw+ae+Dz1dbPw=;
        b=TVcdCs7aliBBrfmQp0xJoWdGnN73IHt4lKDlThcOWp6XejH3z3ABONjd4uu+yHsH0p
         nGx+Y8Pw3cfo+RV5BZIWQ54ByvlZb6IX2rDF+wR8U+W4LdOwrKJM4BqKRK/DX+fjiW64
         Ll7aORi8yOCmskk3HQmVPlwOMTp0sBhSA3BhtYSbHHTWkXdDIbVaHY00dSgrq+njy/ST
         SBWZoGfOzG2ZJTrk3uSr6xSQUXKhTKNzrQXeYIfoM5Gu8WzeQYszRApEYp33SacbsRKV
         Vp7sdY8rhKYQoOELyxnzK+C3czrbtDLYBTT1g7Mnve1u125BmvziunBIz7G3v53rX6oP
         YjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389767; x=1739994567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfHuUv36qeD42E0Vtap9D8YYHwdtLSqw+ae+Dz1dbPw=;
        b=vUd7Nxi2u2Wr8ws8oFZmIPDq8iI/A+vgYC0iZFH6QaLT25Jddxi3zOLYGWQyiCKZo6
         q1HYPGO+DaUp4b03X7KNvKkI0+NN17bZV42Jn7/JmrkSMyXGjwJMxbXPpY5wEpWJNO5Q
         GbGz3GmNS3Nh3ZC1laaMMvIqhay1vO6jXxrWYuATFypWsnzoIOA7BXku/lxNYlYbgMpe
         mNcKdcyQZ4scVhtU6HIO9LT1/Jkm/jY/yAtlJKf38CXEfiEyPQs1Kux3cvzGi2HZhzVh
         z1NzzZPP84Eq7YQteoDxH29ClIZhUwyE35VBj0fMmZzdj4lG44AlIg7GPeV4E2WQudQk
         i16w==
X-Forwarded-Encrypted: i=1; AJvYcCWv4OJFlbh5nbi65RsXt5GqsRxOKNny77dyKYCOghAjkAEuaJk+pgV8wxL/2JEcPKS3LOGyrltPyiTiK6k=@vger.kernel.org, AJvYcCXvMjj9mtb6fFzA4RtzbI2B2kmZPsQ4SW8rgnOHHPqkbmivnbnmhtcpSN8vmRzz9XehLZ73nD1BcxsQAF3tl2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuV4ttzrFYEgA8XO7iBzXmDbJquP2Su6M4XtgTDF6CvzL3Eb1M
	cSVf5XfRYZ7y2RTGK5oabSdCYrGIIHTYtgCHQQVrYmN0V2FXeX3x
X-Gm-Gg: ASbGncvSoiZxrKMjyjoBuxCAAxOEuHjKgUcS8m2jiQIrfDJXXozxDcykSASLGChZ5BD
	bWEO2cWYtaHHWs8HaAS+vp6MKARcChd2h9TLhAZHpIyDUFbnHElcwuib44K43j35oP/zcTsNVTX
	QHiCW/labLDfCw3/6YkxsCEuTgRU6CTBYxA18Pgk6iVgvKL+ZTtLFojbb+ZU4UqE0pE0Y/DvklY
	5f8RBufRW1pchGPx2pmIFx5r3yNyHjZIRR0MeTheIraTV77kMvo7lG/AKkQw1cU9k3akmU8AwOh
	I5TyGRwbUfoeBSCWCdhrZ0wZ
X-Google-Smtp-Source: AGHT+IH7q/q5890m2oMI3dG75nxH8ikvFXu+8m9Gfe5ezMXI3YpTrCnQMblmfQ09g+vRYMH/Yb3kfA==
X-Received: by 2002:a05:6808:3096:b0:3f3:c289:8212 with SMTP id 5614622812f47-3f3cd5d318amr3894336b6e.11.1739389766853;
        Wed, 12 Feb 2025 11:49:26 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389ea921dsm4542328b6e.3.2025.02.12.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:49:26 -0800 (PST)
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
Subject: [PATCH 3/3] checkpatch: throw error in malformed arrays
Date: Wed, 12 Feb 2025 16:48:57 -0300
Message-Id: <20250212194857.192057-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212194857.192057-1-trintaeoitogc@gmail.com>
References: <20250212194857.192057-1-trintaeoitogc@gmail.com>
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
 scripts/checkpatch.pl | 68 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..d45536c2c63a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2775,6 +2775,9 @@ sub process {
 	$realcnt = 0;
 	$linenr = 0;
 	$fixlinenr = -1;
+
+	my %parse_module_arr;
+
 	foreach my $line (@lines) {
 		$linenr++;
 		$fixlinenr++;
@@ -3567,6 +3570,71 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
+# check if arrays has more than one value in the same line
+		my $inline = 0;
+		if ($line =~ /^\+\s*.*\b(author|alias|firmware)\s*:\s*\[/) {
+			$inline = 1;
+
+			if ($line =~ /author/) {
+				$parse_module_arr{'author'} = 1;
+			}
+
+			if ($line =~ /alias/) {
+				$parse_module_arr{'alias'} = 1;
+			}
+
+			if ($line =~ /firmware/) {
+				$parse_module_arr{'firmware'} = 1;
+			}
+		}
+
+		if (keys %parse_module_arr) {
+			my @keys = keys %parse_module_arr;
+			my $key = $keys[0];
+
+			my $more_than_one_vl = qr/".+",\s*".+"/;
+
+			if ($line =~ $more_than_one_vl) {
+					ERROR("ERR_ARRAY_MODULE_MACRO",
+						"the key $key have more than one values in same line\n$here\n". cat_vet($rawline));
+			}
+			elsif ($inline && $line !~ /\]/ && $line =~ /\["/) {
+					ERROR("ERR_ARRAY_MODULE_MACRO",
+						qq~the key $key need a new line after declare the key\n$here\n~ . cat_vet($rawline) . qq~\nFor example:
+
+FROM
+'example': ['value',
+	    'value'
+
+TO
+'example': [
+	'value',
+	'value
+
+	~);
+			}
+			elsif (!$inline && $line =~ /"\]/) {
+					ERROR("ERR_ARRAY_MODULE_MACRO",
+						qq~the key $key need a new line after last value and before ]\n$here\n~ . cat_vet($rawline) . qq~\nFor example:
+
+FROM
+'last_value']
+
+TO
+'last_value'
+]
+	~);
+			}
+
+			#END OF ANALYZE FIELD
+			if ((!$inline || $line !~ $more_than_one_vl) && $line =~ /\]/) {
+				delete $parse_module_arr{author};
+				delete $parse_module_arr{alias};
+				delete $parse_module_arr{firmware};
+			}
+		}
+
+
 #trailing whitespace
 		if ($line =~ /^\+.*\015/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
-- 
2.34.1


