Return-Path: <linux-kernel+bounces-564785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554E4A65AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD07B3A7C00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C741A262A;
	Mon, 17 Mar 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK8LPh1X"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E36D1598F4;
	Mon, 17 Mar 2025 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232202; cv=none; b=YVHOra5rFRzTDv/TYszQ7Iv+Ofv87BHlf1fivU7tJbBapsL/t1VnatKqLL77yoVKeTuxODAl8PNaPiyTs9LHjY/Ox2MX7PWqquwuOSEc723J9V43HLvEpLAKcTIUt4Gc1UOSXAJAj+7ngqQ3cZVj5idmCaAKO7EhpLQPCkvPLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232202; c=relaxed/simple;
	bh=5vxm/HEKlIPK/+zNIKuY7zqhLB4xKor4/veLY1kYxTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hSNuR7N1a+dwBtYK1CQwMspunu2klU6Ca0MXwSphbvbhs0dB2Fd67LeibPcRQUgA7JtMkjpKyPwGgqu770gT9owJXokf6fweSqmLH+G922ppdhh+DKT37p2jnGirbK6mBlZHKN20+rhYK6c8TRwIc2H5qj9kdaKNmJ2j8AFSSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK8LPh1X; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4766631a6a4so47539461cf.2;
        Mon, 17 Mar 2025 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742232200; x=1742837000; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RV3/QPVb7oRU6oz0KDmtdy9mXqtl5ObgAszDpJd9zlM=;
        b=IK8LPh1XtlahflVl9SE4YCDl4B/t6m3fIGrRcBYl/n9B86lXbvZvSvS9f7vzjWgGXj
         65jTf3W5wid4Srbi7zvttgSbYtxg48cOe0X0haW0N5qnIjDus4gTRCx7X/voODyrcsWv
         Qcw2GpfyYxzuRRb8zm0jD/M8gAeEWF9nYwtEVFO0E/igYGqa3wUnST1w38PpLuPC6+CL
         DZAIWiTTpfLZTP/Sn9SI7ScvYL/BDef/YNgaAyJHzTwQVHaR3IJhTVF5b1e7Fv8+swmA
         rpszk7JkYbD1mxLUhJr06UZGV1/4BS50xb78Op+jx6/6nShx4psV7Yoef4r7KjILRkxa
         crYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232200; x=1742837000;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RV3/QPVb7oRU6oz0KDmtdy9mXqtl5ObgAszDpJd9zlM=;
        b=h1omEkcTed3qTw/D/q1BLUG3sQBPMng1FrM6f2l3Lci6793zlkjwRlGIKjeSTKlUpX
         kzkIOck6R3biQogz5OUVn110DLIUZIRreQeQgmLkgPFOkWKXyNGXZRSyGgACOQS26LwG
         ZVDfqjNLKVrJoPFqj12mxidWLPkXA2TRTU3saBFFI0EHWxk5vQFenJDKSA0pyLXEW8tl
         VjJ+Yj/vDpNagXBn8Az3wmLh1Jat+hswCxxNLlJMI9jcy02GqloOTYx2WPMoTvMGtAZj
         bAeD5K2pHYJqRblnmhWCFITkBm+Y3hoeL2d0mlDe4Vh2jep/5fboz5tgD6QYzsfBxdPN
         Z2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkWhL7oirprBxgyqOLkuFeZT9GMApZ/sJ3nFfiojj+8xdcbj2CvjSNakaWMlBoB8P2gYkWgkFhyijVwnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BNVkeFsmnMnXYHIWygxXtigSLVJYapK68K29ReOO1On0D25D
	4d1XyhW6xWLYg2KSp4pIcin7E1HXQzDT2IcKl5iOvrVt+8fTZcCF
X-Gm-Gg: ASbGncvhJ0H0ByhUgsP4PF9R6QalBudRKkyWdJahq/icfSHGRPJiDx0gThpncMRqYjQ
	ZGY3d1CiPph9qLO0UD91eJVHfGfhmp1TnEw8KuJZ5kWp6jsqWdCIj7eedlR/sdSsgSPt4FHAvYu
	g++iQeKuAvFitVCBL5uWiON56Z4MW0OP+Zmf7feFadVySgTIH80ILgHlGpWBgBjg03aD4mn9fXP
	bqBe72frnA6OnyNnTjE6xDJOC7k8Gp6aAzOiSxVwvlcdep5FjOwQJMSSWjElIa8ZpofsAYSVWFb
	CDxdtBSbF0CaOwgs5JpHpM9sz5aYOwwiqA4zCiRfmRoMiqhhfocNdK5ydHw/PGnEmPpzPvyh1kB
	mmXL4GA==
X-Google-Smtp-Source: AGHT+IHmxy9vpg9M7E8kN6XgzJl0JzNKGPUQR3gwh/56CDWM2m0BxD3Xt9c6qpYaYbxk9qrzN3ULWw==
X-Received: by 2002:a05:622a:4d4f:b0:476:98d6:1419 with SMTP id d75a77b69052e-476fc9b4f7fmr7933451cf.30.1742232200182;
        Mon, 17 Mar 2025 10:23:20 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:6895:24c6:e898:e320])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade20998asm57237756d6.18.2025.03.17.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:23:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 13:23:18 -0400
Subject: [PATCH v2] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-vec-push-use-spare-v2-1-5dc6583f732c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIVa2GcC/32NQQ6CMBBFr0Jm7Rhaq1VW3sOwaMoUJhFKOtJoC
 He3cgCX7+f/91cQSkwCTbVCoszCcSqgDxX4wU09IXeFQdf6XJ+UxUwe50UGXIRQZpcItTVXE7p
 aXdwNynBOFPi9Sx9t4YHlFdNn/8jql/7VZYUKLZUGBeNImXs/On4efRyh3bbtC0JIcZ20AAAA
X-Change-ID: 20250317-vec-push-use-spare-27484fd016a9
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use `spare_capacity_mut` in the implementation of `push` to reduce the
use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
alloc: implement kernel `Vec` type").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Use `slice::get_unchecked_mut` to ensure we avoid a bounds check.
  (Benno Lossin)
- Link to v1: https://lore.kernel.org/r/20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com
---
 rust/kernel/alloc/kvec.rs | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..b91b287e0d22 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
     pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         self.reserve(1, flags)?;
 
-        // SAFETY:
-        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
-        //   guaranteed to be part of the same allocated object.
-        // - `self.len` can not overflow `isize`.
-        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
-
-        // SAFETY:
-        // - `ptr` is properly aligned and valid for writes.
-        unsafe { core::ptr::write(ptr, v) };
+        // SAFETY: The call to `reserve` was successful so the spare capacity is at least 1.
+        unsafe { self.spare_capacity_mut().get_unchecked_mut(0) }.write(v);
 
         // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
         // by 1. We also know that the new length is <= capacity because of the previous call to

---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20250317-vec-push-use-spare-27484fd016a9

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


