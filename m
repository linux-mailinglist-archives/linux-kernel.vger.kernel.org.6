Return-Path: <linux-kernel+bounces-569805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA1DA6A7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41F41B808A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87595225410;
	Thu, 20 Mar 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="on1QeZwF"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2162253FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478817; cv=none; b=O8I8q+EshmNyGmaCQXylzvm7M/9HuqwW1h/xk9SQUdkLBEAYA3i6C0H2M3kGdFr4rtU6uy0Pg79/YJmx5IuaiXZdz3Xkukir6PLJtpzbRqBh9yXN3CaoCarLj0JpwZfbxPagIaQCwCcyNiMahj08VfqL9gcX/mCipwN2LLvCAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478817; c=relaxed/simple;
	bh=NCAdAD7zcQQG3DmPxpb4nW9umd28Sgb4e1h7Xd2XolE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=utiG03c+kLfl9reDlhSX79AukuxRAZMXUqL+Coqz6/J51e6hP8phuHLYUFIKEAsntTcGmXzeblscnL9CzReaeTYeFVh5CwEx1dr2QOKJ82ehvux5/xpFX0d9S/DCPyzvFHL2n24BHFlvfzG2WoKkfqmdK9jJjuntlINYaU9xz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=on1QeZwF; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912aab7a36so316015f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742478814; x=1743083614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ARoR/4rbfxmbwkx8MsUi2O1VKkXGVBlgDqberViU+Ls=;
        b=on1QeZwF4l5IKECzJ7cTm9j25hxrgfckeqj3a1y4+SFE+h4bV5g7JvTRI7IpWa9rl9
         V1VWmwxxBHDR5DsKnUfQFMi6B2DUjt1UTBVRdRD8PqIp079CQRYo5UG88DHTFKr/0Pgw
         p7aEvCKFdOzUi4VgQpPyMFaUQh6aN7iAUR5KqVJTvgM0RUWDTQp/lduKRMWzVPCC2XvW
         Dm7sqgWwALRVLCWvLnZaGVRL8E15sQQpr4i9PV2mGicl+EFSUYc0yhYzZDGrl4Nl1WuK
         EmLHsT0zJzu5CAP7SyDSo0RETqmTICGBOvcMxtXC2MlTvhbm0FtsmAQ7ndbX9NJKPb7H
         1KOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478814; x=1743083614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARoR/4rbfxmbwkx8MsUi2O1VKkXGVBlgDqberViU+Ls=;
        b=hyh4dGhOpVo7q3KcfVFD7Jiu1A5b6nZw4vkx/T2bppo5kIeB6eK4LM4FUI+76NBg+D
         xhoovIJhOo0JlTiWWtjXmyo/hmKgR/yBgcFz1eqzjD3L+ELB3JfqYnHGybRjhpn01qir
         3VIKN3Al60n4QRyQnffEKNb8uM/QF/ay3fc+y1khv4nNbH87ZhsEU4u9HTSkF+pfWFQ4
         AXhKXyK9hka39fY2C/gS+NWymByNoorAxzAG1WqWvf1tQOG/17hOnd+vV5wC711xTn5r
         jXlGsXYiREjj+g53VCYmbkyZOTtphavt7NS8B3d9oFUi6IvVf5vdA/p2laI7/iq1chid
         4YlA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ug3ksim263+kMPvCf9EB6o/gjgL2l/dUEUuA+j/fuQjMm2nNcFIecqIzzRuvtryMySi8cRGAMFtOgr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+43eqVtZVHDHA5GoFvFSGdL0BiVk4I3STCYnPajHEqydm5m9
	kcFBONwnTYAKD6MPjBMTGF6U3HhP2WpdEZ9L6Nh5NfHrzH7jtTh2rHDE07VUA06SdMnFCUAcCoV
	hJ12UUY5kIFRoVw==
X-Google-Smtp-Source: AGHT+IGk1VdvocsBb4oxWBkhM8eKGeq/5oOXyCMhkbRPxkFUqPnga50GXXG8kVbBNsuNobfY3vnahdRVjW03aOE=
X-Received: from wrbfu22.prod.google.com ([2002:a05:6000:25f6:b0:394:d453:93f4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64ee:0:b0:392:c64:9aef with SMTP id ffacd0b85a97d-399739c1f58mr7094721f8f.20.1742478814714;
 Thu, 20 Mar 2025 06:53:34 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:53:00 +0000
In-Reply-To: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NCAdAD7zcQQG3DmPxpb4nW9umd28Sgb4e1h7Xd2XolE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3B3OAP6GNwr3WDtZT5V/xWKWknls04prEXKq0
 YkqvMbPSgWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ9wdzgAKCRAEWL7uWMY5
 RqaFEAC4C1slxPMFONjtELvLg3Z2lonhLkvPeEiY+ubrSjRI6bJMkQvEekJ74MNGhyEwiLPklmm
 hAbZAOVsSPed/Bus+tlXu47Tb+c8xTYS23KAmdJb+uCAOywmTxAHM+a9HKQQp/jWujTzXi+AUvo
 V1s8oGFSnoCRn0WyttpV9ah/dIGyPKJ1EMlASd8f7aiAItmjdCjDbXzXEgYeDTSAwcMMwCK7eVq
 IwXDwaUuZoK39a/EuyQvtQIb92h+6/9byvlaUXkBxRb9n7RjYsu2ZNRIOltlIUrcks+tOKTJvxm
 V/r5ZOO+kJMYTmro6rOHexRvsV1grH4+ppq8O5pAE2PSIKGJjEBrDmQULKyHYnHku0UjLSD5JFo
 xu8BZ7Gjw0ycHDA2ZsdWD/DCqOFrDe3lyeDsQnDvNs9iMzuimTF97RLi/gW/EBVBvfjHpslBBs7
 mjny3n3xeUz8u2S74a8bPTKd2cx29U4sjDS2s4mQWlyJtGDuuckB5svz9xwqe5zj/C6Oa/SqZX1
 KVAAJRrbsQBA9FudWPBK2t/aINplQkyVoO/aS94Y5EKGa+e2+cK1DQHpy5e+y67PvYLIgNDfUqD
 kANC31eOX1v5/6rsAT7/5eLsDh1iRlgk49x6imrLPH2SNXO1v1CS1iegVcxTjNW2YMRlhDdlHYF 3rDRib1JkmiBWlA==
X-Mailer: b4 0.14.2
Message-ID: <20250320-vec-methods-v1-5-7dff5cf25fe8@google.com>
Subject: [PATCH 5/5] rust: alloc: add Vec::retain
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This adds a common Vec method called `retain` that removes all elements
that don't match a certain condition. Rust Binder uses it to find all
processes that match a given pid.

The stdlib retain method takes &T rather than &mut T and has a separate
retain_mut for the &mut T case. However, this is considered an API
mistake that can't be fixed now due to backwards compatibility. There's
no reason for us to repeat that mistake.

To verify the correctness of this implementation, you may run the
following program in userspace:

    fn retain<T>(vec: &mut Vec<T>, f: impl Fn(&T) -> bool) {
        let mut num_kept = 0;
        let mut next_to_check = 0;
        while let Some(to_check) = vec.get_mut(next_to_check) {
            if f(to_check) {
                vec.swap(num_kept, next_to_check);
                num_kept += 1;
            }
            next_to_check += 1;
        }
        vec.truncate(num_kept);
    }

    fn verify(c: &[bool]) {
        let mut vec1: Vec<usize> = (0..c.len()).collect();
        let mut vec2: Vec<usize> = (0..c.len()).collect();

        vec1.retain(|i| c[*i]);
        retain(&mut vec2, |i| c[*i]);

        assert_eq!(vec1, vec2);
    }

    // Used to loop through all 2^n bit vectors.
    fn add(value: &mut [bool]) -> bool {
        let mut carry = true;
        for v in value {
            let new_v = carry != *v;
            carry = carry && *v;
            *v = new_v;
        }
        carry
    }

    fn main() {
        for len in 0..10 {
            let mut retain = vec![false; len];
            while !add(&mut retain) {
                verify(&retain);
            }
        }
        println!("ok!");
    }

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kvec.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 303198509885f5e24b74da5a92382b518de3e1c0..00dabea8ea6c8a742a7fc95954d8de58be124493 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -588,6 +588,20 @@ pub fn drain_all(&mut self) -> DrainAll<'_, T> {
             elements: self.spare_capacity_mut()[..len].iter_mut(),
         }
     }
+
+    /// Removes all elements that don't match the provided closure.
+    pub fn retain(&mut self, mut f: impl FnMut(&mut T) -> bool) {
+        let mut num_kept = 0;
+        let mut next_to_check = 0;
+        while let Some(to_check) = self.get_mut(next_to_check) {
+            if f(to_check) {
+                self.swap(num_kept, next_to_check);
+                num_kept += 1;
+            }
+            next_to_check += 1;
+        }
+        self.truncate(num_kept);
+    }
 }
 
 impl<T: Clone, A: Allocator> Vec<T, A> {

-- 
2.49.0.rc1.451.g8f38331e32-goog


