Return-Path: <linux-kernel+bounces-325439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAE89759AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AD0285549
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0911B2537;
	Wed, 11 Sep 2024 17:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7nKftXx"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A515B10D;
	Wed, 11 Sep 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076723; cv=none; b=qBuPTVNAQ7UE80YVKUSQfyJF4pqrMv8T3nHpF1R3Ips4ObHipr5ISSw08qA76B3P9YUPPCB3C/tjKNaqKn5ZNFTQZ02EE7WXb19ET2YcMsTUhbJAxauEy1cxNLOvpoELa5XHoGzCosSTwrtCKn5mcMAlSW0H2ziQkingKghKx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076723; c=relaxed/simple;
	bh=yrBsxlWEGnaQTlJ5iuOws6MchRPMJlM1WvfH9TUetF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeWJQrxk6ZVKazIwijNAPgUkOheQ1fbdNs3MpsAjKE0N0cjzGAKKzWG6YMyuBEQsjZMd3CA3+A/TM3yfWRMADWtLEI+5byjkuiALo/v6Sj1b5QdD7PcFihWnlaH0YP/FVy2f/AgWeaaTWo2f4wV2ucNjbnz3ER5F6Ju8MD6dZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7nKftXx; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5c7f24372so70610eaf.0;
        Wed, 11 Sep 2024 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726076720; x=1726681520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEryC26HDDluJUPDb2FLocPjA9qovOLmtn8dxelqX3U=;
        b=e7nKftXx2mypp27mH7nBfAPKOl3hkHiyhzQIk/Skt3hmiWv4hlmeDI3ru01QWHCxr5
         Ze6LOYBWLRpOwXxMDUbJ7alJjIPlSqTnaQ950DLvzx+7xJFpcy5lbNvuZGFR2uigcg+Q
         j7Qc7Pj6dILHr9UI+7BlQlCL+E7zDBdQUoaMJ9qVg+Lk9AlObnFg1K5C1Ok+fcaHl97H
         UpSrW2utxFEk/OZ8tWbQSsh9MXrvzE2tFsMBRRdGbuj439+QjyKbXqpziOjOepNCGFZ0
         N6ojWJHq/Jq5SC9anEouiIl+bIvFN/du6wstDFp73xWip7IgfO9R6guZwzutwlvWw9SH
         SJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076720; x=1726681520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEryC26HDDluJUPDb2FLocPjA9qovOLmtn8dxelqX3U=;
        b=txLP0WDANtTfHnCPSUErxb2TPzwcwScjOM4COdhk6ds/G3BaCDPyy6fJ9ZAYLx6DEm
         t2JSA16nwQkzmuKFIDKORpMbD0e8L58pDHxFKLucFWo+7KAuxKQ7GxL/OccELAn9foBm
         2aLpCXqfdxLFrZfel5ZbQ4I01IGgCjBjKNFX1VzSKgF/q3Zui65GZWByu8pDaTkt+q6l
         ok+5TGfnkhsODquKQbbbm16pvGFd/4KbKdRAYbhoGSCwjl6XVs84f6IuqnGYepKml5hI
         s5M4AOi3Co+yaJr3Z5vObYWlT/E2j7dBc+EcXYDxSHkeEHytdmMYkLbHPZ+07Jam/0nx
         Mzjw==
X-Forwarded-Encrypted: i=1; AJvYcCXjgSd9hExNC981TDWy/vm5UW85BrNTLVkIQcm2ziRp4JqYXJXq+BNbat34M9dW0MknYk6aBu1kTE3WSo0O+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+OWdsW0nOb8LOpPz2QG0pdmB/l7T8XCoQdVS4O3A22ApDfyH
	UZH89ykwMof2AxcjhXj4Q/VpHF+0qgblIR+he0cNLvPcwK+pVhXcDKgr6SY8rP8=
X-Google-Smtp-Source: AGHT+IH2C+23i5HnVfQnyH5byEh9z1KWrcIF+e0BjdxeTkydBp68nFxSfL3QAhFwZ14UHUesT2CaXA==
X-Received: by 2002:a05:6870:c10c:b0:277:fbac:1f71 with SMTP id 586e51a60fabf-27c3f0daa7amr50192fac.3.1726076720358;
        Wed, 11 Sep 2024 10:45:20 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b0347sm3351588b3a.149.2024.09.11.10.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:45:20 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: hridesh <hridesh699@gmail.com>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 2/2] checkpatch: warn on empty rust doc comments
Date: Wed, 11 Sep 2024 23:14:35 +0530
Message-ID: <7877d23adba22e2f89a61efc129ecf1b0627510b.1726072795.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
References: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: hridesh <hridesh699@gmail.com>

Add a check to warn if there are consecutive empty `///` lines in rust
files.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1109
Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
No changes in v2, this is a new patch
---
 scripts/checkpatch.pl | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 39032224d504..c75bc3927bf6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3884,6 +3884,13 @@ sub process {
 			}
 		}
 
+# check for consecutive empty /// lines in .rs files
+		if ($realfile =~ /\.rs$/ &&
+		    $rawline =~ /^\+\s*\/\/\/$/ && $prevrawline =~ /^\+\s*\/\/\/$/) {
+			WARN("RUST_DOC_EMPTY",
+			     "avoid using consecutive empty rustdoc comments\n" . $herecurr);
+		}
+
 # check for adding lines without a newline.
 		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
 			if (WARN("MISSING_EOF_NEWLINE",
-- 
2.46.0


