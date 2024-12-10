Return-Path: <linux-kernel+bounces-440420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52DC9EBDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC0716929D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D19B22914C;
	Tue, 10 Dec 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+Og2Fpb"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385F229137;
	Tue, 10 Dec 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733869006; cv=none; b=ARuyVQ2a9od+nlgsnQppPaIy1gwfhK/g0mp2vE/lNNkW81f+8otAVRmt87xnSFRsVwECS5VeHTpmSz1MlR2XzepFAWdVt+T58/CCbShJBabGAGpucAZSeFQpjBPGHbGu3QvMnJ8MQ6WR1KQoWVtT8tR91ZOKCT/xfuhRlGi7IX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733869006; c=relaxed/simple;
	bh=GemqW1wx2Zr6paMlaBSC9NsMGFDzwO10UQsFGzL0Yf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTobQ6JlL+H7A5SC4ROyLwdHDq9v3s0Mht7oM7m6GuaB0B5GZ+3hdIpVXzU7teBKYMPp0fASvZiTcCGRrASihcRNpftR/K6RJr/Cn2EByC/xrzcPoWrVeE/EYnG5R21w/dFmjXEEyRKLit2zWS3k1/iLkTbETbE70aoLbA3LLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+Og2Fpb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c68b89eso101536e87.0;
        Tue, 10 Dec 2024 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733869003; x=1734473803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q5eDyei5ksXYu0d0JSpsZg8ILiim7eTaT1jDdxHxcxY=;
        b=k+Og2FpbWHFXoAresFeGJ+kiFXvSD/quYedwiTZ9+oFbrWYbLnrkuYegEA6xo3zBI3
         CjiV7FSxP2PeTAjkRjlKmv/GviVW2R8q1GfEnS2lIC9Abob+t0QA2KW+T++fPTVaxkyb
         Cx5ljgdp8IimpTROpoCfgOX13CkH3XmfR0KRAsVe6nrIZ6Lc1kzaToV+CmsTtx6+SG/Z
         zK4Lc3lBOyXaiaU00y4jXel+BYdR7RHymgTQ78cjyraHnJiSxr5uV4kfS/gWgCGTBWG5
         nFuPG5rQXJ2wx2iEGIYPnVQZyR+1pIDfdjp4SFjLBOX04sABwPagu6OC9XONhDKFVpbw
         pftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733869003; x=1734473803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5eDyei5ksXYu0d0JSpsZg8ILiim7eTaT1jDdxHxcxY=;
        b=tFIeRoR85o2iuAFvZ8PFK7Ql42OeffMzmc4RN1jgWPmkD4GWj6fQBPmfFpRqByknA8
         SKZ9m6ZN3AckQFnUEbh/0i5ugFY6S3hTriAW9Ev3rlEwoldmCSPO0pivmKklkDNPIxyq
         HGZS4IGPRO/TNaxSej1EsGeqhgNAYOXu2z9fqk07n8p5CdRXIi/2gMXkY1b4X1ywI2Pw
         WkdeVS7FFuZjUAK0shFlwhBIn+pxfESKsgEhaNsaKWN4hOclRBfafb+PkgrObELdkS9n
         QToVpxFYuTI191eqj3K2RkOHQwOAA9ESMVaQNEw9nDpQ2N07flInr8URUTe/zLDn1/rU
         HtTw==
X-Forwarded-Encrypted: i=1; AJvYcCVtJUYncslKJ5GlpM2Tkw0sUO6AwMDIoUX/1OSeORyFtQWHpNiBC9RyXCl7W/Lts7RpdAQ/YpQPyPHzhAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMalwhTUbeRb9XlkywBFHUBFSm5ENiYLIWzTWOej/yTAQqgKGG
	2P9VUJMifii1sPXHSfGW/2U/ndnk2AxgP8YUnXOnY2Ue6BW3O3lxMIXjxg==
X-Gm-Gg: ASbGncuZZjRO3X8dcLlwdvJCoXVFHHCWsQwXYR3lBSYNeteD9uqqivo5X6QPsu7ONF+
	Sby/YFliWy1H0TODQzyVU4oDRQwEIN/zO58blCFJQ5BRB9AmArwGpjTKoZ3InDp6Lb4n4UP3qd5
	0YiceWuLYEg9lgOROQSQ/UUqogqcEQK2YTdQaz1ybE6n9bma6JDVabdcB2adoT8RI6vmoGLUPg1
	0KmhZOMu74SrN9+Q9kH3isNI/adwddebgkxUHrwuNn8XisN7cJM+QqL1dNifyVRT0xplYW34Wpk
	zzu1WQq3HWQnVqBr3k44ss98
X-Google-Smtp-Source: AGHT+IGYXyjdGUb83ke3duPPcomNuJVXRVbSNr61MJVyyjJUySl5R3d+sPrypSylJfWAJ07lr2F5Sw==
X-Received: by 2002:a05:6512:1104:b0:53e:2098:861d with SMTP id 2adb3069b0e04-5402a7569d9mr113730e87.15.1733869002359;
        Tue, 10 Dec 2024 14:16:42 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e34a4531fsm1472694e87.262.2024.12.10.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:16:40 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v7 0/2] Add dma coherent allocator abstraction
Date: Wed, 11 Dec 2024 00:14:57 +0200
Message-ID: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v6:
- Include the dma_attrs in the constructor, use alloc::Flags as inpiration

Changes since v5:
- Remove unnecessary lifetime annotation when returning the CPU buffer.

Changes since v4:
- Documentation and example fixes, use Markdown formatting (Miguel Ojeda).
- Discard read()/write() helpers to remove bound on Copy and fix overhead
  (Daniel Almeida).
- Improve error-handling in the constructor block (Andreas Hindborg).

Changes since v3:
- Reject ZST types by checking the type size in the constructor in
  addition to requiring FromBytes/AsBytes traits for the type (Alice Ryhl).

Changes since v2:
- Fixed missing header for generating the bindings.

Changes since v1:
- Fix missing info in commit log where EOVERFLOW is used.
- Restrict the dma coherent allocator to numeric types for now for valid
  behaviour (Daniel Almeida).
- Build slice dynamically.

Abdiel Janulgue (2):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/dma.rs              | 223 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 4 files changed, 226 insertions(+)
 create mode 100644 rust/kernel/dma.rs


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.43.0


