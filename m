Return-Path: <linux-kernel+bounces-366192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A6599F201
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B3F1F22D77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4E1E6DEE;
	Tue, 15 Oct 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrC/+mh3"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A11CBA18;
	Tue, 15 Oct 2024 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007551; cv=none; b=s6JoW4aYR9FWo1JaJDBOHDm2V3JHcNb5hrctdskirkvOXCDv7iLATuxPqafGb/5i1rEkN3VeHMJrzOdtivpl3Rd5RsoPhzNmX4H8to5TNXD5RsaBlH2SLcfOwxuB4CfCwh1Zjhhwf97QrrFL4xs+8yJWGXuTOJteclY7u+IVxSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007551; c=relaxed/simple;
	bh=+Fp5ImgtvT/g8YQzRUmLKeuXeZI3mdgbhmU4ODD+i9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr3ey8uPcYVXbguGgzSuj7MAxOz2OCtNWdmsEHnWEjIDWtwuItpRLYQY4Vatc2KGVQlRz8tAGkIFEkGDx+6f/R8JoV16VWwdtsDF6tb9zHxVkWHMrKi5FLD/MTUsvzuAuguOUbN+mcZEYg2RX+Hmj0Es4ocRIlwgbbA/Fdw3oBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrC/+mh3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e6f085715so1566128b3a.2;
        Tue, 15 Oct 2024 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729007549; x=1729612349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=351WEUHsLBNMjnwFGj/YaHLkFIDuudwz/R8NEtbQqd8=;
        b=JrC/+mh3L4SerHjvLBcJycfOBmuBNtEHa09H4KxLtsFHkxw9yEL+VGrAEY0fCdocRp
         M3ITqFUR/LDCjsxHV/zGQMcW4x8k6IIWQhpUr63TnddH0O6FLo69WBy60nrnY7HrPakf
         1ef547Ro8IR+jGULnmUAFjkz8D6CGzG1crKVqHHnV97U0hGr4btpCwDF56d/S2KRVgbe
         J6KGKI7uMP1nfh2FvKb6jtcMkPUp37upBQXPW4Vs0mYAgUyeKc5cRI1C3DFyTDjR1Bcn
         Z/ttkcuwJoRu7tihiAdbCOnSp5a+eJDpXIyR5kpAq1rvmO9YxRdQ9j23qs5fzVZyI7se
         jPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007549; x=1729612349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=351WEUHsLBNMjnwFGj/YaHLkFIDuudwz/R8NEtbQqd8=;
        b=M9KrQoCKP0nQ8r41sAqBj16vrTBmw7jqyLd4YGqWBnMNglMZMaOwd7E1CgxewUt6C7
         qU9b9SGw8+zTgtfuhFiSgH75TKtVpP6i0MZI+9LclEUv8FPgWlUjqkJ5s2HLQcrPaM18
         ODgVOw2jmvOpdW/6A8aG74TQfqQvR8My68WMiC64dwTkoBaXSFhy9NWttUkpg+wodKOp
         6F2UbtzrBbKXHg7woratbkB3xlcRWIj9lCKjAY7rHf54fN7n30wdw+ihL2DsdVzyLr/F
         /RINiEqSwd7XOqVbXAmnsD4pl+bGTXMiyiFe+GBRuDGfme0Hdw4kdpAxPbAGRuWlppZY
         LCVw==
X-Forwarded-Encrypted: i=1; AJvYcCWJcjF8k3G1P73u+hmBs9A5xCwThMiEYOqnHW6mfIYHQ5qSbm6ZLtpV+9mmjJ5qQhCefoGm3gVTqUaGleg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW6mOL8JueoSHd+AZKFFK6U40iAVCHnajca28eu0K4TFdRbrd+
	i2dpNacMZh3sdm+cUPXMbzWfjjJWhI+k3+35u+EdjjBASUgYVj2ssHGZP6l2ulE=
X-Google-Smtp-Source: AGHT+IHDO1X3FNYdrJ+gs37IQiBKhlQ9JngCoqgyknUGtlhXnGGzA/uxDLJVfWLQCuIdCStO++H+3Q==
X-Received: by 2002:a05:6a00:1250:b0:71e:fb4:6c98 with SMTP id d2e1a72fcca58-71e4c1cfc05mr22451433b3a.23.1729007549172;
        Tue, 15 Oct 2024 08:52:29 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2561sm1461753b3a.97.2024.10.15.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:52:28 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Hridesh MG <hridesh699@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Patrick Miller <paddymills@proton.me>,
	Alex Mantel <alexmantel93@mailbox.org>,
	Matt Gilbride <mattgilbride@google.com>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH v6 2/4] checkpatch: warn on known non-plural rust doc headers
Date: Tue, 15 Oct 2024 21:21:37 +0530
Message-ID: <088495172736416665325802594aeb6996159f9a.1728818976.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728818976.git.hridesh699@gmail.com>
References: <cover.1728818976.git.hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Miller <paddymills@proton.me>

Add a check for documentation in rust files. Warn if certain known
documentation headers are not plural.

The rust maintainers prefer document headers to be plural. This is to
enforce consistency as well as to protect against errors when additions
are made. For instance, if a header says "Example" for a single example,
adding a second example may cause confusion. The maintainers wish to
avoid reminding users to update their documentation for such cases.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1110
Signed-off-by: Patrick Miller <paddymills@proton.me>
Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
v1: https://lore.kernel.org/rust-for-linux/2024090628-bankable-refusal-5f20@gregkh/T/#t
v2: https://lore.kernel.org/rust-for-linux/92be0b48-cde9-4241-8ef9-7fe4d7c42466@proton.me/T/#t
  - fixed whitespace that was formatted due to editor settings 
v3: https://lore.kernel.org/rust-for-linux/da34f89c-f94c-43aa-946c-57fec3597974@proton.me/T/#t
  - move && to previous line and remove whitespace in WARN per Joe Perches
  - reformat following C coding style
v4: https://lore.kernel.org/rust-for-linux/20240914181618.837227-2-paddymills@proton.me/
  - add @fix option (credit: Joe Perches)
  - add Error to list of checked section headers
  - make check for rust file its own if statement because more rust
      checks are planned
v5: https://lore.kernel.org/rust-for-linux/20241002022749.390836-2-paddymills@proton.me/
  - merged Hridesh MG's patch[1] to check against consecutive empty rustdoc comments
  - revised Hridesh MG's patch to match against $prevrawline being new
      or existing
  - added fix to Hridesh MG's patch
v6:
  - undid the merging of Hridesh MG's patch
  - revised opening comment to be more explicit per Miguel Ojeda
  - The --fix option was throwing an uninitialized variable error, fixed
    it and made it automatically convert the headers to plural.

[1]: https://lore.kernel.org/rust-for-linux/bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com/
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..c390a9926cd5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3900,6 +3900,19 @@ sub process {
 			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
 		}
 
+# checks that only apply to Rust files
+		if ($realfile =~ /\.rs$/) {
+			# check that document section headers are plural
+			if ($rawline =~ /^\+\s*\/\/\/\s+#+\s+(Example|Error|Guarantee|Invariant|Panic)\s*$/i) {
+				if (WARN("RUST_DOC_HEADER",
+				         "Rust doc section names should be plural\n" . $herecurr) &&
+				    $fix) {
+					my $header = $1;
+					$fixed[$fixlinenr] =~ s/\b$header\b/ucfirst(lc($header)) . 's'/e;
+				}
+			}
+		}
+
 # check we are in a valid source file C or perl if not then ignore this hunk
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
-- 
2.46.1


