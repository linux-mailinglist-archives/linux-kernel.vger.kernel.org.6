Return-Path: <linux-kernel+bounces-444866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9562C9F0DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F882818A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3F31E1C16;
	Fri, 13 Dec 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1yQALhO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320C1E1C07;
	Fri, 13 Dec 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097676; cv=none; b=enAPHqps1q8AkekEeH0Fd0hBNTkXElmGRkpH+XQcouvCiHwL7H54Mb3pWijzoai2hzkDvJa4ToLUTtIb0LGt5lyeZqNdVcES8OX9hOMtBJR/RSp3/p3Q0zcj8voq64wXOtZlE3f8VxKVrPSDhJuJEIt3HfQTzCgKX9n//NvKW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097676; c=relaxed/simple;
	bh=2Cpd5nmMdpE1QJyo7HkmRlJyt5ZRsTgDLqFZwGiXn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4m0vGGvVdkNvyE7GpH1vSrC+1FVjB2xTlOFEwO2cwFe7phqNzaIEJnjejPvgeXj3k2n5WqEfKQ2NRFBYdZL6zkoLQlpJa1i+1EsWHGfSq9OP6NG8ZlzIrlhqXEE0kLAS57P4KU8tppXooBL2xuw30XneFg3jALe9a1cpoNMUtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1yQALhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6CBC4CEDE;
	Fri, 13 Dec 2024 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734097675;
	bh=2Cpd5nmMdpE1QJyo7HkmRlJyt5ZRsTgDLqFZwGiXn2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z1yQALhOOLQ8LMgGi1jrflJxFbg3+XxKnUOMVWKz3aWRZPrHeCFUR93YW4d1XFVLZ
	 rX0X5SLIZDBt0K5r5HJVe+RNE0Jivaes42dRSW0wp7p4vDJc6j1o/BEVpkEpMCTPFs
	 n/J3upUp8HWnq44WpFEWC3Go66Ztkcc9uAD+LiwkYiA8lWJVjBMv2C0Vwo64sM5MhK
	 TKnwuwhy4n1wLnl/c1ScTORP94i3x4pKK5+RNohMNDlZpG3CjkYZgOpY6iCsDiuhHa
	 TpC66GbNvWofEmQNdJitUdvV1wnbstkxqmkZroGTklH/KRfcopiN+z4Qtt71NVyVpS
	 zzXcxLo3IaFTA==
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
Subject: [PATCH v6 5/5] samples: rust_misc_device: Provide an example C program to exercise functionality
Date: Fri, 13 Dec 2024 13:47:10 +0000
Message-ID: <20241213134715.601415-6-lee@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213134715.601415-1-lee@kernel.org>
References: <20241213134715.601415-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the expected output (manually spliced together):

USERSPACE: Opening /dev/rust-misc-device for reading and writing
KERNEL: rust_misc_device: Opening Rust Misc Device Sample
USERSPACE: Calling Hello
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Hello from the Rust Misc Device
USERSPACE: Fetching initial value
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Copying data to userspace (value: 0)
USERSPACE: Submitting new value (1)
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Copying data from userspace (value: 1)
USERSPACE: Fetching new value
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> Copying data to userspace (value: 1)
USERSPACE: Attempting to call in to an non-existent IOCTL
KERNEL: rust_misc_device: IOCTLing Rust Misc Device Sample
KERNEL: rust_misc_device: -> IOCTL not recognised: 20992
USERSPACE: ioctl: Succeeded to fail - this was expected: Inappropriate ioctl for device
USERSPACE: Closing /dev/rust-misc-device
KERNEL: rust_misc_device: Exiting the Rust Misc Device Sample
USERSPACE: Success

Signed-off-by: Lee Jones <lee@kernel.org>
---
 samples/rust/rust_misc_device.rs | 90 ++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index ae1474a451f1..40ad7266c225 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -4,6 +4,96 @@
 
 //! Rust misc device sample.
 
+/// Below is an example userspace C program that exercises this sample's functionality.
+///
+/// ```c
+/// #include <stdio.h>
+/// #include <stdlib.h>
+/// #include <errno.h>
+/// #include <fcntl.h>
+/// #include <unistd.h>
+/// #include <sys/ioctl.h>
+///
+/// #define RUST_MISC_DEV_FAIL _IO('|', 0)
+/// #define RUST_MISC_DEV_HELLO _IO('|', 0x80)
+/// #define RUST_MISC_DEV_GET_VALUE _IOR('|', 0x81, int)
+/// #define RUST_MISC_DEV_SET_VALUE _IOW('|', 0x82, int)
+///
+/// int main() {
+///   int value, new_value;
+///   int fd, ret;
+///
+///   // Open the device file
+///   printf("Opening /dev/rust-misc-device for reading and writing\n");
+///   fd = open("/dev/rust-misc-device", O_RDWR);
+///   if (fd < 0) {
+///     perror("open");
+///     return errno;
+///   }
+///
+///   // Make call into driver to say "hello"
+///   printf("Calling Hello\n");
+///   ret = ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
+///   if (ret < 0) {
+///     perror("ioctl: Failed to call into Hello");
+///     close(fd);
+///     return errno;
+///   }
+///
+///   // Get initial value
+///   printf("Fetching initial value\n");
+///   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
+///   if (ret < 0) {
+///     perror("ioctl: Failed to fetch the initial value");
+///     close(fd);
+///     return errno;
+///   }
+///
+///   value++;
+///
+///   // Set value to something different
+///   printf("Submitting new value (%d)\n", value);
+///   ret = ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
+///   if (ret < 0) {
+///     perror("ioctl: Failed to submit new value");
+///     close(fd);
+///     return errno;
+///   }
+///
+///   // Ensure new value was applied
+///   printf("Fetching new value\n");
+///   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
+///   if (ret < 0) {
+///     perror("ioctl: Failed to fetch the new value");
+///     close(fd);
+///     return errno;
+///   }
+///
+///   if (value != new_value) {
+///     printf("Failed: Committed and retrieved values are different (%d - %d)\n", value, new_value);
+///     close(fd);
+///     return -1;
+///   }
+///
+///   // Call the unsuccessful ioctl
+///   printf("Attempting to call in to an non-existent IOCTL\n");
+///   ret = ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
+///   if (ret < 0) {
+///     perror("ioctl: Succeeded to fail - this was expected");
+///   } else {
+///     printf("ioctl: Failed to fail\n");
+///     close(fd);
+///     return -1;
+///   }
+///
+///   // Close the device file
+///   printf("Closing /dev/rust-misc-device\n");
+///   close(fd);
+///
+///   printf("Success\n");
+///   return 0;
+/// }
+/// ```
 use core::pin::Pin;
 
 use kernel::{
-- 
2.47.1.613.gc27f4b7a9f-goog


