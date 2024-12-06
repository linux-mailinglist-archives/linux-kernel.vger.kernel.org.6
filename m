Return-Path: <linux-kernel+bounces-435523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53269E7903
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973DA18821A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD71F3D51;
	Fri,  6 Dec 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uD4jVU35"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134DF192B76;
	Fri,  6 Dec 2024 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513707; cv=none; b=Fpji0XtzwRVQGh3wxQE4rWBuOUmM/veXu97WxGGIUF6kqUM+usV+I2UUCfqmaZ2TuO29nVK0GVLXG63VgH2el6dKGEuuZQndglOuylkaTkk76MPQ4Xqm8/4jxl0LEoKDkfeDsL6iEsiP+p9JDGhnsP2hRlAsWs6mTp/tm6DLNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513707; c=relaxed/simple;
	bh=lDPl01izmHRdpX/4BbDdhKpVVoE+jqsdSqSjquB7akA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRAyBq0YJhJ/2RhxxhtTGwyJUq+Ol56SJjeJVk8YjNB+cRZwgK+apYmNC9xWbfika0bpV1smfyx2boGfhR9lVCBQ3NHNFtSSTLsj4ihD5qXBh5Km0dUJHar1+4xONxn62jYQIoeeqowE24LVCUui04+Ng2keclPzmpj5Xmwv5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uD4jVU35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009B0C4CED1;
	Fri,  6 Dec 2024 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513705;
	bh=lDPl01izmHRdpX/4BbDdhKpVVoE+jqsdSqSjquB7akA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uD4jVU35ESf/s1A+zsxTylVGmnky49Vg9Cf9lMerF58jOsCkJu0MPqKeL7Dm8a5/w
	 uSM0o0a8vmT8LHeNHnHn3vhZ0BpnhWP3vARhpCge07jYgnBfha/BNWKTVKZOeBlGVI
	 PdrKPspTCPgroBPaJNL/Ih694+WTOKpWbl4kAUEhDY6egUltvZOf7/eHYvPT2hWYSb
	 qBRxZ11BZ/6NUGdAhD271tD7DIfnPfcAz9HOFN0f87YmzRiL2nnop+jJleUN137XsY
	 VAgh52kogyv7El4bS0LO+80YWxUYsWO3yFO9bP33C/J//BaTqai3UXPaSWgP8WcIR5
	 MZxekVXMPEBhQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:32:55 +0100
Subject: [PATCH v4 03/14] rust: sync: add `Arc::as_ptr`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-3-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=lDPl01izmHRdpX/4BbDdhKpVVoE+jqsdSqSjquB7akA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVdzZWRubjNRZlNIRk45cnNLcFpKbHpFClRuVmtXY0FGQWNYRVN0bmNJ
 dUdld0lrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnJ
 BQW9KRU9HNEdqNTVLR04zakUwUUFKOERaQVVucjg2cmhCUnBMR3NiYis0aE5UWloyb1VqM1U2Zg
 pVR0ZPRW92V2ZSb0djdWZpRWdzTVR0M3M3ZEdxSXlEWHZiUEhVNzZwWWdBTkdncm9wZm8wRzNIZ
 DVvS213TWlkCkxWa1hjL2FYbTFVK0FjQWl2VHpNaElXQkdvU3FST3hJTjEwMTZRekplNjFQSHV2
 cXBKd2FydEdaeitwdG8wVlAKMHh0RU16cFBUeWo2SU9lcHRMTjFraENESTNsWDJMclFpSGc1S2l
 ycTAxbVpheUttSEQ4OTVvVEU3NHpEWVNDcQowL2h4OFVuQjJJY0lCMGlnMGxYMTJKSERjK0NmQX
 hSbkNoeWd4V0V3SEszRWtnaGo2dDRaQVdOcnpncUh6SVBIClI5S2xzYkZCajBXdFJkSmtwOWx6c
 UZlcVZ5YmMweHdNdHRWUlpmQTl5QVNJbWs3QWRQVlVtK05HNGtTMHdxemUKTDJwTS9lQkN4UjNJ
 UnVGM2hVdi94azhIbVF0T2xoVHQvNDVRbzArZDlhUzE2bTZuQmRGcGdjYWwxWDlEYzQrVgpHUmp
 3Rlp5bkhjUUhwYnBCcFRBYTJNaDdVMVdhSzR3VmgxZXd3eW1wMDFtTXZCS3ptNHROZExNSTZuY3
 BPdlV4CnVOWXMxdmVpZklRa2VETWgwaWNId295WE56THVENE8yUUk2MTFnbVBYdjJENW5OV0dBR
 kptUnBnaURzKzlHMWQKdDhKY09GUnQxSjNmTGZaRXYrSFIrRXZLc3RHZkhUd3dpVEdpS2NZUWha
 QW1nN2tUbzlmcmtxQVZHTjJhaDVaTwo5QU12d1RwcmFLQ3RzWGQ5RndQbkYyUGN0a0tlVzNkTWt
 2ODM1RCtqYS9BQ1pQcXpXbHVaZVcyWFJGY3RGTHYzClNjV1FKNld3Z25Za2N3PT0KPTdCcCsKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a method to get a pointer to the data contained in an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/arc.rs | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index fa4509406ee909ca0677b78d5ece966089ce6366..3d6111ddb007285b26eca2177a412033f4ac5dcb 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -233,6 +233,15 @@ pub fn into_raw(self) -> *const T {
         unsafe { core::ptr::addr_of!((*ptr).data) }
     }
 
+    /// Return a raw pointer to the data in this arc.
+    pub fn as_ptr(this: &Self) -> *const T {
+        let ptr = this.ptr.as_ptr();
+
+        // SAFETY: As `ptr` points to a valid allocation of type `ArcInner`,
+        // field projection to `data`is within bounds of the allocation.
+        unsafe { core::ptr::addr_of!((*ptr).data) }
+    }
+
     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
     ///
     /// # Safety
@@ -508,11 +517,11 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
     }
 
     /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously been deconstructed with
-    /// [`Arc::into_raw`].
+    /// [`Arc::into_raw`] or [`Arc::as_ptr`].
     ///
     /// # Safety
     ///
-    /// * The provided pointer must originate from a call to [`Arc::into_raw`].
+    /// * The provided pointer must originate from a call to [`Arc::into_raw`] or [`Arc::as_ptr`].
     /// * For the duration of the lifetime annotated on this `ArcBorrow`, the reference count must
     ///   not hit zero.
     /// * For the duration of the lifetime annotated on this `ArcBorrow`, there must not be a

-- 
2.46.0



