Return-Path: <linux-kernel+bounces-331560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D5797AE42
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA251F232C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26263165EE2;
	Tue, 17 Sep 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b="CMETqzVn"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7C16FF44;
	Tue, 17 Sep 2024 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566674; cv=none; b=f0YzQQQMdXyHwwpXnVWDmbMbYkwYdSZ23FTxr+MW/6rpt82+cUW61tNZCX9wMf39UPvKi6l6TRxMLxd+CmseMxQRDo8g64+Xv6TT4MMI4D49EJiT8MReivpiULu1mkSkgfbmvDiXODdaIsfuB/qrsruQJ5zfMTsm4ORmh5OJ7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566674; c=relaxed/simple;
	bh=lUR4hcD/rHw5G5H2VSeRpG/TfeCB6sfAzBL9iYDROio=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IwfIojjHsWvlFG1dFUR9mObKFLNloE52+4IEf/MnGmGejduqNcrRKJbwCM9H+bHP09di5zgyA0cyK7E1Va9dxeZ+O5bE1HRLzvWr25q+B6noxA543Yq6+SFiuF7xXfKZkjDsThwGrJhVb91CaLQpKpTFMZAdINhovHyJgRfPfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de; spf=pass smtp.mailfrom=tuxedo.de; dkim=pass (2048-bit key) header.d=tuxedo.de header.i=@tuxedo.de header.b=CMETqzVn; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuxedo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedo.de
Received: from mail.tuxedocomputers.com (localhost [IPv6:::1])
	(Authenticated sender: cs@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 1BD4F2FC0177;
	Tue, 17 Sep 2024 11:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedo.de; s=default;
	t=1726566655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tyr99nlov4kWMSoICEq41tVbUOGgiT3zYuDe8iETO9Y=;
	b=CMETqzVn/8nIOCj0JPM3bEWs9B45eZkBERWIcnhgg/jpu3qn8j/cfvbaqAv7YgtspP40Br
	E55QIWVMrtqaFryeT43xzaf3TO1mdGAwHyv6FDDCf76hOPRVR2Dk1hMZOEuxeI86aHz/Pd
	eZCcMZ9OyXuYyg2UPwD9q/zCz1xfUz8fIq7a8UshVEwIag5xhdgnL23PfdxEd6Q98e8FcL
	u+RM39Txj8GGMRnXiiCL4mnpWdO2vQX36Ks90umZ8Rvv1dkEHz7zXihop64Xu1zS6y38QJ
	EfPQ4wWn7BtHCVsrSUodcwUA9AHPTQR07h9F2v+KH1ZAZzsGIRf/Z+msXTooPw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 11:50:55 +0200
From: Christoffer Sandberg <cs@tuxedo.de>
To: Jerry Luo <jerryluo225@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Christian Heusel <christian@heusel.eu>,
 Werner Sembach <wse@tuxedocomputers.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
References: <c930b6a6-64e5-498f-b65a-1cd5e0a1d733@heusel.eu>
 <87jzfbh5tu.wl-tiwai@suse.de>
 <66dfd536-ae17-4d75-b514-7931a3734e54@gmail.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <20f70c0a92a27db29f188e05c33ba82c@tuxedo.de>
X-Sender: cs@tuxedo.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 16.9.2024 21:36, Jerry Luo wrote:
> Hi, unfortunately I was unable to reproduce the issue in the last two
> hours, and I wasn't sure what might cause that. The issue was
> reproducible this morning, and I haven't change any system
> configuration after that.
> 
> I will get back to you when the issue reappear.
> 
> Thank you,
> 
> Jerry
> 

 From the dmesg logs it does look like the quirk is applied. Assuming
the pci ids collide between these models (or the model param is used)
which would explain why it gets applied:

1. Does the device have dual speaker pairs? If so (or if in doubt),
    check alsamixer for the codec and play around with the volume knobs
    to see if the controls affect the individual speaker pairs. Or try
    this https://github.com/alsa-project/alsa-ucm-conf/pull/410 to 
control
    both with the system volume control
2. If the device does not have dual speakers the quirk application 
probably
    needs to be extended with DMI specific info to limit it more.

Let me know how it works,

Christoffer

> On 9/16/24 1:22 PM, Takashi Iwai wrote:
>> On Mon, 16 Sep 2024 18:39:40 +0200,
>> Christian Heusel wrote:
>>> Hello everyone,
>>> 
>>> James reports a regression with his System76 Pangolin (pang14) laptop
>>> where the audio became way too loud and 3% loudness sound like 50%
>>> before. The issue initially occurred when updating from 6.10.9 to
>>> 6.10.10. while the rest of the system config stays unchanged.
>>> 
>>> We have bisected the issue together to the following commit:
>>> 
>>>      4178d78cd7a8 ("ALSA: hda/conexant: Add pincfg quirk to enable 
>>> top speakers on Sirius devices")
>>> 
>>> We also verified that the issue is present with the latest linux
>>> mainline kernel (6.11rc7-1 at the time) and that reverting the above
>>> commit on top of mainline fixes the issue.
>>> 
>>> Now looking at the code I do not understand where the issue could be
>>> caused as apparently it just adds a quirk for a totally different
>>> hardware, but maybe you can find out more about this!
>>> 
>>> Attached you can find a dmesg of a working boot (6.11-1.1) which has 
>>> the
>>> patch reverted and a failing boot (6.11.arch1-1). We're happy to test
>>> patches or provide more debug outputs :)
>>> 
>>> Reported-by: Jerry <jerryluo225@gmail.com>
>>> Bisected-by: Christian Heusel <christian@heusel.eu>
>> Could you give alsa-info.sh output from both working and non-working
>> cases?  Run the script with --no-upload option and attach the outputs.
>> 
>> 
>> thanks,
>> 
>> Takashi
>> 
>>> Cheers,
>>> Chris
>>> [    0.000000] Linux version 6.11.0-1.1-mainline-dirty 
>>> (linux-mainline@archlinux) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU 
>>> Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Mon, 16 Sep 2024 00:45:50 
>>> +0000
>>> [    0.000000] Command line: initrd=\initramfs-linux-mainline.img ro 
>>> rd.luks.name=97a0672e-59e7-4e70-94e3-b261fb372de3=root 
>>> rd.luks.name=a17f7cbf-2762-4b33-a2bc-054e1e336a25=root2 
>>> root=/dev/mapper/root rootflags=subvol=root rd.luks.options=discard 
>>> add_efi_memmap quiet splash
>>> [    0.000000] BIOS-provided physical RAM map:
>>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009a7efff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x0000000009a7f000-0x0000000009ffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a23bfff] 
>>> ACPI NVS
>>> [    0.000000] BIOS-e820: [mem 0x000000000a23c000-0x000000008f5d6fff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000008f5d7000-0x0000000092134fff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x0000000092135000-0x00000000921a8fff] 
>>> ACPI data
>>> [    0.000000] BIOS-e820: [mem 0x00000000921a9000-0x000000009721efff] 
>>> ACPI NVS
>>> [    0.000000] BIOS-e820: [mem 0x000000009721f000-0x000000009adfefff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009adff000-0x000000009bff8fff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000009bff9000-0x000000009bffcfff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009bffd000-0x000000009bffefff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000009bfff000-0x000000009cffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009d790000-0x000000009d7effff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009d7f5000-0x000000009fffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083e2fffff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000083f340000-0x00000008801fffff] 
>>> reserved
>>> [    0.000000] NX (Execute Disable) protection: active
>>> [    0.000000] APIC: Static calls initialized
>>> [    0.000000] e820: update [mem 0x8820f018-0x88212057] usable ==> 
>>> usable
>>> [    0.000000] extended physical RAM map:
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000000000000-0x000000000009ffff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000000a0000-0x00000000000fffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000000100000-0x0000000009a7efff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000009a7f000-0x0000000009ffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000000a000000-0x000000000a1fffff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000000a200000-0x000000000a23bfff] ACPI NVS
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000000a23c000-0x000000008820f017] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000008820f018-0x0000000088212057] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000088212058-0x000000008f5d6fff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000008f5d7000-0x0000000092134fff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000092135000-0x00000000921a8fff] ACPI data
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000921a9000-0x000000009721efff] ACPI NVS
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009721f000-0x000000009adfefff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009adff000-0x000000009bff8fff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009bff9000-0x000000009bffcfff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009bffd000-0x000000009bffefff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009bfff000-0x000000009cffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009d790000-0x000000009d7effff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009d7f5000-0x000000009fffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000e0000000-0x00000000efffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000fd000000-0x00000000ffffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000100000000-0x000000083e2fffff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000083f340000-0x00000008801fffff] reserved
>>> [    0.000000] efi: EFI v2.8 by American Megatrends
>>> [    0.000000] efi: ACPI=0x97205000 ACPI 2.0=0x97205014 
>>> TPMFinalLog=0x971d4000 SMBIOS=0x9ab7c000 SMBIOS 3.0=0x9ab7b000 
>>> MEMATTR=0x88238018 ESRT=0x8e5c6b98 RNG=0x9214bf18 INITRD=0x8823a998 
>>> TPMEventLog=0x88213018
>>> [    0.000000] random: crng init done
>>> [    0.000000] efi: Remove mem55: MMIO range=[0xe0000000-0xefffffff] 
>>> (256MB) from e820 map
>>> [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
>>> [    0.000000] efi: Remove mem56: MMIO range=[0xfd000000-0xfedfffff] 
>>> (30MB) from e820 map
>>> [    0.000000] e820: remove [mem 0xfd000000-0xfedfffff] reserved
>>> [    0.000000] efi: Not removing mem57: MMIO 
>>> range=[0xfee00000-0xfee00fff] (4KB) from e820 map
>>> [    0.000000] efi: Remove mem58: MMIO range=[0xfee01000-0xffffffff] 
>>> (17MB) from e820 map
>>> [    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
>>> [    0.000000] efi: Remove mem60: MMIO 
>>> range=[0x860000000-0x8801fffff] (514MB) from e820 map
>>> [    0.000000] e820: remove [mem 0x860000000-0x8801fffff] reserved
>>> [    0.000000] SMBIOS 3.5.0 present.
>>> [    0.000000] DMI: System76 Pangolin/Pangolin, BIOS 
>>> APX928_V00.01_T0008ASY1_ms 09/27/2023
>>> [    0.000000] DMI: Memory slots populated: 4/4
>>> [    0.000000] tsc: Fast TSC calibration using PIT
>>> [    0.000000] tsc: Detected 3293.750 MHz processor
>>> [    0.000074] e820: update [mem 0x00000000-0x00000fff] usable ==> 
>>> reserved
>>> [    0.000076] e820: remove [mem 0x000a0000-0x000fffff] usable
>>> [    0.000082] last_pfn = 0x83e300 max_arch_pfn = 0x400000000
>>> [    0.000089] MTRR map: 5 entries (3 fixed + 2 variable; max 20), 
>>> built from 9 variable MTRRs
>>> [    0.000091] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  
>>> UC- WT
>>> [    0.000321] e820: update [mem 0xa0000000-0xffffffff] usable ==> 
>>> reserved
>>> [    0.000330] last_pfn = 0x9bfff max_arch_pfn = 0x400000000
>>> [    0.004066] esrt: Reserving ESRT space from 0x000000008e5c6b98 to 
>>> 0x000000008e5c6bf8.
>>> [    0.004073] e820: update [mem 0x8e5c6000-0x8e5c6fff] usable ==> 
>>> reserved
>>> [    0.004086] Using GB pages for direct mapping
>>> [    0.004639] Secure boot enabled
>>> [    0.004640] RAMDISK: [mem 0x80432000-0x82f54fff]
>>> [    0.004839] ACPI: Early table checksum verification disabled
>>> [    0.004843] ACPI: RSDP 0x0000000097205014 000024 (v02 ALASKA)
>>> [    0.004847] ACPI: XSDT 0x0000000097204728 000144 (v01 ALASKA A M I 
>>>    01072009 AMI  01000013)
>>> [    0.004852] ACPI: FACP 0x000000009219E000 000114 (v06 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004856] ACPI: DSDT 0x0000000092190000 00DB39 (v02 ALASKA A M I 
>>>    01072009 INTL 20220331)
>>> [    0.004859] ACPI: FACS 0x00000000931C1000 000040
>>> [    0.004861] ACPI: SSDT 0x00000000921A0000 008416 (v02 AMD    
>>> AmdTable 00000002 MSFT 02000002)
>>> [    0.004863] ACPI: SSDT 0x000000009219F000 000221 (v02 ALASKA 
>>> CPUSSDT  01072009 AMI  01072009)
>>> [    0.004865] ACPI: FIDT 0x000000009218F000 00009C (v01 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004866] ACPI: MCFG 0x000000009218E000 00003C (v01 ALASKA A M I 
>>>    01072009 MSFT 00010013)
>>> [    0.004868] ACPI: FPDT 0x000000009218D000 000044 (v01 ALASKA A M I 
>>>    01072009 AMI  01000013)
>>> [    0.004870] ACPI: VFCT 0x0000000092189000 003084 (v01 ALASKA A M I 
>>>    00000001 AMD  33504F47)
>>> [    0.004872] ACPI: BGRT 0x0000000092188000 000038 (v01 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004874] ACPI: TPM2 0x0000000092187000 00004C (v04 ALASKA A M I 
>>>    00000001 AMI  00000000)
>>> [    0.004876] ACPI: SSDT 0x0000000092181000 00547E (v02 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004877] ACPI: CRAT 0x0000000092180000 000EE8 (v01 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004879] ACPI: CDIT 0x000000009217F000 000029 (v01 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004881] ACPI: SSDT 0x000000009217D000 0015C0 (v02 AMD    
>>> CPMDFIG2 00000001 INTL 20220331)
>>> [    0.004883] ACPI: SSDT 0x000000009217A000 002A87 (v02 AMD    
>>> CDFAAIG2 00000001 INTL 20220331)
>>> [    0.004885] ACPI: SSDT 0x0000000092178000 00144D (v02 AMD    
>>> CPMPMF   00000001 INTL 20220331)
>>> [    0.004886] ACPI: SSDT 0x0000000092177000 000CDE (v02 AMD    
>>> OEMACP   00000001 INTL 20220331)
>>> [    0.004888] ACPI: SSDT 0x0000000092176000 000634 (v02 AMD    
>>> OEMPMF   00000001 INTL 20220331)
>>> [    0.004890] ACPI: SSDT 0x000000009216C000 0096F8 (v02 AMD    
>>> CPMCMN   00000001 INTL 20220331)
>>> [    0.004892] ACPI: SSDT 0x000000009216B000 00073F (v02 AMD    NVME  
>>>    00000001 INTL 20220331)
>>> [    0.004893] ACPI: SSDT 0x000000009216A000 00073F (v02 AMD    NVME  
>>>    00000001 INTL 20220331)
>>> [    0.004895] ACPI: SSDT 0x0000000092169000 000952 (v02 AMD    
>>> GpMsSsdt 00000001 INTL 20220331)
>>> [    0.004897] ACPI: SSDT 0x0000000092168000 000057 (v02 AMD    GPP0  
>>>    00000001 INTL 20220331)
>>> [    0.004899] ACPI: SSDT 0x0000000092166000 0017DC (v02 AMD    UPEP  
>>>    00000001 INTL 20220331)
>>> [    0.004901] ACPI: WSMT 0x0000000092165000 000028 (v01 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004902] ACPI: APIC 0x0000000092164000 0000E8 (v05 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004904] ACPI: IVRS 0x0000000092163000 0001A4 (v02 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004906] ACPI: SSDT 0x0000000092162000 00094E (v02 AMD    
>>> CPMMSOSC 00000001 INTL 20220331)
>>> [    0.004908] ACPI: SSDT 0x0000000092161000 000EA5 (v02 AMD    
>>> CPMACPV5 00000001 INTL 20220331)
>>> [    0.004910] ACPI: SSDT 0x0000000092160000 000600 (v02 AMD    
>>> TOUCHPNL 00000001 INTL 20220331)
>>> [    0.004912] ACPI: SSDT 0x000000009215F000 000601 (v02 AMD    
>>> TOUCHPAD 00000001 INTL 20220331)
>>> [    0.004913] ACPI: SSDT 0x000000009215E000 0007D5 (v02 AMD    
>>> THERMAL0 00000001 INTL 20220331)
>>> [    0.004915] ACPI: SSDT 0x000000009215D000 000FEF (v02 AMD    
>>> GPP_PME_ 00000001 INTL 20220331)
>>> [    0.004917] ACPI: SSDT 0x0000000092153000 009837 (v02 AMD    
>>> INTGPP03 00000001 INTL 20220331)
>>> [    0.004919] ACPI: SSDT 0x000000009214E000 004FE3 (v02 AMD    
>>> INTGPP01 00000001 INTL 20220331)
>>> [    0.004920] ACPI: SSDT 0x000000009214D000 000A9F (v02 AMD    
>>> CPMGPIO0 00000001 INTL 20220331)
>>> [    0.004922] ACPI: SSDT 0x000000009214C000 00008D (v02 AMD    
>>> CPMMSLPI 00000001 INTL 20220331)
>>> [    0.004924] ACPI: Reserving FACP table memory at [mem 
>>> 0x9219e000-0x9219e113]
>>> [    0.004925] ACPI: Reserving DSDT table memory at [mem 
>>> 0x92190000-0x9219db38]
>>> [    0.004925] ACPI: Reserving FACS table memory at [mem 
>>> 0x931c1000-0x931c103f]
>>> [    0.004926] ACPI: Reserving SSDT table memory at [mem 
>>> 0x921a0000-0x921a8415]
>>> [    0.004926] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9219f000-0x9219f220]
>>> [    0.004927] ACPI: Reserving FIDT table memory at [mem 
>>> 0x9218f000-0x9218f09b]
>>> [    0.004927] ACPI: Reserving MCFG table memory at [mem 
>>> 0x9218e000-0x9218e03b]
>>> [    0.004928] ACPI: Reserving FPDT table memory at [mem 
>>> 0x9218d000-0x9218d043]
>>> [    0.004928] ACPI: Reserving VFCT table memory at [mem 
>>> 0x92189000-0x9218c083]
>>> [    0.004929] ACPI: Reserving BGRT table memory at [mem 
>>> 0x92188000-0x92188037]
>>> [    0.004929] ACPI: Reserving TPM2 table memory at [mem 
>>> 0x92187000-0x9218704b]
>>> [    0.004930] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92181000-0x9218647d]
>>> [    0.004930] ACPI: Reserving CRAT table memory at [mem 
>>> 0x92180000-0x92180ee7]
>>> [    0.004931] ACPI: Reserving CDIT table memory at [mem 
>>> 0x9217f000-0x9217f028]
>>> [    0.004931] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9217d000-0x9217e5bf]
>>> [    0.004932] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9217a000-0x9217ca86]
>>> [    0.004932] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92178000-0x9217944c]
>>> [    0.004933] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92177000-0x92177cdd]
>>> [    0.004933] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92176000-0x92176633]
>>> [    0.004934] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9216c000-0x921756f7]
>>> [    0.004934] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9216b000-0x9216b73e]
>>> [    0.004935] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9216a000-0x9216a73e]
>>> [    0.004935] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92169000-0x92169951]
>>> [    0.004936] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92168000-0x92168056]
>>> [    0.004936] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92166000-0x921677db]
>>> [    0.004937] ACPI: Reserving WSMT table memory at [mem 
>>> 0x92165000-0x92165027]
>>> [    0.004937] ACPI: Reserving APIC table memory at [mem 
>>> 0x92164000-0x921640e7]
>>> [    0.004938] ACPI: Reserving IVRS table memory at [mem 
>>> 0x92163000-0x921631a3]
>>> [    0.004938] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92162000-0x9216294d]
>>> [    0.004939] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92161000-0x92161ea4]
>>> [    0.004939] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92160000-0x921605ff]
>>> [    0.004940] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9215f000-0x9215f600]
>>> [    0.004940] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9215e000-0x9215e7d4]
>>> [    0.004941] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9215d000-0x9215dfee]
>>> [    0.004941] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92153000-0x9215c836]
>>> [    0.004942] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9214e000-0x92152fe2]
>>> [    0.004942] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9214d000-0x9214da9e]
>>> [    0.004943] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9214c000-0x9214c08c]
>>> [    0.005005] No NUMA configuration found
>>> [    0.005006] Faking a node at [mem 
>>> 0x0000000000000000-0x000000083e2fffff]
>>> [    0.005009] NODE_DATA(0) allocated [mem 0x83e2fb000-0x83e2fffff]
>>> [    0.005051] Zone ranges:
>>> [    0.005052]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>>> [    0.005054]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>>> [    0.005055]   Normal   [mem 0x0000000100000000-0x000000083e2fffff]
>>> [    0.005055]   Device   empty
>>> [    0.005056] Movable zone start for each node
>>> [    0.005057] Early memory node ranges
>>> [    0.005057]   node   0: [mem 
>>> 0x0000000000001000-0x000000000009ffff]
>>> [    0.005058]   node   0: [mem 
>>> 0x0000000000100000-0x0000000009a7efff]
>>> [    0.005059]   node   0: [mem 
>>> 0x000000000a000000-0x000000000a1fffff]
>>> [    0.005060]   node   0: [mem 
>>> 0x000000000a23c000-0x000000008f5d6fff]
>>> [    0.005060]   node   0: [mem 
>>> 0x000000009adff000-0x000000009bff8fff]
>>> [    0.005061]   node   0: [mem 
>>> 0x000000009bffd000-0x000000009bffefff]
>>> [    0.005061]   node   0: [mem 
>>> 0x0000000100000000-0x000000083e2fffff]
>>> [    0.005064] Initmem setup node 0 [mem 
>>> 0x0000000000001000-0x000000083e2fffff]
>>> [    0.005069] On node 0, zone DMA: 1 pages in unavailable ranges
>>> [    0.005082] On node 0, zone DMA: 96 pages in unavailable ranges
>>> [    0.005173] On node 0, zone DMA32: 1409 pages in unavailable 
>>> ranges
>>> [    0.006782] On node 0, zone DMA32: 60 pages in unavailable ranges
>>> [    0.006877] On node 0, zone DMA32: 14376 pages in unavailable 
>>> ranges
>>> [    0.006878] On node 0, zone DMA32: 4 pages in unavailable ranges
>>> [    0.028963] On node 0, zone Normal: 16385 pages in unavailable 
>>> ranges
>>> [    0.029007] On node 0, zone Normal: 7424 pages in unavailable 
>>> ranges
>>> [    0.029304] ACPI: PM-Timer IO Port: 0x808
>>> [    0.029312] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
>>> [    0.029327] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, 
>>> GSI 0-23
>>> [    0.029332] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, 
>>> GSI 24-55
>>> [    0.029334] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl 
>>> dfl)
>>> [    0.029335] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 high 
>>> edge)
>>> [    0.029336] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low 
>>> level)
>>> [    0.029339] ACPI: Using ACPI (MADT) for SMP configuration 
>>> information
>>> [    0.029347] e820: update [mem 0x8748a000-0x87a78fff] usable ==> 
>>> reserved
>>> [    0.029362] CPU topo: Max. logical packages:   1
>>> [    0.029363] CPU topo: Max. logical dies:       1
>>> [    0.029363] CPU topo: Max. dies per package:   1
>>> [    0.029367] CPU topo: Max. threads per core:   2
>>> [    0.029368] CPU topo: Num. cores per package:     8
>>> [    0.029369] CPU topo: Num. threads per package:  16
>>> [    0.029369] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
>>> [    0.029385] PM: hibernation: Registered nosave memory: [mem 
>>> 0x00000000-0x00000fff]
>>> [    0.029386] PM: hibernation: Registered nosave memory: [mem 
>>> 0x000a0000-0x000fffff]
>>> [    0.029388] PM: hibernation: Registered nosave memory: [mem 
>>> 0x09a7f000-0x09ffffff]
>>> [    0.029389] PM: hibernation: Registered nosave memory: [mem 
>>> 0x0a200000-0x0a23bfff]
>>> [    0.029390] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8748a000-0x87a78fff]
>>> [    0.029391] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8820f000-0x8820ffff]
>>> [    0.029392] PM: hibernation: Registered nosave memory: [mem 
>>> 0x88212000-0x88212fff]
>>> [    0.029393] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8e5c6000-0x8e5c6fff]
>>> [    0.029395] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8f5d7000-0x92134fff]
>>> [    0.029395] PM: hibernation: Registered nosave memory: [mem 
>>> 0x92135000-0x921a8fff]
>>> [    0.029395] PM: hibernation: Registered nosave memory: [mem 
>>> 0x921a9000-0x9721efff]
>>> [    0.029396] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9721f000-0x9adfefff]
>>> [    0.029397] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9bff9000-0x9bffcfff]
>>> [    0.029398] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9bfff000-0x9cffffff]
>>> [    0.029398] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d000000-0x9d78ffff]
>>> [    0.029399] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d790000-0x9d7effff]
>>> [    0.029399] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d7f0000-0x9d7f4fff]
>>> [    0.029400] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d7f5000-0x9fffffff]
>>> [    0.029400] PM: hibernation: Registered nosave memory: [mem 
>>> 0xa0000000-0xfedfffff]
>>> [    0.029401] PM: hibernation: Registered nosave memory: [mem 
>>> 0xfee00000-0xfee00fff]
>>> [    0.029401] PM: hibernation: Registered nosave memory: [mem 
>>> 0xfee01000-0xffffffff]
>>> [    0.029402] [mem 0xa0000000-0xfedfffff] available for PCI devices
>>> [    0.029403] Booting paravirtualized kernel on bare hardware
>>> [    0.029406] clocksource: refined-jiffies: mask: 0xffffffff 
>>> max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
>>> [    0.033723] setup_percpu: NR_CPUS:320 nr_cpumask_bits:16 
>>> nr_cpu_ids:16 nr_node_ids:1
>>> [    0.034158] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 
>>> u524288
>>> [    0.034164] pcpu-alloc: s233472 r8192 d28672 u524288 
>>> alloc=1*2097152
>>> [    0.034165] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
>>> [    0.034169] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
>>> [    0.034182] Kernel command line: 
>>> initrd=\initramfs-linux-mainline.img ro 
>>> rd.luks.name=97a0672e-59e7-4e70-94e3-b261fb372de3=root 
>>> rd.luks.name=a17f7cbf-2762-4b33-a2bc-054e1e336a25=root2 
>>> root=/dev/mapper/root rootflags=subvol=root rd.luks.options=discard 
>>> add_efi_memmap quiet splash
>>> [    0.034272] Unknown kernel command line parameters "splash", will 
>>> be passed to user space.
>>> [    0.035998] Dentry cache hash table entries: 4194304 (order: 13, 
>>> 33554432 bytes, linear)
>>> [    0.036632] Inode-cache hash table entries: 2097152 (order: 12, 
>>> 16777216 bytes, linear)
>>> [    0.036716] Fallback order for Node 0: 0
>>> [    0.036722] Built 1 zonelists, mobility grouping on.  Total pages: 
>>> 8185013
>>> [    0.036723] Policy zone: Normal
>>> [    0.036823] mem auto-init: stack:all(zero), heap alloc:on, heap 
>>> free:off
>>> [    0.036870] software IO TLB: area num 16.
>>> [    0.076253] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, 
>>> Nodes=1
>>> [    0.076293] ftrace: allocating 50630 entries in 198 pages
>>> [    0.085606] ftrace: allocated 198 pages with 4 groups
>>> [    0.085665] Dynamic Preempt: full
>>> [    0.085719] rcu: Preemptible hierarchical RCU implementation.
>>> [    0.085720] rcu: 	RCU restricting CPUs from NR_CPUS=320 to 
>>> nr_cpu_ids=16.
>>> [    0.085721] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
>>> [    0.085722] 	Trampoline variant of Tasks RCU enabled.
>>> [    0.085723] 	Rude variant of Tasks RCU enabled.
>>> [    0.085723] 	Tracing variant of Tasks RCU enabled.
>>> [    0.085724] rcu: RCU calculated value of scheduler-enlistment 
>>> delay is 30 jiffies.
>>> [    0.085725] rcu: Adjusting geometry for rcu_fanout_leaf=16, 
>>> nr_cpu_ids=16
>>> [    0.085735] RCU Tasks: Setting shift to 4 and lim to 1 
>>> rcu_task_cb_adjust=1.
>>> [    0.085737] RCU Tasks Rude: Setting shift to 4 and lim to 1 
>>> rcu_task_cb_adjust=1.
>>> [    0.085739] RCU Tasks Trace: Setting shift to 4 and lim to 1 
>>> rcu_task_cb_adjust=1.
>>> [    0.088676] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
>>> [    0.088892] rcu: srcu_init: Setting srcu_struct sizes based on 
>>> contention.
>>> [    0.089072] kfence: initialized - using 2097152 bytes for 255 
>>> objects at 0x(____ptrval____)-0x(____ptrval____)
>>> [    0.089109] Console: colour dummy device 80x25
>>> [    0.089111] printk: legacy console [tty0] enabled
>>> [    0.089149] ACPI: Core revision 20240322
>>> [    0.089349] APIC: Switch to symmetric I/O mode setup
>>> [    0.090137] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, 
>>> rdevid:160
>>> [    0.090139] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, 
>>> rdevid:160
>>> [    0.090140] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, 
>>> rdevid:160
>>> [    0.090141] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, 
>>> rdevid:160
>>> [    0.090141] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, 
>>> EFR2:0x0
>>> [    0.090750] x2apic: IRQ remapping doesn't support X2APIC mode
>>> [    0.090758] APIC: Switched APIC routing to: physical flat
>>> [    0.091551] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>>> [    0.106019] clocksource: tsc-early: mask: 0xffffffffffffffff 
>>> max_cycles: 0x2f7a3c4f274, max_idle_ns: 440795328267 ns
>>> [    0.106024] Calibrating delay loop (skipped), value calculated 
>>> using timer frequency.. 6590.97 BogoMIPS (lpj=10979166)
>>> [    0.106050] x86/cpu: User Mode Instruction Prevention (UMIP) 
>>> activated
>>> [    0.106108] LVT offset 1 assigned for vector 0xf9
>>> [    0.106307] LVT offset 2 assigned for vector 0xf4
>>> [    0.106355] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
>>> [    0.106356] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 
>>> 1GB 0
>>> [    0.106359] process: using mwait in idle threads
>>> [    0.106361] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
>>> __user pointer sanitization
>>> [    0.106364] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
>>> [    0.106365] Spectre V2 : Spectre v2 / SpectreRSB mitigation: 
>>> Filling RSB on context switch
>>> [    0.106368] Spectre V2 : mitigation: Enabling conditional Indirect 
>>> Branch Prediction Barrier
>>> [    0.106369] Spectre V2 : User space: Mitigation: STIBP always-on 
>>> protection
>>> [    0.106371] Speculative Store Bypass: Mitigation: Speculative 
>>> Store Bypass disabled via prctl
>>> [    0.106372] Speculative Return Stack Overflow: IBPB-extending 
>>> microcode not applied!
>>> [    0.106373] Speculative Return Stack Overflow: WARNING: See 
>>> https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for 
>>> mitigation options.
>>> [    0.106374] Speculative Return Stack Overflow: Vulnerable: Safe 
>>> RET, no microcode
>>> [    0.106381] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
>>> point registers'
>>> [    0.106382] x86/fpu: Supporting XSAVE feature 0x002: 'SSE 
>>> registers'
>>> [    0.106383] x86/fpu: Supporting XSAVE feature 0x004: 'AVX 
>>> registers'
>>> [    0.106384] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 
>>> opmask'
>>> [    0.106385] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 
>>> Hi256'
>>> [    0.106385] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 
>>> ZMM_Hi256'
>>> [    0.106386] x86/fpu: Supporting XSAVE feature 0x200: 'Protection 
>>> Keys User registers'
>>> [    0.106387] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow 
>>> User registers'
>>> [    0.106388] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>>> [    0.106389] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
>>> [    0.106390] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
>>> [    0.106391] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
>>> [    0.106391] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
>>> [    0.106392] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   
>>> 16
>>> [    0.106393] x86/fpu: Enabled xstate features 0xae7, context size 
>>> is 2456 bytes, using 'compacted' format.
>>> [    0.133891] Freeing SMP alternatives memory: 40K
>>> [    0.133895] pid_max: default: 32768 minimum: 301
>>> [    0.137478] LSM: initializing 
>>> lsm=capability,landlock,lockdown,yama,bpf
>>> [    0.137508] landlock: Up and running.
>>> [    0.137510] Yama: becoming mindful.
>>> [    0.137515] LSM support for eBPF active
>>> [    0.137564] Mount-cache hash table entries: 65536 (order: 7, 
>>> 524288 bytes, linear)
>>> [    0.137589] Mountpoint-cache hash table entries: 65536 (order: 7, 
>>> 524288 bytes, linear)
>>> [    0.244696] smpboot: CPU0: AMD Ryzen 7 7840U w/ Radeon 780M 
>>> Graphics (family: 0x19, model: 0x74, stepping: 0x1)
>>> [    0.244959] Performance Events: Fam17h+ 16-deep LBR, core perfctr, 
>>> AMD PMU driver.
>>> [    0.244990] ... version:                2
>>> [    0.244992] ... bit width:              48
>>> [    0.244993] ... generic registers:      6
>>> [    0.244994] ... value mask:             0000ffffffffffff
>>> [    0.244995] ... max period:             00007fffffffffff
>>> [    0.244996] ... fixed-purpose events:   0
>>> [    0.244997] ... event mask:             000000000000003f
>>> [    0.245099] signal: max sigframe size: 3376
>>> [    0.245128] rcu: Hierarchical SRCU implementation.
>>> [    0.245129] rcu: 	Max phase no-delay instances is 1000.
>>> [    0.245197] Timer migration: 2 hierarchy levels; 8 children per 
>>> group; 2 crossnode level
>>> [    0.246022] MCE: In-kernel MCE decoding enabled.
>>> [    0.246022] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
>>> counter.
>>> [    0.246022] smp: Bringing up secondary CPUs ...
>>> [    0.246022] smpboot: x86: Booting SMP configuration:
>>> [    0.246022] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7 
>>>  #8  #9 #10 #11 #12 #13 #14 #15
>>> [    0.264691] Spectre V2 : Update user space SMT mitigation: STIBP 
>>> always-on
>>> [    0.279393] smp: Brought up 1 node, 16 CPUs
>>> [    0.279393] smpboot: Total of 16 processors activated (105442.66 
>>> BogoMIPS)
>>> [    0.282874] Memory: 31986756K/32740052K available (18432K kernel 
>>> code, 2187K rwdata, 13520K rodata, 3452K init, 3432K bss, 734332K 
>>> reserved, 0K cma-reserved)
>>> [    0.283301] devtmpfs: initialized
>>> [    0.283301] x86/mm: Memory block size: 128MB
>>> [    0.286869] ACPI: PM: Registering ACPI NVS region [mem 
>>> 0x0a200000-0x0a23bfff] (245760 bytes)
>>> [    0.286869] ACPI: PM: Registering ACPI NVS region [mem 
>>> 0x921a9000-0x9721efff] (84369408 bytes)
>>> [    0.286990] clocksource: jiffies: mask: 0xffffffff max_cycles: 
>>> 0xffffffff, max_idle_ns: 6370867519511994 ns
>>> [    0.287003] futex hash table entries: 4096 (order: 6, 262144 
>>> bytes, linear)
>>> [    0.287083] pinctrl core: initialized pinctrl subsystem
>>> [    0.287216] PM: RTC time: 14:08:12, date: 2024-09-16
>>> [    0.287582] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>>> [    0.287885] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic 
>>> allocations
>>> [    0.288018] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for 
>>> atomic allocations
>>> [    0.288194] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool 
>>> for atomic allocations
>>> [    0.288206] audit: initializing netlink subsys (disabled)
>>> [    0.288217] audit: type=2000 audit(1726495691.196:1): 
>>> state=initialized audit_enabled=0 res=1
>>> [    0.288217] thermal_sys: Registered thermal governor 'fair_share'
>>> [    0.288217] thermal_sys: Registered thermal governor 'bang_bang'
>>> [    0.288217] thermal_sys: Registered thermal governor 'step_wise'
>>> [    0.288217] thermal_sys: Registered thermal governor 'user_space'
>>> [    0.288217] thermal_sys: Registered thermal governor 
>>> 'power_allocator'
>>> [    0.288217] cpuidle: using governor ladder
>>> [    0.288217] cpuidle: using governor menu
>>> [    0.289480] acpiphp: ACPI Hot Plug PCI Controller Driver version: 
>>> 0.5
>>> [    0.289584] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 
>>> 0xe0000000) for domain 0000 [bus 00-ff]
>>> [    0.289602] PCI: Using configuration type 1 for base access
>>> [    0.289772] kprobes: kprobe jump-optimization is enabled. All 
>>> kprobes are optimized if possible.
>>> [    0.296006] HugeTLB: registered 1.00 GiB page size, pre-allocated 
>>> 0 pages
>>> [    0.296006] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB 
>>> page
>>> [    0.296006] HugeTLB: registered 2.00 MiB page size, pre-allocated 
>>> 0 pages
>>> [    0.296006] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB 
>>> page
>>> [    0.296497] ACPI: Added _OSI(Module Device)
>>> [    0.296497] ACPI: Added _OSI(Processor Device)
>>> [    0.296497] ACPI: Added _OSI(3.0 _SCP Extensions)
>>> [    0.296497] ACPI: Added _OSI(Processor Aggregator Device)
>>> [    0.317759] ACPI BIOS Error (bug): Failure creating named object 
>>> [\_SB.PCI0.GPP5.RTL8._RMV], AE_ALREADY_EXISTS (20240322/dswload2-326)
>>> [    0.317767] ACPI Error: AE_ALREADY_EXISTS, During name 
>>> lookup/catalog (20240322/psobject-220)
>>> [    0.317770] ACPI: Skipping parse of AML opcode: Method (0x0014)
>>> [    0.318937] ACPI BIOS Error (bug): Failure creating named object 
>>> [\_SB.I2CA.TPNL], AE_ALREADY_EXISTS (20240322/dswload2-326)
>>> [    0.318942] ACPI Error: AE_ALREADY_EXISTS, During name 
>>> lookup/catalog (20240322/psobject-220)
>>> [    0.318945] ACPI: Skipping parse of AML opcode: Device (0x5B82)
>>> [    0.319062] ACPI BIOS Error (bug): Failure creating named object 
>>> [\_SB.I2CD.TPDD], AE_ALREADY_EXISTS (20240322/dswload2-326)
>>> [    0.319066] ACPI Error: AE_ALREADY_EXISTS, During name 
>>> lookup/catalog (20240322/psobject-220)
>>> [    0.319068] ACPI: Skipping parse of AML opcode: Device (0x5B82)
>>> [    0.324079] ACPI: 25 ACPI AML tables successfully acquired and 
>>> loaded
>>> [    0.330550] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>>> [    0.344641] ACPI: EC: EC started
>>> [    0.344643] ACPI: EC: interrupt blocked
>>> [    0.789510] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>> [    0.789517] ACPI: \_SB_.PCI0.SBRG.H_EC: Boot DSDT EC used to 
>>> handle transactions
>>> [    0.789522] ACPI: Interpreter enabled
>>> [    0.789566] ACPI: PM: (supports S0 S4 S5)
>>> [    0.789570] ACPI: Using IOAPIC for interrupt routing
>>> [    0.792562] PCI: Using host bridge windows from ACPI; if 
>>> necessary, use "pci=nocrs" and report a bug
>>> [    0.792564] PCI: Ignoring E820 reservations for host bridge 
>>> windows
>>> [    0.793364] ACPI: Enabled 4 GPEs in block 00 to 1F
>>> [    0.795307] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
>>> [    0.798105] ACPI: \_SB_.PCI0.GPP8.P0NV: New power resource
>>> [    0.799857] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
>>> [    0.800832] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
>>> [    0.801725] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
>>> [    0.802694] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
>>> [    0.803064] ACPI: \_SB_.PCI0.GP17.PWRS: New power resource
>>> [    0.803451] ACPI: \_SB_.PCI0.GP17.VGA_.PWRS: New power resource
>>> [    0.803920] ACPI: \_SB_.PCI0.GP17.HDAU.PWRS: New power resource
>>> [    0.804313] ACPI: \_SB_.PCI0.GP17.ACP_.PWRS: New power resource
>>> [    0.805182] ACPI: \_SB_.PCI0.GP17.AZAL.PWRS: New power resource
>>> [    0.806119] ACPI: \_SB_.PCI0.GP17.XHC0.PWRS: New power resource
>>> [    0.809357] ACPI: \_SB_.PCI0.GP17.XHC1.PWRS: New power resource
>>> [    0.809368] ACPI: \_SB_.PCI0.GP19.XHC2.PWRS: New power resource
>>> [    0.810549] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
>>> [    0.811913] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
>>> [    0.813283] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
>>> [    0.814212] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
>>> [    0.830740] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>>> [    0.830747] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig 
>>> ASPM ClockPM Segments MSI EDR HPX-Type3]
>>> [    0.830886] acpi PNP0A08:00: _OSC: platform does not support 
>>> [SHPCHotplug AER LTR DPC]
>>> [    0.831141] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug 
>>> PME PCIeCapability]
>>> [    0.831990] PCI host bridge to bus 0000:00
>>> [    0.831995] pci_bus 0000:00: root bus resource [io  0x0000-0x03af 
>>> window]
>>> [    0.831997] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 
>>> window]
>>> [    0.831999] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df 
>>> window]
>>> [    0.832001] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff 
>>> window]
>>> [    0.832002] pci_bus 0000:00: root bus resource [mem 
>>> 0x000a0000-0x000dffff window]
>>> [    0.832004] pci_bus 0000:00: root bus resource [mem 
>>> 0xfa000000-0xfcffffff window]
>>> [    0.832006] pci_bus 0000:00: root bus resource [mem 
>>> 0xf0000000-0xf9ffffff window]
>>> [    0.832007] pci_bus 0000:00: root bus resource [mem 
>>> 0xa0000000-0xdfffffff window]
>>> [    0.832009] pci_bus 0000:00: root bus resource [mem 
>>> 0x860000000-0x7fffffffff window]
>>> [    0.832011] pci_bus 0000:00: root bus resource [bus 00-ff]
>>> [    0.832028] pci 0000:00:00.0: [1022:14e8] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.832154] pci 0000:00:00.2: [1022:14e9] type 00 class 0x080600 
>>> conventional PCI endpoint
>>> [    0.832269] pci 0000:00:01.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.832343] pci 0000:00:01.2: [1022:14ee] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.832364] pci 0000:00:01.2: PCI bridge to [bus 01]
>>> [    0.832371] pci 0000:00:01.2:   bridge window [mem 
>>> 0xfce00000-0xfcefffff]
>>> [    0.832386] pci 0000:00:01.2: enabling Extended Tags
>>> [    0.832444] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
>>> [    0.832604] pci 0000:00:02.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.832670] pci 0000:00:02.1: [1022:14ed] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.832691] pci 0000:00:02.1: PCI bridge to [bus 02]
>>> [    0.832696] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
>>> [    0.832699] pci 0000:00:02.1:   bridge window [mem 
>>> 0xfcd00000-0xfcdfffff]
>>> [    0.832712] pci 0000:00:02.1: enabling Extended Tags
>>> [    0.832763] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
>>> [    0.832897] pci 0000:00:02.2: [1022:14ed] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.832915] pci 0000:00:02.2: PCI bridge to [bus 03]
>>> [    0.832926] pci 0000:00:02.2:   bridge window [mem 
>>> 0x7ff0900000-0x7ff0afffff 64bit pref]
>>> [    0.832979] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
>>> [    0.833126] pci 0000:00:02.4: [1022:14ee] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.833147] pci 0000:00:02.4: PCI bridge to [bus 04]
>>> [    0.833153] pci 0000:00:02.4:   bridge window [mem 
>>> 0xfcc00000-0xfccfffff]
>>> [    0.833168] pci 0000:00:02.4: enabling Extended Tags
>>> [    0.833224] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
>>> [    0.833368] pci 0000:00:03.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.833441] pci 0000:00:04.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.833518] pci 0000:00:08.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.833585] pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.833603] pci 0000:00:08.1: PCI bridge to [bus 05]
>>> [    0.833607] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
>>> [    0.833610] pci 0000:00:08.1:   bridge window [mem 
>>> 0xfc400000-0xfc9fffff]
>>> [    0.833616] pci 0000:00:08.1:   bridge window [mem 
>>> 0x7fe0000000-0x7ff07fffff 64bit pref]
>>> [    0.833623] pci 0000:00:08.1: enabling Extended Tags
>>> [    0.833666] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
>>> [    0.833822] pci 0000:00:08.2: [1022:14eb] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.833873] pci 0000:00:08.2: PCI bridge to [bus 06]
>>> [    0.833889] pci 0000:00:08.2: enabling Extended Tags
>>> [    0.833931] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
>>> [    0.834049] pci 0000:00:08.3: [1022:14eb] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.834067] pci 0000:00:08.3: PCI bridge to [bus 07]
>>> [    0.834072] pci 0000:00:08.3:   bridge window [mem 
>>> 0xfca00000-0xfcbfffff]
>>> [    0.834084] pci 0000:00:08.3: enabling Extended Tags
>>> [    0.834127] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
>>> [    0.834492] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 
>>> conventional PCI endpoint
>>> [    0.834638] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 
>>> conventional PCI endpoint
>>> [    0.834797] pci 0000:00:18.0: [1022:14f0] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.834839] pci 0000:00:18.1: [1022:14f1] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.834881] pci 0000:00:18.2: [1022:14f2] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.834922] pci 0000:00:18.3: [1022:14f3] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.834963] pci 0000:00:18.4: [1022:14f4] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.835004] pci 0000:00:18.5: [1022:14f5] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.835046] pci 0000:00:18.6: [1022:14f6] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.835088] pci 0000:00:18.7: [1022:14f7] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.835437] pci 0000:01:00.0: [15b7:5030] type 00 class 0x010802 
>>> PCIe Endpoint
>>> [    0.835455] pci 0000:01:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 
>>> 64bit]
>>> [    0.835744] pci 0000:00:01.2: PCI bridge to [bus 01]
>>> [    0.835818] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000 
>>> PCIe Endpoint
>>> [    0.835835] pci 0000:02:00.0: BAR 0 [io  0xf000-0xf0ff]
>>> [    0.835859] pci 0000:02:00.0: BAR 2 [mem 0xfcd04000-0xfcd04fff 
>>> 64bit]
>>> [    0.835873] pci 0000:02:00.0: BAR 4 [mem 0xfcd00000-0xfcd03fff 
>>> 64bit]
>>> [    0.835971] pci 0000:02:00.0: supports D1 D2
>>> [    0.835972] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot 
>>> D3cold
>>> [    0.836162] pci 0000:00:02.1: PCI bridge to [bus 02]
>>> [    0.836233] pci 0000:03:00.0: [14c3:0608] type 00 class 0x028000 
>>> PCIe Endpoint
>>> [    0.836253] pci 0000:03:00.0: BAR 0 [mem 0x7ff0900000-0x7ff09fffff 
>>> 64bit pref]
>>> [    0.836265] pci 0000:03:00.0: BAR 2 [mem 0x7ff0a00000-0x7ff0a03fff 
>>> 64bit pref]
>>> [    0.836277] pci 0000:03:00.0: BAR 4 [mem 0x7ff0a04000-0x7ff0a04fff 
>>> 64bit pref]
>>> [    0.836356] pci 0000:03:00.0: supports D1 D2
>>> [    0.836357] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot 
>>> D3cold
>>> [    0.836527] pci 0000:00:02.2: PCI bridge to [bus 03]
>>> [    0.836602] pci 0000:04:00.0: [2646:5017] type 00 class 0x010802 
>>> PCIe Endpoint
>>> [    0.836620] pci 0000:04:00.0: BAR 0 [mem 0xfcc00000-0xfcc03fff 
>>> 64bit]
>>> [    0.836864] pci 0000:00:02.4: PCI bridge to [bus 04]
>>> [    0.836986] pci 0000:05:00.0: [1002:15bf] type 00 class 0x030000 
>>> PCIe Legacy Endpoint
>>> [    0.837000] pci 0000:05:00.0: BAR 0 [mem 0x7fe0000000-0x7fefffffff 
>>> 64bit pref]
>>> [    0.837010] pci 0000:05:00.0: BAR 2 [mem 0xfc400000-0xfc5fffff 
>>> 64bit pref]
>>> [    0.837017] pci 0000:05:00.0: BAR 4 [io  0xe000-0xe0ff]
>>> [    0.837024] pci 0000:05:00.0: BAR 5 [mem 0xfc900000-0xfc97ffff]
>>> [    0.837035] pci 0000:05:00.0: enabling Extended Tags
>>> [    0.837103] pci 0000:05:00.0: PME# supported from D1 D2 D3hot 
>>> D3cold
>>> [    0.837266] pci 0000:05:00.1: [1002:1640] type 00 class 0x040300 
>>> PCIe Legacy Endpoint
>>> [    0.837276] pci 0000:05:00.1: BAR 0 [mem 0xfc9c8000-0xfc9cbfff]
>>> [    0.837303] pci 0000:05:00.1: enabling Extended Tags
>>> [    0.837345] pci 0000:05:00.1: PME# supported from D1 D2 D3hot 
>>> D3cold
>>> [    0.837456] pci 0000:05:00.2: [1022:15c7] type 00 class 0x108000 
>>> PCIe Endpoint
>>> [    0.837474] pci 0000:05:00.2: BAR 2 [mem 0xfc800000-0xfc8fffff]
>>> [    0.837486] pci 0000:05:00.2: BAR 5 [mem 0xfc9cc000-0xfc9cdfff]
>>> [    0.837495] pci 0000:05:00.2: enabling Extended Tags
>>> [    0.837646] pci 0000:05:00.3: [1022:15b9] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.837660] pci 0000:05:00.3: BAR 0 [mem 0xfc700000-0xfc7fffff 
>>> 64bit]
>>> [    0.837691] pci 0000:05:00.3: enabling Extended Tags
>>> [    0.837735] pci 0000:05:00.3: PME# supported from D0 D3hot D3cold
>>> [    0.837855] pci 0000:05:00.4: [1022:15ba] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.837869] pci 0000:05:00.4: BAR 0 [mem 0xfc600000-0xfc6fffff 
>>> 64bit]
>>> [    0.837900] pci 0000:05:00.4: enabling Extended Tags
>>> [    0.837944] pci 0000:05:00.4: PME# supported from D0 D3hot D3cold
>>> [    0.838060] pci 0000:05:00.5: [1022:15e2] type 00 class 0x048000 
>>> PCIe Endpoint
>>> [    0.838070] pci 0000:05:00.5: BAR 0 [mem 0xfc980000-0xfc9bffff]
>>> [    0.838082] pci 0000:05:00.5: BAR 2 [mem 0x7ff0000000-0x7ff07fffff 
>>> 64bit pref]
>>> [    0.838099] pci 0000:05:00.5: enabling Extended Tags
>>> [    0.838140] pci 0000:05:00.5: PME# supported from D0 D3hot D3cold
>>> [    0.838255] pci 0000:05:00.6: [1022:15e3] type 00 class 0x040300 
>>> PCIe Endpoint
>>> [    0.838265] pci 0000:05:00.6: BAR 0 [mem 0xfc9c0000-0xfc9c7fff]
>>> [    0.838293] pci 0000:05:00.6: enabling Extended Tags
>>> [    0.838334] pci 0000:05:00.6: PME# supported from D0 D3hot D3cold
>>> [    0.838469] pci 0000:00:08.1: PCI bridge to [bus 05]
>>> [    0.838531] pci 0000:06:00.0: [1022:14ec] type 00 class 0x130000 
>>> PCIe Endpoint
>>> [    0.838566] pci 0000:06:00.0: enabling Extended Tags
>>> [    0.838620] pci 0000:06:00.0: PME# supported from D3hot D3cold
>>> [    0.838726] pci 0000:00:08.2: PCI bridge to [bus 06]
>>> [    0.838822] pci 0000:07:00.0: [1022:14ec] type 00 class 0x130000 
>>> PCIe Endpoint
>>> [    0.838857] pci 0000:07:00.0: enabling Extended Tags
>>> [    0.839043] pci 0000:07:00.3: [1022:15c0] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.839057] pci 0000:07:00.3: BAR 0 [mem 0xfcb00000-0xfcbfffff 
>>> 64bit]
>>> [    0.839088] pci 0000:07:00.3: enabling Extended Tags
>>> [    0.839133] pci 0000:07:00.3: PME# supported from D0 D3hot D3cold
>>> [    0.839247] pci 0000:07:00.4: [1022:15c1] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.839262] pci 0000:07:00.4: BAR 0 [mem 0xfca00000-0xfcafffff 
>>> 64bit]
>>> [    0.839292] pci 0000:07:00.4: enabling Extended Tags
>>> [    0.839337] pci 0000:07:00.4: PME# supported from D0 D3hot D3cold
>>> [    0.839461] pci 0000:00:08.3: PCI bridge to [bus 07]
>>> [    0.847948] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
>>> [    0.848034] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
>>> [    0.848112] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
>>> [    0.848204] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
>>> [    0.848288] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
>>> [    0.848360] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
>>> [    0.848432] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
>>> [    0.848505] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
>>> [    0.855137] Low-power S0 idle used by default for system suspend
>>> [    0.855327] ACPI: EC: interrupt unblocked
>>> [    0.855329] ACPI: EC: event unblocked
>>> [    0.855333] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>> [    0.855334] ACPI: EC: GPE=0x5
>>> [    0.855336] ACPI: \_SB_.PCI0.SBRG.H_EC: Boot DSDT EC 
>>> initialization complete
>>> [    0.855338] ACPI: \_SB_.PCI0.SBRG.H_EC: EC: Used to handle 
>>> transactions and events
>>> [    0.856042] iommu: Default domain type: Translated
>>> [    0.856042] iommu: DMA domain TLB invalidation policy: lazy mode
>>> [    0.856181] SCSI subsystem initialized
>>> [    0.856189] libata version 3.00 loaded.
>>> [    0.856189] ACPI: bus type USB registered
>>> [    0.856189] usbcore: registered new interface driver usbfs
>>> [    0.856189] usbcore: registered new interface driver hub
>>> [    0.856189] usbcore: registered new device driver usb
>>> [    0.865521] EDAC MC: Ver: 3.0.0
>>> [    0.866050] efivars: Registered efivars operations
>>> [    0.866262] NetLabel: Initializing
>>> [    0.866264] NetLabel:  domain hash size = 128
>>> [    0.866265] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
>>> [    0.866284] NetLabel:  unlabeled traffic allowed by default
>>> [    0.866290] mctp: management component transport protocol core
>>> [    0.866291] NET: Registered PF_MCTP protocol family
>>> [    0.866296] PCI: Using ACPI for IRQ routing
>>> [    0.875853] PCI: pci_cache_line_size set to 64 bytes
>>> [    0.875917] e820: reserve RAM buffer [mem 0x09a7f000-0x0bffffff]
>>> [    0.875920] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
>>> [    0.875921] e820: reserve RAM buffer [mem 0x8748a000-0x87ffffff]
>>> [    0.875923] e820: reserve RAM buffer [mem 0x8820f018-0x8bffffff]
>>> [    0.875924] e820: reserve RAM buffer [mem 0x8e5c6000-0x8fffffff]
>>> [    0.875925] e820: reserve RAM buffer [mem 0x8f5d7000-0x8fffffff]
>>> [    0.875926] e820: reserve RAM buffer [mem 0x9bff9000-0x9bffffff]
>>> [    0.875928] e820: reserve RAM buffer [mem 0x9bfff000-0x9bffffff]
>>> [    0.875929] e820: reserve RAM buffer [mem 0x83e300000-0x83fffffff]
>>> [    0.876061] pci 0000:05:00.0: vgaarb: setting as boot VGA device
>>> [    0.876061] pci 0000:05:00.0: vgaarb: bridge control possible
>>> [    0.876061] pci 0000:05:00.0: vgaarb: VGA device added: 
>>> decodes=io+mem,owns=none,locks=none
>>> [    0.876061] vgaarb: loaded
>>> [    0.879357] clocksource: Switched to clocksource tsc-early
>>> [    0.879377] VFS: Disk quotas dquot_6.6.0
>>> [    0.879377] VFS: Dquot-cache hash table entries: 512 (order 0, 
>>> 4096 bytes)
>>> [    0.879377] pnp: PnP ACPI init
>>> [    0.879377] system 00:00: [mem 0xe0000000-0xefffffff] has been 
>>> reserved
>>> [    0.882322] system 00:03: [io  0x04d0-0x04d1] has been reserved
>>> [    0.882325] system 00:03: [io  0x040b] has been reserved
>>> [    0.882327] system 00:03: [io  0x04d6] has been reserved
>>> [    0.882328] system 00:03: [io  0x0c00-0x0c01] has been reserved
>>> [    0.882330] system 00:03: [io  0x0c14] has been reserved
>>> [    0.882331] system 00:03: [io  0x0c50-0x0c51] has been reserved
>>> [    0.882333] system 00:03: [io  0x0c52] has been reserved
>>> [    0.882335] system 00:03: [io  0x0c6c] has been reserved
>>> [    0.882336] system 00:03: [io  0x0c6f] has been reserved
>>> [    0.882338] system 00:03: [io  0x0cd0-0x0cd1] has been reserved
>>> [    0.882340] system 00:03: [io  0x0cd2-0x0cd3] has been reserved
>>> [    0.882341] system 00:03: [io  0x0cd4-0x0cd5] has been reserved
>>> [    0.882343] system 00:03: [io  0x0cd6-0x0cd7] has been reserved
>>> [    0.882345] system 00:03: [io  0x0cd8-0x0cdf] has been reserved
>>> [    0.882346] system 00:03: [io  0x0800-0x089f] has been reserved
>>> [    0.882348] system 00:03: [io  0x0b00-0x0b0f] has been reserved
>>> [    0.882349] system 00:03: [io  0x0b20-0x0b3f] has been reserved
>>> [    0.882351] system 00:03: [io  0x0900-0x090f] has been reserved
>>> [    0.882353] system 00:03: [io  0x0910-0x091f] has been reserved
>>> [    0.882355] system 00:03: [mem 0xfec00000-0xfec00fff] could not be 
>>> reserved
>>> [    0.882357] system 00:03: [mem 0xfec01000-0xfec01fff] could not be 
>>> reserved
>>> [    0.882359] system 00:03: [mem 0xfedc0000-0xfedc0fff] has been 
>>> reserved
>>> [    0.882362] system 00:03: [mem 0xfee00000-0xfee00fff] has been 
>>> reserved
>>> [    0.882363] system 00:03: [mem 0xfed80000-0xfed8ffff] could not be 
>>> reserved
>>> [    0.882366] system 00:03: [mem 0xfec10000-0xfec10fff] has been 
>>> reserved
>>> [    0.882368] system 00:03: [mem 0xff000000-0xffffffff] has been 
>>> reserved
>>> [    0.884027] pnp: PnP ACPI: found 4 devices
>>> [    0.890360] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
>>> 0xffffff, max_idle_ns: 2085701024 ns
>>> [    0.890502] NET: Registered PF_INET protocol family
>>> [    0.890648] IP idents hash table entries: 262144 (order: 9, 
>>> 2097152 bytes, linear)
>>> [    0.904508] tcp_listen_portaddr_hash hash table entries: 16384 
>>> (order: 6, 262144 bytes, linear)
>>> [    0.904530] Table-perturb hash table entries: 65536 (order: 6, 
>>> 262144 bytes, linear)
>>> [    0.904565] TCP established hash table entries: 262144 (order: 9, 
>>> 2097152 bytes, linear)
>>> [    0.904810] TCP bind hash table entries: 65536 (order: 9, 2097152 
>>> bytes, linear)
>>> [    0.904898] TCP: Hash tables configured (established 262144 bind 
>>> 65536)
>>> [    0.904995] MPTCP token hash table entries: 32768 (order: 7, 
>>> 786432 bytes, linear)
>>> [    0.905052] UDP hash table entries: 16384 (order: 7, 524288 bytes, 
>>> linear)
>>> [    0.905106] UDP-Lite hash table entries: 16384 (order: 7, 524288 
>>> bytes, linear)
>>> [    0.905183] NET: Registered PF_UNIX/PF_LOCAL protocol family
>>> [    0.905190] NET: Registered PF_XDP protocol family
>>> [    0.905198] pci 0000:00:02.1: bridge window [mem 
>>> 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 
>>> add_align 100000
>>> [    0.905212] pci 0000:00:02.1: bridge window [mem 
>>> 0x860000000-0x8601fffff 64bit pref]: assigned
>>> [    0.905216] pci 0000:00:01.2: PCI bridge to [bus 01]
>>> [    0.905225] pci 0000:00:01.2:   bridge window [mem 
>>> 0xfce00000-0xfcefffff]
>>> [    0.905231] pci 0000:00:02.1: PCI bridge to [bus 02]
>>> [    0.905234] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
>>> [    0.905237] pci 0000:00:02.1:   bridge window [mem 
>>> 0xfcd00000-0xfcdfffff]
>>> [    0.905240] pci 0000:00:02.1:   bridge window [mem 
>>> 0x860000000-0x8601fffff 64bit pref]
>>> [    0.905244] pci 0000:00:02.2: PCI bridge to [bus 03]
>>> [    0.905249] pci 0000:00:02.2:   bridge window [mem 
>>> 0x7ff0900000-0x7ff0afffff 64bit pref]
>>> [    0.905253] pci 0000:00:02.4: PCI bridge to [bus 04]
>>> [    0.905256] pci 0000:00:02.4:   bridge window [mem 
>>> 0xfcc00000-0xfccfffff]
>>> [    0.905263] pci 0000:00:08.1: PCI bridge to [bus 05]
>>> [    0.905265] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
>>> [    0.905271] pci 0000:00:08.1:   bridge window [mem 
>>> 0xfc400000-0xfc9fffff]
>>> [    0.905273] pci 0000:00:08.1:   bridge window [mem 
>>> 0x7fe0000000-0x7ff07fffff 64bit pref]
>>> [    0.905277] pci 0000:00:08.2: PCI bridge to [bus 06]
>>> [    0.905284] pci 0000:00:08.3: PCI bridge to [bus 07]
>>> [    0.905287] pci 0000:00:08.3:   bridge window [mem 
>>> 0xfca00000-0xfcbfffff]
>>> [    0.905293] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
>>> [    0.905295] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
>>> [    0.905296] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
>>> [    0.905298] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
>>> [    0.905299] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff 
>>> window]
>>> [    0.905301] pci_bus 0000:00: resource 9 [mem 0xfa000000-0xfcffffff 
>>> window]
>>> [    0.905303] pci_bus 0000:00: resource 10 [mem 
>>> 0xf0000000-0xf9ffffff window]
>>> [    0.905304] pci_bus 0000:00: resource 11 [mem 
>>> 0xa0000000-0xdfffffff window]
>>> [    0.905306] pci_bus 0000:00: resource 12 [mem 
>>> 0x860000000-0x7fffffffff window]
>>> [    0.905308] pci_bus 0000:01: resource 1 [mem 
>>> 0xfce00000-0xfcefffff]
>>> [    0.905310] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
>>> [    0.905311] pci_bus 0000:02: resource 1 [mem 
>>> 0xfcd00000-0xfcdfffff]
>>> [    0.905313] pci_bus 0000:02: resource 2 [mem 
>>> 0x860000000-0x8601fffff 64bit pref]
>>> [    0.905314] pci_bus 0000:03: resource 2 [mem 
>>> 0x7ff0900000-0x7ff0afffff 64bit pref]
>>> [    0.905316] pci_bus 0000:04: resource 1 [mem 
>>> 0xfcc00000-0xfccfffff]
>>> [    0.905318] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
>>> [    0.905319] pci_bus 0000:05: resource 1 [mem 
>>> 0xfc400000-0xfc9fffff]
>>> [    0.905321] pci_bus 0000:05: resource 2 [mem 
>>> 0x7fe0000000-0x7ff07fffff 64bit pref]
>>> [    0.905323] pci_bus 0000:07: resource 1 [mem 
>>> 0xfca00000-0xfcbfffff]
>>> [    0.905740] pci 0000:05:00.1: D0 power state depends on 
>>> 0000:05:00.0
>>> [    0.905840] pci 0000:00:08.1: can't derive routing for PCI INT A
>>> [    0.905856] pci 0000:00:08.1: PCI INT A: not connected
>>> [    0.906114] pci 0000:00:08.3: can't derive routing for PCI INT A
>>> [    0.906116] pci 0000:00:08.3: PCI INT A: not connected
>>> [    0.906292] PCI: CLS 64 bytes, default 64
>>> [    0.906325] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
>>> supported
>>> [    0.906396] pci 0000:00:01.0: Adding to iommu group 0
>>> [    0.906397] Trying to unpack rootfs image as initramfs...
>>> [    0.906415] pci 0000:00:01.2: Adding to iommu group 1
>>> [    0.906441] pci 0000:00:02.0: Adding to iommu group 2
>>> [    0.906458] pci 0000:00:02.1: Adding to iommu group 3
>>> [    0.906474] pci 0000:00:02.2: Adding to iommu group 4
>>> [    0.906490] pci 0000:00:02.4: Adding to iommu group 5
>>> [    0.906513] pci 0000:00:03.0: Adding to iommu group 6
>>> [    0.906535] pci 0000:00:04.0: Adding to iommu group 7
>>> [    0.906564] pci 0000:00:08.0: Adding to iommu group 8
>>> [    0.906580] pci 0000:00:08.1: Adding to iommu group 9
>>> [    0.906597] pci 0000:00:08.2: Adding to iommu group 10
>>> [    0.906613] pci 0000:00:08.3: Adding to iommu group 11
>>> [    0.906646] pci 0000:00:14.0: Adding to iommu group 12
>>> [    0.906661] pci 0000:00:14.3: Adding to iommu group 12
>>> [    0.906736] pci 0000:00:18.0: Adding to iommu group 13
>>> [    0.906753] pci 0000:00:18.1: Adding to iommu group 13
>>> [    0.906769] pci 0000:00:18.2: Adding to iommu group 13
>>> [    0.906785] pci 0000:00:18.3: Adding to iommu group 13
>>> [    0.906801] pci 0000:00:18.4: Adding to iommu group 13
>>> [    0.906816] pci 0000:00:18.5: Adding to iommu group 13
>>> [    0.906832] pci 0000:00:18.6: Adding to iommu group 13
>>> [    0.906848] pci 0000:00:18.7: Adding to iommu group 13
>>> [    0.906869] pci 0000:01:00.0: Adding to iommu group 14
>>> [    0.906885] pci 0000:02:00.0: Adding to iommu group 15
>>> [    0.906901] pci 0000:03:00.0: Adding to iommu group 16
>>> [    0.906917] pci 0000:04:00.0: Adding to iommu group 17
>>> [    0.906945] pci 0000:05:00.0: Adding to iommu group 18
>>> [    0.906961] pci 0000:05:00.1: Adding to iommu group 19
>>> [    0.906978] pci 0000:05:00.2: Adding to iommu group 20
>>> [    0.906996] pci 0000:05:00.3: Adding to iommu group 21
>>> [    0.907014] pci 0000:05:00.4: Adding to iommu group 22
>>> [    0.907031] pci 0000:05:00.5: Adding to iommu group 23
>>> [    0.907048] pci 0000:05:00.6: Adding to iommu group 24
>>> [    0.907064] pci 0000:06:00.0: Adding to iommu group 25
>>> [    0.907086] pci 0000:07:00.0: Adding to iommu group 26
>>> [    0.907103] pci 0000:07:00.3: Adding to iommu group 27
>>> [    0.907121] pci 0000:07:00.4: Adding to iommu group 28
>>> [    0.909510] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): 
>>> PPR NX GT [5] IA GA PC GA_vAPIC
>>> [    0.909521] AMD-Vi: Interrupt remapping enabled
>>> [    0.909654] AMD-Vi: Virtual APIC enabled
>>> [    0.909689] PCI-DMA: Using software bounce buffering for IO 
>>> (SWIOTLB)
>>> [    0.909700] software IO TLB: mapped [mem 
>>> 0x000000008348a000-0x000000008748a000] (64MB)
>>> [    0.909788] LVT offset 0 assigned for vector 0x400
>>> [    0.912766] perf: AMD IBS detected (0x00000bff)
>>> [    0.912774] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
>>> counters/bank).
>>> [    0.920007] Initialise system trusted keyrings
>>> [    0.920033] Key type blacklist registered
>>> [    0.920113] workingset: timestamp_bits=41 max_order=23 
>>> bucket_order=0
>>> [    0.920133] zbud: loaded
>>> [    0.920319] fuse: init (API version 7.40)
>>> [    0.920409] integrity: Platform Keyring initialized
>>> [    0.920411] integrity: Machine keyring initialized
>>> [    0.930486] Key type asymmetric registered
>>> [    0.930488] Asymmetric key parser 'x509' registered
>>> [    0.930510] Block layer SCSI generic (bsg) driver version 0.4 
>>> loaded (major 246)
>>> [    0.930567] io scheduler mq-deadline registered
>>> [    0.930569] io scheduler kyber registered
>>> [    0.930578] io scheduler bfq registered
>>> [    0.932250] pcieport 0000:00:01.2: PME: Signaling with IRQ 33
>>> [    0.932397] pcieport 0000:00:02.1: PME: Signaling with IRQ 34
>>> [    0.932418] pcieport 0000:00:02.1: pciehp: Slot #0 AttnBtn- 
>>> PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ 
>>> IbPresDis- LLActRep+
>>> [    0.932599] pcieport 0000:00:02.2: PME: Signaling with IRQ 35
>>> [    0.932724] pcieport 0000:00:02.4: PME: Signaling with IRQ 36
>>> [    0.932860] pcieport 0000:00:08.1: PME: Signaling with IRQ 37
>>> [    0.932974] pcieport 0000:00:08.2: can't derive routing for PCI 
>>> INT A
>>> [    0.932976] pcieport 0000:00:08.2: PCI INT A: not connected
>>> [    0.933052] pcieport 0000:00:08.2: PME: Signaling with IRQ 38
>>> [    0.933162] pcieport 0000:00:08.3: PME: Signaling with IRQ 39
>>> [    0.933270] shpchp: Standard Hot Plug PCI Controller Driver 
>>> version: 0.4
>>> [    0.981312] Freeing initrd memory: 44172K
>>> [    1.056058] ACPI: AC: AC Adapter [ADP1] (on-line)
>>> [    1.056256] input: Lid Switch as 
>>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:51/PNP0C09:00/PNP0C0D:00/input/input0
>>> [    1.056312] ACPI: button: Lid Switch [LID0]
>>> [    1.056389] input: Power Button as 
>>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
>>> [    1.056435] ACPI: button: Power Button [PWRB]
>>> [    1.057478] Estimated ratio of average max frequency by base 
>>> frequency (times 1024): 1548
>>> [    1.057497] Monitor-Mwait will be used to enter C-1 state
>>> [    1.057501] ACPI: \_SB_.PLTF.C000: Found 3 idle states
>>> [    1.057714] ACPI: \_SB_.PLTF.C002: Found 3 idle states
>>> [    1.057961] ACPI: \_SB_.PLTF.C004: Found 3 idle states
>>> [    1.058220] ACPI: \_SB_.PLTF.C006: Found 3 idle states
>>> [    1.058472] ACPI: \_SB_.PLTF.C008: Found 3 idle states
>>> [    1.058727] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
>>> [    1.058987] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
>>> [    1.059253] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
>>> [    1.059438] ACPI: \_SB_.PLTF.C001: Found 3 idle states
>>> [    1.059613] ACPI: \_SB_.PLTF.C003: Found 3 idle states
>>> [    1.059834] ACPI: \_SB_.PLTF.C005: Found 3 idle states
>>> [    1.059975] ACPI: \_SB_.PLTF.C007: Found 3 idle states
>>> [    1.060115] ACPI: \_SB_.PLTF.C009: Found 3 idle states
>>> [    1.060251] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
>>> [    1.060382] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
>>> [    1.060563] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
>>> [    1.061910] thermal LNXTHERM:00: registered as thermal_zone0
>>> [    1.061913] ACPI: thermal: Thermal Zone [TZ01] (39 C)
>>> [    1.062173] Serial: 8250/16550 driver, 32 ports, IRQ sharing 
>>> enabled
>>> [    1.064716] hpet_acpi_add: no address or irqs in _CRS
>>> [    1.064740] Non-volatile memory driver v1.3
>>> [    1.064742] Linux agpgart interface v0.103
>>> [    1.071517] ACPI: battery: Slot [BAT0] (battery present)
>>> [    1.232709] tpm_crb MSFT0101:00: Disabling hwrng
>>> [    1.234158] ACPI: bus type drm_connector registered
>>> [    1.237125] usbcore: registered new interface driver 
>>> usbserial_generic
>>> [    1.237132] usbserial: USB Serial support registered for generic
>>> [    1.237289] rtc_cmos 00:01: RTC can wake from S4
>>> [    1.237634] rtc_cmos 00:01: registered as rtc0
>>> [    1.237672] rtc_cmos 00:01: setting system clock to 
>>> 2024-09-16T14:08:13 UTC (1726495693)
>>> [    1.237707] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes 
>>> nvram
>>> [    1.239457] ledtrig-cpu: registered to indicate activity on CPUs
>>> [    1.239936] [drm] Initialized simpledrm 1.0.0 for 
>>> simple-framebuffer.0 on minor 0
>>> [    1.242055] fbcon: Deferring console take-over
>>> [    1.242058] simple-framebuffer simple-framebuffer.0: [drm] fb0: 
>>> simpledrmdrmfb frame buffer device
>>> [    1.242106] hid: raw HID events driver (C) Jiri Kosina
>>> [    1.242172] drop_monitor: Initializing network drop monitor 
>>> service
>>> [    1.242290] NET: Registered PF_INET6 protocol family
>>> [    1.247652] Segment Routing with IPv6
>>> [    1.247657] RPL Segment Routing with IPv6
>>> [    1.247682] In-situ OAM (IOAM) with IPv6
>>> [    1.247736] NET: Registered PF_PACKET protocol family
>>> [    1.249851] microcode: Current revision: 0x0a704103
>>> [    1.250442] resctrl: L3 allocation detected
>>> [    1.250443] resctrl: MB allocation detected
>>> [    1.250444] resctrl: SMBA allocation detected
>>> [    1.250445] resctrl: L3 monitoring detected
>>> [    1.250467] IPI shorthand broadcast: enabled
>>> [    1.252744] sched_clock: Marking stable (1250006575, 
>>> 425706)->(1252509056, -2076775)
>>> [    1.252894] registered taskstats version 1
>>> [    1.253401] Loading compiled-in X.509 certificates
>>> [    1.255937] Loaded X.509 cert 'Build time autogenerated kernel 
>>> key: 6ad17a63870541699c2e72736d49c75f37f030e3'
>>> [    1.259830] zswap: loaded using pool zstd/zsmalloc
>>> [    1.259891] Demotion targets for Node 0: null
>>> [    1.260074] Key type .fscrypt registered
>>> [    1.260076] Key type fscrypt-provisioning registered
>>> [    1.260265] integrity: Loading X.509 certificate: UEFI:db
>>> [    1.264285] integrity: Loaded X.509 cert 'Database Key: 
>>> 5cf25c529578f9f01b9cf7cd4217a23d'
>>> [    1.264824] PM:   Magic number: 8:769:131
>>> [    1.264887] acpi PNP0C02:03: hash matches
>>> [    1.264937] acpi device:06: hash matches
>>> [    1.268361] RAS: Correctable Errors collector initialized.
>>> [    1.281970] clk: Disabling unused clocks
>>> [    1.281974] PM: genpd: Disabling unused power domains
>>> [    1.283003] Freeing unused decrypted memory: 2028K
>>> [    1.283422] Freeing unused kernel image (initmem) memory: 3452K
>>> [    1.283432] Write protecting the kernel read-only data: 32768k
>>> [    1.283812] Freeing unused kernel image (rodata/data gap) memory: 
>>> 816K
>>> [    1.329117] x86/mm: Checked W+X mappings: passed, no W+X pages 
>>> found.
>>> [    1.329122] rodata_test: all tests were successful
>>> [    1.329128] Run /init as init process
>>> [    1.329129]   with arguments:
>>> [    1.329131]     /init
>>> [    1.329132]     splash
>>> [    1.329133]   with environment:
>>> [    1.329134]     HOME=/
>>> [    1.329135]     TERM=linux
>>> [    1.339230] systemd[1]: Successfully made /usr/ read-only.
>>> [    1.339343] systemd[1]: systemd 256.6-1-arch running in system 
>>> mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT 
>>> +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
>>> +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 
>>> +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD 
>>> +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
>>> [    1.339348] systemd[1]: Detected architecture x86-64.
>>> [    1.339350] systemd[1]: Running in initrd.
>>> [    1.339506] systemd[1]: Initializing machine ID from random 
>>> generator.
>>> [    1.402645] systemd[1]: Queued start job for default target Initrd 
>>> Default Target.
>>> [    1.434844] systemd[1]: Created slice Slice 
>>> /system/systemd-cryptsetup.
>>> [    1.434917] systemd[1]: Expecting device 
>>> /dev/disk/by-uuid/97a0672e-59e7-4e70-94e3-b261fb372de3...
>>> [    1.434922] systemd[1]: Expecting device 
>>> /dev/disk/by-uuid/a17f7cbf-2762-4b33-a2bc-054e1e336a25...
>>> [    1.434927] systemd[1]: Expecting device /dev/mapper/root...
>>> [    1.434949] systemd[1]: Reached target Slice Units.
>>> [    1.434961] systemd[1]: Reached target Swaps.
>>> [    1.434972] systemd[1]: Reached target Timer Units.
>>> [    1.435056] systemd[1]: Listening on Journal Socket (/dev/log).
>>> [    1.435117] systemd[1]: Listening on Journal Sockets.
>>> [    1.435180] systemd[1]: Listening on udev Control Socket.
>>> [    1.435219] systemd[1]: Listening on udev Kernel Socket.
>>> [    1.435228] systemd[1]: Reached target Socket Units.
>>> [    1.436010] systemd[1]: Starting Create List of Static Device 
>>> Nodes...
>>> [    1.437605] systemd[1]: Starting Journal Service...
>>> [    1.438932] systemd[1]: Starting Load Kernel Modules...
>>> [    1.438969] systemd[1]: TPM PCR Barrier (initrd) was skipped 
>>> because of an unmet condition check (ConditionSecurity=measured-uki).
>>> [    1.440056] systemd[1]: Starting Create Static Device Nodes in 
>>> /dev...
>>> [    1.440718] systemd[1]: Starting Coldplug All udev Devices...
>>> [    1.441306] systemd[1]: Starting Virtual Console Setup...
>>> [    1.441857] systemd[1]: Finished Create List of Static Device 
>>> Nodes.
>>> [    1.444578] systemd[1]: Finished Load Kernel Modules.
>>> [    1.446135] systemd[1]: Finished Create Static Device Nodes in 
>>> /dev.
>>> [    1.446201] systemd[1]: Reached target Preparation for Local File 
>>> Systems.
>>> [    1.446210] systemd[1]: Reached target Local File Systems.
>>> [    1.446919] systemd[1]: Starting Rule-based Manager for Device 
>>> Events and Files...
>>> [    1.450163] systemd-journald[191]: Collecting audit messages is 
>>> disabled.
>>> [    1.450987] systemd[1]: Finished Virtual Console Setup.
>>> [    1.463923] systemd[1]: Started Rule-based Manager for Device 
>>> Events and Files.
>>> [    1.481937] systemd[1]: Started Journal Service.
>>> [    1.578876] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WMBB 
>>> method block execution control method not found
>>> [    1.582816] ACPI: video: Video Device [VGA] (multi-head: yes  rom: 
>>> no  post: no)
>>> [    1.583253] input: Video Bus as 
>>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:23/LNXVIDEO:00/input/input2
>>> [    1.583776] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 
>>> 0x60,0x64 irq 1
>>> [    1.583780] i8042: PNP: PS/2 appears to have AUX port disabled, if 
>>> this is incorrect please boot with i8042.nopnp
>>> [    1.584361] serio: i8042 KBD port at 0x60,0x64 irq 1
>>> [    1.585104] ccp 0000:05:00.2: enabling device (0000 -> 0002)
>>> [    1.585251] xhci_hcd 0000:05:00.3: xHCI Host Controller
>>> [    1.585259] xhci_hcd 0000:05:00.3: new USB bus registered, 
>>> assigned bus number 1
>>> [    1.585706] xhci_hcd 0000:05:00.3: hcc params 0x0128ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.585991] xhci_hcd 0000:05:00.3: xHCI Host Controller
>>> [    1.585994] xhci_hcd 0000:05:00.3: new USB bus registered, 
>>> assigned bus number 2
>>> [    1.585997] xhci_hcd 0000:05:00.3: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.586044] usb usb1: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.586046] usb usb1: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.586048] usb usb1: Product: xHCI Host Controller
>>> [    1.586050] usb usb1: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.586051] usb usb1: SerialNumber: 0000:05:00.3
>>> [    1.586226] hub 1-0:1.0: USB hub found
>>> [    1.586250] hub 1-0:1.0: 5 ports detected
>>> [    1.588071] usb usb2: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.588099] usb usb2: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.588102] usb usb2: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.588104] usb usb2: Product: xHCI Host Controller
>>> [    1.588106] usb usb2: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.588107] usb usb2: SerialNumber: 0000:05:00.3
>>> [    1.588147] ccp 0000:05:00.2: tee enabled
>>> [    1.588242] hub 2-0:1.0: USB hub found
>>> [    1.588255] hub 2-0:1.0: 2 ports detected
>>> [    1.588528] ccp 0000:05:00.2: psp enabled
>>> [    1.590248] xhci_hcd 0000:05:00.4: xHCI Host Controller
>>> [    1.590254] xhci_hcd 0000:05:00.4: new USB bus registered, 
>>> assigned bus number 3
>>> [    1.590694] xhci_hcd 0000:05:00.4: hcc params 0x0110ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.590946] xhci_hcd 0000:05:00.4: xHCI Host Controller
>>> [    1.590949] xhci_hcd 0000:05:00.4: new USB bus registered, 
>>> assigned bus number 4
>>> [    1.590952] xhci_hcd 0000:05:00.4: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.590993] usb usb3: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.590996] usb usb3: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.590998] usb usb3: Product: xHCI Host Controller
>>> [    1.590999] usb usb3: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.591001] usb usb3: SerialNumber: 0000:05:00.4
>>> [    1.591128] hub 3-0:1.0: USB hub found
>>> [    1.591139] hub 3-0:1.0: 1 port detected
>>> [    1.591556] usb usb4: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.591582] usb usb4: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.591585] usb usb4: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.591587] usb usb4: Product: xHCI Host Controller
>>> [    1.591588] usb usb4: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.591590] usb usb4: SerialNumber: 0000:05:00.4
>>> [    1.591721] hub 4-0:1.0: USB hub found
>>> [    1.591743] hub 4-0:1.0: 1 port detected
>>> [    1.592123] xhci_hcd 0000:07:00.3: xHCI Host Controller
>>> [    1.592129] xhci_hcd 0000:07:00.3: new USB bus registered, 
>>> assigned bus number 5
>>> [    1.592508] xhci_hcd 0000:07:00.3: hcc params 0x0110ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.593000] xhci_hcd 0000:07:00.3: xHCI Host Controller
>>> [    1.593004] xhci_hcd 0000:07:00.3: new USB bus registered, 
>>> assigned bus number 6
>>> [    1.593006] xhci_hcd 0000:07:00.3: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.593047] usb usb5: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.593049] usb usb5: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.593051] usb usb5: Product: xHCI Host Controller
>>> [    1.593052] usb usb5: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.593054] usb usb5: SerialNumber: 0000:07:00.3
>>> [    1.593184] hub 5-0:1.0: USB hub found
>>> [    1.593197] hub 5-0:1.0: 1 port detected
>>> [    1.593349] usb usb6: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.593382] usb usb6: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.593385] usb usb6: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.593386] usb usb6: Product: xHCI Host Controller
>>> [    1.593388] usb usb6: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.593389] usb usb6: SerialNumber: 0000:07:00.3
>>> [    1.593513] nvme 0000:01:00.0: platform quirk: setting simple 
>>> suspend
>>> [    1.593532] nvme 0000:04:00.0: platform quirk: setting simple 
>>> suspend
>>> [    1.593587] hub 6-0:1.0: USB hub found
>>> [    1.593592] nvme nvme0: pci function 0000:01:00.0
>>> [    1.593603] hub 6-0:1.0: 1 port detected
>>> [    1.593617] nvme nvme1: pci function 0000:04:00.0
>>> [    1.594288] xhci_hcd 0000:07:00.4: xHCI Host Controller
>>> [    1.594294] xhci_hcd 0000:07:00.4: new USB bus registered, 
>>> assigned bus number 7
>>> [    1.594642] xhci_hcd 0000:07:00.4: hcc params 0x0110ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.595094] xhci_hcd 0000:07:00.4: xHCI Host Controller
>>> [    1.595097] xhci_hcd 0000:07:00.4: new USB bus registered, 
>>> assigned bus number 8
>>> [    1.595100] xhci_hcd 0000:07:00.4: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.595139] usb usb7: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.595141] usb usb7: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.595143] usb usb7: Product: xHCI Host Controller
>>> [    1.595145] usb usb7: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.595146] usb usb7: SerialNumber: 0000:07:00.4
>>> [    1.595253] hub 7-0:1.0: USB hub found
>>> [    1.595267] hub 7-0:1.0: 1 port detected
>>> [    1.595418] usb usb8: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.595446] usb usb8: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.595449] usb usb8: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.595451] usb usb8: Product: xHCI Host Controller
>>> [    1.595453] usb usb8: Manufacturer: Linux 
>>> 6.11.0-1.1-mainline-dirty xhci-hcd
>>> [    1.595454] usb usb8: SerialNumber: 0000:07:00.4
>>> [    1.595573] hub 8-0:1.0: USB hub found
>>> [    1.595585] hub 8-0:1.0: 1 port detected
>>> [    1.599152] input: AT Translated Set 2 keyboard as 
>>> /devices/platform/i8042/serio0/input/input3
>>> [    1.613429] nvme nvme1: allocated 64 MiB host memory buffer.
>>> [    1.633021] nvme nvme1: 8/0/0 default/read/poll queues
>>> [    1.633099] nvme nvme0: 16/0/0 default/read/poll queues
>>> [    1.643432]  nvme1n1: p1 p2
>>> [    1.680501] cryptd: max_cpu_qlen set to 1000
>>> [    1.692314] AES CTR mode by8 optimization enabled
>>> [    1.767305] device-mapper: uevent: version 1.0.3
>>> [    1.767398] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
>>> initialised: dm-devel@lists.linux.dev
>>> [    1.834151] usb 1-3: new full-speed USB device number 2 using 
>>> xhci_hcd
>>> [    1.927605] tsc: Refined TSC clocksource calibration: 3293.812 MHz
>>> [    1.927626] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
>>> 0x2f7a76a4ebd, max_idle_ns: 440795230158 ns
>>> [    1.927715] clocksource: Switched to clocksource tsc
>>> [    1.997491] usb 1-3: New USB device found, idVendor=2808, 
>>> idProduct=9348, bcdDevice= 1.00
>>> [    1.997504] usb 1-3: New USB device strings: Mfr=1, Product=2, 
>>> SerialNumber=0
>>> [    1.997510] usb 1-3: Product: FT9201Fingerprint.̚
>>> [    1.997514] usb 1-3: Manufacturer: Focal-systems.Corp
>>> [    2.127108] usb 1-5: new high-speed USB device number 3 using 
>>> xhci_hcd
>>> [    2.274478] usb 1-5: New USB device found, idVendor=0e8d, 
>>> idProduct=0608, bcdDevice= 1.00
>>> [    2.274489] usb 1-5: New USB device strings: Mfr=5, Product=6, 
>>> SerialNumber=7
>>> [    2.274494] usb 1-5: Product: Wireless_Device
>>> [    2.274499] usb 1-5: Manufacturer: MediaTek Inc.
>>> [    2.274502] usb 1-5: SerialNumber: 000000000
>>> [    3.347771] [drm] amdgpu kernel modesetting enabled.
>>> [    3.361807] amdgpu: Virtual CRAT table created for CPU
>>> [    3.361825] amdgpu: Topology: Add CPU node
>>> [    3.361927] amdgpu 0000:05:00.0: enabling device (0006 -> 0007)
>>> [    3.361974] [drm] initializing kernel modesetting (IP DISCOVERY 
>>> 0x1002:0x15BF 0x2782:0x12B3 0xC9).
>>> [    3.567760] [drm] register mmio base: 0xFC900000
>>> [    3.567770] [drm] register mmio size: 524288
>>> [    3.571438] [drm] add ip block number 0 <soc21_common>
>>> [    3.571443] [drm] add ip block number 1 <gmc_v11_0>
>>> [    3.571446] [drm] add ip block number 2 <ih_v6_0>
>>> [    3.571448] [drm] add ip block number 3 <psp>
>>> [    3.571450] [drm] add ip block number 4 <smu>
>>> [    3.571452] [drm] add ip block number 5 <dm>
>>> [    3.571455] [drm] add ip block number 6 <gfx_v11_0>
>>> [    3.571457] [drm] add ip block number 7 <sdma_v6_0>
>>> [    3.571459] [drm] add ip block number 8 <vcn_v4_0>
>>> [    3.571461] [drm] add ip block number 9 <jpeg_v4_0>
>>> [    3.571462] [drm] add ip block number 10 <mes_v11_0>
>>> [    3.571477] amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from VFCT
>>> [    3.571482] amdgpu: ATOM BIOS: 113-PHXGENERIC-001
>>> [    3.638897] amdgpu 0000:05:00.0: vgaarb: deactivate vga console
>>> [    3.638905] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) 
>>> feature enabled
>>> [    3.639030] [drm] vm size is 262144 GB, 4 levels, block size is 
>>> 9-bit, fragment size is 9-bit
>>> [    3.639059] amdgpu 0000:05:00.0: amdgpu: VRAM: 512M 
>>> 0x0000008000000000 - 0x000000801FFFFFFF (512M used)
>>> [    3.639062] amdgpu 0000:05:00.0: amdgpu: GART: 512M 
>>> 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
>>> [    3.639077] [drm] Detected VRAM RAM=512M, BAR=512M
>>> [    3.639078] [drm] RAM width 128bits LPDDR5
>>> [    3.639341] [drm] amdgpu: 512M of VRAM memory ready
>>> [    3.639345] [drm] amdgpu: 15652M of GTT memory ready.
>>> [    3.639364] [drm] GART: num cpu pages 131072, num gpu pages 131072
>>> [    3.639883] [drm] PCIE GART of 512M enabled (table at 
>>> 0x000000801FD00000).
>>> [    3.640310] [drm] Loading DMUB firmware via PSP: 
>>> version=0x08004300
>>> [    3.640655] [drm] Found VCN firmware Version ENC: 1.22 DEC: 8 VEP: 
>>> 0 Revision: 3
>>> [    3.666161] amdgpu 0000:05:00.0: amdgpu: reserve 0x4a00000 from 
>>> 0x8010000000 for PSP TMR
>>> [    4.448029] amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta 
>>> ucode is not available
>>> [    4.454918] amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta 
>>> ucode is not available
>>> [    4.454923] amdgpu 0000:05:00.0: amdgpu: SECUREDISPLAY: 
>>> securedisplay ta ucode is not available
>>> [    4.486110] amdgpu 0000:05:00.0: amdgpu: SMU is initialized 
>>> successfully!
>>> [    4.486114] [drm] Seamless boot condition check passed
>>> [    4.487235] [drm] Display Core v3.2.291 initialized on DCN 3.1.4
>>> [    4.487237] [drm] DP-HDMI FRL PCON supported
>>> [    4.489618] [drm] DMUB hardware initialized: version=0x08004300
>>> [    4.609752] [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 
>>> DPCD caps 0x0 su_y_granularity 0
>>> [    4.618805] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>>> [    4.618817] kfd kfd: amdgpu: Total number of KFD nodes to be 
>>> created: 1
>>> [    4.619278] amdgpu: Virtual CRAT table created for GPU
>>> [    4.619420] amdgpu: Topology: Add dGPU node [0x15bf:0x1002]
>>> [    4.619423] kfd kfd: amdgpu: added device 1002:15bf
>>> [    4.619434] amdgpu 0000:05:00.0: amdgpu: SE 1, SH per SE 2, CU per 
>>> SH 6, active_cu_number 12
>>> [    4.619440] amdgpu 0000:05:00.0: amdgpu: ring gfx_0.0.0 uses VM 
>>> inv eng 0 on hub 0
>>> [    4.619442] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM 
>>> inv eng 1 on hub 0
>>> [    4.619443] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM 
>>> inv eng 4 on hub 0
>>> [    4.619444] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM 
>>> inv eng 6 on hub 0
>>> [    4.619446] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM 
>>> inv eng 7 on hub 0
>>> [    4.619447] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM 
>>> inv eng 8 on hub 0
>>> [    4.619448] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM 
>>> inv eng 9 on hub 0
>>> [    4.619449] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM 
>>> inv eng 10 on hub 0
>>> [    4.619450] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM 
>>> inv eng 11 on hub 0
>>> [    4.619451] amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv 
>>> eng 12 on hub 0
>>> [    4.619453] amdgpu 0000:05:00.0: amdgpu: ring vcn_unified_0 uses 
>>> VM inv eng 0 on hub 8
>>> [    4.619454] amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv 
>>> eng 1 on hub 8
>>> [    4.619455] amdgpu 0000:05:00.0: amdgpu: ring mes_kiq_3.1.0 uses 
>>> VM inv eng 13 on hub 0
>>> [    4.840160] [drm] ring gfx_32768.1.1 was added
>>> [    4.840455] [drm] ring compute_32768.2.2 was added
>>> [    4.840820] [drm] ring sdma_32768.3.3 was added
>>> [    4.840886] [drm] ring gfx_32768.1.1 ib test pass
>>> [    4.840949] [drm] ring compute_32768.2.2 ib test pass
>>> [    4.841008] [drm] ring sdma_32768.3.3 ib test pass
>>> [    4.843478] amdgpu 0000:05:00.0: amdgpu: Runtime PM not available
>>> [    5.049671] [drm] Initialized amdgpu 3.58.0 for 0000:05:00.0 on 
>>> minor 1
>>> [    5.054858] fbcon: amdgpudrmfb (fb0) is primary device
>>> [    5.054864] fbcon: Deferring console take-over
>>> [    5.054867] amdgpu 0000:05:00.0: [drm] fb0: amdgpudrmfb frame 
>>> buffer device
>>> [    5.150430] [drm] DSC precompute is not needed.
>>> [    6.324880] Key type trusted registered
>>> [    6.576267] Key type encrypted registered
>>> [    6.596406] raid6: skipped pq benchmark and selected avx512x4
>>> [    6.596408] raid6: using avx512x2 recovery algorithm
>>> [    6.598434] xor: automatically using best checksumming function   
>>> avx
>>> [    6.661318] Btrfs loaded, zoned=yes, fsverity=yes
>>> [    6.661758] BTRFS: device fsid 
>>> bec7d079-0b9c-458f-889a-df146ded0246 devid 2 transid 16880 /dev/dm-1 
>>> (254:1) scanned by (udev-worker) (224)
>>> [    6.661876] BTRFS: device fsid 
>>> bec7d079-0b9c-458f-889a-df146ded0246 devid 1 transid 16880 /dev/dm-0 
>>> (254:0) scanned by (udev-worker) (314)
>>> [    6.721576] BTRFS info (device dm-0): first mount of filesystem 
>>> bec7d079-0b9c-458f-889a-df146ded0246
>>> [    6.721603] BTRFS info (device dm-0): using crc32c (crc32c-intel) 
>>> checksum algorithm
>>> [    6.721609] BTRFS info (device dm-0): using free-space-tree
>>> [    6.947578] systemd-journald[191]: Received SIGTERM from PID 1 
>>> (systemd).
>>> [    7.023125] systemd[1]: systemd 256.6-1-arch running in system 
>>> mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT 
>>> +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
>>> +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 
>>> +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD 
>>> +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
>>> [    7.023134] systemd[1]: Detected architecture x86-64.
>>> [    7.023516] systemd[1]: Hostname set to <jerrypop>.
>>> [    7.189099] systemd[1]: bpf-restrict-fs: LSM BPF program attached
>>> [    7.362520] systemd[1]: 
>>> run-credentials-systemd\x2djournald.service.mount: Deactivated 
>>> successfully.
>>> [    7.362730] systemd[1]: initrd-switch-root.service: Deactivated 
>>> successfully.
>>> [    7.362834] systemd[1]: Stopped Switch Root.
>>> [    7.363314] systemd[1]: systemd-journald.service: Scheduled 
>>> restart job, restart counter is at 1.
>>> [    7.363584] systemd[1]: Created slice Slice /system/dirmngr.
>>> [    7.363815] systemd[1]: Created slice Slice /system/getty.
>>> [    7.364036] systemd[1]: Created slice Slice /system/gpg-agent.
>>> [    7.364241] systemd[1]: Created slice Slice 
>>> /system/gpg-agent-browser.
>>> [    7.364443] systemd[1]: Created slice Slice 
>>> /system/gpg-agent-extra.
>>> [    7.364651] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
>>> [    7.364847] systemd[1]: Created slice Slice /system/keyboxd.
>>> [    7.365045] systemd[1]: Created slice Slice /system/modprobe.
>>> [    7.365196] systemd[1]: Created slice User and Session Slice.
>>> [    7.365213] systemd[1]: Dispatch Password Requests to Console 
>>> Directory Watch was skipped because of an unmet condition check 
>>> (ConditionPathExists=!/run/plymouth/pid).
>>> [    7.365242] systemd[1]: Started Forward Password Requests to Wall 
>>> Directory Watch.
>>> [    7.365360] systemd[1]: Set up automount Arbitrary Executable File 
>>> Formats File System Automount Point.
>>> [    7.365377] systemd[1]: Expecting device 
>>> /dev/disk/by-uuid/DCAE-BB86...
>>> [    7.365390] systemd[1]: Reached target Local Encrypted Volumes.
>>> [    7.365403] systemd[1]: Reached target Login Prompts.
>>> [    7.365417] systemd[1]: Stopped target Switch Root.
>>> [    7.365429] systemd[1]: Stopped target Initrd File Systems.
>>> [    7.365439] systemd[1]: Stopped target Initrd Root File System.
>>> [    7.365450] systemd[1]: Reached target Local Integrity Protected 
>>> Volumes.
>>> [    7.365468] systemd[1]: Reached target Path Units.
>>> [    7.365480] systemd[1]: Reached target Remote File Systems.
>>> [    7.365491] systemd[1]: Reached target Slice Units.
>>> [    7.365505] systemd[1]: Reached target Swaps.
>>> [    7.365520] systemd[1]: Reached target Local Verity Protected 
>>> Volumes.
>>> [    7.365566] systemd[1]: Listening on Device-mapper event daemon 
>>> FIFOs.
>>> [    7.366832] systemd[1]: Listening on Process Core Dump Socket.
>>> [    7.367147] systemd[1]: Listening on Credential 
>>> Encryption/Decryption.
>>> [    7.367191] systemd[1]: TPM PCR Measurements was skipped because 
>>> of an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.367199] systemd[1]: Make TPM PCR Policy was skipped because of 
>>> an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.367242] systemd[1]: Listening on udev Control Socket.
>>> [    7.367280] systemd[1]: Listening on udev Kernel Socket.
>>> [    7.367322] systemd[1]: Listening on User Database Manager Socket.
>>> [    7.368388] systemd[1]: Mounting Huge Pages File System...
>>> [    7.368891] systemd[1]: Mounting POSIX Message Queue File 
>>> System...
>>> [    7.369424] systemd[1]: Mounting Kernel Debug File System...
>>> [    7.370023] systemd[1]: Mounting Kernel Trace File System...
>>> [    7.370890] systemd[1]: Mounting Temporary Directory /tmp...
>>> [    7.371944] systemd[1]: Starting Create List of Static Device 
>>> Nodes...
>>> [    7.435072] systemd[1]: Starting Load Kernel Module configfs...
>>> [    7.437706] systemd[1]: Starting Load Kernel Module dm_mod...
>>> [    7.439267] systemd[1]: Starting Load Kernel Module drm...
>>> [    7.440383] systemd[1]: Starting Load Kernel Module fuse...
>>> [    7.441228] systemd[1]: Starting Load Kernel Module loop...
>>> [    7.442287] systemd[1]: Starting Mullvad early boot network 
>>> blocker...
>>> [    7.442370] systemd[1]: plymouth-switch-root.service: Deactivated 
>>> successfully.
>>> [    7.442454] systemd[1]: Stopped Plymouth switch root service.
>>> [    7.442581] systemd[1]: systemd-cryptsetup@root.service: 
>>> Deactivated successfully.
>>> [    7.442606] systemd[1]: Stopped systemd-cryptsetup@root.service.
>>> [    7.442697] systemd[1]: systemd-cryptsetup@root2.service: 
>>> Deactivated successfully.
>>> [    7.442719] systemd[1]: Stopped systemd-cryptsetup@root2.service.
>>> [    7.442803] systemd[1]: Clear Stale Hibernate Storage Info was 
>>> skipped because of an unmet condition check 
>>> (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
>>> [    7.443765] systemd[1]: Starting Journal Service...
>>> [    7.444838] systemd[1]: Starting Load Kernel Modules...
>>> [    7.444858] systemd[1]: TPM PCR Machine ID Measurement was skipped 
>>> because of an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.445297] systemd[1]: Starting Remount Root and Kernel File 
>>> Systems...
>>> [    7.445340] systemd[1]: Early TPM SRK Setup was skipped because of 
>>> an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.445815] systemd[1]: Starting Load udev Rules from 
>>> Credentials...
>>> [    7.446488] systemd[1]: Starting Coldplug All udev Devices...
>>> [    7.448079] systemd[1]: 
>>> run-credentials-systemd\x2dcryptsetup\x40root2.service.mount: 
>>> Deactivated successfully.
>>> [    7.448136] systemd[1]: 
>>> run-credentials-systemd\x2dcryptsetup\x40root.service.mount: 
>>> Deactivated successfully.
>>> [    7.449229] loop: module loaded
>>> [    7.449611] systemd[1]: Mounted Huge Pages File System.
>>> [    7.449696] systemd[1]: Mounted POSIX Message Queue File System.
>>> [    7.449772] systemd[1]: Mounted Kernel Debug File System.
>>> [    7.449844] systemd[1]: Mounted Kernel Trace File System.
>>> [    7.449918] systemd[1]: Mounted Temporary Directory /tmp.
>>> [    7.450171] systemd[1]: Finished Create List of Static Device 
>>> Nodes.
>>> [    7.450459] systemd[1]: modprobe@configfs.service: Deactivated 
>>> successfully.
>>> [    7.450622] systemd[1]: Finished Load Kernel Module configfs.
>>> [    7.450960] systemd[1]: modprobe@dm_mod.service: Deactivated 
>>> successfully.
>>> [    7.451117] systemd[1]: Finished Load Kernel Module dm_mod.
>>> [    7.451422] systemd[1]: modprobe@drm.service: Deactivated 
>>> successfully.
>>> [    7.451608] systemd[1]: Finished Load Kernel Module drm.
>>> [    7.451809] systemd[1]: modprobe@fuse.service: Deactivated 
>>> successfully.
>>> [    7.451936] systemd[1]: Finished Load Kernel Module fuse.
>>> [    7.452135] systemd[1]: modprobe@loop.service: Deactivated 
>>> successfully.
>>> [    7.452169] BTRFS info (device dm-0 state M): use zstd 
>>> compression, level 3
>>> [    7.452262] systemd[1]: Finished Load Kernel Module loop.
>>> [    7.452942] systemd[1]: Finished Remount Root and Kernel File 
>>> Systems.
>>> [    7.453203] systemd[1]: Finished Load udev Rules from Credentials.
>>> [    7.454343] systemd[1]: Mounting FUSE Control File System...
>>> [    7.454838] systemd[1]: Mounting Kernel Configuration File 
>>> System...
>>> [    7.455459] systemd[1]: Rebuild Hardware Database was skipped 
>>> because of an unmet condition check (ConditionNeedsUpdate=/etc).
>>> [    7.456326] systemd[1]: Starting Load/Save OS Random Seed...
>>> [    7.456383] systemd[1]: Repartition Root Disk was skipped because 
>>> no trigger condition checks were met.
>>> [    7.456951] systemd[1]: Starting Create Static Device Nodes in 
>>> /dev gracefully...
>>> [    7.456984] systemd[1]: TPM SRK Setup was skipped because of an 
>>> unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.457112] systemd-journald[443]: Collecting audit messages is 
>>> disabled.
>>> [    7.458165] i2c_dev: i2c /dev entries driver
>>> [    7.459553] systemd[1]: Mounted FUSE Control File System.
>>> [    7.459730] systemd[1]: Mounted Kernel Configuration File System.
>>> [    7.462117] Asymmetric key parser 'pkcs8' registered
>>> [    7.462120] systemd[1]: Started Journal Service.
>>> [    7.493228] systemd-journald[443]: Received client request to 
>>> flush runtime journal.
>>> [    7.709010] BTRFS info: devid 2 device path /dev/dm-1 changed to 
>>> /dev/mapper/root2 scanned by (udev-worker) (524)
>>> [    7.709669] BTRFS info: devid 1 device path /dev/mapper/root 
>>> changed to /dev/dm-0 scanned by (udev-worker) (518)
>>> [    7.710196] BTRFS info: devid 1 device path /dev/dm-0 changed to 
>>> /dev/mapper/root scanned by (udev-worker) (518)
>>> [    7.742977] input: Intel HID events as 
>>> /devices/platform/INT33D5:00/input/input4
>>> [    7.743158] intel-hid INT33D5:00: failed to enable HID power 
>>> button
>>> [    7.754204] amd-tee driver initialization successful
>>> [    7.755494] input: PC Speaker as 
>>> /devices/platform/pcspkr/input/input5
>>> [    7.763842] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 
>>> 163840 ms ovfl timer
>>> [    7.763846] RAPL PMU: hw unit of domain package 2^-16 Joules
>>> [    8.008813] piix4_smbus 0000:00:14.0: SMBus Host Controller at 
>>> 0xb00, revision 0
>>> [    8.008818] piix4_smbus 0000:00:14.0: Using register 0x02 for 
>>> SMBus port selection
>>> [    8.009143] input: PNP0C50:0b 0911:5288 Mouse as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input6
>>> [    8.009213] input: PNP0C50:0b 0911:5288 Touchpad as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input7
>>> [    8.009262] hid-generic 0018:0911:5288.0001: input,hidraw0: I2C 
>>> HID v1.00 Mouse [PNP0C50:0b 0911:5288] on i2c-PNP0C50:0b
>>> [    8.011141] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host 
>>> Controller at 0xb20
>>> [    8.011740] kvm_amd: TSC scaling supported
>>> [    8.011743] kvm_amd: Nested Virtualization enabled
>>> [    8.011745] kvm_amd: Nested Paging enabled
>>> [    8.011746] kvm_amd: LBR virtualization supported
>>> [    8.011751] kvm_amd: Virtual VMLOAD VMSAVE supported
>>> [    8.011752] kvm_amd: Virtual GIF supported
>>> [    8.011752] kvm_amd: Virtual NMI enabled
>>> [    8.020856] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
>>> [    8.020960] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog 
>>> MMIO address
>>> [    8.021091] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec 
>>> (nowayout=0)
>>> [    8.037986] amd-pmf AMDI0102:00: registered PMF device 
>>> successfully
>>> [    8.082040] cfg80211: Loading compiled-in X.509 certificates for 
>>> regulatory database
>>> [    8.082348] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>>> [    8.082639] Loaded X.509 cert 'wens: 
>>> 61c038651aabdcf94bd0ac7ff06c7248db18c600'
>>> [    8.082954] platform regulatory.0: Direct firmware load for 
>>> regulatory.db failed with error -2
>>> [    8.082961] cfg80211: failed to load regulatory.db
>>> [    8.095675] r8169 0000:02:00.0 eth0: RTL8168h/8111h, 
>>> 50:a1:32:3d:41:01, XID 541, IRQ 82
>>> [    8.095680] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 
>>> bytes, tx checksumming: ko]
>>> [    8.097031] r8169 0000:02:00.0 enp2s0: renamed from eth0
>>> [    8.126728] input: PNP0C50:0b 0911:5288 Mouse as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input8
>>> [    8.126796] input: PNP0C50:0b 0911:5288 Touchpad as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input9
>>> [    8.126848] hid-multitouch 0018:0911:5288.0001: input,hidraw0: I2C 
>>> HID v1.00 Mouse [PNP0C50:0b 0911:5288] on i2c-PNP0C50:0b
>>> [    8.133288] mousedev: PS/2 mouse device common for all mice
>>> [    8.133290] snd_hda_intel 0000:05:00.1: enabling device (0000 -> 
>>> 0002)
>>> [    8.133359] snd_hda_intel 0000:05:00.1: Handle vga_switcheroo 
>>> audio client
>>> [    8.133412] snd_hda_intel 0000:05:00.6: enabling device (0000 -> 
>>> 0002)
>>> [    8.143179] snd_hda_intel 0000:05:00.1: bound 0000:05:00.0 (ops 
>>> amdgpu_dm_audio_component_bind_ops [amdgpu])
>>> [    8.144202] input: HD-Audio Generic HDMI/DP,pcm=3 as 
>>> /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input10
>>> [    8.152228] snd_hda_codec_conexant hdaudioC1D0: CX11970: BIOS 
>>> auto-probing.
>>> [    8.152875] snd_hda_codec_conexant hdaudioC1D0: autoconfig for 
>>> CX11970: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
>>> [    8.152878] snd_hda_codec_conexant hdaudioC1D0:    speaker_outs=0 
>>> (0x0/0x0/0x0/0x0/0x0)
>>> [    8.152879] snd_hda_codec_conexant hdaudioC1D0:    hp_outs=1 
>>> (0x16/0x0/0x0/0x0/0x0)
>>> [    8.152881] snd_hda_codec_conexant hdaudioC1D0:    mono: 
>>> mono_out=0x0
>>> [    8.152882] snd_hda_codec_conexant hdaudioC1D0:    inputs:
>>> [    8.152883] snd_hda_codec_conexant hdaudioC1D0:      Mic=0x19
>>> [    8.155105] mt7921e 0000:03:00.0: enabling device (0000 -> 0002)
>>> [    8.158543] input: HD-Audio Generic Mic as 
>>> /devices/pci0000:00/0000:00:08.1/0000:05:00.6/sound/card1/input11
>>> [    8.158615] input: HD-Audio Generic Headphone as 
>>> /devices/pci0000:00/0000:00:08.1/0000:05:00.6/sound/card1/input12
>>> [    8.159432] snd_pci_ps 0000:05:00.5: enabling device (0000 -> 
>>> 0002)
>>> [    8.160323] mt7921e 0000:03:00.0: ASIC revision: 79610010
>>> [    8.222450] intel_rapl_common: Found RAPL domain package
>>> [    8.222456] intel_rapl_common: Found RAPL domain core
>>> [    8.222789] amd_atl: AMD Address Translation Library initialized
>>> [    8.237076] mt7921e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build 
>>> Time: 20240826150948a
>>> 
>>> [    8.248573] mt7921e 0000:03:00.0: WM Firmware Version: ____010000, 
>>> Build Time: 20240826151030
>>> [    8.427618] FAT-fs (nvme1n1p1): Volume was not properly unmounted. 
>>> Some data may be corrupt. Please run fsck.
>>> [    8.810495] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY 
>>> driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
>>> [    8.860186] Bluetooth: Core ver 2.22
>>> [    8.860209] NET: Registered PF_BLUETOOTH protocol family
>>> [    8.860210] Bluetooth: HCI device and connection manager 
>>> initialized
>>> [    8.860213] Bluetooth: HCI socket layer initialized
>>> [    8.860215] Bluetooth: L2CAP socket layer initialized
>>> [    8.860218] Bluetooth: SCO socket layer initialized
>>> [    8.876294] usbcore: registered new interface driver btusb
>>> [    8.927836] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build 
>>> Time: 20240826151221
>>> [    8.952167] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>>> [    8.952172] Bluetooth: BNEP filters: protocol multicast
>>> [    8.952177] Bluetooth: BNEP socket layer initialized
>>> [    9.014305] r8169 0000:02:00.0 enp2s0: Link is Down
>>> [   11.186750] Bluetooth: hci0: Device setup in 2256284 usecs
>>> [   11.186762] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
>>> Connection command is advertised, but not supported.
>>> [   11.258358] Bluetooth: hci0: AOSP extensions version v1.00
>>> [   11.258371] Bluetooth: hci0: AOSP quality report is supported
>>> [   11.258635] Bluetooth: MGMT ver 1.23
>>> [   11.265128] NET: Registered PF_ALG protocol family
>>> [   12.824444] wlan0: authenticate with 62:22:32:27:0c:95 (local 
>>> address=c8:94:02:13:e2:05)
>>> [   12.943006] wlan0: send auth to 62:22:32:27:0c:95 (try 1/3)
>>> [   12.946133] wlan0: authenticated
>>> [   12.947154] wlan0: associate with 62:22:32:27:0c:95 (try 1/3)
>>> [   12.956680] wlan0: RX AssocResp from 62:22:32:27:0c:95 
>>> (capab=0x431 status=0 aid=2)
>>> [   12.971939] wlan0: associated
>>> [   13.363917] wireguard: WireGuard 1.0.0 loaded. See 
>>> www.wireguard.com for information.
>>> [   13.363921] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld 
>>> <Jason@zx2c4.com>. All Rights Reserved.
>>> [   18.511996] overlayfs: "xino" feature enabled using 2 upper inode 
>>> bits.
>>> [   18.580208] overlayfs: "xino" feature enabled using 2 upper inode 
>>> bits.
>>> [   19.586015] Bluetooth: RFCOMM TTY layer initialized
>>> [   19.586026] Bluetooth: RFCOMM socket layer initialized
>>> [   19.586034] Bluetooth: RFCOMM ver 1.11
>>> [   19.960909] block nvme0n1: No UUID available providing old NGUID
>>> [   20.900576] warning: `kdeconnectd' uses wireless extensions which 
>>> will stop working for Wi-Fi 7 hardware; use nl80211
>>> [    0.000000] Linux version 6.11.0-arch1-1 (linux@archlinux) (gcc 
>>> (GCC) 14.2.1 20240910, GNU ld (GNU Binutils) 2.43.0) #1 SMP 
>>> PREEMPT_DYNAMIC Sun, 15 Sep 2024 18:38:36 +0000
>>> [    0.000000] Command line: initrd=\initramfs-linux.img 
>>> initrd=\amd-ucode.img ro 
>>> rd.luks.name=97a0672e-59e7-4e70-94e3-b261fb372de3=root 
>>> rd.luks.name=a17f7cbf-2762-4b33-a2bc-054e1e336a25=root2 
>>> root=/dev/mapper/root rootflags=subvol=root rd.luks.options=discard 
>>> add_efi_memmap quiet splash
>>> [    0.000000] BIOS-provided physical RAM map:
>>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009a7efff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x0000000009a7f000-0x0000000009ffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a23bfff] 
>>> ACPI NVS
>>> [    0.000000] BIOS-e820: [mem 0x000000000a23c000-0x000000008f5d6fff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000008f5d7000-0x0000000092134fff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x0000000092135000-0x00000000921a8fff] 
>>> ACPI data
>>> [    0.000000] BIOS-e820: [mem 0x00000000921a9000-0x000000009721efff] 
>>> ACPI NVS
>>> [    0.000000] BIOS-e820: [mem 0x000000009721f000-0x000000009adfefff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009adff000-0x000000009bff8fff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000009bff9000-0x000000009bffcfff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009bffd000-0x000000009bffefff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000009bfff000-0x000000009cffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009d790000-0x000000009d7effff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x000000009d7f5000-0x000000009fffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] 
>>> reserved
>>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083e2fffff] 
>>> usable
>>> [    0.000000] BIOS-e820: [mem 0x000000083f340000-0x00000008801fffff] 
>>> reserved
>>> [    0.000000] NX (Execute Disable) protection: active
>>> [    0.000000] APIC: Static calls initialized
>>> [    0.000000] e820: update [mem 0x8820f018-0x88212057] usable ==> 
>>> usable
>>> [    0.000000] extended physical RAM map:
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000000000000-0x000000000009ffff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000000a0000-0x00000000000fffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000000100000-0x0000000009a7efff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000009a7f000-0x0000000009ffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000000a000000-0x000000000a1fffff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000000a200000-0x000000000a23bfff] ACPI NVS
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000000a23c000-0x000000008820f017] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000008820f018-0x0000000088212057] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000088212058-0x000000008f5d6fff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000008f5d7000-0x0000000092134fff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000092135000-0x00000000921a8fff] ACPI data
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000921a9000-0x000000009721efff] ACPI NVS
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009721f000-0x000000009adfefff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009adff000-0x000000009bff8fff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009bff9000-0x000000009bffcfff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009bffd000-0x000000009bffefff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009bfff000-0x000000009cffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009d790000-0x000000009d7effff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000009d7f5000-0x000000009fffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000e0000000-0x00000000efffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x00000000fd000000-0x00000000ffffffff] reserved
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x0000000100000000-0x000000083e2fffff] usable
>>> [    0.000000] reserve setup_data: [mem 
>>> 0x000000083f340000-0x00000008801fffff] reserved
>>> [    0.000000] efi: EFI v2.8 by American Megatrends
>>> [    0.000000] efi: ACPI=0x97205000 ACPI 2.0=0x97205014 
>>> TPMFinalLog=0x971d4000 SMBIOS=0x9ab7c000 SMBIOS 3.0=0x9ab7b000 
>>> MEMATTR=0x88238018 ESRT=0x8e5c6b98 RNG=0x9214bf18 INITRD=0x8823bb18 
>>> TPMEventLog=0x88213018
>>> [    0.000000] random: crng init done
>>> [    0.000000] efi: Remove mem55: MMIO range=[0xe0000000-0xefffffff] 
>>> (256MB) from e820 map
>>> [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
>>> [    0.000000] efi: Remove mem56: MMIO range=[0xfd000000-0xfedfffff] 
>>> (30MB) from e820 map
>>> [    0.000000] e820: remove [mem 0xfd000000-0xfedfffff] reserved
>>> [    0.000000] efi: Not removing mem57: MMIO 
>>> range=[0xfee00000-0xfee00fff] (4KB) from e820 map
>>> [    0.000000] efi: Remove mem58: MMIO range=[0xfee01000-0xffffffff] 
>>> (17MB) from e820 map
>>> [    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
>>> [    0.000000] efi: Remove mem60: MMIO 
>>> range=[0x860000000-0x8801fffff] (514MB) from e820 map
>>> [    0.000000] e820: remove [mem 0x860000000-0x8801fffff] reserved
>>> [    0.000000] SMBIOS 3.5.0 present.
>>> [    0.000000] DMI: System76 Pangolin/Pangolin, BIOS 
>>> APX928_V00.01_T0008ASY1_ms 09/27/2023
>>> [    0.000000] DMI: Memory slots populated: 4/4
>>> [    0.000000] tsc: Fast TSC calibration using PIT
>>> [    0.000000] tsc: Detected 3293.894 MHz processor
>>> [    0.000073] e820: update [mem 0x00000000-0x00000fff] usable ==> 
>>> reserved
>>> [    0.000075] e820: remove [mem 0x000a0000-0x000fffff] usable
>>> [    0.000082] last_pfn = 0x83e300 max_arch_pfn = 0x400000000
>>> [    0.000088] MTRR map: 5 entries (3 fixed + 2 variable; max 20), 
>>> built from 9 variable MTRRs
>>> [    0.000091] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  
>>> UC- WT
>>> [    0.000318] e820: update [mem 0xa0000000-0xffffffff] usable ==> 
>>> reserved
>>> [    0.000326] last_pfn = 0x9bfff max_arch_pfn = 0x400000000
>>> [    0.003993] esrt: Reserving ESRT space from 0x000000008e5c6b98 to 
>>> 0x000000008e5c6bf8.
>>> [    0.004000] e820: update [mem 0x8e5c6000-0x8e5c6fff] usable ==> 
>>> reserved
>>> [    0.004013] Using GB pages for direct mapping
>>> [    0.004671] Secure boot enabled
>>> [    0.004672] RAMDISK: [mem 0x7f320000-0x81e49fff]
>>> [    0.004859] ACPI: Early table checksum verification disabled
>>> [    0.004862] ACPI: RSDP 0x0000000097205014 000024 (v02 ALASKA)
>>> [    0.004866] ACPI: XSDT 0x0000000097204728 000144 (v01 ALASKA A M I 
>>>    01072009 AMI  01000013)
>>> [    0.004871] ACPI: FACP 0x000000009219E000 000114 (v06 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004875] ACPI: DSDT 0x0000000092190000 00DB39 (v02 ALASKA A M I 
>>>    01072009 INTL 20220331)
>>> [    0.004877] ACPI: FACS 0x00000000931C1000 000040
>>> [    0.004880] ACPI: SSDT 0x00000000921A0000 008416 (v02 AMD    
>>> AmdTable 00000002 MSFT 02000002)
>>> [    0.004882] ACPI: SSDT 0x000000009219F000 000221 (v02 ALASKA 
>>> CPUSSDT  01072009 AMI  01072009)
>>> [    0.004883] ACPI: FIDT 0x000000009218F000 00009C (v01 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004885] ACPI: MCFG 0x000000009218E000 00003C (v01 ALASKA A M I 
>>>    01072009 MSFT 00010013)
>>> [    0.004887] ACPI: FPDT 0x000000009218D000 000044 (v01 ALASKA A M I 
>>>    01072009 AMI  01000013)
>>> [    0.004889] ACPI: VFCT 0x0000000092189000 003084 (v01 ALASKA A M I 
>>>    00000001 AMD  33504F47)
>>> [    0.004891] ACPI: BGRT 0x0000000092188000 000038 (v01 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004892] ACPI: TPM2 0x0000000092187000 00004C (v04 ALASKA A M I 
>>>    00000001 AMI  00000000)
>>> [    0.004894] ACPI: SSDT 0x0000000092181000 00547E (v02 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004896] ACPI: CRAT 0x0000000092180000 000EE8 (v01 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004898] ACPI: CDIT 0x000000009217F000 000029 (v01 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004900] ACPI: SSDT 0x000000009217D000 0015C0 (v02 AMD    
>>> CPMDFIG2 00000001 INTL 20220331)
>>> [    0.004901] ACPI: SSDT 0x000000009217A000 002A87 (v02 AMD    
>>> CDFAAIG2 00000001 INTL 20220331)
>>> [    0.004903] ACPI: SSDT 0x0000000092178000 00144D (v02 AMD    
>>> CPMPMF   00000001 INTL 20220331)
>>> [    0.004905] ACPI: SSDT 0x0000000092177000 000CDE (v02 AMD    
>>> OEMACP   00000001 INTL 20220331)
>>> [    0.004907] ACPI: SSDT 0x0000000092176000 000634 (v02 AMD    
>>> OEMPMF   00000001 INTL 20220331)
>>> [    0.004908] ACPI: SSDT 0x000000009216C000 0096F8 (v02 AMD    
>>> CPMCMN   00000001 INTL 20220331)
>>> [    0.004910] ACPI: SSDT 0x000000009216B000 00073F (v02 AMD    NVME  
>>>    00000001 INTL 20220331)
>>> [    0.004912] ACPI: SSDT 0x000000009216A000 00073F (v02 AMD    NVME  
>>>    00000001 INTL 20220331)
>>> [    0.004914] ACPI: SSDT 0x0000000092169000 000952 (v02 AMD    
>>> GpMsSsdt 00000001 INTL 20220331)
>>> [    0.004916] ACPI: SSDT 0x0000000092168000 000057 (v02 AMD    GPP0  
>>>    00000001 INTL 20220331)
>>> [    0.004917] ACPI: SSDT 0x0000000092166000 0017DC (v02 AMD    UPEP  
>>>    00000001 INTL 20220331)
>>> [    0.004919] ACPI: WSMT 0x0000000092165000 000028 (v01 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004921] ACPI: APIC 0x0000000092164000 0000E8 (v05 ALASKA A M I 
>>>    01072009 AMI  00010013)
>>> [    0.004923] ACPI: IVRS 0x0000000092163000 0001A4 (v02 AMD    
>>> AmdTable 00000001 AMD  00000001)
>>> [    0.004925] ACPI: SSDT 0x0000000092162000 00094E (v02 AMD    
>>> CPMMSOSC 00000001 INTL 20220331)
>>> [    0.004926] ACPI: SSDT 0x0000000092161000 000EA5 (v02 AMD    
>>> CPMACPV5 00000001 INTL 20220331)
>>> [    0.004928] ACPI: SSDT 0x0000000092160000 000600 (v02 AMD    
>>> TOUCHPNL 00000001 INTL 20220331)
>>> [    0.004930] ACPI: SSDT 0x000000009215F000 000601 (v02 AMD    
>>> TOUCHPAD 00000001 INTL 20220331)
>>> [    0.004931] ACPI: SSDT 0x000000009215E000 0007D5 (v02 AMD    
>>> THERMAL0 00000001 INTL 20220331)
>>> [    0.004933] ACPI: SSDT 0x000000009215D000 000FEF (v02 AMD    
>>> GPP_PME_ 00000001 INTL 20220331)
>>> [    0.004935] ACPI: SSDT 0x0000000092153000 009837 (v02 AMD    
>>> INTGPP03 00000001 INTL 20220331)
>>> [    0.004937] ACPI: SSDT 0x000000009214E000 004FE3 (v02 AMD    
>>> INTGPP01 00000001 INTL 20220331)
>>> [    0.004938] ACPI: SSDT 0x000000009214D000 000A9F (v02 AMD    
>>> CPMGPIO0 00000001 INTL 20220331)
>>> [    0.004940] ACPI: SSDT 0x000000009214C000 00008D (v02 AMD    
>>> CPMMSLPI 00000001 INTL 20220331)
>>> [    0.004941] ACPI: Reserving FACP table memory at [mem 
>>> 0x9219e000-0x9219e113]
>>> [    0.004943] ACPI: Reserving DSDT table memory at [mem 
>>> 0x92190000-0x9219db38]
>>> [    0.004943] ACPI: Reserving FACS table memory at [mem 
>>> 0x931c1000-0x931c103f]
>>> [    0.004944] ACPI: Reserving SSDT table memory at [mem 
>>> 0x921a0000-0x921a8415]
>>> [    0.004944] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9219f000-0x9219f220]
>>> [    0.004945] ACPI: Reserving FIDT table memory at [mem 
>>> 0x9218f000-0x9218f09b]
>>> [    0.004945] ACPI: Reserving MCFG table memory at [mem 
>>> 0x9218e000-0x9218e03b]
>>> [    0.004946] ACPI: Reserving FPDT table memory at [mem 
>>> 0x9218d000-0x9218d043]
>>> [    0.004946] ACPI: Reserving VFCT table memory at [mem 
>>> 0x92189000-0x9218c083]
>>> [    0.004947] ACPI: Reserving BGRT table memory at [mem 
>>> 0x92188000-0x92188037]
>>> [    0.004947] ACPI: Reserving TPM2 table memory at [mem 
>>> 0x92187000-0x9218704b]
>>> [    0.004948] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92181000-0x9218647d]
>>> [    0.004948] ACPI: Reserving CRAT table memory at [mem 
>>> 0x92180000-0x92180ee7]
>>> [    0.004949] ACPI: Reserving CDIT table memory at [mem 
>>> 0x9217f000-0x9217f028]
>>> [    0.004949] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9217d000-0x9217e5bf]
>>> [    0.004950] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9217a000-0x9217ca86]
>>> [    0.004950] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92178000-0x9217944c]
>>> [    0.004951] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92177000-0x92177cdd]
>>> [    0.004951] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92176000-0x92176633]
>>> [    0.004952] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9216c000-0x921756f7]
>>> [    0.004952] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9216b000-0x9216b73e]
>>> [    0.004953] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9216a000-0x9216a73e]
>>> [    0.004953] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92169000-0x92169951]
>>> [    0.004954] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92168000-0x92168056]
>>> [    0.004954] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92166000-0x921677db]
>>> [    0.004955] ACPI: Reserving WSMT table memory at [mem 
>>> 0x92165000-0x92165027]
>>> [    0.004955] ACPI: Reserving APIC table memory at [mem 
>>> 0x92164000-0x921640e7]
>>> [    0.004956] ACPI: Reserving IVRS table memory at [mem 
>>> 0x92163000-0x921631a3]
>>> [    0.004956] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92162000-0x9216294d]
>>> [    0.004957] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92161000-0x92161ea4]
>>> [    0.004957] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92160000-0x921605ff]
>>> [    0.004958] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9215f000-0x9215f600]
>>> [    0.004958] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9215e000-0x9215e7d4]
>>> [    0.004959] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9215d000-0x9215dfee]
>>> [    0.004959] ACPI: Reserving SSDT table memory at [mem 
>>> 0x92153000-0x9215c836]
>>> [    0.004960] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9214e000-0x92152fe2]
>>> [    0.004960] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9214d000-0x9214da9e]
>>> [    0.004961] ACPI: Reserving SSDT table memory at [mem 
>>> 0x9214c000-0x9214c08c]
>>> [    0.005023] No NUMA configuration found
>>> [    0.005023] Faking a node at [mem 
>>> 0x0000000000000000-0x000000083e2fffff]
>>> [    0.005026] NODE_DATA(0) allocated [mem 0x83e2fb000-0x83e2fffff]
>>> [    0.005068] Zone ranges:
>>> [    0.005068]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>>> [    0.005070]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>>> [    0.005071]   Normal   [mem 0x0000000100000000-0x000000083e2fffff]
>>> [    0.005072]   Device   empty
>>> [    0.005072] Movable zone start for each node
>>> [    0.005073] Early memory node ranges
>>> [    0.005073]   node   0: [mem 
>>> 0x0000000000001000-0x000000000009ffff]
>>> [    0.005075]   node   0: [mem 
>>> 0x0000000000100000-0x0000000009a7efff]
>>> [    0.005075]   node   0: [mem 
>>> 0x000000000a000000-0x000000000a1fffff]
>>> [    0.005076]   node   0: [mem 
>>> 0x000000000a23c000-0x000000008f5d6fff]
>>> [    0.005077]   node   0: [mem 
>>> 0x000000009adff000-0x000000009bff8fff]
>>> [    0.005077]   node   0: [mem 
>>> 0x000000009bffd000-0x000000009bffefff]
>>> [    0.005078]   node   0: [mem 
>>> 0x0000000100000000-0x000000083e2fffff]
>>> [    0.005081] Initmem setup node 0 [mem 
>>> 0x0000000000001000-0x000000083e2fffff]
>>> [    0.005085] On node 0, zone DMA: 1 pages in unavailable ranges
>>> [    0.005097] On node 0, zone DMA: 96 pages in unavailable ranges
>>> [    0.005190] On node 0, zone DMA32: 1409 pages in unavailable 
>>> ranges
>>> [    0.006778] On node 0, zone DMA32: 60 pages in unavailable ranges
>>> [    0.006875] On node 0, zone DMA32: 14376 pages in unavailable 
>>> ranges
>>> [    0.006876] On node 0, zone DMA32: 4 pages in unavailable ranges
>>> [    0.029027] On node 0, zone Normal: 16385 pages in unavailable 
>>> ranges
>>> [    0.029071] On node 0, zone Normal: 7424 pages in unavailable 
>>> ranges
>>> [    0.029368] ACPI: PM-Timer IO Port: 0x808
>>> [    0.029376] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
>>> [    0.029390] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, 
>>> GSI 0-23
>>> [    0.029395] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, 
>>> GSI 24-55
>>> [    0.029397] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl 
>>> dfl)
>>> [    0.029398] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 high 
>>> edge)
>>> [    0.029399] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low 
>>> level)
>>> [    0.029402] ACPI: Using ACPI (MADT) for SMP configuration 
>>> information
>>> [    0.029410] e820: update [mem 0x8748a000-0x87a78fff] usable ==> 
>>> reserved
>>> [    0.029424] CPU topo: Max. logical packages:   1
>>> [    0.029425] CPU topo: Max. logical dies:       1
>>> [    0.029425] CPU topo: Max. dies per package:   1
>>> [    0.029428] CPU topo: Max. threads per core:   2
>>> [    0.029429] CPU topo: Num. cores per package:     8
>>> [    0.029430] CPU topo: Num. threads per package:  16
>>> [    0.029430] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
>>> [    0.029445] PM: hibernation: Registered nosave memory: [mem 
>>> 0x00000000-0x00000fff]
>>> [    0.029446] PM: hibernation: Registered nosave memory: [mem 
>>> 0x000a0000-0x000fffff]
>>> [    0.029448] PM: hibernation: Registered nosave memory: [mem 
>>> 0x09a7f000-0x09ffffff]
>>> [    0.029449] PM: hibernation: Registered nosave memory: [mem 
>>> 0x0a200000-0x0a23bfff]
>>> [    0.029450] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8748a000-0x87a78fff]
>>> [    0.029451] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8820f000-0x8820ffff]
>>> [    0.029452] PM: hibernation: Registered nosave memory: [mem 
>>> 0x88212000-0x88212fff]
>>> [    0.029453] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8e5c6000-0x8e5c6fff]
>>> [    0.029454] PM: hibernation: Registered nosave memory: [mem 
>>> 0x8f5d7000-0x92134fff]
>>> [    0.029454] PM: hibernation: Registered nosave memory: [mem 
>>> 0x92135000-0x921a8fff]
>>> [    0.029455] PM: hibernation: Registered nosave memory: [mem 
>>> 0x921a9000-0x9721efff]
>>> [    0.029455] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9721f000-0x9adfefff]
>>> [    0.029456] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9bff9000-0x9bffcfff]
>>> [    0.029457] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9bfff000-0x9cffffff]
>>> [    0.029458] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d000000-0x9d78ffff]
>>> [    0.029458] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d790000-0x9d7effff]
>>> [    0.029459] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d7f0000-0x9d7f4fff]
>>> [    0.029459] PM: hibernation: Registered nosave memory: [mem 
>>> 0x9d7f5000-0x9fffffff]
>>> [    0.029459] PM: hibernation: Registered nosave memory: [mem 
>>> 0xa0000000-0xfedfffff]
>>> [    0.029460] PM: hibernation: Registered nosave memory: [mem 
>>> 0xfee00000-0xfee00fff]
>>> [    0.029460] PM: hibernation: Registered nosave memory: [mem 
>>> 0xfee01000-0xffffffff]
>>> [    0.029462] [mem 0xa0000000-0xfedfffff] available for PCI devices
>>> [    0.029463] Booting paravirtualized kernel on bare hardware
>>> [    0.029465] clocksource: refined-jiffies: mask: 0xffffffff 
>>> max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
>>> [    0.033727] setup_percpu: NR_CPUS:320 nr_cpumask_bits:16 
>>> nr_cpu_ids:16 nr_node_ids:1
>>> [    0.034161] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 
>>> u524288
>>> [    0.034166] pcpu-alloc: s233472 r8192 d28672 u524288 
>>> alloc=1*2097152
>>> [    0.034167] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07
>>> [    0.034171] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15
>>> [    0.034184] Kernel command line: initrd=\initramfs-linux.img 
>>> initrd=\amd-ucode.img ro 
>>> rd.luks.name=97a0672e-59e7-4e70-94e3-b261fb372de3=root 
>>> rd.luks.name=a17f7cbf-2762-4b33-a2bc-054e1e336a25=root2 
>>> root=/dev/mapper/root rootflags=subvol=root rd.luks.options=discard 
>>> add_efi_memmap quiet splash
>>> [    0.034279] Unknown kernel command line parameters "splash", will 
>>> be passed to user space.
>>> [    0.035973] Dentry cache hash table entries: 4194304 (order: 13, 
>>> 33554432 bytes, linear)
>>> [    0.036656] Inode-cache hash table entries: 2097152 (order: 12, 
>>> 16777216 bytes, linear)
>>> [    0.036739] Fallback order for Node 0: 0
>>> [    0.036744] Built 1 zonelists, mobility grouping on.  Total pages: 
>>> 8185013
>>> [    0.036745] Policy zone: Normal
>>> [    0.036844] mem auto-init: stack:all(zero), heap alloc:on, heap 
>>> free:off
>>> [    0.036892] software IO TLB: area num 16.
>>> [    0.076337] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, 
>>> Nodes=1
>>> [    0.076377] ftrace: allocating 50625 entries in 198 pages
>>> [    0.085646] ftrace: allocated 198 pages with 4 groups
>>> [    0.085705] Dynamic Preempt: full
>>> [    0.085759] rcu: Preemptible hierarchical RCU implementation.
>>> [    0.085760] rcu: 	RCU restricting CPUs from NR_CPUS=320 to 
>>> nr_cpu_ids=16.
>>> [    0.085761] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
>>> [    0.085762] 	Trampoline variant of Tasks RCU enabled.
>>> [    0.085762] 	Rude variant of Tasks RCU enabled.
>>> [    0.085763] 	Tracing variant of Tasks RCU enabled.
>>> [    0.085763] rcu: RCU calculated value of scheduler-enlistment 
>>> delay is 30 jiffies.
>>> [    0.085764] rcu: Adjusting geometry for rcu_fanout_leaf=16, 
>>> nr_cpu_ids=16
>>> [    0.085774] RCU Tasks: Setting shift to 4 and lim to 1 
>>> rcu_task_cb_adjust=1.
>>> [    0.085776] RCU Tasks Rude: Setting shift to 4 and lim to 1 
>>> rcu_task_cb_adjust=1.
>>> [    0.085779] RCU Tasks Trace: Setting shift to 4 and lim to 1 
>>> rcu_task_cb_adjust=1.
>>> [    0.088657] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
>>> [    0.088872] rcu: srcu_init: Setting srcu_struct sizes based on 
>>> contention.
>>> [    0.089053] kfence: initialized - using 2097152 bytes for 255 
>>> objects at 0x(____ptrval____)-0x(____ptrval____)
>>> [    0.089091] Console: colour dummy device 80x25
>>> [    0.089093] printk: legacy console [tty0] enabled
>>> [    0.089131] ACPI: Core revision 20240322
>>> [    0.089332] APIC: Switch to symmetric I/O mode setup
>>> [    0.090120] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, 
>>> rdevid:160
>>> [    0.090122] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, 
>>> rdevid:160
>>> [    0.090122] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, 
>>> rdevid:160
>>> [    0.090123] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, 
>>> rdevid:160
>>> [    0.090124] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, 
>>> EFR2:0x0
>>> [    0.090733] x2apic: IRQ remapping doesn't support X2APIC mode
>>> [    0.091526] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>>> [    0.106001] clocksource: tsc-early: mask: 0xffffffffffffffff 
>>> max_cycles: 0x2f7ac43e849, max_idle_ns: 440795235415 ns
>>> [    0.106007] Calibrating delay loop (skipped), value calculated 
>>> using timer frequency.. 6590.27 BogoMIPS (lpj=10979646)
>>> [    0.106034] x86/cpu: User Mode Instruction Prevention (UMIP) 
>>> activated
>>> [    0.106303] LVT offset 1 assigned for vector 0xf9
>>> [    0.106502] LVT offset 2 assigned for vector 0xf4
>>> [    0.106550] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
>>> [    0.106551] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 
>>> 1GB 0
>>> [    0.106554] process: using mwait in idle threads
>>> [    0.106557] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
>>> __user pointer sanitization
>>> [    0.106561] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
>>> [    0.106562] Spectre V2 : Spectre v2 / SpectreRSB mitigation: 
>>> Filling RSB on context switch
>>> [    0.106565] Spectre V2 : mitigation: Enabling conditional Indirect 
>>> Branch Prediction Barrier
>>> [    0.106566] Spectre V2 : User space: Mitigation: STIBP always-on 
>>> protection
>>> [    0.106568] Speculative Store Bypass: Mitigation: Speculative 
>>> Store Bypass disabled via prctl
>>> [    0.106569] Speculative Return Stack Overflow: IBPB-extending 
>>> microcode not applied!
>>> [    0.106570] Speculative Return Stack Overflow: WARNING: See 
>>> https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for 
>>> mitigation options.
>>> [    0.106572] Speculative Return Stack Overflow: Vulnerable: Safe 
>>> RET, no microcode
>>> [    0.106579] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating 
>>> point registers'
>>> [    0.106580] x86/fpu: Supporting XSAVE feature 0x002: 'SSE 
>>> registers'
>>> [    0.106581] x86/fpu: Supporting XSAVE feature 0x004: 'AVX 
>>> registers'
>>> [    0.106582] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 
>>> opmask'
>>> [    0.106582] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 
>>> Hi256'
>>> [    0.106583] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 
>>> ZMM_Hi256'
>>> [    0.106584] x86/fpu: Supporting XSAVE feature 0x200: 'Protection 
>>> Keys User registers'
>>> [    0.106585] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow 
>>> User registers'
>>> [    0.106587] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>>> [    0.106589] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
>>> [    0.106590] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
>>> [    0.106591] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
>>> [    0.106591] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
>>> [    0.106592] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   
>>> 16
>>> [    0.106594] x86/fpu: Enabled xstate features 0xae7, context size 
>>> is 2456 bytes, using 'compacted' format.
>>> [    0.133389] Freeing SMP alternatives memory: 40K
>>> [    0.133392] pid_max: default: 32768 minimum: 301
>>> [    0.136972] LSM: initializing 
>>> lsm=capability,landlock,lockdown,yama,bpf
>>> [    0.137003] landlock: Up and running.
>>> [    0.137005] Yama: becoming mindful.
>>> [    0.137010] LSM support for eBPF active
>>> [    0.137058] Mount-cache hash table entries: 65536 (order: 7, 
>>> 524288 bytes, linear)
>>> [    0.137083] Mountpoint-cache hash table entries: 65536 (order: 7, 
>>> 524288 bytes, linear)
>>> [    0.244193] smpboot: CPU0: AMD Ryzen 7 7840U w/ Radeon 780M 
>>> Graphics (family: 0x19, model: 0x74, stepping: 0x1)
>>> [    0.244458] Performance Events: Fam17h+ 16-deep LBR, core perfctr, 
>>> AMD PMU driver.
>>> [    0.244489] ... version:                2
>>> [    0.244491] ... bit width:              48
>>> [    0.244493] ... generic registers:      6
>>> [    0.244494] ... value mask:             0000ffffffffffff
>>> [    0.244495] ... max period:             00007fffffffffff
>>> [    0.244496] ... fixed-purpose events:   0
>>> [    0.244497] ... event mask:             000000000000003f
>>> [    0.244595] signal: max sigframe size: 3376
>>> [    0.244624] rcu: Hierarchical SRCU implementation.
>>> [    0.244625] rcu: 	Max phase no-delay instances is 1000.
>>> [    0.244702] Timer migration: 2 hierarchy levels; 8 children per 
>>> group; 2 crossnode level
>>> [    0.246005] MCE: In-kernel MCE decoding enabled.
>>> [    0.246005] NMI watchdog: Enabled. Permanently consumes one hw-PMU 
>>> counter.
>>> [    0.246005] smp: Bringing up secondary CPUs ...
>>> [    0.246005] smpboot: x86: Booting SMP configuration:
>>> [    0.246005] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7 
>>>  #8  #9 #10 #11 #12 #13 #14 #15
>>> [    0.264674] Spectre V2 : Update user space SMT mitigation: STIBP 
>>> always-on
>>> [    0.279382] smp: Brought up 1 node, 16 CPUs
>>> [    0.279382] smpboot: Total of 16 processors activated (105446.46 
>>> BogoMIPS)
>>> [    0.282857] Memory: 31986728K/32740052K available (18432K kernel 
>>> code, 2187K rwdata, 13516K rodata, 3452K init, 3432K bss, 734360K 
>>> reserved, 0K cma-reserved)
>>> [    0.283284] devtmpfs: initialized
>>> [    0.283284] x86/mm: Memory block size: 128MB
>>> [    0.287064] ACPI: PM: Registering ACPI NVS region [mem 
>>> 0x0a200000-0x0a23bfff] (245760 bytes)
>>> [    0.287064] ACPI: PM: Registering ACPI NVS region [mem 
>>> 0x921a9000-0x9721efff] (84369408 bytes)
>>> [    0.287064] clocksource: jiffies: mask: 0xffffffff max_cycles: 
>>> 0xffffffff, max_idle_ns: 6370867519511994 ns
>>> [    0.287064] futex hash table entries: 4096 (order: 6, 262144 
>>> bytes, linear)
>>> [    0.287064] pinctrl core: initialized pinctrl subsystem
>>> [    0.287192] PM: RTC time: 15:10:49, date: 2024-09-16
>>> [    0.287548] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>>> [    0.287866] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic 
>>> allocations
>>> [    0.287999] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for 
>>> atomic allocations
>>> [    0.288127] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool 
>>> for atomic allocations
>>> [    0.288127] audit: initializing netlink subsys (disabled)
>>> [    0.288134] audit: type=2000 audit(1726499449.196:1): 
>>> state=initialized audit_enabled=0 res=1
>>> [    0.288134] thermal_sys: Registered thermal governor 'fair_share'
>>> [    0.288134] thermal_sys: Registered thermal governor 'bang_bang'
>>> [    0.288134] thermal_sys: Registered thermal governor 'step_wise'
>>> [    0.288134] thermal_sys: Registered thermal governor 'user_space'
>>> [    0.288134] thermal_sys: Registered thermal governor 
>>> 'power_allocator'
>>> [    0.289344] cpuidle: using governor ladder
>>> [    0.289346] cpuidle: using governor menu
>>> [    0.289448] acpiphp: ACPI Hot Plug PCI Controller Driver version: 
>>> 0.5
>>> [    0.289548] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 
>>> 0xe0000000) for domain 0000 [bus 00-ff]
>>> [    0.289565] PCI: Using configuration type 1 for base access
>>> [    0.289744] kprobes: kprobe jump-optimization is enabled. All 
>>> kprobes are optimized if possible.
>>> [    0.299103] HugeTLB: registered 1.00 GiB page size, pre-allocated 
>>> 0 pages
>>> [    0.299103] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB 
>>> page
>>> [    0.299103] HugeTLB: registered 2.00 MiB page size, pre-allocated 
>>> 0 pages
>>> [    0.299103] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB 
>>> page
>>> [    0.299677] ACPI: Added _OSI(Module Device)
>>> [    0.299677] ACPI: Added _OSI(Processor Device)
>>> [    0.299677] ACPI: Added _OSI(3.0 _SCP Extensions)
>>> [    0.299677] ACPI: Added _OSI(Processor Aggregator Device)
>>> [    0.322548] ACPI BIOS Error (bug): Failure creating named object 
>>> [\_SB.PCI0.GPP5.RTL8._RMV], AE_ALREADY_EXISTS (20240322/dswload2-326)
>>> [    0.322556] ACPI Error: AE_ALREADY_EXISTS, During name 
>>> lookup/catalog (20240322/psobject-220)
>>> [    0.322559] ACPI: Skipping parse of AML opcode: Method (0x0014)
>>> [    0.323745] ACPI BIOS Error (bug): Failure creating named object 
>>> [\_SB.I2CA.TPNL], AE_ALREADY_EXISTS (20240322/dswload2-326)
>>> [    0.323750] ACPI Error: AE_ALREADY_EXISTS, During name 
>>> lookup/catalog (20240322/psobject-220)
>>> [    0.323753] ACPI: Skipping parse of AML opcode: Device (0x5B82)
>>> [    0.323870] ACPI BIOS Error (bug): Failure creating named object 
>>> [\_SB.I2CD.TPDD], AE_ALREADY_EXISTS (20240322/dswload2-326)
>>> [    0.323875] ACPI Error: AE_ALREADY_EXISTS, During name 
>>> lookup/catalog (20240322/psobject-220)
>>> [    0.323877] ACPI: Skipping parse of AML opcode: Device (0x5B82)
>>> [    0.328918] ACPI: 25 ACPI AML tables successfully acquired and 
>>> loaded
>>> [    0.333869] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>>> [    0.352187] ACPI: EC: EC started
>>> [    0.352189] ACPI: EC: interrupt blocked
>>> [    0.792825] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>> [    0.792833] ACPI: \_SB_.PCI0.SBRG.H_EC: Boot DSDT EC used to 
>>> handle transactions
>>> [    0.792838] ACPI: Interpreter enabled
>>> [    0.792881] ACPI: PM: (supports S0 S4 S5)
>>> [    0.792885] ACPI: Using IOAPIC for interrupt routing
>>> [    0.795870] PCI: Using host bridge windows from ACPI; if 
>>> necessary, use "pci=nocrs" and report a bug
>>> [    0.795872] PCI: Ignoring E820 reservations for host bridge 
>>> windows
>>> [    0.796687] ACPI: Enabled 4 GPEs in block 00 to 1F
>>> [    0.798633] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
>>> [    0.801477] ACPI: \_SB_.PCI0.GPP8.P0NV: New power resource
>>> [    0.803272] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
>>> [    0.804273] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
>>> [    0.805198] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
>>> [    0.806192] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
>>> [    0.806568] ACPI: \_SB_.PCI0.GP17.PWRS: New power resource
>>> [    0.806964] ACPI: \_SB_.PCI0.GP17.VGA_.PWRS: New power resource
>>> [    0.807445] ACPI: \_SB_.PCI0.GP17.HDAU.PWRS: New power resource
>>> [    0.807846] ACPI: \_SB_.PCI0.GP17.ACP_.PWRS: New power resource
>>> [    0.808738] ACPI: \_SB_.PCI0.GP17.AZAL.PWRS: New power resource
>>> [    0.812673] ACPI: \_SB_.PCI0.GP17.XHC0.PWRS: New power resource
>>> [    0.812673] ACPI: \_SB_.PCI0.GP17.XHC1.PWRS: New power resource
>>> [    0.812899] ACPI: \_SB_.PCI0.GP19.XHC2.PWRS: New power resource
>>> [    0.814260] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
>>> [    0.815662] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
>>> [    0.817071] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
>>> [    0.818021] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
>>> [    0.834647] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>>> [    0.834654] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig 
>>> ASPM ClockPM Segments MSI EDR HPX-Type3]
>>> [    0.834793] acpi PNP0A08:00: _OSC: platform does not support 
>>> [SHPCHotplug AER LTR DPC]
>>> [    0.835048] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug 
>>> PME PCIeCapability]
>>> [    0.835949] PCI host bridge to bus 0000:00
>>> [    0.835954] pci_bus 0000:00: root bus resource [io  0x0000-0x03af 
>>> window]
>>> [    0.835956] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 
>>> window]
>>> [    0.835958] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df 
>>> window]
>>> [    0.835960] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff 
>>> window]
>>> [    0.835961] pci_bus 0000:00: root bus resource [mem 
>>> 0x000a0000-0x000dffff window]
>>> [    0.835963] pci_bus 0000:00: root bus resource [mem 
>>> 0xfa000000-0xfcffffff window]
>>> [    0.835965] pci_bus 0000:00: root bus resource [mem 
>>> 0xf0000000-0xf9ffffff window]
>>> [    0.835966] pci_bus 0000:00: root bus resource [mem 
>>> 0xa0000000-0xdfffffff window]
>>> [    0.835968] pci_bus 0000:00: root bus resource [mem 
>>> 0x860000000-0x7fffffffff window]
>>> [    0.835970] pci_bus 0000:00: root bus resource [bus 00-ff]
>>> [    0.835987] pci 0000:00:00.0: [1022:14e8] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.836116] pci 0000:00:00.2: [1022:14e9] type 00 class 0x080600 
>>> conventional PCI endpoint
>>> [    0.836233] pci 0000:00:01.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.836308] pci 0000:00:01.2: [1022:14ee] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.836328] pci 0000:00:01.2: PCI bridge to [bus 01]
>>> [    0.836335] pci 0000:00:01.2:   bridge window [mem 
>>> 0xfce00000-0xfcefffff]
>>> [    0.836351] pci 0000:00:01.2: enabling Extended Tags
>>> [    0.836408] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
>>> [    0.836569] pci 0000:00:02.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.836635] pci 0000:00:02.1: [1022:14ed] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.836653] pci 0000:00:02.1: PCI bridge to [bus 02]
>>> [    0.836658] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
>>> [    0.836660] pci 0000:00:02.1:   bridge window [mem 
>>> 0xfcd00000-0xfcdfffff]
>>> [    0.836674] pci 0000:00:02.1: enabling Extended Tags
>>> [    0.836725] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
>>> [    0.836854] pci 0000:00:02.2: [1022:14ed] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.836873] pci 0000:00:02.2: PCI bridge to [bus 03]
>>> [    0.836884] pci 0000:00:02.2:   bridge window [mem 
>>> 0x7ff0900000-0x7ff0afffff 64bit pref]
>>> [    0.836938] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
>>> [    0.837083] pci 0000:00:02.4: [1022:14ee] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.837104] pci 0000:00:02.4: PCI bridge to [bus 04]
>>> [    0.837110] pci 0000:00:02.4:   bridge window [mem 
>>> 0xfcc00000-0xfccfffff]
>>> [    0.837125] pci 0000:00:02.4: enabling Extended Tags
>>> [    0.837181] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
>>> [    0.837326] pci 0000:00:03.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.837398] pci 0000:00:04.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.837475] pci 0000:00:08.0: [1022:14ea] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.837541] pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.837558] pci 0000:00:08.1: PCI bridge to [bus 05]
>>> [    0.837563] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
>>> [    0.837565] pci 0000:00:08.1:   bridge window [mem 
>>> 0xfc400000-0xfc9fffff]
>>> [    0.837572] pci 0000:00:08.1:   bridge window [mem 
>>> 0x7fe0000000-0x7ff07fffff 64bit pref]
>>> [    0.837579] pci 0000:00:08.1: enabling Extended Tags
>>> [    0.837622] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
>>> [    0.837778] pci 0000:00:08.2: [1022:14eb] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.837828] pci 0000:00:08.2: PCI bridge to [bus 06]
>>> [    0.837844] pci 0000:00:08.2: enabling Extended Tags
>>> [    0.837887] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
>>> [    0.838004] pci 0000:00:08.3: [1022:14eb] type 01 class 0x060400 
>>> PCIe Root Port
>>> [    0.838021] pci 0000:00:08.3: PCI bridge to [bus 07]
>>> [    0.838027] pci 0000:00:08.3:   bridge window [mem 
>>> 0xfca00000-0xfcbfffff]
>>> [    0.838039] pci 0000:00:08.3: enabling Extended Tags
>>> [    0.838082] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
>>> [    0.838446] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 
>>> conventional PCI endpoint
>>> [    0.838592] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 
>>> conventional PCI endpoint
>>> [    0.838752] pci 0000:00:18.0: [1022:14f0] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.838794] pci 0000:00:18.1: [1022:14f1] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.838839] pci 0000:00:18.2: [1022:14f2] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.838881] pci 0000:00:18.3: [1022:14f3] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.838922] pci 0000:00:18.4: [1022:14f4] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.838962] pci 0000:00:18.5: [1022:14f5] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.839004] pci 0000:00:18.6: [1022:14f6] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.839047] pci 0000:00:18.7: [1022:14f7] type 00 class 0x060000 
>>> conventional PCI endpoint
>>> [    0.839361] pci 0000:01:00.0: [15b7:5030] type 00 class 0x010802 
>>> PCIe Endpoint
>>> [    0.839380] pci 0000:01:00.0: BAR 0 [mem 0xfce00000-0xfce03fff 
>>> 64bit]
>>> [    0.839672] pci 0000:00:01.2: PCI bridge to [bus 01]
>>> [    0.839746] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000 
>>> PCIe Endpoint
>>> [    0.839764] pci 0000:02:00.0: BAR 0 [io  0xf000-0xf0ff]
>>> [    0.839787] pci 0000:02:00.0: BAR 2 [mem 0xfcd04000-0xfcd04fff 
>>> 64bit]
>>> [    0.839802] pci 0000:02:00.0: BAR 4 [mem 0xfcd00000-0xfcd03fff 
>>> 64bit]
>>> [    0.839900] pci 0000:02:00.0: supports D1 D2
>>> [    0.839901] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot 
>>> D3cold
>>> [    0.840089] pci 0000:00:02.1: PCI bridge to [bus 02]
>>> [    0.840159] pci 0000:03:00.0: [14c3:0608] type 00 class 0x028000 
>>> PCIe Endpoint
>>> [    0.840179] pci 0000:03:00.0: BAR 0 [mem 0x7ff0900000-0x7ff09fffff 
>>> 64bit pref]
>>> [    0.840191] pci 0000:03:00.0: BAR 2 [mem 0x7ff0a00000-0x7ff0a03fff 
>>> 64bit pref]
>>> [    0.840203] pci 0000:03:00.0: BAR 4 [mem 0x7ff0a04000-0x7ff0a04fff 
>>> 64bit pref]
>>> [    0.840282] pci 0000:03:00.0: supports D1 D2
>>> [    0.840283] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot 
>>> D3cold
>>> [    0.840453] pci 0000:00:02.2: PCI bridge to [bus 03]
>>> [    0.840529] pci 0000:04:00.0: [2646:5017] type 00 class 0x010802 
>>> PCIe Endpoint
>>> [    0.840546] pci 0000:04:00.0: BAR 0 [mem 0xfcc00000-0xfcc03fff 
>>> 64bit]
>>> [    0.840789] pci 0000:00:02.4: PCI bridge to [bus 04]
>>> [    0.840912] pci 0000:05:00.0: [1002:15bf] type 00 class 0x030000 
>>> PCIe Legacy Endpoint
>>> [    0.840927] pci 0000:05:00.0: BAR 0 [mem 0x7fe0000000-0x7fefffffff 
>>> 64bit pref]
>>> [    0.840937] pci 0000:05:00.0: BAR 2 [mem 0xfc400000-0xfc5fffff 
>>> 64bit pref]
>>> [    0.840943] pci 0000:05:00.0: BAR 4 [io  0xe000-0xe0ff]
>>> [    0.840950] pci 0000:05:00.0: BAR 5 [mem 0xfc900000-0xfc97ffff]
>>> [    0.840961] pci 0000:05:00.0: enabling Extended Tags
>>> [    0.841030] pci 0000:05:00.0: PME# supported from D1 D2 D3hot 
>>> D3cold
>>> [    0.841193] pci 0000:05:00.1: [1002:1640] type 00 class 0x040300 
>>> PCIe Legacy Endpoint
>>> [    0.841203] pci 0000:05:00.1: BAR 0 [mem 0xfc9c8000-0xfc9cbfff]
>>> [    0.841231] pci 0000:05:00.1: enabling Extended Tags
>>> [    0.841272] pci 0000:05:00.1: PME# supported from D1 D2 D3hot 
>>> D3cold
>>> [    0.841383] pci 0000:05:00.2: [1022:15c7] type 00 class 0x108000 
>>> PCIe Endpoint
>>> [    0.841400] pci 0000:05:00.2: BAR 2 [mem 0xfc800000-0xfc8fffff]
>>> [    0.841412] pci 0000:05:00.2: BAR 5 [mem 0xfc9cc000-0xfc9cdfff]
>>> [    0.841422] pci 0000:05:00.2: enabling Extended Tags
>>> [    0.841571] pci 0000:05:00.3: [1022:15b9] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.841585] pci 0000:05:00.3: BAR 0 [mem 0xfc700000-0xfc7fffff 
>>> 64bit]
>>> [    0.841616] pci 0000:05:00.3: enabling Extended Tags
>>> [    0.841661] pci 0000:05:00.3: PME# supported from D0 D3hot D3cold
>>> [    0.841784] pci 0000:05:00.4: [1022:15ba] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.841798] pci 0000:05:00.4: BAR 0 [mem 0xfc600000-0xfc6fffff 
>>> 64bit]
>>> [    0.841829] pci 0000:05:00.4: enabling Extended Tags
>>> [    0.841873] pci 0000:05:00.4: PME# supported from D0 D3hot D3cold
>>> [    0.841989] pci 0000:05:00.5: [1022:15e2] type 00 class 0x048000 
>>> PCIe Endpoint
>>> [    0.841999] pci 0000:05:00.5: BAR 0 [mem 0xfc980000-0xfc9bffff]
>>> [    0.842011] pci 0000:05:00.5: BAR 2 [mem 0x7ff0000000-0x7ff07fffff 
>>> 64bit pref]
>>> [    0.842028] pci 0000:05:00.5: enabling Extended Tags
>>> [    0.842069] pci 0000:05:00.5: PME# supported from D0 D3hot D3cold
>>> [    0.842184] pci 0000:05:00.6: [1022:15e3] type 00 class 0x040300 
>>> PCIe Endpoint
>>> [    0.842194] pci 0000:05:00.6: BAR 0 [mem 0xfc9c0000-0xfc9c7fff]
>>> [    0.842222] pci 0000:05:00.6: enabling Extended Tags
>>> [    0.842263] pci 0000:05:00.6: PME# supported from D0 D3hot D3cold
>>> [    0.842398] pci 0000:00:08.1: PCI bridge to [bus 05]
>>> [    0.842457] pci 0000:06:00.0: [1022:14ec] type 00 class 0x130000 
>>> PCIe Endpoint
>>> [    0.842492] pci 0000:06:00.0: enabling Extended Tags
>>> [    0.842546] pci 0000:06:00.0: PME# supported from D3hot D3cold
>>> [    0.842718] pci 0000:00:08.2: PCI bridge to [bus 06]
>>> [    0.842815] pci 0000:07:00.0: [1022:14ec] type 00 class 0x130000 
>>> PCIe Endpoint
>>> [    0.842851] pci 0000:07:00.0: enabling Extended Tags
>>> [    0.843039] pci 0000:07:00.3: [1022:15c0] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.843053] pci 0000:07:00.3: BAR 0 [mem 0xfcb00000-0xfcbfffff 
>>> 64bit]
>>> [    0.843084] pci 0000:07:00.3: enabling Extended Tags
>>> [    0.843129] pci 0000:07:00.3: PME# supported from D0 D3hot D3cold
>>> [    0.843243] pci 0000:07:00.4: [1022:15c1] type 00 class 0x0c0330 
>>> PCIe Endpoint
>>> [    0.843257] pci 0000:07:00.4: BAR 0 [mem 0xfca00000-0xfcafffff 
>>> 64bit]
>>> [    0.843288] pci 0000:07:00.4: enabling Extended Tags
>>> [    0.843332] pci 0000:07:00.4: PME# supported from D0 D3hot D3cold
>>> [    0.843454] pci 0000:00:08.3: PCI bridge to [bus 07]
>>> [    0.852209] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
>>> [    0.852295] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
>>> [    0.852372] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
>>> [    0.852464] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
>>> [    0.852548] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
>>> [    0.852620] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
>>> [    0.852693] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
>>> [    0.852765] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
>>> [    0.859441] Low-power S0 idle used by default for system suspend
>>> [    0.859652] ACPI: EC: interrupt unblocked
>>> [    0.859654] ACPI: EC: event unblocked
>>> [    0.859658] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
>>> [    0.859660] ACPI: EC: GPE=0x5
>>> [    0.859661] ACPI: \_SB_.PCI0.SBRG.H_EC: Boot DSDT EC 
>>> initialization complete
>>> [    0.859664] ACPI: \_SB_.PCI0.SBRG.H_EC: EC: Used to handle 
>>> transactions and events
>>> [    0.862691] iommu: Default domain type: Translated
>>> [    0.862691] iommu: DMA domain TLB invalidation policy: lazy mode
>>> [    0.862844] SCSI subsystem initialized
>>> [    0.862851] libata version 3.00 loaded.
>>> [    0.862851] ACPI: bus type USB registered
>>> [    0.862851] usbcore: registered new interface driver usbfs
>>> [    0.862851] usbcore: registered new interface driver hub
>>> [    0.862851] usbcore: registered new device driver usb
>>> [    0.869938] EDAC MC: Ver: 3.0.0
>>> [    0.872699] efivars: Registered efivars operations
>>> [    0.872932] NetLabel: Initializing
>>> [    0.872934] NetLabel:  domain hash size = 128
>>> [    0.872935] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
>>> [    0.872954] NetLabel:  unlabeled traffic allowed by default
>>> [    0.872960] mctp: management component transport protocol core
>>> [    0.872961] NET: Registered PF_MCTP protocol family
>>> [    0.872966] PCI: Using ACPI for IRQ routing
>>> [    0.880421] PCI: pci_cache_line_size set to 64 bytes
>>> [    0.880486] e820: reserve RAM buffer [mem 0x09a7f000-0x0bffffff]
>>> [    0.880489] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
>>> [    0.880490] e820: reserve RAM buffer [mem 0x8748a000-0x87ffffff]
>>> [    0.880492] e820: reserve RAM buffer [mem 0x8820f018-0x8bffffff]
>>> [    0.880493] e820: reserve RAM buffer [mem 0x8e5c6000-0x8fffffff]
>>> [    0.880494] e820: reserve RAM buffer [mem 0x8f5d7000-0x8fffffff]
>>> [    0.880495] e820: reserve RAM buffer [mem 0x9bff9000-0x9bffffff]
>>> [    0.880497] e820: reserve RAM buffer [mem 0x9bfff000-0x9bffffff]
>>> [    0.880498] e820: reserve RAM buffer [mem 0x83e300000-0x83fffffff]
>>> [    0.882703] pci 0000:05:00.0: vgaarb: setting as boot VGA device
>>> [    0.882703] pci 0000:05:00.0: vgaarb: bridge control possible
>>> [    0.882703] pci 0000:05:00.0: vgaarb: VGA device added: 
>>> decodes=io+mem,owns=none,locks=none
>>> [    0.882706] vgaarb: loaded
>>> [    0.882843] clocksource: Switched to clocksource tsc-early
>>> [    0.883714] VFS: Disk quotas dquot_6.6.0
>>> [    0.883726] VFS: Dquot-cache hash table entries: 512 (order 0, 
>>> 4096 bytes)
>>> [    0.883808] pnp: PnP ACPI init
>>> [    0.883918] system 00:00: [mem 0xe0000000-0xefffffff] has been 
>>> reserved
>>> [    0.886409] system 00:03: [io  0x04d0-0x04d1] has been reserved
>>> [    0.886412] system 00:03: [io  0x040b] has been reserved
>>> [    0.886414] system 00:03: [io  0x04d6] has been reserved
>>> [    0.886415] system 00:03: [io  0x0c00-0x0c01] has been reserved
>>> [    0.886417] system 00:03: [io  0x0c14] has been reserved
>>> [    0.886419] system 00:03: [io  0x0c50-0x0c51] has been reserved
>>> [    0.886420] system 00:03: [io  0x0c52] has been reserved
>>> [    0.886422] system 00:03: [io  0x0c6c] has been reserved
>>> [    0.886424] system 00:03: [io  0x0c6f] has been reserved
>>> [    0.886425] system 00:03: [io  0x0cd0-0x0cd1] has been reserved
>>> [    0.886427] system 00:03: [io  0x0cd2-0x0cd3] has been reserved
>>> [    0.886429] system 00:03: [io  0x0cd4-0x0cd5] has been reserved
>>> [    0.886430] system 00:03: [io  0x0cd6-0x0cd7] has been reserved
>>> [    0.886432] system 00:03: [io  0x0cd8-0x0cdf] has been reserved
>>> [    0.886434] system 00:03: [io  0x0800-0x089f] has been reserved
>>> [    0.886435] system 00:03: [io  0x0b00-0x0b0f] has been reserved
>>> [    0.886437] system 00:03: [io  0x0b20-0x0b3f] has been reserved
>>> [    0.886439] system 00:03: [io  0x0900-0x090f] has been reserved
>>> [    0.886440] system 00:03: [io  0x0910-0x091f] has been reserved
>>> [    0.886443] system 00:03: [mem 0xfec00000-0xfec00fff] could not be 
>>> reserved
>>> [    0.886445] system 00:03: [mem 0xfec01000-0xfec01fff] could not be 
>>> reserved
>>> [    0.886447] system 00:03: [mem 0xfedc0000-0xfedc0fff] has been 
>>> reserved
>>> [    0.886449] system 00:03: [mem 0xfee00000-0xfee00fff] has been 
>>> reserved
>>> [    0.886451] system 00:03: [mem 0xfed80000-0xfed8ffff] could not be 
>>> reserved
>>> [    0.886453] system 00:03: [mem 0xfec10000-0xfec10fff] has been 
>>> reserved
>>> [    0.886456] system 00:03: [mem 0xff000000-0xffffffff] has been 
>>> reserved
>>> [    0.888125] pnp: PnP ACPI: found 4 devices
>>> [    0.894564] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
>>> 0xffffff, max_idle_ns: 2085701024 ns
>>> [    0.894700] NET: Registered PF_INET protocol family
>>> [    0.894843] IP idents hash table entries: 262144 (order: 9, 
>>> 2097152 bytes, linear)
>>> [    0.908979] tcp_listen_portaddr_hash hash table entries: 16384 
>>> (order: 6, 262144 bytes, linear)
>>> [    0.909001] Table-perturb hash table entries: 65536 (order: 6, 
>>> 262144 bytes, linear)
>>> [    0.909037] TCP established hash table entries: 262144 (order: 9, 
>>> 2097152 bytes, linear)
>>> [    0.909279] TCP bind hash table entries: 65536 (order: 9, 2097152 
>>> bytes, linear)
>>> [    0.909365] TCP: Hash tables configured (established 262144 bind 
>>> 65536)
>>> [    0.909463] MPTCP token hash table entries: 32768 (order: 7, 
>>> 786432 bytes, linear)
>>> [    0.909519] UDP hash table entries: 16384 (order: 7, 524288 bytes, 
>>> linear)
>>> [    0.909575] UDP-Lite hash table entries: 16384 (order: 7, 524288 
>>> bytes, linear)
>>> [    0.909654] NET: Registered PF_UNIX/PF_LOCAL protocol family
>>> [    0.909661] NET: Registered PF_XDP protocol family
>>> [    0.909668] pci 0000:00:02.1: bridge window [mem 
>>> 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 
>>> add_align 100000
>>> [    0.909681] pci 0000:00:02.1: bridge window [mem 
>>> 0x860000000-0x8601fffff 64bit pref]: assigned
>>> [    0.909685] pci 0000:00:01.2: PCI bridge to [bus 01]
>>> [    0.909694] pci 0000:00:01.2:   bridge window [mem 
>>> 0xfce00000-0xfcefffff]
>>> [    0.909701] pci 0000:00:02.1: PCI bridge to [bus 02]
>>> [    0.909703] pci 0000:00:02.1:   bridge window [io  0xf000-0xffff]
>>> [    0.909707] pci 0000:00:02.1:   bridge window [mem 
>>> 0xfcd00000-0xfcdfffff]
>>> [    0.909709] pci 0000:00:02.1:   bridge window [mem 
>>> 0x860000000-0x8601fffff 64bit pref]
>>> [    0.909714] pci 0000:00:02.2: PCI bridge to [bus 03]
>>> [    0.909718] pci 0000:00:02.2:   bridge window [mem 
>>> 0x7ff0900000-0x7ff0afffff 64bit pref]
>>> [    0.909723] pci 0000:00:02.4: PCI bridge to [bus 04]
>>> [    0.909726] pci 0000:00:02.4:   bridge window [mem 
>>> 0xfcc00000-0xfccfffff]
>>> [    0.909734] pci 0000:00:08.1: PCI bridge to [bus 05]
>>> [    0.909736] pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
>>> [    0.909741] pci 0000:00:08.1:   bridge window [mem 
>>> 0xfc400000-0xfc9fffff]
>>> [    0.909744] pci 0000:00:08.1:   bridge window [mem 
>>> 0x7fe0000000-0x7ff07fffff 64bit pref]
>>> [    0.909748] pci 0000:00:08.2: PCI bridge to [bus 06]
>>> [    0.909755] pci 0000:00:08.3: PCI bridge to [bus 07]
>>> [    0.909758] pci 0000:00:08.3:   bridge window [mem 
>>> 0xfca00000-0xfcbfffff]
>>> [    0.909764] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
>>> [    0.909766] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
>>> [    0.909768] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
>>> [    0.909770] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
>>> [    0.909771] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff 
>>> window]
>>> [    0.909773] pci_bus 0000:00: resource 9 [mem 0xfa000000-0xfcffffff 
>>> window]
>>> [    0.909774] pci_bus 0000:00: resource 10 [mem 
>>> 0xf0000000-0xf9ffffff window]
>>> [    0.909776] pci_bus 0000:00: resource 11 [mem 
>>> 0xa0000000-0xdfffffff window]
>>> [    0.909778] pci_bus 0000:00: resource 12 [mem 
>>> 0x860000000-0x7fffffffff window]
>>> [    0.909780] pci_bus 0000:01: resource 1 [mem 
>>> 0xfce00000-0xfcefffff]
>>> [    0.909781] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
>>> [    0.909783] pci_bus 0000:02: resource 1 [mem 
>>> 0xfcd00000-0xfcdfffff]
>>> [    0.909785] pci_bus 0000:02: resource 2 [mem 
>>> 0x860000000-0x8601fffff 64bit pref]
>>> [    0.909786] pci_bus 0000:03: resource 2 [mem 
>>> 0x7ff0900000-0x7ff0afffff 64bit pref]
>>> [    0.909788] pci_bus 0000:04: resource 1 [mem 
>>> 0xfcc00000-0xfccfffff]
>>> [    0.909790] pci_bus 0000:05: resource 0 [io  0xe000-0xefff]
>>> [    0.909791] pci_bus 0000:05: resource 1 [mem 
>>> 0xfc400000-0xfc9fffff]
>>> [    0.909793] pci_bus 0000:05: resource 2 [mem 
>>> 0x7fe0000000-0x7ff07fffff 64bit pref]
>>> [    0.909795] pci_bus 0000:07: resource 1 [mem 
>>> 0xfca00000-0xfcbfffff]
>>> [    0.910217] pci 0000:05:00.1: D0 power state depends on 
>>> 0000:05:00.0
>>> [    0.910309] pci 0000:00:08.1: can't derive routing for PCI INT A
>>> [    0.910311] pci 0000:00:08.1: PCI INT A: not connected
>>> [    0.910579] pci 0000:00:08.3: can't derive routing for PCI INT A
>>> [    0.910581] pci 0000:00:08.3: PCI INT A: not connected
>>> [    0.910755] PCI: CLS 64 bytes, default 64
>>> [    0.910788] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters 
>>> supported
>>> [    0.910849] Trying to unpack rootfs image as initramfs...
>>> [    0.910859] pci 0000:00:01.0: Adding to iommu group 0
>>> [    0.910876] pci 0000:00:01.2: Adding to iommu group 1
>>> [    0.910903] pci 0000:00:02.0: Adding to iommu group 2
>>> [    0.910919] pci 0000:00:02.1: Adding to iommu group 3
>>> [    0.910935] pci 0000:00:02.2: Adding to iommu group 4
>>> [    0.910952] pci 0000:00:02.4: Adding to iommu group 5
>>> [    0.910976] pci 0000:00:03.0: Adding to iommu group 6
>>> [    0.910998] pci 0000:00:04.0: Adding to iommu group 7
>>> [    0.911027] pci 0000:00:08.0: Adding to iommu group 8
>>> [    0.911044] pci 0000:00:08.1: Adding to iommu group 9
>>> [    0.911060] pci 0000:00:08.2: Adding to iommu group 10
>>> [    0.911076] pci 0000:00:08.3: Adding to iommu group 11
>>> [    0.911105] pci 0000:00:14.0: Adding to iommu group 12
>>> [    0.911123] pci 0000:00:14.3: Adding to iommu group 12
>>> [    0.911211] pci 0000:00:18.0: Adding to iommu group 13
>>> [    0.911228] pci 0000:00:18.1: Adding to iommu group 13
>>> [    0.911258] pci 0000:00:18.2: Adding to iommu group 13
>>> [    0.911275] pci 0000:00:18.3: Adding to iommu group 13
>>> [    0.911290] pci 0000:00:18.4: Adding to iommu group 13
>>> [    0.911306] pci 0000:00:18.5: Adding to iommu group 13
>>> [    0.911323] pci 0000:00:18.6: Adding to iommu group 13
>>> [    0.911340] pci 0000:00:18.7: Adding to iommu group 13
>>> [    0.911363] pci 0000:01:00.0: Adding to iommu group 14
>>> [    0.911379] pci 0000:02:00.0: Adding to iommu group 15
>>> [    0.911397] pci 0000:03:00.0: Adding to iommu group 16
>>> [    0.911413] pci 0000:04:00.0: Adding to iommu group 17
>>> [    0.911441] pci 0000:05:00.0: Adding to iommu group 18
>>> [    0.911458] pci 0000:05:00.1: Adding to iommu group 19
>>> [    0.911475] pci 0000:05:00.2: Adding to iommu group 20
>>> [    0.911492] pci 0000:05:00.3: Adding to iommu group 21
>>> [    0.911510] pci 0000:05:00.4: Adding to iommu group 22
>>> [    0.911527] pci 0000:05:00.5: Adding to iommu group 23
>>> [    0.911545] pci 0000:05:00.6: Adding to iommu group 24
>>> [    0.911562] pci 0000:06:00.0: Adding to iommu group 25
>>> [    0.911585] pci 0000:07:00.0: Adding to iommu group 26
>>> [    0.911602] pci 0000:07:00.3: Adding to iommu group 27
>>> [    0.911620] pci 0000:07:00.4: Adding to iommu group 28
>>> [    0.914013] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): 
>>> PPR NX GT [5] IA GA PC GA_vAPIC
>>> [    0.914025] AMD-Vi: Interrupt remapping enabled
>>> [    0.914174] AMD-Vi: Virtual APIC enabled
>>> [    0.914208] PCI-DMA: Using software bounce buffering for IO 
>>> (SWIOTLB)
>>> [    0.914219] software IO TLB: mapped [mem 
>>> 0x000000008348a000-0x000000008748a000] (64MB)
>>> [    0.914315] LVT offset 0 assigned for vector 0x400
>>> [    0.914443] perf: AMD IBS detected (0x00000bff)
>>> [    0.914448] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 
>>> counters/bank).
>>> [    0.922776] Initialise system trusted keyrings
>>> [    0.922787] Key type blacklist registered
>>> [    0.922830] workingset: timestamp_bits=41 max_order=23 
>>> bucket_order=0
>>> [    0.922838] zbud: loaded
>>> [    0.922947] fuse: init (API version 7.40)
>>> [    0.923033] integrity: Platform Keyring initialized
>>> [    0.923036] integrity: Machine keyring initialized
>>> [    0.932948] Key type asymmetric registered
>>> [    0.932951] Asymmetric key parser 'x509' registered
>>> [    0.932976] Block layer SCSI generic (bsg) driver version 0.4 
>>> loaded (major 246)
>>> [    0.933038] io scheduler mq-deadline registered
>>> [    0.933039] io scheduler kyber registered
>>> [    0.933052] io scheduler bfq registered
>>> [    0.934731] pcieport 0000:00:01.2: PME: Signaling with IRQ 33
>>> [    0.934875] pcieport 0000:00:02.1: PME: Signaling with IRQ 34
>>> [    0.934895] pcieport 0000:00:02.1: pciehp: Slot #0 AttnBtn- 
>>> PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ 
>>> IbPresDis- LLActRep+
>>> [    0.935073] pcieport 0000:00:02.2: PME: Signaling with IRQ 35
>>> [    0.935197] pcieport 0000:00:02.4: PME: Signaling with IRQ 36
>>> [    0.935334] pcieport 0000:00:08.1: PME: Signaling with IRQ 37
>>> [    0.935451] pcieport 0000:00:08.2: can't derive routing for PCI 
>>> INT A
>>> [    0.935453] pcieport 0000:00:08.2: PCI INT A: not connected
>>> [    0.935527] pcieport 0000:00:08.2: PME: Signaling with IRQ 38
>>> [    0.935635] pcieport 0000:00:08.3: PME: Signaling with IRQ 39
>>> [    0.935745] shpchp: Standard Hot Plug PCI Controller Driver 
>>> version: 0.4
>>> [    0.985499] Freeing initrd memory: 44200K
>>> [    1.054782] ACPI: AC: AC Adapter [ADP1] (on-line)
>>> [    1.054954] input: Lid Switch as 
>>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:51/PNP0C09:00/PNP0C0D:00/input/input0
>>> [    1.055009] ACPI: button: Lid Switch [LID0]
>>> [    1.055081] input: Power Button as 
>>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
>>> [    1.055124] ACPI: button: Power Button [PWRB]
>>> [    1.055963] Estimated ratio of average max frequency by base 
>>> frequency (times 1024): 1548
>>> [    1.055977] Monitor-Mwait will be used to enter C-1 state
>>> [    1.055980] ACPI: \_SB_.PLTF.C000: Found 3 idle states
>>> [    1.056158] ACPI: \_SB_.PLTF.C002: Found 3 idle states
>>> [    1.056394] ACPI: \_SB_.PLTF.C004: Found 3 idle states
>>> [    1.056631] ACPI: \_SB_.PLTF.C006: Found 3 idle states
>>> [    1.056871] ACPI: \_SB_.PLTF.C008: Found 3 idle states
>>> [    1.057103] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
>>> [    1.057344] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
>>> [    1.057584] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
>>> [    1.057751] ACPI: \_SB_.PLTF.C001: Found 3 idle states
>>> [    1.057850] ACPI: \_SB_.PLTF.C003: Found 3 idle states
>>> [    1.057982] ACPI: \_SB_.PLTF.C005: Found 3 idle states
>>> [    1.058088] ACPI: \_SB_.PLTF.C007: Found 3 idle states
>>> [    1.058189] ACPI: \_SB_.PLTF.C009: Found 3 idle states
>>> [    1.058295] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
>>> [    1.058403] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
>>> [    1.058551] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
>>> [    1.060429] thermal LNXTHERM:00: registered as thermal_zone0
>>> [    1.060432] ACPI: thermal: Thermal Zone [TZ01] (41 C)
>>> [    1.060659] Serial: 8250/16550 driver, 32 ports, IRQ sharing 
>>> enabled
>>> [    1.062639] hpet_acpi_add: no address or irqs in _CRS
>>> [    1.062664] Non-volatile memory driver v1.3
>>> [    1.062666] Linux agpgart interface v0.103
>>> [    1.070284] ACPI: battery: Slot [BAT0] (battery present)
>>> [    1.232561] tpm_crb MSFT0101:00: Disabling hwrng
>>> [    1.233363] ACPI: bus type drm_connector registered
>>> [    1.236241] usbcore: registered new interface driver 
>>> usbserial_generic
>>> [    1.236250] usbserial: USB Serial support registered for generic
>>> [    1.236399] rtc_cmos 00:01: RTC can wake from S4
>>> [    1.236708] rtc_cmos 00:01: registered as rtc0
>>> [    1.236745] rtc_cmos 00:01: setting system clock to 
>>> 2024-09-16T15:10:50 UTC (1726499450)
>>> [    1.236775] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes 
>>> nvram
>>> [    1.238432] ledtrig-cpu: registered to indicate activity on CPUs
>>> [    1.238794] [drm] Initialized simpledrm 1.0.0 for 
>>> simple-framebuffer.0 on minor 0
>>> [    1.240655] fbcon: Deferring console take-over
>>> [    1.240657] simple-framebuffer simple-framebuffer.0: [drm] fb0: 
>>> simpledrmdrmfb frame buffer device
>>> [    1.240705] hid: raw HID events driver (C) Jiri Kosina
>>> [    1.240771] drop_monitor: Initializing network drop monitor 
>>> service
>>> [    1.240886] NET: Registered PF_INET6 protocol family
>>> [    1.249541] Segment Routing with IPv6
>>> [    1.249547] RPL Segment Routing with IPv6
>>> [    1.249578] In-situ OAM (IOAM) with IPv6
>>> [    1.249641] NET: Registered PF_PACKET protocol family
>>> [    1.252958] microcode: Current revision: 0x0a704103
>>> [    1.253854] resctrl: L3 allocation detected
>>> [    1.253855] resctrl: MB allocation detected
>>> [    1.253856] resctrl: SMBA allocation detected
>>> [    1.253857] resctrl: L3 monitoring detected
>>> [    1.253878] IPI shorthand broadcast: enabled
>>> [    1.256146] sched_clock: Marking stable (1255574628, 
>>> 428545)->(1258938107, -2934934)
>>> [    1.256318] registered taskstats version 1
>>> [    1.257006] Loading compiled-in X.509 certificates
>>> [    1.259946] Loaded X.509 cert 'Build time autogenerated kernel 
>>> key: 1bad038e049bffb5ed6d380eed95e075718c6f9b'
>>> [    1.264030] zswap: loaded using pool zstd/zsmalloc
>>> [    1.264094] Demotion targets for Node 0: null
>>> [    1.264278] Key type .fscrypt registered
>>> [    1.264280] Key type fscrypt-provisioning registered
>>> [    1.264505] integrity: Loading X.509 certificate: UEFI:db
>>> [    1.267506] integrity: Loaded X.509 cert 'Database Key: 
>>> 5cf25c529578f9f01b9cf7cd4217a23d'
>>> [    1.267841] PM:   Magic number: 8:428:184
>>> [    1.267900] thermal LNXTHERM:00: hash matches
>>> [    1.267924] acpi device:43: hash matches
>>> [    1.271271] RAS: Correctable Errors collector initialized.
>>> [    1.284920] clk: Disabling unused clocks
>>> [    1.284924] PM: genpd: Disabling unused power domains
>>> [    1.285952] Freeing unused decrypted memory: 2028K
>>> [    1.286382] Freeing unused kernel image (initmem) memory: 3452K
>>> [    1.286391] Write protecting the kernel read-only data: 32768k
>>> [    1.286773] Freeing unused kernel image (rodata/data gap) memory: 
>>> 820K
>>> [    1.332079] x86/mm: Checked W+X mappings: passed, no W+X pages 
>>> found.
>>> [    1.332084] rodata_test: all tests were successful
>>> [    1.332090] Run /init as init process
>>> [    1.332091]   with arguments:
>>> [    1.332093]     /init
>>> [    1.332094]     splash
>>> [    1.332095]   with environment:
>>> [    1.332096]     HOME=/
>>> [    1.332097]     TERM=linux
>>> [    1.341042] systemd[1]: Successfully made /usr/ read-only.
>>> [    1.341213] systemd[1]: systemd 256.6-1-arch running in system 
>>> mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT 
>>> +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
>>> +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 
>>> +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD 
>>> +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
>>> [    1.341223] systemd[1]: Detected architecture x86-64.
>>> [    1.341228] systemd[1]: Running in initrd.
>>> [    1.341576] systemd[1]: Initializing machine ID from random 
>>> generator.
>>> [    1.385985] systemd[1]: Queued start job for default target Initrd 
>>> Default Target.
>>> [    1.412515] systemd[1]: Created slice Slice 
>>> /system/systemd-cryptsetup.
>>> [    1.412587] systemd[1]: Expecting device 
>>> /dev/disk/by-uuid/97a0672e-59e7-4e70-94e3-b261fb372de3...
>>> [    1.412592] systemd[1]: Expecting device 
>>> /dev/disk/by-uuid/a17f7cbf-2762-4b33-a2bc-054e1e336a25...
>>> [    1.412597] systemd[1]: Expecting device /dev/mapper/root...
>>> [    1.412619] systemd[1]: Reached target Slice Units.
>>> [    1.412633] systemd[1]: Reached target Swaps.
>>> [    1.412643] systemd[1]: Reached target Timer Units.
>>> [    1.412735] systemd[1]: Listening on Journal Socket (/dev/log).
>>> [    1.412800] systemd[1]: Listening on Journal Sockets.
>>> [    1.412864] systemd[1]: Listening on udev Control Socket.
>>> [    1.412911] systemd[1]: Listening on udev Kernel Socket.
>>> [    1.412919] systemd[1]: Reached target Socket Units.
>>> [    1.413687] systemd[1]: Starting Create List of Static Device 
>>> Nodes...
>>> [    1.415264] systemd[1]: Starting Journal Service...
>>> [    1.416817] systemd[1]: Starting Load Kernel Modules...
>>> [    1.416889] systemd[1]: TPM PCR Barrier (initrd) was skipped 
>>> because of an unmet condition check (ConditionSecurity=measured-uki).
>>> [    1.418177] systemd[1]: Starting Create Static Device Nodes in 
>>> /dev...
>>> [    1.419365] systemd[1]: Starting Coldplug All udev Devices...
>>> [    1.420012] systemd[1]: Starting Virtual Console Setup...
>>> [    1.420889] systemd[1]: Finished Create List of Static Device 
>>> Nodes.
>>> [    1.422444] systemd[1]: Finished Load Kernel Modules.
>>> [    1.424508] systemd[1]: Finished Create Static Device Nodes in 
>>> /dev.
>>> [    1.424625] systemd[1]: Reached target Preparation for Local File 
>>> Systems.
>>> [    1.424639] systemd[1]: Reached target Local File Systems.
>>> [    1.425581] systemd[1]: Starting Rule-based Manager for Device 
>>> Events and Files...
>>> [    1.427891] systemd-journald[186]: Collecting audit messages is 
>>> disabled.
>>> [    1.429937] systemd[1]: Finished Virtual Console Setup.
>>> [    1.442226] systemd[1]: Started Rule-based Manager for Device 
>>> Events and Files.
>>> [    1.460747] systemd[1]: Started Journal Service.
>>> [    1.557204] wmi_bus wmi_bus-PNP0C14:00: [Firmware Bug]: WMBB 
>>> method block execution control method not found
>>> [    1.561232] ACPI: video: Video Device [VGA] (multi-head: yes  rom: 
>>> no  post: no)
>>> [    1.561688] input: Video Bus as 
>>> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:23/LNXVIDEO:00/input/input2
>>> [    1.562481] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 
>>> 0x60,0x64 irq 1
>>> [    1.562484] i8042: PNP: PS/2 appears to have AUX port disabled, if 
>>> this is incorrect please boot with i8042.nopnp
>>> [    1.563058] serio: i8042 KBD port at 0x60,0x64 irq 1
>>> [    1.563928] ccp 0000:05:00.2: enabling device (0000 -> 0002)
>>> [    1.563973] xhci_hcd 0000:05:00.3: xHCI Host Controller
>>> [    1.563980] xhci_hcd 0000:05:00.3: new USB bus registered, 
>>> assigned bus number 1
>>> [    1.564439] xhci_hcd 0000:05:00.3: hcc params 0x0128ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.564725] xhci_hcd 0000:05:00.3: xHCI Host Controller
>>> [    1.564729] xhci_hcd 0000:05:00.3: new USB bus registered, 
>>> assigned bus number 2
>>> [    1.564732] xhci_hcd 0000:05:00.3: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.564779] usb usb1: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.564782] usb usb1: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.564784] usb usb1: Product: xHCI Host Controller
>>> [    1.564785] usb usb1: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.564787] usb usb1: SerialNumber: 0000:05:00.3
>>> [    1.564941] hub 1-0:1.0: USB hub found
>>> [    1.564963] hub 1-0:1.0: 5 ports detected
>>> [    1.566565] ccp 0000:05:00.2: tee enabled
>>> [    1.566966] ccp 0000:05:00.2: psp enabled
>>> [    1.567033] usb usb2: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.567075] usb usb2: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.567079] usb usb2: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.567082] usb usb2: Product: xHCI Host Controller
>>> [    1.567084] usb usb2: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.567086] usb usb2: SerialNumber: 0000:05:00.3
>>> [    1.567231] hub 2-0:1.0: USB hub found
>>> [    1.567363] hub 2-0:1.0: 2 ports detected
>>> [    1.568175] xhci_hcd 0000:05:00.4: xHCI Host Controller
>>> [    1.568181] xhci_hcd 0000:05:00.4: new USB bus registered, 
>>> assigned bus number 3
>>> [    1.568619] xhci_hcd 0000:05:00.4: hcc params 0x0110ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.568888] xhci_hcd 0000:05:00.4: xHCI Host Controller
>>> [    1.568892] xhci_hcd 0000:05:00.4: new USB bus registered, 
>>> assigned bus number 4
>>> [    1.568894] xhci_hcd 0000:05:00.4: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.568941] usb usb3: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.568943] usb usb3: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.568945] usb usb3: Product: xHCI Host Controller
>>> [    1.568947] usb usb3: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.568949] usb usb3: SerialNumber: 0000:05:00.4
>>> [    1.569079] hub 3-0:1.0: USB hub found
>>> [    1.569101] hub 3-0:1.0: 1 port detected
>>> [    1.569263] usb usb4: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.569290] usb usb4: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.569293] usb usb4: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.569295] usb usb4: Product: xHCI Host Controller
>>> [    1.569296] usb usb4: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.569298] usb usb4: SerialNumber: 0000:05:00.4
>>> [    1.569403] hub 4-0:1.0: USB hub found
>>> [    1.569414] hub 4-0:1.0: 1 port detected
>>> [    1.569698] xhci_hcd 0000:07:00.3: xHCI Host Controller
>>> [    1.569703] xhci_hcd 0000:07:00.3: new USB bus registered, 
>>> assigned bus number 5
>>> [    1.570088] xhci_hcd 0000:07:00.3: hcc params 0x0110ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.570586] xhci_hcd 0000:07:00.3: xHCI Host Controller
>>> [    1.570589] xhci_hcd 0000:07:00.3: new USB bus registered, 
>>> assigned bus number 6
>>> [    1.570592] xhci_hcd 0000:07:00.3: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.570632] usb usb5: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.570635] usb usb5: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.570636] usb usb5: Product: xHCI Host Controller
>>> [    1.570638] usb usb5: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.570640] usb usb5: SerialNumber: 0000:07:00.3
>>> [    1.570742] hub 5-0:1.0: USB hub found
>>> [    1.570759] hub 5-0:1.0: 1 port detected
>>> [    1.570899] usb usb6: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.570929] usb usb6: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.570931] usb usb6: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.570933] usb usb6: Product: xHCI Host Controller
>>> [    1.570934] usb usb6: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.570936] usb usb6: SerialNumber: 0000:07:00.3
>>> [    1.572710] hub 6-0:1.0: USB hub found
>>> [    1.572733] hub 6-0:1.0: 1 port detected
>>> [    1.572752] nvme 0000:04:00.0: platform quirk: setting simple 
>>> suspend
>>> [    1.572755] nvme 0000:01:00.0: platform quirk: setting simple 
>>> suspend
>>> [    1.572871] nvme nvme0: pci function 0000:04:00.0
>>> [    1.572992] nvme nvme1: pci function 0000:01:00.0
>>> [    1.573925] xhci_hcd 0000:07:00.4: xHCI Host Controller
>>> [    1.573931] xhci_hcd 0000:07:00.4: new USB bus registered, 
>>> assigned bus number 7
>>> [    1.574282] xhci_hcd 0000:07:00.4: hcc params 0x0110ffc5 hci 
>>> version 0x120 quirks 0x0000000200000010
>>> [    1.574777] xhci_hcd 0000:07:00.4: xHCI Host Controller
>>> [    1.574781] xhci_hcd 0000:07:00.4: new USB bus registered, 
>>> assigned bus number 8
>>> [    1.574784] xhci_hcd 0000:07:00.4: Host supports USB 3.1 Enhanced 
>>> SuperSpeed
>>> [    1.574824] usb usb7: New USB device found, idVendor=1d6b, 
>>> idProduct=0002, bcdDevice= 6.11
>>> [    1.574827] usb usb7: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.574830] usb usb7: Product: xHCI Host Controller
>>> [    1.574831] usb usb7: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.574833] usb usb7: SerialNumber: 0000:07:00.4
>>> [    1.574978] hub 7-0:1.0: USB hub found
>>> [    1.574990] hub 7-0:1.0: 1 port detected
>>> [    1.575120] usb usb8: We don't know the algorithms for LPM for 
>>> this host, disabling LPM.
>>> [    1.575146] usb usb8: New USB device found, idVendor=1d6b, 
>>> idProduct=0003, bcdDevice= 6.11
>>> [    1.575148] usb usb8: New USB device strings: Mfr=3, Product=2, 
>>> SerialNumber=1
>>> [    1.575150] usb usb8: Product: xHCI Host Controller
>>> [    1.575151] usb usb8: Manufacturer: Linux 6.11.0-arch1-1 xhci-hcd
>>> [    1.575153] usb usb8: SerialNumber: 0000:07:00.4
>>> [    1.575329] hub 8-0:1.0: USB hub found
>>> [    1.575345] hub 8-0:1.0: 1 port detected
>>> [    1.575454] input: AT Translated Set 2 keyboard as 
>>> /devices/platform/i8042/serio0/input/input3
>>> [    1.593669] nvme nvme0: allocated 64 MiB host memory buffer.
>>> [    1.613062] nvme nvme0: 8/0/0 default/read/poll queues
>>> [    1.613640] nvme nvme1: 16/0/0 default/read/poll queues
>>> [    1.625019]  nvme0n1: p1 p2
>>> [    1.659931] cryptd: max_cpu_qlen set to 1000
>>> [    1.670871] AES CTR mode by8 optimization enabled
>>> [    1.694224] device-mapper: uevent: version 1.0.3
>>> [    1.694311] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) 
>>> initialised: dm-devel@lists.linux.dev
>>> [    1.817536] usb 1-3: new full-speed USB device number 2 using 
>>> xhci_hcd
>>> [    1.927453] tsc: Refined TSC clocksource calibration: 3293.811 MHz
>>> [    1.927461] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
>>> 0x2f7a758b259, max_idle_ns: 440795268702 ns
>>> [    1.927509] clocksource: Switched to clocksource tsc
>>> [    1.980828] usb 1-3: New USB device found, idVendor=2808, 
>>> idProduct=9348, bcdDevice= 1.00
>>> [    1.980839] usb 1-3: New USB device strings: Mfr=1, Product=2, 
>>> SerialNumber=0
>>> [    1.980845] usb 1-3: Product: FT9201Fingerprint.̚
>>> [    1.980850] usb 1-3: Manufacturer: Focal-systems.Corp
>>> [    2.103780] usb 1-5: new high-speed USB device number 3 using 
>>> xhci_hcd
>>> [    2.247687] usb 1-5: New USB device found, idVendor=0e8d, 
>>> idProduct=0608, bcdDevice= 1.00
>>> [    2.247697] usb 1-5: New USB device strings: Mfr=5, Product=6, 
>>> SerialNumber=7
>>> [    2.247703] usb 1-5: Product: Wireless_Device
>>> [    2.247708] usb 1-5: Manufacturer: MediaTek Inc.
>>> [    2.247712] usb 1-5: SerialNumber: 000000000
>>> [    3.352916] [drm] amdgpu kernel modesetting enabled.
>>> [    3.368088] amdgpu: Virtual CRAT table created for CPU
>>> [    3.368103] amdgpu: Topology: Add CPU node
>>> [    3.368198] amdgpu 0000:05:00.0: enabling device (0006 -> 0007)
>>> [    3.368243] [drm] initializing kernel modesetting (IP DISCOVERY 
>>> 0x1002:0x15BF 0x2782:0x12B3 0xC9).
>>> [    3.574435] [drm] register mmio base: 0xFC900000
>>> [    3.574445] [drm] register mmio size: 524288
>>> [    3.578566] [drm] add ip block number 0 <soc21_common>
>>> [    3.578571] [drm] add ip block number 1 <gmc_v11_0>
>>> [    3.578574] [drm] add ip block number 2 <ih_v6_0>
>>> [    3.578576] [drm] add ip block number 3 <psp>
>>> [    3.578579] [drm] add ip block number 4 <smu>
>>> [    3.578581] [drm] add ip block number 5 <dm>
>>> [    3.578583] [drm] add ip block number 6 <gfx_v11_0>
>>> [    3.578585] [drm] add ip block number 7 <sdma_v6_0>
>>> [    3.578587] [drm] add ip block number 8 <vcn_v4_0>
>>> [    3.578589] [drm] add ip block number 9 <jpeg_v4_0>
>>> [    3.578590] [drm] add ip block number 10 <mes_v11_0>
>>> [    3.578616] amdgpu 0000:05:00.0: amdgpu: Fetched VBIOS from VFCT
>>> [    3.578620] amdgpu: ATOM BIOS: 113-PHXGENERIC-001
>>> [    3.648604] amdgpu 0000:05:00.0: vgaarb: deactivate vga console
>>> [    3.648617] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) 
>>> feature enabled
>>> [    3.648690] [drm] vm size is 262144 GB, 4 levels, block size is 
>>> 9-bit, fragment size is 9-bit
>>> [    3.648718] amdgpu 0000:05:00.0: amdgpu: VRAM: 512M 
>>> 0x0000008000000000 - 0x000000801FFFFFFF (512M used)
>>> [    3.648725] amdgpu 0000:05:00.0: amdgpu: GART: 512M 
>>> 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
>>> [    3.648746] [drm] Detected VRAM RAM=512M, BAR=512M
>>> [    3.648750] [drm] RAM width 128bits LPDDR5
>>> [    3.649054] [drm] amdgpu: 512M of VRAM memory ready
>>> [    3.649057] [drm] amdgpu: 15652M of GTT memory ready.
>>> [    3.649081] [drm] GART: num cpu pages 131072, num gpu pages 131072
>>> [    3.649313] [drm] PCIE GART of 512M enabled (table at 
>>> 0x000000801FD00000).
>>> [    3.649630] [drm] Loading DMUB firmware via PSP: 
>>> version=0x08004300
>>> [    3.649825] [drm] Found VCN firmware Version ENC: 1.22 DEC: 8 VEP: 
>>> 0 Revision: 3
>>> [    3.676056] amdgpu 0000:05:00.0: amdgpu: reserve 0x4a00000 from 
>>> 0x8010000000 for PSP TMR
>>> [    4.468562] amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta 
>>> ucode is not available
>>> [    4.478246] amdgpu 0000:05:00.0: amdgpu: RAP: optional rap ta 
>>> ucode is not available
>>> [    4.478251] amdgpu 0000:05:00.0: amdgpu: SECUREDISPLAY: 
>>> securedisplay ta ucode is not available
>>> [    4.508557] amdgpu 0000:05:00.0: amdgpu: SMU is initialized 
>>> successfully!
>>> [    4.508562] [drm] Seamless boot condition check passed
>>> [    4.509846] [drm] Display Core v3.2.291 initialized on DCN 3.1.4
>>> [    4.509850] [drm] DP-HDMI FRL PCON supported
>>> [    4.512212] [drm] DMUB hardware initialized: version=0x08004300
>>> [    4.629356] [drm] PSR support 0, DC PSR ver -1, sink PSR ver 0 
>>> DPCD caps 0x0 su_y_granularity 0
>>> [    4.637452] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>>> [    4.637467] kfd kfd: amdgpu: Total number of KFD nodes to be 
>>> created: 1
>>> [    4.637978] amdgpu: Virtual CRAT table created for GPU
>>> [    4.638114] amdgpu: Topology: Add dGPU node [0x15bf:0x1002]
>>> [    4.638116] kfd kfd: amdgpu: added device 1002:15bf
>>> [    4.638128] amdgpu 0000:05:00.0: amdgpu: SE 1, SH per SE 2, CU per 
>>> SH 6, active_cu_number 12
>>> [    4.638134] amdgpu 0000:05:00.0: amdgpu: ring gfx_0.0.0 uses VM 
>>> inv eng 0 on hub 0
>>> [    4.638136] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM 
>>> inv eng 1 on hub 0
>>> [    4.638137] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM 
>>> inv eng 4 on hub 0
>>> [    4.638139] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM 
>>> inv eng 6 on hub 0
>>> [    4.638140] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM 
>>> inv eng 7 on hub 0
>>> [    4.638141] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM 
>>> inv eng 8 on hub 0
>>> [    4.638142] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM 
>>> inv eng 9 on hub 0
>>> [    4.638144] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM 
>>> inv eng 10 on hub 0
>>> [    4.638145] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM 
>>> inv eng 11 on hub 0
>>> [    4.638146] amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv 
>>> eng 12 on hub 0
>>> [    4.638147] amdgpu 0000:05:00.0: amdgpu: ring vcn_unified_0 uses 
>>> VM inv eng 0 on hub 8
>>> [    4.638148] amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv 
>>> eng 1 on hub 8
>>> [    4.638149] amdgpu 0000:05:00.0: amdgpu: ring mes_kiq_3.1.0 uses 
>>> VM inv eng 13 on hub 0
>>> [    4.856452] [drm] ring gfx_32768.1.1 was added
>>> [    4.856695] [drm] ring compute_32768.2.2 was added
>>> [    4.856964] [drm] ring sdma_32768.3.3 was added
>>> [    4.856998] [drm] ring gfx_32768.1.1 ib test pass
>>> [    4.857026] [drm] ring compute_32768.2.2 ib test pass
>>> [    4.857051] [drm] ring sdma_32768.3.3 ib test pass
>>> [    4.859055] amdgpu 0000:05:00.0: amdgpu: Runtime PM not available
>>> [    5.069518] [drm] Initialized amdgpu 3.58.0 for 0000:05:00.0 on 
>>> minor 1
>>> [    5.074177] fbcon: amdgpudrmfb (fb0) is primary device
>>> [    5.074182] fbcon: Deferring console take-over
>>> [    5.074186] amdgpu 0000:05:00.0: [drm] fb0: amdgpudrmfb frame 
>>> buffer device
>>> [    5.161125] [drm] DSC precompute is not needed.
>>> [    6.307397] Key type trusted registered
>>> [    6.509253] Key type encrypted registered
>>> [    6.528486] raid6: skipped pq benchmark and selected avx512x4
>>> [    6.528488] raid6: using avx512x2 recovery algorithm
>>> [    6.530544] xor: automatically using best checksumming function   
>>> avx
>>> [    6.592858] Btrfs loaded, zoned=yes, fsverity=yes
>>> [    6.593314] BTRFS: device fsid 
>>> bec7d079-0b9c-458f-889a-df146ded0246 devid 1 transid 16984 /dev/dm-1 
>>> (254:1) scanned by (udev-worker) (217)
>>> [    6.593453] BTRFS: device fsid 
>>> bec7d079-0b9c-458f-889a-df146ded0246 devid 2 transid 16984 /dev/dm-0 
>>> (254:0) scanned by (udev-worker) (316)
>>> [    6.664186] BTRFS info (device dm-1): first mount of filesystem 
>>> bec7d079-0b9c-458f-889a-df146ded0246
>>> [    6.664210] BTRFS info (device dm-1): using crc32c (crc32c-intel) 
>>> checksum algorithm
>>> [    6.664214] BTRFS info (device dm-1): using free-space-tree
>>> [    6.851255] systemd-journald[186]: Received SIGTERM from PID 1 
>>> (systemd).
>>> [    6.927674] systemd[1]: systemd 256.6-1-arch running in system 
>>> mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT 
>>> +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC 
>>> +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 
>>> +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD 
>>> +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
>>> [    6.927679] systemd[1]: Detected architecture x86-64.
>>> [    6.927948] systemd[1]: Hostname set to <jerrypop>.
>>> [    7.096265] systemd[1]: bpf-restrict-fs: LSM BPF program attached
>>> [    7.269609] systemd[1]: 
>>> run-credentials-systemd\x2djournald.service.mount: Deactivated 
>>> successfully.
>>> [    7.269819] systemd[1]: initrd-switch-root.service: Deactivated 
>>> successfully.
>>> [    7.269921] systemd[1]: Stopped Switch Root.
>>> [    7.270502] systemd[1]: systemd-journald.service: Scheduled 
>>> restart job, restart counter is at 1.
>>> [    7.270775] systemd[1]: Created slice Slice /system/dirmngr.
>>> [    7.271000] systemd[1]: Created slice Slice /system/getty.
>>> [    7.271218] systemd[1]: Created slice Slice /system/gpg-agent.
>>> [    7.271430] systemd[1]: Created slice Slice 
>>> /system/gpg-agent-browser.
>>> [    7.271635] systemd[1]: Created slice Slice 
>>> /system/gpg-agent-extra.
>>> [    7.271856] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
>>> [    7.272063] systemd[1]: Created slice Slice /system/keyboxd.
>>> [    7.272263] systemd[1]: Created slice Slice /system/modprobe.
>>> [    7.272421] systemd[1]: Created slice User and Session Slice.
>>> [    7.272437] systemd[1]: Dispatch Password Requests to Console 
>>> Directory Watch was skipped because of an unmet condition check 
>>> (ConditionPathExists=!/run/plymouth/pid).
>>> [    7.272467] systemd[1]: Started Forward Password Requests to Wall 
>>> Directory Watch.
>>> [    7.272573] systemd[1]: Set up automount Arbitrary Executable File 
>>> Formats File System Automount Point.
>>> [    7.272589] systemd[1]: Expecting device 
>>> /dev/disk/by-uuid/DCAE-BB86...
>>> [    7.272599] systemd[1]: Reached target Local Encrypted Volumes.
>>> [    7.272612] systemd[1]: Reached target Login Prompts.
>>> [    7.272625] systemd[1]: Stopped target Switch Root.
>>> [    7.272637] systemd[1]: Stopped target Initrd File Systems.
>>> [    7.272647] systemd[1]: Stopped target Initrd Root File System.
>>> [    7.272658] systemd[1]: Reached target Local Integrity Protected 
>>> Volumes.
>>> [    7.272674] systemd[1]: Reached target Path Units.
>>> [    7.272685] systemd[1]: Reached target Remote File Systems.
>>> [    7.272695] systemd[1]: Reached target Slice Units.
>>> [    7.272708] systemd[1]: Reached target Swaps.
>>> [    7.272722] systemd[1]: Reached target Local Verity Protected 
>>> Volumes.
>>> [    7.272769] systemd[1]: Listening on Device-mapper event daemon 
>>> FIFOs.
>>> [    7.274075] systemd[1]: Listening on Process Core Dump Socket.
>>> [    7.274367] systemd[1]: Listening on Credential 
>>> Encryption/Decryption.
>>> [    7.274399] systemd[1]: TPM PCR Measurements was skipped because 
>>> of an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.274407] systemd[1]: Make TPM PCR Policy was skipped because of 
>>> an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.274451] systemd[1]: Listening on udev Control Socket.
>>> [    7.274489] systemd[1]: Listening on udev Kernel Socket.
>>> [    7.274535] systemd[1]: Listening on User Database Manager Socket.
>>> [    7.275537] systemd[1]: Mounting Huge Pages File System...
>>> [    7.276075] systemd[1]: Mounting POSIX Message Queue File 
>>> System...
>>> [    7.276772] systemd[1]: Mounting Kernel Debug File System...
>>> [    7.277473] systemd[1]: Mounting Kernel Trace File System...
>>> [    7.278382] systemd[1]: Mounting Temporary Directory /tmp...
>>> [    7.279892] systemd[1]: Starting Create List of Static Device 
>>> Nodes...
>>> [    7.315785] systemd[1]: Starting Load Kernel Module configfs...
>>> [    7.317463] systemd[1]: Starting Load Kernel Module dm_mod...
>>> [    7.319487] systemd[1]: Starting Load Kernel Module drm...
>>> [    7.320345] systemd[1]: Starting Load Kernel Module fuse...
>>> [    7.321438] systemd[1]: Starting Load Kernel Module loop...
>>> [    7.322650] systemd[1]: Starting Mullvad early boot network 
>>> blocker...
>>> [    7.322749] systemd[1]: plymouth-switch-root.service: Deactivated 
>>> successfully.
>>> [    7.322851] systemd[1]: Stopped Plymouth switch root service.
>>> [    7.323024] systemd[1]: systemd-cryptsetup@root.service: 
>>> Deactivated successfully.
>>> [    7.323084] systemd[1]: Stopped systemd-cryptsetup@root.service.
>>> [    7.323299] systemd[1]: systemd-cryptsetup@root2.service: 
>>> Deactivated successfully.
>>> [    7.323350] systemd[1]: Stopped systemd-cryptsetup@root2.service.
>>> [    7.323453] systemd[1]: Clear Stale Hibernate Storage Info was 
>>> skipped because of an unmet condition check 
>>> (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
>>> [    7.324518] systemd[1]: Starting Journal Service...
>>> [    7.325550] systemd[1]: Starting Load Kernel Modules...
>>> [    7.325571] systemd[1]: TPM PCR Machine ID Measurement was skipped 
>>> because of an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.326314] systemd[1]: Starting Remount Root and Kernel File 
>>> Systems...
>>> [    7.326405] systemd[1]: Early TPM SRK Setup was skipped because of 
>>> an unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.328453] systemd[1]: Starting Load udev Rules from 
>>> Credentials...
>>> [    7.329175] systemd[1]: Starting Coldplug All udev Devices...
>>> [    7.330697] systemd[1]: 
>>> run-credentials-systemd\x2dcryptsetup\x40root.service.mount: 
>>> Deactivated successfully.
>>> [    7.330764] systemd[1]: 
>>> run-credentials-systemd\x2dcryptsetup\x40root2.service.mount: 
>>> Deactivated successfully.
>>> [    7.332227] systemd[1]: Mounted Huge Pages File System.
>>> [    7.332320] systemd[1]: Mounted POSIX Message Queue File System.
>>> [    7.332391] systemd[1]: Mounted Kernel Debug File System.
>>> [    7.332509] systemd[1]: Mounted Kernel Trace File System.
>>> [    7.332598] systemd[1]: Mounted Temporary Directory /tmp.
>>> [    7.332675] loop: module loaded
>>> [    7.332820] systemd[1]: Finished Create List of Static Device 
>>> Nodes.
>>> [    7.333046] systemd[1]: modprobe@configfs.service: Deactivated 
>>> successfully.
>>> [    7.333208] systemd[1]: Finished Load Kernel Module configfs.
>>> [    7.333577] systemd[1]: modprobe@dm_mod.service: Deactivated 
>>> successfully.
>>> [    7.333807] systemd[1]: Finished Load Kernel Module dm_mod.
>>> [    7.334154] systemd[1]: modprobe@drm.service: Deactivated 
>>> successfully.
>>> [    7.334363] systemd[1]: Finished Load Kernel Module drm.
>>> [    7.334663] systemd[1]: modprobe@fuse.service: Deactivated 
>>> successfully.
>>> [    7.334812] systemd[1]: Finished Load Kernel Module fuse.
>>> [    7.335038] systemd[1]: modprobe@loop.service: Deactivated 
>>> successfully.
>>> [    7.335163] systemd[1]: Finished Load Kernel Module loop.
>>> [    7.335223] BTRFS info (device dm-1 state M): use zstd 
>>> compression, level 3
>>> [    7.336063] systemd[1]: Finished Remount Root and Kernel File 
>>> Systems.
>>> [    7.336497] systemd[1]: Finished Load udev Rules from Credentials.
>>> [    7.337228] systemd[1]: Mounting FUSE Control File System...
>>> [    7.337828] systemd[1]: Mounting Kernel Configuration File 
>>> System...
>>> [    7.338240] systemd-journald[440]: Collecting audit messages is 
>>> disabled.
>>> [    7.338772] systemd[1]: Rebuild Hardware Database was skipped 
>>> because no trigger condition checks were met.
>>> [    7.339726] systemd[1]: Starting Load/Save OS Random Seed...
>>> [    7.339820] systemd[1]: Repartition Root Disk was skipped because 
>>> no trigger condition checks were met.
>>> [    7.340631] i2c_dev: i2c /dev entries driver
>>> [    7.340750] systemd[1]: Starting Create Static Device Nodes in 
>>> /dev gracefully...
>>> [    7.340791] systemd[1]: TPM SRK Setup was skipped because of an 
>>> unmet condition check (ConditionSecurity=measured-uki).
>>> [    7.343049] systemd[1]: Started Journal Service.
>>> [    7.379255] systemd-journald[440]: Received client request to 
>>> flush runtime journal.
>>> [    7.379714] Asymmetric key parser 'pkcs8' registered
>>> [    7.636052] BTRFS info: devid 2 device path /dev/dm-0 changed to 
>>> /dev/mapper/root2 scanned by (udev-worker) (525)
>>> [    7.636888] BTRFS info: devid 1 device path /dev/mapper/root 
>>> changed to /dev/dm-1 scanned by (udev-worker) (512)
>>> [    7.637790] BTRFS info: devid 1 device path /dev/dm-1 changed to 
>>> /dev/mapper/root scanned by (udev-worker) (512)
>>> [    7.664322] input: Intel HID events as 
>>> /devices/platform/INT33D5:00/input/input4
>>> [    7.664754] intel-hid INT33D5:00: failed to enable HID power 
>>> button
>>> [    7.674428] amd-tee driver initialization successful
>>> [    7.687912] input: PC Speaker as 
>>> /devices/platform/pcspkr/input/input5
>>> [    7.694949] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 
>>> 163840 ms ovfl timer
>>> [    7.694954] RAPL PMU: hw unit of domain package 2^-16 Joules
>>> [    7.724377] amd-pmf AMDI0102:00: registered PMF device 
>>> successfully
>>> [    7.949724] piix4_smbus 0000:00:14.0: SMBus Host Controller at 
>>> 0xb00, revision 0
>>> [    7.949732] piix4_smbus 0000:00:14.0: Using register 0x02 for 
>>> SMBus port selection
>>> [    7.950106] input: PNP0C50:0b 0911:5288 Mouse as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input6
>>> [    7.950173] input: PNP0C50:0b 0911:5288 Touchpad as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input7
>>> [    7.950232] hid-generic 0018:0911:5288.0001: input,hidraw0: I2C 
>>> HID v1.00 Mouse [PNP0C50:0b 0911:5288] on i2c-PNP0C50:0b
>>> [    7.952297] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host 
>>> Controller at 0xb20
>>> [    7.952912] i2c i2c-20: Successfully instantiated SPD at 0x50
>>> [    7.955410] kvm_amd: TSC scaling supported
>>> [    7.955412] kvm_amd: Nested Virtualization enabled
>>> [    7.955413] kvm_amd: Nested Paging enabled
>>> [    7.955414] kvm_amd: LBR virtualization supported
>>> [    7.955419] kvm_amd: Virtual VMLOAD VMSAVE supported
>>> [    7.955419] kvm_amd: Virtual GIF supported
>>> [    7.955420] kvm_amd: Virtual NMI enabled
>>> [    8.010958] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
>>> [    8.011139] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog 
>>> MMIO address
>>> [    8.011333] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec 
>>> (nowayout=0)
>>> [    8.026746] cfg80211: Loading compiled-in X.509 certificates for 
>>> regulatory database
>>> [    8.026870] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>>> [    8.026970] Loaded X.509 cert 'wens: 
>>> 61c038651aabdcf94bd0ac7ff06c7248db18c600'
>>> [    8.027227] platform regulatory.0: Direct firmware load for 
>>> regulatory.db failed with error -2
>>> [    8.027230] cfg80211: failed to load regulatory.db
>>> [    8.042617] r8169 0000:02:00.0 eth0: RTL8168h/8111h, 
>>> 50:a1:32:3d:41:01, XID 541, IRQ 82
>>> [    8.042623] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 
>>> bytes, tx checksumming: ko]
>>> [    8.044085] r8169 0000:02:00.0 enp2s0: renamed from eth0
>>> [    8.059670] input: PNP0C50:0b 0911:5288 Mouse as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input8
>>> [    8.059793] input: PNP0C50:0b 0911:5288 Touchpad as 
>>> /devices/platform/AMDI0010:03/i2c-0/i2c-PNP0C50:0b/0018:0911:5288.0001/input/input9
>>> [    8.059872] hid-multitouch 0018:0911:5288.0001: input,hidraw0: I2C 
>>> HID v1.00 Mouse [PNP0C50:0b 0911:5288] on i2c-PNP0C50:0b
>>> [    8.075445] mousedev: PS/2 mouse device common for all mice
>>> [    8.083670] snd_hda_intel 0000:05:00.1: enabling device (0000 -> 
>>> 0002)
>>> [    8.083733] snd_hda_intel 0000:05:00.1: Handle vga_switcheroo 
>>> audio client
>>> [    8.083908] snd_hda_intel 0000:05:00.6: enabling device (0000 -> 
>>> 0002)
>>> [    8.094077] snd_hda_intel 0000:05:00.1: bound 0000:05:00.0 (ops 
>>> amdgpu_dm_audio_component_bind_ops [amdgpu])
>>> [    8.095281] input: HD-Audio Generic HDMI/DP,pcm=3 as 
>>> /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input10
>>> [    8.151512] mt7921e 0000:03:00.0: enabling device (0000 -> 0002)
>>> [    8.151967] snd_hda_codec_conexant hdaudioC1D0: CX11970: BIOS 
>>> auto-probing.
>>> [    8.152686] snd_hda_codec_conexant hdaudioC1D0: autoconfig for 
>>> CX11970: line_outs=2 (0x17/0x1d/0x0/0x0/0x0) type:speaker
>>> [    8.152690] snd_hda_codec_conexant hdaudioC1D0:    speaker_outs=0 
>>> (0x0/0x0/0x0/0x0/0x0)
>>> [    8.152692] snd_hda_codec_conexant hdaudioC1D0:    hp_outs=1 
>>> (0x16/0x0/0x0/0x0/0x0)
>>> [    8.152694] snd_hda_codec_conexant hdaudioC1D0:    mono: 
>>> mono_out=0x0
>>> [    8.152696] snd_hda_codec_conexant hdaudioC1D0:    inputs:
>>> [    8.152697] snd_hda_codec_conexant hdaudioC1D0:      Mic=0x19
>>> [    8.154804] amd_atl: AMD Address Translation Library initialized
>>> [    8.155232] intel_rapl_common: Found RAPL domain package
>>> [    8.155234] intel_rapl_common: Found RAPL domain core
>>> [    8.157127] mt7921e 0000:03:00.0: ASIC revision: 79610010
>>> [    8.159573] input: HD-Audio Generic Mic as 
>>> /devices/pci0000:00/0000:00:08.1/0000:05:00.6/sound/card1/input11
>>> [    8.159650] input: HD-Audio Generic Headphone as 
>>> /devices/pci0000:00/0000:00:08.1/0000:05:00.6/sound/card1/input12
>>> [    8.162138] snd_pci_ps 0000:05:00.5: enabling device (0000 -> 
>>> 0002)
>>> [    8.240936] mt7921e 0000:03:00.0: HW/SW Version: 0x8a108a10, Build 
>>> Time: 20240826150948a
>>> 
>>> [    8.253614] mt7921e 0000:03:00.0: WM Firmware Version: ____010000, 
>>> Build Time: 20240826151030
>>> [    8.344021] FAT-fs (nvme0n1p1): Volume was not properly unmounted. 
>>> Some data may be corrupt. Please run fsck.
>>> [    8.697126] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY 
>>> driver (mii_bus:phy_addr=r8169-0-200:00, irq=MAC)
>>> [    8.800332] Bluetooth: Core ver 2.22
>>> [    8.800366] NET: Registered PF_BLUETOOTH protocol family
>>> [    8.800368] Bluetooth: HCI device and connection manager 
>>> initialized
>>> [    8.800374] Bluetooth: HCI socket layer initialized
>>> [    8.800376] Bluetooth: L2CAP socket layer initialized
>>> [    8.800380] Bluetooth: SCO socket layer initialized
>>> [    8.814548] usbcore: registered new interface driver btusb
>>> [    8.869526] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build 
>>> Time: 20240826151221
>>> [    8.894612] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>>> [    8.894615] Bluetooth: BNEP filters: protocol multicast
>>> [    8.894618] Bluetooth: BNEP socket layer initialized
>>> [    8.907620] r8169 0000:02:00.0 enp2s0: Link is Down
>>> [   11.117556] Bluetooth: hci0: Device setup in 2248981 usecs
>>> [   11.117573] Bluetooth: hci0: HCI Enhanced Setup Synchronous 
>>> Connection command is advertised, but not supported.
>>> [   11.189056] Bluetooth: hci0: AOSP extensions version v1.00
>>> [   11.189068] Bluetooth: hci0: AOSP quality report is supported
>>> [   11.189244] Bluetooth: MGMT ver 1.23
>>> [   11.196397] NET: Registered PF_ALG protocol family
>>> [   12.781118] wlan0: authenticate with 62:22:32:27:0c:96 (local 
>>> address=c8:94:02:13:e2:05)
>>> [   13.278917] wlan0: send auth to 62:22:32:27:0c:96 (try 1/3)
>>> [   13.280836] wlan0: authenticated
>>> [   13.284412] wlan0: associate with 62:22:32:27:0c:96 (try 1/3)
>>> [   13.290951] wlan0: RX AssocResp from 62:22:32:27:0c:96 
>>> (capab=0x131 status=0 aid=16)
>>> [   13.302914] wlan0: associated
>>> [   14.761538] wireguard: WireGuard 1.0.0 loaded. See 
>>> www.wireguard.com for information.
>>> [   14.761542] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld 
>>> <Jason@zx2c4.com>. All Rights Reserved.
>>> [   21.861597] overlayfs: "xino" feature enabled using 2 upper inode 
>>> bits.
>>> [   21.935601] overlayfs: "xino" feature enabled using 2 upper inode 
>>> bits.
>>> [   23.037329] Bluetooth: RFCOMM TTY layer initialized
>>> [   23.037339] Bluetooth: RFCOMM socket layer initialized
>>> [   23.037342] Bluetooth: RFCOMM ver 1.11
>>> [   23.449450] block nvme0n1: No UUID available providing old NGUID
>>> [   24.367833] warning: `kdeconnectd' uses wireless extensions which 
>>> will stop working for Wi-Fi 7 hardware; use nl80211
>>> Verifying...

