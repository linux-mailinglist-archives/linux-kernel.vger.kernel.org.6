Return-Path: <linux-kernel+bounces-536719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CDBA4835F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A309188366A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49126E63B;
	Thu, 27 Feb 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mYn5gddv"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664526E620
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670923; cv=none; b=APXt54qkbkTDKeT/ZtQFDkPrvtbX9B03bmeew6V50y0lu/HlnwvRCHWsiVRHBj/0+AKB2ZphhOv3McUkcYVxRvv+NtZVT1BAd03xfh7J7Idxc+riNMz2HsuQh3hFzz4fHKVRtH8IiC2RkjfyZqfDXxxkd2vizhFfbKz0G5jPyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670923; c=relaxed/simple;
	bh=/pH/AP2pDhWaRgVtZJC8/LEMe2tRFFXiquD9vYJ4inQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NJ6h7JHiWqlXECnPL556kCBCmXUTEa1R26UHga+YyuT+ldftycXSp2lssgpLDWjVbn/+Xb0rHO/aYAGQ7MN6ULKNnNdtqvppibKCfuNmj5pofIK5AzMnqiqvn8MDUWogJxIlfXScUcCos8JhVdIv6QfSfSnQGoEUwUkBe5U9C+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mYn5gddv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51RFfQDe2206762
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Feb 2025 07:41:26 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51RFfQDe2206762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740670887;
	bh=miBXCNSq5FF5x5V3+N1fWs3Zi52js77/5lX7Im9Fwko=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=mYn5gddvjraUbbzXZOxVSAKZGp8IRRXcIYnF/LPkdM6JdWRusMfewBnRuy7xjjdZl
	 ciW6HUS+kh48rU44to4qE1DygEMnXPYB5kUd9YiWW4lmGScwWWmx8MKZEdRD/gKsGx
	 PI+eJUstuovSremv/Kfirbm0rbiuT3MqsIrvyalHLCmmmL2/pZ1FcrTySdov1EP0zY
	 60O0hGm9Bvk9v49psQUV19z+G+7G5o42ZupLm3hVjY+DayLeaCEHWfRfSVb7JJdw4+
	 dOKcMpD4mQnzlMWKx4qguZ0Os/ft4qyEV6h7TflbrkQue3AD+k2fOw3g64kdvcId+s
	 EZ+W/nZ7YS2Pw==
Date: Thu, 27 Feb 2025 07:41:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 05/10] x86: remove HIGHMEM64G support
User-Agent: K-9 Mail for Android
In-Reply-To: <20250226213714.4040853-6-arnd@kernel.org>
References: <20250226213714.4040853-1-arnd@kernel.org> <20250226213714.4040853-6-arnd@kernel.org>
Message-ID: <572DCA31-1CCA-45FB-ADCD-29C24A527437@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 26, 2025 1:37:09 PM PST, Arnd Bergmann <arnd@kernel=2Eorg> wrot=
e:
>From: Arnd Bergmann <arnd@arndb=2Ede>
>
>The HIGHMEM64G support was added in linux-2=2E3=2E25 to support (then)
>high-end Pentium Pro and Pentium III Xeon servers with more than 4GB of
>addressing, NUMA and PCI-X slots started appearing=2E
>
>I have found no evidence of this ever being used in regular dual-socket
>servers or consumer devices, all the users seem obsolete these days,
>even by i386 standards:
>
> - Support for NUMA servers (NUMA-Q, IBM x440, unisys) was already
>   removed ten years ago=2E
>
> - 4+ socket non-NUMA servers based on Intel 450GX/450NX, HP F8 and
>   ServerWorks ServerSet/GrandChampion could theoretically still work
>   with 8GB, but these were exceptionally rare even 20 years ago and
>   would have usually been equipped with than the maximum amount of
>   RAM=2E
>
> - Some SKUs of the Celeron D from 2004 had 64-bit mode fused off but
>   could still work in a Socket 775 mainboard designed for the later
>   Core 2 Duo and 8GB=2E Apparently most BIOSes at the time only allowed
>   64-bit CPUs=2E
>
> - The rare Xeon LV "Sossaman" came on a few motherboards with
>   registered DDR2 memory support up to 16GB=2E
>
> - In the early days of x86-64 hardware, there was sometimes the need
>   to run a 32-bit kernel to work around bugs in the hardware drivers,
>   or in the syscall emulation for 32-bit userspace=2E This likely still
>   works but there should never be a need for this any more=2E
>
>PAE mode is still required to get access to the 'NX' bit on Atom
>'Pentium M' and 'Core Duo' CPUs=2E
>
>Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>---
> Documentation/admin-guide/kdump/kdump=2Erst     |  4 --
> Documentation/arch/x86/usb-legacy-support=2Erst | 11 +----
> arch/x86/Kconfig                              | 46 +++----------------
> arch/x86/configs/xen=2Econfig                   |  2 -
> arch/x86/include/asm/page_32_types=2Eh          |  4 +-
> arch/x86/mm/init_32=2Ec                         |  9 +---
> 6 files changed, 11 insertions(+), 65 deletions(-)
>
>diff --git a/Documentation/admin-guide/kdump/kdump=2Erst b/Documentation/=
admin-guide/kdump/kdump=2Erst
>index 5376890adbeb=2E=2E1f7f14c6e184 100644
>--- a/Documentation/admin-guide/kdump/kdump=2Erst
>+++ b/Documentation/admin-guide/kdump/kdump=2Erst
>@@ -180,10 +180,6 @@ Dump-capture kernel config options (Arch Dependent, =
i386 and x86_64)
> 1) On i386, enable high memory support under "Processor type and
>    features"::
>=20
>-	CONFIG_HIGHMEM64G=3Dy
>-
>-   or::
>-
> 	CONFIG_HIGHMEM4G
>=20
> 2) With CONFIG_SMP=3Dy, usually nr_cpus=3D1 need specified on the kernel
>diff --git a/Documentation/arch/x86/usb-legacy-support=2Erst b/Documentat=
ion/arch/x86/usb-legacy-support=2Erst
>index e01c08b7c981=2E=2Eb17bf122270a 100644
>--- a/Documentation/arch/x86/usb-legacy-support=2Erst
>+++ b/Documentation/arch/x86/usb-legacy-support=2Erst
>@@ -20,11 +20,7 @@ It has several drawbacks, though:
>    features (wheel, extra buttons, touchpad mode) of the real PS/2 mouse=
 may
>    not be available=2E
>=20
>-2) If CONFIG_HIGHMEM64G is enabled, the PS/2 mouse emulation can cause
>-   system crashes, because the SMM BIOS is not expecting to be in PAE mo=
de=2E
>-   The Intel E7505 is a typical machine where this happens=2E
>-
>-3) If AMD64 64-bit mode is enabled, again system crashes often happen,
>+2) If AMD64 64-bit mode is enabled, again system crashes often happen,
>    because the SMM BIOS isn't expecting the CPU to be in 64-bit mode=2E =
 The
>    BIOS manufacturers only test with Windows, and Windows doesn't do 64-=
bit
>    yet=2E
>@@ -38,11 +34,6 @@ Problem 1)
>   compiled-in, too=2E
>=20
> Problem 2)
>-  can currently only be solved by either disabling HIGHMEM64G
>-  in the kernel config or USB Legacy support in the BIOS=2E A BIOS updat=
e
>-  could help, but so far no such update exists=2E
>-
>-Problem 3)
>   is usually fixed by a BIOS update=2E Check the board
>   manufacturers web site=2E If an update is not available, disable USB
>   Legacy support in the BIOS=2E If this alone doesn't help, try also add=
ing
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 4a1205b22ae2=2E=2Ed785cb368125 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -1387,15 +1387,11 @@ config X86_CPUID
> 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
> 	  /dev/cpu/31/cpuid=2E
>=20
>-choice
>-	prompt "High Memory Support"
>-	default HIGHMEM4G
>+config HIGHMEM4G
>+	bool "High Memory Support"
> 	depends on X86_32
>-
>-config NOHIGHMEM
>-	bool "off"
> 	help
>-	  Linux can use up to 64 Gigabytes of physical memory on x86 systems=2E
>+	  Linux can use up to 4 Gigabytes of physical memory on x86 systems=2E
> 	  However, the address space of 32-bit x86 processors is only 4
> 	  Gigabytes large=2E That means that, if you have a large amount of
> 	  physical memory, not all of it can be "permanently mapped" by the
>@@ -1411,38 +1407,9 @@ config NOHIGHMEM
> 	  possible=2E
>=20
> 	  If the machine has between 1 and 4 Gigabytes physical RAM, then
>-	  answer "4GB" here=2E
>+	  answer "Y" here=2E
>=20
>-	  If more than 4 Gigabytes is used then answer "64GB" here=2E This
>-	  selection turns Intel PAE (Physical Address Extension) mode on=2E
>-	  PAE implements 3-level paging on IA32 processors=2E PAE is fully
>-	  supported by Linux, PAE mode is implemented on all recent Intel
>-	  processors (Pentium Pro and better)=2E NOTE: If you say "64GB" here,
>-	  then the kernel will not boot on CPUs that don't support PAE!
>-
>-	  The actual amount of total physical memory will either be
>-	  auto detected or can be forced by using a kernel command line option
>-	  such as "mem=3D256M"=2E (Try "man bootparam" or see the documentation=
 of
>-	  your boot loader (lilo or loadlin) about how to pass options to the
>-	  kernel at boot time=2E)
>-
>-	  If unsure, say "off"=2E
>-
>-config HIGHMEM4G
>-	bool "4GB"
>-	help
>-	  Select this if you have a 32-bit processor and between 1 and 4
>-	  gigabytes of physical RAM=2E
>-
>-config HIGHMEM64G
>-	bool "64GB"
>-	depends on X86_HAVE_PAE
>-	select X86_PAE
>-	help
>-	  Select this if you have a 32-bit processor and more than 4
>-	  gigabytes of physical RAM=2E
>-
>-endchoice
>+	  If unsure, say N=2E
>=20
> choice
> 	prompt "Memory split" if EXPERT
>@@ -1488,8 +1455,7 @@ config PAGE_OFFSET
> 	depends on X86_32
>=20
> config HIGHMEM
>-	def_bool y
>-	depends on X86_32 && (HIGHMEM64G || HIGHMEM4G)
>+	def_bool HIGHMEM4G
>=20
> config X86_PAE
> 	bool "PAE (Physical Address Extension) Support"
>diff --git a/arch/x86/configs/xen=2Econfig b/arch/x86/configs/xen=2Econfi=
g
>index 581296255b39=2E=2Ed5d091e03bd3 100644
>--- a/arch/x86/configs/xen=2Econfig
>+++ b/arch/x86/configs/xen=2Econfig
>@@ -1,6 +1,4 @@
> # global x86 required specific stuff
>-# On 32-bit HIGHMEM4G is not allowed
>-CONFIG_HIGHMEM64G=3Dy
> CONFIG_64BIT=3Dy
>=20
> # These enable us to allow some of the
>diff --git a/arch/x86/include/asm/page_32_types=2Eh b/arch/x86/include/as=
m/page_32_types=2Eh
>index faf9cc1c14bb=2E=2E25c32652f404 100644
>--- a/arch/x86/include/asm/page_32_types=2Eh
>+++ b/arch/x86/include/asm/page_32_types=2Eh
>@@ -11,8 +11,8 @@
>  * a virtual address space of one gigabyte, which limits the
>  * amount of physical memory you can use to about 950MB=2E
>  *
>- * If you want more physical memory than this then see the CONFIG_HIGHME=
M4G
>- * and CONFIG_HIGHMEM64G options in the kernel configuration=2E
>+ * If you want more physical memory than this then see the CONFIG_VMSPLI=
T_2G
>+ * and CONFIG_HIGHMEM4G options in the kernel configuration=2E
>  */
> #define __PAGE_OFFSET_BASE	_AC(CONFIG_PAGE_OFFSET, UL)
> #define __PAGE_OFFSET		__PAGE_OFFSET_BASE
>diff --git a/arch/x86/mm/init_32=2Ec b/arch/x86/mm/init_32=2Ec
>index ac41b1e0940d=2E=2Ef288aad8dc74 100644
>--- a/arch/x86/mm/init_32=2Ec
>+++ b/arch/x86/mm/init_32=2Ec
>@@ -582,7 +582,7 @@ static void __init lowmem_pfn_init(void)
> 	"only %luMB highmem pages available, ignoring highmem size of %luMB!\n"
>=20
> #define MSG_HIGHMEM_TRIMMED \
>-	"Warning: only 4GB will be used=2E Use a HIGHMEM64G enabled kernel!\n"
>+	"Warning: only 4GB will be used=2E Support for for CONFIG_HIGHMEM64G wa=
s removed!\n"
> /*
>  * We have more RAM than fits into lowmem - we try to put it into
>  * highmem, also taking the highmem=3Dx boot parameter into account:
>@@ -606,18 +606,13 @@ static void __init highmem_pfn_init(void)
> #ifndef CONFIG_HIGHMEM
> 	/* Maximum memory usable is what is directly addressable */
> 	printk(KERN_WARNING "Warning only %ldMB will be used=2E\n", MAXMEM>>20)=
;
>-	if (max_pfn > MAX_NONPAE_PFN)
>-		printk(KERN_WARNING "Use a HIGHMEM64G enabled kernel=2E\n");
>-	else
>-		printk(KERN_WARNING "Use a HIGHMEM enabled kernel=2E\n");
>+	printk(KERN_WARNING "Use a HIGHMEM enabled kernel=2E\n");
> 	max_pfn =3D MAXMEM_PFN;
> #else /* !CONFIG_HIGHMEM */
>-#ifndef CONFIG_HIGHMEM64G
> 	if (max_pfn > MAX_NONPAE_PFN) {
> 		max_pfn =3D MAX_NONPAE_PFN;
> 		printk(KERN_WARNING MSG_HIGHMEM_TRIMMED);
> 	}
>-#endif /* !CONFIG_HIGHMEM64G */
> #endif /* !CONFIG_HIGHMEM */
> }
>=20

One of the generations of kernel=2Eorg ran on a dual socket system with 6 =
GiB RAM=2E It was a mess; basically it achieved less than 50% memory utiliz=
ation because of highmem=2E

The next generation after that was 64 bits  hardware and software=2E

