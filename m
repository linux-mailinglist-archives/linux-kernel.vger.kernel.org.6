Return-Path: <linux-kernel+bounces-342939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BC3989501
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA4C1F21585
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4516F851;
	Sun, 29 Sep 2024 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG1AGGlw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD416E892;
	Sun, 29 Sep 2024 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727608554; cv=none; b=mCpdVJdIpfaLYzmxu66XstsDDyW3l0L20Nvf+V8RY6l2HZgURvkmn5mGPHdOeXDqN0vZiZ1RoZ/KjKsGFgQSKo6EURCn9eyaB/ZHwRYJ6pwVVDND0R7wK4CjZGTH0zDiDLRE/B544b8zxzz9mUeurz8XRbbEDMSC70e7o533eNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727608554; c=relaxed/simple;
	bh=bsPnFCeG+JvsEtzpEBodGj/MudZC2AoZKW9XYzSwsNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMzjIG/zhhAD/KizCtjXPTNQ3/8RnDKt9ZeLSUgs8NJqLEpn/wAvBasAWxPqXtzaeZ6ZgwWx3Ww0+ffWKqdbqEpZ3o41URjGFTn8wGq04PMXxZ9U5bqa/0IM3Szi53OIpZ4+g0KvJf4IfiYPKMIRqXUg46TimDFi9R8DoWYUaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG1AGGlw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b833f9b35so449535ad.2;
        Sun, 29 Sep 2024 04:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727608553; x=1728213353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9AVQtrT9ThGaeXMgQ52AtWh3TYRz+l/TvjuslOCM3E=;
        b=SG1AGGlwNM6qwNhaVGSQxQeHn72skVRiJreBzXWqifVCuYlbIAGodAs/Nbl5i9oieK
         OJ9YJgFLKcNutDBjZQx+byU77WhXlvHPcrgCzoSsMM5m6YgiNGq1mcmC2vb8CPIdth1L
         JbZtlpp4rZzzujW5N+MEtMvTA+dIvAa0mE3oJE9n65YnzXWMDYro7K+Qjm0AFM1ycIZ1
         v1uzdEwicIbYAOl7Kkwz8xHM7e5JKuLfhHr7QOUwJAiyWV4YkdMneQFrnMA/dVvGWfmF
         ANUL/wEPMDS2+hAYs6LDKbR4eO1qDcXI+I0lOmHT4AhB1UhShUrkFwgkCutMHW4SkxW0
         JKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727608553; x=1728213353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9AVQtrT9ThGaeXMgQ52AtWh3TYRz+l/TvjuslOCM3E=;
        b=oqBrBt0SL379Qwse2SNCOiGrZE+Y1MeTYQqa2krTDiaSzQ/EUPPCKHxfzCci1aGsur
         2tpYxPPIhDdTkb3YDJw1XgGrjw6YxiCgkpZHbdjX2N/mTXFv+l0ziscNmj7+A9FH4FK2
         vf0iLV6Z0gPxULfkQ8t/HzNzMCGSbKX4N7DIvCrJgRRRldnNwfmxGGGw5XXqIcWpCYkc
         RPJRtq1zYX56DunvBzQPozfvU+3UrYvd0qJyG0rQ4g0jQDTAbcA2TKl6wfFD/9Q2rd+V
         Nwxcl8DCOky2Ma2t6Yv0cWtt1yierNOn85hhf/p697U8wS3UZh/teQCcFQLPErcadNQB
         CbgA==
X-Forwarded-Encrypted: i=1; AJvYcCVuz6KdYXbhyuLqFhqCr4tFx55LUHAW2vukvGDxQNzmr8vy5hw2V8X4dLOKri/S/uGhtSNIkTdm3byzd2JE6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsuOUJnBbS3vEgV33ZOtdALRB3nivWxhMV5AzOnHeS7w0eWP2
	GVkJ6LxlLTQOzT/DDHfvv1LhftbxunJnKz+JRFXdxLKyhFCnDrrNb0EBS8OKjSMCLA==
X-Google-Smtp-Source: AGHT+IGT3tQcI14d3kx8C+9kfWSop2ELerA90t8IvCPdfVU02vMazoyrOHANFcR6nDoil78y+0B1QQ==
X-Received: by 2002:a17:902:e5cf:b0:20b:5a2e:9c53 with SMTP id d9443c01a7336-20b5a2e9e7emr61105465ad.57.1727608552476;
        Sun, 29 Sep 2024 04:15:52 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([2401:4900:6875:87f:e24c:5aa8:9689:9176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e63cbasm37978685ad.282.2024.09.29.04.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 04:15:52 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Hridesh MG <hridesh699@gmail.com>,
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
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v3 2/2 RESEND] checkpatch: warn on empty rust doc comments
Date: Sun, 29 Sep 2024 16:45:24 +0530
Message-ID: <bf6544faba2b53ce901b2e031f3d944babcc7018.1727606659.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
References: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
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
No changes in v2, this is a new patch
No changes in v3
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
2.46.1


