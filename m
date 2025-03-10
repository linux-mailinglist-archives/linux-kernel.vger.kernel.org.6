Return-Path: <linux-kernel+bounces-553847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4CFA58FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D190168B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90C2253EA;
	Mon, 10 Mar 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO88WR0l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E78D22333B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599260; cv=none; b=VyrAWTn4KSBhSACRbMuAXne6DecdEgnTE/ceYujhIJxn/lL6TTZgu6NdJvhnakv8bl350/ALOkcFlnytlL5B47dVbX2ZDlht0cJZZ80uc6vNKmPHBIiKNTTy3E5RxBT5R+EypJ9Y/6qY1u4ifgUxaNL3U2+rDv0Kzd8U4SGAly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599260; c=relaxed/simple;
	bh=bUGR7AYEjmZ0/GTMtezMy6ASdVQTR8gYl5wlmoOHyzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gabT3zaqm49iroPayCQMgANRPZCK+tjE4Bu9rzJOgTxmwzOjSezyT5WcX1BLtFZswigXDUkIHh8uII2EBTDMtRlv99F1vvfNvSo8yCoxr7GEtvCNGzKgYT0pkYAFrt2cAKAxffc9QXIDgBP2bil7aUBpxdVgTzpLz/thpn2MkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iO88WR0l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxAXCSpoP8920rV5lHzSeHACzkgsW5QFulf8EGPZCMI=;
	b=iO88WR0lJZe4QondO3Yi1+I0uTSpYZTzm4bHUVNVYyE+1rt5xRtZrrMVJ1ihs4xsySXaDC
	djWUpKwxEjRcgjghqM1s1wsl9KfpbC0SwhJTpbGJUhfebD65CXTdHgRms/xayoCrOUhRuf
	ZNp54tOljkamPubNSk5qYcvu9W5ayWE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-l1e3qvLWPECtppJvS-Gy-A-1; Mon, 10 Mar 2025 05:34:16 -0400
X-MC-Unique: l1e3qvLWPECtppJvS-Gy-A-1
X-Mimecast-MFC-AGG-ID: l1e3qvLWPECtppJvS-Gy-A_1741599255
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf59b0b274so369302466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741599255; x=1742204055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxAXCSpoP8920rV5lHzSeHACzkgsW5QFulf8EGPZCMI=;
        b=LTJp3SEMoSE38IJD8fTEgJVphZ6mffHv5RGavzJmEuxPFgUkIMvQ6rowBlmvmkwBHr
         1US73syxOt4EdJiyjfOjZ7WaWZZAlxr0byhw4dN+J/TAo8mBndZ8eqL7u8tZ9kiAwSaO
         Yrp1sJwnUn70a/y53aquMD/cvTgVW2Xy4vquQe79nQq2XrGc4UeSzlh+l3Vj45uuaxhz
         PhP+vA4Yq2N1nvOqfS18jOXWGEcBks964gnijF8D6omNZVvmxkMNUNpArgnRY2LfDJAN
         1NSinaLgzt6z3oIx+rAwb1jdMFT/Y6toFTQht/1C+zS1ZKHlljQzzsgudWB+wlCRJR8h
         Kfhg==
X-Forwarded-Encrypted: i=1; AJvYcCXJqeEigoG0LcN+O7lyyKdFUl8BEwmoMr5FGpXYm+zxGfwP/vqXsnewU0EBpShGZvM3I6Gdgkq6lzeGfxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAELI4IiCRazkEvck3XtCG/83v8+USQ4wV2woYfgGOZ/hBb3RP
	x2TjRbsQ83laEEMJNjSvxKKMIoV7iunkFeFso/JxTjTtSNqGAPHEvsjCCHAlddmGoSfFnymdN7X
	Th+bvNG6D8ZQMTtC/XHZow5pbcGfgry1gktIF4RFnNHXXTT+o2s7tZZ60855O3Q==
X-Gm-Gg: ASbGncstgp3xYmSzO5/wMpgINFqY73VmM4omrfYoDh4VoZVbw/eFR1n1jZRIfhAXuNt
	3jd8iQRGUD9WNj0H/ru85mS9dd3Q64hxj3Ijz5tfPFyL7P0IsU/ZoJCqXoXH+/1va3YyPxG5JnF
	b14eHNmLTE8CACm8Dm338WdXwQmb67Wbv3PC//kO/9aha9HWWdSWqkCaO8aPQAnmJVPV4NWvtDt
	rSJTPyAsSeSM/qEWY2/BpJrRbaV2ESGkdundrLTiPADOYSSviCh7wgKejf4ooOIW7O7FZkisKA8
	OkO2Zng+0iRqHCTaQ90=
X-Received: by 2002:a17:907:2d2b:b0:ac2:b086:88ec with SMTP id a640c23a62f3a-ac2b0868a7bmr65146466b.5.1741599254976;
        Mon, 10 Mar 2025 02:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8YZensyq9aJIcOzf85eeldXt/bSXXdomDPL1jUmJLB9L63zaVvcyVjP7FwLx46h3EpesbiQ==
X-Received: by 2002:a17:907:2d2b:b0:ac2:b086:88ec with SMTP id a640c23a62f3a-ac2b0868a7bmr65143566b.5.1741599254591;
        Mon, 10 Mar 2025 02:34:14 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943c476sm732865966b.3.2025.03.10.02.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:34:13 -0700 (PDT)
Message-ID: <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
Date: Mon, 10 Mar 2025 10:34:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>, Eric <eric.4.debian@grabatoulnz.fr>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan> <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z8rCF39n5GjTwfjP@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7-Mar-25 10:53, Niklas Cassel wrote:
> Hello Eric,
> 
> On Thu, Mar 06, 2025 at 01:27:17PM +0100, Eric wrote:
>>
>> I installed the same system on a USB stick, on which I also installed grub,
>> so that the reboot is made independent of weather the UEFI sees the SSD disk
>> or not. I'll attach dmesg extracts (grep on ata or ahci) to this mail.
> 
> Exellent idea!
> 
> 
>>
>> One is the dmesg after coldbooting from the USB stick, the other is
>> rebooting on the USB stick. First of all, the visible result : the SSD is
>> not detected by linux at reboot (but is when coldbooting).
>>
>> Here is what changes :
>>
>> eric@gwaihir:~$ diff
>> /media/eric/trixieUSB/home/eric/dmesg-ahci-ata-coldboot.untimed.txt
>> /media/eric/trixieUSB/home/eric/dmesg-ahci-ata-reboot.untimed.txt
>>
>> 4c4
>> <  ahci 0000:00:11.0: 4/4 ports implemented (port mask 0x3c)
>> ---
>>>   ahci 0000:00:11.0: 3/3 ports implemented (port mask 0x38)
>> 14c14
>> <  ata3: SATA max UDMA/133 abar m1024@0xfeb0b000 port 0xfeb0b200 irq 19
>> lpm-pol 3
>> ---
>>>   ata3: DUMMY
>> 27,28d26
>> <  ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> <  ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> 29a28
>>>   ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> 31,34d29
>> <  ata3.00: Model 'Samsung SSD 870 QVO 2TB', rev 'SVQ02B6Q', applying
>> quirks: noncqtrim zeroaftertrim noncqonati
>> <  ata3.00: supports DRM functions and may not be fully accessible
>> <  ata3.00: ATA-11: Samsung SSD 870 QVO 2TB, SVQ02B6Q, max UDMA/133
>> <  ata3.00: 3907029168 sectors, multi 1: LBA48 NCQ (not used)
>> 37a33
>>>   ata5.00: configured for UDMA/100
>> 40d35
>> <  ata5.00: configured for UDMA/100
>> 43,46d37
>> <  ata3.00: Features: Trust Dev-Sleep
>> <  ata3.00: supports DRM functions and may not be fully accessible
>> <  ata3.00: configured for UDMA/133
>> <  scsi 2:0:0:0: Direct-Access     ATA      Samsung SSD 870 2B6Q PQ: 0 ANSI:
>> 5
>> 50,51d40
>> <  ata3.00: Enabling discard_zeroes_data
>> <  ata3.00: Enabling discard_zeroes_data
>>
>> I hope this is useful for diagnosing the problem.
> 
> It is indeed!
> 
> Wow.
> 
> The problem does not appear to be with the SSD firmware.
> 
> The problem appears to be that your AHCI controller reports different
> values in the PI (Ports Implemented) register.
> 
> This is supposed to be a read-only register :)
> 
> At cold boot the print is:
> 4/4 ports implemented (port mask 0x3c)
> meaning ports 1,2 are not implemented (DUMMY ports).
> 
> At reboot the print is:
> 3/3 ports implemented (port mask 0x38)
> meaning ports 1,2,3 are not implemented (DUMMY ports).
> 
> So, the problem is that your AHCI controller appears to report different
> values in the PI register.
> 
> Most likely, if the AHCI controller reported the same register values the
> second boot, libata would be able to scan and detect the drive correctly.

I think that the port-mask register is only read-only from an OS pov,
the BIOS/UEFI/firmware can likely set it to e.g. exclude ports which are
not enabled on the motherboard (e.g. an M2 slot which can do both pci-e + 
ata and is used in pci-e mode, so the sata port on that slot should be
ignored).

What we seem to be hitting here is a bug where the UEFI can not detect
the SATA SSD after reboot if it ALPM was used by the OS before reboot and
the UEFI's SATA driver responds to the not detecting by clearing the bit
in the port-mask register.

The UEFI not detecting the disk after reboot when ALPM was in use also
matches with not being able to boot from the disk after reboot.

I think what would be worth a try would be to disable ALPM on reboot
from a driver shutdown hook. IIRC the ALPM level can be changed at runtime
from a sysfs file, so we should be able to do the same at shutdown ?

Its been a while since I last touched the AHCI code, so I hope someone else
can write a proof of concept patch with the shutdown handler disabling ALPM
on reboot ?

Regards,

Hans


