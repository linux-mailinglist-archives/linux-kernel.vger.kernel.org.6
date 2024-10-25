Return-Path: <linux-kernel+bounces-382651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6469B1178
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A74BAB251D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535F21C2CD;
	Fri, 25 Oct 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siwXzZBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE84216DE1;
	Fri, 25 Oct 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890369; cv=none; b=HMdKQA1oZxKw3xUQfBzlGjI42ATucvQWDzXpqjLEzbdpQjjV/W0CFsrydrNx10HrIHYv1OURgJRNQ/abktq/Nq8AYytFepbBrCbioxKA77oOeraY/Ura6hls4+vIecier+r96CnaYXU5U6Cgx2s319oYPfDWPVNs8el8LMjBI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890369; c=relaxed/simple;
	bh=yv3Bmr21rRk5eXwZrMp1GWmeP54UQKU8npZAxjm6M6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LeSLv7SXa6tnXL4zkot9fP3I9AB+2BPzmkJGn9NLmI2R4TAtNWY5St5AC9uC3nKwQsUd64ALkP1RozUlcO5M/G1oozNUckAEhVAE3VzGZwdlumMRXC4gCFxXCpKWHDXJ/2zmv8yrbiW0hb0BcB2r5/Bwj0fwuylzmoIx0LeMnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siwXzZBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77994C4CEC3;
	Fri, 25 Oct 2024 21:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890368;
	bh=yv3Bmr21rRk5eXwZrMp1GWmeP54UQKU8npZAxjm6M6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=siwXzZBspz5wDqs9RD5M93sgU+Madl9XI6od1OLT7rIGIGeAJTwA5pJ1kXvGP66kQ
	 gFUHspHSL55CRKrRN++V6PREplLXM0yEH2DytEkIp7TBrLM9kzrdK7DcHLyFYzCrX4
	 XW94C+peSxBZHZfbFLul6VXJPQ9cKmTkXaZnsS2ulWG4yK1tIyuEb/o6BksERXMg69
	 gPBnI6zYy0gC7grWubljJ1Y+vg7ZGGPNg9uaSBekATBaVM7d5GN1HPSj5mtrhVB3hS
	 zA6ukvOWrgknz9WPkljFbGHadmx9VVrE8+xO2C2EcCtCJgCunErB9CT0GDrbOSD8kF
	 trypy5yS+Xe+Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 25 Oct 2024 16:05:46 -0500
Subject: [PATCH RFC 1/3] of: unittest: Add a platform device node for rust
 platform driver sample
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-rust-platform-dev-v1-1-0df8dcf7c20b@kernel.org>
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

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/unittest-data/tests-platform.dtsi | 5 +++++
 samples/rust/rust_driver_platform.rs         | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
index fa39611071b3..2caaf1c10ee6 100644
--- a/drivers/of/unittest-data/tests-platform.dtsi
+++ b/drivers/of/unittest-data/tests-platform.dtsi
@@ -33,6 +33,11 @@ dev@100 {
 					reg = <0x100>;
 				};
 			};
+
+			test-device@2 {
+				compatible = "test,rust-device";
+				reg = <0x2>;
+			};
 		};
 	};
 };
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 55caaaa4f216..5cf4a8f86c13 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -15,7 +15,7 @@ struct SampleDriver {
     MODULE_OF_TABLE,
     <SampleDriver as platform::Driver>::IdInfo,
     [(
-        of::DeviceId::new(c_str!("redhat,rust-sample-platform-driver")),
+        of::DeviceId::new(c_str!("test,rust-device")),
         Info(42)
     )]
 );

-- 
2.45.2


