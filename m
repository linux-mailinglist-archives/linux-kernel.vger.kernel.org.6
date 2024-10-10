Return-Path: <linux-kernel+bounces-358169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C0997AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3941C1C23A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932E8189918;
	Thu, 10 Oct 2024 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="dO4l3rb8"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0614A627
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529285; cv=none; b=ghi+NqmeVMD5DF91syY4KbKxYFFrTUEFXkfRkX0ZsUpz4DcVbkKW3rNfNAE61ug7ZwtJYdtUrF0GtQB/Cq8T0KTOuullxKDWlS9OTnFH1E5StF1TgG4P61EN+1I5EgHt8gY5JpPG/IiFv42bbdcdYBwkmg3IyO3EpIqez0aWM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529285; c=relaxed/simple;
	bh=HjNfATR+0D9/yvN5PJVWq2tCu0LS/g4mAGWEPj2SfaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G5uT3TWJ9zCDSqPEicGB13otugjlVyHzpXkNn7AMkrWGmD9laSInwqfUrmHuX/6rYrAaEaLo/PTfkDuW2nlBPFpPjhip5t8gF0cGM/5TEE1pvZmSqR97k9F6KWsD2LZLpnxAPgoLDqdMSKBT9rbeHJKPsmefp2cX/k8juKOn5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=dO4l3rb8; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-835453714e5so18367739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 20:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1728529283; x=1729134083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19XrpJWo5a5gBk75zTGuTjmDV9UXEYk+OyCOWs/8F9Q=;
        b=dO4l3rb8kx+VFxyeFMPZ3BA3sHQR5R/W+1k4t67vbJA1tVrrNreiQq8adVaEWBuqTv
         pu7LJ/CMd+XFDP8pEJRRO/7zLLczRriyxHBlyHtWMU5IiL1PhndeuXKEKshIUlcPZcJm
         XqUJR0ScBr8C55fsi+K/7+YADKdtV9BuoU9I0o+nTpKjChS3fHsxJlZlb3j78osr0e4l
         jDe05txm7J11U6EJL/H8n4q1IagE/m7hIC9bnnpBLUr17CT6VXaauKaaCnJRk2zEf4XA
         hO3s5QuPeDNlq/7NgC4dxvPM3Y5n2LcBDMtJGzo5w22UCsFY8yg+ij5+dXWORNFn5aBR
         dC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728529283; x=1729134083;
        h=content-transfer-encoding:mime-version:organization:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19XrpJWo5a5gBk75zTGuTjmDV9UXEYk+OyCOWs/8F9Q=;
        b=coTcb3pMVm/qYrTVrYmpxp0Zc7uf1EFVmSFzcS0qCwUrK/O4NSJFzIjFqlHmcG5i2B
         e63nkZUuQaBajvdpgQqYIY0bN7gv5EKbCv1MK3szXIa8OUw4azvxi6XG0kXvlGERR2sj
         86WgiV/GP+BKqCMLsf8Te38x+8LOyL4FrFh1Gqg/vuBRX5c6y7tn2dZHHENMacIrWRXE
         g/c9M50t946XGoanGoYFKRyfcxtJe4wqefQjIx+wgA/06dXi4zvwZ6IgZp17O+IoX+xd
         XWAz+fxQOAjYHAYZ/lc5EAc7Hk4mzNIer6mRZ/7yHRoK7sEFxzbCh1Aqs6FeZQyUFYKW
         nqsg==
X-Forwarded-Encrypted: i=1; AJvYcCWfiqkPlEKn3ZGBaWLUXKPz8R45kSwx1oD9URRFdHk5PqvZzWcQIpaUjPs3ZaWG7foll9YsVge7rVxBb8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz87GC6snHYTbxe1XD58Clkt4Dc8Md8v1jSIjxs4bqgwGLZIhyP
	ncjHz3Fb+pS8BlezZlHJp2UgjHN4ie2U/BCT8ZrupWE/aFkkroth5sEIOvOymWg=
X-Google-Smtp-Source: AGHT+IE6S1SX0rkK7TT8JqVkglPbbfEygKnOKQz47PuwYsv/PSbuU8UkBzHe9D6yFyoUwn5jbDRE8g==
X-Received: by 2002:a05:6602:611c:b0:82d:2a45:79f6 with SMTP id ca18e2360f4ac-83547be10c1mr243239639f.11.1728529282786;
        Wed, 09 Oct 2024 20:01:22 -0700 (PDT)
Received: from kf-ir16 ([2607:fb91:111c:4921:cc0f:e4be:af60:359a])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadaa8e09sm79159173.127.2024.10.09.20.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:01:22 -0700 (PDT)
Date: Wed, 9 Oct 2024 22:01:18 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
 michael.jamet@intel.com, andreas.noever@gmail.com
Cc: linux-usb@vger.kernel.org, mmikowski@kfocus.org,
 linux-kernel@vger.kernel.org
Subject: USB-C DisplayPort display failing to stay active with Intel Barlow
 Ridge USB4 controller, power-management related issue?
Message-ID: <20241009220118.70bfedd0@kf-ir16>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

We're experiencing a Linux kernel bug affecting multiple Clevo X370SNx1
laptops (specifically the X370SNW1 variant). The bug appears to be
present in kernels greater than or equal to 6.5, worsening
significantly with kernel 6.11.2 (latest stable at time of this
writing). It is unclear if all of the issues encountered are the same
bug, however the primary problem we've run into appears to be a
consequence of the power management code involving Intel Barlow Ridge
controllers and DisplayPort. The issue occurs with in-kernel Nouveau
drivers and also with proprietary NVIDIA drivers.

When a DisplayPort monitor is attached to these laptops via a USB-C
connection, the monitor is recognized by the system and comes on for
approximately 15 seconds. It then blanks out and is automatically
disconnected from the system as if it had been unplugged. It will
remain that way indefinitely until unplugged and replugged, or until
something "jiggles" (for lack of a better term) the thunderbolt driver.
When either of these things occur, the display will re-attach and come
back on for 15 seconds, then blank out and detach again. There are
various different things that can "jiggle" the thunderbolt driver,
including but not limited to:

* Running `lspci -k` (this one came as a particular surprise)
* Removing and re-inserting the thunderbolt driver (`sudo modprobe -r
  thunderbolt; sleep 1; sudo modprobe thunderbolt`)
* Running `nvidia-detector` while proprietary NVIDIA drivers are loaded

It is possible to mitigate this issue by simply running
`sudo modprobe -r thunderbolt` or `sudo rmmod thunderbolt` and then
leaving the driver unloaded. USB-C displays become stable after this -
they are recognized when attached and remain recognized and functional
indefinitely as one would expect.

We believe this is related to the Intel Barlow Ridge USB4 controller
because:

* Removing the thunderbolt driver restores normal display operation.
* This issue was *not* a problem on Clevo X370SNx machines, which are
  identical to the X370SNx1 except for the Maple Ridge TBT controller
  on the board has been replaced with a Barlow Ridge USB4 controller.
* This problem does not occur on the affected models with the 6.1
  kernel. It occurs with the 6.5 kernel and on all newer kernels we
  have tried.

Furthermore, from inspecting the Thunderbolt driver code, we believe
this is related to the power management features of the driver, because:

* There is only one 15-second timeout defined in the driver source
  code, that being TB_AUTOSUSPEND_DELAY in drivers/thunderbolt/tb.h
* On earlier kernels (Ubuntu=E2=80=99s variant of 6.8 at least), displays a=
re
  stable even when the thunderbolt driver is loaded if we:
  * Remove the thunderbolt driver
  * Attach a USB-C dock
  * Attach displays to the dock (we used 2 4K HDMI monitors)
  * Reload the thunderbolt driver

During our investigation, we discovered commit
a75e0684efe567ae5f6a8e91a8360c4c1773cf3a (patch on mailing list at
https://lore.kernel.org/linux-usb/20240213114318.3023150-1-mika.westerberg@=
linux.intel.com/)
which appears to be a fix for this exact problem. It adds a quirk for
Intel Barlow Ridge controllers, which detects when a DisplayPort device
has been plugged directly into the USB4 port (thus using "redrive"
mode), and instructs the power management subsystem to not power the
chip down during this time if so. Unfortunately, this quirk seems to be
silently ignored, as we built a custom kernel with some `printk` lines
added to the `tb_enter_redrive` and `tb_exit_redrive` functions to
announce when they were called, and nothing in the dmesg log indicated
that they had been called when we did this.

This bug is easily reproducible using the stock kernels in Kubuntu
22.04, Kubuntu 24.04, Kali Linux 2024.2, and Fedora Workstation
Rawhide. Similar behavior is observed across all of these distributions.

We built the 6.11.2 kernel from source and tested it on Kubuntu 24.04,
but while the kernel built, installed, and functioned properly in most
respects, it actually made the problem with USB-C displays worse. As
long as the thunderbolt driver was loaded, no displays were detected
when plugged in (not for even a short length of time), and when the
thunderbolt driver was unloaded, displays would only be recognized and
function if there was only one display attached. Attaching a second
display resulted in the first external display becoming detached and
the second display not coming on. Unplugging the second display
resulted in the first display reattaching. This machine supports up to
three external displays and this has proven to be achievable and stable
with earlier kernels. No valuable error messages were logged in dmesg
when these problems occurred.

Our testing has been limited to the Clevo X370SNW1 model, however we
expect that the X370SNV1 model will exhibit the same issues as it uses
very similar internal components on the system board.

This is basically the extent of our knowledge at this point. We
attempted various patches on Ubuntu's 6.8 kernel to resolve the issue,
all without success:

* We attempted reverting fd4d58d1fef9ae9b0ee235eaad73d2e0a6a73025
  (thunderbolt: Enable CL2 low power state), which had no effect.
* We noticed that one of the Barlow Ridge bridge controllers
  listed by `lspci -k` appeared to not have its device ID in
  drivers/thunderbolt/nhi.h and there was a corresponding quirk in
  drivers/thunderbolt/quirks.c that looked like it might be vaguely
  related to the issue (specifically quirk_usb3_maximum_bandwidth), so
  we tried adding that device to the appropriate files in order to make
  that quirk apply to that device as well, this had no visible effect
  on the kernel's operation and did not resolve the issue.
* After narrowing it down to `quirk_block_rpm_in_redrive`, we attempted
  adding a new `thunderbolt.kf_force_redrive` kernel parameter in
  drivers/thunderbolt/tb.c that forced the code in
  `tb_enter_redrive` and `tb_exit_redrive` to be executed even *if* the
  device didn't have the appropriate quirk bit set, in the hopes that
  this would make the quirk execute and resolve the issue. What ended
  up happening was somehow `tb_enter_redrive` was never called at all
  and `tb_exit_redrive` was called. This in turn made it so that no
  USB-C displays would even be recognized for a short period of time if
  the thunderbolt driver was loaded.
* Looking at PCI vendor IDs, we noticed that the PCI vendor ID used to
  recognize all Intel controllers in drivers/thunderbolt/quirks.c was
  0x8087, whereas the Barlow Ridge controller in our device reported a
  vendor ID of 0x8086. On the off chance that this was a typo of epic
  proportions, we tried adjusting all of the occurrences of 0x8087 in
  the tb_quirks[] array to PCI_VENDOR_ID_INTEL (which is defined as
  0x8086 in include/linux/pci_ids.h). This has no visible effect on the
  kernel's behavior, and did not resolve the issue. (Presumably there's
  something going on with the IDs there that we're not aware of.)

As to my speculation as to what's wrong, I believe this is likely a
combination of two things:

* Some data in the `tb_quirks` array in drivers/thunderbolt/quirks.c is
  incorrect and leading to the Barlow Ridge controllers not being
  recognized as needing the DisplayPort redrive mode quirk.
* The code in drivers/thunderbolt/tb.c `tb_dp_resource_unavailable`
  that controls whether or not to run `tb_enter_redrive` is faulty in
  some way and is not calling `tb_enter_redrive` in all scenarios where
  it is necessary. To be clear, the exact code I'm talking about is
  this chunk from the aforementioned function:

        tunnel =3D tb_find_tunnel(tb, TB_TUNNEL_DP, in, out);
        if (tunnel)
                tb_deactivate_and_free_tunnel(tunnel);
        else=20
                tb_enter_redrive(port);

Finally, this is probably a result of me misreading the driver code
somehow, but I was surprised by the following conditional at the top
of `tb_enter_redrive`:

        if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
                return;

To me this reads as "if the DP redrive quirk bit is set, return and do
nothing. Otherwise, if the bit is not set, run the quirk function."
This is the opposite of what I would expect - shouldn't the code run if
the bit is set, not if it is clear? Or does the bit being unset mean
that the quirk is active? (I do not believe that this is the root cause
of the issue because even when I forced this function to run any time
it was invoked, it wasn't being invoked at all.)

This issue has only been definitively reproduced on already-EOL kernels
due to the (potentially related) problem encountered with 6.11.2.
However based on a code comparison it appears all of the apparently
relevant code (that which deals with the DP quirk) is identical between
Ubuntu's variation of the 6.8 kernel and the tip of the mainline master
branch. Therefore I believe this issue very likely impacts the latest
mainline kernel.


