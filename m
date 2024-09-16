Return-Path: <linux-kernel+bounces-331206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229E597A9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E762877D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42C1547FD;
	Mon, 16 Sep 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n88H5tZM"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0D3381C2;
	Mon, 16 Sep 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726529721; cv=none; b=kKXIJnmxgK2OtHrRnBx3geDFLmSIcwc5Sg0FNE/C4mBrUYx0sZ/q1YV8si/Jd9pJRqvklhT0Sh255RuABfCzyiGEDsxIgEuzEGjtzHw5+Y71EhcYynUo+8CS3MiIoFvvmAeff6wmACi4Io3Eo92YdGW3zMaRHu/wdLbhDKLbxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726529721; c=relaxed/simple;
	bh=uObNZQ6eDPXeqgv+zTSIzRN0CZenM1ZZ0k901t9ysEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1hLq+DG6aD8+Upj/RF28CbX3hZDoEUuohkG/O8wFT4hOXFvIYQMl0FxJ+kfGuBZeaIuU9JEkvw8DxLmKHFQpbd0ng+hxKmqkGXy49aU6JLv5xDKRrF/Ia3qU0t1b/Fkd5PvPIeRD1Ug3F8ujsFwzbKSqcatlz17ofw2doLQPnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n88H5tZM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from nell-kernel-vm-08-09.ejenzozri2pedhiq2wfesci2lb.xx.internal.cloudapp.net (unknown [13.66.192.56])
	by linux.microsoft.com (Postfix) with ESMTPSA id B218B20C0948;
	Mon, 16 Sep 2024 16:35:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B218B20C0948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726529713;
	bh=WpS0syyJZ8aEELqL2HjUDFgqXoXkUUjModKEFleQTzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=n88H5tZMKmDHH9bNuezcKYfNlv+Pg2McHEEMD35iMF9aGR22CIFi4TKfDlFmqBN2I
	 /a10RbXj/XytitErLWDXU4WAijs4wyL/66WnKfhbWOQAdIRNNNtRk3bYn6r6yL69PL
	 Ahp6eKI71RFYwIQ6A47QAIUZsO2u4ygkhWFtl7wA=
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
Subject: [PATCH] rust: Adds examples for the `Either` type
Date: Mon, 16 Sep 2024 23:35:07 +0000
Message-Id: <20240916233507.11779-1-nells@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds examples for the `Either` type

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
---
 rust/kernel/types.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9e7ca066355c..f22f6e289198 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -461,6 +461,12 @@ fn drop(&mut self) {
 }
 
 /// A sum type that always holds either a value of type `L` or `R`.
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


