Return-Path: <linux-kernel+bounces-342994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E6E9895AE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D3A1C2136F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB5178CE4;
	Sun, 29 Sep 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVQWfeOJ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1339748A;
	Sun, 29 Sep 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727616681; cv=none; b=ay9mQNpPF9R3/hxDm+lAUWk80yk8/sZDR6Y6sGQQPbSKLNl4nY9tQ3k1U4/+6CPvh6JfkRH2ZcgumpZuuJF0IAp9xHIX/sunOKk1gJ1DWMNqs3hEsCM9WnUNVSR52vJ8v29J5g5LSE1DST9CKGXyE7Vh96z+TlneN7HUU0N4Now=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727616681; c=relaxed/simple;
	bh=befcry7AHjbXEfUIpurXHG1xQuSkPZQYKAQTm3ent0o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Vbn8AhR/ZWgE8XlcD+i7rFl9tCoRspc+fo1VkA1Vq0HLdvAgolecnls4Lgbh55CijOq+S+HkBTI04mbOQSdbcY95d/v4wZ8iYqV5GU8FYTSrJp7nEkYb+xBN7N2YP9CxoHToJcnwpj2HB/QNOdq2UPPLYwPlTUPoabegC6CpwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVQWfeOJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4583209a17dso37165291cf.1;
        Sun, 29 Sep 2024 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727616679; x=1728221479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uVJWhSUCq6HWlZXlmldiICSmD5/m9Zw9scstAJoBrAI=;
        b=lVQWfeOJ4OK9DFyYmPR6wfjxJcMsu7hXMzDwUQpNUVFR8gjb7o77KiAyFAAWSuCGBs
         ESbMfe7Z4qJxlHToRw5M77F95DQH+EiV7pHnECAAtpXYCfgyIkf1SAo2acjAVzX2Po9P
         T68vFzqMSmSu5Cuy49zAHMtou9GyDiBhEqJR7wbhFKbOQB7Rlv7g3yEcJgrofI1bzTcN
         g9g4EvhYOYX4e4lGlgjH+vVdKh9AjPczbTY/xfUxhmJ9C1yYldqRCC/FXytPHNyGPNdX
         LBhHdzhvQmcP9dr02RDsLgL7Kmu5AbcBrYTPEGsouK/YbAbQLlzrWnMzvfkQtZ7MiuJP
         P2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727616679; x=1728221479;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVJWhSUCq6HWlZXlmldiICSmD5/m9Zw9scstAJoBrAI=;
        b=js2zJuMRjGCT+2DYBq4fKxNXiA02E3of4P8c/FvEevgX/ocXOwjnmhO/TdlfLMTW/K
         VJM0IMRg9ctpixwq8OP4huASCz5mK5VipggmHVpLJO2mO26bLl3JGJh8Alsh3pn7A89L
         4uMDw2em3KrZ2Ir/yEIQCSBRly9xpNfMmE95bghSbo64HtRkmMWVaBUOsqLu1ovoXNVV
         d0bMQYEDfPWE6qF5O89NKhRkxTXq1q52d8/8uFDsvoK1Y9P2r1tPgDNSByn1RT0k1gVn
         iobV0yfN/GXYgxUMedEFnIZWIRSMtEp5meJZgc9Wb6qvY0T8t71mzLCmtf1lxWYoIvDG
         DlwA==
X-Forwarded-Encrypted: i=1; AJvYcCXxWzGrt6xmNwAIIr4p9oSn166FzcIS5ieoS++HHbAfECR4ftxFcSvXRpVNicOP/0+XLOG5Y/TUIRjhJtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExmDMEPp4t4lGHipkjqKarptmw+Vv/1HZIWpTLf3pdyMMHtB7
	jn/ZoX4khtzFrCyiLNZ3bHtdN+n4VfVVvkxBshhABnK7fWVNJHJ7Qh4r407jPIrd/kiF/TZccAX
	dFtt7qJho0aqHtQkTp4Ta4zuWNsw=
X-Google-Smtp-Source: AGHT+IHCI4qA8gLFxQzmxTkeazg6D6Mwm1JAGP/zcarnI4WZ6q/NBWm5fijmUZjh3XrLqfihl3ymNEX8/0vRI5iSm54=
X-Received: by 2002:a05:622a:19a1:b0:458:3d2a:65b3 with SMTP id
 d75a77b69052e-45c9f1d6cdfmr146173941cf.11.1727616678579; Sun, 29 Sep 2024
 06:31:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Sun, 29 Sep 2024 10:30:42 -0300
Message-ID: <CAM_RzfavjM9VPJhTi1czOSC0BFOc3FUHRMdzFrU9fJE+WJMKbw@mail.gmail.com>
Subject: [PATCH 1/2] device: rust: change the name function
To: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Why did I make this change?
This function "Device::from_raw()" increments the refcount by this command
"bindings::get_device(prt)". This can be confused because the function
Arc::from_raw() from the standard library, doesn't increment the refcount.

This discussion is in
https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E

The options can be:
1) Rename the function for don't make confusing with the Arc::from_raw().
2) Remove this function and use the unsafe { Device::as_ref(ptr) }.into()
when I need the get pointer for the device.


Proposed solution
I like the first option. Because, how was will commented by Boqun Feng
, when the
people write the unsafe { Device::as_ref(ptr) }.into() again, again and again...
inevitably anybody will create a help function for this.

Then I think that we should rename this function for
Device::get_from_raw() or maybe
Device::get_device() and I like more of the second option because,
this will be equal
the get_device() function that already exists in .c code.


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


Then I enable this in menu config... compile the kernel e run this in a qemu
qemu-system-x86_64 -kernel bzImage -initrd initramfs.img -m 2G
-machine q35 -device ich9-ahci,id=sata -drive
id=disk,file=rootfs.img,if=none,format=raw -device
ide-hd,drive=disk,bus=sata.0 -append "root=/dev/sda console=ttyS0"
-nographic -monitor telnet:127.0.0.1:5555,server,nowai

the expected print is showing
[    2.786174] device_test: initial device test
[    2.786541] device_test: device created

