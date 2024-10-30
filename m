Return-Path: <linux-kernel+bounces-389691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BBD9B6FFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94537B20F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA091EF94E;
	Wed, 30 Oct 2024 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi3JlwXA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5067315B0F7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328497; cv=none; b=nxgc2DKV4DjzrVe2BiCBB+X/LSOBmr5OIHRjtL1XNr8dPJ9bjinkvwHvrgjeh8yRnR3+OxBuG9tIEeQWaSHfpHKalaYmYE7lV7pAN3EgHxer3HsBNU7z59FeT4T+UJBWfqPp0CuB/rhAsUWgggArYcJNGyBNm/rkKhY1fajpqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328497; c=relaxed/simple;
	bh=U5kEO1PWuvnE3zD/pwKWo2O2YdMvgKm7x3/096Vz0tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AC0Qwi4Vf6aQHzuw/ikA7UeZJ+tlKGYtM5eylijXSlNF+A7W8fLq8TSS/4aGjdnCTr0ip7vHGSlKAb0qDkfgwjPBwDMKyhid9OCPVIKiauGUD2i/iOBuF3fZzW875OXRAU223/6k7GcezQtxLSyRkL+9SoADeBecOwkyQs7q8+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wi3JlwXA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730328494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSTwWvPDbKEnyoJdhYuAUAC8p/hvR5Suw9BWaRelTHc=;
	b=Wi3JlwXAipoxLa8lTKSyFe6WhJwJIzlYwOz+XfnWVN8aECze42WYAKJRmd8yvrtFBYPoQu
	F8Owew+ygZqKq55fLWBtcll/i+6QKHaKEmvvUCnG9+hvFyTEX9z2j0NdoVL5kgnyufUfcS
	J3FDxOrgPmi6Ua/gbpHlwp6JbWrG4HE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-igbjThpbNUmYFBBYG8keSA-1; Wed, 30 Oct 2024 18:48:12 -0400
X-MC-Unique: igbjThpbNUmYFBBYG8keSA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e2eb765285so321101a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730328491; x=1730933291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSTwWvPDbKEnyoJdhYuAUAC8p/hvR5Suw9BWaRelTHc=;
        b=CaM28hdYaFb1twkhSFZUOgOtCw59NaXYKzwHknsG9aB75m8tV+NkEzWZKYM/C3Qr5M
         S1YPsqdsSZx+gpEZtgo4vxOtAH4dKZybQxeRptSGDfnzGadiXnJO2s+LAxMpN5VvVAT+
         cnalW/pp1O8z2wN+5iZofilMa/AdtOXPlYfiZ2giBUSoMFHQU/mgMDhKE7NSg9kLuBk2
         YyG48I0A8PdKnEJ/8d5IKYC5ix1R4waKLb18PPzafEpKoOgaVTpC1PzjAiSJ4hP99P4M
         h/9K/hjJoWIzLY6BBnZoVdWOxUzffd6atWh1M3/s+pphaIHfgZDt4BPssMh+WX41QhZ7
         Ptsg==
X-Forwarded-Encrypted: i=1; AJvYcCV2Qk1rnOvMj1fVA6aPEUayvNxsrw6lAtMbRFzxY3sCvoUZ5FnjBxSIcsBKO3LDKtihT1gNjE8LbFSLOak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhIltbLQGXXFjbgv+HKG0fjHpjagg+mohX/UFPGY+0Ds0skl5
	syhQYKzg1LaoSHrQgQdH78HJ9Mdzen8BaA6bTnSFkn229A+sKVLP9Tob+ohQa89CA7ZdZBKGOWM
	FbvNQs3zgmrGSfLBxdIJZag8J1z2GtQEfphdlOJc4dz0aEgMhYwGB6b17Is7T/A==
X-Received: by 2002:a17:90a:8d05:b0:2e2:b204:90c8 with SMTP id 98e67ed59e1d1-2e8f11bf7d2mr18512081a91.34.1730328491276;
        Wed, 30 Oct 2024 15:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk33fvhx7J/zOySil7LvSFSpwzEwNmUlqs+yh90jXmneYSsyy4+TZp43m6T36UsLv0fd+DpA==
X-Received: by 2002:a17:90a:8d05:b0:2e2:b204:90c8 with SMTP id 98e67ed59e1d1-2e8f11bf7d2mr18512066a91.34.1730328490930;
        Wed, 30 Oct 2024 15:48:10 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfa8a4sm2434748a91.53.2024.10.30.15.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 15:48:10 -0700 (PDT)
Message-ID: <98b47e47-9014-45d1-86c7-4b78ff36bf54@redhat.com>
Date: Thu, 31 Oct 2024 08:48:05 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: rsi: Add automatic arm-cca-guest module loading
To: Jeremy Linton <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: steven.price@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com,
 will@kernel.org, sami.mujawar@arm.com, linux-kernel@vger.kernel.org
References: <20241029141114.7207-1-jeremy.linton@arm.com>
 <32211eb5-eed5-4c71-b62a-362d32e1af47@redhat.com>
 <b62b9ba4-eaf9-4533-9a97-7d5e2929b1e8@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <b62b9ba4-eaf9-4533-9a97-7d5e2929b1e8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jeremy,

On 10/31/24 1:16 AM, Jeremy Linton wrote:
> On 10/29/24 7:23 PM, Gavin Shan wrote:
>> On 10/30/24 12:11 AM, Jeremy Linton wrote:
>>> The TSM module provides both guest identification as well as
>>> attestation when a guest is run in CCA mode. Lets assure by creating a
>>> dummy platform device that the module is automatically loaded during
>>> boot. Once it is in place it can be used earlier in the boot process
>>> to say decrypt a LUKS rootfs.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   arch/arm64/include/asm/rsi.h                    |  2 ++
>>>   arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>>>   drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  7 +++++++
>>>   3 files changed, 24 insertions(+)
>>>
>>
>> I don't understand how the TSM module is automatically loaded and arm_cca_guest_init()
>> is triggered because of the newly introduced platform device. Could you please provide
>> more details? Apart from it, some nick-picks as below.
> 
> I think your asking how the module boilerplate here works, AKA how the standard uevent/udev/modalias/kmod stuff works? The short version is that the platform bus uevents an add device with a modalias and userspace udev + kmod finds matching modules, and their dependencies, and loads them which triggers the module_init() calls.
> 
> The suse folks have a detailed description of how this works:
> https://doc.opensuse.org/documentation/leap/reference/html/book-reference/cha-udev.html#sec-udev-kernel
> 
> So, this is a fairly common misuse of the platform bus, in this case to avoid needing a HWCAP. Assuring the module exists in the initrd will then result in it being loaded along any other modules required for the rootfs pivot.
> 
> 

Thanks for the explanation and details. The module won't be automatically loaded if
udev daemon isn't in place or the DEV_ADD event is ignored for whatever reasons. For
example the corresponding ACTION for DEV_ADD of this particular device is null in the
udev rules. So it's not guranteed that the module can be automatically loaded until udev
is in place and udev rules have been configured properly. It's a best-effort attempt
if I don't miss anything.

Could you please update the change log to mention the automatic module loading depends
on udev and its rules? In this way, readers will know it's a best-effort attempt at least.

Thanks,
Gavin


