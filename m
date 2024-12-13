Return-Path: <linux-kernel+bounces-444861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D929F0DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84CE1881535
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C331E04B3;
	Fri, 13 Dec 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gboqsmsw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B717548;
	Fri, 13 Dec 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097660; cv=none; b=VuE4FsA7cZ3aClO1rOKMVbvB30O00CTnLvfl8iOlHKKOUfmJ2wYqNGC/rXoWPgotqhUmZB6SwiWacURWxO5rOx0NaJ2Sni84JZcDCkGZ9XhvjgAEFUqQrbBv60betCv7J2sdSXLs9QqhQ7ge9av0w1k9FX5HzzME1BeiXUANeqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097660; c=relaxed/simple;
	bh=VIMig2II2mNgjbylAE+qGc7rd0TqLWtlscaZ2SC+AiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGETnX6vH5mr8msNGNfYIM6SJXXyr14GiJQDgDY/0KAEm+AkWNUm1qPpyuEFvcdfl5DrLfyji2nvoaVryGP1J1c1m8E3vybaFh6KhG8hSXbpthKajk6H/9T2a5X13LGBSe3xPEF0rW356PbrBCyVZdEWR+cYi8l/9cqraY57tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gboqsmsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FE2C4CED0;
	Fri, 13 Dec 2024 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097659;
	bh=VIMig2II2mNgjbylAE+qGc7rd0TqLWtlscaZ2SC+AiM=;
	h=From:To:Cc:Subject:Date:From;
	b=GboqsmswPX2ALN4uAHgrk8022juznHmZ8HVfND+VEO3hsYtLBujxfkYQ1VZruCAzi
	 PyxuMw2TZCRWLSh7riBqDROtX1JF+qAvoQg8tSgAMuzQwoY3e5lYQEnUM7J4TqnUyQ
	 JJy2IF96FAt8e7EeykuBQBgLuSfMOHpRzP/LlahlFUZAHkZTNacelm/o0RGi5i+901
	 rwqjVblG5/QkkmrBmGSeQJo/tlnK/Xl+0YI2EDt7KiNWues0Wx3BEAGJEE/qeOKV/v
	 XjFUgxwZFM1dNVAz3muHgKB3g0Lsyo01T6WwHuYgtHUo8PO0BmS/ExBCPbte1OkCEP
	 KXxzA8d56G29A==
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
Subject: [PATCH v6 0/5] rust: miscdevice: Provide sample driver using the new MiscDevice bindings
Date: Fri, 13 Dec 2024 13:47:05 +0000
Message-ID: <20241213134715.601415-1-lee@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set depends on Alice's most recent MiscDevice changes:

https://lore.kernel.org/all/20241210-miscdevice-file-param-v3-0-b2a79b666dc5@google.com/

Changelog v5 -> v6:
 - pr_info() to dev_info() conversion (based on Alice's new set)
 - Moved the example C program from the commit message to the file comments
 - Changed mutex-drop commentary

Lee Jones (5):
  Documentation: ioctl-number: Carve out some identifiers for use by
    sample drivers
  samples: rust: Provide example using the new Rust MiscDevice
    abstraction
  samples: rust_misc_device: Demonstrate additional get/set value
    functionality
  MAINTAINERS: Add Rust Misc Sample to MISC entry
  samples: rust_misc_device: Provide an example C program to exercise
    functionality

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 samples/rust/Kconfig                          |  10 +
 samples/rust/Makefile                         |   1 +
 samples/rust/rust_misc_device.rs              | 238 ++++++++++++++++++
 5 files changed, 251 insertions(+)
 create mode 100644 samples/rust/rust_misc_device.rs

-- 
2.47.1.613.gc27f4b7a9f-goog


