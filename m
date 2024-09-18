Return-Path: <linux-kernel+bounces-332952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F250097C14D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110211C21BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4B1CA69E;
	Wed, 18 Sep 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DnxDSCL8"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8FF13792B;
	Wed, 18 Sep 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726694472; cv=none; b=T65xECBYeZE0o3njKeFam6t/FBFUZVT0ErJZwJo7d8FaQ3KjYwHi4WnIdu57U/rix3Up87eWUlJN8eLX2s4H4FDk8lUtFHGaaI0t2aRBsL6wSOHOiQk04I1BDw2vKMbOtWuiyzihWQw+gG3IW5opmf7LqEJsFDcmsYymiKIl1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726694472; c=relaxed/simple;
	bh=GK5S9iKp79ueNMdTOZBcBx7mwwXHMNSQ1nxVCDlFJus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaNUsBPdoNGwtSjiLSZ85UZIpqArgvWeoPeE8Q4e0k27uR/8s2t/aIiEmere4cDcTNrzVl54UGHMY43uyqD3QRYAaEGuvcXi6A0IZhPbmI3VvFFOGZgIYv2Gm4/Q072bYMRK6bN1d61zFh11uh1nBMhC7fLUAFsSLQJ3q1KmDxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DnxDSCL8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from nell-kernel-vm-08-09.ejenzozri2pedhiq2wfesci2lb.xx.internal.cloudapp.net (unknown [13.66.192.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id 485FC20C0A0C;
	Wed, 18 Sep 2024 14:21:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 485FC20C0A0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726694465;
	bh=2MMaw3724sZ++Ne7FpHpXyS950zBAoGoyZ5LANf+mfE=;
	h=From:To:Cc:Subject:Date:From;
	b=DnxDSCL8Cv+dmF/sr+oXK86ZMM3mytYbv0W18URfNVJ58Rqbn8WN5BqE10HDRbGkr
	 eKw82g+ugLL4QE6BkmJlIQYBYnpqRkdQke0aVpwBloDYuELlYZ12nbVA68qBvB6Qsc
	 JNrGaLD31Alq9LfaAzxju3vMB5ZIqhbn2NnqOiDc=
From: Nell Shamrell-Harrington <nells@linux.microsoft.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux@obei.io,
	kernel@valentinobst.de,
	kent.overstreet@gmail.com,
	matthew.d.roper@intel.com,
	kartikprajapati987@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: types: Add examples for the `Either` type
Date: Wed, 18 Sep 2024 21:20:52 +0000
Message-Id: <20240918212052.8790-1-nells@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add examples for the `Either` type

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
---
V1 -> V2: Cleaned up commit message and addressed review comments

 rust/kernel/types.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9e7ca066355c..e2f3ab11cfda 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -461,6 +461,15 @@ fn drop(&mut self) {
 }
 
 /// A sum type that always holds either a value of type `L` or `R`.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::types::Either;
+///
+/// let left_value: Either<i32, &str> = Either::Left(7);
+/// let right_value: Either<i32, &str> = Either::Right("right value");
+/// ```
 pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `L`.
     Left(L),
-- 
2.34.1


