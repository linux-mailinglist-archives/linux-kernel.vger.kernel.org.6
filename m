Return-Path: <linux-kernel+bounces-361737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826F99AC64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE9D28C5B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58B1CEAB0;
	Fri, 11 Oct 2024 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b="dBY9fizC"
Received: from dd3514.kasserver.com (dd3514.kasserver.com [85.13.129.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969F1C9EAC;
	Fri, 11 Oct 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.129.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673627; cv=none; b=aoy7NOTIJJK8rdlk0GtN0aSxjClDtFa+qp+dLGWreItIZktx846qUyq17++KFgjFwbZnM5uCYmc3J0RKa3j2ABfdXygAAVJTFRHjZSs7ed7sUaU/H6MnaVzfAzwM2F/Wi8LKu9sF/s0dggVjOM0ChhHuVarJ2dOIfDKuW5vCyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673627; c=relaxed/simple;
	bh=qJxolLH/s+r6N8THdla8qmGE08QyXUO9znbAqP5MNWQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jl9MeRbTECp8YSjy57XHULxMyU0/mahvJSuNYiypqO4k/JLigan8SM4VaBVfrms22j5nT756D4qAvvx9f4f5JLolT+O40VHrqryMggCfEKlag0zxVXDSVgjUJLkcVxlMbqu62HyTkf5A5190S3l0rTB/nZz5BJW+asGKhYbr+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com; spf=pass smtp.mailfrom=walterzollerpiano.com; dkim=pass (2048-bit key) header.d=walterzollerpiano.com header.i=@walterzollerpiano.com header.b=dBY9fizC; arc=none smtp.client-ip=85.13.129.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=walterzollerpiano.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walterzollerpiano.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=walterzollerpiano.com; s=kas202409051210; t=1728673043;
	bh=cYxfaAElfPkV13FD5dVIzPaXnnSCjCSQLgi5JCrG0HU=;
	h=From:Subject:Date:To:Cc:From;
	b=dBY9fizC0Ike5WsSqVthkI0HWmUcvKGEp+a/TJwuG93KyzDIkHNeikR9nOX81hOUW
	 j9FjV4PhoOIxkGG7QhPlOIK377wkeqhOu+qzmXQsF2JdmPH/yWOWcUSh7O5wscZnau
	 4ZACBFHDWxf4SfVUKtb2fGMY3iNxCvXrdUOr1TCPMTvG/UCiKf27UlTwCNJcGdke0M
	 U80HeEp9sH9qnuXVlFvts3Di/MhKIES3wFAhQmWjif5PuF++hCHCOCeburkWqcXa8F
	 RbZXK0ZtFy+jdnGuxHTxtVsg7bDzVIhITbm/67aXTnescOG+MAG6qgribKoMLo/UBg
	 GfAnQjXBB1EtA==
Received: from [127.0.0.1] (31-10-158-205.cgn.dynamic.upc.ch [31.10.158.205])
	by dd3514.kasserver.com (Postfix) with ESMTPSA id 6BBC31017A4;
	Fri, 11 Oct 2024 20:57:22 +0200 (CEST)
From: Josef Zoller <josef@walterzollerpiano.com>
Subject: [PATCH 0/3] Character device abstractions for Rust
Date: Fri, 11 Oct 2024 20:55:41 +0200
Message-Id: <20241011-rust-char-dev-v1-0-350225ae228b@walterzollerpiano.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK10CWcC/z2OyYoCMRiEX6XJeQLZl34V8ZD8i+bgMkkrA+K7T
 2jB41dFfdRLDOqNhliXl+j0bKPdrhP0zyLgXK4nkg0nC6OM00pr2R9jk7PqEukpORmqlkxOOYu
 5uXfi9rf7DscPd/p9TO32CcW9bHCe0nWpFGxAzClxRc05W2TPFAG1olK5IFqdq9m935WLqTqTP
 NvoDQWnnEVDtnoAjCkQK5s5+P1NLYMk3C6Xtq0LkAbvGJkjiOP7/Q8BZyBI+wAAAA==
X-Change-ID: 20241011-rust-char-dev-f82eb3e29899
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Josef Zoller <josef@walterzollerpiano.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2483;
 i=josef@walterzollerpiano.com; h=from:subject:message-id;
 bh=qJxolLH/s+r6N8THdla8qmGE08QyXUO9znbAqP5MNWQ=;
 b=owEBbQKS/ZANAwAIAROd718OBo3IAcsmYgBnCXURjrnyyf+JwVptt3da+/23SQX8ALLZnFXGh
 0bflXNCcrOJAjMEAAEIAB0WIQQnwV8chXqnjaC1vcATne9fDgaNyAUCZwl1EQAKCRATne9fDgaN
 yPRaD/9i2cHTA4LxxEsPiZOtFDsLNA3nAMfYGrivbmCPLyjDNA0+tanxtMDkhmiRTuC3DoTTJbP
 /KCw/Y7vK/XwEjXjY9/Ojl/y4VtiESXrohM/Kevfefo36E3q1Z19cqDfvCAqV0z8P5asnB1vQQF
 R7S7oCzDmiESnXRel1jXwEUOS70fIrj69O2Tnq4MbbL4theIVe4qggB23Z8uTmmlIoPun69p6kc
 hfTLJKxFnAyasdX+bKuP2sM5xqlAieh9gg+LiAL7pHwm3ZHwNCvF9/BCnS4OJG5XRxAThMRqJYZ
 08rJGPaYZD+112tB2CB2C32fF/AqkZB26E0VGyq4Mr2fo+a3KJ/UY18cDUnsCFgdXvPoyxSZSyL
 dV6q/wq1HIDMsZLew6mZjVukirzSUM6SykhtWV7WXGaxbm3B+fDja9rNqpRXXqiCt5KL43O3nwz
 9ZDjNYvD8IOKNmYiKeTZKXh9Y7Rw+T1JtWk+WY1lidcQEjkRgjnCrzAzWnFwDEE/cQJwBwhESqB
 qp3qJ7XYxoE7nDBmJHzQVmmBLK6tqRbhS0H0kZOVn2BikXHKa7FhQ4ueCMgWl/qE9HWzEtoZLpU
 NdUW4MXel0HE9Cdc/Mss6Mk8lOhQd4U76ni+2nwaNPGm6Xs3yds3yV5FNr6ONVqPBQrzKkmP8Zt
 mVvfGLXLHpKudXg==
X-Developer-Key: i=josef@walterzollerpiano.com; a=openpgp;
 fpr=27C15F1C857AA78DA0B5BDC0139DEF5F0E068DC8
X-Spamd-Bar: +

Writing character devices is a common way to start writing kernel code,
especially because of the book "Linux Device Drivers", which is still
one of the best resources to learn about Linux kernel programming. To
allow an easier entry into Rust kernel programming specifically, this
series adds abstractions for these kinds of devices to the Rust API.

I also included a sample that demonstrates how to use these abstractions
to create the simplest example from LDD3, the "scull" device.

I'm also aware of the patch series about misc devices that was sent
recently. I think these are both valuable additions to the Rust API, and
could even be combined in some way, in which case the file operations
abstractions in both series should probably be separated and
generalized. But I'm still sending this series as it is, because it is
my first ever patch and I could use some feedback on my approach.

This series depends on the File abstraction patch [1] and the
Opaque::try_ffi_init patch [2], however, the latter is such a small
change that it could easily be included in this series if necessary.

Link: https://lore.kernel.org/all/20240915-alice-file-v10-3-88484f7a3dcf@google.com/ [1]
Link: https://lore.kernel.org/all/20241001-b4-miscdevice-v2-1-330d760041fa@google.com/ [2]
Signed-off-by: Josef Zoller <josef@walterzollerpiano.com>
---
Josef Zoller (3):
      rust: char_dev: add character device abstraction
      rust: macros: add IoctlCommand derive macro
      samples: rust: add character device sample

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/fs.c               |  16 +
 rust/kernel/char_dev.rs         | 976 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/init/macros.rs      |  10 +-
 rust/kernel/ioctl.rs            | 236 +++++++++-
 rust/kernel/lib.rs              |   1 +
 rust/kernel/prelude.rs          |   2 +-
 rust/macros/ioctl_cmd.rs        | 202 +++++++++
 rust/macros/lib.rs              |  21 +
 samples/rust/Kconfig            |  10 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_char_dev.rs   | 506 +++++++++++++++++++++
 12 files changed, 1977 insertions(+), 5 deletions(-)
---
base-commit: ce1c54fdff7c4556b08f5b875a331d8952e8b6b7
change-id: 20241011-rust-char-dev-f82eb3e29899
prerequisite-patch-id: be636dd988fbd1f993df5fe7cd10eabfadd319b2
prerequisite-patch-id: 478b4285f3752e64043d2e3b5ccd786ef039f659

Best regards,
-- 
Josef Zoller <josef@walterzollerpiano.com>


