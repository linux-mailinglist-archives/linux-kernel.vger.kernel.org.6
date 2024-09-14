Return-Path: <linux-kernel+bounces-329474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE69791CB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAE4283F56
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D5E1D0950;
	Sat, 14 Sep 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz3Z9hBr"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC6179BF;
	Sat, 14 Sep 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726327488; cv=none; b=rekGvS3tL7Gh+WuVGwLtrT54YDiGjJ2WGWkgcsNckSoFtV1R8VzigG1PmSIrGJsWqtk9XJ/Dkb2Ymc9rrAL7gvQdH8H/7Qg3XsAtwzcXN5WtpxzpZKn4LcyX0gW+FCKj09DU8w2Ip7DATjK2iDZCxRUHqF5WV7k7jrfv0WzapGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726327488; c=relaxed/simple;
	bh=/mF78CmISjMAeM9ETh5R6boWVf+mPRmxubAiKOXzW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UoUOr7vmJvktXxKg20Bsk1GTYnUUywq72PoPYFogAVLc+RYePvsUBnF39sM1vvT+t+RnTRcsFielWS6Is/HiG04FvhSJqp09lEVYCG9XIXJ1WPam36KpmJTroSQvaL+jHz4cS8qVMXMRrgAeto5gOc7+YNNxhGoSTqdo06JOMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz3Z9hBr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7191df6b5f5so2257267b3a.0;
        Sat, 14 Sep 2024 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726327486; x=1726932286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t36oXNVlAeqd61XcbUSB6cnA9J3g+hNJhUgNCRHHaUI=;
        b=Jz3Z9hBrEXk83w9AssPYFyJ2nJ8FF3aVYlDQ1wYzAciosBKzyKl0nF1Q1so+dJ5xeg
         Yu0dkRNeWnesMyzDHaj00rSgMauXIbXkmRckEES7ZfzjFLbte/yQZ+9WYueRdMfx9K5j
         mpGN+krb87cjn6ttca0q3MJK2LlgEU0T5rt2GZkQ749KJnlvXdmaQyIZBef245lz+x19
         SaeZDWMjtT0bdi25rx8iDuGmFCEZOUfltsYzPscDzXx7NJBjHfXu4flCe2p2AlXDzuMm
         OiL3OS1m7AqnnX15LgmvSDhK4QqpoZtDuFInX4fr/NsW9suqmbbMlWjqmuN7j8GW+Is9
         RtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726327486; x=1726932286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t36oXNVlAeqd61XcbUSB6cnA9J3g+hNJhUgNCRHHaUI=;
        b=vHEgnL+w+QTbJXuZl772tzR4F6I91CBb0xftpdf1OFYfApU/evTeZhZI1wVh0i9iUr
         v9s6aaZCZyPcpNylPCMhH5M/pYyygFLWaZIyLN0pAzHWer5jRQdOs7iRcX6Uhic+iAYS
         nE4OKiI758HjEwJjIwrZsPIOSunolx5shubNoVUxYzyHo72f1FrUV0oju6mBa/xz7xr9
         A3NliLIRvf7RxQJqlDBNI92WMk6MBBeHEF/xfSayy4tcCJ2+J415CawDoYvuSjdTulZn
         AEBD0mEJ2aYKqWHL7M5iZ2pOqAJuTcNkxVYhYxnepGr6BBmO2/0jXZMkp5O/R1ou3E0T
         kk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgb0/68Ae3X8ZtxTM7c4EgGhdlhOkUNAIbNC7JtIVePaqe5mslZF6HQo38IruQe8fOVS5eIVEKu6L2gEUogw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIc81RAZcdArv0I8a/687lvAvBIPJSkNVv7GUH6CRgC99/CHa
	TAuATDDS/g6boaMAM9LxOO42PGtZwu6ABArwQL8UqeOESY7TIQjDCaOM02eSI1U=
X-Google-Smtp-Source: AGHT+IFa+Bsp1DEtyaNCbsWORDxwH4y7rTN4lPjYwPHTEugiagfgxbC3b76L0HbmyLi9JKCrcPSD4w==
X-Received: by 2002:a05:6a21:3a41:b0:1cf:5b31:313a with SMTP id adf61e73a8af0-1cf75c7e923mr15063676637.1.1726327486187;
        Sat, 14 Sep 2024 08:24:46 -0700 (PDT)
Received: from Hridesh-ArchLinux.domain.name ([117.193.94.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b301sm1103898b3a.107.2024.09.14.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 08:24:45 -0700 (PDT)
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
	Trevor Gross <tmgross@umich.edu>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 2/2] checkpatch: warn on empty rust doc comments
Date: Sat, 14 Sep 2024 20:54:29 +0530
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
2.46.0


