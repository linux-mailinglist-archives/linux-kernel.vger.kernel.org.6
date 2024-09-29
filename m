Return-Path: <linux-kernel+bounces-342938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E3989500
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154241F21575
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A4615FD16;
	Sun, 29 Sep 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipiEoNiu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ED2566A;
	Sun, 29 Sep 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727608539; cv=none; b=McTjS4OAba4vq5krkDO0jGNNWUWF+eq8ZvrBrNtT5QJ+xlaxRL9m5x3ToYYkIFm2pUduMB1kEb1gy8vTbKn0haiwlKbDpDRwo2lu1CcprmiguM2vXSOIB5CzG9rZyJxhW/11LdGMBAM68wh5+4+gcVKcrLIIBj2JOb68xTPQIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727608539; c=relaxed/simple;
	bh=DgrRPPlafnmB2qsdkk/HDLH5QeHR5NK6i4zLkW9bPvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eRa5eZzpQk3NmCBITscMhI1IhcZvY7FdLldi9gSQx/iNC0eq/WOvAhUpLyaUjwxzLiO3rLQdP1KFc1OkKUITAa+qulRd8cxza+W7LasZgZEVuNVgX7BIXdBMsgV1UFmWiN7EOm1WIj8AP/LhdnuHLtv9+WPDXI9dyqtFc/p9p5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipiEoNiu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2057835395aso37764225ad.3;
        Sun, 29 Sep 2024 04:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727608537; x=1728213337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gpg2ZDt70ZWqdKwXPQNweurZkvJMHHsrsVb/deHCRw=;
        b=ipiEoNiuQboejXdtFXC/o4jL6IS7RbkjuhbFtsjmdQIGJjACzJDbIvePl+B1nb9Wva
         OFf+AKtXP+TAG8hB8EdeRGOxaqETOpyPZ/Y7asYsckOMFORuogfz4EpJsjn+QiffLMQU
         Gw3ZPpgvZbqRCSFMlJmlqLDtP2HbXWjSRyy8zAJqaZAP6pRewZTLs3spt8Li6TXHP/Jk
         jwALkq9ADRhFJyd2/9q2JboNN037rVJROp+Sef7SVG6vz5manCZALd922WSgP4iam+F/
         XFihOtIIcvmf09J/40KwFtOR08WpTochfgiNqR1DJwfnlN9SLLsinft07ocRIEIvo0Wo
         XR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727608537; x=1728213337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gpg2ZDt70ZWqdKwXPQNweurZkvJMHHsrsVb/deHCRw=;
        b=eMNQgfNy49WcwamdacQpXMkiWlsHw4jCcIvSa+T76t/9sG6Vcr+20GKJU5vz6tiwNX
         wA9R76DXtxoUoec+4MmWmakA2MHBsNtqqY8crA+Il0fdwt3fkPD5sYLWEPEEK7pHR4vi
         ZzClEKJnvZ59nYzasnRVTD78gvzj4pSzEVZB16Buu21DMFJGq0PXV9j6XKdCtGTbh+E8
         3uO7fK0Wj2h++970JauPvtADXHPRLdxt4Lx+zWp0RDSLatLAqDiitSJgr5Vfcn+IwF/d
         SlNK2NPxXlFh6Eeg9W8axRuJoMFBl3P12c+UvunTYC812UzOuX2gVsxUvdCMQL662oYG
         yLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7Apqtlf9I2si36Lzmu8GX8VOB9rhp/RCeS/8vgad/aYrM3ZYvvLwviQyphqFThX8rQc1AkmNuVZcATHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSRuEUjLHOprklDrd/W3SxSRJcENBSbAm2stXHuUSghSlPISyY
	+1649+Wfussdalz3i7HRA68rvOnQwNwNCwmI8Qp6u/ve64iWC6SgZ1s8CRRoKLuv+w==
X-Google-Smtp-Source: AGHT+IEkNbbcGJsyfF4mOcZ0PHb3hq3P4cr+YJFm+61tuVgx+PrASPFMNB7V7yliM5JTkWeiz+ptSg==
X-Received: by 2002:a17:902:d484:b0:207:5d33:a1b8 with SMTP id d9443c01a7336-20b37b79d4bmr130838145ad.38.1727608537154;
        Sun, 29 Sep 2024 04:15:37 -0700 (PDT)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([2401:4900:6875:87f:e24c:5aa8:9689:9176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e63cbasm37978685ad.282.2024.09.29.04.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 04:15:36 -0700 (PDT)
From: Hridesh MG <hridesh699@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hridesh MG <hridesh699@gmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Jens Axboe <axboe@kernel.dk>,
	Matt Gilbride <mattgilbride@google.com>
Subject: [PATCH v3 1/2 RESEND] rust: kernel: clean up empty `///` lines
Date: Sun, 29 Sep 2024 16:45:23 +0530
Message-ID: <dbb63b5698aa507bbe3dec54b4458a3f151899d3.1727606659.git.hridesh699@gmail.com>
X-Mailer: git-send-email 2.46.1
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
index 25eb36fd1cdc..006f6e03aba5 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -1031,7 +1031,6 @@ fn next(&mut self) -> Option<Self::Item> {
 
 /// A memory reservation for a red-black tree node.
 ///
-///
 /// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
 /// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
 pub struct RBTreeNodeReservation<K, V> {
-- 
2.46.1


