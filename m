Return-Path: <linux-kernel+bounces-395572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2939BBFF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869551C21433
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001B21FCC6D;
	Mon,  4 Nov 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="majAUT6y"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADA1AC43E;
	Mon,  4 Nov 2024 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755432; cv=none; b=kny3dedT7epkYIjW6SJ6Mt5DGQuXrDZbxsOziYL3f2sx2RtldFzdxv/LfjFemOzAW4cGxj04aNqNHKFzaRTI76T/Qs2Y7diu/IL6fGtFVu+tUlvhIX5IZgnXf5EFEAofbufSHCU4Cs1QVN+PBzM2tcSPPBEEE8rQe8yVpwQ2ZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755432; c=relaxed/simple;
	bh=FpDp8lSAvcXeWzgEwTmPCLEDMI9wrhbS4RakTmDVMkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gmhMzLhzIxk7EamOULbVVsBhcEiwB739263QDgtLZY7SXdn2HHCs2uUb3BKQR2xs9AJ2R/KvdNyJFlTVwOEE46tYnbFVMwWsugtsmq2bvKgmCaF18fejb8ltdwLUA7KKN+NVfYX0PklvpfTF7pDeomRG2jFBkscz/O3rB4nTeks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=majAUT6y; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e6089a1d39so1983094b6e.0;
        Mon, 04 Nov 2024 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755430; x=1731360230; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc3vG3O8T1Ijlo0JdWm6wUh5vdWRrdFg96scIPC6qSo=;
        b=majAUT6yemJiB9VFWTLy8qs9/9LuxZekrQGmJ8p2+H6mPMtrBLj5YKTzivnm5xQynJ
         N18Mdg+02NeYOdZeUjN5XINcvbW3+XKJCkLUficYP8EpGlyB73Xcmr9y9lGv8EjkMOFF
         K9EkzmQdYTjp/ubIHfLV59M2BDgO+rBVa0XQR/riW/ys3h34cKqGHutkZzgjVjTfH/vH
         dvNzhPNMa88D2AtYV+7jTKAWoxidkt1ll8CBIz7cDH2RThoI9rYZ4onVWOc+c8StdeJP
         Wr8vqt2+WIiu27KkI88CYokiyPNOZaCOA24w8E8nZ9J00M1FCfuhztIKYXZnH/dCOy2h
         zvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755430; x=1731360230;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc3vG3O8T1Ijlo0JdWm6wUh5vdWRrdFg96scIPC6qSo=;
        b=iimlxKDkEdDkA8Qh5v0ouy26OGodahV18cljjs5rhhvJjUIpd9Eym2oEGjfF/gxHzD
         g7sEwCpfbQqMKfsYmmx4lwKncx6c2YoLOFV6596I2woHedEehUNroihdcDftaUpPxdlT
         QYTUVBj3KSZkovMOLiorbT0O9YizzfgiywmVNcLZNlAC6fjQa387R7Jbzp9+bgpHXf2a
         I8G8adqx4D1Mz1YQfExqok4oYpeXscKjkXxycagvZQc22t6+bfBrI1eyjgpXActp6JhQ
         uRYnnd/4VhDdXgn2FMiTwkxrsE+lZSLgeF+oauD9ASSF+M7xvM4NSUwX18U909+dD8Xn
         ucBw==
X-Forwarded-Encrypted: i=1; AJvYcCWBA1Z3O/AkrGkKEZSvk6LNbT6kkPcyU+EBam7usfcErNRaR/ft0ouoTRNBYeSJ30nrSPncPMfpROViwP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXiiVbHg5+gGroSJq/I4RIHd9UyAMl3DlxkS/OsqQTdE0J5Ku
	MkGjSm52hNSR8WUkQwQTx1aTmA5vS/FRsbeecCaeu7SHIjFVbrRIBh+ggC1mUjk=
X-Google-Smtp-Source: AGHT+IHWdsCFdmKEFe3x2g9ZS4ezil34gSBy99C2VobKDidhn9d1S51WmxCF7kxl3vAB1pchN+FfgA==
X-Received: by 2002:a05:6808:1a13:b0:3e5:fd5a:d3cc with SMTP id 5614622812f47-3e758c1e383mr12763089b6e.16.1730755429749;
        Mon, 04 Nov 2024 13:23:49 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a7fe72sm2187019276.24.2024.11.04.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:23:49 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 04 Nov 2024 17:23:44 -0400
Subject: [PATCH] rust: arc: remove unused PhantomData
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF87KWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwMT3eLM3IKczLRK3cSiZF1zg2RjU3OTJNO0xGQloJaCotS0zAqwcdG
 xtbUA+fkf6V4AAAA=
X-Change-ID: 20241104-simplify-arc-70c3574b5fac
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

There's no need for this. The type had the same form when it was first
introduced, so it seems this was never necessary.

Fixed: 9dc043655003 ("rust: sync: add `Arc` for ref-counted allocations")
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 2 --
 1 file changed, 2 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index db9da352d588f65348aa7a5204abbb165b70197f..7e54d31538273d410f80fd65b2070e75e4f69428 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -127,7 +127,6 @@
 /// ```
 pub struct Arc<T: ?Sized> {
     ptr: NonNull<ArcInner<T>>,
-    _p: PhantomData<ArcInner<T>>,
 }
 
 #[pin_data]
@@ -219,7 +218,6 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
         // INVARIANT: By the safety requirements, the invariants hold.
         Arc {
             ptr: inner,
-            _p: PhantomData,
         }
     }
 

---
base-commit: ae7851c29747fa3765ecb722fe722117a346f988
change-id: 20241104-simplify-arc-70c3574b5fac

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


