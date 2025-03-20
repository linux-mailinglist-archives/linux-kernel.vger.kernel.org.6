Return-Path: <linux-kernel+bounces-569057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02609A69E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCB61898434
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBA1E7C01;
	Thu, 20 Mar 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="UQZlUOzS"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BAD1E47B3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436494; cv=none; b=QlJyFIvpFn5UpuOO75ZgvCkds1sciHLoguVYRVBY9N5479WCE8uoBV1LMlRdWVQwV38zWgwJOmLgPgzTFdLFGyHWx5Vt2irVJw9vV7HcQ0dH9ObzGQX2YuBoWs4AEgmaC+ZE6KKhSlGv4iPIuUvh4W7ZeHHNW3rCOaazQRs2Prg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436494; c=relaxed/simple;
	bh=5DYwCw5VSjMRViNkfzFuwdcL8RKibKODas0k+zh2s+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbDeQeJFe8rf44Y/z6pBpyQPxo40bZcFlpPu/fa4aaa10LvPfOmxmdfm9ycdyOcpTzXlPQEVTTztr2YLQDZLJAVWekz0VaKXyTxyhbq6swudPFw2N02bHwxIJYpX2T3bAnGQOa4+AfmYZrfq74c5i3vplr59Spyxb5T3NInrSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=UQZlUOzS; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6feab7c5f96so2255997b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436492; x=1743041292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjP5UYMdVD8swW0UhXnvA0Xvua7PoLrWUXi4eCeH58Y=;
        b=UQZlUOzSip1U2maanPmmv0u1xv+3X1lsPBSQ8A7bloI2Tcn+gtBhV+/L4RS6CAR9aI
         Z2Dz6UWB5ibU++zwHtm69sgQ3e2dUY6yJpco9c0VMbykZMwLBrHUd/eJAvBcep6D+jjd
         T4A8wjXjfeAn5+xmi5LKuUjLv+R/cpeWn+wr8P9a0BjWXe/XPJrUVsUBVLkUcKAHKQuS
         HxofB7OXVrljxqyccCcwvqLD5Ll2tz7itwxT8htFzflB3IbW/wzPQk6IAtjdtkTBvoaW
         I0gFZnyTSnMpSljN/HjqqOZPPbVEBVcw8nRi4tDvTdrD5zD9tQpBLkJIvxX89FinxMD6
         UX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436492; x=1743041292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjP5UYMdVD8swW0UhXnvA0Xvua7PoLrWUXi4eCeH58Y=;
        b=IlOSllRxNm9qH9zfrE4zpx1JRcheZ83xqefX+crmtIy8QaqA/8DRJupol3DgCeUQkv
         xS2F2v4IFNmz78IUAUREw0ryqUyJOnBV0Ej2fVuUoZe7Ag7N6HSCL6GHDH1o+cnqxom+
         auVFO+NydWEZSSgp5x4uvNb8wEcr8GcYLkFahYlBm7mZ+cAa8+Ilsz4n5tr0uSV6JrP8
         dC8WiyzYOSEO1jMGJm8CqAdBx23VxCC4ZxRhT8B/hHidVkY1S3Fpb8OYPku43IYj1j4F
         Yi2i/jdRc3TUNnxuStGu9nrdm1koOe6XShh6Du7sL8F6L3yhQ5uvQd+ALOiGs630Nawn
         WmLg==
X-Forwarded-Encrypted: i=1; AJvYcCXp8sC4Y05QCCJZuqwFu4nDdRPw9Qujje04Xk3r5MZW0MDcyu59mR+te8sqO/4TQ4U56nPSfW3oX0BuIPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSUc+SAiX2EbuwqN0fydi8nNq1NmufRYAZuqOdloLRJAxKeRw
	Fd/Bwvo7OVuuVMmmMvFRVx6kYe5MLlT6qk+dHMIlskky1PHznSWpEfdhOYZtkDU=
X-Gm-Gg: ASbGncv2WoLJdLQ5EbD/z0Gn3vH3y9eGUlUM/YRHVcMf3mIzQs0UHsZBE6xxlW6FOze
	BQLCTMLtRFRbzUKh1GOQ/0r5wChUr9UOOk12s5KEYEmto0Mhxk9Z8IIZuTZaiFzamPesNDNrGZn
	ZTqoyROpLOmdzAdnhZlXNgPOYUHi9hCJWcrL0nwPlCdaNcp9vlplMbLLaB8dd5daRs+1eGEyYTr
	Ildjf3KrUpNbx6ZBrX0EvIB1OtH+DH+1bmQ9KU7zHF5RI0KrOgg66Bq7GGj5rUQLIz09zOrQOeY
	KrrXJSap896M87dHe4JKS2oo1PX7xk7UiB+RORjdqPRkWjbUCUhDyFyka4Od4x2lxjvQtjyQ9Qr
	HRSBEJ/70xyBrohTKaN+pSRy8D9faVg==
X-Google-Smtp-Source: AGHT+IE+1+outUb+Gv03/JgxTzo1KPf7Ulu2G+RNfgqQlReYHZUVrPUgA3z5P8FXtZWsXbv0HHu9gg==
X-Received: by 2002:a05:690c:6185:b0:6fe:af27:33f8 with SMTP id 00721157ae682-7009c02deafmr74365507b3.30.1742436492028;
        Wed, 19 Mar 2025 19:08:12 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:11 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/17] rust: platform: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:25 -0400
Message-ID: <20250320020740.1631171-7-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of_mut!(place)`
with `&raw mut place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw mut` is similar to `&mut`
making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/platform.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..344875ad7b82 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -14,8 +14,6 @@
     ThisModule,
 };
 
-use core::ptr::addr_of_mut;
-
 /// An adapter for the registration of platform drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -55,7 +53,7 @@ unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
 impl<T: Driver + 'static> Adapter<T> {
     extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
         // SAFETY: The platform bus only ever calls the probe callback with a valid `pdev`.
-        let dev = unsafe { device::Device::get_device(addr_of_mut!((*pdev).dev)) };
+        let dev = unsafe { device::Device::get_device(&raw mut (*pdev).dev) };
         // SAFETY: `dev` is guaranteed to be embedded in a valid `struct platform_device` by the
         // call above.
         let mut pdev = unsafe { Device::from_dev(dev) };


