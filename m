Return-Path: <linux-kernel+bounces-366193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1657B99F202
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE45282D31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457F1E9096;
	Tue, 15 Oct 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU4OCjBi"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782581CBA18;
	Tue, 15 Oct 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007563; cv=none; b=CgZqA9c9UU+EvgOjS/Bg7IUay8dzJCQgBeQgEYkk84PqKbM1j5S+yAJXreYTzk7+GrlP1GIkWvqhD9S6SiXI+33sILblFvxyJO3wWvFKTZ6bxyPPIpwm5/UleY+DLUzwbejE5GJ0tdjvQzO+FDuv5YjK5wlaelwvulvoPqSc8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007563; c=relaxed/simple;
	bh=uN1REU0Di5I3mklfKwwzumFIR1apUk4/wC9sJd6e83w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtcE4B//cs4PZxhOkxYxsAhKAFRmrO7wp+ddI0bO/h3yu1DvdUHcT6UwCXBDF+K89K3oK+LfvfgmKsnmJ6NvEd9J1ACUE+Wk+AJBB+P3aR2RI9IhxDkC93UWcVMzxW5jA+rx2Yd0y8d5GwsXLFGrVPiuCGBrqOyGyuFYFk77i6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU4OCjBi; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-288642376bcso2452534fac.1;
        Tue, 15 Oct 2024 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729007561; x=1729612361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrJdz13VBM6PnyfIrWk3YM9luzWUsilA55w4yeLkO7s=;
        b=XU4OCjBipdYW0yE0++7DKe4MZF9gaTMeZF3/JI/DYzlYV1qEGDdAkazashJv16zNsn
         Md4MdIgrQlCAff6nuJnst3RdwxGi1+Fx9fc18/WVuVpu/6vqhj8/87QdQIdKkTPN9aRO
         wmin+pP/LJEWmD3T4dBpQE/zZVcF1uXADf2Z10EHGRMJzWhTwKHVDZmCcPlWT0AZMfGw
         asgJd1eRGw181bzirm5p95yyqwKVIuzcsDeUgUAKXP8QCVjOKVCRUJAeS4QxnX+bZrBB
         n3XGQS0pK2VkMHGEEdgfcGXxvbKL4/qV+HJ1Z++5wxNLhzIOU+NUqQ9DMEhw43JtZDrL
         zEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007561; x=1729612361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrJdz13VBM6PnyfIrWk3YM9luzWUsilA55w4yeLkO7s=;
        b=Qh3W5ewXL50AMXrNIoTW2nEn2IvA0GlJSKIVA6Og7oBpRJ4yQmpf0Eym2XJTlUGxAJ
         VA3xsjptY9+s7QJQESYLGPmVxDVSJ1JmP7jXJELk7XMHKz2b5YnTVZuW8HtJ1iXjaEtK
         xSLsOOV2cMLHvItu7NNnYrZL5Q9NU0YssOGfSVub3k1bxomFldq6COpoyn8RskunMSkT
         cy9G0ILyDhaG31aQoBfl+uafTPaw+wUxKhVS6uiyIu+GkpHUB1HvMJChlgwOdf5Jjss6
         m6DFR5EwUAFN9GpnrWnFXePHmAI3WoJMlBBhA6XJc5ymh0S6BYIdajZjQG8cTEBm/HhH
         9dKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfFfPBVpZ+0Hs/5KeHZDIDAYGvXnDmM2m3gUq3oOt6inDPJUWK3Q6CdtcS1qxaAnn8RXI3/2yFe0omyh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wdTXDiI/XDhewob5CFA4VESAdrBAEOeLnYRCwPmqYARt1sLm
	pGwKOyXKIfbU0gBsLdby/5KKo/Ly2Ixime/0ZYxaGR/klBcMkcdkrQp8obUYh20=
X-Google-Smtp-Source: AGHT+IGvIvlkwmUzaoU7B8CSaATLdDpPybawEbZcgXCffHNDVSH7wRChKyPeweYtqsa/fce2pakVGA==
X-Received: by 2002:a05:6870:ac26:b0:288:2b44:5577 with SMTP id 586e51a60fabf-2888734357amr6494708fac.18.1729007561144;
        Tue, 15 Oct 2024 08:52:41 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2561sm1461753b3a.97.2024.10.15.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:52:40 -0700 (PDT)
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
Subject: [PATCH v6 3/4] rust: kernel: clean up empty `///` lines
Date: Tue, 15 Oct 2024 21:21:38 +0530
Message-ID: <5f42e19fe52adc07d44d1fde225e8d933fde54f8.1728818976.git.hridesh699@gmail.com>
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

Remove unnecessary empty `///` lines in the rust docs.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1109
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
Changelog:
v1->v2
- Fixed typo in commit title and description
- Removed backslashes in kernel::block::mq::Request
- Link to v1: https://lore.kernel.org/rust-for-linux/20240909161749.147076-1-hridesh699@gmail.com/

v2->v3
- Fixed From: tag in patch header
- Link to v2: https://lore.kernel.org/rust-for-linux/aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com/

No changes from v3->v6
---
 rust/kernel/block/mq/request.rs | 1 -
 rust/kernel/rbtree.rs           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index a0e22827f3f4..313334b1bf18 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -30,7 +30,6 @@
 /// D) Request is owned by driver with more than one `ARef` in existence
 ///    (refcount > 2)
 ///
-///
 /// We need to track A and B to ensure we fail tag to request conversions for
 /// requests that are not owned by the driver.
 ///
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index d03e4aa1f481..c0730c1f9707 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -1034,7 +1034,6 @@ fn next(&mut self) -> Option<Self::Item> {
 
 /// A memory reservation for a red-black tree node.
 ///
-///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
 /// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
 pub struct RBTreeNodeReservation<K, V> {
-- 
2.46.1


