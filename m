Return-Path: <linux-kernel+bounces-434669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028239E69A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD9C18842C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AEC1E1C11;
	Fri,  6 Dec 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWzI6XWc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6281DE8B7;
	Fri,  6 Dec 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475931; cv=none; b=diMw2jRfbbE9WO+3uE0jRCQxJJWas6AzntujAELMcrpykJPG2giC7NLW7QwkIX9srRY4a4IBzdnh1LfNJd9PSl9oHISdsUJsLzDHNg2NHNcNMXqi4C/G+AXQaTsPIMpuD/OdFGAdKk60ST2ESuhadzLT8w1tM79w1C9aC2s9a18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475931; c=relaxed/simple;
	bh=Fzuiw4te3yb1kYEXXRZexllf/Un+NGqelHJC0fK5Kl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7A6HEofE8Yx7jqM54aH5elrrdIZYp56xj5ZQSzmkEIqE/9r9n5kd0vYYq/HE764uNWzYIG677QLwiodE8hwhz3F6cH3Lc3siAWI8MAZ7AJeH2lpSe42iw7/ol8zFpLMm8Wds/YPO6n3SRc7NUuL+A+zwdjQL7Y3MNThUypoxZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWzI6XWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C8DC4CED1;
	Fri,  6 Dec 2024 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733475930;
	bh=Fzuiw4te3yb1kYEXXRZexllf/Un+NGqelHJC0fK5Kl0=;
	h=From:To:Cc:Subject:Date:From;
	b=kWzI6XWcWWbpsrad061RwPEKmCHJvnjsPI9pEQMMMI9+aC7cmvycOCDcCtiSMrnaQ
	 epBlt1egX+k+bka2cu8YnODLLlAYIPayY/3VBy7RSwur610YWKG/09cGcH443gVBQj
	 bPItvZ9yMlTPj8wJx+v9euRC/D1lDogFYPJHUxnKSwPe/iG2RQ7VnEeZ8qbFnucHpK
	 FGLmnf5zg2d/svTq79Pxetq/77zjvTc2Xyo3WrRgF6X70h0rEkwfztKtXUykC/D0UR
	 dt2oDIwEW4M3X6gcFj1YqW04mVyYYa06KryyOf6WmGydKJuyR+9rQYyrcip97Jf9RY
	 S0gm8G9nRkDKQ==
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
Subject: [PATCH v4 0/4] rust: miscdevice: Provide sample driver using the new MiscDevice bindings
Date: Fri,  6 Dec 2024 09:05:02 +0000
Message-ID: <20241206090515.752267-1-lee@kernel.org>
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

Lee Jones (4):
  Documentation: ioctl-number: Carve out some identifiers for use by
    sample drivers
  samples: rust: Provide example using the new Rust MiscDevice
    abstraction
  sample: rust_misc_device: Demonstrate additional get/set value
    functionality
  MAINTAINERS: Add Rust Misc Sample to MISC entry

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   1 +
 samples/rust/Kconfig                          |  10 ++
 samples/rust/Makefile                         |   1 +
 samples/rust/rust_misc_device.rs              | 132 ++++++++++++++++++
 5 files changed, 145 insertions(+)
 create mode 100644 samples/rust/rust_misc_device.rs

-- 
2.47.0.338.g60cca15819-goog


