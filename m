Return-Path: <linux-kernel+bounces-362175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7522699B1D1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EEB1C211E7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AB9145FE8;
	Sat, 12 Oct 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="2n981J1O"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBB142E76
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719618; cv=none; b=JAHuvwtpMRNs0OnpjCscZ8PhcBNj4Fypvo4ur2gWhhGTAVm1i3mARcFNRmkwJp7GrWzJQaAg5aaK4bQJaokK3rXGwWS6Mz448oFM6K6PneQc2pros/rr7eHyPFmBgipBKH0ghYq3+kFy55bQy9u8LR6fN6FLErmO0oaLkQ8YXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719618; c=relaxed/simple;
	bh=Uz8fI/TjycUzp3sCaBSskUO/agHmlbV/KUA2udyPBIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+fPaWGHaAMtvKFVeV+lxw+tZTFQ4rLeyM4zLFjqRUKpppBIbTC0K1akKIoc3cONisDAMTZTZwWd5eXy2ez+L1SwZGm12t+37Jh+S91hPG/NqlNFvYch/vuG2zfyvzK+eb/UG+HtuD+td4aOVQqitWPPp96KYOFRGHbLbXlhDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=2n981J1O; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1728719614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OlwIdCzcY6aFelGEBN20ax7Y102wIl6HXhpWaUdSH8=;
	b=2n981J1OKZiHd3yRwNB996EiVpGTi+j65C7jCX1rnYwo86uKc2Hv6BqNd1xBqMaGelQ9XN
	u/ffPuSutQdrNJ1/76exgT+U2ryuE8mA+GCj3UpG9WOFFreGECOSyLnu+cbbUeaaqsJ47y
	Av7H0AuMLE+iNwUIOAssCpHWm9GQNws=
From: =?UTF-8?q?Thomas=20B=C3=B6hler?= <witcher@wiredspace.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Jocelyn Falempe <jfalempe@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20B=C3=B6hler?= <witcher@wiredspace.de>
Subject: [PATCH 2/7] drm/panic: remove unnecessary borrow in alignment_pattern
Date: Sat, 12 Oct 2024 09:52:45 +0200
Message-ID: <20241012075312.16342-2-witcher@wiredspace.de>
In-Reply-To: <20241012075312.16342-1-witcher@wiredspace.de>
References: <20241012075312.16342-1-witcher@wiredspace.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function `alignment_pattern` returns a static reference to a `u8`
slice. The borrow of the returned element in `ALIGNMENT_PATTERNS` is
already a reference as defined in the array definition above so this
borrow is unnecessary and removed by the compiler. Clippy notes this in
`needless_borrow`:

    error: this expression creates a reference which is immediately dereferenced by the compiler
       --> drivers/gpu/drm/drm_panic_qr.rs:245:9
        |
    245 |         &ALIGNMENT_PATTERNS[self.0 - 1]
        |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: change this to: `ALIGNMENT_PATTERNS[self.0 - 1]`
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_borrow
        = note: `-D clippy::needless-borrow` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(clippy::needless_borrow)]`

Remove the unnecessary borrow.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1123
Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
---
 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 76decf49e678..7adfaa3d6222 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -239,7 +239,7 @@ fn g1_blk_size(&self) -> usize {
     }
 
     fn alignment_pattern(&self) -> &'static [u8] {
-        &ALIGNMENT_PATTERNS[self.0 - 1]
+        ALIGNMENT_PATTERNS[self.0 - 1]
     }
 
     fn poly(&self) -> &'static [u8] {
-- 
2.46.2


