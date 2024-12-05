Return-Path: <linux-kernel+bounces-433656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47F9E5B51
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB3316C41A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559221D5B9;
	Thu,  5 Dec 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcysFhAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715402F29;
	Thu,  5 Dec 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733415940; cv=none; b=uAKu5f3WsdRsAN4eUYoXMmj6AOgRKWbNJ04DM/ZVfCYoI1mtnVCNJvc5v6h88n+jC+dorwxpcVR3WPOkWcr3eFNLDmKUGncb7b0W1wvl+sJJNnC+3xVp/8CsYIW/VCcwYKxnvwZcRLB7Ez93khdeb03WQscfAR5qN8yXldh1wvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733415940; c=relaxed/simple;
	bh=G4I3QSZ14vomGceI39e4cy972y5DP0f91KtOauJ1dzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBT+WMURronj1lgmRBTv3AKWxMSrYBdEckPkkS9PAHAe+wvGUr0CXLpvyZFfhIjHZcaSO2u4Xcgv26qWoKL+7ebMazRwl9BT4hta8AWZk74YffSCtxiZK8/2UGJccSrMsP1/LUm3Z2vHFyZzmPfyH2pcDzsSPynft+mmOUWVRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcysFhAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BDEC4CED1;
	Thu,  5 Dec 2024 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733415940;
	bh=G4I3QSZ14vomGceI39e4cy972y5DP0f91KtOauJ1dzQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HcysFhAFTAvvBPMXCZ8qNzj5bdiHKqpXPA+BlLqhBoYSNVqYIYpMALQZuHjBcNkaK
	 XFlEmV1K98E1RuwEf8knjq1Y5Y5BAneOLjGzT5VXtpH24eJNHUPVdwNIvox6vFirf7
	 Qs8g7qNh2GCGzmUjKFFy87mHQat/UBqyD04QGMBBXx7MSOQ2cvT8q77zR2/dlqUqJM
	 7CnpBRCdoutza93VfOl/cbNeLYdqJwctcinLChaGamUdseO0nx/GMRESFmNkfVluXx
	 SmeEBiE2UvHCxS3Zmoz3krv4RDxJWx+s/ypVXYLv7r0eGybv25vclUyCdtZ81mrrbb
	 aZ5Reu31cH2gg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 0/5] rust: miscdevice: Provide sample driver using the new MiscDevice bindings
Date: Thu,  5 Dec 2024 16:25:17 +0000
Message-ID: <20241205162531.1883859-1-lee@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been suggested that the driver should use dev_info() instead of
pr_info() however there is currently no scaffolding to successfully pull
a 'struct device' out from driver data post register().  This is being
worked on and we will convert this over in due course.

Lee Jones (5):
  rust: miscdevice: Provide accessor to pull out miscdevice::this_device
  Documentation: ioctl-number: Carve out some identifiers for use by
    sample drivers
  samples: rust: Provide example using the new Rust MiscDevice
    abstraction
  sample: rust_misc_device: Demonstrate additional get/set value
    functionality
  MAINTAINERS: Add Rust Misc Sample to MISC entry

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 rust/kernel/miscdevice.rs                     |   9 ++
 samples/rust/Kconfig                          |  10 ++
 samples/rust/Makefile                         |   1 +
 samples/rust/rust_misc_device.rs              | 132 ++++++++++++++++++
 6 files changed, 154 insertions(+)
 create mode 100644 samples/rust/rust_misc_device.rs

-- 
2.47.0.338.g60cca15819-goog


