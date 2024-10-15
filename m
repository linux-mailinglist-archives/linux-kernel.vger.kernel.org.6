Return-Path: <linux-kernel+bounces-366194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD199F203
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F95A1F21EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E362C1F4FBB;
	Tue, 15 Oct 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euFUF/Du"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018D1DD0D8;
	Tue, 15 Oct 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007574; cv=none; b=ZfUXRhX0LzeJhdB5/j4X6g1GlMSBCrzBC6MC9eE3rEz7fQHwZWhYpXSnUoMaq3Xy6BrOeFnXibdWvist2r9J2VLoSJmXNO8LVLA7jSskd85w9LEJbA1RVPv2px54QCIikaYzubMKLVdjjz/Bkr224+X5wYe6FDShKKFQ8NfCu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007574; c=relaxed/simple;
	bh=8Dxngxm3PKoGPubk+nvP9wf4wpuZgaDMrU6hT7hubVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhIskTD5AY3LQJ3A5o5RaJfzhS1Y+8kD99wI7p/VbBBV+ta3D11meWcXc/vairMjScuqktsnEjBc+ZoqXYh/xtBUWKqURpI7k+vmBR2romix6tb6VUILO2oxwyqpQ18o2fVZ4EgjvITsHAr/WNNE2YVsdQeVZX1LXUURsdXRY2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euFUF/Du; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso1819301a12.0;
        Tue, 15 Oct 2024 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729007572; x=1729612372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sQCvJD715/TLzicIGZLXAFOT6C/C41EPnvD4MXjx14=;
        b=euFUF/DueaBiGgF2D2jSpPI+aESB7pou4XNGYZ7NP7xel6Fg9n9jBc8puZcpH0fwQ/
         Ix2PbIj8PA5U2RqdVUiVze73gWry75GIuOQASOH5LqdrNVT0IH1x9ppmteUJMGcfV8XP
         sBHuT3YwdJW9a/eHLqFvHjn770TrqNed7/ekT1S3+BI+4/RDrn+ZvgOv4dQ9Wr2FZ4p5
         wr6LHnYvrn11l8wDRllEFw8X6FyTq6zwPX9bOsujB1bK6Kq13+dIQA9nEtLb/rLWLYsf
         jJuYhL9nZXWxjzhfMiWZ9meLOvOvjz4NKQvcb9cKZliQxYS1xUeVQO8QR8tx9m8E0t+w
         UO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007572; x=1729612372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sQCvJD715/TLzicIGZLXAFOT6C/C41EPnvD4MXjx14=;
        b=cq3bf82ufkHApRWPK++yqxCuR3nuRw6eSv4PPjQjDpqJaBDaE6PaPOTuwkMgpEF/j8
         IBXco2aMiyRDibMHYgN45cyogcdNyjKv4RZrDb9Qqr2onAej32gpWj/IPRp2VSQGE0Tg
         7z9pQnflt7KmeOMjdD0UxyuKWsVhXYrLDkgAWyKOUm4HD54r2p5F7lO0KcsOjnDkzPEL
         uUIUw4CPdzmw27+qBzXF4WcvMBsNpnewZ2d6RWCGmFghhsrpfJ+dSP+RqlkAvqWiIiH6
         GG43xoiyp69uu351KcjJuqXFu6XIjT8ffXgJW5qWkiwEAUOw+pbbIxdT21jQ63gzApbm
         hv5g==
X-Forwarded-Encrypted: i=1; AJvYcCUY7FglM/Dkt0/XuhNLpBNPGfUr/8dYp65r9D29u5lEuDod9QBvDFlr836Isb7X/x+9JHxXkl8VHItZ754=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32Xu9d0ZEt4ELda329jI0LIRJDkQ42J777lQIcsaJzojXb92c
	CYI7n9gzjP+M0ZuCf0KTfVsX9O462ZRGwmuJ+t0on6AIOD99fJkEfXje6W6JuoA=
X-Google-Smtp-Source: AGHT+IFYPaqAglwoiW7FHEIVR4+5UzMRm39kklNaQpPpIeLzKJbmzNPx6bNLFhbFFP3WXff/8vy8sg==
X-Received: by 2002:a05:6a21:a4c2:b0:1d5:143d:5197 with SMTP id adf61e73a8af0-1d8bc8066e8mr20649901637.6.1729007571724;
        Tue, 15 Oct 2024 08:52:51 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2561sm1461753b3a.97.2024.10.15.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:52:51 -0700 (PDT)
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
Subject: [PATCH v6 4/4] checkpatch: warn on empty rust doc comments
Date: Tue, 15 Oct 2024 21:21:39 +0530
Message-ID: <32382c55dbcb6482d6e686d541c2e15b282908cd.1728818976.git.hridesh699@gmail.com>
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

Add a check to warn if there are consecutive empty `///` lines in rust
files.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1109
Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
v2: https://lore.kernel.org/rust-for-linux/7877d23adba22e2f89a61efc129ecf1b0627510b.1726072795.git.hridesh699@gmail.com/
  - new patch
v3: https://lore.kernel.org/rust-for-linux/bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com/
  - no changes
v6:
  - added --fix support which deletes the unnecessary line
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c390a9926cd5..baadc345bf87 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3911,6 +3911,15 @@ sub process {
 					$fixed[$fixlinenr] =~ s/\b$header\b/ucfirst(lc($header)) . 's'/e;
 				}
 			}
+
+			# check for consecutive empty rustdoc lines
+			if ($rawline =~ /^\+\s*\/\/\/$/ && $prevrawline =~ /^\+?\s*\/\/\/$/) {
+				if (WARN("RUST_DOC_EMPTY",
+				         "avoid using consecutive empty rustdoc comments\n" . $herecurr) &&
+				    $fix) {
+					fix_delete_line($fixlinenr, $rawline);
+				}
+			}
 		}
 
 # check we are in a valid source file C or perl if not then ignore this hunk
-- 
2.46.1


