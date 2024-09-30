Return-Path: <linux-kernel+bounces-344254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690EF98A780
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4CF1C22B50
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD43E192B78;
	Mon, 30 Sep 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeiOn11S"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E61922F9;
	Mon, 30 Sep 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707428; cv=none; b=SMHoSIIBq7u43HD/YUaTYM1k0+QZoCwCj1f4+EPBYqiQcBGKi0AtcATKx5qEHwsYpmAjd2TXvPFyEqQk43pS4fFVcnkU31ZM5YKTzjvOLq6YDOAJPRHKnwalRmDynQWwyh+oYeAbo/qdXnIM6wUqGsD9HXLIIhyHPTiUYtMmLuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707428; c=relaxed/simple;
	bh=V5KYCCRcPcoweZzkEDcp1YM6DPJokOBCsNi1DC8e1jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOH6GLTOS4ErD9q7KQ8jxH4pE6IzDuNS/t+8Bw2jf7C6eWeKUrBhoBClNYvmUCTdQsbQU/WS/GXrBVXN1SFwgmj2rkgcnucIVf9jIndLRbcJ3AhEogC1RFGp1B6BbhcNwyqZw1p9+BUMDoGIVSSnrwse2sn/9awa7G+3vYPynZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeiOn11S; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207115e3056so38345375ad.2;
        Mon, 30 Sep 2024 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727707426; x=1728312226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXlNw5h0RJKykTmyYsPmjNCcESsmoWRT0nX8xH3EQdc=;
        b=WeiOn11SsqZRcXpxnjc6tKw1PvyWK8t5rHBWtTJOvUYbsUikqU5y2kXrFbhOYxzFCU
         Taq8CV1pKG8EfHjFzhU4oo7YpxEN4753+hgetfXjiDFslFL75gnPgFzVDErrZIF2hnrl
         mkFmRewBoy8lKqFD4yC4IXIS29CVso8N3zIZxVbIKW6gvzX3nwwdHaKbwP9QtCdcd0bC
         GajJdqM1jOFp4u63vPnQv+2o89B1Qrw/NRjMkvZ/2ijio3DgQeutb8jUzCMegkHp/8hq
         HWggT/4C6vqUn7KLBQnpQ8K6nE/KtGN1TxEVqSse9DPpzbJMwB11lwatqHVcIK3is/OB
         Jc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707426; x=1728312226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXlNw5h0RJKykTmyYsPmjNCcESsmoWRT0nX8xH3EQdc=;
        b=qmFgm8X2VmKYGltDHyR5R8fp4neLhoqEhGPnYXvJ2mvg6qemACxVufl8e6N5jeKr7F
         TcuK/V31eDJ7fasdmEEtixxt8BKircz89bNkX7s6fqp3O0nZ2Ii55f+bgQL/FvCT44Lb
         J1w28tZ5FtlHFd2Sc7kY06B9Ns+Ygw/ZscsArySe3RHoZvDbbuHONAZo8omWBtBrR0HI
         Dv6rwKsSPTdQOHeV8GIIbCNXFsCf45dyeuRLDAH37AT2LnfwG4+ebqltpzagIfoqyPt3
         vCvecFR0IR5MNa1J9+R7wmBddEVKnCO4carboJNecLKlBlik+oUH8MqAWq3xq2L1IcGB
         OtSw==
X-Forwarded-Encrypted: i=1; AJvYcCVSd91hJXxF0dMEhcsDOLMgH/mQn9unXaUtVxUBsgQ+j4rkx0uKkzLkRriawcoxOmNGAQCs1ys7cupj83A=@vger.kernel.org, AJvYcCWql/ylEHNVBssxu1yOb7I8mLvXvxSExF7HekyC2LisMsawgJvb9hG0Ef4AnUVzskJkBKaUdb+uKTyCVkMzlHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBszUK7C1aJnGExbkcDCn+pLSEUMX0wO+ksxDDd5BmCETHoMbZ
	Y/HBv/42aLhUyxJtQml+iQBsgColhD1Q1ffzLVdbWFAxPEwgdruI
X-Google-Smtp-Source: AGHT+IGS1ybxXsoqy36LflxAz8iu2OPnV0ojb3/ucQhkDcaye7ou+jVOOvOluE7Djj1wKV6boNb85w==
X-Received: by 2002:a17:903:8cc:b0:20b:5b16:b16b with SMTP id d9443c01a7336-20b5b16b29dmr114037995ad.36.1727707425609;
        Mon, 30 Sep 2024 07:43:45 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d61db9sm54882005ad.26.2024.09.30.07.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 07:43:45 -0700 (PDT)
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
Subject: [PATCH v3 0/1] rust: device: rename "Device::from_raw()" 
Date: Mon, 30 Sep 2024 11:43:26 -0300
Message-ID: <20240930144328.51098-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Why did I make this change?
This function "Device::from_raw()" increments the refcount by this
command "bindings::get_device(prt)". This can be confused because the
function Arc::from_raw() from the standard library, doesn't increment
the refcount.

This discussion is in
https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E

The options can be:
1) Rename the function for don't make confusing with the
Arc::from_raw().
2) Remove this function and use the unsafe { Device::as_ref(ptr)
}.into() when I need the get pointer for the device.

Proposed solution
I like the first option. Because, how was will commented by Boqun Feng ,
when the people write the "unsafe { Device::as_ref(ptr) }.into()" again,
again and again... inevitably anybody will create a help function for
this.

Then I think that we should rename this function for
Device::get_from_raw() or maybe Device::get_device() and I like more of
the second option because, this will be equal the get_device() function
that already exists in .c code.


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


Then I enable this in menu config... compile the kernel e run this in a
qemu:
qemu-system-x86_64 -kernel bzImage -initrd initramfs.img -m 2G -machine
q35 -device ich9-ahci,id=sata -drive
id=disk,file=rootfs.img,if=none,format=raw -device
ide-hd,drive=disk,bus=sata.0 -append "root=/dev/sda console=ttyS0"
-nographic -monitor telnet:127.0.0.1:5555,server,nowai

the expected print is showing
[    2.786174] device_test: initial device test
[    2.786541] device_test: device created


Guilherme Giacomo Simoes (1):
  rust: device: rename "Device::from_raw()"

 rust/kernel/device.rs   | 2 +-
 rust/kernel/firmware.rs | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 

Changes from v2:
 - Refactored commit message style

