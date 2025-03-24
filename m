Return-Path: <linux-kernel+bounces-574582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEFFA6E71E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A393AC699
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F521D86E8;
	Mon, 24 Mar 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="isM2W+nA"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81984FAD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742857689; cv=none; b=JpfOdLf5OkGbc/G/QAzaFT4LlYiYct/VzW3TIdodf2ngNEyIrFqEuq0E9jTb6b6V+uufZ0OPfymvhx33FmzeB1VxMNmqFEtB0pwTRRxbGl8jgTiL3CmCERUL8MG6lgiZ57uRJDNlNmnA8nbRSKp7gzhIk6vOXG0tuwTpTrGQut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742857689; c=relaxed/simple;
	bh=uhRMTHpHbuG0d3wUH1RvLWchY+rjWN4lC+BhRLS15FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAso5zvoiXdC25FLhfQ4Bo+REWGEqMcWzH9qBkHMSJGLfBM4bDb1GBMtRaq8pZpqsxVzY7W65PbWF2rGvFrq3MM4WoQfH6UouVCSN7L7JNlv+1qwRxMp7R4Bw7VXhZAJl6gJ2ySv/Rk8q3Y9LUQR8nGLxNBRolWq9OzCo/DY9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=isM2W+nA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742857635; x=1743462435; i=spasswolf@web.de;
	bh=XH2AVN+mZDd6nJ+zhfqKWfLxoAwBDOIv47Z8tWzJP8o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=isM2W+nARE63oO9hwcq3/xtQJwLW31qKhmSXgskSmlXFYZS4C48Sn1c3EM9dm6tY
	 jWlbhQGX6zhPSJU/3aIqVn0qTQxYe8cKitI3KEjAyLQ9JVcdKEQdi1YqX9LdO+inI
	 UoW6FNmJMMNyVTNCgWbguKoC1iM5DsAuUN/vdsjz8lPCaStlKbDam7VjHI1brw83G
	 p9wCknoUqCrxNVgTk/Cn119M0PuGGp04OLZrhygRm7tx3mu3XCF0XOKd8qhgWWlG8
	 DMUq4mIkb+x8/v8LlGQDWUSzJ4lSyGKc8kCQK2Mo6hQrUGRT4XA/Ne32ItTgZ6j2f
	 gcrYdOPTT3hjhkSp0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mmyqx-1tG3PR1UsZ-00k6S9; Tue, 25 Mar 2025 00:07:14 +0100
From: Bert Karwatzki <spasswolf@web.de>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	Balbir Singh <balbirs@nvidia.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org
Subject: RE: commit 7ffb791423c7 breaks steam game
Date: Tue, 25 Mar 2025 00:07:11 +0100
Message-ID: <20250324230712.4122-1-spasswolf@web.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: 7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nyTay1HTrXwTJZNZ3ZvsBOn9kbOVvBz5bRuZrEz3Abj8nUIxV/T
 sGi7Ol8uDBQMXkK8k7Ue8iAg0QqnuFh/9373eXBy3oIDOzS7vPGcjRQInGUZGbaXpo4o3HE
 66eJL+aIlgbh80Mnnpb6LJZ0qYMJ0owraX8lPxGxPhSTdDUG1cvsjnWJCK2Ha2KPp8/LcwI
 RoAmvlSNBBZ5zxz4X8MAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UgfQ10ELsyo=;SAHR5p9qXvIv6Iq3hXz6f59/ENp
 NFyrNvwq602sUNC3fb0bI7Bse9Gg3//6eoN3Sk7pOm1Ic1HxnKasMYtq35yAmmpwBJMscCR0S
 YyApF2ibz661/oXEmzg2zZXF4wnh9Eo/ZWh3KXKLYm3axVv5QSbXEumxBREVZMzrj5WXFlpGl
 V8gn/tVlku9OZ4KH6uDnnCsA0e0WC4nvWwSbFwVwIAbD36ZrYgwUBE/6O1KR5M5yUvdep6GsF
 A2OBtKINsNXS1TAanuREkYVQtYhKERllTLI9+nznROGIDzrh6y409YJong7yZSP4rwqdqB1YQ
 PDPyykxLZQip8JmTB3JfbsgKsN64yimsSQKg4g+1+jIAV1Qp15QX8pSeK3aQ84X+o4a/Ig0Mp
 d5u5rXhoZLHFtJCsO8L1itj+Z8VQ1xr4cXSOXfUoSm5ImB6fvLEvzg8YNkLiLr7TWHDCp/TjI
 ZoztAlRasZQbGO19eTgtYEUlbwDExd1KpYH5QB4uElpSOmMGTn5VLemXnrqNW4iX6MRnMr4K1
 h5v8IwbLOZSbiGzADPmMQ5sShLMxls6agHuY7DdFAO1p9D9wQgZAeeVYUPzcwhgDV5nq/ZoxJ
 l7LW/h04BXYYvpJK4olFFSjUfbbj9H2/PSyf4zUTF+zTh9zyZSB9OcYjRB30Qk3C18MO3l8F4
 fpLmxnE/ewkyNO5alsU9Ku9BkNKEfU4LgcFMxRG8JscW8+oAGe0ZdUeeVM7RbMPpnMFUOGRx7
 /Avn0NmrmQpL4cyic6k8rVpeYNxMQD+DkJvDECYBrOiwhdRAN+z/yCupj8BXSZHEusOfyeTEN
 W6dzO12pMDMhaSaPRjTqLn25gUJnXRwF0eXguF/kDkQx4XyxQJRsbr4EPAE/AZ1OtqjaEQ0bw
 DbZQ618LZOCRRpzmlCEfMyjuXl+0w1x5GbekJZ0ck6Vzd5heM4RVX8cJYrwFCj8B/F6+sZFGu
 7W8aa5ub4Hms0seDJhktorK/okHjQVwdmovDMpl2ai5k5nV2WELSjAC5g+bNZVGtQih7p9+QY
 lgHC5EXNYQcXuNgdK7l0XAKNn2m9pzwaEJXxmpJoyFobepqkuX9vj7wrlKe6Ix6hgPX69I5TA
 tg+g0V/4SykyCCY8n7QhsmT6iRTHOmCMW7c1ebF9F7JiU9ZYA+AbTzK0GtWined/bz1WmE+b6
 eTgV/tSyCG6QTCgnv1T185rPEdS8WKnSZbKnv9cQM+0LCpqrNzbjcKKwYDmvOnzu2VebJPXen
 fb5s87J5YwGixwP2l5n5UvtZHOSaK4n6PbladpvErPbKHrBFjb5Rr5HXd4zl7o2Da9ekbWDFq
 AQKpEH6U0tLfKPjwm6waD5XUQjf8PQN1L4NjSiM2CXUN72I4sUBu3DuO9jevvEVlxB94SrZ8i
 guPqpodra1vJ8oMwwJQ424XmgZsLOkdjEAPfZnhmTqRUl3mmISLGfCnDmlmI3bi+XIv07dDPq
 GiuK7d8r/W22uHaTH37lzkLb/vdU=

Here's the dmesg from linux-next-6.14-rc7-next20250321 (CONFIG_PCI_P2PDMA =
not set)
The memory ranges of (afe00000000-affffffffff) or (3ffe00000000-3fffffffff=
ff) are
mentioned in neither of them.

Without nokaslr:
[    0.000000] [      T0] Linux version 6.14.0-rc7-next-20250321-master (b=
ert@lisa) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian)=
 2.44) #755 SMP PREEMPT_RT Mon Mar 24 23:23:21 CET 2025
[    0.000000] [      T0] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-=
rc7-next-20250321-master root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7da2b611=
2 ro clocksource=3Dhpet amdgpu.noretry=3D0 quiet
[    0.000000] [      T0] BIOS-provided physical RAM map:
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000000000000-0x00000000000=
9ffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000000a0000-0x00000000000=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000000100000-0x0000000009b=
fefff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000009bff000-0x000000000a0=
00fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x000000000a001000-0x000000000a1=
fffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x000000000a200000-0x000000000a2=
0efff] ACPI NVS
[    0.000000] [      T0] BIOS-e820: [mem 0x000000000a20f000-0x00000000e9e=
1ffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000e9e20000-0x00000000eb3=
3efff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000eb33f000-0x00000000eb3=
9efff] ACPI data
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000eb39f000-0x00000000eb5=
56fff] ACPI NVS
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000eb557000-0x00000000ed1=
fefff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000ed1ff000-0x00000000edf=
fffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000ee000000-0x00000000f7f=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fd000000-0x00000000fdf=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec=
01fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec=
10fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed=
00fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed=
44fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed=
8ffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fedc4000-0x00000000fed=
c9fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fedcc000-0x00000000fed=
cefff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fedd5000-0x00000000fed=
d5fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000ff000000-0x00000000fff=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000100000000-0x0000000fee2=
fffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000fee300000-0x000000100ff=
fffff] reserved
[    0.000000] [      T0] NX (Execute Disable) protection: active
[    0.000000] [      T0] APIC: Static calls initialized
[    0.000000] [      T0] efi: EFI v2.7 by American Megatrends
[    0.000000] [      T0] efi: ACPI=3D0xeb540000 ACPI 2.0=3D0xeb540014 TPM=
FinalLog=3D0xeb50c000 SMBIOS=3D0xed020000 SMBIOS 3.0=3D0xed01f000 MEMATTR=
=3D0xe6fa0018 ESRT=3D0xe87cb898 INITRD=3D0xe5e66518 RNG=3D0xeb351018 TPMEv=
entLog=3D0xeb343018
[    0.000000] [      T0] random: crng init done
[    0.000000] [      T0] efi: Remove mem54: MMIO range=3D[0xf0000000-0xf7=
ffffff] (128MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xf0000000-0xf7ffffff] reserve=
d
[    0.000000] [      T0] efi: Remove mem55: MMIO range=3D[0xfd000000-0xfd=
ffffff] (16MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xfd000000-0xfdffffff] reserve=
d
[    0.000000] [      T0] efi: Remove mem56: MMIO range=3D[0xfeb80000-0xfe=
c01fff] (0MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xfeb80000-0xfec01fff] reserve=
d
[    0.000000] [      T0] efi: Not removing mem57: MMIO range=3D[0xfec1000=
0-0xfec10fff] (4KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem58: MMIO range=3D[0xfed0000=
0-0xfed00fff] (4KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem59: MMIO range=3D[0xfed4000=
0-0xfed44fff] (20KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem60: MMIO range=3D[0xfed8000=
0-0xfed8ffff] (64KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem61: MMIO range=3D[0xfedc400=
0-0xfedc9fff] (24KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem62: MMIO range=3D[0xfedcc00=
0-0xfedcefff] (12KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem63: MMIO range=3D[0xfedd500=
0-0xfedd5fff] (4KB) from e820 map
[    0.000000] [      T0] efi: Remove mem64: MMIO range=3D[0xff000000-0xff=
ffffff] (16MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xff000000-0xffffffff] reserve=
d
[    0.000000] [      T0] SMBIOS 3.3.0 present.
[    0.000000] [      T0] DMI: Micro-Star International Co., Ltd. Alpha 15=
 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[    0.000000] [      T0] DMI: Memory slots populated: 2/2
[    0.000000] [      T0] tsc: Fast TSC calibration using PIT
[    0.000000] [      T0] tsc: Detected 3194.280 MHz processor
[    0.000133] [      T0] e820: update [mem 0x00000000-0x00000fff] usable =
=3D=3D> reserved
[    0.000134] [      T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000139] [      T0] last_pfn =3D 0xfee300 max_arch_pfn =3D 0x4000000=
00
[    0.000144] [      T0] MTRR map: 5 entries (3 fixed + 2 variable; max 2=
0), built from 9 variable MTRRs
[    0.000146] [      T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB=
  WP  UC- WT
[    0.000241] [      T0] e820: update [mem 0xf0000000-0xffffffff] usable =
=3D=3D> reserved
[    0.000246] [      T0] last_pfn =3D 0xee000 max_arch_pfn =3D 0x40000000=
0
[    0.002782] [      T0] esrt: Reserving ESRT space from 0x00000000e87cb8=
98 to 0x00000000e87cb8d0.
[    0.002787] [      T0] e820: update [mem 0xe87cb000-0xe87cbfff] usable =
=3D=3D> reserved
[    0.002797] [      T0] Using GB pages for direct mapping
[    0.002925] [      T0] Secure boot disabled
[    0.002926] [      T0] RAMDISK: [mem 0xdc578000-0xdeea1fff]
[    0.002965] [      T0] ACPI: Early table checksum verification disabled
[    0.002967] [      T0] ACPI: RSDP 0x00000000EB540014 000024 (v02 MSI_NB=
)
[    0.002969] [      T0] ACPI: XSDT 0x00000000EB53F728 000114 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  01000013)
[    0.002973] [      T0] ACPI: FACP 0x00000000EB390000 000114 (v06 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.002975] [      T0] ACPI: DSDT 0x00000000EB383000 00C50C (v02 MSI_NB=
 MEGABOOK 01072009 INTL 20190509)
[    0.002977] [      T0] ACPI: FACS 0x00000000EB50A000 000040
[    0.002978] [      T0] ACPI: SLIC 0x00000000EB39E000 000176 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  01000013)
[    0.002979] [      T0] ACPI: SSDT 0x00000000EB396000 0072B0 (v02 AMD   =
 AmdTable 00000002 MSFT 04000000)
[    0.002981] [      T0] ACPI: IVRS 0x00000000EB395000 0001A4 (v02 AMD   =
 AmdTable 00000001 AMD  00000000)
[    0.002982] [      T0] ACPI: SSDT 0x00000000EB391000 003A21 (v01 AMD   =
 AMD AOD  00000001 INTL 20190509)
[    0.002983] [      T0] ACPI: FIDT 0x00000000EB382000 00009C (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.002984] [      T0] ACPI: ECDT 0x00000000EB381000 0000C1 (v01 MSI_NB=
 MEGABOOK 01072009 AMI. 00010013)
[    0.002985] [      T0] ACPI: MCFG 0x00000000EB380000 00003C (v01 MSI_NB=
 MEGABOOK 01072009 MSFT 00010013)
[    0.002986] [      T0] ACPI: HPET 0x00000000EB37F000 000038 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00000005)
[    0.002988] [      T0] ACPI: VFCT 0x00000000EB371000 00D884 (v01 MSI_NB=
 MEGABOOK 00000001 AMD  31504F47)
[    0.002989] [      T0] ACPI: BGRT 0x00000000EB370000 000038 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.002990] [      T0] ACPI: TPM2 0x00000000EB36F000 00004C (v04 MSI_NB=
 MEGABOOK 00000001 AMI  00000000)
[    0.002991] [      T0] ACPI: SSDT 0x00000000EB369000 005354 (v02 AMD   =
 AmdTable 00000001 AMD  00000001)
[    0.002992] [      T0] ACPI: CRAT 0x00000000EB368000 000EE8 (v01 AMD   =
 AmdTable 00000001 AMD  00000001)
[    0.002993] [      T0] ACPI: CDIT 0x00000000EB367000 000029 (v01 AMD   =
 AmdTable 00000001 AMD  00000001)
[    0.002994] [      T0] ACPI: SSDT 0x00000000EB366000 000149 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.002996] [      T0] ACPI: SSDT 0x00000000EB364000 00148E (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.002997] [      T0] ACPI: SSDT 0x00000000EB362000 00153F (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.002998] [      T0] ACPI: SSDT 0x00000000EB361000 000696 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.002999] [      T0] ACPI: SSDT 0x00000000EB35F000 001A56 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003000] [      T0] ACPI: SSDT 0x00000000EB35E000 0005DE (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003001] [      T0] ACPI: SSDT 0x00000000EB35A000 0036E9 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003002] [      T0] ACPI: WSMT 0x00000000EB359000 000028 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.003004] [      T0] ACPI: APIC 0x00000000EB358000 0000DE (v03 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.003005] [      T0] ACPI: SSDT 0x00000000EB357000 00008D (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003006] [      T0] ACPI: SSDT 0x00000000EB356000 0008A8 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003007] [      T0] ACPI: SSDT 0x00000000EB355000 0001B7 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003008] [      T0] ACPI: SSDT 0x00000000EB354000 0007B1 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003009] [      T0] ACPI: SSDT 0x00000000EB353000 00097D (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003010] [      T0] ACPI: FPDT 0x00000000EB352000 000044 (v01 MSI_NB=
 A M I    01072009 AMI  01000013)
[    0.003011] [      T0] ACPI: Reserving FACP table memory at [mem 0xeb39=
0000-0xeb390113]
[    0.003012] [      T0] ACPI: Reserving DSDT table memory at [mem 0xeb38=
3000-0xeb38f50b]
[    0.003012] [      T0] ACPI: Reserving FACS table memory at [mem 0xeb50=
a000-0xeb50a03f]
[    0.003013] [      T0] ACPI: Reserving SLIC table memory at [mem 0xeb39=
e000-0xeb39e175]
[    0.003013] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb39=
6000-0xeb39d2af]
[    0.003014] [      T0] ACPI: Reserving IVRS table memory at [mem 0xeb39=
5000-0xeb3951a3]
[    0.003014] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb39=
1000-0xeb394a20]
[    0.003014] [      T0] ACPI: Reserving FIDT table memory at [mem 0xeb38=
2000-0xeb38209b]
[    0.003015] [      T0] ACPI: Reserving ECDT table memory at [mem 0xeb38=
1000-0xeb3810c0]
[    0.003015] [      T0] ACPI: Reserving MCFG table memory at [mem 0xeb38=
0000-0xeb38003b]
[    0.003015] [      T0] ACPI: Reserving HPET table memory at [mem 0xeb37=
f000-0xeb37f037]
[    0.003016] [      T0] ACPI: Reserving VFCT table memory at [mem 0xeb37=
1000-0xeb37e883]
[    0.003016] [      T0] ACPI: Reserving BGRT table memory at [mem 0xeb37=
0000-0xeb370037]
[    0.003016] [      T0] ACPI: Reserving TPM2 table memory at [mem 0xeb36=
f000-0xeb36f04b]
[    0.003017] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
9000-0xeb36e353]
[    0.003017] [      T0] ACPI: Reserving CRAT table memory at [mem 0xeb36=
8000-0xeb368ee7]
[    0.003017] [      T0] ACPI: Reserving CDIT table memory at [mem 0xeb36=
7000-0xeb367028]
[    0.003018] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
6000-0xeb366148]
[    0.003018] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
4000-0xeb36548d]
[    0.003018] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
2000-0xeb36353e]
[    0.003019] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
1000-0xeb361695]
[    0.003019] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
f000-0xeb360a55]
[    0.003020] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
e000-0xeb35e5dd]
[    0.003020] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
a000-0xeb35d6e8]
[    0.003020] [      T0] ACPI: Reserving WSMT table memory at [mem 0xeb35=
9000-0xeb359027]
[    0.003021] [      T0] ACPI: Reserving APIC table memory at [mem 0xeb35=
8000-0xeb3580dd]
[    0.003021] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
7000-0xeb35708c]
[    0.003021] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
6000-0xeb3568a7]
[    0.003022] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
5000-0xeb3551b6]
[    0.003022] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
4000-0xeb3547b0]
[    0.003022] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
3000-0xeb35397c]
[    0.003023] [      T0] ACPI: Reserving FPDT table memory at [mem 0xeb35=
2000-0xeb352043]
[    0.003073] [      T0] Zone ranges:
[    0.003074] [      T0]   DMA      [mem 0x0000000000001000-0x0000000000f=
fffff]
[    0.003075] [      T0]   DMA32    [mem 0x0000000001000000-0x00000000fff=
fffff]
[    0.003076] [      T0]   Normal   [mem 0x0000000100000000-0x0000000fee2=
fffff]
[    0.003076] [      T0]   Device   empty
[    0.003077] [      T0] Movable zone start for each node
[    0.003077] [      T0] Early memory node ranges
[    0.003077] [      T0]   node   0: [mem 0x0000000000001000-0x0000000000=
09ffff]
[    0.003078] [      T0]   node   0: [mem 0x0000000000100000-0x0000000009=
bfefff]
[    0.003079] [      T0]   node   0: [mem 0x000000000a001000-0x000000000a=
1fffff]
[    0.003079] [      T0]   node   0: [mem 0x000000000a20f000-0x00000000e9=
e1ffff]
[    0.003079] [      T0]   node   0: [mem 0x00000000ed1ff000-0x00000000ed=
ffffff]
[    0.003080] [      T0]   node   0: [mem 0x0000000100000000-0x0000000fee=
2fffff]
[    0.003083] [      T0] Initmem setup node 0 [mem 0x0000000000001000-0x0=
000000fee2fffff]
[    0.003086] [      T0] On node 0, zone DMA: 1 pages in unavailable rang=
es
[    0.003098] [      T0] On node 0, zone DMA: 96 pages in unavailable ran=
ges
[    0.003192] [      T0] On node 0, zone DMA32: 1026 pages in unavailable=
 ranges
[    0.006770] [      T0] On node 0, zone DMA32: 15 pages in unavailable r=
anges
[    0.006855] [      T0] On node 0, zone DMA32: 13279 pages in unavailabl=
e ranges
[    0.007046] [      T0] On node 0, zone Normal: 8192 pages in unavailabl=
e ranges
[    0.007082] [      T0] On node 0, zone Normal: 7424 pages in unavailabl=
e ranges
[    0.008054] [      T0] ACPI: PM-Timer IO Port: 0x808
[    0.008060] [      T0] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x=
1])
[    0.008071] [      T0] IOAPIC[0]: apic_id 33, version 33, address 0xfec=
00000, GSI 0-23
[    0.008075] [      T0] IOAPIC[1]: apic_id 34, version 33, address 0xfec=
01000, GSI 24-55
[    0.008076] [      T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 =
dfl dfl)
[    0.008078] [      T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 =
low level)
[    0.008080] [      T0] ACPI: Using ACPI (MADT) for SMP configuration in=
formation
[    0.008080] [      T0] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.008087] [      T0] e820: update [mem 0xe62ee000-0xe63e1fff] usable =
=3D=3D> reserved
[    0.008100] [      T0] CPU topo: Max. logical packages:   1
[    0.008100] [      T0] CPU topo: Max. logical dies:       1
[    0.008100] [      T0] CPU topo: Max. dies per package:   1
[    0.008103] [      T0] CPU topo: Max. threads per core:   2
[    0.008104] [      T0] CPU topo: Num. cores per package:     8
[    0.008104] [      T0] CPU topo: Num. threads per package:  16
[    0.008104] [      T0] CPU topo: Allowing 16 present CPUs plus 0 hotplu=
g CPUs
[    0.008117] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x00000000-0x00000fff]
[    0.008118] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x000a0000-0x000fffff]
[    0.008119] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x09bff000-0x0a000fff]
[    0.008119] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x0a200000-0x0a20efff]
[    0.008120] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xe62ee000-0xe63e1fff]
[    0.008121] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xe87cb000-0xe87cbfff]
[    0.008122] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xe9e20000-0xeb33efff]
[    0.008122] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xeb33f000-0xeb39efff]
[    0.008122] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xeb39f000-0xeb556fff]
[    0.008123] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xeb557000-0xed1fefff]
[    0.008123] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xee000000-0xefffffff]
[    0.008124] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xf0000000-0xfec0ffff]
[    0.008124] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfec10000-0xfec10fff]
[    0.008124] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfec11000-0xfecfffff]
[    0.008125] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed00000-0xfed00fff]
[    0.008125] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed01000-0xfed3ffff]
[    0.008125] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed40000-0xfed44fff]
[    0.008125] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed45000-0xfed7ffff]
[    0.008126] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed80000-0xfed8ffff]
[    0.008126] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed90000-0xfedc3fff]
[    0.008126] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedc4000-0xfedc9fff]
[    0.008126] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedca000-0xfedcbfff]
[    0.008127] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedcc000-0xfedcefff]
[    0.008127] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedcf000-0xfedd4fff]
[    0.008127] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedd5000-0xfedd5fff]
[    0.008128] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedd6000-0xffffffff]
[    0.008129] [      T0] [mem 0xf0000000-0xfec0ffff] available for PCI de=
vices
[    0.008131] [      T0] clocksource: refined-jiffies: mask: 0xffffffff m=
ax_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.010529] [      T0] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_c=
pu_ids:16 nr_node_ids:1
[    0.010863] [      T0] percpu: Embedded 45 pages/cpu s146800 r8192 d293=
28 u262144
[    0.010867] [      T0] pcpu-alloc: s146800 r8192 d29328 u262144 alloc=
=3D1*2097152
[    0.010868] [      T0] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 0=
9 10 11 12 13 14 15
[    0.010880] [      T0] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-=
6.14.0-rc7-next-20250321-master root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf7=
da2b6112 ro clocksource=3Dhpet amdgpu.noretry=3D0 quiet
[    0.010913] [      T0] Unknown kernel command line parameters "BOOT_IMA=
GE=3D/boot/vmlinuz-6.14.0-rc7-next-20250321-master", will be passed to use=
r space.
[    0.010930] [      T0] printk: log buffer data + meta data: 131072 + 45=
8752 =3D 589824 bytes
[    0.015167] [      T0] Dentry cache hash table entries: 8388608 (order:=
 14, 67108864 bytes, linear)
[    0.017277] [      T0] Inode-cache hash table entries: 4194304 (order: =
13, 33554432 bytes, linear)
[    0.017374] [      T0] software IO TLB: area num 16.
[    0.025999] [      T0] Built 1 zonelists, mobility grouping on.  Total =
pages: 16616111
[    0.026003] [      T0] mem auto-init: stack:off, heap alloc:off, heap f=
ree:off
[    0.033581] [      T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0,=
 CPUs=3D16, Nodes=3D1
[    0.033932] [      T0] Dynamic Preempt: lazy
[    0.033982] [      T0] rcu: Preemptible hierarchical RCU implementation=
.
[    0.033983] [      T0] rcu: 	RCU priority boosting: priority 1 delay 50=
0 ms.
[    0.033983] [      T0] rcu: 	RCU_SOFTIRQ processing moved to rcuc kthre=
ads.
[    0.033984] [      T0] 	No expedited grace period (rcu_normal_after_boo=
t).
[    0.033984] [      T0] 	Trampoline variant of Tasks RCU enabled.
[    0.033984] [      T0] 	Tracing variant of Tasks RCU enabled.
[    0.033985] [      T0] rcu: RCU calculated value of scheduler-enlistmen=
t delay is 100 jiffies.
[    0.033994] [      T0] RCU Tasks: Setting shift to 4 and lim to 1 rcu_t=
ask_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.033997] [      T0] RCU Tasks Trace: Setting shift to 4 and lim to 1=
 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.034003] [      T0] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs:=
 16
[    0.034189] [      T0] rcu: srcu_init: Setting srcu_struct sizes based =
on contention.
[    0.034261] [      T0] Console: colour dummy device 80x25
[    0.034264] [      T0] printk: legacy console [tty0] enabled
[    0.034270] [      T0] ACPI: Core revision 20240827
[    0.034421] [      T0] clocksource: hpet: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 133484873504 ns
[    0.034438] [      T0] APIC: Switch to symmetric I/O mode setup
[    0.034809] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, r=
devid:0xa0
[    0.034811] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, r=
devid:0xa0
[    0.034812] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, r=
devid:0xa0
[    0.034812] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, r=
devid:0xa0
[    0.034812] [      T0] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade=
, EFR2:0x0
[    0.035073] [      T0] x2apic enabled
[    0.035121] [      T0] APIC: Switched APIC routing to: cluster x2apic
[    0.035708] [      T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=
=3D-1 pin2=3D-1
[    0.040444] [      T0] clocksource: tsc-early: mask: 0xffffffffffffffff=
 max_cycles: 0x2e0b2ed30fb, max_idle_ns: 440795283680 ns
[    0.040450] [      T0] Calibrating delay loop (skipped), value calculat=
ed using timer frequency.. 6388.56 BogoMIPS (lpj=3D3194280)
[    0.040471] [      T0] x86/cpu: User Mode Instruction Prevention (UMIP)=
 activated
[    0.040503] [      T0] LVT offset 1 assigned for vector 0xf9
[    0.040618] [      T0] LVT offset 2 assigned for vector 0xf4
[    0.040644] [      T0] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 2=
56
[    0.040644] [      T0] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB=
 1024, 1GB 0
[    0.040647] [      T0] process: using mwait in idle threads
[    0.040649] [      T0] Spectre V1 : Mitigation: usercopy/swapgs barrier=
s and __user pointer sanitization
[    0.040650] [      T0] Spectre V2 : Mitigation: Retpolines
[    0.040651] [      T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation:=
 Filling RSB on context switch
[    0.040651] [      T0] Spectre V2 : Spectre v2 / SpectreRSB : Filling R=
SB on VMEXIT
[    0.040652] [      T0] Spectre V2 : Enabling Restricted Speculation for=
 firmware calls
[    0.040653] [      T0] Spectre V2 : mitigation: Enabling conditional In=
direct Branch Prediction Barrier
[    0.040654] [      T0] Spectre V2 : User space: Mitigation: STIBP alway=
s-on protection
[    0.040654] [      T0] Speculative Store Bypass: Mitigation: Speculativ=
e Store Bypass disabled via prctl
[    0.040655] [      T0] Speculative Return Stack Overflow: IBPB-extendin=
g microcode not applied!
[    0.040656] [      T0] Speculative Return Stack Overflow: WARNING: See =
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitig=
ation options.
[    0.040656] [      T0] Speculative Return Stack Overflow: Vulnerable: S=
afe RET, no microcode
[    0.040661] [      T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 fl=
oating point registers'
[    0.040663] [      T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE re=
gisters'
[    0.040663] [      T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX re=
gisters'
[    0.040663] [      T0] x86/fpu: Supporting XSAVE feature 0x200: 'Protec=
tion Keys User registers'
[    0.040664] [      T0] x86/fpu: Supporting XSAVE feature 0x800: 'Contro=
l-flow User registers'
[    0.040665] [      T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]=
:  256
[    0.040666] [      T0] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]=
:    8
[    0.040666] [      T0] x86/fpu: xstate_offset[11]:  840, xstate_sizes[1=
1]:   16
[    0.040667] [      T0] x86/fpu: Enabled xstate features 0xa07, context =
size is 856 bytes, using 'compacted' format.
[    0.055861] [      T0] Freeing SMP alternatives memory: 36K
[    0.055863] [      T0] pid_max: default: 32768 minimum: 301
[    0.058389] [      T0] LSM: initializing lsm=3Dcapability,apparmor
[    0.058493] [      T0] AppArmor: AppArmor initialized
[    0.058592] [      T0] Mount-cache hash table entries: 131072 (order: 8=
, 1048576 bytes, linear)
[    0.058664] [      T0] Mountpoint-cache hash table entries: 131072 (ord=
er: 8, 1048576 bytes, linear)
[    0.161399] [      T1] smpboot: CPU0: AMD Ryzen 7 5800H with Radeon Gra=
phics (family: 0x19, model: 0x50, stepping: 0x0)
[    0.161446] [      T1] Performance Events: Fam17h+ core perfctr, AMD PM=
U driver.
[    0.161446] [      T1] ... version:                0
[    0.161446] [      T1] ... bit width:              48
[    0.161446] [      T1] ... generic registers:      6
[    0.161446] [      T1] ... value mask:             0000ffffffffffff
[    0.161446] [      T1] ... max period:             00007fffffffffff
[    0.161446] [      T1] ... fixed-purpose events:   0
[    0.161446] [      T1] ... event mask:             000000000000003f
[    0.161446] [      T1] signal: max sigframe size: 3376
[    0.161446] [      T1] rcu: Hierarchical SRCU implementation.
[    0.161446] [      T1] rcu: 	Max phase no-delay instances is 400.
[    0.161446] [      T1] Timer migration: 2 hierarchy levels; 8 children =
per group; 2 crossnode level
[    0.162247] [     T11] NMI watchdog: Enabled. Permanently consumes one =
hw-PMU counter.
[    0.162408] [      T1] smp: Bringing up secondary CPUs ...
[    0.162576] [      T1] smpboot: x86: Booting SMP configuration:
[    0.162578] [      T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #=
12 #14  #1  #3  #5  #7  #9 #11 #13 #15
[    0.174529] [      T1] Spectre V2 : Update user space SMT mitigation: S=
TIBP always-on
[    0.182474] [      T1] smp: Brought up 1 node, 16 CPUs
[    0.182474] [      T1] smpboot: Total of 16 processors activated (10221=
6.96 BogoMIPS)
[    0.241458] [    T145] node 0 deferred pages initialised in 58ms
[    0.241470] [      T1] Memory: 65172372K/66464444K available (12264K ke=
rnel code, 1211K rwdata, 4344K rodata, 2024K init, 1348K bss, 1278548K res=
erved, 0K cma-reserved)
[    0.242490] [      T1] devtmpfs: initialized
[    0.242525] [      T1] x86/mm: Memory block size: 128MB
[    0.254170] [      T1] ACPI: PM: Registering ACPI NVS region [mem 0x0a2=
00000-0x0a20efff] (61440 bytes)
[    0.254170] [      T1] ACPI: PM: Registering ACPI NVS region [mem 0xeb3=
9f000-0xeb556fff] (1802240 bytes)
[    0.254170] [      T1] clocksource: jiffies: mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.254170] [      T1] posixtimers hash table entries: 8192 (order: 6, =
327680 bytes, linear)
[    0.254479] [      T1] futex hash table entries: 4096 (order: 6, 262144=
 bytes, linear)
[    0.254577] [      T1] pinctrl core: initialized pinctrl subsystem
[    0.254979] [      T1] NET: Registered PF_NETLINK/PF_ROUTE protocol fam=
ily
[    0.255197] [      T1] audit: initializing netlink subsys (disabled)
[    0.255207] [    T165] audit: type=3D2000 audit(1742855122.219:1): stat=
e=3Dinitialized audit_enabled=3D0 res=3D1
[    0.255207] [      T1] thermal_sys: Registered thermal governor 'fair_s=
hare'
[    0.255207] [      T1] thermal_sys: Registered thermal governor 'bang_b=
ang'
[    0.255207] [      T1] thermal_sys: Registered thermal governor 'step_w=
ise'
[    0.255207] [      T1] thermal_sys: Registered thermal governor 'user_s=
pace'
[    0.255207] [      T1] thermal_sys: Registered thermal governor 'power_=
allocator'
[    0.255207] [      T1] cpuidle: using governor ladder
[    0.255207] [      T1] cpuidle: using governor teo
[    0.255614] [      T1] acpiphp: ACPI Hot Plug PCI Controller Driver ver=
sion: 0.5
[    0.255705] [      T1] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0=
000000) for domain 0000 [bus 00-7f]
[    0.255718] [      T1] PCI: Using configuration type 1 for base access
[    0.255799] [      T1] HugeTLB: allocation took 0ms with hugepage_alloc=
ation_threads=3D4
[    0.255799] [      T1] HugeTLB: registered 1.00 GiB page size, pre-allo=
cated 0 pages
[    0.255799] [      T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.=
00 GiB page
[    0.255799] [      T1] HugeTLB: registered 2.00 MiB page size, pre-allo=
cated 0 pages
[    0.255799] [      T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 =
MiB page
[    0.256511] [      T1] ACPI: Added _OSI(Module Device)
[    0.256512] [      T1] ACPI: Added _OSI(Processor Device)
[    0.256513] [      T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.256514] [      T1] ACPI: Added _OSI(Processor Aggregator Device)
[    0.279055] [      T1] ACPI: 16 ACPI AML tables successfully acquired a=
nd loaded
[    0.280635] [      T1] ACPI: EC: EC started
[    0.280636] [      T1] ACPI: EC: interrupt blocked
[    0.281243] [      T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.281244] [      T1] ACPI: EC: Boot ECDT EC used to handle transactio=
ns
[    0.282247] [      T1] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ign=
ored
[    0.285745] [      T1] ACPI: Interpreter enabled
[    0.285763] [      T1] ACPI: PM: (supports S0 S4 S5)
[    0.285764] [      T1] ACPI: Using IOAPIC for interrupt routing
[    0.286019] [      T1] PCI: Using host bridge windows from ACPI; if nec=
essary, use "pci=3Dnocrs" and report a bug
[    0.286020] [      T1] PCI: Using E820 reservations for host bridge win=
dows
[    0.286678] [      T1] ACPI: Enabled 1 GPEs in block 00 to 1F
[    0.287667] [      T1] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.287930] [      T1] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resou=
rce
[    0.288067] [      T1] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power =
resource
[    0.289796] [      T1] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resou=
rce
[    0.289841] [      T1] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resou=
rce
[    0.290740] [      T1] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resou=
rce
[    0.290784] [      T1] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resou=
rce
[    0.293590] [      T1] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
[    0.293893] [      T1] ACPI: \_SB_.PCI0.GPP5.P0NX: New power resource
[    0.303675] [      T1] ACPI: \_SB_.PRWB: New power resource
[    0.306517] [      T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 0=
0-ff])
[    0.306523] [      T1] acpi PNP0A08:00: _OSC: OS supports [ExtendedConf=
ig ASPM ClockPM Segments MSI HPX-Type3]
[    0.306633] [      T1] acpi PNP0A08:00: _OSC: platform does not support=
 [LTR]
[    0.306834] [      T1] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotp=
lug PME AER PCIeCapability]
[    0.306837] [      T1] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0=
000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially covers this =
bridge
[    0.307474] [      T1] PCI host bridge to bus 0000:00
[    0.307478] [      T1] pci_bus 0000:00: root bus resource [io  0x0000-0=
x03af window]
[    0.307481] [      T1] pci_bus 0000:00: root bus resource [io  0x03e0-0=
x0cf7 window]
[    0.307482] [      T1] pci_bus 0000:00: root bus resource [io  0x03b0-0=
x03df window]
[    0.307484] [      T1] pci_bus 0000:00: root bus resource [io  0x0d00-0=
xffff window]
[    0.307485] [      T1] pci_bus 0000:00: root bus resource [mem 0x000a00=
00-0x000dffff window]
[    0.307487] [      T1] pci_bus 0000:00: root bus resource [mem 0xf00000=
00-0xfcffffff window]
[    0.307488] [      T1] pci_bus 0000:00: root bus resource [mem 0x101000=
0000-0xffffffffff window]
[    0.307490] [      T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.307508] [      T1] pci 0000:00:00.0: [1022:1630] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.307650] [      T1] pci 0000:00:00.2: [1022:1631] type 00 class 0x08=
0600 conventional PCI endpoint
[    0.307791] [      T1] pci 0000:00:01.0: [1022:1632] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.307910] [      T1] pci 0000:00:01.1: [1022:1633] type 01 class 0x06=
0400 PCIe Root Port
[    0.307923] [      T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.307928] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfca0000=
0-0xfccfffff]
[    0.307934] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.307976] [      T1] pci 0000:00:01.1: PME# supported from D0 D3hot D=
3cold
[    0.308138] [      T1] pci 0000:00:02.0: [1022:1632] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.308259] [      T1] pci 0000:00:02.1: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.308272] [      T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.308281] [      T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300=
000-0xfe304fffff 64bit pref]
[    0.308322] [      T1] pci 0000:00:02.1: PME# supported from D0 D3hot D=
3cold
[    0.308465] [      T1] pci 0000:00:02.2: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.308478] [      T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.308482] [      T1] pci 0000:00:02.2:   bridge window [io  0xf000-0x=
ffff]
[    0.308484] [      T1] pci 0000:00:02.2:   bridge window [mem 0xfcf0000=
0-0xfcffffff]
[    0.308495] [      T1] pci 0000:00:02.2: enabling Extended Tags
[    0.308530] [      T1] pci 0000:00:02.2: PME# supported from D0 D3hot D=
3cold
[    0.308663] [      T1] pci 0000:00:02.3: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.308676] [      T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.308680] [      T1] pci 0000:00:02.3:   bridge window [mem 0xfce0000=
0-0xfcefffff]
[    0.308724] [      T1] pci 0000:00:02.3: PME# supported from D0 D3hot D=
3cold
[    0.308854] [      T1] pci 0000:00:02.4: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.308867] [      T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.308871] [      T1] pci 0000:00:02.4:   bridge window [mem 0xfcd0000=
0-0xfcdfffff]
[    0.308882] [      T1] pci 0000:00:02.4: enabling Extended Tags
[    0.308916] [      T1] pci 0000:00:02.4: PME# supported from D0 D3hot D=
3cold
[    0.309053] [      T1] pci 0000:00:08.0: [1022:1632] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.309172] [      T1] pci 0000:00:08.1: [1022:1635] type 01 class 0x06=
0400 PCIe Root Port
[    0.309185] [      T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.309188] [      T1] pci 0000:00:08.1:   bridge window [io  0xe000-0x=
efff]
[    0.309190] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfc50000=
0-0xfc9fffff]
[    0.309195] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000=
000-0xfe301fffff 64bit pref]
[    0.309201] [      T1] pci 0000:00:08.1: enabling Extended Tags
[    0.309235] [      T1] pci 0000:00:08.1: PME# supported from D0 D3hot D=
3cold
[    0.309443] [      T1] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c=
0500 conventional PCI endpoint
[    0.309613] [      T1] pci 0000:00:14.3: [1022:790e] type 00 class 0x06=
0100 conventional PCI endpoint
[    0.309783] [      T1] pci 0000:00:18.0: [1022:166a] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.309878] [      T1] pci 0000:00:18.1: [1022:166b] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.309981] [      T1] pci 0000:00:18.2: [1022:166c] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.310076] [      T1] pci 0000:00:18.3: [1022:166d] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.310172] [      T1] pci 0000:00:18.4: [1022:166e] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.310271] [      T1] pci 0000:00:18.5: [1022:166f] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.310368] [      T1] pci 0000:00:18.6: [1022:1670] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.310475] [      T1] pci 0000:00:18.7: [1022:1671] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.310650] [      T1] pci 0000:01:00.0: [1002:1478] type 01 class 0x06=
0400 PCIe Switch Upstream Port
[    0.310671] [      T1] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03f=
ff]
[    0.310675] [      T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.310683] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.310691] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.310773] [      T1] pci 0000:01:00.0: PME# supported from D0 D3hot D=
3cold
[    0.310841] [      T1] pci 0000:01:00.0: 63.008 Gb/s available PCIe ban=
dwidth, limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.0=
24 Gb/s with 16.0 GT/s PCIe x8 link)
[    0.310984] [      T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.311064] [      T1] pci 0000:02:00.0: [1002:1479] type 01 class 0x06=
0400 PCIe Switch Downstream Port
[    0.311087] [      T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.311094] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.311103] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.311186] [      T1] pci 0000:02:00.0: PME# supported from D0 D3hot D=
3cold
[    0.311725] [      T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.311818] [      T1] pci 0000:03:00.0: [1002:73ff] type 00 class 0x03=
8000 PCIe Legacy Endpoint
[    0.311852] [      T1] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdff=
ffffff 64bit pref]
[    0.311855] [      T1] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0f=
ffffff 64bit pref]
[    0.311858] [      T1] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafff=
ff]
[    0.311860] [      T1] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff=
 pref]
[    0.311951] [      T1] pci 0000:03:00.0: PME# supported from D1 D2 D3ho=
t D3cold
[    0.312022] [      T1] pci 0000:03:00.0: 63.008 Gb/s available PCIe ban=
dwidth, limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.0=
48 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.312165] [      T1] pci 0000:03:00.1: [1002:ab28] type 00 class 0x04=
0300 PCIe Legacy Endpoint
[    0.312198] [      T1] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23f=
ff]
[    0.312263] [      T1] pci 0000:03:00.1: PME# supported from D1 D2 D3ho=
t D3cold
[    0.312441] [      T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.312546] [      T1] pci 0000:04:00.0: [14c3:0608] type 00 class 0x02=
8000 PCIe Endpoint
[    0.312590] [      T1] pci 0000:04:00.0: BAR 0 [mem 0xfe30300000-0xfe30=
3fffff 64bit pref]
[    0.312593] [      T1] pci 0000:04:00.0: BAR 2 [mem 0xfe30400000-0xfe30=
403fff 64bit pref]
[    0.312597] [      T1] pci 0000:04:00.0: BAR 4 [mem 0xfe30404000-0xfe30=
404fff 64bit pref]
[    0.312669] [      T1] pci 0000:04:00.0: supports D1 D2
[    0.312670] [      T1] pci 0000:04:00.0: PME# supported from D0 D1 D2 D=
3hot D3cold
[    0.312875] [      T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.312956] [      T1] pci 0000:05:00.0: [10ec:8168] type 00 class 0x02=
0000 PCIe Endpoint
[    0.313001] [      T1] pci 0000:05:00.0: BAR 0 [io  0xf000-0xf0ff]
[    0.313006] [      T1] pci 0000:05:00.0: BAR 2 [mem 0xfcf04000-0xfcf04f=
ff 64bit]
[    0.313009] [      T1] pci 0000:05:00.0: BAR 4 [mem 0xfcf00000-0xfcf03f=
ff 64bit]
[    0.313096] [      T1] pci 0000:05:00.0: supports D1 D2
[    0.313097] [      T1] pci 0000:05:00.0: PME# supported from D0 D1 D2 D=
3hot D3cold
[    0.313310] [      T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.313491] [      T1] pci 0000:06:00.0: [2646:5013] type 00 class 0x01=
0802 PCIe Endpoint
[    0.313594] [      T1] pci 0000:06:00.0: BAR 0 [mem 0xfce00000-0xfce03f=
ff 64bit]
[    0.314096] [      T1] pci 0000:06:00.0: 31.504 Gb/s available PCIe ban=
dwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:02.3 (capable of 63.01=
2 Gb/s with 16.0 GT/s PCIe x4 link)
[    0.314527] [      T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.314884] [      T1] pci 0000:07:00.0: [c0a9:2263] type 00 class 0x01=
0802 PCIe Endpoint
[    0.314928] [      T1] pci 0000:07:00.0: BAR 0 [mem 0xfcd00000-0xfcd03f=
ff 64bit]
[    0.315554] [      T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.315656] [      T1] pci 0000:08:00.0: [1002:1638] type 00 class 0x03=
0000 PCIe Legacy Endpoint
[    0.315679] [      T1] pci 0000:08:00.0: BAR 0 [mem 0xfe20000000-0xfe2f=
ffffff 64bit pref]
[    0.315681] [      T1] pci 0000:08:00.0: BAR 2 [mem 0xfe30000000-0xfe30=
1fffff 64bit pref]
[    0.315683] [      T1] pci 0000:08:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.315685] [      T1] pci 0000:08:00.0: BAR 5 [mem 0xfc900000-0xfc97ff=
ff]
[    0.315690] [      T1] pci 0000:08:00.0: enabling Extended Tags
[    0.315743] [      T1] pci 0000:08:00.0: PME# supported from D1 D2 D3ho=
t D3cold
[    0.315890] [      T1] pci 0000:08:00.1: [1002:1637] type 00 class 0x04=
0300 PCIe Legacy Endpoint
[    0.315911] [      T1] pci 0000:08:00.1: BAR 0 [mem 0xfc9c8000-0xfc9cbf=
ff]
[    0.315918] [      T1] pci 0000:08:00.1: enabling Extended Tags
[    0.315950] [      T1] pci 0000:08:00.1: PME# supported from D1 D2 D3ho=
t D3cold
[    0.316069] [      T1] pci 0000:08:00.2: [1022:15df] type 00 class 0x10=
8000 PCIe Endpoint
[    0.316091] [      T1] pci 0000:08:00.2: BAR 2 [mem 0xfc800000-0xfc8fff=
ff]
[    0.316094] [      T1] pci 0000:08:00.2: BAR 5 [mem 0xfc9ce000-0xfc9cff=
ff]
[    0.316099] [      T1] pci 0000:08:00.2: enabling Extended Tags
[    0.316243] [      T1] pci 0000:08:00.3: [1022:1639] type 00 class 0x0c=
0330 PCIe Endpoint
[    0.316265] [      T1] pci 0000:08:00.3: BAR 0 [mem 0xfc700000-0xfc7fff=
ff 64bit]
[    0.316272] [      T1] pci 0000:08:00.3: enabling Extended Tags
[    0.316306] [      T1] pci 0000:08:00.3: PME# supported from D0 D3hot D=
3cold
[    0.316442] [      T1] pci 0000:08:00.4: [1022:1639] type 00 class 0x0c=
0330 PCIe Endpoint
[    0.316471] [      T1] pci 0000:08:00.4: BAR 0 [mem 0xfc600000-0xfc6fff=
ff 64bit]
[    0.316478] [      T1] pci 0000:08:00.4: enabling Extended Tags
[    0.316512] [      T1] pci 0000:08:00.4: PME# supported from D0 D3hot D=
3cold
[    0.316640] [      T1] pci 0000:08:00.5: [1022:15e2] type 00 class 0x04=
8000 PCIe Endpoint
[    0.316660] [      T1] pci 0000:08:00.5: BAR 0 [mem 0xfc980000-0xfc9bff=
ff]
[    0.316668] [      T1] pci 0000:08:00.5: enabling Extended Tags
[    0.316700] [      T1] pci 0000:08:00.5: PME# supported from D0 D3hot D=
3cold
[    0.316824] [      T1] pci 0000:08:00.6: [1022:15e3] type 00 class 0x04=
0300 PCIe Endpoint
[    0.316844] [      T1] pci 0000:08:00.6: BAR 0 [mem 0xfc9c0000-0xfc9c7f=
ff]
[    0.316852] [      T1] pci 0000:08:00.6: enabling Extended Tags
[    0.316887] [      T1] pci 0000:08:00.6: PME# supported from D0 D3hot D=
3cold
[    0.317008] [      T1] pci 0000:08:00.7: [1022:15e4] type 00 class 0x11=
8000 PCIe Endpoint
[    0.317030] [      T1] pci 0000:08:00.7: BAR 2 [mem 0xfc500000-0xfc5fff=
ff]
[    0.317033] [      T1] pci 0000:08:00.7: BAR 5 [mem 0xfc9cc000-0xfc9cdf=
ff]
[    0.317038] [      T1] pci 0000:08:00.7: enabling Extended Tags
[    0.317214] [      T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.317236] [      T1] pci_bus 0000:00: on NUMA node 0
[    0.319456] [      T1] ACPI: PCI: Interrupt link LNKA configured for IR=
Q 0
[    0.319518] [      T1] ACPI: PCI: Interrupt link LNKB configured for IR=
Q 0
[    0.319572] [      T1] ACPI: PCI: Interrupt link LNKC configured for IR=
Q 0
[    0.319636] [      T1] ACPI: PCI: Interrupt link LNKD configured for IR=
Q 0
[    0.319695] [      T1] ACPI: PCI: Interrupt link LNKE configured for IR=
Q 0
[    0.319745] [      T1] ACPI: PCI: Interrupt link LNKF configured for IR=
Q 0
[    0.319795] [      T1] ACPI: PCI: Interrupt link LNKG configured for IR=
Q 0
[    0.319846] [      T1] ACPI: PCI: Interrupt link LNKH configured for IR=
Q 0
[    0.321520] [      T1] Low-power S0 idle used by default for system sus=
pend
[    0.322353] [      T1] ACPI: EC: interrupt unblocked
[    0.322355] [      T1] ACPI: EC: event unblocked
[    0.322357] [      T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.322358] [      T1] ACPI: EC: GPE=3D0x3
[    0.322359] [      T1] ACPI: \_SB_.PCI0.SBRG.EC__: Boot ECDT EC initial=
ization complete
[    0.322361] [      T1] ACPI: \_SB_.PCI0.SBRG.EC__: EC: Used to handle t=
ransactions and events
[    0.322427] [      T1] iommu: Default domain type: Passthrough
[    0.322539] [      T1] EDAC MC: Ver: 3.0.0
[    0.323005] [      T1] efivars: Registered efivars operations
[    0.323608] [      T1] PCI: Using ACPI for IRQ routing
[    0.327881] [      T1] PCI: pci_cache_line_size set to 64 bytes
[    0.328498] [      T1] e820: reserve RAM buffer [mem 0x09bff000-0x0bfff=
fff]
[    0.328500] [      T1] e820: reserve RAM buffer [mem 0x0a200000-0x0bfff=
fff]
[    0.328501] [      T1] e820: reserve RAM buffer [mem 0xe62ee000-0xe7fff=
fff]
[    0.328502] [      T1] e820: reserve RAM buffer [mem 0xe87cb000-0xebfff=
fff]
[    0.328503] [      T1] e820: reserve RAM buffer [mem 0xe9e20000-0xebfff=
fff]
[    0.328504] [      T1] e820: reserve RAM buffer [mem 0xee000000-0xeffff=
fff]
[    0.328505] [      T1] e820: reserve RAM buffer [mem 0xfee300000-0xfeff=
fffff]
[    0.328629] [      T1] pci 0000:08:00.0: vgaarb: setting as boot VGA de=
vice
[    0.328629] [      T1] pci 0000:08:00.0: vgaarb: bridge control possibl=
e
[    0.328629] [      T1] pci 0000:08:00.0: vgaarb: VGA device added: deco=
des=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.328629] [      T1] vgaarb: loaded
[    0.329065] [      T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.329069] [      T1] hpet0: 3 comparators, 32-bit 14.318180 MHz count=
er
[    0.330492] [      T1] clocksource: Switched to clocksource hpet
[    0.330792] [      T1] AppArmor: AppArmor Filesystem Enabled
[    0.330810] [      T1] pnp: PnP ACPI init
[    0.330914] [      T1] system 00:00: [mem 0xf0000000-0xf7ffffff] has be=
en reserved
[    0.331593] [      T1] system 00:04: [io  0x04d0-0x04d1] has been reser=
ved
[    0.331595] [      T1] system 00:04: [io  0x040b] has been reserved
[    0.331597] [      T1] system 00:04: [io  0x04d6] has been reserved
[    0.331599] [      T1] system 00:04: [io  0x0c00-0x0c01] has been reser=
ved
[    0.331600] [      T1] system 00:04: [io  0x0c14] has been reserved
[    0.331602] [      T1] system 00:04: [io  0x0c50-0x0c51] has been reser=
ved
[    0.331603] [      T1] system 00:04: [io  0x0c52] has been reserved
[    0.331604] [      T1] system 00:04: [io  0x0c6c] has been reserved
[    0.331606] [      T1] system 00:04: [io  0x0c6f] has been reserved
[    0.331607] [      T1] system 00:04: [io  0x0cd8-0x0cdf] has been reser=
ved
[    0.331609] [      T1] system 00:04: [io  0x0800-0x089f] has been reser=
ved
[    0.331610] [      T1] system 00:04: [io  0x0b00-0x0b0f] has been reser=
ved
[    0.331612] [      T1] system 00:04: [io  0x0b20-0x0b3f] has been reser=
ved
[    0.331613] [      T1] system 00:04: [io  0x0900-0x090f] has been reser=
ved
[    0.331615] [      T1] system 00:04: [io  0x0910-0x091f] has been reser=
ved
[    0.331616] [      T1] system 00:04: [mem 0xfec00000-0xfec00fff] could =
not be reserved
[    0.331618] [      T1] system 00:04: [mem 0xfec01000-0xfec01fff] could =
not be reserved
[    0.331620] [      T1] system 00:04: [mem 0xfedc0000-0xfedc0fff] has be=
en reserved
[    0.331622] [      T1] system 00:04: [mem 0xfee00000-0xfee00fff] has be=
en reserved
[    0.331623] [      T1] system 00:04: [mem 0xfed80000-0xfed8ffff] could =
not be reserved
[    0.331625] [      T1] system 00:04: [mem 0xfec10000-0xfec10fff] has be=
en reserved
[    0.331626] [      T1] system 00:04: [mem 0xff000000-0xffffffff] has be=
en reserved
[    0.332627] [      T1] pnp: PnP ACPI: found 5 devices
[    0.339915] [      T1] clocksource: acpi_pm: mask: 0xffffff max_cycles:=
 0xffffff, max_idle_ns: 2085701024 ns
[    0.340026] [      T1] NET: Registered PF_INET protocol family
[    0.340216] [      T1] IP idents hash table entries: 262144 (order: 9, =
2097152 bytes, linear)
[    0.343420] [      T1] tcp_listen_portaddr_hash hash table entries: 327=
68 (order: 8, 1310720 bytes, linear)
[    0.343731] [      T1] Table-perturb hash table entries: 65536 (order: =
6, 262144 bytes, linear)
[    0.343743] [      T1] TCP established hash table entries: 524288 (orde=
r: 10, 4194304 bytes, linear)
[    0.344346] [      T1] TCP bind hash table entries: 65536 (order: 10, 5=
242880 bytes, vmalloc hugepage)
[    0.345179] [      T1] TCP: Hash tables configured (established 524288 =
bind 65536)
[    0.345892] [      T1] MPTCP token hash table entries: 65536 (order: 9,=
 3670016 bytes, linear)
[    0.346354] [      T1] UDP hash table entries: 32768 (order: 10, 524288=
0 bytes, vmalloc hugepage)
[    0.347279] [      T1] UDP-Lite hash table entries: 32768 (order: 10, 5=
242880 bytes, vmalloc hugepage)
[    0.348215] [      T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.348226] [      T1] NET: Registered PF_XDP protocol family
[    0.348269] [      T1] pci 0000:00:01.1: bridge window [io  0x1000-0x0f=
ff] to [bus 01-03] add_size 1000
[    0.348286] [      T1] pci 0000:00:01.1: bridge window [io  0x1000-0x1f=
ff]: assigned
[    0.348290] [      T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.348301] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.348304] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.348310] [      T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.348314] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.348318] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.348323] [      T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.348326] [      T1] pci 0000:00:01.1:   bridge window [io  0x1000-0x=
1fff]
[    0.348329] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfca0000=
0-0xfccfffff]
[    0.348331] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.348336] [      T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.348340] [      T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300=
000-0xfe304fffff 64bit pref]
[    0.348345] [      T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.348347] [      T1] pci 0000:00:02.2:   bridge window [io  0xf000-0x=
ffff]
[    0.348350] [      T1] pci 0000:00:02.2:   bridge window [mem 0xfcf0000=
0-0xfcffffff]
[    0.348356] [      T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.348359] [      T1] pci 0000:00:02.3:   bridge window [mem 0xfce0000=
0-0xfcefffff]
[    0.348364] [      T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.348367] [      T1] pci 0000:00:02.4:   bridge window [mem 0xfcd0000=
0-0xfcdfffff]
[    0.348377] [      T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.348379] [      T1] pci 0000:00:08.1:   bridge window [io  0xe000-0x=
efff]
[    0.348382] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfc50000=
0-0xfc9fffff]
[    0.348384] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000=
000-0xfe301fffff 64bit pref]
[    0.348390] [      T1] pci_bus 0000:00: resource 4 [io  0x0000-0x03af w=
indow]
[    0.348391] [      T1] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 w=
indow]
[    0.348393] [      T1] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df w=
indow]
[    0.348394] [      T1] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff w=
indow]
[    0.348395] [      T1] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x00=
0dffff window]
[    0.348396] [      T1] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfc=
ffffff window]
[    0.348397] [      T1] pci_bus 0000:00: resource 10 [mem 0x1010000000-0=
xffffffffff window]
[    0.348399] [      T1] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.348401] [      T1] pci_bus 0000:01: resource 1 [mem 0xfca00000-0xfc=
cfffff]
[    0.348402] [      T1] pci_bus 0000:01: resource 2 [mem 0xfc00000000-0x=
fe0fffffff 64bit pref]
[    0.348403] [      T1] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfc=
bfffff]
[    0.348404] [      T1] pci_bus 0000:02: resource 2 [mem 0xfc00000000-0x=
fe0fffffff 64bit pref]
[    0.348406] [      T1] pci_bus 0000:03: resource 1 [mem 0xfca00000-0xfc=
bfffff]
[    0.348407] [      T1] pci_bus 0000:03: resource 2 [mem 0xfc00000000-0x=
fe0fffffff 64bit pref]
[    0.348409] [      T1] pci_bus 0000:04: resource 2 [mem 0xfe30300000-0x=
fe304fffff 64bit pref]
[    0.348410] [      T1] pci_bus 0000:05: resource 0 [io  0xf000-0xffff]
[    0.348411] [      T1] pci_bus 0000:05: resource 1 [mem 0xfcf00000-0xfc=
ffffff]
[    0.348413] [      T1] pci_bus 0000:06: resource 1 [mem 0xfce00000-0xfc=
efffff]
[    0.348415] [      T1] pci_bus 0000:07: resource 1 [mem 0xfcd00000-0xfc=
dfffff]
[    0.348416] [      T1] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
[    0.348417] [      T1] pci_bus 0000:08: resource 1 [mem 0xfc500000-0xfc=
9fffff]
[    0.348418] [      T1] pci_bus 0000:08: resource 2 [mem 0xfe20000000-0x=
fe301fffff 64bit pref]
[    0.348628] [      T1] pci 0000:03:00.1: D0 power state depends on 0000=
:03:00.0
[    0.349040] [      T1] pci 0000:08:00.1: D0 power state depends on 0000=
:08:00.0
[    0.349048] [      T1] pci 0000:08:00.3: extending delay after power-on=
 from D3hot to 20 msec
[    0.349429] [      T1] pci 0000:08:00.4: extending delay after power-on=
 from D3hot to 20 msec
[    0.349533] [      T1] PCI: CLS 64 bytes, default 64
[    0.349554] [      T1] pci 0000:00:00.2: AMD-Vi: IOMMU performance coun=
ters supported
[    0.349632] [    T159] Trying to unpack rootfs image as initramfs...
[    0.349672] [      T1] pci 0000:00:00.0: Adding to iommu group 0
[    0.349703] [      T1] pci 0000:00:01.0: Adding to iommu group 1
[    0.349723] [      T1] pci 0000:00:01.1: Adding to iommu group 2
[    0.349755] [      T1] pci 0000:00:02.0: Adding to iommu group 3
[    0.349780] [      T1] pci 0000:00:02.1: Adding to iommu group 4
[    0.349801] [      T1] pci 0000:00:02.2: Adding to iommu group 5
[    0.349822] [      T1] pci 0000:00:02.3: Adding to iommu group 6
[    0.349844] [      T1] pci 0000:00:02.4: Adding to iommu group 7
[    0.349875] [      T1] pci 0000:00:08.0: Adding to iommu group 8
[    0.349897] [      T1] pci 0000:00:08.1: Adding to iommu group 9
[    0.349933] [      T1] pci 0000:00:14.0: Adding to iommu group 10
[    0.349952] [      T1] pci 0000:00:14.3: Adding to iommu group 10
[    0.350039] [      T1] pci 0000:00:18.0: Adding to iommu group 11
[    0.350060] [      T1] pci 0000:00:18.1: Adding to iommu group 11
[    0.350079] [      T1] pci 0000:00:18.2: Adding to iommu group 11
[    0.350098] [      T1] pci 0000:00:18.3: Adding to iommu group 11
[    0.350118] [      T1] pci 0000:00:18.4: Adding to iommu group 11
[    0.350138] [      T1] pci 0000:00:18.5: Adding to iommu group 11
[    0.350157] [      T1] pci 0000:00:18.6: Adding to iommu group 11
[    0.350176] [      T1] pci 0000:00:18.7: Adding to iommu group 11
[    0.350198] [      T1] pci 0000:01:00.0: Adding to iommu group 12
[    0.350219] [      T1] pci 0000:02:00.0: Adding to iommu group 13
[    0.350270] [      T1] pci 0000:03:00.0: Adding to iommu group 14
[    0.350294] [      T1] pci 0000:03:00.1: Adding to iommu group 15
[    0.350316] [      T1] pci 0000:04:00.0: Adding to iommu group 16
[    0.350338] [      T1] pci 0000:05:00.0: Adding to iommu group 17
[    0.350359] [      T1] pci 0000:06:00.0: Adding to iommu group 18
[    0.350381] [      T1] pci 0000:07:00.0: Adding to iommu group 19
[    0.350410] [      T1] pci 0000:08:00.0: Adding to iommu group 20
[    0.350431] [      T1] pci 0000:08:00.1: Adding to iommu group 21
[    0.350453] [      T1] pci 0000:08:00.2: Adding to iommu group 22
[    0.350476] [      T1] pci 0000:08:00.3: Adding to iommu group 23
[    0.350497] [      T1] pci 0000:08:00.4: Adding to iommu group 24
[    0.350521] [      T1] pci 0000:08:00.5: Adding to iommu group 25
[    0.350548] [      T1] pci 0000:08:00.6: Adding to iommu group 26
[    0.350571] [      T1] pci 0000:08:00.7: Adding to iommu group 27
[    0.350988] [      T1] AMD-Vi: Extended features (0x206d73ef22254ade, 0=
x0): PPR X2APIC NX GT IA GA PC GA_vAPIC
[    0.350993] [      T1] AMD-Vi: Interrupt remapping enabled
[    0.350994] [      T1] AMD-Vi: X2APIC enabled
[    0.351374] [      T1] AMD-Vi: Virtual APIC enabled
[    0.351381] [      T1] PCI-DMA: Using software bounce buffering for IO =
(SWIOTLB)
[    0.351382] [      T1] software IO TLB: mapped [mem 0x00000000e1e58000-=
0x00000000e5e58000] (64MB)
[    0.351426] [      T1] RAPL PMU: API unit is 2^-32 Joules, 2 fixed coun=
ters, 163840 ms ovfl timer
[    0.351427] [      T1] RAPL PMU: hw unit of domain package 2^-16 Joules
[    0.351428] [      T1] RAPL PMU: hw unit of domain core 2^-16 Joules
[    0.351431] [      T1] LVT offset 0 assigned for vector 0x400
[    0.352309] [      T1] perf: AMD IBS detected (0x000003ff)
[    0.353296] [     T24] amd_uncore: 4 amd_df counters detected
[    0.353302] [     T24] amd_uncore: 6 amd_l3 counters detected
[    0.354280] [      T1] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, =
4 counters/bank).
[    0.355182] [      T1] Initialise system trusted keyrings
[    0.355254] [      T1] workingset: timestamp_bits=3D46 max_order=3D24 b=
ucket_order=3D0
[    0.501578] [    T159] Freeing initrd memory: 42152K
[    0.520880] [      T1] Key type asymmetric registered
[    0.520882] [      T1] Asymmetric key parser 'x509' registered
[    0.520905] [      T1] Block layer SCSI generic (bsg) driver version 0.=
4 loaded (major 251)
[    0.520985] [      T1] io scheduler bfq registered
[    0.523182] [      T1] pcieport 0000:00:01.1: PME: Signaling with IRQ 4=
3
[    0.523214] [      T1] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- =
PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPr=
esDis- LLActRep+
[    0.523594] [      T1] pcieport 0000:00:02.1: PME: Signaling with IRQ 4=
4
[    0.523824] [      T1] pcieport 0000:00:02.2: PME: Signaling with IRQ 4=
5
[    0.524061] [      T1] pcieport 0000:00:02.3: PME: Signaling with IRQ 4=
6
[    0.524330] [      T1] pcieport 0000:00:02.4: PME: Signaling with IRQ 4=
7
[    0.524571] [      T1] pcieport 0000:00:08.1: PME: Signaling with IRQ 4=
8
[    0.525202] [      T1] ACPI: video: Video Device [VGA] (multi-head: yes=
  rom: no  post: no)
[    0.525523] [      T1] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBU=
S:00/PNP0A08:00/device:13/LNXVIDEO:00/input/input0
[    0.525992] [     T24] Monitor-Mwait will be used to enter C-1 state
[    0.529010] [      T1] Estimated ratio of average max frequency by base=
 frequency (times 1024): 1226
[    0.529928] [      T1] thermal LNXTHERM:00: registered as thermal_zone0
[    0.529930] [      T1] ACPI: thermal: Thermal Zone [THRM] (72 C)
[    0.530047] [      T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing =
disabled
[    0.530917] [      T1] ACPI: bus type drm_connector registered
[    0.532880] [      T1] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f1=
3:PS2M] at 0x60,0x64 irq 1,12
[    0.536200] [      T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.536208] [      T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.536743] [      T1] mousedev: PS/2 mouse device common for all mice
[    0.536786] [      T1] rtc_cmos 00:01: RTC can wake from S4
[    0.537276] [      T1] rtc_cmos 00:01: registered as rtc0
[    0.537322] [      T1] rtc_cmos 00:01: setting system clock to 2025-03-=
24T22:25:23 UTC (1742855123)
[    0.537357] [      T1] rtc_cmos 00:01: alarms up to one month, y3k, 114=
 bytes nvram
[    0.539377] [      T1] efifb: probing for efifb
[    0.539416] [      T1] efifb: framebuffer at 0xfe20000000, using 8100k,=
 total 8100k
[    0.539417] [      T1] efifb: mode is 1920x1080x32, linelength=3D7680, =
pages=3D1
[    0.539418] [      T1] efifb: scrolling: redraw
[    0.539419] [      T1] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:=
8:0
[    0.539538] [      T1] Console: switching to colour frame buffer device=
 240x67
[    0.552765] [    T175] input: AT Translated Set 2 keyboard as /devices/=
platform/i8042/serio0/input/input2
[    0.563495] [      T1] fb0: EFI VGA frame buffer device
[    0.563628] [      T1] NET: Registered PF_INET6 protocol family
[    0.567551] [      T1] Segment Routing with IPv6
[    0.567562] [      T1] In-situ OAM (IOAM) with IPv6
[    0.567583] [      T1] mip6: Mobile IPv6
[    0.567586] [      T1] NET: Registered PF_PACKET protocol family
[    0.567627] [      T1] mpls_gso: MPLS GSO support
[    0.569646] [      T1] microcode: Current revision: 0x0a50000c
[    0.570139] [      T1] resctrl: L3 allocation detected
[    0.570140] [      T1] resctrl: MB allocation detected
[    0.570141] [      T1] resctrl: L3 monitoring detected
[    0.570169] [      T1] IPI shorthand broadcast: enabled
[    0.572357] [      T1] sched_clock: Marking stable (571007626, 1230036)=
->(589206987, -16969325)
[    0.572545] [      T1] registered taskstats version 1
[    0.572644] [      T1] Loading compiled-in X.509 certificates
[    0.575871] [      T1] Key type .fscrypt registered
[    0.575872] [      T1] Key type fscrypt-provisioning registered
[    0.575886] [      T1] AppArmor: AppArmor sha256 policy hashing enabled
[    0.579540] [      T1] ACPI BIOS Error (bug): Could not resolve symbol =
[\_SB.PCI0.GP17.MP2], AE_NOT_FOUND (20240827/psargs-332)
[    0.579548] [      T1] ACPI Error: Aborting method \_SB.GPIO._EVT due t=
o previous error (AE_NOT_FOUND) (20240827/psparse-529)
[    0.580260] [      T1] clk: Disabling unused clocks
[    0.580287] [      T1] PM: genpd: Disabling unused power domains
[    0.580984] [      T1] Freeing unused kernel image (initmem) memory: 20=
24K
[    0.580993] [      T1] Write protecting the kernel read-only data: 1843=
2k
[    0.581133] [      T1] Freeing unused kernel image (text/rodata gap) me=
mory: 20K
[    0.581429] [      T1] Freeing unused kernel image (rodata/data gap) me=
mory: 1800K
[    0.626495] [      T1] x86/mm: Checked W+X mappings: passed, no W+X pag=
es found.
[    0.626499] [      T1] Run /init as init process
[    0.626500] [      T1]   with arguments:
[    0.626500] [      T1]     /init
[    0.626501] [      T1]   with environment:
[    0.626502] [      T1]     HOME=3D/
[    0.626503] [      T1]     TERM=3Dlinux
[    0.626503] [      T1]     BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc7-next-2=
0250321-master
[    0.793837] [    T349] i2c_designware_core: no symbol version for __x86=
_indirect_thunk_rax
[    0.806301] [    T362] piix4_smbus 0000:00:14.0: SMBus Host Controller =
at 0xb00, revision 0
[    0.806305] [    T362] piix4_smbus 0000:00:14.0: Using register 0x02 fo=
r SMBus port selection
[    0.807489] [    T362] i2c i2c-1: Successfully instantiated SPD at 0x50
[    0.808690] [    T362] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host C=
ontroller at 0xb20
[    0.809280] [    T378] hid: raw HID events driver (C) Jiri Kosina
[    0.812011] [    T372] pcie_mp2_amd 0000:08:00.7: enabling device (0000=
 -> 0002)
[    0.812195] [    T153] nvme 0000:06:00.0: platform quirk: setting simpl=
e suspend
[    0.812205] [    T146] nvme 0000:07:00.0: platform quirk: setting simpl=
e suspend
[    0.812775] [    T153] nvme nvme0: pci function 0000:06:00.0
[    0.813253] [    T146] nvme nvme1: pci function 0000:07:00.0
[    0.830003] [    T377] ACPI: bus type USB registered
[    0.830039] [    T377] usbcore: registered new interface driver usbfs
[    0.830053] [    T377] usbcore: registered new interface driver hub
[    0.830070] [    T377] usbcore: registered new device driver usb
[    0.831050] [    T146] nvme nvme1: missing or invalid SUBNQN field.
[    0.831137] [    T153] nvme nvme0: D3 entry latency set to 10 seconds
[    0.832081] [    T371] r8169 0000:05:00.0 eth0: RTL8168h/8111h, d8:bb:c=
1:ab:dd:5e, XID 541, IRQ 53
[    0.832084] [    T371] r8169 0000:05:00.0 eth0: jumbo features [frames:=
 9194 bytes, tx checksumming: ko]
[    0.834846] [    T153] nvme nvme0: 16/0/0 default/read/poll queues
[    0.836276] [    T146] nvme nvme1: 15/0/0 default/read/poll queues
[    0.842608] [    T157]  nvme0n1: p1 p2 p3 p4
[    0.844920] [    T393] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.845007] [    T152]  nvme1n1: p1
[    0.845060] [    T393] hid-generic 0020:1022:0001.0002: hidraw1: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.845193] [    T393] hid-generic 0020:1022:0001.0003: hidraw2: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.845327] [    T393] hid-generic 0020:1022:0001.0004: hidraw3: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.845420] [    T393] hid-generic 0020:1022:0001.0005: hidraw4: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.845518] [    T393] hid-generic 0020:1022:0001.0006: hidraw5: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.977879] [    T155] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/pl=
atform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input5
[    0.978184] [    T155] input: PNP0C50:0e 06CB:7E7E Touchpad as /devices=
/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input=
6
[    0.978374] [    T155] hid-generic 0018:06CB:7E7E.0007: input,hidraw6: =
I2C HID v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[    0.980859] [    T386] r8169 0000:05:00.0 enp5s0: renamed from eth0
[    0.982069] [    T396] hid-sensor-hub 0020:1022:0001.0001: hidraw0: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.982376] [    T396] hid-sensor-hub 0020:1022:0001.0002: hidraw1: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.982675] [    T396] hid-sensor-hub 0020:1022:0001.0003: hidraw2: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.982978] [    T396] hid-sensor-hub 0020:1022:0001.0004: hidraw3: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.983209] [    T396] hid-sensor-hub 0020:1022:0001.0005: hidraw4: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.983445] [    T396] hid-sensor-hub 0020:1022:0001.0006: hidraw5: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.990891] [    T370] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.990915] [    T370] xhci_hcd 0000:08:00.3: new USB bus registered, a=
ssigned bus number 1
[    0.991003] [    T370] xhci_hcd 0000:08:00.3: hcc params 0x0268ffe5 hci=
 version 0x110 quirks 0x0000020000000010
[    0.991414] [    T370] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.991417] [    T370] xhci_hcd 0000:08:00.3: new USB bus registered, a=
ssigned bus number 2
[    0.991420] [    T370] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enh=
anced SuperSpeed
[    0.991515] [    T370] usb usb1: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0002, bcdDevice=3D 6.14
[    0.991518] [    T370] usb usb1: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.991520] [    T370] usb usb1: Product: xHCI Host Controller
[    0.991521] [    T370] usb usb1: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.991522] [    T370] usb usb1: SerialNumber: 0000:08:00.3
[    0.992355] [    T370] hub 1-0:1.0: USB hub found
[    0.992383] [    T370] hub 1-0:1.0: 4 ports detected
[    0.993537] [    T370] usb usb2: We don't know the algorithms for LPM f=
or this host, disabling LPM.
[    0.993591] [    T370] usb usb2: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0003, bcdDevice=3D 6.14
[    0.993593] [    T370] usb usb2: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.993594] [    T370] usb usb2: Product: xHCI Host Controller
[    0.993595] [    T370] usb usb2: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.993597] [    T370] usb usb2: SerialNumber: 0000:08:00.3
[    0.993806] [    T370] hub 2-0:1.0: USB hub found
[    0.993819] [    T370] hub 2-0:1.0: 2 ports detected
[    0.994686] [    T370] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.994691] [    T370] xhci_hcd 0000:08:00.4: new USB bus registered, a=
ssigned bus number 3
[    0.994779] [    T370] xhci_hcd 0000:08:00.4: hcc params 0x0268ffe5 hci=
 version 0x110 quirks 0x0000020000000010
[    0.995826] [    T370] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.995829] [    T370] xhci_hcd 0000:08:00.4: new USB bus registered, a=
ssigned bus number 4
[    0.995833] [    T370] xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enh=
anced SuperSpeed
[    0.995929] [    T370] usb usb3: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0002, bcdDevice=3D 6.14
[    0.995931] [    T370] usb usb3: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.995933] [    T370] usb usb3: Product: xHCI Host Controller
[    0.995934] [    T370] usb usb3: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.995935] [    T370] usb usb3: SerialNumber: 0000:08:00.4
[    0.996251] [    T370] hub 3-0:1.0: USB hub found
[    0.996267] [    T370] hub 3-0:1.0: 4 ports detected
[    0.997394] [    T370] usb usb4: We don't know the algorithms for LPM f=
or this host, disabling LPM.
[    0.997449] [    T370] usb usb4: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0003, bcdDevice=3D 6.14
[    0.997452] [    T370] usb usb4: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.997453] [    T370] usb usb4: Product: xHCI Host Controller
[    0.997454] [    T370] usb usb4: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.997455] [    T370] usb usb4: SerialNumber: 0000:08:00.4
[    0.997650] [    T370] hub 4-0:1.0: USB hub found
[    0.997664] [    T370] hub 4-0:1.0: 2 ports detected
[    1.019944] [    T395] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/pl=
atform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input8
[    1.020058] [    T395] input: PNP0C50:0e 06CB:7E7E Touchpad as /devices=
/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input=
9
[    1.020161] [    T395] hid-multitouch 0018:06CB:7E7E.0007: input,hidraw=
6: I2C HID v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[    1.232894] [    T127] usb 1-2: new low-speed USB device number 2 using=
 xhci_hcd
[    1.237892] [    T399] usb 3-3: new high-speed USB device number 2 usin=
g xhci_hcd
[    1.311856] [    T349] [drm] amdgpu kernel modesetting enabled.
[    1.311895] [    T349] amdgpu: vga_switcheroo: detected switching metho=
d \_SB_.PCI0.GP17.VGA_.ATPX handle
[    1.312350] [    T349] amdgpu: ATPX version 1, functions 0x00000001
[    1.312401] [    T349] amdgpu: ATPX Hybrid Graphics
[    1.322345] [    T349] amdgpu: Virtual CRAT table created for CPU
[    1.322366] [    T349] amdgpu: Topology: Add CPU node
[    1.322485] [    T349] amdgpu 0000:03:00.0: enabling device (0000 -> 00=
02)
[    1.322526] [    T349] [drm] initializing kernel modesetting (DIMGREY_C=
AVEFISH 0x1002:0x73FF 0x1462:0x1313 0xC3).
[    1.322534] [    T349] [drm] register mmio base: 0xFCA00000
[    1.322535] [    T349] [drm] register mmio size: 1048576
[    1.326985] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 0 <nv_common>
[    1.326987] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 1 <gmc_v10_0>
[    1.326988] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 2 <navi10_ih>
[    1.326989] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 3 <psp>
[    1.326990] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 4 <smu>
[    1.326992] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 5 <dm>
[    1.326993] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 6 <gfx_v10_0>
[    1.326994] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 7 <sdma_v5_2>
[    1.326995] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 8 <vcn_v3_0>
[    1.326996] [    T349] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 9 <jpeg_v3_0>
[    1.327006] [    T349] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table pre=
sent but broken (too short #2),skipping
[    1.334552] [    T349] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from =
ROM BAR
[    1.334554] [    T349] amdgpu: ATOM BIOS: SWBRT77181.001
[    1.342490] [    T349] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone=
 (TMZ) feature disabled as experimental (default)
[    1.342498] [    T349] [drm] GPU posting now...
[    1.342567] [    T349] [drm] vm size is 262144 GB, 4 levels, block size=
 is 9-bit, fragment size is 9-bit
[    1.342573] [    T349] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x00000=
08000000000 - 0x00000081FEFFFFFF (8176M used)
[    1.342575] [    T349] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x000000=
0000000000 - 0x000000001FFFFFFF
[    1.342583] [    T349] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
[    1.342584] [    T349] [drm] RAM width 128bits GDDR6
[    1.343362] [    T349] [drm] amdgpu: 8176M of VRAM memory ready
[    1.343364] [    T349] [drm] amdgpu: 31851M of GTT memory ready.
[    1.343383] [    T349] [drm] GART: num cpu pages 131072, num gpu pages =
131072
[    1.343507] [    T349] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[    1.366502] [    T127] usb 1-2: New USB device found, idVendor=3D1bcf, =
idProduct=3D08a0, bcdDevice=3D 1.04
[    1.366505] [    T127] usb 1-2: New USB device strings: Mfr=3D0, Produc=
t=3D0, SerialNumber=3D0
[    1.366698] [    T399] usb 3-3: New USB device found, idVendor=3D0e8d, =
idProduct=3D0608, bcdDevice=3D 1.00
[    1.366700] [    T399] usb 3-3: New USB device strings: Mfr=3D5, Produc=
t=3D6, SerialNumber=3D7
[    1.366701] [    T399] usb 3-3: Product: Wireless_Device
[    1.366703] [    T399] usb 3-3: Manufacturer: MediaTek Inc.
[    1.366704] [    T399] usb 3-3: SerialNumber: 000000000
[    1.396956] [    T395] input: HID 1bcf:08a0 Mouse as /devices/pci0000:0=
0/0000:00:08.1/0000:08:00.3/usb1/1-2/1-2:1.0/0003:1BCF:08A0.0008/input/inp=
ut11
[    1.397100] [    T395] input: HID 1bcf:08a0 Keyboard as /devices/pci000=
0:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-2:1.0/0003:1BCF:08A0.0008/input/=
input12
[    1.412878] [    T194] tsc: Refined TSC clocksource calibration: 3199.1=
53 MHz
[    1.412883] [    T194] clocksource: tsc: mask: 0xffffffffffffffff max_c=
ycles: 0x2e1d29f97a6, max_idle_ns: 440795283805 ns
[    1.484765] [    T399] usb 3-4: new full-speed USB device number 3 usin=
g xhci_hcd
[    1.487858] [    T395] input: HID 1bcf:08a0 as /devices/pci0000:00/0000=
:00:08.1/0000:08:00.3/usb1/1-2/1-2:1.0/0003:1BCF:08A0.0008/input/input13
[    1.487998] [    T395] hid-generic 0003:1BCF:08A0.0008: input,hiddev0,h=
idraw7: USB HID v1.10 Mouse [HID 1bcf:08a0] on usb-0000:08:00.3-2/input0
[    1.488057] [    T395] usbcore: registered new interface driver usbhid
[    1.488059] [    T395] usbhid: USB HID core driver
[    1.495760] [    T127] usb 1-4: new high-speed USB device number 3 usin=
g xhci_hcd
[    1.630721] [    T127] usb 1-4: New USB device found, idVendor=3D30c9, =
idProduct=3D0042, bcdDevice=3D 0.03
[    1.630724] [    T127] usb 1-4: New USB device strings: Mfr=3D1, Produc=
t=3D2, SerialNumber=3D3
[    1.630726] [    T127] usb 1-4: Product: Integrated Camera
[    1.630727] [    T127] usb 1-4: Manufacturer: S1F0009330LB620L420004LP
[    1.630729] [    T127] usb 1-4: SerialNumber: SunplusIT Inc
[    1.642518] [    T399] usb 3-4: New USB device found, idVendor=3D1462, =
idProduct=3D1563, bcdDevice=3D 2.00
[    1.642522] [    T399] usb 3-4: New USB device strings: Mfr=3D1, Produc=
t=3D2, SerialNumber=3D3
[    1.642524] [    T399] usb 3-4: Product: MysticLight MS-1563 v0001
[    1.642525] [    T399] usb 3-4: Manufacturer: MSI
[    1.642526] [    T399] usb 3-4: SerialNumber: 2064386A5430
[    1.665489] [    T399] hid-generic 0003:1462:1563.0009: hiddev1,hidraw8=
: USB HID v1.11 Device [MSI MysticLight MS-1563 v0001] on usb-0000:08:00.4=
-4/input0
[    2.044864] [      C3] clocksource: timekeeping watchdog on CPU3: Marki=
ng clocksource 'tsc' as unstable because the skew is too large:
[    2.044867] [      C3] clocksource:                       'hpet' wd_nse=
c: 496992215 wd_now: 1bad220 wd_last: 14e3d28 mask: ffffffff
[    2.044869] [      C3] clocksource:                       'tsc' cs_nsec=
: 496191667 cs_now: 6d5c817c0 cs_last: 6772a6580 mask: ffffffffffffffff
[    2.044871] [      C3] clocksource:                       Clocksource '=
tsc' skewed -800548 ns (0 ms) over watchdog 'hpet' interval of 496992215 n=
s (496 ms)
[    2.044872] [      C3] clocksource:                       'hpet' (not '=
tsc') is current clocksource.
[    2.044878] [      C3] tsc: Marking TSC unstable due to clocksource wat=
chdog
[    2.046508] [     T95] TSC found unstable after boot, most likely due t=
o broken BIOS. Use 'tsc=3Dunstable'.
[    2.046509] [     T95] sched_clock: Marking unstable (2044670270, 12300=
36)<-(2063476284, -16969325)
[    3.633653] [    T349] amdgpu 0000:03:00.0: amdgpu: STB initialized to =
2048 entries
[    3.633747] [    T349] [drm] Loading DMUB firmware via PSP: version=3D0=
x02020020
[    3.634107] [    T349] [drm] use_doorbell being set to: [true]
[    3.634120] [    T349] [drm] use_doorbell being set to: [true]
[    3.634136] [    T349] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware =
Version ENC: 1.33 DEC: 4 VEP: 0 Revision: 3
[    3.796768] [    T349] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[    3.879592] [    T349] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[    3.891041] [    T349] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[    3.891062] [    T349] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D 0x003b3100 (59.49.0)
[    3.891066] [    T349] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[    3.891097] [    T349] amdgpu 0000:03:00.0: amdgpu: use vbios provided =
pptable
[    3.942340] [    T349] amdgpu 0000:03:00.0: amdgpu: SMU is initialized =
successfully!
[    3.942700] [    T349] [drm] Display Core v3.2.325 initialized on DCN 3=
.0.2
[    3.942702] [    T349] [drm] DP-HDMI FRL PCON supported
[    3.944036] [    T349] [drm] DMUB hardware initialized: version=3D0x020=
20020
[    3.977089] [    T349] [drm] kiq ring mec 2 pipe 1 q 0
[    4.015814] [    T349] amdgpu: HMM registered 8176MB device memory
[    4.017196] [    T349] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.017210] [    T349] kfd kfd: amdgpu: Total number of KFD nodes to be=
 created: 1
[    4.017407] [    T349] amdgpu: Virtual CRAT table created for GPU
[    4.017821] [    T349] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    4.017824] [    T349] kfd kfd: amdgpu: added device 1002:73ff
[    4.017845] [    T349] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, =
CU per SH 8, active_cu_number 28
[    4.017849] [    T349] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses=
 VM inv eng 0 on hub 0
[    4.017851] [    T349] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses=
 VM inv eng 1 on hub 0
[    4.017852] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 4 on hub 0
[    4.017853] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 5 on hub 0
[    4.017854] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 6 on hub 0
[    4.017855] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 7 on hub 0
[    4.017856] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 8 on hub 0
[    4.017857] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 9 on hub 0
[    4.017858] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 10 on hub 0
[    4.017859] [    T349] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 11 on hub 0
[    4.017860] [    T349] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 12 on hub 0
[    4.017861] [    T349] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM =
inv eng 13 on hub 0
[    4.017862] [    T349] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM =
inv eng 14 on hub 0
[    4.017864] [    T349] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses=
 VM inv eng 0 on hub 8
[    4.017865] [    T349] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 us=
es VM inv eng 1 on hub 8
[    4.017866] [    T349] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 us=
es VM inv eng 4 on hub 8
[    4.017867] [    T349] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 5 on hub 8
[    4.019074] [    T349] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runt=
ime pm
[    4.027335] [    T349] [drm] Initialized amdgpu 3.63.0 for 0000:03:00.0=
 on minor 0
[    4.030608] [    T349] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[    4.030653] [    T349] [drm] pre_validate_dsc:1601 MST_DSC dsc precompu=
te is not needed
[    4.031047] [    T349] amdgpu 0000:08:00.0: enabling device (0006 -> 00=
07)
[    4.031122] [    T349] [drm] initializing kernel modesetting (RENOIR 0x=
1002:0x1638 0x1462:0x1313 0xC5).
[    4.031136] [    T349] [drm] register mmio base: 0xFC900000
[    4.031137] [    T349] [drm] register mmio size: 524288
[    4.034415] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 0 <soc15_common>
[    4.034417] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 1 <gmc_v9_0>
[    4.034418] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 2 <vega10_ih>
[    4.034420] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 3 <psp>
[    4.034421] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 4 <smu>
[    4.034422] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 5 <dm>
[    4.034423] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 6 <gfx_v9_0>
[    4.034424] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 7 <sdma_v4_0>
[    4.034425] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 8 <vcn_v2_0>
[    4.034427] [    T349] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 9 <jpeg_v2_0>
[    4.034435] [    T349] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from =
VFCT
[    4.034436] [    T349] amdgpu: ATOM BIOS: 113-CEZANNE-018
[    4.038150] [    T349] Console: switching to colour dummy device 80x25
[    4.038170] [    T349] amdgpu 0000:08:00.0: vgaarb: deactivate vga cons=
ole
[    4.038171] [    T349] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone=
 (TMZ) feature enabled
[    4.038173] [    T349] amdgpu 0000:08:00.0: amdgpu: MODE2 reset
[    4.038385] [    T349] [drm] vm size is 262144 GB, 4 levels, block size=
 is 9-bit, fragment size is 9-bit
[    4.038390] [    T349] amdgpu 0000:08:00.0: amdgpu: VRAM: 512M 0x000000=
F400000000 - 0x000000F41FFFFFFF (512M used)
[    4.038392] [    T349] amdgpu 0000:08:00.0: amdgpu: GART: 1024M 0x00000=
00000000000 - 0x000000003FFFFFFF
[    4.038397] [    T349] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[    4.038398] [    T349] [drm] RAM width 128bits DDR4
[    4.038507] [    T349] [drm] amdgpu: 512M of VRAM memory ready
[    4.038509] [    T349] [drm] amdgpu: 31851M of GTT memory ready.
[    4.038530] [    T349] [drm] GART: num cpu pages 262144, num gpu pages =
262144
[    4.038620] [    T349] [drm] PCIE GART of 1024M enabled.
[    4.038621] [    T349] [drm] PTB located at 0x000000F41FC00000
[    4.038925] [    T349] [drm] Loading DMUB firmware via PSP: version=3D0=
x0101002B
[    4.039358] [    T349] amdgpu 0000:08:00.0: amdgpu: Found VCN firmware =
Version ENC: 1.24 DEC: 8 VEP: 0 Revision: 3
[    4.754743] [    T349] amdgpu 0000:08:00.0: amdgpu: reserve 0x400000 fr=
om 0xf41f800000 for PSP TMR
[    4.844522] [    T349] amdgpu 0000:08:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[    4.853289] [    T349] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap t=
a ucode is not available
[    4.853291] [    T349] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[    4.853969] [    T349] amdgpu 0000:08:00.0: amdgpu: SMU is initialized =
successfully!
[    4.857964] [    T349] [drm] Display Core v3.2.325 initialized on DCN 2=
.1
[    4.857967] [    T349] [drm] DP-HDMI FRL PCON supported
[    4.858514] [    T349] [drm] DMUB hardware initialized: version=3D0x010=
1002B
[    5.008675] [    T349] [drm] kiq ring mec 2 pipe 1 q 0
[    5.014807] [    T349] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.014821] [    T349] kfd kfd: amdgpu: Total number of KFD nodes to be=
 created: 1
[    5.014963] [    T349] amdgpu: Virtual CRAT table created for GPU
[    5.016074] [    T349] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[    5.016077] [    T349] kfd kfd: amdgpu: added device 1002:1638
[    5.016161] [    T349] amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, =
CU per SH 8, active_cu_number 8
[    5.016164] [    T349] amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM in=
v eng 0 on hub 0
[    5.016166] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 1 on hub 0
[    5.016168] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 4 on hub 0
[    5.016169] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 5 on hub 0
[    5.016171] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 6 on hub 0
[    5.016172] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 7 on hub 0
[    5.016173] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 8 on hub 0
[    5.016175] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 9 on hub 0
[    5.016176] [    T349] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 10 on hub 0
[    5.016178] [    T349] amdgpu 0000:08:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 11 on hub 0
[    5.016179] [    T349] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM =
inv eng 0 on hub 8
[    5.016181] [    T349] amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses V=
M inv eng 1 on hub 8
[    5.016182] [    T349] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses =
VM inv eng 4 on hub 8
[    5.016184] [    T349] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses =
VM inv eng 5 on hub 8
[    5.016185] [    T349] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 6 on hub 8
[    5.017318] [    T349] amdgpu 0000:08:00.0: amdgpu: Runtime PM not avai=
lable
[    5.017606] [    T349] amdgpu 0000:08:00.0: amdgpu: [drm] Using custom =
brightness curve
[    5.017740] [    T349] [drm] Initialized amdgpu 3.63.0 for 0000:08:00.0=
 on minor 1
[    5.022164] [    T349] fbcon: amdgpudrmfb (fb0) is primary device
[    5.037126] [    T349] Console: switching to colour frame buffer device=
 240x67
[    5.045828] [    T349] amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb fram=
e buffer device
[    5.134281] [    T523] PM: Image not found (code -22)
[    5.202695] [    T536] EXT4-fs (nvme0n1p2): mounted filesystem 73e0f015=
-c115-4eb2-92cb-dbf7da2b6112 ro with ordered data mode. Quota mode: disabl=
ed.
[    5.298701] [      T1] systemd[1]: Inserted module 'autofs4'
[    5.313059] [      T1] systemd[1]: systemd 257.4-3 running in system mo=
de (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUT=
LS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIB=
CRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRE=
NCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UT=
MP +SYSVINIT +LIBARCHIVE)
[    5.313064] [      T1] systemd[1]: Detected architecture x86-64.
[    5.314424] [      T1] systemd[1]: Hostname set to <lisa>.
[    5.394799] [      T1] systemd[1]: bpf-restrict-fs: BPF LSM hook not en=
abled in the kernel, BPF LSM not supported.
[    5.589905] [      T1] systemd[1]: Queued start job for default target =
graphical.target.
[    5.604996] [      T1] systemd[1]: Created slice system-getty.slice - S=
lice /system/getty.
[    5.605533] [      T1] systemd[1]: Created slice system-modprobe.slice =
- Slice /system/modprobe.
[    5.605990] [      T1] systemd[1]: Created slice system-systemd\x2dfsck=
.slice - Slice /system/systemd-fsck.
[    5.606392] [      T1] systemd[1]: Created slice user.slice - User and =
Session Slice.
[    5.606472] [      T1] systemd[1]: Started systemd-ask-password-wall.pa=
th - Forward Password Requests to Wall Directory Watch.
[    5.606675] [      T1] systemd[1]: Set up automount proc-sys-fs-binfmt_=
misc.automount - Arbitrary Executable File Formats File System Automount P=
oint.
[    5.606705] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-11b4f8f5\x2d4dc8\x2d43e2\x2da1e9\x2d6693a8a172b6.device - /dev/disk/by-uu=
id/11b4f8f5-4dc8-43e2-a1e9-6693a8a172b6...
[    5.606718] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-33A0\x2d776C.device - /dev/disk/by-uuid/33A0-776C...
[    5.606730] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-85e13cd1\x2d3c57\x2d4343\x2da1f5\x2d6209e530b640.device - /dev/disk/by-uu=
id/85e13cd1-3c57-4343-a1f5-6209e530b640...
[    5.606744] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-d21e6ad6\x2dbc46\x2d4b61\x2dbc20\x2de4d2f4bf719a.device - /dev/disk/by-uu=
id/d21e6ad6-bc46-4b61-bc20-e4d2f4bf719a...
[    5.606771] [      T1] systemd[1]: Reached target integritysetup.target=
 - Local Integrity Protected Volumes.
[    5.606800] [      T1] systemd[1]: Reached target nss-user-lookup.targe=
t - User and Group Name Lookups.
[    5.606818] [      T1] systemd[1]: Reached target remote-fs.target - Re=
mote File Systems.
[    5.606835] [      T1] systemd[1]: Reached target slices.target - Slice=
 Units.
[    5.606867] [      T1] systemd[1]: Reached target veritysetup.target - =
Local Verity Protected Volumes.
[    5.606968] [      T1] systemd[1]: Listening on dm-event.socket - Devic=
e-mapper event daemon FIFOs.
[    5.607060] [      T1] systemd[1]: Listening on lvm2-lvmpolld.socket - =
LVM2 poll daemon socket.
[    5.607155] [      T1] systemd[1]: Listening on syslog.socket - Syslog =
Socket.
[    5.607745] [      T1] systemd[1]: Listening on systemd-creds.socket - =
Credential Encryption/Decryption.
[    5.607829] [      T1] systemd[1]: Listening on systemd-initctl.socket =
- initctl Compatibility Named Pipe.
[    5.607924] [      T1] systemd[1]: Listening on systemd-journald-dev-lo=
g.socket - Journal Socket (/dev/log).
[    5.608034] [      T1] systemd[1]: Listening on systemd-journald.socket=
 - Journal Sockets.
[    5.608073] [      T1] systemd[1]: systemd-pcrextend.socket - TPM PCR M=
easurements was skipped because of an unmet condition check (ConditionSecu=
rity=3Dmeasured-uki).
[    5.608090] [      T1] systemd[1]: systemd-pcrlock.socket - Make TPM PC=
R Policy was skipped because of an unmet condition check (ConditionSecurit=
y=3Dmeasured-uki).
[    5.608175] [      T1] systemd[1]: Listening on systemd-udevd-control.s=
ocket - udev Control Socket.
[    5.608268] [      T1] systemd[1]: Listening on systemd-udevd-kernel.so=
cket - udev Kernel Socket.
[    5.609366] [      T1] systemd[1]: Mounting dev-hugepages.mount - Huge =
Pages File System...
[    5.610096] [      T1] systemd[1]: Mounting dev-mqueue.mount - POSIX Me=
ssage Queue File System...
[    5.610878] [      T1] systemd[1]: Mounting run-lock.mount - Legacy Loc=
ks Directory /run/lock...
[    5.611768] [      T1] systemd[1]: Mounting sys-kernel-debug.mount - Ke=
rnel Debug File System...
[    5.611845] [      T1] systemd[1]: sys-kernel-tracing.mount - Kernel Tr=
ace File System was skipped because of an unmet condition check (Condition=
PathExists=3D/sys/kernel/tracing).
[    5.612671] [      T1] systemd[1]: Starting blk-availability.service - =
Availability of block devices...
[    5.613977] [      T1] systemd[1]: Starting keyboard-setup.service - Se=
t the console keyboard layout...
[    5.614734] [      T1] systemd[1]: Starting kmod-static-nodes.service -=
 Create List of Static Device Nodes...
[    5.615464] [      T1] systemd[1]: Starting lvm2-monitor.service - Moni=
toring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.=
..
[    5.616824] [      T1] systemd[1]: Starting modprobe@configfs.service -=
 Load Kernel Module configfs...
[    5.617593] [      T1] systemd[1]: Starting modprobe@drm.service - Load=
 Kernel Module drm...
[    5.618325] [      T1] systemd[1]: Starting modprobe@efi_pstore.service=
 - Load Kernel Module efi_pstore...
[    5.619077] [      T1] systemd[1]: Starting modprobe@fuse.service - Loa=
d Kernel Module fuse...
[    5.619939] [      T1] systemd[1]: Starting modprobe@nvme_fabrics.servi=
ce - Load Kernel Module nvme_fabrics...
[    5.620062] [      T1] systemd[1]: systemd-fsck-root.service - File Sys=
tem Check on Root Device was skipped because of an unmet condition check (=
ConditionPathExists=3D!/run/initramfs/fsck-root).
[    5.620113] [      T1] systemd[1]: systemd-hibernate-clear.service - Cl=
ear Stale Hibernate Storage Info was skipped because of an unmet condition=
 check (ConditionPathExists=3D/sys/firmware/efi/efivars/HibernateLocation-=
8cf2644b-4b0b-428f-9387-6d876050dc67).
[    5.621606] [      T1] systemd[1]: Starting systemd-journald.service - =
Journal Service...
[    5.623064] [      T1] systemd[1]: Starting systemd-modules-load.servic=
e - Load Kernel Modules...
[    5.623085] [      T1] systemd[1]: systemd-pcrmachine.service - TPM PCR=
 Machine ID Measurement was skipped because of an unmet condition check (C=
onditionSecurity=3Dmeasured-uki).
[    5.623957] [      T1] systemd[1]: Starting systemd-remount-fs.service =
- Remount Root and Kernel File Systems...
[    5.623999] [      T1] systemd[1]: systemd-tpm2-setup-early.service - E=
arly TPM SRK Setup was skipped because of an unmet condition check (Condit=
ionSecurity=3Dmeasured-uki).
[    5.624336] [    T589] pstore: Using crash dump compression: deflate
[    5.624854] [      T1] systemd[1]: Starting systemd-udev-load-credentia=
ls.service - Load udev Rules from Credentials...
[    5.625707] [      T1] systemd[1]: Starting systemd-udev-trigger.servic=
e - Coldplug All udev Devices...
[    5.626541] [    T589] pstore: Registered efi_pstore as persistent stor=
e backend
[    5.627831] [      T1] systemd[1]: Mounted dev-hugepages.mount - Huge P=
ages File System.
[    5.627944] [      T1] systemd[1]: Mounted dev-mqueue.mount - POSIX Mes=
sage Queue File System.
[    5.628050] [      T1] systemd[1]: Mounted run-lock.mount - Legacy Lock=
s Directory /run/lock.
[    5.628149] [      T1] systemd[1]: Mounted sys-kernel-debug.mount - Ker=
nel Debug File System.
[    5.629096] [      T1] systemd[1]: Finished blk-availability.service - =
Availability of block devices.
[    5.629509] [      T1] systemd[1]: Finished kmod-static-nodes.service -=
 Create List of Static Device Nodes.
[    5.629813] [      T1] systemd[1]: modprobe@configfs.service: Deactivat=
ed successfully.
[    5.630021] [      T1] systemd[1]: Finished modprobe@configfs.service -=
 Load Kernel Module configfs.
[    5.630326] [      T1] systemd[1]: modprobe@drm.service: Deactivated su=
ccessfully.
[    5.630544] [      T1] systemd[1]: Finished modprobe@drm.service - Load=
 Kernel Module drm.
[    5.630832] [      T1] systemd[1]: modprobe@efi_pstore.service: Deactiv=
ated successfully.
[    5.631052] [      T1] systemd[1]: Finished modprobe@efi_pstore.service=
 - Load Kernel Module efi_pstore.
[    5.631417] [      T1] systemd[1]: modprobe@nvme_fabrics.service: Deact=
ivated successfully.
[    5.631634] [      T1] systemd[1]: Finished modprobe@nvme_fabrics.servi=
ce - Load Kernel Module nvme_fabrics.
[    5.632652] [      T1] systemd[1]: Mounting sys-kernel-config.mount - K=
ernel Configuration File System...
[    5.633096] [    T591] fuse: init (API version 7.43)
[    5.633638] [      T1] systemd[1]: Starting systemd-tmpfiles-setup-dev-=
early.service - Create Static Device Nodes in /dev gracefully...
[    5.634591] [      T1] systemd[1]: modprobe@fuse.service: Deactivated s=
uccessfully.
[    5.634808] [      T1] systemd[1]: Finished modprobe@fuse.service - Loa=
d Kernel Module fuse.
[    5.635786] [      T1] systemd[1]: Mounting sys-fs-fuse-connections.mou=
nt - FUSE Control File System...
[    5.637952] [      T1] systemd[1]: Mounted sys-kernel-config.mount - Ke=
rnel Configuration File System.
[    5.640565] [      T1] systemd[1]: Mounted sys-fs-fuse-connections.moun=
t - FUSE Control File System.
[    5.647400] [    T610] EXT4-fs (nvme0n1p2): re-mounted 73e0f015-c115-4e=
b2-92cb-dbf7da2b6112 r/w. Quota mode: disabled.
[    5.648377] [      T1] systemd[1]: Finished systemd-remount-fs.service =
- Remount Root and Kernel File Systems.
[    5.648666] [      T1] systemd[1]: systemd-hwdb-update.service - Rebuil=
d Hardware Database was skipped because of an unmet condition check (Condi=
tionNeedsUpdate=3D/etc).
[    5.648702] [      T1] systemd[1]: systemd-pstore.service - Platform Pe=
rsistent Storage Archival was skipped because of an unmet condition check =
(ConditionDirectoryNotEmpty=3D/sys/fs/pstore).
[    5.649562] [      T1] systemd[1]: Starting systemd-random-seed.service=
 - Load/Save OS Random Seed...
[    5.649582] [      T1] systemd[1]: systemd-tpm2-setup.service - TPM SRK=
 Setup was skipped because of an unmet condition check (ConditionSecurity=
=3Dmeasured-uki).
[    5.657566] [      T1] systemd[1]: Finished keyboard-setup.service - Se=
t the console keyboard layout.
[    5.659652] [    T598] cfg80211: Loading compiled-in X.509 certificates=
 for regulatory database
[    5.665108] [    T596] systemd-journald[596]: Collecting audit messages=
 is disabled.
[    5.667486] [      T1] systemd[1]: Finished systemd-udev-load-credentia=
ls.service - Load udev Rules from Credentials.
[    5.667871] [      T1] systemd[1]: Finished systemd-random-seed.service=
 - Load/Save OS Random Seed.
[    5.668192] [    T598] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.668277] [      T1] systemd[1]: Finished lvm2-monitor.service - Moni=
toring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    5.668369] [    T598] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7=
ff06c7248db18c600'
[    5.669675] [     T95] cfg80211: loaded regulatory.db is malformed or s=
ignature is missing/invalid
[    5.706356] [      T1] systemd[1]: Finished systemd-tmpfiles-setup-dev-=
early.service - Create Static Device Nodes in /dev gracefully.
[    5.706531] [      T1] systemd[1]: systemd-sysusers.service - Create Sy=
stem Users was skipped because no trigger condition checks were met.
[    5.707519] [      T1] systemd[1]: Starting systemd-tmpfiles-setup-dev.=
service - Create Static Device Nodes in /dev...
[    5.719280] [    T598] mt7921e 0000:04:00.0: enabling device (0000 -> 0=
002)
[    5.725605] [    T598] mt7921e 0000:04:00.0: ASIC revision: 79610010
[    5.777385] [      T1] systemd[1]: Finished systemd-tmpfiles-setup-dev.=
service - Create Static Device Nodes in /dev.
[    5.778717] [      T1] systemd[1]: Starting systemd-udevd.service - Rul=
e-based Manager for Device Events and Files...
[    5.799876] [     T95] mt7921e 0000:04:00.0: HW/SW Version: 0x8a108a10,=
 Build Time: 20241106151007a

[    5.802454] [      T1] systemd[1]: Finished systemd-modules-load.servic=
e - Load Kernel Modules.
[    5.803566] [      T1] systemd[1]: Starting systemd-sysctl.service - Ap=
ply Kernel Variables...
[    5.811839] [     T95] mt7921e 0000:04:00.0: WM Firmware Version: ____0=
10000, Build Time: 20241106151045
[    5.834730] [      T1] systemd[1]: Finished systemd-udev-trigger.servic=
e - Coldplug All udev Devices.
[    5.835787] [      T1] systemd[1]: Starting ifupdown-pre.service - Help=
er to synchronize boot up for ifupdown...
[    5.881358] [      T1] systemd[1]: Finished systemd-sysctl.service - Ap=
ply Kernel Variables.
[    5.881714] [      T1] systemd[1]: Started systemd-journald.service - J=
ournal Service.
[    5.929168] [    T596] systemd-journald[596]: Received client request t=
o flush runtime journal.
[    5.964769] [    T709] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYB=
US:00/PNP0A08:00/device:33/PNP0C09:00/PNP0C0D:00/input/input14
[    5.965042] [    T709] ACPI: button: Lid Switch [LID0]
[    5.965340] [    T709] input: Power Button as /devices/LNXSYSTM:00/LNXS=
YBUS:00/PNP0C0C:00/input/input15
[    5.965591] [    T709] ACPI: button: Power Button [PWRB]
[    5.965702] [    T709] input: Sleep Button as /devices/LNXSYSTM:00/LNXS=
YBUS:00/PNP0C0E:00/input/input16
[    5.965804] [    T709] ACPI: button: Sleep Button [SLPB]
[    5.969599] [    T666] ACPI: AC: AC Adapter [ADP1] (on-line)
[    5.977777] [    T723] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[    5.979529] [    T723] ccp 0000:08:00.2: tee enabled
[    5.979682] [    T723] ccp 0000:08:00.2: psp enabled
[    5.994133] [    T650] MCE: In-kernel MCE decoding enabled.
[    6.006895] [    T709] mc: Linux media interface: v0.10
[    6.075709] [    T146] ACPI: battery: Slot [BAT1] (battery present)
[    6.079066] [    T698] input: MSI WMI hotkeys as /devices/virtual/input=
/input17
[    6.081528] [    T755] Adding 75497468k swap on /dev/nvme0n1p3.  Priori=
ty:-2 extents:1 across:75497468k SS
[    6.083531] [    T722] snd_rn_pci_acp3x 0000:08:00.5: enabling device (=
0000 -> 0002)
[    6.092121] [    T709] videodev: Linux video capture interface: v2.00
[    6.125907] [    T715] Bluetooth: Core ver 2.22
[    6.125966] [    T715] NET: Registered PF_BLUETOOTH protocol family
[    6.125967] [    T715] Bluetooth: HCI device and connection manager ini=
tialized
[    6.125970] [    T715] Bluetooth: HCI socket layer initialized
[    6.125973] [    T715] Bluetooth: L2CAP socket layer initialized
[    6.125988] [    T715] Bluetooth: SCO socket layer initialized
[    6.130112] [    T710] snd_hda_intel 0000:03:00.1: enabling device (000=
0 -> 0002)
[    6.130276] [    T710] snd_hda_intel 0000:03:00.1: Handle vga_switchero=
o audio client
[    6.130280] [    T710] snd_hda_intel 0000:03:00.1: Force to non-snoop m=
ode
[    6.130419] [    T710] snd_hda_intel 0000:08:00.1: enabling device (000=
0 -> 0002)
[    6.130484] [    T710] snd_hda_intel 0000:08:00.1: Handle vga_switchero=
o audio client
[    6.130587] [    T710] snd_hda_intel 0000:08:00.6: enabling device (000=
0 -> 0002)
[    6.139492] [    T709] usb 1-4: Found UVC 1.00 device Integrated Camera=
 (30c9:0042)
[    6.142027] [    T724] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (=
ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    6.143954] [    T724] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (=
ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    6.145353] [    T639] usbcore: registered new interface driver btusb
[    6.148587] [    T223] Bluetooth: hci0: HW/SW Version: 0x008a008a, Buil=
d Time: 20241106151414
[    6.149017] [    T202] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input22
[    6.151607] [    T202] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input23
[    6.156020] [    T202] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input24
[    6.157437] [    T511] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input18
[    6.158744] [    T202] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card1=
/input25
[    6.161441] [    T511] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input19
[    6.163260] [    T202] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices=
/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card=
1/input26
[    6.165024] [    T511] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input20
[    6.166272] [    T643] snd_hda_codec_realtek hdaudioC3D0: autoconfig fo=
r ALC233: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    6.166286] [    T643] snd_hda_codec_realtek hdaudioC3D0:    speaker_ou=
ts=3D0 (0x0/0x0/0x0/0x0/0x0)
[    6.166289] [    T643] snd_hda_codec_realtek hdaudioC3D0:    hp_outs=3D=
1 (0x21/0x0/0x0/0x0/0x0)
[    6.166291] [    T643] snd_hda_codec_realtek hdaudioC3D0:    mono: mono=
_out=3D0x0
[    6.166293] [    T643] snd_hda_codec_realtek hdaudioC3D0:    inputs:
[    6.166294] [    T643] snd_hda_codec_realtek hdaudioC3D0:      Mic=3D0x=
19
[    6.166798] [    T709] usbcore: registered new interface driver uvcvide=
o
[    6.168574] [    T511] input: HD-Audio Generic HDMI/DP,pcm=3D9 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card2/input21
[    6.209331] [    T643] input: HD-Audio Generic Mic as /devices/pci0000:=
00/0000:00:08.1/0000:08:00.6/sound/card3/input27
[    6.209546] [    T643] input: HD-Audio Generic Headphone as /devices/pc=
i0000:00/0000:00:08.1/0000:08:00.6/sound/card3/input28
[    6.284420] [    T223] Bluetooth: hci0: Device setup in 136086 usecs
[    6.284429] [    T223] Bluetooth: hci0: HCI Enhanced Setup Synchronous =
Connection command is advertised, but not supported.
[    6.683289] [    T874] EXT4-fs (nvme1n1p1): mounted filesystem 85e13cd1=
-3c57-4343-a1f5-6209e530b640 r/w with ordered data mode. Quota mode: disab=
led.
[    6.689560] [    T873] EXT4-fs (nvme0n1p4): mounted filesystem d21e6ad6=
-bc46-4b61-bc20-e4d2f4bf719a r/w with ordered data mode. Quota mode: disab=
led.
[    6.731612] [    T165] audit: type=3D1400 audit(1742855129.693:2): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
balena-etcher" pid=3D909 comm=3D"apparmor_parser"
[    6.731667] [    T165] audit: type=3D1400 audit(1742855129.693:3): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
cam" pid=3D913 comm=3D"apparmor_parser"
[    6.731714] [    T165] audit: type=3D1400 audit(1742855129.693:4): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
QtWebEngineProcess" pid=3D907 comm=3D"apparmor_parser"
[    6.731759] [    T165] audit: type=3D1400 audit(1742855129.693:5): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
Discord" pid=3D905 comm=3D"apparmor_parser"
[    6.731808] [    T165] audit: type=3D1400 audit(1742855129.693:6): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
ch-run" pid=3D915 comm=3D"apparmor_parser"
[    6.731871] [    T165] audit: type=3D1400 audit(1742855129.693:7): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
busybox" pid=3D912 comm=3D"apparmor_parser"
[    6.731918] [    T165] audit: type=3D1400 audit(1742855129.693:8): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
brave" pid=3D910 comm=3D"apparmor_parser"
[    6.731985] [    T165] audit: type=3D1400 audit(1742855129.693:9): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
buildah" pid=3D911 comm=3D"apparmor_parser"
[    6.732027] [    T165] audit: type=3D1400 audit(1742855129.693:10): app=
armor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D=
"1password" pid=3D904 comm=3D"apparmor_parser"
[    6.732071] [    T165] audit: type=3D1400 audit(1742855129.693:11): app=
armor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D=
"crun" pid=3D919 comm=3D"apparmor_parser"
[    6.880045] [   T1050] nvme nvme0: using unchecked data buffer
[    6.998931] [   T1150] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.998934] [   T1150] Bluetooth: BNEP filters: protocol multicast
[    6.998938] [   T1150] Bluetooth: BNEP socket layer initialized
[    7.000144] [   T1024] Bluetooth: MGMT ver 1.23
[    7.008274] [   T1153] Bluetooth: RFCOMM TTY layer initialized
[    7.008279] [   T1153] Bluetooth: RFCOMM socket layer initialized
[    7.008283] [   T1153] Bluetooth: RFCOMM ver 1.11
[    7.310942] [   T1061] block nvme0n1: No UUID available providing old N=
GUID
[    7.331292] [   T1119] Generic FE-GE Realtek PHY r8169-0-500:00: attach=
ed PHY driver (mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[    7.510886] [    T624] r8169 0000:05:00.0 enp5s0: Link is Down
[    7.540218] [    T639] mt7921e 0000:04:00.0 wlp4s0: renamed from wlan0
[   10.532541] [   T1120] wlp4s0: authenticate with 54:67:51:3d:a2:e0 (loc=
al address=3Dc8:94:02:c1:bd:69)
[   10.649163] [   T1120] wlp4s0: send auth to 54:67:51:3d:a2:e0 (try 1/3)
[   10.651375] [    T159] wlp4s0: authenticated
[   10.653257] [    T159] wlp4s0: associate with 54:67:51:3d:a2:e0 (try 1/=
3)
[   10.673412] [    T159] wlp4s0: RX AssocResp from 54:67:51:3d:a2:e0 (cap=
ab=3D0x1411 status=3D0 aid=3D1)
[   10.678731] [    T159] wlp4s0: associated
[   10.871268] [    T152] wlp4s0: Limiting TX power to 20 (20 - 0) dBm as =
advertised by 54:67:51:3d:a2:e0
[   18.504574] [    T596] systemd-journald[596]: Time jumped backwards, ro=
tating.

With nokaslr:
[    0.000000] [      T0] Linux version 6.14.0-rc7-next-20250321-master (b=
ert@lisa) (gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian)=
 2.44) #755 SMP PREEMPT_RT Mon Mar 24 23:23:21 CET 2025
[    0.000000] [      T0] Command line: BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-=
rc7-next-20250321-master nokaslr root=3DUUID=3D73e0f015-c115-4eb2-92cb-dbf=
7da2b6112 ro clocksource=3Dhpet amdgpu.noretry=3D0 quiet
[    0.000000] [      T0] BIOS-provided physical RAM map:
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000000000000-0x00000000000=
9ffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000000a0000-0x00000000000=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000000100000-0x0000000009b=
fefff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000009bff000-0x000000000a0=
00fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x000000000a001000-0x000000000a1=
fffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x000000000a200000-0x000000000a2=
0efff] ACPI NVS
[    0.000000] [      T0] BIOS-e820: [mem 0x000000000a20f000-0x00000000e9e=
1ffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000e9e20000-0x00000000eb3=
3efff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000eb33f000-0x00000000eb3=
9efff] ACPI data
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000eb39f000-0x00000000eb5=
56fff] ACPI NVS
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000eb557000-0x00000000ed1=
fefff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000ed1ff000-0x00000000edf=
fffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000ee000000-0x00000000f7f=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fd000000-0x00000000fdf=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec=
01fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec=
10fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed=
00fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed=
44fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed=
8ffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fedc4000-0x00000000fed=
c9fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fedcc000-0x00000000fed=
cefff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000fedd5000-0x00000000fed=
d5fff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x00000000ff000000-0x00000000fff=
fffff] reserved
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000100000000-0x0000000fee2=
fffff] usable
[    0.000000] [      T0] BIOS-e820: [mem 0x0000000fee300000-0x000000100ff=
fffff] reserved
[    0.000000] [      T0] NX (Execute Disable) protection: active
[    0.000000] [      T0] APIC: Static calls initialized
[    0.000000] [      T0] efi: EFI v2.7 by American Megatrends
[    0.000000] [      T0] efi: ACPI=3D0xeb540000 ACPI 2.0=3D0xeb540014 TPM=
FinalLog=3D0xeb50c000 SMBIOS=3D0xed020000 SMBIOS 3.0=3D0xed01f000 MEMATTR=
=3D0xe6fa0018 ESRT=3D0xe87cb898 INITRD=3D0xe5e66518 RNG=3D0xeb351018 TPMEv=
entLog=3D0xeb341018
[    0.000000] [      T0] random: crng init done
[    0.000000] [      T0] efi: Remove mem54: MMIO range=3D[0xf0000000-0xf7=
ffffff] (128MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xf0000000-0xf7ffffff] reserve=
d
[    0.000000] [      T0] efi: Remove mem55: MMIO range=3D[0xfd000000-0xfd=
ffffff] (16MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xfd000000-0xfdffffff] reserve=
d
[    0.000000] [      T0] efi: Remove mem56: MMIO range=3D[0xfeb80000-0xfe=
c01fff] (0MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xfeb80000-0xfec01fff] reserve=
d
[    0.000000] [      T0] efi: Not removing mem57: MMIO range=3D[0xfec1000=
0-0xfec10fff] (4KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem58: MMIO range=3D[0xfed0000=
0-0xfed00fff] (4KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem59: MMIO range=3D[0xfed4000=
0-0xfed44fff] (20KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem60: MMIO range=3D[0xfed8000=
0-0xfed8ffff] (64KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem61: MMIO range=3D[0xfedc400=
0-0xfedc9fff] (24KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem62: MMIO range=3D[0xfedcc00=
0-0xfedcefff] (12KB) from e820 map
[    0.000000] [      T0] efi: Not removing mem63: MMIO range=3D[0xfedd500=
0-0xfedd5fff] (4KB) from e820 map
[    0.000000] [      T0] efi: Remove mem64: MMIO range=3D[0xff000000-0xff=
ffffff] (16MB) from e820 map
[    0.000000] [      T0] e820: remove [mem 0xff000000-0xffffffff] reserve=
d
[    0.000000] [      T0] SMBIOS 3.3.0 present.
[    0.000000] [      T0] DMI: Micro-Star International Co., Ltd. Alpha 15=
 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[    0.000000] [      T0] DMI: Memory slots populated: 2/2
[    0.000000] [      T0] tsc: Fast TSC calibration using PIT
[    0.000000] [      T0] tsc: Detected 3193.924 MHz processor
[    0.000133] [      T0] e820: update [mem 0x00000000-0x00000fff] usable =
=3D=3D> reserved
[    0.000134] [      T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000139] [      T0] last_pfn =3D 0xfee300 max_arch_pfn =3D 0x4000000=
00
[    0.000145] [      T0] MTRR map: 5 entries (3 fixed + 2 variable; max 2=
0), built from 9 variable MTRRs
[    0.000147] [      T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB=
  WP  UC- WT
[    0.000239] [      T0] e820: update [mem 0xf0000000-0xffffffff] usable =
=3D=3D> reserved
[    0.000243] [      T0] last_pfn =3D 0xee000 max_arch_pfn =3D 0x40000000=
0
[    0.002752] [      T0] esrt: Reserving ESRT space from 0x00000000e87cb8=
98 to 0x00000000e87cb8d0.
[    0.002757] [      T0] e820: update [mem 0xe87cb000-0xe87cbfff] usable =
=3D=3D> reserved
[    0.002766] [      T0] Using GB pages for direct mapping
[    0.003092] [      T0] Secure boot disabled
[    0.003093] [      T0] RAMDISK: [mem 0xdc678000-0xdefa1fff]
[    0.003130] [      T0] ACPI: Early table checksum verification disabled
[    0.003132] [      T0] ACPI: RSDP 0x00000000EB540014 000024 (v02 MSI_NB=
)
[    0.003135] [      T0] ACPI: XSDT 0x00000000EB53F728 000114 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  01000013)
[    0.003139] [      T0] ACPI: FACP 0x00000000EB390000 000114 (v06 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.003142] [      T0] ACPI: DSDT 0x00000000EB383000 00C50C (v02 MSI_NB=
 MEGABOOK 01072009 INTL 20190509)
[    0.003143] [      T0] ACPI: FACS 0x00000000EB50A000 000040
[    0.003144] [      T0] ACPI: SLIC 0x00000000EB39E000 000176 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  01000013)
[    0.003145] [      T0] ACPI: SSDT 0x00000000EB396000 0072B0 (v02 AMD   =
 AmdTable 00000002 MSFT 04000000)
[    0.003147] [      T0] ACPI: IVRS 0x00000000EB395000 0001A4 (v02 AMD   =
 AmdTable 00000001 AMD  00000000)
[    0.003148] [      T0] ACPI: SSDT 0x00000000EB391000 003A21 (v01 AMD   =
 AMD AOD  00000001 INTL 20190509)
[    0.003149] [      T0] ACPI: FIDT 0x00000000EB382000 00009C (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.003151] [      T0] ACPI: ECDT 0x00000000EB381000 0000C1 (v01 MSI_NB=
 MEGABOOK 01072009 AMI. 00010013)
[    0.003152] [      T0] ACPI: MCFG 0x00000000EB380000 00003C (v01 MSI_NB=
 MEGABOOK 01072009 MSFT 00010013)
[    0.003153] [      T0] ACPI: HPET 0x00000000EB37F000 000038 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00000005)
[    0.003154] [      T0] ACPI: VFCT 0x00000000EB371000 00D884 (v01 MSI_NB=
 MEGABOOK 00000001 AMD  31504F47)
[    0.003155] [      T0] ACPI: BGRT 0x00000000EB370000 000038 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.003156] [      T0] ACPI: TPM2 0x00000000EB36F000 00004C (v04 MSI_NB=
 MEGABOOK 00000001 AMI  00000000)
[    0.003157] [      T0] ACPI: SSDT 0x00000000EB369000 005354 (v02 AMD   =
 AmdTable 00000001 AMD  00000001)
[    0.003159] [      T0] ACPI: CRAT 0x00000000EB368000 000EE8 (v01 AMD   =
 AmdTable 00000001 AMD  00000001)
[    0.003160] [      T0] ACPI: CDIT 0x00000000EB367000 000029 (v01 AMD   =
 AmdTable 00000001 AMD  00000001)
[    0.003161] [      T0] ACPI: SSDT 0x00000000EB366000 000149 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003162] [      T0] ACPI: SSDT 0x00000000EB364000 00148E (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003163] [      T0] ACPI: SSDT 0x00000000EB362000 00153F (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003164] [      T0] ACPI: SSDT 0x00000000EB361000 000696 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003165] [      T0] ACPI: SSDT 0x00000000EB35F000 001A56 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003166] [      T0] ACPI: SSDT 0x00000000EB35E000 0005DE (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003167] [      T0] ACPI: SSDT 0x00000000EB35A000 0036E9 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003168] [      T0] ACPI: WSMT 0x00000000EB359000 000028 (v01 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.003169] [      T0] ACPI: APIC 0x00000000EB358000 0000DE (v03 MSI_NB=
 MEGABOOK 01072009 AMI  00010013)
[    0.003170] [      T0] ACPI: SSDT 0x00000000EB357000 00008D (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003171] [      T0] ACPI: SSDT 0x00000000EB356000 0008A8 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003173] [      T0] ACPI: SSDT 0x00000000EB355000 0001B7 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003174] [      T0] ACPI: SSDT 0x00000000EB354000 0007B1 (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003175] [      T0] ACPI: SSDT 0x00000000EB353000 00097D (v01 AMD   =
 AmdTable 00000001 INTL 20190509)
[    0.003176] [      T0] ACPI: FPDT 0x00000000EB352000 000044 (v01 MSI_NB=
 A M I    01072009 AMI  01000013)
[    0.003177] [      T0] ACPI: Reserving FACP table memory at [mem 0xeb39=
0000-0xeb390113]
[    0.003178] [      T0] ACPI: Reserving DSDT table memory at [mem 0xeb38=
3000-0xeb38f50b]
[    0.003178] [      T0] ACPI: Reserving FACS table memory at [mem 0xeb50=
a000-0xeb50a03f]
[    0.003178] [      T0] ACPI: Reserving SLIC table memory at [mem 0xeb39=
e000-0xeb39e175]
[    0.003179] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb39=
6000-0xeb39d2af]
[    0.003179] [      T0] ACPI: Reserving IVRS table memory at [mem 0xeb39=
5000-0xeb3951a3]
[    0.003179] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb39=
1000-0xeb394a20]
[    0.003180] [      T0] ACPI: Reserving FIDT table memory at [mem 0xeb38=
2000-0xeb38209b]
[    0.003180] [      T0] ACPI: Reserving ECDT table memory at [mem 0xeb38=
1000-0xeb3810c0]
[    0.003180] [      T0] ACPI: Reserving MCFG table memory at [mem 0xeb38=
0000-0xeb38003b]
[    0.003181] [      T0] ACPI: Reserving HPET table memory at [mem 0xeb37=
f000-0xeb37f037]
[    0.003181] [      T0] ACPI: Reserving VFCT table memory at [mem 0xeb37=
1000-0xeb37e883]
[    0.003181] [      T0] ACPI: Reserving BGRT table memory at [mem 0xeb37=
0000-0xeb370037]
[    0.003182] [      T0] ACPI: Reserving TPM2 table memory at [mem 0xeb36=
f000-0xeb36f04b]
[    0.003182] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
9000-0xeb36e353]
[    0.003182] [      T0] ACPI: Reserving CRAT table memory at [mem 0xeb36=
8000-0xeb368ee7]
[    0.003183] [      T0] ACPI: Reserving CDIT table memory at [mem 0xeb36=
7000-0xeb367028]
[    0.003183] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
6000-0xeb366148]
[    0.003183] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
4000-0xeb36548d]
[    0.003184] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
2000-0xeb36353e]
[    0.003184] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb36=
1000-0xeb361695]
[    0.003185] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
f000-0xeb360a55]
[    0.003185] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
e000-0xeb35e5dd]
[    0.003185] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
a000-0xeb35d6e8]
[    0.003186] [      T0] ACPI: Reserving WSMT table memory at [mem 0xeb35=
9000-0xeb359027]
[    0.003186] [      T0] ACPI: Reserving APIC table memory at [mem 0xeb35=
8000-0xeb3580dd]
[    0.003186] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
7000-0xeb35708c]
[    0.003187] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
6000-0xeb3568a7]
[    0.003187] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
5000-0xeb3551b6]
[    0.003187] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
4000-0xeb3547b0]
[    0.003188] [      T0] ACPI: Reserving SSDT table memory at [mem 0xeb35=
3000-0xeb35397c]
[    0.003188] [      T0] ACPI: Reserving FPDT table memory at [mem 0xeb35=
2000-0xeb352043]
[    0.003238] [      T0] Zone ranges:
[    0.003239] [      T0]   DMA      [mem 0x0000000000001000-0x0000000000f=
fffff]
[    0.003240] [      T0]   DMA32    [mem 0x0000000001000000-0x00000000fff=
fffff]
[    0.003241] [      T0]   Normal   [mem 0x0000000100000000-0x0000000fee2=
fffff]
[    0.003241] [      T0]   Device   empty
[    0.003242] [      T0] Movable zone start for each node
[    0.003242] [      T0] Early memory node ranges
[    0.003242] [      T0]   node   0: [mem 0x0000000000001000-0x0000000000=
09ffff]
[    0.003243] [      T0]   node   0: [mem 0x0000000000100000-0x0000000009=
bfefff]
[    0.003244] [      T0]   node   0: [mem 0x000000000a001000-0x000000000a=
1fffff]
[    0.003244] [      T0]   node   0: [mem 0x000000000a20f000-0x00000000e9=
e1ffff]
[    0.003245] [      T0]   node   0: [mem 0x00000000ed1ff000-0x00000000ed=
ffffff]
[    0.003245] [      T0]   node   0: [mem 0x0000000100000000-0x0000000fee=
2fffff]
[    0.003248] [      T0] Initmem setup node 0 [mem 0x0000000000001000-0x0=
000000fee2fffff]
[    0.003252] [      T0] On node 0, zone DMA: 1 pages in unavailable rang=
es
[    0.003263] [      T0] On node 0, zone DMA: 96 pages in unavailable ran=
ges
[    0.003357] [      T0] On node 0, zone DMA32: 1026 pages in unavailable=
 ranges
[    0.006972] [      T0] On node 0, zone DMA32: 15 pages in unavailable r=
anges
[    0.007053] [      T0] On node 0, zone DMA32: 13279 pages in unavailabl=
e ranges
[    0.007240] [      T0] On node 0, zone Normal: 8192 pages in unavailabl=
e ranges
[    0.007274] [      T0] On node 0, zone Normal: 7424 pages in unavailabl=
e ranges
[    0.008244] [      T0] ACPI: PM-Timer IO Port: 0x808
[    0.008251] [      T0] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x=
1])
[    0.008262] [      T0] IOAPIC[0]: apic_id 33, version 33, address 0xfec=
00000, GSI 0-23
[    0.008266] [      T0] IOAPIC[1]: apic_id 34, version 33, address 0xfec=
01000, GSI 24-55
[    0.008267] [      T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 =
dfl dfl)
[    0.008268] [      T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 =
low level)
[    0.008271] [      T0] ACPI: Using ACPI (MADT) for SMP configuration in=
formation
[    0.008271] [      T0] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.008278] [      T0] e820: update [mem 0xe62ee000-0xe63e1fff] usable =
=3D=3D> reserved
[    0.008290] [      T0] CPU topo: Max. logical packages:   1
[    0.008290] [      T0] CPU topo: Max. logical dies:       1
[    0.008290] [      T0] CPU topo: Max. dies per package:   1
[    0.008293] [      T0] CPU topo: Max. threads per core:   2
[    0.008294] [      T0] CPU topo: Num. cores per package:     8
[    0.008294] [      T0] CPU topo: Num. threads per package:  16
[    0.008294] [      T0] CPU topo: Allowing 16 present CPUs plus 0 hotplu=
g CPUs
[    0.008307] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x00000000-0x00000fff]
[    0.008308] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x000a0000-0x000fffff]
[    0.008309] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x09bff000-0x0a000fff]
[    0.008309] [      T0] PM: hibernation: Registered nosave memory: [mem =
0x0a200000-0x0a20efff]
[    0.008310] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xe62ee000-0xe63e1fff]
[    0.008311] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xe87cb000-0xe87cbfff]
[    0.008312] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xe9e20000-0xeb33efff]
[    0.008312] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xeb33f000-0xeb39efff]
[    0.008312] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xeb39f000-0xeb556fff]
[    0.008312] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xeb557000-0xed1fefff]
[    0.008313] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xee000000-0xefffffff]
[    0.008313] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xf0000000-0xfec0ffff]
[    0.008314] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfec10000-0xfec10fff]
[    0.008314] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfec11000-0xfecfffff]
[    0.008314] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed00000-0xfed00fff]
[    0.008315] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed01000-0xfed3ffff]
[    0.008315] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed40000-0xfed44fff]
[    0.008315] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed45000-0xfed7ffff]
[    0.008315] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed80000-0xfed8ffff]
[    0.008316] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfed90000-0xfedc3fff]
[    0.008316] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedc4000-0xfedc9fff]
[    0.008316] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedca000-0xfedcbfff]
[    0.008317] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedcc000-0xfedcefff]
[    0.008317] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedcf000-0xfedd4fff]
[    0.008317] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedd5000-0xfedd5fff]
[    0.008317] [      T0] PM: hibernation: Registered nosave memory: [mem =
0xfedd6000-0xffffffff]
[    0.008319] [      T0] [mem 0xf0000000-0xfec0ffff] available for PCI de=
vices
[    0.008320] [      T0] clocksource: refined-jiffies: mask: 0xffffffff m=
ax_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.010692] [      T0] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_c=
pu_ids:16 nr_node_ids:1
[    0.011023] [      T0] percpu: Embedded 45 pages/cpu s146800 r8192 d293=
28 u262144
[    0.011027] [      T0] pcpu-alloc: s146800 r8192 d29328 u262144 alloc=
=3D1*2097152
[    0.011028] [      T0] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 0=
9 10 11 12 13 14 15
[    0.011040] [      T0] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-=
6.14.0-rc7-next-20250321-master nokaslr root=3DUUID=3D73e0f015-c115-4eb2-9=
2cb-dbf7da2b6112 ro clocksource=3Dhpet amdgpu.noretry=3D0 quiet
[    0.011078] [      T0] Unknown kernel command line parameters "nokaslr =
BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc7-next-20250321-master", will be passe=
d to user space.
[    0.011094] [      T0] printk: log buffer data + meta data: 131072 + 45=
8752 =3D 589824 bytes
[    0.015336] [      T0] Dentry cache hash table entries: 8388608 (order:=
 14, 67108864 bytes, linear)
[    0.017444] [      T0] Inode-cache hash table entries: 4194304 (order: =
13, 33554432 bytes, linear)
[    0.017511] [      T0] software IO TLB: area num 16.
[    0.026129] [      T0] Built 1 zonelists, mobility grouping on.  Total =
pages: 16616111
[    0.026132] [      T0] mem auto-init: stack:off, heap alloc:off, heap f=
ree:off
[    0.033626] [      T0] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0,=
 CPUs=3D16, Nodes=3D1
[    0.033977] [      T0] Dynamic Preempt: lazy
[    0.034027] [      T0] rcu: Preemptible hierarchical RCU implementation=
.
[    0.034028] [      T0] rcu: 	RCU priority boosting: priority 1 delay 50=
0 ms.
[    0.034029] [      T0] rcu: 	RCU_SOFTIRQ processing moved to rcuc kthre=
ads.
[    0.034030] [      T0] 	No expedited grace period (rcu_normal_after_boo=
t).
[    0.034030] [      T0] 	Trampoline variant of Tasks RCU enabled.
[    0.034030] [      T0] 	Tracing variant of Tasks RCU enabled.
[    0.034031] [      T0] rcu: RCU calculated value of scheduler-enlistmen=
t delay is 100 jiffies.
[    0.034040] [      T0] RCU Tasks: Setting shift to 4 and lim to 1 rcu_t=
ask_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.034042] [      T0] RCU Tasks Trace: Setting shift to 4 and lim to 1=
 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D16.
[    0.034049] [      T0] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs:=
 16
[    0.034232] [      T0] rcu: srcu_init: Setting srcu_struct sizes based =
on contention.
[    0.034306] [      T0] Console: colour dummy device 80x25
[    0.034308] [      T0] printk: legacy console [tty0] enabled
[    0.034315] [      T0] ACPI: Core revision 20240827
[    0.034460] [      T0] clocksource: hpet: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 133484873504 ns
[    0.034477] [      T0] APIC: Switch to symmetric I/O mode setup
[    0.034843] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, r=
devid:0xa0
[    0.034844] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, r=
devid:0xa0
[    0.034845] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, r=
devid:0xa0
[    0.034845] [      T0] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, r=
devid:0xa0
[    0.034846] [      T0] AMD-Vi: Using global IVHD EFR:0x206d73ef22254ade=
, EFR2:0x0
[    0.035103] [      T0] x2apic enabled
[    0.035149] [      T0] APIC: Switched APIC routing to: cluster x2apic
[    0.035735] [      T0] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=
=3D-1 pin2=3D-1
[    0.040483] [      T0] clocksource: tsc-early: mask: 0xffffffffffffffff=
 max_cycles: 0x2e09de6ed1b, max_idle_ns: 440795361819 ns
[    0.040487] [      T0] Calibrating delay loop (skipped), value calculat=
ed using timer frequency.. 6387.84 BogoMIPS (lpj=3D3193924)
[    0.040500] [      T0] x86/cpu: User Mode Instruction Prevention (UMIP)=
 activated
[    0.040519] [      T0] LVT offset 1 assigned for vector 0xf9
[    0.040576] [      T0] LVT offset 2 assigned for vector 0xf4
[    0.040592] [      T0] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 2=
56
[    0.040592] [      T0] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB=
 1024, 1GB 0
[    0.040595] [      T0] process: using mwait in idle threads
[    0.040596] [      T0] Spectre V1 : Mitigation: usercopy/swapgs barrier=
s and __user pointer sanitization
[    0.040598] [      T0] Spectre V2 : Mitigation: Retpolines
[    0.040598] [      T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation:=
 Filling RSB on context switch
[    0.040598] [      T0] Spectre V2 : Spectre v2 / SpectreRSB : Filling R=
SB on VMEXIT
[    0.040599] [      T0] Spectre V2 : Enabling Restricted Speculation for=
 firmware calls
[    0.040600] [      T0] Spectre V2 : mitigation: Enabling conditional In=
direct Branch Prediction Barrier
[    0.040601] [      T0] Spectre V2 : User space: Mitigation: STIBP alway=
s-on protection
[    0.040601] [      T0] Speculative Store Bypass: Mitigation: Speculativ=
e Store Bypass disabled via prctl
[    0.040602] [      T0] Speculative Return Stack Overflow: IBPB-extendin=
g microcode not applied!
[    0.040603] [      T0] Speculative Return Stack Overflow: WARNING: See =
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitig=
ation options.
[    0.040603] [      T0] Speculative Return Stack Overflow: Vulnerable: S=
afe RET, no microcode
[    0.040607] [      T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 fl=
oating point registers'
[    0.040608] [      T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE re=
gisters'
[    0.040608] [      T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX re=
gisters'
[    0.040608] [      T0] x86/fpu: Supporting XSAVE feature 0x200: 'Protec=
tion Keys User registers'
[    0.040609] [      T0] x86/fpu: Supporting XSAVE feature 0x800: 'Contro=
l-flow User registers'
[    0.040610] [      T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]=
:  256
[    0.040610] [      T0] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]=
:    8
[    0.040611] [      T0] x86/fpu: xstate_offset[11]:  840, xstate_sizes[1=
1]:   16
[    0.040611] [      T0] x86/fpu: Enabled xstate features 0xa07, context =
size is 856 bytes, using 'compacted' format.
[    0.053500] [      T0] Freeing SMP alternatives memory: 36K
[    0.053502] [      T0] pid_max: default: 32768 minimum: 301
[    0.055987] [      T0] LSM: initializing lsm=3Dcapability,apparmor
[    0.056089] [      T0] AppArmor: AppArmor initialized
[    0.056195] [      T0] Mount-cache hash table entries: 131072 (order: 8=
, 1048576 bytes, linear)
[    0.056264] [      T0] Mountpoint-cache hash table entries: 131072 (ord=
er: 8, 1048576 bytes, linear)
[    0.158976] [      T1] smpboot: CPU0: AMD Ryzen 7 5800H with Radeon Gra=
phics (family: 0x19, model: 0x50, stepping: 0x0)
[    0.159187] [      T1] Performance Events: Fam17h+ core perfctr, AMD PM=
U driver.
[    0.159192] [      T1] ... version:                0
[    0.159193] [      T1] ... bit width:              48
[    0.159193] [      T1] ... generic registers:      6
[    0.159194] [      T1] ... value mask:             0000ffffffffffff
[    0.159195] [      T1] ... max period:             00007fffffffffff
[    0.159195] [      T1] ... fixed-purpose events:   0
[    0.159196] [      T1] ... event mask:             000000000000003f
[    0.159277] [      T1] signal: max sigframe size: 3376
[    0.159352] [      T1] rcu: Hierarchical SRCU implementation.
[    0.159353] [      T1] rcu: 	Max phase no-delay instances is 400.
[    0.159474] [      T1] Timer migration: 2 hierarchy levels; 8 children =
per group; 2 crossnode level
[    0.160300] [     T11] NMI watchdog: Enabled. Permanently consumes one =
hw-PMU counter.
[    0.160456] [      T1] smp: Bringing up secondary CPUs ...
[    0.160626] [      T1] smpboot: x86: Booting SMP configuration:
[    0.160627] [      T1] .... node  #0, CPUs:        #2  #4  #6  #8 #10 #=
12 #14  #1  #3  #5  #7  #9 #11 #13 #15
[    0.177568] [      T1] Spectre V2 : Update user space SMT mitigation: S=
TIBP always-on
[    0.185513] [      T1] smp: Brought up 1 node, 16 CPUs
[    0.185513] [      T1] smpboot: Total of 16 processors activated (10220=
5.56 BogoMIPS)
[    0.245541] [    T145] node 0 deferred pages initialised in 59ms
[    0.245547] [      T1] Memory: 65171140K/66464444K available (12264K ke=
rnel code, 1211K rwdata, 4344K rodata, 2024K init, 1348K bss, 1278436K res=
erved, 0K cma-reserved)
[    0.246633] [      T1] devtmpfs: initialized
[    0.246633] [      T1] x86/mm: Memory block size: 128MB
[    0.258182] [      T1] ACPI: PM: Registering ACPI NVS region [mem 0x0a2=
00000-0x0a20efff] (61440 bytes)
[    0.258182] [      T1] ACPI: PM: Registering ACPI NVS region [mem 0xeb3=
9f000-0xeb556fff] (1802240 bytes)
[    0.258182] [      T1] clocksource: jiffies: mask: 0xffffffff max_cycle=
s: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.258182] [      T1] posixtimers hash table entries: 8192 (order: 6, =
327680 bytes, linear)
[    0.258182] [      T1] futex hash table entries: 4096 (order: 6, 262144=
 bytes, linear)
[    0.258571] [      T1] pinctrl core: initialized pinctrl subsystem
[    0.258964] [      T1] NET: Registered PF_NETLINK/PF_ROUTE protocol fam=
ily
[    0.259171] [      T1] audit: initializing netlink subsys (disabled)
[    0.259179] [    T165] audit: type=3D2000 audit(1742855348.223:1): stat=
e=3Dinitialized audit_enabled=3D0 res=3D1
[    0.259179] [      T1] thermal_sys: Registered thermal governor 'fair_s=
hare'
[    0.259179] [      T1] thermal_sys: Registered thermal governor 'bang_b=
ang'
[    0.259179] [      T1] thermal_sys: Registered thermal governor 'step_w=
ise'
[    0.259179] [      T1] thermal_sys: Registered thermal governor 'user_s=
pace'
[    0.259179] [      T1] thermal_sys: Registered thermal governor 'power_=
allocator'
[    0.259179] [      T1] cpuidle: using governor ladder
[    0.259179] [      T1] cpuidle: using governor teo
[    0.259648] [      T1] acpiphp: ACPI Hot Plug PCI Controller Driver ver=
sion: 0.5
[    0.259736] [      T1] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0=
000000) for domain 0000 [bus 00-7f]
[    0.259750] [      T1] PCI: Using configuration type 1 for base access
[    0.259828] [      T1] HugeTLB: allocation took 0ms with hugepage_alloc=
ation_threads=3D4
[    0.259828] [      T1] HugeTLB: registered 1.00 GiB page size, pre-allo=
cated 0 pages
[    0.259828] [      T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.=
00 GiB page
[    0.259828] [      T1] HugeTLB: registered 2.00 MiB page size, pre-allo=
cated 0 pages
[    0.259828] [      T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 =
MiB page
[    0.260556] [      T1] ACPI: Added _OSI(Module Device)
[    0.260558] [      T1] ACPI: Added _OSI(Processor Device)
[    0.260558] [      T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.260559] [      T1] ACPI: Added _OSI(Processor Aggregator Device)
[    0.282847] [      T1] ACPI: 16 ACPI AML tables successfully acquired a=
nd loaded
[    0.284405] [      T1] ACPI: EC: EC started
[    0.284406] [      T1] ACPI: EC: interrupt blocked
[    0.285012] [      T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.285013] [      T1] ACPI: EC: Boot ECDT EC used to handle transactio=
ns
[    0.286001] [      T1] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ign=
ored
[    0.289535] [      T1] ACPI: Interpreter enabled
[    0.289554] [      T1] ACPI: PM: (supports S0 S4 S5)
[    0.289555] [      T1] ACPI: Using IOAPIC for interrupt routing
[    0.289807] [      T1] PCI: Using host bridge windows from ACPI; if nec=
essary, use "pci=3Dnocrs" and report a bug
[    0.289808] [      T1] PCI: Using E820 reservations for host bridge win=
dows
[    0.290436] [      T1] ACPI: Enabled 1 GPEs in block 00 to 1F
[    0.291421] [      T1] ACPI: \_SB_.PCI0.GPP0.M237: New power resource
[    0.291693] [      T1] ACPI: \_SB_.PCI0.GPP0.SWUS.M237: New power resou=
rce
[    0.291830] [      T1] ACPI: \_SB_.PCI0.GPP0.SWUS.SWDS.M237: New power =
resource
[    0.293523] [      T1] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resou=
rce
[    0.293567] [      T1] ACPI: \_SB_.PCI0.GP17.XHC0.P3U0: New power resou=
rce
[    0.294447] [      T1] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resou=
rce
[    0.294498] [      T1] ACPI: \_SB_.PCI0.GP17.XHC1.P3U1: New power resou=
rce
[    0.297278] [      T1] ACPI: \_SB_.PCI0.GPP6.P0NV: New power resource
[    0.297589] [      T1] ACPI: \_SB_.PCI0.GPP5.P0NX: New power resource
[    0.307208] [      T1] ACPI: \_SB_.PRWB: New power resource
[    0.310006] [      T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 0=
0-ff])
[    0.310012] [      T1] acpi PNP0A08:00: _OSC: OS supports [ExtendedConf=
ig ASPM ClockPM Segments MSI HPX-Type3]
[    0.310121] [      T1] acpi PNP0A08:00: _OSC: platform does not support=
 [LTR]
[    0.310320] [      T1] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotp=
lug PME AER PCIeCapability]
[    0.310322] [      T1] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0=
000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially covers this =
bridge
[    0.310952] [      T1] PCI host bridge to bus 0000:00
[    0.310956] [      T1] pci_bus 0000:00: root bus resource [io  0x0000-0=
x03af window]
[    0.310958] [      T1] pci_bus 0000:00: root bus resource [io  0x03e0-0=
x0cf7 window]
[    0.310959] [      T1] pci_bus 0000:00: root bus resource [io  0x03b0-0=
x03df window]
[    0.310960] [      T1] pci_bus 0000:00: root bus resource [io  0x0d00-0=
xffff window]
[    0.310962] [      T1] pci_bus 0000:00: root bus resource [mem 0x000a00=
00-0x000dffff window]
[    0.310963] [      T1] pci_bus 0000:00: root bus resource [mem 0xf00000=
00-0xfcffffff window]
[    0.310965] [      T1] pci_bus 0000:00: root bus resource [mem 0x101000=
0000-0xffffffffff window]
[    0.310967] [      T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.310984] [      T1] pci 0000:00:00.0: [1022:1630] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.311125] [      T1] pci 0000:00:00.2: [1022:1631] type 00 class 0x08=
0600 conventional PCI endpoint
[    0.311263] [      T1] pci 0000:00:01.0: [1022:1632] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.311382] [      T1] pci 0000:00:01.1: [1022:1633] type 01 class 0x06=
0400 PCIe Root Port
[    0.311395] [      T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.311400] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfca0000=
0-0xfccfffff]
[    0.311406] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.311449] [      T1] pci 0000:00:01.1: PME# supported from D0 D3hot D=
3cold
[    0.311620] [      T1] pci 0000:00:02.0: [1022:1632] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.311739] [      T1] pci 0000:00:02.1: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.311752] [      T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.311761] [      T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300=
000-0xfe304fffff 64bit pref]
[    0.311801] [      T1] pci 0000:00:02.1: PME# supported from D0 D3hot D=
3cold
[    0.311932] [      T1] pci 0000:00:02.2: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.311945] [      T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.311949] [      T1] pci 0000:00:02.2:   bridge window [io  0xf000-0x=
ffff]
[    0.311951] [      T1] pci 0000:00:02.2:   bridge window [mem 0xfcf0000=
0-0xfcffffff]
[    0.311961] [      T1] pci 0000:00:02.2: enabling Extended Tags
[    0.311996] [      T1] pci 0000:00:02.2: PME# supported from D0 D3hot D=
3cold
[    0.312125] [      T1] pci 0000:00:02.3: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.312138] [      T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.312142] [      T1] pci 0000:00:02.3:   bridge window [mem 0xfce0000=
0-0xfcefffff]
[    0.312186] [      T1] pci 0000:00:02.3: PME# supported from D0 D3hot D=
3cold
[    0.312312] [      T1] pci 0000:00:02.4: [1022:1634] type 01 class 0x06=
0400 PCIe Root Port
[    0.312324] [      T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.312329] [      T1] pci 0000:00:02.4:   bridge window [mem 0xfcd0000=
0-0xfcdfffff]
[    0.312339] [      T1] pci 0000:00:02.4: enabling Extended Tags
[    0.312373] [      T1] pci 0000:00:02.4: PME# supported from D0 D3hot D=
3cold
[    0.312527] [      T1] pci 0000:00:08.0: [1022:1632] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.312647] [      T1] pci 0000:00:08.1: [1022:1635] type 01 class 0x06=
0400 PCIe Root Port
[    0.312660] [      T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.312663] [      T1] pci 0000:00:08.1:   bridge window [io  0xe000-0x=
efff]
[    0.312665] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfc50000=
0-0xfc9fffff]
[    0.312670] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000=
000-0xfe301fffff 64bit pref]
[    0.312676] [      T1] pci 0000:00:08.1: enabling Extended Tags
[    0.312710] [      T1] pci 0000:00:08.1: PME# supported from D0 D3hot D=
3cold
[    0.312915] [      T1] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c=
0500 conventional PCI endpoint
[    0.313067] [      T1] pci 0000:00:14.3: [1022:790e] type 00 class 0x06=
0100 conventional PCI endpoint
[    0.313233] [      T1] pci 0000:00:18.0: [1022:166a] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.313326] [      T1] pci 0000:00:18.1: [1022:166b] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.313419] [      T1] pci 0000:00:18.2: [1022:166c] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.313522] [      T1] pci 0000:00:18.3: [1022:166d] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.313618] [      T1] pci 0000:00:18.4: [1022:166e] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.313712] [      T1] pci 0000:00:18.5: [1022:166f] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.313806] [      T1] pci 0000:00:18.6: [1022:1670] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.313900] [      T1] pci 0000:00:18.7: [1022:1671] type 00 class 0x06=
0000 conventional PCI endpoint
[    0.314071] [      T1] pci 0000:01:00.0: [1002:1478] type 01 class 0x06=
0400 PCIe Switch Upstream Port
[    0.314092] [      T1] pci 0000:01:00.0: BAR 0 [mem 0xfcc00000-0xfcc03f=
ff]
[    0.314096] [      T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.314104] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.314112] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.314194] [      T1] pci 0000:01:00.0: PME# supported from D0 D3hot D=
3cold
[    0.314262] [      T1] pci 0000:01:00.0: 63.008 Gb/s available PCIe ban=
dwidth, limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 126.0=
24 Gb/s with 16.0 GT/s PCIe x8 link)
[    0.314404] [      T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.314483] [      T1] pci 0000:02:00.0: [1002:1479] type 01 class 0x06=
0400 PCIe Switch Downstream Port
[    0.314512] [      T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.314519] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.314528] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.314610] [      T1] pci 0000:02:00.0: PME# supported from D0 D3hot D=
3cold
[    0.315135] [      T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.315227] [      T1] pci 0000:03:00.0: [1002:73ff] type 00 class 0x03=
8000 PCIe Legacy Endpoint
[    0.315260] [      T1] pci 0000:03:00.0: BAR 0 [mem 0xfc00000000-0xfdff=
ffffff 64bit pref]
[    0.315263] [      T1] pci 0000:03:00.0: BAR 2 [mem 0xfe00000000-0xfe0f=
ffffff 64bit pref]
[    0.315266] [      T1] pci 0000:03:00.0: BAR 5 [mem 0xfca00000-0xfcafff=
ff]
[    0.315268] [      T1] pci 0000:03:00.0: ROM [mem 0xfcb00000-0xfcb1ffff=
 pref]
[    0.315357] [      T1] pci 0000:03:00.0: PME# supported from D1 D2 D3ho=
t D3cold
[    0.315428] [      T1] pci 0000:03:00.0: 63.008 Gb/s available PCIe ban=
dwidth, limited by 8.0 GT/s PCIe x8 link at 0000:00:01.1 (capable of 252.0=
48 Gb/s with 16.0 GT/s PCIe x16 link)
[    0.315578] [      T1] pci 0000:03:00.1: [1002:ab28] type 00 class 0x04=
0300 PCIe Legacy Endpoint
[    0.315610] [      T1] pci 0000:03:00.1: BAR 0 [mem 0xfcb20000-0xfcb23f=
ff]
[    0.315676] [      T1] pci 0000:03:00.1: PME# supported from D1 D2 D3ho=
t D3cold
[    0.315852] [      T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.315949] [      T1] pci 0000:04:00.0: [14c3:0608] type 00 class 0x02=
8000 PCIe Endpoint
[    0.315992] [      T1] pci 0000:04:00.0: BAR 0 [mem 0xfe30300000-0xfe30=
3fffff 64bit pref]
[    0.315996] [      T1] pci 0000:04:00.0: BAR 2 [mem 0xfe30400000-0xfe30=
403fff 64bit pref]
[    0.315999] [      T1] pci 0000:04:00.0: BAR 4 [mem 0xfe30404000-0xfe30=
404fff 64bit pref]
[    0.316070] [      T1] pci 0000:04:00.0: supports D1 D2
[    0.316071] [      T1] pci 0000:04:00.0: PME# supported from D0 D1 D2 D=
3hot D3cold
[    0.316273] [      T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.316353] [      T1] pci 0000:05:00.0: [10ec:8168] type 00 class 0x02=
0000 PCIe Endpoint
[    0.316398] [      T1] pci 0000:05:00.0: BAR 0 [io  0xf000-0xf0ff]
[    0.316403] [      T1] pci 0000:05:00.0: BAR 2 [mem 0xfcf04000-0xfcf04f=
ff 64bit]
[    0.316406] [      T1] pci 0000:05:00.0: BAR 4 [mem 0xfcf00000-0xfcf03f=
ff 64bit]
[    0.316499] [      T1] pci 0000:05:00.0: supports D1 D2
[    0.316501] [      T1] pci 0000:05:00.0: PME# supported from D0 D1 D2 D=
3hot D3cold
[    0.316714] [      T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.317126] [      T1] pci 0000:06:00.0: [2646:5013] type 00 class 0x01=
0802 PCIe Endpoint
[    0.317230] [      T1] pci 0000:06:00.0: BAR 0 [mem 0xfce00000-0xfce03f=
ff 64bit]
[    0.317736] [      T1] pci 0000:06:00.0: 31.504 Gb/s available PCIe ban=
dwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:02.3 (capable of 63.01=
2 Gb/s with 16.0 GT/s PCIe x4 link)
[    0.318244] [      T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.318509] [      T1] pci 0000:07:00.0: [c0a9:2263] type 00 class 0x01=
0802 PCIe Endpoint
[    0.318553] [      T1] pci 0000:07:00.0: BAR 0 [mem 0xfcd00000-0xfcd03f=
ff 64bit]
[    0.318852] [      T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.318954] [      T1] pci 0000:08:00.0: [1002:1638] type 00 class 0x03=
0000 PCIe Legacy Endpoint
[    0.318976] [      T1] pci 0000:08:00.0: BAR 0 [mem 0xfe20000000-0xfe2f=
ffffff 64bit pref]
[    0.318979] [      T1] pci 0000:08:00.0: BAR 2 [mem 0xfe30000000-0xfe30=
1fffff 64bit pref]
[    0.318981] [      T1] pci 0000:08:00.0: BAR 4 [io  0xe000-0xe0ff]
[    0.318982] [      T1] pci 0000:08:00.0: BAR 5 [mem 0xfc900000-0xfc97ff=
ff]
[    0.318987] [      T1] pci 0000:08:00.0: enabling Extended Tags
[    0.319040] [      T1] pci 0000:08:00.0: PME# supported from D1 D2 D3ho=
t D3cold
[    0.319185] [      T1] pci 0000:08:00.1: [1002:1637] type 00 class 0x04=
0300 PCIe Legacy Endpoint
[    0.319206] [      T1] pci 0000:08:00.1: BAR 0 [mem 0xfc9c8000-0xfc9cbf=
ff]
[    0.319213] [      T1] pci 0000:08:00.1: enabling Extended Tags
[    0.319245] [      T1] pci 0000:08:00.1: PME# supported from D1 D2 D3ho=
t D3cold
[    0.319364] [      T1] pci 0000:08:00.2: [1022:15df] type 00 class 0x10=
8000 PCIe Endpoint
[    0.319386] [      T1] pci 0000:08:00.2: BAR 2 [mem 0xfc800000-0xfc8fff=
ff]
[    0.319490] [      T1] pci 0000:08:00.2: BAR 5 [mem 0xfc9ce000-0xfc9cff=
ff]
[    0.319496] [      T1] pci 0000:08:00.2: enabling Extended Tags
[    0.319639] [      T1] pci 0000:08:00.3: [1022:1639] type 00 class 0x0c=
0330 PCIe Endpoint
[    0.319661] [      T1] pci 0000:08:00.3: BAR 0 [mem 0xfc700000-0xfc7fff=
ff 64bit]
[    0.319668] [      T1] pci 0000:08:00.3: enabling Extended Tags
[    0.319702] [      T1] pci 0000:08:00.3: PME# supported from D0 D3hot D=
3cold
[    0.319839] [      T1] pci 0000:08:00.4: [1022:1639] type 00 class 0x0c=
0330 PCIe Endpoint
[    0.319861] [      T1] pci 0000:08:00.4: BAR 0 [mem 0xfc600000-0xfc6fff=
ff 64bit]
[    0.319868] [      T1] pci 0000:08:00.4: enabling Extended Tags
[    0.319902] [      T1] pci 0000:08:00.4: PME# supported from D0 D3hot D=
3cold
[    0.320028] [      T1] pci 0000:08:00.5: [1022:15e2] type 00 class 0x04=
8000 PCIe Endpoint
[    0.320049] [      T1] pci 0000:08:00.5: BAR 0 [mem 0xfc980000-0xfc9bff=
ff]
[    0.320056] [      T1] pci 0000:08:00.5: enabling Extended Tags
[    0.320087] [      T1] pci 0000:08:00.5: PME# supported from D0 D3hot D=
3cold
[    0.320207] [      T1] pci 0000:08:00.6: [1022:15e3] type 00 class 0x04=
0300 PCIe Endpoint
[    0.320228] [      T1] pci 0000:08:00.6: BAR 0 [mem 0xfc9c0000-0xfc9c7f=
ff]
[    0.320235] [      T1] pci 0000:08:00.6: enabling Extended Tags
[    0.320267] [      T1] pci 0000:08:00.6: PME# supported from D0 D3hot D=
3cold
[    0.320386] [      T1] pci 0000:08:00.7: [1022:15e4] type 00 class 0x11=
8000 PCIe Endpoint
[    0.320407] [      T1] pci 0000:08:00.7: BAR 2 [mem 0xfc500000-0xfc5fff=
ff]
[    0.320410] [      T1] pci 0000:08:00.7: BAR 5 [mem 0xfc9cc000-0xfc9cdf=
ff]
[    0.320415] [      T1] pci 0000:08:00.7: enabling Extended Tags
[    0.320595] [      T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.320617] [      T1] pci_bus 0000:00: on NUMA node 0
[    0.322818] [      T1] ACPI: PCI: Interrupt link LNKA configured for IR=
Q 0
[    0.322881] [      T1] ACPI: PCI: Interrupt link LNKB configured for IR=
Q 0
[    0.322935] [      T1] ACPI: PCI: Interrupt link LNKC configured for IR=
Q 0
[    0.322998] [      T1] ACPI: PCI: Interrupt link LNKD configured for IR=
Q 0
[    0.323057] [      T1] ACPI: PCI: Interrupt link LNKE configured for IR=
Q 0
[    0.323107] [      T1] ACPI: PCI: Interrupt link LNKF configured for IR=
Q 0
[    0.323156] [      T1] ACPI: PCI: Interrupt link LNKG configured for IR=
Q 0
[    0.323206] [      T1] ACPI: PCI: Interrupt link LNKH configured for IR=
Q 0
[    0.324857] [      T1] Low-power S0 idle used by default for system sus=
pend
[    0.325694] [      T1] ACPI: EC: interrupt unblocked
[    0.325695] [      T1] ACPI: EC: event unblocked
[    0.325697] [      T1] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
[    0.325698] [      T1] ACPI: EC: GPE=3D0x3
[    0.325699] [      T1] ACPI: \_SB_.PCI0.SBRG.EC__: Boot ECDT EC initial=
ization complete
[    0.325701] [      T1] ACPI: \_SB_.PCI0.SBRG.EC__: EC: Used to handle t=
ransactions and events
[    0.325766] [      T1] iommu: Default domain type: Passthrough
[    0.325861] [      T1] EDAC MC: Ver: 3.0.0
[    0.326327] [      T1] efivars: Registered efivars operations
[    0.326646] [      T1] PCI: Using ACPI for IRQ routing
[    0.331181] [      T1] PCI: pci_cache_line_size set to 64 bytes
[    0.331920] [      T1] e820: reserve RAM buffer [mem 0x09bff000-0x0bfff=
fff]
[    0.331922] [      T1] e820: reserve RAM buffer [mem 0x0a200000-0x0bfff=
fff]
[    0.331923] [      T1] e820: reserve RAM buffer [mem 0xe62ee000-0xe7fff=
fff]
[    0.331924] [      T1] e820: reserve RAM buffer [mem 0xe87cb000-0xebfff=
fff]
[    0.331925] [      T1] e820: reserve RAM buffer [mem 0xe9e20000-0xebfff=
fff]
[    0.331926] [      T1] e820: reserve RAM buffer [mem 0xee000000-0xeffff=
fff]
[    0.331927] [      T1] e820: reserve RAM buffer [mem 0xfee300000-0xfeff=
fffff]
[    0.332049] [      T1] pci 0000:08:00.0: vgaarb: setting as boot VGA de=
vice
[    0.332049] [      T1] pci 0000:08:00.0: vgaarb: bridge control possibl=
e
[    0.332049] [      T1] pci 0000:08:00.0: vgaarb: VGA device added: deco=
des=3Dio+mem,owns=3Dnone,locks=3Dnone
[    0.332049] [      T1] vgaarb: loaded
[    0.332746] [      T1] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.332749] [      T1] hpet0: 3 comparators, 32-bit 14.318180 MHz count=
er
[    0.334531] [      T1] clocksource: Switched to clocksource hpet
[    0.334850] [      T1] AppArmor: AppArmor Filesystem Enabled
[    0.334870] [      T1] pnp: PnP ACPI init
[    0.334980] [      T1] system 00:00: [mem 0xf0000000-0xf7ffffff] has be=
en reserved
[    0.335681] [      T1] system 00:04: [io  0x04d0-0x04d1] has been reser=
ved
[    0.335684] [      T1] system 00:04: [io  0x040b] has been reserved
[    0.335685] [      T1] system 00:04: [io  0x04d6] has been reserved
[    0.335687] [      T1] system 00:04: [io  0x0c00-0x0c01] has been reser=
ved
[    0.335688] [      T1] system 00:04: [io  0x0c14] has been reserved
[    0.335690] [      T1] system 00:04: [io  0x0c50-0x0c51] has been reser=
ved
[    0.335691] [      T1] system 00:04: [io  0x0c52] has been reserved
[    0.335693] [      T1] system 00:04: [io  0x0c6c] has been reserved
[    0.335694] [      T1] system 00:04: [io  0x0c6f] has been reserved
[    0.335696] [      T1] system 00:04: [io  0x0cd8-0x0cdf] has been reser=
ved
[    0.335697] [      T1] system 00:04: [io  0x0800-0x089f] has been reser=
ved
[    0.335698] [      T1] system 00:04: [io  0x0b00-0x0b0f] has been reser=
ved
[    0.335700] [      T1] system 00:04: [io  0x0b20-0x0b3f] has been reser=
ved
[    0.335701] [      T1] system 00:04: [io  0x0900-0x090f] has been reser=
ved
[    0.335703] [      T1] system 00:04: [io  0x0910-0x091f] has been reser=
ved
[    0.335705] [      T1] system 00:04: [mem 0xfec00000-0xfec00fff] could =
not be reserved
[    0.335707] [      T1] system 00:04: [mem 0xfec01000-0xfec01fff] could =
not be reserved
[    0.335708] [      T1] system 00:04: [mem 0xfedc0000-0xfedc0fff] has be=
en reserved
[    0.335710] [      T1] system 00:04: [mem 0xfee00000-0xfee00fff] has be=
en reserved
[    0.335711] [      T1] system 00:04: [mem 0xfed80000-0xfed8ffff] could =
not be reserved
[    0.335713] [      T1] system 00:04: [mem 0xfec10000-0xfec10fff] has be=
en reserved
[    0.335714] [      T1] system 00:04: [mem 0xff000000-0xffffffff] has be=
en reserved
[    0.336708] [      T1] pnp: PnP ACPI: found 5 devices
[    0.344156] [      T1] clocksource: acpi_pm: mask: 0xffffff max_cycles:=
 0xffffff, max_idle_ns: 2085701024 ns
[    0.344290] [      T1] NET: Registered PF_INET protocol family
[    0.344476] [      T1] IP idents hash table entries: 262144 (order: 9, =
2097152 bytes, linear)
[    0.346854] [      T1] tcp_listen_portaddr_hash hash table entries: 327=
68 (order: 8, 1310720 bytes, linear)
[    0.347067] [      T1] Table-perturb hash table entries: 65536 (order: =
6, 262144 bytes, linear)
[    0.347074] [      T1] TCP established hash table entries: 524288 (orde=
r: 10, 4194304 bytes, linear)
[    0.347447] [      T1] TCP bind hash table entries: 65536 (order: 10, 5=
242880 bytes, vmalloc hugepage)
[    0.348242] [      T1] TCP: Hash tables configured (established 524288 =
bind 65536)
[    0.348623] [      T1] MPTCP token hash table entries: 65536 (order: 9,=
 3670016 bytes, linear)
[    0.349049] [      T1] UDP hash table entries: 32768 (order: 10, 524288=
0 bytes, vmalloc hugepage)
[    0.349732] [      T1] UDP-Lite hash table entries: 32768 (order: 10, 5=
242880 bytes, vmalloc hugepage)
[    0.350461] [      T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.350471] [      T1] NET: Registered PF_XDP protocol family
[    0.350483] [      T1] pci 0000:00:01.1: bridge window [io  0x1000-0x0f=
ff] to [bus 01-03] add_size 1000
[    0.350494] [      T1] pci 0000:00:01.1: bridge window [io  0x1000-0x1f=
ff]: assigned
[    0.350497] [      T1] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.350506] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.350509] [      T1] pci 0000:02:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.350514] [      T1] pci 0000:01:00.0: PCI bridge to [bus 02-03]
[    0.350518] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfca0000=
0-0xfcbfffff]
[    0.350521] [      T1] pci 0000:01:00.0:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.350525] [      T1] pci 0000:00:01.1: PCI bridge to [bus 01-03]
[    0.350527] [      T1] pci 0000:00:01.1:   bridge window [io  0x1000-0x=
1fff]
[    0.350530] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfca0000=
0-0xfccfffff]
[    0.350532] [      T1] pci 0000:00:01.1:   bridge window [mem 0xfc00000=
000-0xfe0fffffff 64bit pref]
[    0.350536] [      T1] pci 0000:00:02.1: PCI bridge to [bus 04]
[    0.350540] [      T1] pci 0000:00:02.1:   bridge window [mem 0xfe30300=
000-0xfe304fffff 64bit pref]
[    0.350543] [      T1] pci 0000:00:02.2: PCI bridge to [bus 05]
[    0.350544] [      T1] pci 0000:00:02.2:   bridge window [io  0xf000-0x=
ffff]
[    0.350547] [      T1] pci 0000:00:02.2:   bridge window [mem 0xfcf0000=
0-0xfcffffff]
[    0.350552] [      T1] pci 0000:00:02.3: PCI bridge to [bus 06]
[    0.350554] [      T1] pci 0000:00:02.3:   bridge window [mem 0xfce0000=
0-0xfcefffff]
[    0.350559] [      T1] pci 0000:00:02.4: PCI bridge to [bus 07]
[    0.350561] [      T1] pci 0000:00:02.4:   bridge window [mem 0xfcd0000=
0-0xfcdfffff]
[    0.350567] [      T1] pci 0000:00:08.1: PCI bridge to [bus 08]
[    0.350569] [      T1] pci 0000:00:08.1:   bridge window [io  0xe000-0x=
efff]
[    0.350571] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfc50000=
0-0xfc9fffff]
[    0.350573] [      T1] pci 0000:00:08.1:   bridge window [mem 0xfe20000=
000-0xfe301fffff 64bit pref]
[    0.350578] [      T1] pci_bus 0000:00: resource 4 [io  0x0000-0x03af w=
indow]
[    0.350580] [      T1] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 w=
indow]
[    0.350581] [      T1] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df w=
indow]
[    0.350582] [      T1] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff w=
indow]
[    0.350583] [      T1] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x00=
0dffff window]
[    0.350584] [      T1] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfc=
ffffff window]
[    0.350585] [      T1] pci_bus 0000:00: resource 10 [mem 0x1010000000-0=
xffffffffff window]
[    0.350587] [      T1] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    0.350588] [      T1] pci_bus 0000:01: resource 1 [mem 0xfca00000-0xfc=
cfffff]
[    0.350589] [      T1] pci_bus 0000:01: resource 2 [mem 0xfc00000000-0x=
fe0fffffff 64bit pref]
[    0.350591] [      T1] pci_bus 0000:02: resource 1 [mem 0xfca00000-0xfc=
bfffff]
[    0.350592] [      T1] pci_bus 0000:02: resource 2 [mem 0xfc00000000-0x=
fe0fffffff 64bit pref]
[    0.350593] [      T1] pci_bus 0000:03: resource 1 [mem 0xfca00000-0xfc=
bfffff]
[    0.350594] [      T1] pci_bus 0000:03: resource 2 [mem 0xfc00000000-0x=
fe0fffffff 64bit pref]
[    0.350595] [      T1] pci_bus 0000:04: resource 2 [mem 0xfe30300000-0x=
fe304fffff 64bit pref]
[    0.350597] [      T1] pci_bus 0000:05: resource 0 [io  0xf000-0xffff]
[    0.350598] [      T1] pci_bus 0000:05: resource 1 [mem 0xfcf00000-0xfc=
ffffff]
[    0.350600] [      T1] pci_bus 0000:06: resource 1 [mem 0xfce00000-0xfc=
efffff]
[    0.350601] [      T1] pci_bus 0000:07: resource 1 [mem 0xfcd00000-0xfc=
dfffff]
[    0.350602] [      T1] pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
[    0.350603] [      T1] pci_bus 0000:08: resource 1 [mem 0xfc500000-0xfc=
9fffff]
[    0.350604] [      T1] pci_bus 0000:08: resource 2 [mem 0xfe20000000-0x=
fe301fffff 64bit pref]
[    0.350755] [      T1] pci 0000:03:00.1: D0 power state depends on 0000=
:03:00.0
[    0.351155] [      T1] pci 0000:08:00.1: D0 power state depends on 0000=
:08:00.0
[    0.351161] [      T1] pci 0000:08:00.3: extending delay after power-on=
 from D3hot to 20 msec
[    0.351436] [      T1] pci 0000:08:00.4: extending delay after power-on=
 from D3hot to 20 msec
[    0.351530] [      T1] PCI: CLS 64 bytes, default 64
[    0.351546] [      T1] pci 0000:00:00.2: AMD-Vi: IOMMU performance coun=
ters supported
[    0.351602] [    T149] Trying to unpack rootfs image as initramfs...
[    0.351636] [      T1] pci 0000:00:00.0: Adding to iommu group 0
[    0.351666] [      T1] pci 0000:00:01.0: Adding to iommu group 1
[    0.351687] [      T1] pci 0000:00:01.1: Adding to iommu group 2
[    0.351719] [      T1] pci 0000:00:02.0: Adding to iommu group 3
[    0.351739] [      T1] pci 0000:00:02.1: Adding to iommu group 4
[    0.351759] [      T1] pci 0000:00:02.2: Adding to iommu group 5
[    0.351780] [      T1] pci 0000:00:02.3: Adding to iommu group 6
[    0.351802] [      T1] pci 0000:00:02.4: Adding to iommu group 7
[    0.351830] [      T1] pci 0000:00:08.0: Adding to iommu group 8
[    0.351851] [      T1] pci 0000:00:08.1: Adding to iommu group 9
[    0.351887] [      T1] pci 0000:00:14.0: Adding to iommu group 10
[    0.351905] [      T1] pci 0000:00:14.3: Adding to iommu group 10
[    0.351990] [      T1] pci 0000:00:18.0: Adding to iommu group 11
[    0.352009] [      T1] pci 0000:00:18.1: Adding to iommu group 11
[    0.352027] [      T1] pci 0000:00:18.2: Adding to iommu group 11
[    0.352046] [      T1] pci 0000:00:18.3: Adding to iommu group 11
[    0.352065] [      T1] pci 0000:00:18.4: Adding to iommu group 11
[    0.352083] [      T1] pci 0000:00:18.5: Adding to iommu group 11
[    0.352102] [      T1] pci 0000:00:18.6: Adding to iommu group 11
[    0.352121] [      T1] pci 0000:00:18.7: Adding to iommu group 11
[    0.352141] [      T1] pci 0000:01:00.0: Adding to iommu group 12
[    0.352162] [      T1] pci 0000:02:00.0: Adding to iommu group 13
[    0.352192] [      T1] pci 0000:03:00.0: Adding to iommu group 14
[    0.352215] [      T1] pci 0000:03:00.1: Adding to iommu group 15
[    0.352254] [      T1] pci 0000:04:00.0: Adding to iommu group 16
[    0.352274] [      T1] pci 0000:05:00.0: Adding to iommu group 17
[    0.352296] [      T1] pci 0000:06:00.0: Adding to iommu group 18
[    0.352317] [      T1] pci 0000:07:00.0: Adding to iommu group 19
[    0.352340] [      T1] pci 0000:08:00.0: Adding to iommu group 20
[    0.352361] [      T1] pci 0000:08:00.1: Adding to iommu group 21
[    0.352383] [      T1] pci 0000:08:00.2: Adding to iommu group 22
[    0.352404] [      T1] pci 0000:08:00.3: Adding to iommu group 23
[    0.352425] [      T1] pci 0000:08:00.4: Adding to iommu group 24
[    0.352446] [      T1] pci 0000:08:00.5: Adding to iommu group 25
[    0.352470] [      T1] pci 0000:08:00.6: Adding to iommu group 26
[    0.352492] [      T1] pci 0000:08:00.7: Adding to iommu group 27
[    0.352913] [      T1] AMD-Vi: Extended features (0x206d73ef22254ade, 0=
x0): PPR X2APIC NX GT IA GA PC GA_vAPIC
[    0.352918] [      T1] AMD-Vi: Interrupt remapping enabled
[    0.352919] [      T1] AMD-Vi: X2APIC enabled
[    0.353351] [      T1] AMD-Vi: Virtual APIC enabled
[    0.353358] [      T1] PCI-DMA: Using software bounce buffering for IO =
(SWIOTLB)
[    0.353359] [      T1] software IO TLB: mapped [mem 0x00000000e1e58000-=
0x00000000e5e58000] (64MB)
[    0.353412] [      T1] RAPL PMU: API unit is 2^-32 Joules, 2 fixed coun=
ters, 163840 ms ovfl timer
[    0.353413] [      T1] RAPL PMU: hw unit of domain package 2^-16 Joules
[    0.353414] [      T1] RAPL PMU: hw unit of domain core 2^-16 Joules
[    0.353417] [      T1] LVT offset 0 assigned for vector 0x400
[    0.354262] [      T1] perf: AMD IBS detected (0x000003ff)
[    0.355294] [     T24] amd_uncore: 4 amd_df counters detected
[    0.355301] [     T24] amd_uncore: 6 amd_l3 counters detected
[    0.356264] [      T1] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, =
4 counters/bank).
[    0.357352] [      T1] Initialise system trusted keyrings
[    0.357433] [      T1] workingset: timestamp_bits=3D46 max_order=3D24 b=
ucket_order=3D0
[    0.509876] [    T149] Freeing initrd memory: 42152K
[    0.529032] [      T1] Key type asymmetric registered
[    0.529033] [      T1] Asymmetric key parser 'x509' registered
[    0.529059] [      T1] Block layer SCSI generic (bsg) driver version 0.=
4 loaded (major 251)
[    0.529142] [      T1] io scheduler bfq registered
[    0.531301] [      T1] pcieport 0000:00:01.1: PME: Signaling with IRQ 4=
3
[    0.531335] [      T1] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- =
PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPr=
esDis- LLActRep+
[    0.531699] [      T1] pcieport 0000:00:02.1: PME: Signaling with IRQ 4=
4
[    0.531939] [      T1] pcieport 0000:00:02.2: PME: Signaling with IRQ 4=
5
[    0.532168] [      T1] pcieport 0000:00:02.3: PME: Signaling with IRQ 4=
6
[    0.532427] [      T1] pcieport 0000:00:02.4: PME: Signaling with IRQ 4=
7
[    0.532663] [      T1] pcieport 0000:00:08.1: PME: Signaling with IRQ 4=
8
[    0.533324] [      T1] ACPI: video: Video Device [VGA] (multi-head: yes=
  rom: no  post: no)
[    0.533626] [      T1] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBU=
S:00/PNP0A08:00/device:13/LNXVIDEO:00/input/input0
[    0.534109] [     T24] Monitor-Mwait will be used to enter C-1 state
[    0.537069] [      T1] Estimated ratio of average max frequency by base=
 frequency (times 1024): 1226
[    0.537996] [      T1] thermal LNXTHERM:00: registered as thermal_zone0
[    0.537998] [      T1] ACPI: thermal: Thermal Zone [THRM] (60 C)
[    0.538120] [      T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing =
disabled
[    0.538943] [      T1] ACPI: bus type drm_connector registered
[    0.540851] [      T1] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f1=
3:PS2M] at 0x60,0x64 irq 1,12
[    0.544299] [      T1] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.544306] [      T1] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.544611] [      T1] mousedev: PS/2 mouse device common for all mice
[    0.544649] [      T1] rtc_cmos 00:01: RTC can wake from S4
[    0.545116] [      T1] rtc_cmos 00:01: registered as rtc0
[    0.545170] [      T1] rtc_cmos 00:01: setting system clock to 2025-03-=
24T22:29:09 UTC (1742855349)
[    0.545211] [      T1] rtc_cmos 00:01: alarms up to one month, y3k, 114=
 bytes nvram
[    0.547215] [      T1] efifb: probing for efifb
[    0.547244] [      T1] efifb: framebuffer at 0xfe20000000, using 8100k,=
 total 8100k
[    0.547246] [      T1] efifb: mode is 1920x1080x32, linelength=3D7680, =
pages=3D1
[    0.547248] [      T1] efifb: scrolling: redraw
[    0.547248] [      T1] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:=
8:0
[    0.547371] [      T1] Console: switching to colour frame buffer device=
 240x67
[    0.556762] [    T210] input: AT Translated Set 2 keyboard as /devices/=
platform/i8042/serio0/input/input1
[    0.571066] [      T1] fb0: EFI VGA frame buffer device
[    0.571203] [      T1] NET: Registered PF_INET6 protocol family
[    0.574803] [      T1] Segment Routing with IPv6
[    0.574813] [      T1] In-situ OAM (IOAM) with IPv6
[    0.574829] [      T1] mip6: Mobile IPv6
[    0.574832] [      T1] NET: Registered PF_PACKET protocol family
[    0.574893] [      T1] mpls_gso: MPLS GSO support
[    0.577026] [      T1] microcode: Current revision: 0x0a50000c
[    0.577563] [      T1] resctrl: L3 allocation detected
[    0.577565] [      T1] resctrl: MB allocation detected
[    0.577566] [      T1] resctrl: L3 monitoring detected
[    0.577593] [      T1] IPI shorthand broadcast: enabled
[    0.579780] [      T1] sched_clock: Marking stable (578007760, 1224969)=
->(595069949, -15837220)
[    0.579966] [      T1] registered taskstats version 1
[    0.580066] [      T1] Loading compiled-in X.509 certificates
[    0.583277] [      T1] Key type .fscrypt registered
[    0.583278] [      T1] Key type fscrypt-provisioning registered
[    0.583293] [      T1] AppArmor: AppArmor sha256 policy hashing enabled
[    0.586003] [      T1] ACPI BIOS Error (bug): Could not resolve symbol =
[\_SB.PCI0.GP17.MP2], AE_NOT_FOUND (20240827/psargs-332)
[    0.586010] [      T1] ACPI Error: Aborting method \_SB.GPIO._EVT due t=
o previous error (AE_NOT_FOUND) (20240827/psparse-529)
[    0.586064] [      T1] clk: Disabling unused clocks
[    0.586066] [      T1] PM: genpd: Disabling unused power domains
[    0.586766] [      T1] Freeing unused kernel image (initmem) memory: 20=
24K
[    0.586773] [      T1] Write protecting the kernel read-only data: 1843=
2k
[    0.586930] [      T1] Freeing unused kernel image (text/rodata gap) me=
mory: 20K
[    0.587217] [      T1] Freeing unused kernel image (rodata/data gap) me=
mory: 1800K
[    0.632308] [      T1] x86/mm: Checked W+X mappings: passed, no W+X pag=
es found.
[    0.632314] [      T1] Run /init as init process
[    0.632315] [      T1]   with arguments:
[    0.632316] [      T1]     /init
[    0.632318] [      T1]     nokaslr
[    0.632318] [      T1]   with environment:
[    0.632319] [      T1]     HOME=3D/
[    0.632319] [      T1]     TERM=3Dlinux
[    0.632320] [      T1]     BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc7-next-2=
0250321-master
[    0.797653] [    T371] i2c_designware_core: no symbol version for __x86=
_indirect_thunk_rax
[    0.807151] [    T357] piix4_smbus 0000:00:14.0: SMBus Host Controller =
at 0xb00, revision 0
[    0.807155] [    T357] piix4_smbus 0000:00:14.0: Using register 0x02 fo=
r SMBus port selection
[    0.808581] [    T357] i2c i2c-1: Successfully instantiated SPD at 0x50
[    0.809205] [    T357] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host C=
ontroller at 0xb20
[    0.813822] [    T365] hid: raw HID events driver (C) Jiri Kosina
[    0.815168] [    T148] nvme 0000:06:00.0: platform quirk: setting simpl=
e suspend
[    0.815188] [    T150] nvme 0000:07:00.0: platform quirk: setting simpl=
e suspend
[    0.815832] [    T150] nvme nvme1: pci function 0000:07:00.0
[    0.816428] [    T148] nvme nvme0: pci function 0000:06:00.0
[    0.818658] [    T365] pcie_mp2_amd 0000:08:00.7: enabling device (0000=
 -> 0002)
[    0.818950] [    T362] r8169 0000:05:00.0 eth0: RTL8168h/8111h, d8:bb:c=
1:ab:dd:5e, XID 541, IRQ 52
[    0.818953] [    T362] r8169 0000:05:00.0 eth0: jumbo features [frames:=
 9194 bytes, tx checksumming: ko]
[    0.822284] [    T366] ACPI: bus type USB registered
[    0.822320] [    T366] usbcore: registered new interface driver usbfs
[    0.822333] [    T366] usbcore: registered new interface driver hub
[    0.822350] [    T366] usbcore: registered new device driver usb
[    0.822734] [    T150] nvme nvme1: missing or invalid SUBNQN field.
[    0.823850] [    T148] nvme nvme0: D3 entry latency set to 10 seconds
[    0.828279] [    T150] nvme nvme1: 15/0/0 default/read/poll queues
[    0.828379] [    T148] nvme nvme0: 16/0/0 default/read/poll queues
[    0.835058] [    T149]  nvme1n1: p1
[    0.836532] [    T159]  nvme0n1: p1 p2 p3 p4
[    0.838530] [    T364] hid-generic 0020:1022:0001.0001: hidraw0: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.838734] [    T364] hid-generic 0020:1022:0001.0002: hidraw1: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.838855] [    T364] hid-generic 0020:1022:0001.0003: hidraw2: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.838964] [    T364] hid-generic 0020:1022:0001.0004: hidraw3: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.839016] [    T362] r8169 0000:05:00.0 enp5s0: renamed from eth0
[    0.839317] [    T364] hid-generic 0020:1022:0001.0005: hidraw4: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.839590] [    T364] hid-generic 0020:1022:0001.0006: hidraw5: SENSOR=
 HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.985005] [    T148] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/pl=
atform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input5
[    0.985262] [    T148] input: PNP0C50:0e 06CB:7E7E Touchpad as /devices=
/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input=
6
[    0.985502] [    T148] hid-generic 0018:06CB:7E7E.0007: input,hidraw6: =
I2C HID v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[    0.987224] [    T366] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.987233] [    T366] xhci_hcd 0000:08:00.3: new USB bus registered, a=
ssigned bus number 1
[    0.987344] [    T366] xhci_hcd 0000:08:00.3: hcc params 0x0268ffe5 hci=
 version 0x110 quirks 0x0000020000000010
[    0.988190] [    T366] xhci_hcd 0000:08:00.3: xHCI Host Controller
[    0.988195] [    T366] xhci_hcd 0000:08:00.3: new USB bus registered, a=
ssigned bus number 2
[    0.988198] [    T366] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enh=
anced SuperSpeed
[    0.988344] [    T366] usb usb1: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0002, bcdDevice=3D 6.14
[    0.988349] [    T366] usb usb1: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.988352] [    T366] usb usb1: Product: xHCI Host Controller
[    0.988354] [    T366] usb usb1: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.988356] [    T366] usb usb1: SerialNumber: 0000:08:00.3
[    0.988525] [    T390] hid-sensor-hub 0020:1022:0001.0001: hidraw0: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.988830] [    T366] hub 1-0:1.0: USB hub found
[    0.988850] [    T366] hub 1-0:1.0: 4 ports detected
[    0.989077] [    T390] hid-sensor-hub 0020:1022:0001.0002: hidraw1: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.990804] [    T363] hid-sensor-hub 0020:1022:0001.0003: hidraw2: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.991049] [    T390] hid-sensor-hub 0020:1022:0001.0004: hidraw3: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.992381] [    T363] hid-sensor-hub 0020:1022:0001.0005: hidraw4: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.992642] [    T390] hid-sensor-hub 0020:1022:0001.0006: hidraw5: SEN=
SOR HUB HID v0.00 Device [hid-amdsfh 1022:0001] on pcie_mp2_amd
[    0.993484] [    T366] usb usb2: We don't know the algorithms for LPM f=
or this host, disabling LPM.
[    0.993604] [    T366] usb usb2: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0003, bcdDevice=3D 6.14
[    0.993609] [    T366] usb usb2: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.993611] [    T366] usb usb2: Product: xHCI Host Controller
[    0.993612] [    T366] usb usb2: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.993614] [    T366] usb usb2: SerialNumber: 0000:08:00.3
[    0.994031] [    T366] hub 2-0:1.0: USB hub found
[    0.994097] [    T366] hub 2-0:1.0: 2 ports detected
[    0.995605] [    T366] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.995611] [    T366] xhci_hcd 0000:08:00.4: new USB bus registered, a=
ssigned bus number 3
[    0.995695] [    T366] xhci_hcd 0000:08:00.4: hcc params 0x0268ffe5 hci=
 version 0x110 quirks 0x0000020000000010
[    0.996135] [    T366] xhci_hcd 0000:08:00.4: xHCI Host Controller
[    0.996138] [    T366] xhci_hcd 0000:08:00.4: new USB bus registered, a=
ssigned bus number 4
[    0.996141] [    T366] xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enh=
anced SuperSpeed
[    0.996297] [    T366] usb usb3: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0002, bcdDevice=3D 6.14
[    0.996300] [    T366] usb usb3: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.996302] [    T366] usb usb3: Product: xHCI Host Controller
[    0.996303] [    T366] usb usb3: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.996304] [    T366] usb usb3: SerialNumber: 0000:08:00.4
[    0.996500] [    T366] hub 3-0:1.0: USB hub found
[    0.996514] [    T366] hub 3-0:1.0: 4 ports detected
[    0.997678] [    T366] usb usb4: We don't know the algorithms for LPM f=
or this host, disabling LPM.
[    0.997739] [    T366] usb usb4: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0003, bcdDevice=3D 6.14
[    0.997742] [    T366] usb usb4: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
[    0.997743] [    T366] usb usb4: Product: xHCI Host Controller
[    0.997744] [    T366] usb usb4: Manufacturer: Linux 6.14.0-rc7-next-20=
250321-master xhci-hcd
[    0.997745] [    T366] usb usb4: SerialNumber: 0000:08:00.4
[    0.997934] [    T366] hub 4-0:1.0: USB hub found
[    0.997949] [    T366] hub 4-0:1.0: 2 ports detected
[    1.028206] [    T363] input: PNP0C50:0e 06CB:7E7E Mouse as /devices/pl=
atform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input8
[    1.028317] [    T363] input: PNP0C50:0e 06CB:7E7E Touchpad as /devices=
/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0e/0018:06CB:7E7E.0007/input/input=
9
[    1.028467] [    T363] hid-multitouch 0018:06CB:7E7E.0007: input,hidraw=
6: I2C HID v1.00 Mouse [PNP0C50:0e 06CB:7E7E] on i2c-PNP0C50:0e
[    1.231255] [    T177] usb 1-2: new low-speed USB device number 2 using=
 xhci_hcd
[    1.236272] [    T453] usb 3-3: new high-speed USB device number 2 usin=
g xhci_hcd
[    1.313076] [    T348] [drm] amdgpu kernel modesetting enabled.
[    1.313096] [    T348] amdgpu: vga_switcheroo: detected switching metho=
d \_SB_.PCI0.GP17.VGA_.ATPX handle
[    1.313555] [    T348] amdgpu: ATPX version 1, functions 0x00000001
[    1.313605] [    T348] amdgpu: ATPX Hybrid Graphics
[    1.323464] [    T348] amdgpu: Virtual CRAT table created for CPU
[    1.323485] [    T348] amdgpu: Topology: Add CPU node
[    1.323607] [    T348] amdgpu 0000:03:00.0: enabling device (0000 -> 00=
02)
[    1.323648] [    T348] [drm] initializing kernel modesetting (DIMGREY_C=
AVEFISH 0x1002:0x73FF 0x1462:0x1313 0xC3).
[    1.323657] [    T348] [drm] register mmio base: 0xFCA00000
[    1.323658] [    T348] [drm] register mmio size: 1048576
[    1.328126] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 0 <nv_common>
[    1.328128] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 1 <gmc_v10_0>
[    1.328129] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 2 <navi10_ih>
[    1.328130] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 3 <psp>
[    1.328132] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 4 <smu>
[    1.328133] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 5 <dm>
[    1.328134] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 6 <gfx_v10_0>
[    1.328135] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 7 <sdma_v5_2>
[    1.328137] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 8 <vcn_v3_0>
[    1.328138] [    T348] amdgpu 0000:03:00.0: amdgpu: detected ip block n=
umber 9 <jpeg_v3_0>
[    1.328147] [    T348] amdgpu 0000:03:00.0: amdgpu: ACPI VFCT table pre=
sent but broken (too short #2),skipping
[    1.335673] [    T348] amdgpu 0000:03:00.0: amdgpu: Fetched VBIOS from =
ROM BAR
[    1.335675] [    T348] amdgpu: ATOM BIOS: SWBRT77181.001
[    1.343632] [    T348] amdgpu 0000:03:00.0: amdgpu: Trusted Memory Zone=
 (TMZ) feature disabled as experimental (default)
[    1.343641] [    T348] [drm] GPU posting now...
[    1.343709] [    T348] [drm] vm size is 262144 GB, 4 levels, block size=
 is 9-bit, fragment size is 9-bit
[    1.343715] [    T348] amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M 0x00000=
08000000000 - 0x00000081FEFFFFFF (8176M used)
[    1.343717] [    T348] amdgpu 0000:03:00.0: amdgpu: GART: 512M 0x000000=
0000000000 - 0x000000001FFFFFFF
[    1.343725] [    T348] [drm] Detected VRAM RAM=3D8176M, BAR=3D8192M
[    1.343727] [    T348] [drm] RAM width 128bits GDDR6
[    1.343873] [    T348] [drm] amdgpu: 8176M of VRAM memory ready
[    1.343874] [    T348] [drm] amdgpu: 31851M of GTT memory ready.
[    1.343888] [    T348] [drm] GART: num cpu pages 131072, num gpu pages =
131072
[    1.344008] [    T348] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[    1.369256] [    T453] usb 3-3: New USB device found, idVendor=3D0e8d, =
idProduct=3D0608, bcdDevice=3D 1.00
[    1.369259] [    T453] usb 3-3: New USB device strings: Mfr=3D5, Produc=
t=3D6, SerialNumber=3D7
[    1.369260] [    T453] usb 3-3: Product: Wireless_Device
[    1.369261] [    T453] usb 3-3: Manufacturer: MediaTek Inc.
[    1.369262] [    T453] usb 3-3: SerialNumber: 000000000
[    1.370324] [    T177] usb 1-2: New USB device found, idVendor=3D1bcf, =
idProduct=3D08a0, bcdDevice=3D 1.04
[    1.370326] [    T177] usb 1-2: New USB device strings: Mfr=3D0, Produc=
t=3D0, SerialNumber=3D0
[    1.393797] [    T352] input: HID 1bcf:08a0 Mouse as /devices/pci0000:0=
0/0000:00:08.1/0000:08:00.3/usb1/1-2/1-2:1.0/0003:1BCF:08A0.0008/input/inp=
ut11
[    1.394237] [    T352] input: HID 1bcf:08a0 Keyboard as /devices/pci000=
0:00/0000:00:08.1/0000:08:00.3/usb1/1-2/1-2:1.0/0003:1BCF:08A0.0008/input/=
input12
[    1.411263] [    T174] tsc: Refined TSC clocksource calibration: 3193.9=
99 MHz
[    1.411269] [    T174] clocksource: tsc: mask: 0xffffffffffffffff max_c=
ycles: 0x2e0a24cf65f, max_idle_ns: 440795271781 ns
[    1.485343] [    T352] input: HID 1bcf:08a0 as /devices/pci0000:00/0000=
:00:08.1/0000:08:00.3/usb1/1-2/1-2:1.0/0003:1BCF:08A0.0008/input/input13
[    1.485482] [    T352] hid-generic 0003:1BCF:08A0.0008: input,hiddev0,h=
idraw7: USB HID v1.10 Mouse [HID 1bcf:08a0] on usb-0000:08:00.3-2/input0
[    1.485527] [    T352] usbcore: registered new interface driver usbhid
[    1.485528] [    T352] usbhid: USB HID core driver
[    1.488259] [    T453] usb 3-4: new full-speed USB device number 3 usin=
g xhci_hcd
[    1.493267] [    T177] usb 1-4: new high-speed USB device number 3 usin=
g xhci_hcd
[    1.627537] [    T177] usb 1-4: New USB device found, idVendor=3D30c9, =
idProduct=3D0042, bcdDevice=3D 0.03
[    1.627540] [    T177] usb 1-4: New USB device strings: Mfr=3D1, Produc=
t=3D2, SerialNumber=3D3
[    1.627542] [    T177] usb 1-4: Product: Integrated Camera
[    1.627543] [    T177] usb 1-4: Manufacturer: S1F0009330LB620L420004LP
[    1.627544] [    T177] usb 1-4: SerialNumber: SunplusIT Inc
[    1.644267] [    T453] usb 3-4: New USB device found, idVendor=3D1462, =
idProduct=3D1563, bcdDevice=3D 2.00
[    1.644270] [    T453] usb 3-4: New USB device strings: Mfr=3D1, Produc=
t=3D2, SerialNumber=3D3
[    1.644272] [    T453] usb 3-4: Product: MysticLight MS-1563 v0001
[    1.644273] [    T453] usb 3-4: Manufacturer: MSI
[    1.644274] [    T453] usb 3-4: SerialNumber: 2064386A5430
[    1.666157] [    T453] hid-generic 0003:1462:1563.0009: hiddev1,hidraw8=
: USB HID v1.11 Device [MSI MysticLight MS-1563 v0001] on usb-0000:08:00.4=
-4/input0
[    3.635535] [    T348] amdgpu 0000:03:00.0: amdgpu: STB initialized to =
2048 entries
[    3.635622] [    T348] [drm] Loading DMUB firmware via PSP: version=3D0=
x02020020
[    3.635983] [    T348] [drm] use_doorbell being set to: [true]
[    3.635996] [    T348] [drm] use_doorbell being set to: [true]
[    3.636013] [    T348] amdgpu 0000:03:00.0: amdgpu: Found VCN firmware =
Version ENC: 1.33 DEC: 4 VEP: 0 Revision: 3
[    3.798635] [    T348] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[    3.881091] [    T348] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[    3.892389] [    T348] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[    3.892409] [    T348] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D 0x003b3100 (59.49.0)
[    3.892413] [    T348] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[    3.892443] [    T348] amdgpu 0000:03:00.0: amdgpu: use vbios provided =
pptable
[    3.943210] [    T348] amdgpu 0000:03:00.0: amdgpu: SMU is initialized =
successfully!
[    3.943607] [    T348] [drm] Display Core v3.2.325 initialized on DCN 3=
.0.2
[    3.943609] [    T348] [drm] DP-HDMI FRL PCON supported
[    3.944944] [    T348] [drm] DMUB hardware initialized: version=3D0x020=
20020
[    3.978086] [    T348] [drm] kiq ring mec 2 pipe 1 q 0
[    4.015478] [    T348] amdgpu: HMM registered 8176MB device memory
[    4.016729] [    T348] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    4.016744] [    T348] kfd kfd: amdgpu: Total number of KFD nodes to be=
 created: 1
[    4.016963] [    T348] amdgpu: Virtual CRAT table created for GPU
[    4.017238] [    T348] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
[    4.017240] [    T348] kfd kfd: amdgpu: added device 1002:73ff
[    4.017283] [    T348] amdgpu 0000:03:00.0: amdgpu: SE 2, SH per SE 2, =
CU per SH 8, active_cu_number 28
[    4.017288] [    T348] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses=
 VM inv eng 0 on hub 0
[    4.017289] [    T348] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses=
 VM inv eng 1 on hub 0
[    4.017290] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 4 on hub 0
[    4.017291] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 5 on hub 0
[    4.017292] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 6 on hub 0
[    4.017293] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 7 on hub 0
[    4.017295] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 8 on hub 0
[    4.017296] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 9 on hub 0
[    4.017297] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 10 on hub 0
[    4.017298] [    T348] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 11 on hub 0
[    4.017299] [    T348] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 12 on hub 0
[    4.017300] [    T348] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM =
inv eng 13 on hub 0
[    4.017301] [    T348] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM =
inv eng 14 on hub 0
[    4.017302] [    T348] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses=
 VM inv eng 0 on hub 8
[    4.017303] [    T348] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 us=
es VM inv eng 1 on hub 8
[    4.017304] [    T348] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 us=
es VM inv eng 4 on hub 8
[    4.017305] [    T348] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 5 on hub 8
[    4.018375] [    T348] amdgpu 0000:03:00.0: amdgpu: Using BOCO for runt=
ime pm
[    4.025873] [    T348] [drm] Initialized amdgpu 3.63.0 for 0000:03:00.0=
 on minor 0
[    4.029084] [    T348] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[    4.029102] [    T348] [drm] pre_validate_dsc:1601 MST_DSC dsc precompu=
te is not needed
[    4.029362] [    T348] amdgpu 0000:08:00.0: enabling device (0006 -> 00=
07)
[    4.029409] [    T348] [drm] initializing kernel modesetting (RENOIR 0x=
1002:0x1638 0x1462:0x1313 0xC5).
[    4.029424] [    T348] [drm] register mmio base: 0xFC900000
[    4.029424] [    T348] [drm] register mmio size: 524288
[    4.032660] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 0 <soc15_common>
[    4.032662] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 1 <gmc_v9_0>
[    4.032664] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 2 <vega10_ih>
[    4.032665] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 3 <psp>
[    4.032666] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 4 <smu>
[    4.032667] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 5 <dm>
[    4.032668] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 6 <gfx_v9_0>
[    4.032670] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 7 <sdma_v4_0>
[    4.032671] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 8 <vcn_v2_0>
[    4.032673] [    T348] amdgpu 0000:08:00.0: amdgpu: detected ip block n=
umber 9 <jpeg_v2_0>
[    4.032680] [    T348] amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from =
VFCT
[    4.032683] [    T348] amdgpu: ATOM BIOS: 113-CEZANNE-018
[    4.036370] [    T348] Console: switching to colour dummy device 80x25
[    4.036391] [    T348] amdgpu 0000:08:00.0: vgaarb: deactivate vga cons=
ole
[    4.036392] [    T348] amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone=
 (TMZ) feature enabled
[    4.036394] [    T348] amdgpu 0000:08:00.0: amdgpu: MODE2 reset
[    4.036971] [    T348] [drm] vm size is 262144 GB, 4 levels, block size=
 is 9-bit, fragment size is 9-bit
[    4.036975] [    T348] amdgpu 0000:08:00.0: amdgpu: VRAM: 512M 0x000000=
F400000000 - 0x000000F41FFFFFFF (512M used)
[    4.036977] [    T348] amdgpu 0000:08:00.0: amdgpu: GART: 1024M 0x00000=
00000000000 - 0x000000003FFFFFFF
[    4.036982] [    T348] [drm] Detected VRAM RAM=3D512M, BAR=3D512M
[    4.036983] [    T348] [drm] RAM width 128bits DDR4
[    4.037095] [    T348] [drm] amdgpu: 512M of VRAM memory ready
[    4.037097] [    T348] [drm] amdgpu: 31851M of GTT memory ready.
[    4.037109] [    T348] [drm] GART: num cpu pages 262144, num gpu pages =
262144
[    4.037206] [    T348] [drm] PCIE GART of 1024M enabled.
[    4.037207] [    T348] [drm] PTB located at 0x000000F41FC00000
[    4.038379] [    T348] [drm] Loading DMUB firmware via PSP: version=3D0=
x0101002B
[    4.038795] [    T348] amdgpu 0000:08:00.0: amdgpu: Found VCN firmware =
Version ENC: 1.24 DEC: 8 VEP: 0 Revision: 3
[    4.757008] [    T348] amdgpu 0000:08:00.0: amdgpu: reserve 0x400000 fr=
om 0xf41f800000 for PSP TMR
[    4.847654] [    T348] amdgpu 0000:08:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[    4.856470] [    T348] amdgpu 0000:08:00.0: amdgpu: RAP: optional rap t=
a ucode is not available
[    4.856473] [    T348] amdgpu 0000:08:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[    4.856680] [    T348] amdgpu 0000:08:00.0: amdgpu: SMU is initialized =
successfully!
[    4.858710] [    T348] [drm] Display Core v3.2.325 initialized on DCN 2=
.1
[    4.858712] [    T348] [drm] DP-HDMI FRL PCON supported
[    4.859260] [    T348] [drm] DMUB hardware initialized: version=3D0x010=
1002B
[    5.010718] [    T348] [drm] kiq ring mec 2 pipe 1 q 0
[    5.017551] [    T348] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    5.017564] [    T348] kfd kfd: amdgpu: Total number of KFD nodes to be=
 created: 1
[    5.017701] [    T348] amdgpu: Virtual CRAT table created for GPU
[    5.018791] [    T348] amdgpu: Topology: Add dGPU node [0x1638:0x1002]
[    5.018793] [    T348] kfd kfd: amdgpu: added device 1002:1638
[    5.018878] [    T348] amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, =
CU per SH 8, active_cu_number 8
[    5.018881] [    T348] amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM in=
v eng 0 on hub 0
[    5.018883] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 1 on hub 0
[    5.018885] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 4 on hub 0
[    5.018886] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 5 on hub 0
[    5.018887] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 6 on hub 0
[    5.018889] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 7 on hub 0
[    5.018890] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 8 on hub 0
[    5.018892] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 9 on hub 0
[    5.018893] [    T348] amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 10 on hub 0
[    5.018895] [    T348] amdgpu 0000:08:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 11 on hub 0
[    5.018896] [    T348] amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM =
inv eng 0 on hub 8
[    5.018897] [    T348] amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses V=
M inv eng 1 on hub 8
[    5.018899] [    T348] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses =
VM inv eng 4 on hub 8
[    5.018900] [    T348] amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses =
VM inv eng 5 on hub 8
[    5.018902] [    T348] amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 6 on hub 8
[    5.019934] [    T348] amdgpu 0000:08:00.0: amdgpu: Runtime PM not avai=
lable
[    5.020204] [    T348] amdgpu 0000:08:00.0: amdgpu: [drm] Using custom =
brightness curve
[    5.020417] [    T348] [drm] Initialized amdgpu 3.63.0 for 0000:08:00.0=
 on minor 1
[    5.024829] [    T348] fbcon: amdgpudrmfb (fb0) is primary device
[    5.039401] [    T348] Console: switching to colour frame buffer device=
 240x67
[    5.047889] [    T348] amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb fram=
e buffer device
[    5.135209] [    T526] PM: Image not found (code -22)
[    5.202390] [    T539] EXT4-fs (nvme0n1p2): mounted filesystem 73e0f015=
-c115-4eb2-92cb-dbf7da2b6112 ro with ordered data mode. Quota mode: disabl=
ed.
[    5.295157] [      T1] systemd[1]: Inserted module 'autofs4'
[    5.310047] [      T1] systemd[1]: systemd 257.4-3 running in system mo=
de (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUT=
LS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIB=
CRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRE=
NCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UT=
MP +SYSVINIT +LIBARCHIVE)
[    5.310053] [      T1] systemd[1]: Detected architecture x86-64.
[    5.311618] [      T1] systemd[1]: Hostname set to <lisa>.
[    5.390507] [      T1] systemd[1]: bpf-restrict-fs: BPF LSM hook not en=
abled in the kernel, BPF LSM not supported.
[    5.582817] [      T1] systemd[1]: Queued start job for default target =
graphical.target.
[    5.601198] [      T1] systemd[1]: Created slice system-getty.slice - S=
lice /system/getty.
[    5.601812] [      T1] systemd[1]: Created slice system-modprobe.slice =
- Slice /system/modprobe.
[    5.602391] [      T1] systemd[1]: Created slice system-systemd\x2dfsck=
.slice - Slice /system/systemd-fsck.
[    5.602794] [      T1] systemd[1]: Created slice user.slice - User and =
Session Slice.
[    5.602882] [      T1] systemd[1]: Started systemd-ask-password-wall.pa=
th - Forward Password Requests to Wall Directory Watch.
[    5.603104] [      T1] systemd[1]: Set up automount proc-sys-fs-binfmt_=
misc.automount - Arbitrary Executable File Formats File System Automount P=
oint.
[    5.603134] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-11b4f8f5\x2d4dc8\x2d43e2\x2da1e9\x2d6693a8a172b6.device - /dev/disk/by-uu=
id/11b4f8f5-4dc8-43e2-a1e9-6693a8a172b6...
[    5.603149] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-33A0\x2d776C.device - /dev/disk/by-uuid/33A0-776C...
[    5.603162] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-85e13cd1\x2d3c57\x2d4343\x2da1f5\x2d6209e530b640.device - /dev/disk/by-uu=
id/85e13cd1-3c57-4343-a1f5-6209e530b640...
[    5.603176] [      T1] systemd[1]: Expecting device dev-disk-by\x2duuid=
-d21e6ad6\x2dbc46\x2d4b61\x2dbc20\x2de4d2f4bf719a.device - /dev/disk/by-uu=
id/d21e6ad6-bc46-4b61-bc20-e4d2f4bf719a...
[    5.603205] [      T1] systemd[1]: Reached target integritysetup.target=
 - Local Integrity Protected Volumes.
[    5.603234] [      T1] systemd[1]: Reached target nss-user-lookup.targe=
t - User and Group Name Lookups.
[    5.603291] [      T1] systemd[1]: Reached target remote-fs.target - Re=
mote File Systems.
[    5.603321] [      T1] systemd[1]: Reached target slices.target - Slice=
 Units.
[    5.603369] [      T1] systemd[1]: Reached target veritysetup.target - =
Local Verity Protected Volumes.
[    5.603484] [      T1] systemd[1]: Listening on dm-event.socket - Devic=
e-mapper event daemon FIFOs.
[    5.603584] [      T1] systemd[1]: Listening on lvm2-lvmpolld.socket - =
LVM2 poll daemon socket.
[    5.603689] [      T1] systemd[1]: Listening on syslog.socket - Syslog =
Socket.
[    5.604429] [      T1] systemd[1]: Listening on systemd-creds.socket - =
Credential Encryption/Decryption.
[    5.604551] [      T1] systemd[1]: Listening on systemd-initctl.socket =
- initctl Compatibility Named Pipe.
[    5.604678] [      T1] systemd[1]: Listening on systemd-journald-dev-lo=
g.socket - Journal Socket (/dev/log).
[    5.604822] [      T1] systemd[1]: Listening on systemd-journald.socket=
 - Journal Sockets.
[    5.604872] [      T1] systemd[1]: systemd-pcrextend.socket - TPM PCR M=
easurements was skipped because of an unmet condition check (ConditionSecu=
rity=3Dmeasured-uki).
[    5.604895] [      T1] systemd[1]: systemd-pcrlock.socket - Make TPM PC=
R Policy was skipped because of an unmet condition check (ConditionSecurit=
y=3Dmeasured-uki).
[    5.605012] [      T1] systemd[1]: Listening on systemd-udevd-control.s=
ocket - udev Control Socket.
[    5.605101] [      T1] systemd[1]: Listening on systemd-udevd-kernel.so=
cket - udev Kernel Socket.
[    5.606556] [      T1] systemd[1]: Mounting dev-hugepages.mount - Huge =
Pages File System...
[    5.607700] [      T1] systemd[1]: Mounting dev-mqueue.mount - POSIX Me=
ssage Queue File System...
[    5.608869] [      T1] systemd[1]: Mounting run-lock.mount - Legacy Loc=
ks Directory /run/lock...
[    5.609953] [      T1] systemd[1]: Mounting sys-kernel-debug.mount - Ke=
rnel Debug File System...
[    5.610039] [      T1] systemd[1]: sys-kernel-tracing.mount - Kernel Tr=
ace File System was skipped because of an unmet condition check (Condition=
PathExists=3D/sys/kernel/tracing).
[    5.611059] [      T1] systemd[1]: Starting blk-availability.service - =
Availability of block devices...
[    5.612552] [      T1] systemd[1]: Starting keyboard-setup.service - Se=
t the console keyboard layout...
[    5.613272] [      T1] systemd[1]: Starting kmod-static-nodes.service -=
 Create List of Static Device Nodes...
[    5.613919] [      T1] systemd[1]: Starting lvm2-monitor.service - Moni=
toring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.=
..
[    5.614673] [      T1] systemd[1]: Starting modprobe@configfs.service -=
 Load Kernel Module configfs...
[    5.615398] [      T1] systemd[1]: Starting modprobe@drm.service - Load=
 Kernel Module drm...
[    5.616345] [      T1] systemd[1]: Starting modprobe@efi_pstore.service=
 - Load Kernel Module efi_pstore...
[    5.617080] [      T1] systemd[1]: Starting modprobe@fuse.service - Loa=
d Kernel Module fuse...
[    5.617859] [      T1] systemd[1]: Starting modprobe@nvme_fabrics.servi=
ce - Load Kernel Module nvme_fabrics...
[    5.617951] [      T1] systemd[1]: systemd-fsck-root.service - File Sys=
tem Check on Root Device was skipped because of an unmet condition check (=
ConditionPathExists=3D!/run/initramfs/fsck-root).
[    5.617996] [      T1] systemd[1]: systemd-hibernate-clear.service - Cl=
ear Stale Hibernate Storage Info was skipped because of an unmet condition=
 check (ConditionPathExists=3D/sys/firmware/efi/efivars/HibernateLocation-=
8cf2644b-4b0b-428f-9387-6d876050dc67).
[    5.619410] [      T1] systemd[1]: Starting systemd-journald.service - =
Journal Service...
[    5.620968] [      T1] systemd[1]: Starting systemd-modules-load.servic=
e - Load Kernel Modules...
[    5.620986] [      T1] systemd[1]: systemd-pcrmachine.service - TPM PCR=
 Machine ID Measurement was skipped because of an unmet condition check (C=
onditionSecurity=3Dmeasured-uki).
[    5.621943] [      T1] systemd[1]: Starting systemd-remount-fs.service =
- Remount Root and Kernel File Systems...
[    5.621985] [      T1] systemd[1]: systemd-tpm2-setup-early.service - E=
arly TPM SRK Setup was skipped because of an unmet condition check (Condit=
ionSecurity=3Dmeasured-uki).
[    5.622822] [      T1] systemd[1]: Starting systemd-udev-load-credentia=
ls.service - Load udev Rules from Credentials...
[    5.623626] [      T1] systemd[1]: Starting systemd-udev-trigger.servic=
e - Coldplug All udev Devices...
[    5.624041] [    T594] pstore: Using crash dump compression: deflate
[    5.625376] [    T594] pstore: Registered efi_pstore as persistent stor=
e backend
[    5.625771] [      T1] systemd[1]: Mounted dev-hugepages.mount - Huge P=
ages File System.
[    5.625891] [      T1] systemd[1]: Mounted dev-mqueue.mount - POSIX Mes=
sage Queue File System.
[    5.625994] [      T1] systemd[1]: Mounted run-lock.mount - Legacy Lock=
s Directory /run/lock.
[    5.626101] [      T1] systemd[1]: Mounted sys-kernel-debug.mount - Ker=
nel Debug File System.
[    5.626424] [      T1] systemd[1]: Finished blk-availability.service - =
Availability of block devices.
[    5.626798] [      T1] systemd[1]: Finished kmod-static-nodes.service -=
 Create List of Static Device Nodes.
[    5.627044] [      T1] systemd[1]: modprobe@configfs.service: Deactivat=
ed successfully.
[    5.627309] [      T1] systemd[1]: Finished modprobe@configfs.service -=
 Load Kernel Module configfs.
[    5.627569] [      T1] systemd[1]: modprobe@drm.service: Deactivated su=
ccessfully.
[    5.627773] [      T1] systemd[1]: Finished modprobe@drm.service - Load=
 Kernel Module drm.
[    5.628048] [      T1] systemd[1]: modprobe@efi_pstore.service: Deactiv=
ated successfully.
[    5.628298] [      T1] systemd[1]: Finished modprobe@efi_pstore.service=
 - Load Kernel Module efi_pstore.
[    5.628614] [      T1] systemd[1]: modprobe@nvme_fabrics.service: Deact=
ivated successfully.
[    5.628856] [      T1] systemd[1]: Finished modprobe@nvme_fabrics.servi=
ce - Load Kernel Module nvme_fabrics.
[    5.629994] [      T1] systemd[1]: Mounting sys-kernel-config.mount - K=
ernel Configuration File System...
[    5.630886] [      T1] systemd[1]: Starting systemd-tmpfiles-setup-dev-=
early.service - Create Static Device Nodes in /dev gracefully...
[    5.631463] [    T596] fuse: init (API version 7.43)
[    5.633776] [      T1] systemd[1]: modprobe@fuse.service: Deactivated s=
uccessfully.
[    5.634032] [      T1] systemd[1]: Finished modprobe@fuse.service - Loa=
d Kernel Module fuse.
[    5.634943] [      T1] systemd[1]: Mounting sys-fs-fuse-connections.mou=
nt - FUSE Control File System...
[    5.639717] [      T1] systemd[1]: Mounted sys-fs-fuse-connections.moun=
t - FUSE Control File System.
[    5.646387] [    T616] EXT4-fs (nvme0n1p2): re-mounted 73e0f015-c115-4e=
b2-92cb-dbf7da2b6112 r/w. Quota mode: disabled.
[    5.647393] [      T1] systemd[1]: Finished systemd-remount-fs.service =
- Remount Root and Kernel File Systems.
[    5.648303] [      T1] systemd[1]: Mounted sys-kernel-config.mount - Ke=
rnel Configuration File System.
[    5.648640] [      T1] systemd[1]: systemd-hwdb-update.service - Rebuil=
d Hardware Database was skipped because of an unmet condition check (Condi=
tionNeedsUpdate=3D/etc).
[    5.648683] [      T1] systemd[1]: systemd-pstore.service - Platform Pe=
rsistent Storage Archival was skipped because of an unmet condition check =
(ConditionDirectoryNotEmpty=3D/sys/fs/pstore).
[    5.649494] [      T1] systemd[1]: Starting systemd-random-seed.service=
 - Load/Save OS Random Seed...
[    5.649510] [      T1] systemd[1]: systemd-tpm2-setup.service - TPM SRK=
 Setup was skipped because of an unmet condition check (ConditionSecurity=
=3Dmeasured-uki).
[    5.658957] [      T1] systemd[1]: Finished keyboard-setup.service - Se=
t the console keyboard layout.
[    5.659368] [      T1] systemd[1]: Finished systemd-random-seed.service=
 - Load/Save OS Random Seed.
[    5.661714] [    T603] cfg80211: Loading compiled-in X.509 certificates=
 for regulatory database
[    5.669392] [    T603] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    5.669527] [    T603] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7=
ff06c7248db18c600'
[    5.670891] [    T213] cfg80211: loaded regulatory.db is malformed or s=
ignature is missing/invalid
[    5.680395] [      T1] systemd[1]: Finished systemd-udev-load-credentia=
ls.service - Load udev Rules from Credentials.
[    5.680851] [      T1] systemd[1]: Finished lvm2-monitor.service - Moni=
toring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[    5.688161] [    T600] systemd-journald[600]: Collecting audit messages=
 is disabled.
[    5.694465] [      T1] systemd[1]: Finished systemd-tmpfiles-setup-dev-=
early.service - Create Static Device Nodes in /dev gracefully.
[    5.694708] [      T1] systemd[1]: systemd-sysusers.service - Create Sy=
stem Users was skipped because no trigger condition checks were met.
[    5.695667] [      T1] systemd[1]: Starting systemd-tmpfiles-setup-dev.=
service - Create Static Device Nodes in /dev...
[    5.718121] [    T603] mt7921e 0000:04:00.0: enabling device (0000 -> 0=
002)
[    5.725519] [    T603] mt7921e 0000:04:00.0: ASIC revision: 79610010
[    5.768436] [      T1] systemd[1]: Finished systemd-tmpfiles-setup-dev.=
service - Create Static Device Nodes in /dev.
[    5.769623] [      T1] systemd[1]: Starting systemd-udevd.service - Rul=
e-based Manager for Device Events and Files...
[    5.798426] [      T1] systemd[1]: Finished systemd-modules-load.servic=
e - Load Kernel Modules.
[    5.799359] [      T1] systemd[1]: Starting systemd-sysctl.service - Ap=
ply Kernel Variables...
[    5.800385] [    T181] mt7921e 0000:04:00.0: HW/SW Version: 0x8a108a10,=
 Build Time: 20241106151007a

[    5.812501] [    T181] mt7921e 0000:04:00.0: WM Firmware Version: ____0=
10000, Build Time: 20241106151045
[    5.830279] [      T1] systemd[1]: Finished systemd-udev-trigger.servic=
e - Coldplug All udev Devices.
[    5.831485] [      T1] systemd[1]: Starting ifupdown-pre.service - Help=
er to synchronize boot up for ifupdown...
[    5.870366] [      T1] systemd[1]: Finished systemd-sysctl.service - Ap=
ply Kernel Variables.
[    5.870707] [      T1] systemd[1]: Started systemd-journald.service - J=
ournal Service.
[    5.915106] [    T600] systemd-journald[600]: Received client request t=
o flush runtime journal.
[    5.948114] [    T709] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYB=
US:00/PNP0A08:00/device:33/PNP0C09:00/PNP0C0D:00/input/input14
[    5.948431] [    T709] ACPI: button: Lid Switch [LID0]
[    5.948762] [    T709] input: Power Button as /devices/LNXSYSTM:00/LNXS=
YBUS:00/PNP0C0C:00/input/input15
[    5.949158] [    T709] ACPI: button: Power Button [PWRB]
[    5.950403] [    T709] input: Sleep Button as /devices/LNXSYSTM:00/LNXS=
YBUS:00/PNP0C0E:00/input/input16
[    5.951386] [    T709] ACPI: button: Sleep Button [SLPB]
[    5.956575] [    T649] ACPI: AC: AC Adapter [ADP1] (on-line)
[    5.964619] [    T722] ccp 0000:08:00.2: enabling device (0000 -> 0002)
[    5.966285] [    T722] ccp 0000:08:00.2: tee enabled
[    5.966438] [    T722] ccp 0000:08:00.2: psp enabled
[    5.979999] [    T719] MCE: In-kernel MCE decoding enabled.
[    5.986161] [    T664] mc: Linux media interface: v0.10
[    6.055180] [    T758] Adding 75497468k swap on /dev/nvme0n1p3.  Priori=
ty:-2 extents:1 across:75497468k SS
[    6.059435] [    T148] ACPI: battery: Slot [BAT1] (battery present)
[    6.065582] [    T710] input: MSI WMI hotkeys as /devices/virtual/input=
/input17
[    6.066932] [    T682] snd_rn_pci_acp3x 0000:08:00.5: enabling device (=
0000 -> 0002)
[    6.077343] [    T664] videodev: Linux video capture interface: v2.00
[    6.104629] [    T698] Bluetooth: Core ver 2.22
[    6.104654] [    T698] NET: Registered PF_BLUETOOTH protocol family
[    6.104655] [    T698] Bluetooth: HCI device and connection manager ini=
tialized
[    6.104659] [    T698] Bluetooth: HCI socket layer initialized
[    6.104663] [    T698] Bluetooth: L2CAP socket layer initialized
[    6.104668] [    T698] Bluetooth: SCO socket layer initialized
[    6.111552] [    T664] usb 1-4: Found UVC 1.00 device Integrated Camera=
 (30c9:0042)
[    6.115919] [    T698] usbcore: registered new interface driver btusb
[    6.118707] [    T697] snd_hda_intel 0000:03:00.1: enabling device (000=
0 -> 0002)
[    6.118827] [    T697] snd_hda_intel 0000:03:00.1: Handle vga_switchero=
o audio client
[    6.118829] [    T697] snd_hda_intel 0000:03:00.1: Force to non-snoop m=
ode
[    6.118914] [    T697] snd_hda_intel 0000:08:00.1: enabling device (000=
0 -> 0002)
[    6.118958] [    T697] snd_hda_intel 0000:08:00.1: Handle vga_switchero=
o audio client
[    6.119010] [    T697] snd_hda_intel 0000:08:00.6: enabling device (000=
0 -> 0002)
[    6.119028] [    T230] Bluetooth: hci0: HW/SW Version: 0x008a008a, Buil=
d Time: 20241106151414
[    6.128671] [    T713] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (=
ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    6.130743] [    T713] snd_hda_intel 0000:03:00.1: bound 0000:03:00.0 (=
ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    6.135121] [    T664] usbcore: registered new interface driver uvcvide=
o
[    6.136105] [    T800] input: HD-Audio Generic HDMI/DP,pcm=3D3 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input18
[    6.140339] [    T800] input: HD-Audio Generic HDMI/DP,pcm=3D7 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input19
[    6.142668] [    T111] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0=
/input22
[    6.143229] [    T800] input: HD-Audio Generic HDMI/DP,pcm=3D8 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input20
[    6.144431] [    T111] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0=
/input23
[    6.146322] [    T800] input: HD-Audio Generic HDMI/DP,pcm=3D9 as /devi=
ces/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card1/input21
[    6.147907] [    T111] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0=
/input24
[    6.150273] [    T111] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/=
pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card0=
/input25
[    6.150412] [    T111] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices=
/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.1/sound/card=
0/input26
[    6.151233] [    T707] snd_hda_codec_realtek hdaudioC2D0: autoconfig fo=
r ALC233: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    6.151237] [    T707] snd_hda_codec_realtek hdaudioC2D0:    speaker_ou=
ts=3D0 (0x0/0x0/0x0/0x0/0x0)
[    6.151240] [    T707] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=3D=
1 (0x21/0x0/0x0/0x0/0x0)
[    6.151242] [    T707] snd_hda_codec_realtek hdaudioC2D0:    mono: mono=
_out=3D0x0
[    6.151243] [    T707] snd_hda_codec_realtek hdaudioC2D0:    inputs:
[    6.151245] [    T707] snd_hda_codec_realtek hdaudioC2D0:      Mic=3D0x=
19
[    6.195318] [    T794] input: HD-Audio Generic Mic as /devices/pci0000:=
00/0000:00:08.1/0000:08:00.6/sound/card2/input27
[    6.195465] [    T794] input: HD-Audio Generic Headphone as /devices/pc=
i0000:00/0000:00:08.1/0000:08:00.6/sound/card2/input28
[    6.267081] [    T230] Bluetooth: hci0: Device setup in 147580 usecs
[    6.267086] [    T230] Bluetooth: hci0: HCI Enhanced Setup Synchronous =
Connection command is advertised, but not supported.
[    6.677070] [    T888] EXT4-fs (nvme1n1p1): mounted filesystem 85e13cd1=
-3c57-4343-a1f5-6209e530b640 r/w with ordered data mode. Quota mode: disab=
led.
[    6.684262] [    T887] EXT4-fs (nvme0n1p4): mounted filesystem d21e6ad6=
-bc46-4b61-bc20-e4d2f4bf719a r/w with ordered data mode. Quota mode: disab=
led.
[    6.695485] [    T394] psmouse serio1: Failed to deactivate mouse on is=
a0060/serio1: -71
[    6.740212] [    T165] audit: type=3D1400 audit(1742855355.693:2): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
vscode" pid=3D929 comm=3D"apparmor_parser"
[    6.740278] [    T165] audit: type=3D1400 audit(1742855355.694:3): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
chrome" pid=3D927 comm=3D"apparmor_parser"
[    6.740321] [    T165] audit: type=3D1400 audit(1742855355.694:4): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
1password" pid=3D915 comm=3D"apparmor_parser"
[    6.740364] [    T165] audit: type=3D1400 audit(1742855355.694:5): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
QtWebEngineProcess" pid=3D918 comm=3D"apparmor_parser"
[    6.740427] [    T165] audit: type=3D1400 audit(1742855355.694:6): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
ch-checkns" pid=3D925 comm=3D"apparmor_parser"
[    6.740481] [    T165] audit: type=3D1400 audit(1742855355.694:7): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
Discord" pid=3D916 comm=3D"apparmor_parser"
[    6.740532] [    T165] audit: type=3D1400 audit(1742855355.694:8): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
chromium" pid=3D928 comm=3D"apparmor_parser"
[    6.740578] [    T165] audit: type=3D1400 audit(1742855355.694:9): appa=
rmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"=
cam" pid=3D924 comm=3D"apparmor_parser"
[    6.740625] [    T165] audit: type=3D1400 audit(1742855355.694:10): app=
armor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D=
"busybox" pid=3D923 comm=3D"apparmor_parser"
[    6.740681] [    T165] audit: type=3D1400 audit(1742855355.694:11): app=
armor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D=
"crun" pid=3D930 comm=3D"apparmor_parser"
[    6.795287] [    T394] psmouse serio1: Failed to enable mouse on isa006=
0/serio1
[    6.884521] [   T1058] nvme nvme0: using unchecked data buffer
[    6.989698] [   T1144] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    6.989701] [   T1144] Bluetooth: BNEP filters: protocol multicast
[    6.989704] [   T1144] Bluetooth: BNEP socket layer initialized
[    6.990841] [   T1033] Bluetooth: MGMT ver 1.23
[    6.998241] [   T1146] Bluetooth: RFCOMM TTY layer initialized
[    6.998270] [   T1146] Bluetooth: RFCOMM socket layer initialized
[    6.998284] [   T1146] Bluetooth: RFCOMM ver 1.11
[    7.318373] [   T1068] block nvme0n1: No UUID available providing old N=
GUID
[    7.329292] [   T1113] Generic FE-GE Realtek PHY r8169-0-500:00: attach=
ed PHY driver (mii_bus:phy_addr=3Dr8169-0-500:00, irq=3DMAC)
[    7.457484] [    T209] r8169 0000:05:00.0 enp5s0: Link is Down
[    7.483625] [    T713] mt7921e 0000:04:00.0 wlp4s0: renamed from wlan0
[    7.549964] [     C14] clocksource: timekeeping watchdog on CPU14: Mark=
ing clocksource 'tsc' as unstable because the skew is too large:
[    7.549967] [     C14] clocksource:                       'hpet' wd_nse=
c: 504994210 wd_now: 66d0d66 wd_last: 5feb8e0 mask: ffffffff
[    7.549970] [     C14] clocksource:                       'tsc' cs_nsec=
: 506694637 cs_now: 14e13fd000 cs_last: 1480c94340 mask: ffffffffffffffff
[    7.549971] [     C14] clocksource:                       Clocksource '=
tsc' skewed 1700427 ns (1 ms) over watchdog 'hpet' interval of 504994210 n=
s (504 ms)
[    7.549973] [     C14] clocksource:                       'hpet' (not '=
tsc') is current clocksource.
[    7.549976] [     C14] tsc: Marking TSC unstable due to clocksource wat=
chdog
[    7.549987] [    T209] TSC found unstable after boot, most likely due t=
o broken BIOS. Use 'tsc=3Dunstable'.
[    7.549988] [    T209] sched_clock: Marking unstable (7547041393, 12249=
69)<-(7565824048, -15837220)
[    7.926772] [    T394] input: PS/2 Generic Mouse as /devices/platform/i=
8042/serio1/input/input4
[    7.993012] [    T394] psmouse serio1: Failed to enable mouse on isa006=
0/serio1
[   10.440288] [   T1114] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (loc=
al address=3Dc8:94:02:c1:bd:69)
[   10.938920] [   T1114] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[   10.960144] [    T159] wlp4s0: authenticated
[   10.961252] [    T159] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/=
3)
[   11.014612] [    T159] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2 (cap=
ab=3D0x511 status=3D0 aid=3D1)
[   11.019986] [    T159] wlp4s0: associated
[   12.043753] [    T147] wlp4s0: deauthenticated from 54:67:51:3d:a2:d2 (=
Reason: 15=3D4WAY_HANDSHAKE_TIMEOUT)
[   12.404637] [   T1114] wlp4s0: authenticate with 54:67:51:3d:a2:e0 (loc=
al address=3Dc8:94:02:c1:bd:69)
[   12.518688] [   T1114] wlp4s0: send auth to 54:67:51:3d:a2:e0 (try 1/3)
[   12.520882] [    T147] wlp4s0: authenticated
[   12.521262] [    T147] wlp4s0: associate with 54:67:51:3d:a2:e0 (try 1/=
3)
[   12.534024] [    T149] wlp4s0: RX AssocResp from 54:67:51:3d:a2:e0 (cap=
ab=3D0x1411 status=3D17 aid=3D1)
[   12.534028] [    T149] wlp4s0: 54:67:51:3d:a2:e0 denied association (co=
de=3D17)
[   15.645845] [   T1114] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (loc=
al address=3Dc8:94:02:c1:bd:69)
[   15.655782] [   T1114] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
[   15.657032] [    T147] wlp4s0: authenticated
[   15.658276] [    T147] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/=
3)
[   15.707126] [    T147] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2 (cap=
ab=3D0x511 status=3D0 aid=3D1)
[   15.712238] [    T147] wlp4s0: associated
[   24.612671] [    T149] pci_bus 0000:03: Allocating resources
[   24.613050] [    T210] [drm] PCIE GART of 512M enabled (table at 0x0000=
0081FEB00000).
[   24.613081] [    T210] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[   24.788430] [    T210] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 fr=
om 0x81fd000000 for PSP TMR
[   24.871501] [    T210] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras t=
a ucode is not available
[   24.882772] [    T210] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: secu=
redisplay ta ucode is not available
[   24.882777] [    T210] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[   24.882781] [    T210] amdgpu 0000:03:00.0: amdgpu: smu driver if versi=
on =3D 0x0000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0,=
 version =3D 0x003b3100 (59.49.0)
[   24.882785] [    T210] amdgpu 0000:03:00.0: amdgpu: SMU driver if versi=
on not matched
[   24.933894] [    T210] amdgpu 0000:03:00.0: amdgpu: SMU is resumed succ=
essfully!
[   24.935782] [    T210] [drm] kiq ring mec 2 pipe 1 q 0
[   24.942282] [    T210] [drm] DMUB hardware initialized: version=3D0x020=
20020
[   24.960935] [    T210] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes
[   24.960950] [    T210] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses=
 VM inv eng 0 on hub 0
[   24.960951] [    T210] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses=
 VM inv eng 1 on hub 0
[   24.960952] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 use=
s VM inv eng 4 on hub 0
[   24.960954] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 use=
s VM inv eng 5 on hub 0
[   24.960955] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 use=
s VM inv eng 6 on hub 0
[   24.960956] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 use=
s VM inv eng 7 on hub 0
[   24.960957] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 use=
s VM inv eng 8 on hub 0
[   24.960958] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 use=
s VM inv eng 9 on hub 0
[   24.960959] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 use=
s VM inv eng 10 on hub 0
[   24.960960] [    T210] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 use=
s VM inv eng 11 on hub 0
[   24.960961] [    T210] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 us=
es VM inv eng 12 on hub 0
[   24.960962] [    T210] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM =
inv eng 13 on hub 0
[   24.960963] [    T210] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM =
inv eng 14 on hub 0
[   24.960965] [    T210] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses=
 VM inv eng 0 on hub 8
[   24.960966] [    T210] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 us=
es VM inv eng 1 on hub 8
[   24.960967] [    T210] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 us=
es VM inv eng 4 on hub 8
[   24.960968] [    T210] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses =
VM inv eng 5 on hub 8
[   24.964916] [    T210] amdgpu 0000:03:00.0: [drm] Cannot find any crtc =
or sizes


Bert Karwatzki

