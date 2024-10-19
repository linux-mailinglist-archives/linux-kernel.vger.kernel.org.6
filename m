Return-Path: <linux-kernel+bounces-372855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4322B9A4E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B31F25E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE02AE8C;
	Sat, 19 Oct 2024 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="A+FUfKSs"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F21E48A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729346054; cv=none; b=UqMf39R/TFWmh8Rs0idrZN+CyrBCGENYywhVAnpIuJfzNOneTsL1NhNN589xMiybUN5tyBSIW5pNkHSpN57A6hnDdqigUaABc7j2lBCmucxs5tDKGryk6nLvgwE1wN/wg5sY7C+gICdnriozzvz2Bam3wBdKxPOpCgegIprn6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729346054; c=relaxed/simple;
	bh=TG2NCbOVIHtloopVDusSCIkUh1yQYyZsUuYTSh37Fd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAsWQTLrWEXBy/pCaOpFjjdczzUGcs7iJxgwCSO9zwjQFkM9BD4WxqY2H/m/48BckBxhaL5khYKnreH9vM8QdkXnt/c4uVTzOzsPXoHGN9o1BEMX0D687FdQ+jdi5WtVzqDFxkAfZW26awSID1LrL3FSXbOzsQFO4W1Y3n+5HP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=A+FUfKSs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7163489149eso2378137a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729346049; x=1729950849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VL2Q7lOMgfONaV553HeDXjmP7DCdIignmquQZ9VMSOI=;
        b=A+FUfKSs0YgD6Lwg/KxezZDXFT78HxseI9ddYGDoUA5HvkJ62SR4WCa66IrP4cyxT6
         KwYPFnZSusnZbsGupr6lfrSZbcuKT6ibAiqhzlnImax0ICoX+ui7kXv8+idOcuZ1NPPR
         VLY0alBizATHP1SSBKd41WADY9t4GMIQkjZMbFt6lFytUCh3JAhNxURpHDZRt9zsFNpQ
         zh2WCji5ZKTrJ6L9RYbfe4q/zPBDUAFnjT59CSaoZE9wFlrEX/nxzLkX4arDp+BsdBWI
         3fjKZFYkGPVUd6bX6zQHx0zmV434xazbsZNQfqIRjNOUocrdwo5MlkTCBAjYvGLd3EON
         9MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729346049; x=1729950849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VL2Q7lOMgfONaV553HeDXjmP7DCdIignmquQZ9VMSOI=;
        b=Tlo9I4rkHuK7kkCiKkV0ecsG+3Ys+/4bzPaxqsFo9ghTIlaFSl/z8jL8XfQ3bdzAUU
         S7u+7YbEgho4HMd5dJd+fV/9HVBHGf548zKHKBPvFOaGXDh28mUXMj5GTFEkOq9gkO68
         Qo2I7TyN5XEbFnxt9fZ0GLNIdNwqo29cKezs+Avlui9XuYyU/snLerBO8YVRvA44IVAj
         N44+ZPBJs7yXPLJQ5/KRQhzTkjObhS/Yrlo6qrhwrme2CRArGZzCbPub5FnMMtL8N0SE
         XiEYZCg9SrkIwUezTYctdlagk3JFSFDDujvCzw8qLaQ4Zmo78CYBbQNWtd0rzXkzM+Fq
         KtLw==
X-Forwarded-Encrypted: i=1; AJvYcCWxYhiGXmXYK/yjuYpNj/WUlwqs1BNkZnoEaB3dSk8eVyiPSoSZDdFkgnmrR4yHURlNQoy1SaBLBO1h64A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMa1K/W1zLKgHVJWaXqh27mCi1FZV+rpd+PugHzEy7d/7JMQTR
	x4LXAVQ1H+B2H69GMjvrMSfr5Ud2HNMqAfxrwVo9en3Zg9D1JxXMrJTFSL0430A=
X-Google-Smtp-Source: AGHT+IHbVjO2GPKCkje58ypHTM7DYg95479BnrxIa9URWNj8pwsSon1S6tIGgmO6M2AxivVekKzzvQ==
X-Received: by 2002:a05:6a21:e91:b0:1d9:1c76:6742 with SMTP id adf61e73a8af0-1d92c4e0edbmr7311811637.13.1729346049150;
        Sat, 19 Oct 2024 06:54:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea33185b8sm3107169b3a.34.2024.10.19.06.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 06:54:08 -0700 (PDT)
Message-ID: <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
Date: Sat, 19 Oct 2024 07:54:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
 <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
 <20241018115857.GBZxJNgZY-NedtPrxX@fat_crate.local>
 <20241018124943.GDZxJZZxtwA9O9eqiU@fat_crate.local>
 <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
 <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
 <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 3:37 AM, Borislav Petkov wrote:
> On Fri, Oct 18, 2024 at 05:01:18PM -0600, Jens Axboe wrote:
>> I took time out of "would otherwise have had a beer" time on a Friday
> 
> No worries, next time we meet at a conference, I'm buying! :-)

;-)

>> which appears to be here:
>>
>> (gdb) l *load_microcode_amd+0x334
>> 0xffffffff810914a4 is in load_microcode_amd (arch/x86/kernel/cpu/microcode/amd.c:971).
> 
> Ok, first things first, this line 971 points to the code *without* my big
> debugging patch. Is that correct?

Right, this was just a boot of the kernel I'm running now.

> With my patch that line should be 999 because of the debugging output and
> other changes.
> 
> Because if so, please run with it because it has a fix for the patch matching
> steppings too. And then send me the whole serial log because it'll have debug
> info for me to stare at.

Added that, and here's the full boot output until it crashes. Sent you
the full thing as there's some microcode debug prints initially, and
then some later on. Didn't want to miss any.

EFI stub: Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path
EFI stub: Measured initrd data into PCR 9
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
Linux version 6.12.0-rc2+ (axboe@r7625) (gcc (Debian 14.2.0-6) 14.2.0, GNU ld (GNU Binutils for Debian) 2.43.1) #144 SMP Sat Oct 19 13:43:43 UTC 2024
Command line: BOOT_IMAGE=/vmlinuz-6.12.0-rc2+ root=UUID=d155ab07-2863-462d-931e-ce417aca7adb ro nvme.poll_queues=16 mitigations=off console=ttyS1,115200 console=tty0
KERNEL supported cpus:
  AMD AuthenticAMD
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usable
BIOS-e820: [mem 0x0000000000100000-0x0000000059cccfff] usable
BIOS-e820: [mem 0x0000000059ccd000-0x0000000059ccffff] reserved
BIOS-e820: [mem 0x0000000059cd0000-0x00000000677cefff] usable
BIOS-e820: [mem 0x00000000677cf000-0x000000006dfcefff] reserved
BIOS-e820: [mem 0x000000006dfcf000-0x000000006edfefff] ACPI NVS
BIOS-e820: [mem 0x000000006edff000-0x000000006effefff] ACPI data
BIOS-e820: [mem 0x000000006efff000-0x000000006effffff] usable
BIOS-e820: [mem 0x000000006f000000-0x000000006fffffff] ACPI NVS
BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
BIOS-e820: [mem 0x000000009c000000-0x000000009cffffff] reserved
BIOS-e820: [mem 0x00000000a9000000-0x00000000a9ffffff] reserved
BIOS-e820: [mem 0x00000000b6000000-0x00000000b6ffffff] reserved
BIOS-e820: [mem 0x00000000c3000000-0x00000000c3ffffff] reserved
BIOS-e820: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
BIOS-e820: [mem 0x00000000dd000000-0x00000000ddffffff] reserved
BIOS-e820: [mem 0x00000000ea000000-0x00000000eaffffff] reserved
BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000187fdfffff] usable
BIOS-e820: [mem 0x000000187fe00000-0x000000187fffffff] reserved
BIOS-e820: [mem 0x0000001880000000-0x000000307fdfffff] usable
BIOS-e820: [mem 0x000000307fe00000-0x000000307fffffff] reserved
BIOS-e820: [mem 0x0000003080000000-0x000000487fdfffff] usable
BIOS-e820: [mem 0x000000487fe00000-0x000000487fffffff] reserved
BIOS-e820: [mem 0x0000004880000000-0x000000607edfffff] usable
BIOS-e820: [mem 0x000000607ee00000-0x000000607fffffff] reserved
BIOS-e820: [mem 0x0000006080000000-0x000000787fdfffff] usable
BIOS-e820: [mem 0x000000787fe00000-0x000000787fffffff] reserved
BIOS-e820: [mem 0x0000007880000000-0x000000907fdfffff] usable
BIOS-e820: [mem 0x000000907fe00000-0x000000907fffffff] reserved
BIOS-e820: [mem 0x0000009080000000-0x000000a87fdfffff] usable
BIOS-e820: [mem 0x000000a87fe00000-0x000000a87fffffff] reserved
BIOS-e820: [mem 0x000000a880000000-0x000000c07e7bffff] usable
BIOS-e820: [mem 0x000000c07e7c0000-0x000000c07fbfffff] reserved
BIOS-e820: [mem 0x000000c07fc00000-0x000000c07fcfffff] usable
BIOS-e820: [mem 0x000000c07fd00000-0x000000c07fffffff] reserved
BIOS-e820: [mem 0x0000010000000000-0x00000100201fffff] reserved
BIOS-e820: [mem 0x000001dfa0000000-0x000001dfc01fffff] reserved
BIOS-e820: [mem 0x000002bf40000000-0x000002bf601fffff] reserved
BIOS-e820: [mem 0x0000039ee0000000-0x0000039f001fffff] reserved
BIOS-e820: [mem 0x0000047e80000000-0x0000047ea01fffff] reserved
BIOS-e820: [mem 0x0000055e20000000-0x0000055e401fffff] reserved
BIOS-e820: [mem 0x0000063dc0000000-0x0000063de01fffff] reserved
BIOS-e820: [mem 0x0000071d60000000-0x0000071d801fffff] reserved
Kernel compiled without mitigations, ignoring 'mitigations'; system may still be vulnerable
NX (Execute Disable) protection: active
APIC: Static calls initialized
extended physical RAM map:
reserve setup_data: [mem 0x0000000000000000-0x000000000008efff] usable
reserve setup_data: [mem 0x000000000008f000-0x000000000008ffff] ACPI NVS
reserve setup_data: [mem 0x0000000000090000-0x000000000009ffff] usable
reserve setup_data: [mem 0x0000000000100000-0x000000004bd0701f] usable
reserve setup_data: [mem 0x000000004bd07020-0x000000004bd6965f] usable
reserve setup_data: [mem 0x000000004bd69660-0x000000004bd6a01f] usable
reserve setup_data: [mem 0x000000004bd6a020-0x000000004bdcc65f] usable
reserve setup_data: [mem 0x000000004bdcc660-0x000000004bdcd01f] usable
reserve setup_data: [mem 0x000000004bdcd020-0x000000004be01c5f] usable
reserve setup_data: [mem 0x000000004be01c60-0x000000004be0201f] usable
reserve setup_data: [mem 0x000000004be02020-0x000000004be36c5f] usable
reserve setup_data: [mem 0x000000004be36c60-0x000000004be3701f] usable
reserve setup_data: [mem 0x000000004be37020-0x000000004be3f05f] usable
reserve setup_data: [mem 0x000000004be3f060-0x000000004be4001f] usable
reserve setup_data: [mem 0x000000004be40020-0x000000004be5325f] usable
reserve setup_data: [mem 0x000000004be53260-0x000000004be5401f] usable
reserve setup_data: [mem 0x000000004be54020-0x000000004be8a45f] usable
reserve setup_data: [mem 0x000000004be8a460-0x000000004be8b01f] usable
reserve setup_data: [mem 0x000000004be8b020-0x000000004bec145f] usable
reserve setup_data: [mem 0x000000004bec1460-0x000000004bec201f] usable
reserve setup_data: [mem 0x000000004bec2020-0x000000004bef845f] usable
reserve setup_data: [mem 0x000000004bef8460-0x000000004bef901f] usable
reserve setup_data: [mem 0x000000004bef9020-0x000000004bf2f45f] usable
reserve setup_data: [mem 0x000000004bf2f460-0x0000000059cccfff] usable
reserve setup_data: [mem 0x0000000059ccd000-0x0000000059ccffff] reserved
reserve setup_data: [mem 0x0000000059cd0000-0x00000000677cefff] usable
reserve setup_data: [mem 0x00000000677cf000-0x000000006dfcefff] reserved
reserve setup_data: [mem 0x000000006dfcf000-0x000000006edfefff] ACPI NVS
reserve setup_data: [mem 0x000000006edff000-0x000000006effefff] ACPI data
reserve setup_data: [mem 0x000000006efff000-0x000000006effffff] usable
reserve setup_data: [mem 0x000000006f000000-0x000000006fffffff] ACPI NVS
reserve setup_data: [mem 0x0000000070000000-0x000000008fffffff] reserved
reserve setup_data: [mem 0x000000009c000000-0x000000009cffffff] reserved
reserve setup_data: [mem 0x00000000a9000000-0x00000000a9ffffff] reserved
reserve setup_data: [mem 0x00000000b6000000-0x00000000b6ffffff] reserved
reserve setup_data: [mem 0x00000000c3000000-0x00000000c3ffffff] reserved
reserve setup_data: [mem 0x00000000d0000000-0x00000000d0ffffff] reserved
reserve setup_data: [mem 0x00000000dd000000-0x00000000ddffffff] reserved
reserve setup_data: [mem 0x00000000ea000000-0x00000000eaffffff] reserved
reserve setup_data: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
reserve setup_data: [mem 0x0000000100000000-0x000000187fdfffff] usable
reserve setup_data: [mem 0x000000187fe00000-0x000000187fffffff] reserved
reserve setup_data: [mem 0x0000001880000000-0x000000307fdfffff] usable
reserve setup_data: [mem 0x000000307fe00000-0x000000307fffffff] reserved
reserve setup_data: [mem 0x0000003080000000-0x000000487fdfffff] usable
reserve setup_data: [mem 0x000000487fe00000-0x000000487fffffff] reserved
reserve setup_data: [mem 0x0000004880000000-0x000000607edfffff] usable
reserve setup_data: [mem 0x000000607ee00000-0x000000607fffffff] reserved
reserve setup_data: [mem 0x0000006080000000-0x000000787fdfffff] usable
reserve setup_data: [mem 0x000000787fe00000-0x000000787fffffff] reserved
reserve setup_data: [mem 0x0000007880000000-0x000000907fdfffff] usable
reserve setup_data: [mem 0x000000907fe00000-0x000000907fffffff] reserved
reserve setup_data: [mem 0x0000009080000000-0x000000a87fdfffff] usable
reserve setup_data: [mem 0x000000a87fe00000-0x000000a87fffffff] reserved
reserve setup_data: [mem 0x000000a880000000-0x000000c07e7bffff] usable
reserve setup_data: [mem 0x000000c07e7c0000-0x000000c07fbfffff] reserved
reserve setup_data: [mem 0x000000c07fc00000-0x000000c07fcfffff] usable
reserve setup_data: [mem 0x000000c07fd00000-0x000000c07fffffff] reserved
reserve setup_data: [mem 0x0000010000000000-0x00000100201fffff] reserved
reserve setup_data: [mem 0x000001dfa0000000-0x000001dfc01fffff] reserved
reserve setup_data: [mem 0x000002bf40000000-0x000002bf601fffff] reserved
reserve setup_data: [mem 0x0000039ee0000000-0x0000039f001fffff] reserved
reserve setup_data: [mem 0x0000047e80000000-0x0000047ea01fffff] reserved
reserve setup_data: [mem 0x0000055e20000000-0x0000055e401fffff] reserved
reserve setup_data: [mem 0x0000063dc0000000-0x0000063de01fffff] reserved
reserve setup_data: [mem 0x0000071d60000000-0x0000071d801fffff] reserved
efi: EFI v2.7 by Dell Inc.
efi: ACPI=0x6effe000 ACPI 2.0=0x6effe014 TPMFinalLog=0x6ed95000 MEMATTR=0x62fadaa0 SMBIOS=0x69185000 SMBIOS 3.0=0x69183000 INITRD=0x54797da0 RNG=0x6eefd020 TPMEventLog=0x6eeee020
random: crng init done
efi: Remove mem55: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
efi: Remove mem56: MMIO range=[0x9c000000-0x9cffffff] (16MB) from e820 map
efi: Remove mem57: MMIO range=[0xa9000000-0xa9ffffff] (16MB) from e820 map
efi: Remove mem58: MMIO range=[0xb6000000-0xb6ffffff] (16MB) from e820 map
efi: Remove mem59: MMIO range=[0xc3000000-0xc3ffffff] (16MB) from e820 map
efi: Remove mem60: MMIO range=[0xd0000000-0xd0ffffff] (16MB) from e820 map
efi: Remove mem61: MMIO range=[0xdd000000-0xddffffff] (16MB) from e820 map
efi: Remove mem62: MMIO range=[0xea000000-0xeaffffff] (16MB) from e820 map
efi: Remove mem63: MMIO range=[0xfd000000-0xffffffff] (48MB) from e820 map
efi: Remove mem73: MMIO range=[0x10000000000-0x100201fffff] (514MB) from e820 map
efi: Remove mem74: MMIO range=[0x1dfa0000000-0x1dfc01fffff] (514MB) from e820 map
efi: Remove mem75: MMIO range=[0x2bf40000000-0x2bf601fffff] (514MB) from e820 map
efi: Remove mem76: MMIO range=[0x39ee0000000-0x39f001fffff] (514MB) from e820 map
efi: Remove mem77: MMIO range=[0x47e80000000-0x47ea01fffff] (514MB) from e820 map
efi: Remove mem78: MMIO range=[0x55e20000000-0x55e401fffff] (514MB) from e820 map
efi: Remove mem79: MMIO range=[0x63dc0000000-0x63de01fffff] (514MB) from e820 map
efi: Remove mem80: MMIO range=[0x71d60000000-0x71d801fffff] (514MB) from e820 map
SMBIOS 3.3.0 present.
DMI: Dell Inc. PowerEdge R7625/06444F, BIOS 1.8.3 04/02/2024
DMI: Memory slots populated: 24/24
tsc: Fast TSC calibration using PIT
tsc: Detected 2250.007 MHz processor
last_pfn = 0xc07fd00 max_arch_pfn = 0x400000000
MTRR map: 5 entries (2 fixed + 3 variable; max 19), built from 9 variable MTRRs
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
x2apic: enabled by BIOS, switching to x2apic ops
last_pfn = 0x6f000 max_arch_pfn = 0x400000000
Using GB pages for direct mapping
Secure boot disabled
RAMDISK: [mem 0x4bf30000-0x4e31dfff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x000000006EFFE014 000024 (v02 DELL  )
ACPI: XSDT 0x000000006EF00188 0000DC (v01 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: FACP 0x000000006EFFA000 000114 (v06 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: DSDT 0x000000006EF26000 0C986A (v02 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: FACS 0x000000006EDAF000 000040
ACPI: BERT 0x000000006EFFC000 000030 (v01 DELL   PE_SC3   00000001 DELL 00000001)
ACPI: HEST 0x000000006EFFB000 0008D4 (v01 DELL   PE_SC3   00000001 DELL 00000001)
ACPI: HPET 0x000000006EFF9000 000038 (v01 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: APIC 0x000000006EFF2000 0060BE (v05 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: MCFG 0x000000006EFF1000 00003C (v01 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: WSMT 0x000000006EFF0000 000028 (v01 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: SSDT 0x000000006EF25000 000513 (v02 DELL   xhc_port 00000001 INTL 20210331)
ACPI: SSDT 0x000000006EF23000 00111F (v02 AMD    CPMRAS   00000001 INTL 20210331)
ACPI: SSDT 0x000000006EF22000 000623 (v02 DELL   Tpm2Tabl 00001000 INTL 20210331)
ACPI: TPM2 0x000000006EF21000 00004C (v04 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: EINJ 0x000000006EF20000 000170 (v01 AMD    PE_SC3   00000001 AMD  00000001)
ACPI: ASPT 0x000000006EF1F000 000070 (v02 DELL   AmdTable 00000001 AMD  00000001)
ACPI: SSDT 0x000000006EF0F000 00FE24 (v02 DELL   PE_SC3   00000001 AMD  00000001)
ACPI: SRAT 0x000000006EF0B000 003580 (v03 DELL   PE_SC3   00000001 AMD  00000001)
ACPI: MSCT 0x000000006EF0A000 00004E (v01 DELL   PE_SC3   00000000 AMD  00000001)
ACPI: SLIT 0x000000006EF09000 00042C (v01 DELL   PE_SC3   00000001 AMD  00000001)
ACPI: HMAT 0x000000006EF07000 001768 (v02 DELL   AmdTable 00000001 AMD  00000001)
ACPI: IVRS 0x000000006EF06000 000370 (v02 DELL   PE_SC3   00000001 AMD  00000001)
ACPI: SPCR 0x000000006EF05000 000050 (v02 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: SSDT 0x000000006EF01000 0030DC (v02 DELL   PE_SC3   00000002 DELL 00000001)
ACPI: NBFT 0x000000006EFFD000 000123 (v01 DELL   PE_SC3   00000000 DELL 00000001)
ACPI: SSDT 0x000000006EEFE000 00193C (v02 AMD    CPMCMN   00000001 INTL 20210331)
ACPI: Reserving FACP table memory at [mem 0x6effa000-0x6effa113]
ACPI: Reserving DSDT table memory at [mem 0x6ef26000-0x6efef869]
ACPI: Reserving FACS table memory at [mem 0x6edaf000-0x6edaf03f]
ACPI: Reserving BERT table memory at [mem 0x6effc000-0x6effc02f]
ACPI: Reserving HEST table memory at [mem 0x6effb000-0x6effb8d3]
ACPI: Reserving HPET table memory at [mem 0x6eff9000-0x6eff9037]
ACPI: Reserving APIC table memory at [mem 0x6eff2000-0x6eff80bd]
ACPI: Reserving MCFG table memory at [mem 0x6eff1000-0x6eff103b]
ACPI: Reserving WSMT table memory at [mem 0x6eff0000-0x6eff0027]
ACPI: Reserving SSDT table memory at [mem 0x6ef25000-0x6ef25512]
ACPI: Reserving SSDT table memory at [mem 0x6ef23000-0x6ef2411e]
ACPI: Reserving SSDT table memory at [mem 0x6ef22000-0x6ef22622]
ACPI: Reserving TPM2 table memory at [mem 0x6ef21000-0x6ef2104b]
ACPI: Reserving EINJ table memory at [mem 0x6ef20000-0x6ef2016f]
ACPI: Reserving ASPT table memory at [mem 0x6ef1f000-0x6ef1f06f]
ACPI: Reserving SSDT table memory at [mem 0x6ef0f000-0x6ef1ee23]
ACPI: Reserving SRAT table memory at [mem 0x6ef0b000-0x6ef0e57f]
ACPI: Reserving MSCT table memory at [mem 0x6ef0a000-0x6ef0a04d]
ACPI: Reserving SLIT table memory at [mem 0x6ef09000-0x6ef0942b]
ACPI: Reserving HMAT table memory at [mem 0x6ef07000-0x6ef08767]
ACPI: Reserving IVRS table memory at [mem 0x6ef06000-0x6ef0636f]
ACPI: Reserving SPCR table memory at [mem 0x6ef05000-0x6ef0504f]
ACPI: Reserving SSDT table memory at [mem 0x6ef01000-0x6ef040db]
ACPI: Reserving NBFT table memory at [mem 0x6effd000-0x6effd122]
ACPI: Reserving SSDT table memory at [mem 0x6eefe000-0x6eeff93b]
APIC: Switched APIC routing to: cluster x2apic
ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x000c0000-0x7fffffff]
ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x67fffffff]
ACPI: SRAT: Node 1 PXM 1 [mem 0x680000000-0xc7fffffff]
ACPI: SRAT: Node 2 PXM 8 [mem 0xc80000000-0x127fffffff]
ACPI: SRAT: Node 4 PXM 4 [mem 0x1880000000-0x1e7fffffff]
ACPI: SRAT: Node 3 PXM 9 [mem 0x1280000000-0x187fffffff]
ACPI: SRAT: Node 5 PXM 5 [mem 0x1e80000000-0x247fffffff]
ACPI: SRAT: Node 6 PXM 12 [mem 0x2480000000-0x2a7fffffff]
ACPI: SRAT: Node 8 PXM 6 [mem 0x3080000000-0x367fffffff]
ACPI: SRAT: Node 7 PXM 13 [mem 0x2a80000000-0x307fffffff]
ACPI: SRAT: Node 9 PXM 7 [mem 0x3680000000-0x3c7fffffff]
ACPI: SRAT: Node 10 PXM 14 [mem 0x3c80000000-0x427fffffff]
ACPI: SRAT: Node 12 PXM 2 [mem 0x4880000000-0x4e7fffffff]
ACPI: SRAT: Node 11 PXM 15 [mem 0x4280000000-0x487fffffff]
ACPI: SRAT: Node 13 PXM 3 [mem 0x4e80000000-0x547fffffff]
ACPI: SRAT: Node 14 PXM 10 [mem 0x5480000000-0x5a7fffffff]
ACPI: SRAT: Node 15 PXM 11 [mem 0x5a80000000-0x607fffffff]
ACPI: SRAT: Node 16 PXM 16 [mem 0x6080000000-0x667fffffff]
ACPI: SRAT: Node 17 PXM 17 [mem 0x6680000000-0x6c7fffffff]
ACPI: SRAT: Node 18 PXM 24 [mem 0x6c80000000-0x727fffffff]
ACPI: SRAT: Node 20 PXM 20 [mem 0x7880000000-0x7e7fffffff]
ACPI: SRAT: Node 19 PXM 25 [mem 0x7280000000-0x787fffffff]
ACPI: SRAT: Node 21 PXM 21 [mem 0x7e80000000-0x847fffffff]
ACPI: SRAT: Node 22 PXM 28 [mem 0x8480000000-0x8a7fffffff]
ACPI: SRAT: Node 24 PXM 22 [mem 0x9080000000-0x967fffffff]
ACPI: SRAT: Node 23 PXM 29 [mem 0x8a80000000-0x907fffffff]
ACPI: SRAT: Node 25 PXM 23 [mem 0x9680000000-0x9c7fffffff]
ACPI: SRAT: Node 26 PXM 30 [mem 0x9c80000000-0xa27fffffff]
ACPI: SRAT: Node 28 PXM 18 [mem 0xa880000000-0xae7fffffff]
ACPI: SRAT: Node 27 PXM 31 [mem 0xa280000000-0xa87fffffff]
ACPI: SRAT: Node 29 PXM 19 [mem 0xae80000000-0xb47fffffff]
ACPI: SRAT: Node 30 PXM 26 [mem 0xb480000000-0xba7fffffff]
ACPI: SRAT: Node 31 PXM 27 [mem 0xba80000000-0xc07fffffff]
NUMA: Node 0 [mem 0x00001000-0x0009ffff] + [mem 0x000c0000-0x7fffffff] -> [mem 0x00001000-0x7fffffff]
NUMA: Node 0 [mem 0x00001000-0x7fffffff] + [mem 0x100000000-0x67fffffff] -> [mem 0x00001000-0x67fffffff]
NODE_DATA(0) allocated [mem 0x67fffdf40-0x67fffffff]
NODE_DATA(1) allocated [mem 0xc7fffdf40-0xc7fffffff]
NODE_DATA(2) allocated [mem 0x127fffdf40-0x127fffffff]
NODE_DATA(3) allocated [mem 0x187fdfdf40-0x187fdfffff]
NODE_DATA(4) allocated [mem 0x1e7fffdf40-0x1e7fffffff]
NODE_DATA(5) allocated [mem 0x247fffdf40-0x247fffffff]
NODE_DATA(6) allocated [mem 0x2a7fffdf40-0x2a7fffffff]
NODE_DATA(7) allocated [mem 0x307fdfdf40-0x307fdfffff]
NODE_DATA(8) allocated [mem 0x367fffdf40-0x367fffffff]
NODE_DATA(9) allocated [mem 0x3c7fffdf40-0x3c7fffffff]
NODE_DATA(10) allocated [mem 0x427fffdf40-0x427fffffff]
NODE_DATA(11) allocated [mem 0x487fdfdf40-0x487fdfffff]
NODE_DATA(12) allocated [mem 0x4e7fffdf40-0x4e7fffffff]
NODE_DATA(13) allocated [mem 0x547fffdf40-0x547fffffff]
NODE_DATA(14) allocated [mem 0x5a7fffdf40-0x5a7fffffff]
NODE_DATA(15) allocated [mem 0x607edfdf40-0x607edfffff]
NODE_DATA(16) allocated [mem 0x667fffdf40-0x667fffffff]
NODE_DATA(17) allocated [mem 0x6c7fffdf40-0x6c7fffffff]
NODE_DATA(18) allocated [mem 0x727fffdf40-0x727fffffff]
NODE_DATA(19) allocated [mem 0x787fdfdf40-0x787fdfffff]
NODE_DATA(20) allocated [mem 0x7e7fffdf40-0x7e7fffffff]
NODE_DATA(21) allocated [mem 0x847fffdf40-0x847fffffff]
NODE_DATA(22) allocated [mem 0x8a7fffdf40-0x8a7fffffff]
NODE_DATA(23) allocated [mem 0x907fdfdf40-0x907fdfffff]
NODE_DATA(24) allocated [mem 0x967fffdf40-0x967fffffff]
NODE_DATA(25) allocated [mem 0x9c7fffdf40-0x9c7fffffff]
NODE_DATA(26) allocated [mem 0xa27fffdf40-0xa27fffffff]
NODE_DATA(27) allocated [mem 0xa87fdfdf40-0xa87fdfffff]
NODE_DATA(28) allocated [mem 0xae7fffdf40-0xae7fffffff]
NODE_DATA(29) allocated [mem 0xb47fffdf40-0xb47fffffff]
NODE_DATA(30) allocated [mem 0xba7fffdf40-0xba7fffffff]
NODE_DATA(31) allocated [mem 0xc07fcfcf40-0xc07fcfefff]
Zone ranges:
  DMA32    [mem 0x0000000000001000-0x00000000ffffffff]
  Normal   [mem 0x0000000100000000-0x000000c07fcfffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000008efff]
  node   0: [mem 0x0000000000090000-0x000000000009ffff]
  node   0: [mem 0x0000000000100000-0x0000000059cccfff]
  node   0: [mem 0x0000000059cd0000-0x00000000677cefff]
  node   0: [mem 0x000000006efff000-0x000000006effffff]
  node   0: [mem 0x0000000100000000-0x000000067fffffff]
  node   1: [mem 0x0000000680000000-0x0000000c7fffffff]
  node   2: [mem 0x0000000c80000000-0x000000127fffffff]
  node   3: [mem 0x0000001280000000-0x000000187fdfffff]
  node   4: [mem 0x0000001880000000-0x0000001e7fffffff]
  node   5: [mem 0x0000001e80000000-0x000000247fffffff]
  node   6: [mem 0x0000002480000000-0x0000002a7fffffff]
  node   7: [mem 0x0000002a80000000-0x000000307fdfffff]
  node   8: [mem 0x0000003080000000-0x000000367fffffff]
  node   9: [mem 0x0000003680000000-0x0000003c7fffffff]
  node  10: [mem 0x0000003c80000000-0x000000427fffffff]
  node  11: [mem 0x0000004280000000-0x000000487fdfffff]
  node  12: [mem 0x0000004880000000-0x0000004e7fffffff]
  node  13: [mem 0x0000004e80000000-0x000000547fffffff]
  node  14: [mem 0x0000005480000000-0x0000005a7fffffff]
  node  15: [mem 0x0000005a80000000-0x000000607edfffff]
  node  16: [mem 0x0000006080000000-0x000000667fffffff]
  node  17: [mem 0x0000006680000000-0x0000006c7fffffff]
  node  18: [mem 0x0000006c80000000-0x000000727fffffff]
  node  19: [mem 0x0000007280000000-0x000000787fdfffff]
  node  20: [mem 0x0000007880000000-0x0000007e7fffffff]
  node  21: [mem 0x0000007e80000000-0x000000847fffffff]
  node  22: [mem 0x0000008480000000-0x0000008a7fffffff]
  node  23: [mem 0x0000008a80000000-0x000000907fdfffff]
  node  24: [mem 0x0000009080000000-0x000000967fffffff]
  node  25: [mem 0x0000009680000000-0x0000009c7fffffff]
  node  26: [mem 0x0000009c80000000-0x000000a27fffffff]
  node  27: [mem 0x000000a280000000-0x000000a87fdfffff]
  node  28: [mem 0x000000a880000000-0x000000ae7fffffff]
  node  29: [mem 0x000000ae80000000-0x000000b47fffffff]
  node  30: [mem 0x000000b480000000-0x000000ba7fffffff]
  node  31: [mem 0x000000ba80000000-0x000000c07e7bffff]
  node  31: [mem 0x000000c07fc00000-0x000000c07fcfffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000067fffffff]
Initmem setup node 1 [mem 0x0000000680000000-0x0000000c7fffffff]
Initmem setup node 2 [mem 0x0000000c80000000-0x000000127fffffff]
Initmem setup node 3 [mem 0x0000001280000000-0x000000187fdfffff]
Initmem setup node 4 [mem 0x0000001880000000-0x0000001e7fffffff]
Initmem setup node 5 [mem 0x0000001e80000000-0x000000247fffffff]
Initmem setup node 6 [mem 0x0000002480000000-0x0000002a7fffffff]
Initmem setup node 7 [mem 0x0000002a80000000-0x000000307fdfffff]
Initmem setup node 8 [mem 0x0000003080000000-0x000000367fffffff]
Initmem setup node 9 [mem 0x0000003680000000-0x0000003c7fffffff]
Initmem setup node 10 [mem 0x0000003c80000000-0x000000427fffffff]
Initmem setup node 11 [mem 0x0000004280000000-0x000000487fdfffff]
Initmem setup node 12 [mem 0x0000004880000000-0x0000004e7fffffff]
Initmem setup node 13 [mem 0x0000004e80000000-0x000000547fffffff]
Initmem setup node 14 [mem 0x0000005480000000-0x0000005a7fffffff]
Initmem setup node 15 [mem 0x0000005a80000000-0x000000607edfffff]
Initmem setup node 16 [mem 0x0000006080000000-0x000000667fffffff]
Initmem setup node 17 [mem 0x0000006680000000-0x0000006c7fffffff]
Initmem setup node 18 [mem 0x0000006c80000000-0x000000727fffffff]
Initmem setup node 19 [mem 0x0000007280000000-0x000000787fdfffff]
Initmem setup node 20 [mem 0x0000007880000000-0x0000007e7fffffff]
Initmem setup node 21 [mem 0x0000007e80000000-0x000000847fffffff]
Initmem setup node 22 [mem 0x0000008480000000-0x0000008a7fffffff]
Initmem setup node 23 [mem 0x0000008a80000000-0x000000907fdfffff]
Initmem setup node 24 [mem 0x0000009080000000-0x000000967fffffff]
Initmem setup node 25 [mem 0x0000009680000000-0x0000009c7fffffff]
Initmem setup node 26 [mem 0x0000009c80000000-0x000000a27fffffff]
Initmem setup node 27 [mem 0x000000a280000000-0x000000a87fdfffff]
Initmem setup node 28 [mem 0x000000a880000000-0x000000ae7fffffff]
Initmem setup node 29 [mem 0x000000ae80000000-0x000000b47fffffff]
Initmem setup node 30 [mem 0x000000b480000000-0x000000ba7fffffff]
Initmem setup node 31 [mem 0x000000ba80000000-0x000000c07fcfffff]
On node 0, zone DMA32: 1 pages in unavailable ranges
On node 0, zone DMA32: 1 pages in unavailable ranges
On node 0, zone DMA32: 96 pages in unavailable ranges
On node 0, zone DMA32: 3 pages in unavailable ranges
On node 0, zone DMA32: 30768 pages in unavailable ranges
On node 0, zone Normal: 4096 pages in unavailable ranges
On node 4, zone Normal: 512 pages in unavailable ranges
On node 8, zone Normal: 512 pages in unavailable ranges
On node 12, zone Normal: 512 pages in unavailable ranges
On node 16, zone Normal: 4608 pages in unavailable ranges
On node 20, zone Normal: 512 pages in unavailable ranges
On node 24, zone Normal: 512 pages in unavailable ranges
On node 28, zone Normal: 512 pages in unavailable ranges
On node 31, zone Normal: 5184 pages in unavailable ranges
On node 31, zone Normal: 768 pages in unavailable ranges
ACPI: PM-Timer IO Port: 0x408
ACPI: X2APIC_NMI (uid[0xffffffff] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
IOAPIC[0]: apic_id 240, version 33, address 0xfec00000, GSI 0-23
IOAPIC[1]: apic_id 241, version 33, address 0xea180000, GSI 120-151
IOAPIC[2]: apic_id 242, version 33, address 0xdd180000, GSI 88-119
IOAPIC[3]: apic_id 243, version 33, address 0xfd180000, GSI 24-55
IOAPIC[4]: apic_id 244, version 33, address 0xd0180000, GSI 56-87
IOAPIC[5]: apic_id 245, version 33, address 0xc3180000, GSI 248-279
IOAPIC[6]: apic_id 246, version 33, address 0xb6180000, GSI 216-247
IOAPIC[7]: apic_id 247, version 33, address 0xa9280000, GSI 152-183
IOAPIC[8]: apic_id 248, version 33, address 0x9c180000, GSI 184-215
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x10228201 base: 0xfed00000
ACPI: SPCR: console: uart,io,0x2f8,115200
CPU topo: Max. logical packages:   2
CPU topo: Max. logical dies:      16
CPU topo: Max. dies per package:   8
CPU topo: Max. threads per core:   2
CPU topo: Num. cores per package:   128
CPU topo: Num. threads per package: 256
CPU topo: Allowing 512 present CPUs plus 0 hotplug CPUs
[mem 0x80000000-0xffffffff] available for PCI devices
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_ids:32
percpu: Embedded 53 pages/cpu s179352 r8192 d29544 u262144
Kernel command line: BOOT_IMAGE=/vmlinuz-6.12.0-rc2+ root=UUID=d155ab07-2863-462d-931e-ce417aca7adb ro nvme.poll_queues=16 mitigations=off console=ttyS1,115200 console=tty0
Unknown kernel command line parameters "BOOT_IMAGE=/vmlinuz-6.12.0-rc2+", will be passed to user space.
printk: log_buf_len individual max cpu contribution: 4096 bytes
printk: log_buf_len total cpu_extra contributions: 2093056 bytes
printk: log_buf_len min size: 131072 bytes
printk: log_buf_len: 4194304 bytes
printk: early log buf free: 94952(72%)
Fallback order for Node 0: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
Fallback order for Node 1: 1 2 3 0 5 6 7 8 9 10 11 12 13 14 15 4 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 16
Fallback order for Node 2: 2 3 0 6 7 8 9 10 11 12 13 14 15 1 4 5 18 19 20 21 22 23 24 25 26 27 28 29 30 31 16 17
Fallback order for Node 3: 3 0 7 8 9 10 11 12 13 14 15 2 5 6 1 4 19 20 21 22 23 24 25 26 27 28 29 30 31 16 17 18
Fallback order for Node 4: 4 6 7 5 8 9 10 11 12 13 14 15 0 3 2 1 20 21 22 23 24 25 26 27 28 29 30 31 16 17 18 19
Fallback order for Node 5: 5 7 6 9 10 11 12 13 14 15 8 4 0 3 2 1 21 22 23 24 25 26 27 28 29 30 31 16 17 18 19 20
Fallback order for Node 6: 6 7 10 11 12 13 14 15 8 9 5 4 3 0 2 1 22 23 24 25 26 27 28 29 30 31 16 17 18 19 20 21
Fallback order for Node 7: 7 11 12 13 14 15 8 9 10 6 5 4 0 2 3 1 23 24 25 26 27 28 29 30 31 16 17 18 19 20 21 22
Fallback order for Node 8: 8 9 10 11 12 13 14 15 2 3 0 1 5 6 7 4 24 25 26 27 28 29 30 31 16 17 18 19 20 21 22 23
Fallback order for Node 9: 9 10 11 13 14 15 8 12 2 3 0 1 5 6 7 4 25 26 27 28 29 30 31 16 17 18 19 20 21 22 23 24
Fallback order for Node 10: 10 11 14 15 13 8 9 12 2 3 0 1 5 6 7 4 26 27 28 29 30 31 16 17 18 19 20 21 22 23 24 25
Fallback order for Node 11: 11 15 13 14 9 10 8 12 2 3 0 1 5 6 7 4 27 28 29 30 31 16 17 18 19 20 21 22 23 24 25 26
Fallback order for Node 12: 12 13 14 15 2 3 10 11 0 1 5 6 7 8 9 4 28 29 30 31 16 17 18 19 20 21 22 23 24 25 26 27
Fallback order for Node 13: 13 14 15 12 3 10 11 0 1 2 5 6 7 8 9 4 29 30 31 16 17 18 19 20 21 22 23 24 25 26 27 28
Fallback order for Node 14: 14 15 13 12 10 11 0 1 2 3 5 6 7 8 9 4 30 31 16 17 18 19 20 21 22 23 24 25 26 27 28 29
Fallback order for Node 15: 15 13 14 12 11 0 1 2 3 5 6 7 8 9 10 4 31 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
Fallback order for Node 16: 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 14 15 0 1 2 3 5 6 7 8 9 10 11 13 4 12
Fallback order for Node 17: 17 18 19 16 21 22 23 24 25 26 27 28 29 30 31 20 15 0 1 2 3 5 6 7 8 9 10 11 13 14 4 12
Fallback order for Node 18: 18 19 16 22 23 24 25 26 27 28 29 30 31 17 20 21 0 1 2 3 5 6 7 8 9 10 11 13 14 15 4 12
Fallback order for Node 19: 19 16 23 24 25 26 27 28 29 30 31 18 21 22 17 20 1 2 3 5 6 7 8 9 10 11 13 14 15 0 4 12
Fallback order for Node 20: 20 22 23 21 24 25 26 27 28 29 30 31 16 19 18 17 2 3 5 6 7 8 9 10 11 13 14 15 0 1 4 12
Fallback order for Node 21: 21 23 22 25 26 27 28 29 30 31 24 20 16 19 18 17 3 5 6 7 8 9 10 11 13 14 15 0 1 2 4 12
Fallback order for Node 22: 22 23 26 27 28 29 30 31 24 25 21 20 19 16 18 17 5 6 7 8 9 10 11 13 14 15 0 1 2 3 4 12
Fallback order for Node 23: 23 27 28 29 30 31 24 25 26 22 21 20 16 18 19 17 6 7 8 9 10 11 13 14 15 0 1 2 3 4 5 12
Fallback order for Node 24: 24 25 26 27 28 29 30 31 18 19 16 17 21 22 23 20 7 8 9 10 11 13 14 15 0 1 2 3 4 5 6 12
Fallback order for Node 25: 25 26 27 29 30 31 24 28 18 19 16 17 21 22 23 20 8 9 10 11 13 14 15 0 1 2 3 4 5 6 7 12
Fallback order for Node 26: 26 27 30 31 29 24 25 28 18 19 16 17 21 22 23 20 9 10 11 13 14 15 0 1 2 3 4 5 6 7 8 12
Fallback order for Node 27: 27 31 29 30 25 26 24 28 18 19 16 17 21 22 23 20 10 11 13 14 15 0 1 2 3 4 5 6 7 8 9 12
Fallback order for Node 28: 28 29 30 31 18 19 26 27 16 17 21 22 23 24 25 20 11 13 14 15 0 1 2 3 4 5 6 7 8 9 10 12
Fallback order for Node 29: 29 30 31 28 19 26 27 16 17 18 21 22 23 24 25 20 13 14 15 0 1 2 3 4 5 6 7 8 9 10 11 12
Fallback order for Node 30: 30 31 29 28 26 27 16 17 18 19 21 22 23 24 25 20 14 15 0 1 2 3 4 5 6 7 8 9 10 11 12 13
Fallback order for Node 31: 31 29 30 28 27 16 17 18 19 21 22 23 24 25 26 20 15 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14
Built 32 zonelists, mobility grouping on.  Total pages: 201212459
Policy zone: Normal
mem auto-init: stack:off, heap alloc:on, heap free:off
software IO TLB: area num 512.
software IO TLB: SWIOTLB bounce buffer size roundup to 128MB
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=512, Nodes=32
ftrace: allocating 40090 entries in 157 pages
ftrace: allocated 157 pages with 5 groups
rcu: Hierarchical RCU implementation.
 Rude variant of Tasks RCU enabled.
 Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 12 jiffies.
RCU Tasks Rude: Setting shift to 9 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=512.
RCU Tasks Trace: Setting shift to 9 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=512.
NR_IRQS: 33024, nr_irqs: 8872, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes to big.
Console: colour dummy device 80x25
printk: legacy console [tty0] enabled
printk: legacy console [ttyS1] enabled
mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
ACPI: Core revision 20240827
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
APIC: Switch to symmetric I/O mode setup
AMD-Vi: Using global IVHD EFR:0x25bf732fa2295afe, EFR2:0x1d
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x206ebacc55f, max_idle_ns: 440795306246 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 4500.01 BogoMIPS (lpj=22500070)
x86/cpu: User Mode Instruction Prevention (UMIP) activated
LVT offset 2 assigned for vector 0xf4
Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
process: using mwait in idle threads
Spectre V2 : User space: Vulnerable
Speculative Store Bypass: Vulnerable
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
x86/fpu: xstate_offset[11]: 2432, xstate_sizes[11]:   16
x86/fpu: Enabled xstate features 0x8e7, context size is 2448 bytes, using 'compacted' format.
Freeing SMP alternatives memory: 36K
pid_max: default: 524288 minimum: 4096
Dentry cache hash table entries: 33554432 (order: 16, 268435456 bytes, vmalloc hugepage)
Inode-cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc hugepage)
Mount-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
Mountpoint-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
smpboot: CPU0: AMD EPYC 9754 128-Core Processor (family: 0x19, model: 0xa0, stepping: 0x2)
Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
... version:                2
... bit width:              48
... generic registers:      6
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   0
... event mask:             000000000000003f
signal: max sigframe size: 2960
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
microcode: update_cache: add patch: 0xa00107a
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xa10f10
microcode: update_cache: add patch: 0xa101248
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f00
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f10, n_cid.full: 0xaa0f00
microcode: update_cache: add patch: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xa00f10
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f10, n_cid.full: 0xa00f10
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f00, n_cid.full: 0xa00f10
microcode: update_cache: add patch: 0xa001238
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xa10f10
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f10, n_cid.full: 0xa10f10
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f00, n_cid.full: 0xa10f10
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xa10f10
microcode: update_cache: add patch: 0xa101148
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xa00f10
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f10, n_cid.full: 0xa00f10
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f00, n_cid.full: 0xa00f10
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xa00f10
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f10, n_cid.full: 0xa00f10
microcode: update_cache: add patch: 0xa0011d5
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f00
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f10, n_cid.full: 0xaa0f00
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f00, n_cid.full: 0xaa0f00
microcode: ucode_rev_to_cpuid: val: 0xa001238, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f00
microcode: ucode_rev_to_cpuid: val: 0xa101148, p.stepping: 0x1, c.stepping: 0x1
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f10, n_cid.full: 0xaa0f00
microcode: ucode_rev_to_cpuid: val: 0xa0011d5, p.stepping: 0x1, c.stepping: 0x1
microcode: ucode_rev_to_cpuid: val: 0xaa00116, p.stepping: 0x1, c.stepping: 0x1
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f00
microcode: update_cache: add patch: 0xaa00116
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00215
microcode: ucode_rev_to_cpuid: val: 0xa00107a, p.stepping: 0x0, c.stepping: 0x0
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa00f10, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xa101248, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xa10f12, n_cid.full: 0xaa0f02
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: ucode_rev_to_cpuid: val: 0xaa00215, p.stepping: 0x2, c.stepping: 0x2
microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f02, n_cid.full: 0xaa0f02
microcode: cache_find_patch: using 0xaa00215
BUG: unable to handle page fault for address: 00000001000141ab
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc2+ #144
Hardware name: Dell Inc. PowerEdge R7625/06444F, BIOS 1.8.3 04/02/2024
RIP: 0010:load_microcode_amd.isra.0+0x2b1/0x380
Code: e7 06 48 81 c7 c0 97 9e a5 e8 3b bd 4e 00 89 c7 89 c0 4c 8b 2c c5 40 20 02 a5 49 01 ed e8 87 fa ff ff 48 85 c0 74 12 8b 40 1c <41> 39 85 28 01 00 00 0f 92 c0 0f b6 c0 09 c3 41 8d 4c 24 01 41 83
RSP: 0018:ffffaaa8800e7e08 EFLAGS: 00010286
RAX: 000000000aa00215 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffaaa8800e7c78 RDI: 00000000fffdffff
RBP: 0000000000014080 R08: 00000000fffdffff R09: ffff987ce58fffa8
R10: ffff987ce4e00000 R11: 646f636f7263696d R12: 0000000000000001
R13: 0000000100014083 R14: ffffaaa8800e7e0c R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff97c2e7e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000001000141ab CR3: 00000034d3828001 CR4: 0000000000370ef0
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x2b
 ? page_fault_oops+0x90/0x210
 ? prb_read_valid+0x17/0x20
 ? console_unlock+0xb4/0x240
 ? exc_page_fault+0x6c/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? load_microcode_amd.isra.0+0x2b1/0x380
 ? load_microcode_amd.isra.0+0x2a9/0x380
 save_microcode_in_initrd+0x90/0xb0
 ? find_blobs_in_containers+0xb0/0xb0
 do_one_initcall+0x2e/0x190
 ? try_to_wake_up+0x1c0/0x4b0
 kernel_init_freeable+0xdd/0x210
 ? rest_init+0xc0/0xc0
 kernel_init+0x16/0x120
 ret_from_fork+0x2d/0x50
 ? rest_init+0xc0/0xc0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in:
CR2: 00000001000141ab
---[ end trace 0000000000000000 ]---
RIP: 0010:load_microcode_amd.isra.0+0x2b1/0x380
Code: e7 06 48 81 c7 c0 97 9e a5 e8 3b bd 4e 00 89 c7 89 c0 4c 8b 2c c5 40 20 02 a5 49 01 ed e8 87 fa ff ff 48 85 c0 74 12 8b 40 1c <41> 39 85 28 01 00 00 0f 92 c0 0f b6 c0 09 c3 41 8d 4c 24 01 41 83
RSP: 0018:ffffaaa8800e7e08 EFLAGS: 00010286
RAX: 000000000aa00215 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffaaa8800e7c78 RDI: 00000000fffdffff
RBP: 0000000000014080 R08: 00000000fffdffff R09: ffff987ce58fffa8
R10: ffff987ce4e00000 R11: 646f636f7263696d R12: 0000000000000001
R13: 0000000100014083 R14: ffffaaa8800e7e0c R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff97c2e7e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000001000141ab CR3: 00000034d3828001 CR4: 0000000000370ef0
note: swapper/0[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---

-- 
Jens Axboe

