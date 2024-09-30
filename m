Return-Path: <linux-kernel+bounces-344040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1EF98A34D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0031F24309
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83337190492;
	Mon, 30 Sep 2024 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQasC57/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787718E352;
	Mon, 30 Sep 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700013; cv=none; b=tR82K7RHfGSJ8V0qR8p5F8vdWIJcyEzK9cJbz1JUl50FRktDxsFA7u7Ce47xqJb8ShquCxCbJLyl27pOFse9Wg5sR7T/LvQMaVfti05aPBUyFDnWjPJxEWZGwr7wnR85/0VNJUH6OASDCqpJotpKN943oIE9N2xXuXiDX3RlTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700013; c=relaxed/simple;
	bh=RM8k+Og1xucdZtM/tMyuY6EF1+OJMVFGQ4eUvYfdYiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7GAYXf3CpLU7PGs6ql8R74cewHvGhVhc5Gpqi3Z50BL8wJkGbWUP0gBnvO1mA544c+6kL6Ggkq1gtPKVK75LQC3N9goRNtrcQvXZE+FAmIKzOZx6dXi8EDzscIt9iL2Hcos0Co1vhkfDGJ272Kazb3qG/r1JJyThLE1vqu3Qp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQasC57/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20afdad26f5so55542105ad.1;
        Mon, 30 Sep 2024 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727700012; x=1728304812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c55WIPHDfBnIwV8zTM0GRcHHG5bLf8AH4uB8OrirpjA=;
        b=SQasC57/VEaMO1RaRS1N7zh0Z6zpPDL21R1Ape24oZGwtIOic4NXAqM8t/w5qv/CmJ
         xYSaRpPbLnmDCCNMdPQllgXQXCphhQBacZ3lnbud+qsKDOUEDOnJV9GXraFHJhUXhFW2
         3bxea9FCDfC+hekd+7yT9o9b7mxxVx0n/yiDNebLHydN39jpxMSs9QZZg0zVq7EG/WBx
         rjtZBoC5z4XcB8Q7rEzY7mU48KepZA5IXD1aIXfsWACG3UEZUbNpu9ZbF9gDoJjjdQ8i
         JFaKYtDEyg7BcctMgdTsTbiV4nXbIXYxGXt50z0JWEcYsSl4wtqjIn/pdeeWHSULXAxn
         8ECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700012; x=1728304812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c55WIPHDfBnIwV8zTM0GRcHHG5bLf8AH4uB8OrirpjA=;
        b=JoJXsgU7yG3gtEBnxBqnJ+YwvxkL08kcT7kPGex/1fVnbJJqd2FXRjaGPIARJzDoYv
         eJrDcl3KSc2aU3gwbYddl7JpPKNKX+fTA9hMEUOfGna2RU3GLfscq8IGT5/O/IDOdik0
         z3/EdLu5hWjhbHEcz2XVq7H8y05WOLnZ6n5v6uIDgsZe2Kx2WMFj42MI/k0SULfFKGNA
         N6897Bokvagq3KYZNVtkBvHVSkWopzJY5oAMofgYG9JwsIvld0pmaKfbtjv4tAYHaWyt
         jtr+l5swKbtN5zNOcwHMhGyjt47chl7XAwlmOOd2B2ux7UR7LR4B9e8rWHtG+2vw/7R+
         7R5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv+ku3kO8xmcjHBaoZH8B9L9Xg38N8g1GImKWO8HbXx0FZq2Ia8PjP+VkTauJT+MVwG+Csy5+hmF41/3U=@vger.kernel.org, AJvYcCXVJBsKOwwL57y3PwyotdUYrD8/UZpEz6y8827gELu09cQTwDMsLfAji+qHCWxID5vw0dfFY1UtGyFP6127kEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2Me03ID1CiX5hfhoyUp5VP3lrZtzaLls681Je9b8FohsuKbw
	O5BJuXc8gIT0bryC+uv82rDCCPJUCJC/61S9qK07NFYnFIAKcKKa
X-Google-Smtp-Source: AGHT+IHE/23YcZ/kvTHHj5dsasd+8FYaUZNwS9fCgosxZDYW8LkIAfVzP/C3qZJg2j3Er2FIM48goA==
X-Received: by 2002:a17:902:f552:b0:20b:91f5:aae8 with SMTP id d9443c01a7336-20b91f5bc8bmr25740875ad.55.1727700011607;
        Mon, 30 Sep 2024 05:40:11 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e35ce7sm53377965ad.209.2024.09.30.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:40:11 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	mcgrof@kernel.org,
	russ.weight@linux.dev,
	dakr@redhat.com,
	a.hindborg@kernel.org
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] device: rust: change the name function
Date: Mon, 30 Sep 2024 09:39:55 -0300
Message-ID: <20240930123957.49181-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Why did I make this change?
This function "Device::from_raw()" increments the refcount by this command "bindings::get_device(prt)". This can be confused because the function Arc::from_raw() from the standard library, doesn't increment the refcount.

This discussion is in
https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E

The options can be:
1) Rename the function for don't make confusing with the Arc::from_raw().
2) Remove this function and use the unsafe { Device::as_ref(ptr) }.into() when I need the get pointer for the device.

Proposed solution
I like the first option. Because, how was will commented by Boqun Feng , when the people write the "unsafe { Device::as_ref(ptr) }.into()" again, again and again... inevitably anybody will create a help function for this.

Then I think that we should rename this function for Device::get_from_raw() or maybe Device::get_device() and I like more of the second option because, this will be equal the get_device() function that already exists in .c code.


How do I test this:
I create this simple file in sample/rust/device.rs
""""""""
use kernel::device::Device;
use kernel::prelude::*;
use kernel::types::ARef;

module! {
    type: DeviceTest,
    name: "device_test",
    author: "Test device",
    description: "A simple module for test device",
    license: "GPL",
}

struct DeviceTest;

impl kernel::Module for DeviceTest {
    fn init(_module: &'static ThisModule) -> Result<Self> {
        pr_info!("initial device test");
        let device = create_and_get_device();
        pr_info!("device created");

        Ok(DeviceTest)
    }
}

impl Drop for DeviceTest {
    fn drop(&mut self) {
        pr_info!("bye bye driver test");
    }
}

fn create_and_get_device() -> ARef<Device> {
    let device = unsafe { Device::get_device(core::ptr::null_mut()) };
    device
}
""""""""

I set this in Kconfig
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..7779969e7dd6 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -37,4 +37,9 @@ config SAMPLE_RUST_HOSTPROGS

          If unsure, say N.

+config SAMPLE_DEVICE_TEST
+       tristate "Device test"
+       help
+               This option is for device test
+
 endif # SAMPLES_RUST


and in Makefile
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..85a8b30100e7 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,5 +2,6 @@

 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)              += rust_minimal.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)                        += rust_print.o
+obj-$(CONFIG_SAMPLE_DEVICE_TEST)                       += device.o

 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)         += hostprogs


Then I enable this in menu config... compile the kernel e run this in a qemu:
qemu-system-x86_64 -kernel bzImage -initrd initramfs.img -m 2G -machine q35 -device ich9-ahci,id=sata -drive id=disk,file=rootfs.img,if=none,format=raw -device ide-hd,drive=disk,bus=sata.0 -append "root=/dev/sda console=ttyS0" -nographic -monitor telnet:127.0.0.1:5555,server,nowai

the expected print is showing
[    2.786174] device_test: initial device test
[    2.786541] device_test: device created


Guilherme Giacomo Simoes (1):
  device: rust: change the name function

 rust/kernel/device.rs   | 2 +-
 rust/kernel/firmware.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.46.2


