Return-Path: <linux-kernel+bounces-435016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF09E6E75
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9B9285289
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF3204097;
	Fri,  6 Dec 2024 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bou0jqvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECD2036FA;
	Fri,  6 Dec 2024 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488960; cv=none; b=S+fCORMGwG7DzvsrN41OPLH3+NHlNkfEWrUcWS99xKQUtwu3oS+YfifQhTSlPtWzu17odt4jiU+NpCkirvl9aYw439OQaun5wtMns3B4JegtpL7Fl3mVjSzO5URLzbBk8X1yFjeaeQrVRLTfpVUwuQ4fvNeVoFrIOpHszCkZk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488960; c=relaxed/simple;
	bh=Fzuiw4te3yb1kYEXXRZexllf/Un+NGqelHJC0fK5Kl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvNyarvJiVwEcK/lSlTiOhXSd0LB4i1b3S0OM/i72tn1ZCj+z80Lee0qbTXSnOYJxkcjjXn5JrAGVBNgGSYcUMLlixcJR9vwSF2X+xj9PkV5qnsMWE3+cVY3u31Ee03XN+yLN4PIYd3hZLOIKniIGmeTGFxEX4hs7nGI60wtD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bou0jqvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF87C4CED1;
	Fri,  6 Dec 2024 12:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733488959;
	bh=Fzuiw4te3yb1kYEXXRZexllf/Un+NGqelHJC0fK5Kl0=;
	h=From:To:Cc:Subject:Date:From;
	b=Bou0jqvFFHsMC3IB7dqaASxthM4zE4XlcU/BoS4tiZg7nWiqmHwMHrXuZo+OVmS/O
	 aTvOqM1RYPSTZ74dFs5cNMuVISRYY+3UmGbBdtmCJP2nDiHP+UvmqfjdbeHIEDOMQe
	 lxyZ1Q5CsLGOYsSoshs8z8BzhBxMFXTVgJ2NSlINgAi9RdzEYs5gxmOcxOGm+CYtVR
	 GuUtyaPoAFqI4RhiAJHyULVedpMSjlMb725avNML56hFYcecxvFYwmNLwxf8LANPxU
	 qM9jSGgxn/TWVjD9hCr80c0rGbvKZbNHyG9KvOUcDVKC3r7CeS+NGdJE4htdrQ7t7H
	 ijv1LCbZnhBDA==
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
Subject: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the new MiscDevice bindings
Date: Fri,  6 Dec 2024 12:42:11 +0000
Message-ID: <20241206124218.165880-1-lee@kernel.org>
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


