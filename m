Return-Path: <linux-kernel+bounces-332128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C59997B5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B9E28A78D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0101192D81;
	Tue, 17 Sep 2024 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl1zcY4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4989B192594;
	Tue, 17 Sep 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612159; cv=none; b=GaiAUMtV37N4bwYcXY8hpzJZ0vRnOuB0sc8yIccZqx1ooaR014w0lnTPBy2RcOB9EtbMudIPeGfVEcQBWaXxr0FmuJuWWcZkO12HITxod3ie0INdrAV28aNi15/OTmG56+fk1+B+EOxCO8PTZAoM3h3MIYN3/8vCyLHe8j2Qvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612159; c=relaxed/simple;
	bh=H3mqUDMiazCwWZvvlwM1l5nzI68bcs4PzRovcYaEsns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVVjAcJ5mvz2Lpcq1/a5ismsSGvWMvjgzLI9/JPGwpVrLCObEWfJW/wls3tY9qWlz4dg8lHNCcvUUFuLtl8m8MScq35yF9HdEW6W56qrzeAPLQrYlkBFEedB3kvw6IqFAIs3va2/0ji0xTvx7E/CEzi1RwtfBNRFpX0xtCim6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl1zcY4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEEAC4CECD;
	Tue, 17 Sep 2024 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612158;
	bh=H3mqUDMiazCwWZvvlwM1l5nzI68bcs4PzRovcYaEsns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bl1zcY4rbBuft0/IYPQt5rRE4vS6IajzpXvIyvmeA/zsPY4HsMacOLpk8S/zgQ3gd
	 6V+MMaVnPKEqiR1uw4FRRY3SrDR59XbtO1JwQcjrpNx0S0NzQDcf1C2Qpxjs80ERo6
	 lOf9zZdEHDBB9sIaNIoK1c0hO1oXw0b4tkjWMalC523+CYLYr8yb8w85xd2In2uaSj
	 eXALiV8QSb7yXhzVzsf+POD9QZITlVDnh6RatbA/NSoxdWPj/u/atAQwhsFR0W3yMf
	 lAHan8dTwKjSw7KdOAVVPXHO8YyuZbpLEAGr3pjO+hIH/JDD2a/r4XihaUBr9xpWx/
	 LVgg4tLKn7uVg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] rust: sync: add `Arc::as_ptr`
Date: Wed, 18 Sep 2024 00:27:27 +0200
Message-ID: <20240917222739.1298275-4-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=a.hindborg@kernel.org; h=from:subject; bh=H3mqUDMiazCwWZvvlwM1l5nzI68bcs4PzRovcYaEsns=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZjVEJrTTlad055UmowUDN3bFRjais3CjdFUzJNVFkvcXVyMGwwMmVR RVZPcTRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDN BQW9KRU9HNEdqNTVLR04zcjJVUC8waVhnUkVrUmxPTjBjcURibFVRcUlQN1hUN0lXbWRLTkJ6Vg pMSjVQMUNVekhTbEt3NnhtRVhTMkVlZjRETVF1a3hOOVFvTkRPRmZ4OHBCMm1YdW1ENHBNT1REZ EV4cGdSRXgwCmd0YjYzM0hKdTVPeU54aStES1I0VGVYb3BHMXJESnZ1c2pIbW1FZjNZQlZhNXNY SXFoOGdPTXZVQVNrQ3o2WFcKNEZoUFp1Z0Z5QzRxL0cvS3VibHprZDcveXBMVlVpY0pYREZUMTN pYVdwSlFSYjZvcEZseGFGamd1WndodE9WOApDVnYzMmsrVWg1RVBpRHdac0tzVk8vTGhtWUFjan NMVWtHc3dDK1p0YlBXcEIzcG9CNEFhUGNETFNMT2hRS1hoCndIRU1nNGtGeHpJNDNFTlM1SlNDM 24wUHp4NHpKZ3FXVk9ZQzU5bHJ1ZEtqbFdLOGxRTHg3eEd6NmFhSDZJUXAKTU51SmN5N2QrWlhy NEMxYVhNN3I4S3BiS3g1YXRrK3pJbUYyMUdzd1ZwM016Z1FyTWlvZUdUYkJ1Vm1jTHNHVwpWSjF lN0xZMGlUczFjdDdsZT
 RtS3c2cXlVZEtwanlTOEVLdlFuU2RwSnZ4dE9PLy9DenNMSVhlWCtYOV c4MFB2CjlDZzBoenFvaDVxRWhNR3FJcVBTeDdWYVhBMUFMNFpqMzJWd1BlRytXZVlEWEY0a21MO GNFZVpuMGlFSGxUZFcKK09velhrVCt0eTIyeUxjOEtsQmx4VUJwV0lENG1CeWxNdTczcUxxVDh2 Sno3bnJ5WDZGVDVNTWFxK2VvZlVVVgpNbWt0WU1iVG8yRTN4bmRpMk5HUWZjNVFnZHdpN0RucVR EQy9LNnJWcHNFd2UyeUxJZk8xK25rTm5HdDVFT3BFClZQSmtvODdvWWpJbnRnPT0KPU5kQ3YKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Add a method to get a pointer to the data contained in an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/arc.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3673496c2363..a57ea3e2b44c 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -258,6 +258,14 @@ pub fn into_raw(self) -> *const T {
         unsafe { core::ptr::addr_of!((*ptr).data) }
     }
 
+    /// Return a raw pointer to the data in this arc.
+    pub fn as_ptr(&self) -> *const T {
+        let ptr = self.ptr.as_ptr();
+        // SAFETY: As we derive the pointer from a reference above, the pointer
+        // must be valid.
+        unsafe { core::ptr::addr_of!((*ptr).data) }
+    }
+
     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc::into_raw`].
     ///
     /// # Safety
-- 
2.46.0



