Return-Path: <linux-kernel+bounces-226228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86521913BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A319F1C20EC8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B60181BB5;
	Sun, 23 Jun 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fIypESfT"
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E6D1EB25
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719153269; cv=none; b=rsheWmnZmkGSjhpGmVrhPHD1QHTCFMlBvOEf/Ql2hGXe6Yc20qP1lxwISOZ3XIplUygZEWkqTnbivKFO2C4+c0JvJo7DIaVNQFiaDzLYkmxkI9avn1VOqlLelQmYDWlkw/U6oujrALraAcZWlmOeWCpbd/eX0NRYrhhxCZzRnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719153269; c=relaxed/simple;
	bh=cI+eFQThfbuf0KxwRU0P+ggN2CKNdDIfybh7bTdpYBM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ehWX4UcJ/kuLFmtWmV3I01OmkaEMyCRAk1P5VIEtjIUTUCfoPd8f/5TicnJeQZ5GmmKcRrsF5BSd1pTDCJ7eT17lTANtWjXkikYHz7++8TGZ6SVZlNA7nrir0RSJHNSFxvj0J257Kve5xSKaC6IgdRQr25OiBOux7BDTqt5Diks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=fIypESfT; arc=none smtp.client-ip=185.70.40.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1719153257; x=1719412457;
	bh=p1eeQMQxha6yn1aZF7iHoHaKG1rA/hWlLXF/ozfklm4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fIypESfTregAM7AvhMiOSKL2GwQQ8AW4RanZN0FUtxVrhDTNHjDD0Vtac24xe3xbn
	 ClJlCIZL0hI0B34cYIu7HOvPKtmBa80hQbrnbiJ6pgwbYvcm/vbv7IlwUOCcjRL5v0
	 lXbUeYzMSKVzWw6Uyo2AOes0F1Qk9so+JCsBj/NzzZb+lXYJZ68rni6pymOG3OT5yj
	 RfWtlHq/TKBKN3Y0+bro8R+50edc5v2YH58oVA/UR6L++X1otPHX36m0XalO1Gdh+w
	 5SHnOCRIbjlinc68XLC6EXwIBFrWj0Jg77ivzVVSPnzuQQ28AATDwUtMnpCxs4nU9W
	 OAi3GZAftEaHA==
Date: Sun, 23 Jun 2024 14:34:12 +0000
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Stable linux-5.10.x regression triggered by MDS mitigation
Message-ID: <IdYcxU6x6xuUqUg8cliJUnucfwfTO29TrKIlLGCCYbbIr1EQnP0ZAtTxdAM2hp5e5Gny_acIN3OFDS6v0sazocnZZ1UBaINEJ0HoDnbasSI=@protonmail.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 73b9c0e2971e71ba75489e27d73131b41a7615d3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have 32-bit x86 linux virtual machine running on
QEMU-8.2.2+ds-0ubuntu1 with KVM acceleration. QEMU emulated
CPU model is pentium2. Host is 64-bit linux running on Intel
i5-7200U with latest microcode. Inside that 32-bit x86 linux
VM I sometimes start dosemu to run some old MS-DOS programs.

Now dosemu fails to start with "Segmentation fault" error,
and this shows up in dmesg output:

[   23.768348] general protection fault: 0000 [#1]
[   23.768353] CPU: 0 PID: 1730 Comm: dosemu.bin Not tainted 5.10.214-test1=
2345 #1
[   23.768354] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   23.768358] EIP: restore_all_switch_stack+0xbd/0xc5
[   23.768359] Code: 10 36 89 48 fc 8b 4c 24 0c 81 e1 ff ff 00 00 36 89 48 =
f8 8b 4c 24 08 36 89 48 f4 8b 4c 24 04 36 89 48 f0 59 8d 60 f0 58 89 f6 <0f=
> 00 2d 80 87 5c c1 cf fc 0f a0 50 b8 00 00 00 00 8e e0 8c d0 66
[   23.768361] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[   23.768362] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ffc03fdc
[   23.768363] DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 0001004=
6
[   23.768366] CR0: 80050033 CR2: 00a33020 CR3: 0fc3b000 CR4: 00000290
[   23.768368] Call Trace:
[   23.768371]  ? show_regs+0x5d/0x60
[   23.768373]  ? __die_body+0x10/0x43
[   23.768374]  ? die_addr+0x27/0x3c
[   23.768376]  ? exc_general_protection+0x1e6/0x239
[   23.768378]  ? exc_bounds+0x8a/0x8a
[   23.768379]  ? handle_exception+0x147/0x147
[   23.768381]  ? exc_bounds+0x8a/0x8a
[   23.768386]  ? restore_all_switch_stack+0xbd/0xc5
[   23.768388]  ? exc_bounds+0x8a/0x8a
[   23.768389]  ? restore_all_switch_stack+0xbd/0xc5
[   23.768390] Modules linked in:
[   23.768392] ---[ end trace 960c0712f12c2f48 ]---
[   23.768394] EIP: restore_all_switch_stack+0xbd/0xc5
[   23.768395] Code: 10 36 89 48 fc 8b 4c 24 0c 81 e1 ff ff 00 00 36 89 48 =
f8 8b 4c 24 08 36 89 48 f4 8b 4c 24 04 36 89 48 f0 59 8d 60 f0 58 89 f6 <0f=
> 00 2d 80 87 5c c1 cf fc 0f a0 50 b8 00 00 00 00 8e e0 8c d0 66
[   23.768396] EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
[   23.768397] ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: ffc03fdc
[   23.768398] DS: 0000 ES: 0000 FS: 0000 GS: 0033 SS: 0068 EFLAGS: 0001004=
6
[   23.768400] CR0: 80050033 CR2: 00a33020 CR3: 0fc3b000 CR4: 00000290

Inside that 32-bit VM, kernel.org linux-5.10.214 and earlier
5.10.x versions start dosemu normally.

Inside that 32-bit VM, linux-5.10.215 and later 5.10.x
versions fail to start dosemu.

Inside that 32-bit VM, linux-5.10.215 and later 5.10.x
versions work if "mitigations=3Doff" kernel parameter is
added to the kernel running inside the VM.

I have narrowed down the problem so that linux-5.10.214 plus
following 5 patches trigger that failure. Above dmesg output
from "5.10.214-test12345" kernel includes following 5
patches.



x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.10.y&id=3D8b20c6f894b7d7d87d3aa1a85cbc7d57378e1346

x86/bugs: Add asm helpers for executing VERW
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.10.y&id=3D35e36eac881cddea42ca5fd93facc145a2d5369d

x86/entry_64: Add VERW just before userspace transition
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.10.y&id=3Dedc702b4a820fc7ffc20e732db1c421cfffbb746

x86/entry_32: Add VERW just before userspace transition
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.10.y&id=3D50f021f0b985629accf10481a6e89af8b9700583

x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.10.y&id=3D6192d9ed311f70eb7e8ab4a874631a98c5a9217e



My reading of above dmesg output indicates that it is that
VERW opcode that fails inside CLEAR_CPU_BUFFERS macro in
arch/x86/include/asm/nospec-branch.h file. My reading of
(possibly outdated) Intel Instruction Set Reference
indicates this: "The VERR and VERW instructions are not
recognized in virtual-8086 mode". My understanding is that
dosemu uses virtual-8086 mode if that is available. Did
above patch-set just kill virtual-8086 mode and dosemu
permanently despite my 32-bit VM kernel .config having
these?

 CONFIG_X86_LEGACY_VM86=3Dy
 CONFIG_VM86=3Dy

I know that I am doing weird stuff and I understand that
32-bit linux and dosemu are probably something that most
people don't care about, but this is still stable
linux-5.10.x kernel regression that should be fixed.

Upstream Linux-6.10-rc4 seems to have similarly functioning
CLEAR_CPU_BUFFERS macro with VERW opcode that is used in
restore_all_switch_stack code path, so the same problem may
well be with all newer kernels.

Pawan Gupta,
Since you seem to be the author of above mentioned breakage,
is there any chance of you sorting this out?

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


