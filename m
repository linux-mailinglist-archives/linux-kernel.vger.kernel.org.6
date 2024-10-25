Return-Path: <linux-kernel+bounces-382653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5C9B117B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C2FB23EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6719D21CD8E;
	Fri, 25 Oct 2024 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHPY7FII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945E21C2F1;
	Fri, 25 Oct 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890370; cv=none; b=IYXSzQsSSbVuHDU7Ks7Ill4/VVO3vxkYZ/9upXebFOB6ReB+T0Al6Ejh5gh8QRqO46aYS+euXufJqSkPGVFe5GP0NrfsTHgjRq8oXgO3drR6+qw16RjszCZSz6Go1C5wWfRpd5Z5X58ENoLfiAu2DG10yw5Y5wu6tuGPjtjDfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890370; c=relaxed/simple;
	bh=SbDhiQQsJeI/5H0yQes94SuNKiHafq1al/d5HAKaqTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnzBjUhFOYBssvUXJhpDVOX7abP80wF9KegfvxZkp+OoFVwtvdaa3HOkUaHSi7sABbMngng+WGJz2M30acTHqRyGDpajXKFRLH4s72LL803eOjADo+k1wwAsMOZ6h6l2AyG9Z80Wxw31rNunWRKD6aMEp41O5IY9w25ZuvjgdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHPY7FII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BFBC4CEC3;
	Fri, 25 Oct 2024 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890370;
	bh=SbDhiQQsJeI/5H0yQes94SuNKiHafq1al/d5HAKaqTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dHPY7FIIJaavcX+kyElBfHkBhuIvWKd2QEGKyFTdJDg/q0rtBR0yVJAkFpSZqw+uN
	 VflU2EaCO5jVBwOxb1apowsxT2BFY5vDDY01ArWcXPBbXHgQQ7tLW6OZckUaFdPj07
	 hmgqK2eap9ILI4fFF+LTsoT2YyrIrSokJM+uVm34qyqT/WU8ROTdUc2N9+7wdau3Ul
	 ocyrFupWE+4AthipacC2YQIw8JwS4J4mwonhW1Wuta6lW53w3SYK3D7/r0yUyMXbd5
	 cIi6d6U1JCPMLhYPGzKwHr5vnXKBASRwu0OdDG9Ui5ZlSEaJKmXmVvGhtN2/LolMG9
	 ie5v6kYu+TkHw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 25 Oct 2024 16:05:48 -0500
Subject: [PATCH RFC 3/3] samples: rust: platform: Add property read
 examples
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-rust-platform-dev-v1-3-0df8dcf7c20b@kernel.org>
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
In-Reply-To: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
To: Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Dirk Behme <dirk.behme@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
X-Mailer: b4 0.15-dev

Add some example usage of the device property read methods for
DT/ACPI/swnode properties.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/unittest-data/tests-platform.dtsi |  3 +++
 samples/rust/rust_driver_platform.rs         | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index 2caaf1c10ee6..a5369b9343b8 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -37,6 +37,9 @@ dev@100 {
 			test-device@2 {
 				compatible = "test,rust-device";
 				reg = <0x2>;
+
+				test,u32-prop = <0xdeadbeef>;
+				test,i16-array = /bits/ 16 <1 2 (-3) (-4)>;
 			};
 		};
 	};
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 5cf4a8f86c13..95c290806862 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -41,6 +41,28 @@ fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin
             }
         };
 
+        let dev = pdev.as_ref();
+        if let Ok(idx) = dev.property_match_string(c_str!("compatible"), c_str!("test,rust-device"))
+        {
+            dev_info!(pdev.as_ref(), "matched compatible string idx = {}\n", idx);
+        }
+
+        let prop = dev.property_read_bool(c_str!("test,bool-prop"));
+        dev_info!(dev, "bool prop is {}\n", prop);
+
+        let _prop = dev.property_read::<u32>(c_str!("test,u32-prop"))?;
+        let prop: u32 = dev.property_read(c_str!("test,u32-prop"))?;
+        dev_info!(dev, "'test,u32-prop' is {:#x}\n", prop);
+
+        let prop: [i16; 4] = dev.property_read_array(c_str!("test,i16-array"))?;
+        dev_info!(dev, "'test,i16-array' is {:?}\n", prop);
+        dev_info!(
+            dev,
+            "'test,i16-array' length is {}\n",
+            dev.property_count_elem::<u16>(c_str!("test,i16-array"))
+                .unwrap()
+        );
+
         let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
 
         Ok(drvdata.into())

-- 
2.45.2


