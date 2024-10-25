Return-Path: <linux-kernel+bounces-382650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FDB9B1175
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1456FB23BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6120EA57;
	Fri, 25 Oct 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRTyM4tF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2581D215C77;
	Fri, 25 Oct 2024 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890368; cv=none; b=bT2tUpP2HnZ7niWCW03QkUIE2Chts3Ew8NXdeyFgNLdkzZby/reYmc8wDGv4SLsss9VUKxOwerPObNNn5D2AK4AMMl6g80KaLd//gb7SvDHIHLGIdi7ZY9audOBYYGKLZGxAiSbdPF4g2o+RyoLLSNSKYkrkF0maH/Kg/GoBths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890368; c=relaxed/simple;
	bh=0iH4sLoWNbALVNCefEYiy3mvwdhllhDiIAumTMHCt+k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FyplpuRklZ9i3uYSLtKtV4WBnfGeqGBgWBIXQmk4W1/9zsG6rcW5GGMY89FwsD3KxYtTCaUu/NDikEKTqmQ/g218YbT98EZLx7si3W2zwDNp9X/mGAOChthG5OjtLy1ecEqtD7i8Nk/IfkHc+y2/QW1VYGbRXywu4JFhGsfK91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRTyM4tF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D0DC4CEC3;
	Fri, 25 Oct 2024 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890367;
	bh=0iH4sLoWNbALVNCefEYiy3mvwdhllhDiIAumTMHCt+k=;
	h=From:Subject:Date:To:Cc:From;
	b=vRTyM4tFlGX3zRbiGi66VjmJbtYxutJoc1bKiNK8vYg1VRpOAcSjnkIuLe8n8r5vK
	 wXa2Io8TX6h+RUXwJKo0O/SnSC8g2Hvtu2YtMuP4jZ5ZJcydRDOveMwH/Qphu4X6lC
	 7JmWUR1mwAJrqiPpSakPY7Y4aiYN91n0UBVBM8g06SDsL5dJrmNtdbv3j8kh2nqmJb
	 ax2t18yhmyDEqCxVWKmVNN7h7zlMn3yvQajeb8LY1vNmmXMHeNmFNkI+J2Mv8xMXcB
	 nc49lxSrY1msU1qBujcYSJutlW8haC/JglvKL9+AXAat5pm8yDAYgvCPXTKd+TomJp
	 vTnxww+dNzspA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH RFC 0/3] Initial rust bindings for device property reads
Date: Fri, 25 Oct 2024 16:05:45 -0500
Message-Id: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkIHGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyNT3aLS4hLdgpzEkrT8olzdlNQyXYNUC8uU1KTkpKREUyWgvoKi1LT
 MCrCZ0UpBbs5KsbW1ANF4MT1oAAAA
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

I got asked about upstreaming DT rust bindings, so I decided to take a 
stab at it. This series adds rust bindings for the device property API 
which is a firmware agnostic interface for reading firmware properties. 
There are "DT rust bindings" patches floating around, but for many 
drivers they don't need to know any DT specifics nor deal with struct 
device_node (and its refcounts). And reading firmware properties are 
simple enough for my feeble rust abilities.

This series is based on top of Danilo's PCI and platform device 
series[1], though that's really only for the sample driver.

Please tell me how my rust code sucks before I spend more time beating 
my head against the wall^W^W^W^W^W^W learning rust.

Rob

[1] https://lore.kernel.org/all/20241022213221.2383-1-dakr@kernel.org/

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (3):
      of: unittest: Add a platform device node for rust platform driver sample
      rust: Add bindings for device properties
      samples: rust: platform: Add property read examples

 drivers/of/unittest-data/tests-platform.dtsi |   8 ++
 rust/bindings/bindings_helper.h              |   1 +
 rust/kernel/device.rs                        | 145 ++++++++++++++++++++++++++-
 samples/rust/rust_driver_platform.rs         |  24 ++++-
 4 files changed, 176 insertions(+), 2 deletions(-)
---
base-commit: eeb31b3e7e9e1b485763ecc66ece8afba1416b2a
change-id: 20241025-rust-platform-dev-0e89debcbba5

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


