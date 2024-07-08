Return-Path: <linux-kernel+bounces-244016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1A929DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C80B1C22363
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F7739AEC;
	Mon,  8 Jul 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WmYdTMr+"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A80171D2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426081; cv=none; b=jTV77FBl3kpjr/lHazpdi5DzI8XjBzrb5Es00O5HahW2EpMCpYHBqV9v6fW61d4iIV2AWFXTfkIWX9gQMZP932221v8V8g1h47vhF3uPwXFEY+jBj7zyb4IAROoLeyXJm8wjiFFu2YVs/62MlY1nZsEctjC4CXoqm5nr/xAF2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426081; c=relaxed/simple;
	bh=7ZpSSzX4JsrFYQ/PfeXi0lnnC9LeHad7SaEw03Cd6GQ=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=ihFmfM7wVuUR6S6ijDl8TOA75UQlUrUxYBJHhHfuwWm57/up69S2UY6SRcOuY0gBy07NUxG/OKkTaA7ikHMdV9MgUaPI+NdkK3d4r9vxXPtws9QugJl7klKShNoWWxa2YI2i3NPzCA5glnxGn4hB6VTm2mESOzcCWWy9V69dbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WmYdTMr+; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77b60cafecso400487866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720426078; x=1721030878; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4PcBS6fz2t71TZWJiq2Dufxp+94LnJxMp6PgBmTO3I=;
        b=WmYdTMr+a/s/HWDLpG9kCRpoDZsR/KEQibQxPBLJuIrQ5DlpbL+/jxAFXhC7HuQ0XG
         aF38S42A/faYn8VvqJxlWx7ggm71El9eIY859O/V4ZIXykT1d7bU+/Ohglq9Lm/X92Hq
         YBgv8qoHlzvHYRR+Sm5+y5zpG1Ivq7b4J+M4S6AzUnaGkGxycSvdhdm+7VKR9LvokrxO
         0zg6rJ9RoHNDa1Gjk8rTW2dpWHXdsGrbRgCPhNBpP3joYfFRvmKrMGa4az9NGrM/1uMn
         lIQ32BcNdm8LGC1vzsO47Buu20TeKDYu2vuAFYU5UzzyBDhkVwNodAuP+YR1OrKy1Nhh
         vQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426078; x=1721030878;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4PcBS6fz2t71TZWJiq2Dufxp+94LnJxMp6PgBmTO3I=;
        b=Of4klqYBK8Pb9D47wgFYhpBF5e1iEnNbvKzFCRBhmpedbxQIPJUlT6QSkkPvsUp9Fh
         UWsnmU0MRCRHqklBv53UhaZVi6ZDzNMFKiXhepcrz6D2eI9VI+AAzvlojDD0iFa9uSVJ
         6XcUkKaEEmZ8Y2YwMg/YipAEsRUy/VYiorJb/itOOG7th/XZaLHTUgyqTOMaxc54L9YC
         sIgE6KMWAjzbxLZOpDFukt2VCTiTje3bDImPaWDVPAlFz7XacwOkKKBaroxhodt7zJkp
         aYxG/NqJkqxLKgC7HcATTAqYgguIaSpdSpggk02jyA3IurpPSezrySoJNEflrZv+8jSz
         wDkg==
X-Gm-Message-State: AOJu0YzhAM/vJAiXX/YSgBCDoClFX2aW8WnbGkZaajo7k2iz/6Ox5M3e
	2y5ViwR5okNm5UhdBq3YdhR52iFWG9zC88oWTY73d+kDSJUDBtmzo5tBFw==
X-Google-Smtp-Source: AGHT+IFauAHNpgajDRCsVYRJZ/mXBtz5W7IJq74ix78gKdeBZq65A8BtWN2uqKlMx/bt+Jp1rGXFuA==
X-Received: by 2002:a17:907:608c:b0:a77:bfca:da54 with SMTP id a640c23a62f3a-a77bfcadb9emr814381666b.29.1720426077857;
        Mon, 08 Jul 2024 01:07:57 -0700 (PDT)
Received: from [192.168.200.7] (p57b87956.dip0.t-ipconnect.de. [87.184.121.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77dc48e56asm238155766b.83.2024.07.08.01.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 01:07:57 -0700 (PDT)
Message-ID: <205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com>
Date: Mon, 8 Jul 2024 10:07:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Regression in 6.8 from "ACPI: OSL: Use a threaded interrupt handler
 for SCI"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

any kernels after 6.7 break my trusty old Toughbook CF-51 by rendering 
many PCI devices unusable.

I did first notice that i915 did no longer work and filed
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/11437, there I 
was pointed to commit

commit 7a36b901a6eb0e9945341db71ed3c45c7721cfa9
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Nov 27 20:57:43 2023 +0100

     ACPI: OSL: Use a threaded interrupt handler for SCI

which I verified with a week-long bisecting from 6.7 to 6.8 (just for 
fun :-)

Just reverting this commit top of 6.10-rc5 (sorry, this machine is not 
very powerful so I did not try the latest git master) makes everything 
work fine again.

I get these messages in dmesg when running the broken kernels:

[  T308] genirq: Flags mismatch irq 9. 00000080 (yenta) vs. 00002080 (acpi)
[  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs. 
00002080 (acpi)
[  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs. 
00002080 (acpi)
[   T46] genirq: Flags mismatch irq 9. 00000080 (ehci_hcd:usb1) vs. 
00002080 (acpi)
[  T312] genirq: Flags mismatch irq 9. 00000080 (firewire_ohci) vs. 
00002080 (acpi)
[  T305] genirq: Flags mismatch irq 9. 00000080 (uhci_hcd:usb1) vs. 
00002080 (acpi)
[  T308] genirq: Flags mismatch irq 9. 00000080 (yenta) vs. 00002080 (acpi)
[  T592] genirq: Flags mismatch irq 9. 00000080 (snd_intel8x0) vs. 
00002080 (acpi)
[  T581] genirq: Flags mismatch irq 9. 00000080 (i915) vs. 00002080 (acpi)
[  T874] genirq: Flags mismatch irq 9. 00000080 (enp2s1) vs. 00002080 (acpi)

These are not present with that commit reverted.

The machine has an old Pentium M (Dothan):
toughbook:~ # cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 13
model name	: Intel(R) Pentium(R) M processor 1.60GHz
stepping	: 6
microcode	: 0x18
cpu MHz		: 1600.000
cache size	: 2048 KB
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov clflush 
dts acpi mmx fxsr sse sse2 ss tm pbe bts cpuid est tm2
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds 
swapgs itlb_multihit mmio_unknown
bogomips	: 3193.05
clflush size	: 32
cache_alignment	: 32
address sizes	: 36 bits physical, 32 bits virtual
power management:

and is running an i686 pae kernel:

toughbook:~ # uname -a
Linux toughbook 6.10.0-rc5-pae-seife+ #17 PREEMPT_DYNAMIC Sat Jul  6 
07:36:41 CEST 2024 i686 i686 i386 GNU/Linux

I can provide more information on request

Best regards
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman

