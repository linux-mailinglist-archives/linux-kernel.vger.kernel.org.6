Return-Path: <linux-kernel+bounces-330459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8D979ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E10BB20E58
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7D14B967;
	Mon, 16 Sep 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKD0Yiqq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AD14900B;
	Mon, 16 Sep 2024 09:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480489; cv=none; b=DF0ojBJyvzWBn+cHjLZst5Kx96d3OkJLusMBXf+Kv/lYj257CKkxnkRzexaCk8LwIP6xpLCJf+msgAsMN5aI9c+B8Mw8rUMGPFEsEnBuKUSIKeRqaaV9T+pEiiuJc/a3gPFiqUAx7du2BXjP5RCaLqcPWttlrrSu0cLfXkYfP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480489; c=relaxed/simple;
	bh=/mF78CmISjMAeM9ETh5R6boWVf+mPRmxubAiKOXzW6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snxcySv0EbDGmEEqvfHE+ASUO3jaE5ysWRVNfigBaflFmQtUFmFOS5i24IQRuO8Fk3vw2PN4uruF5rDjRKwyVaCNP+HDvtvPvhMQkr6+bvk1COzUko6awNkt6vTfyUQBDcmOit/Q9CnY2okoPirp8YNYOiQTtukBmzi2EfNBbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKD0Yiqq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053a0bd0a6so42631255ad.3;
        Mon, 16 Sep 2024 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726480487; x=1727085287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t36oXNVlAeqd61XcbUSB6cnA9J3g+hNJhUgNCRHHaUI=;
        b=XKD0YiqqUXmL2PmsaZ0UI27EtgHhoju5vM1z3WcpQhwT050CAl/KGxqzkysRj1tOhG
         iR+c5UsDdQdl2vU6EwTDp2zG8Un+f6oNHKj5/vQwUFjYg3OO8X3et8L+Rmgffxr1owta
         4Pdi1FClbfAt2Pe2BOEKz3GoT2DN91cUfxoow+tCx9mY9tKuCDhXd2XCxJRckmrCoAGM
         pebUneBBaQ0emloRr8Ujc9KLo1O7OaQ9aLnlk0PeVeEj9ZqcxRAd7OBPNHShW55oCi4d
         YyRg0oHovC7580MUaBC0YQL5YJJ/FTpdWmK6Efj5n3QUw6vpwzK7DW9wil+hM2MzcZkU
         rE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726480487; x=1727085287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t36oXNVlAeqd61XcbUSB6cnA9J3g+hNJhUgNCRHHaUI=;
        b=J83fi54vMZDT940XNXm8Et8fTJhDLIJnfXx+PjCx38RGfJGC6dX1i17TAWI3z4U78p
         lxM4UkKbjcuWocPhA4sdUH/VT30rQAUs5cDhlr1a6sdXHx7pALqjelECOgOb+gQh/1Yz
         S1dZRpmlVMDmENP/HJ8W1hr5YH3/0nVrHiwadJnhz9zvDOuT2sbuciFE5rfYLP/rz8f6
         wgxDJuOunjlx3ojqWjImpjiNLR66DqpsCpTRh4DVmuyzF5Ka8Cx+rxTBnNgWSwr2h5hl
         spscfRdeGtkIcL2XTOM6EcLpWQeHgfwP0b0QSZ6EKRIqTjg8iIfC7KY9WRH9FgSNeE6Q
         +Oiw==
X-Forwarded-Encrypted: i=1; AJvYcCX3u/2sVY7GHQqLxAGwEmcYW2pdR/2LlbbY680ahivBNt6yA3DdjiAoI3NXAAF6Byi3gCOAJCqb9ixOpu+EDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCLxoXHMrxu0/rTCT62VRK5Kz3UrgNHb3Z3lg+kV911BKPTcj
	saIpKXZrCe0NK66QbNuYubXtHbzYup6c9nkPZbCd9ncw7MqzEw7lEd/PknJ321o=
X-Google-Smtp-Source: AGHT+IHJ5Ph4W7b77xpNhiixsZV2ICt4OnnDHD4/NKOin9jP2JtZqUMhvCj3/Mp+xVwM1w+t5L4Sjg==
X-Received: by 2002:a17:902:dacc:b0:206:96ad:e824 with SMTP id d9443c01a7336-2076e3f8978mr269567005ad.45.1726480486810;
        Mon, 16 Sep 2024 02:54:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:32f5:9b56:32d4:8d34:c09a:f2f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945dc51esm33033895ad.52.2024.09.16.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:54:46 -0700 (PDT)
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
Date: Mon, 16 Sep 2024 15:23:40 +0530
Message-ID: <22250c3f011a324ed4ab99ea0925090b824ffb8a.1726479606.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <320d4bbc9d6f60964366406c4d9903906f5ab0b7.1726479606.git.hridesh699@gmail.com>
References: <320d4bbc9d6f60964366406c4d9903906f5ab0b7.1726479606.git.hridesh699@gmail.com>
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


