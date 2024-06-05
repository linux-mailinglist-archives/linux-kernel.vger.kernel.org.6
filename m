Return-Path: <linux-kernel+bounces-201870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF78FC467
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C1F289D19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64AC1922CF;
	Wed,  5 Jun 2024 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W++ILAZU"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818291922C3;
	Wed,  5 Jun 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572120; cv=none; b=m/nXZ2wZ1QevfeOaBH7mu9mLI2zrO3T4diqmzMyCbpWlNsPqCUKiL8Jd22NrZyyLxAhe6kPt4lKsZni4VOgqynUAGtjAEkUftXjG6DQq4boyoWzAk+xQzfyrHn0zGHsH81qEC8YMBM95qi2YdBp+SFpF5h3cjw9M0MN+r0nGpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572120; c=relaxed/simple;
	bh=Ut2Oosn9WqZjf3PYE8F8z4qKVMvNcq2/CyZELFxomFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfXMJOZZWtlYjIGzwKiUg2J7un+9UlOX4GnXpiVN6cNWdS7xaTKoHEqlLxmsHhD5r85/2UCcZIaoybsWEWjTnxnxOF3QpbwpD4SPLY5NDroontxwfl4BRZJLdRznEwgQjBJkEFfPBcZCSm2at33F5ML+D+zJKevit5MaaHowX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W++ILAZU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68f1017170so198169166b.0;
        Wed, 05 Jun 2024 00:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717572117; x=1718176917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftNw0AS7CQGnX8gfpBjn/H2fKad925eIDIHZ9Kmvfzg=;
        b=W++ILAZUrdSrc4ar/a14RDeEIleZMrxvAwbX0t4LwMrxvp+tD8v2aMkYsPGxfCJUw8
         fZelpnKb0ItaD8QScGYS5EJnEs2DIf/t0XaaMt9OI3kj67ig1kftG3K3jJwnY/Dm9miY
         w6+eNsnsC4g3ll91jDikNDW+ZIWoIn0dHmnetl6aucAf2CKokYvnZC+xH+i7adyM/dn3
         fcofYasqYLHcUf9WrQzKdssG045j+2DWQdziiakESiXdZ+YF/NgIflPhpuQ2DIJcMWqk
         gYaWEzIK2mySKMFU66CAIXgNKk0YQSnA9qyKEtjmDAAGkWuV5gFBkR8WViuGPUkX4+mW
         UXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717572117; x=1718176917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftNw0AS7CQGnX8gfpBjn/H2fKad925eIDIHZ9Kmvfzg=;
        b=CJRKnKpexbEXKXJGUikSHGhgH6RRv22CslssR7gSXle3C94yxRg7gwttxa+6epcqG5
         A3AssCbBdNz5bpJtRbAtS63WKKzddbJLA4HnDHDP/uRipeubfegQoek5Ridy3g6w4C+S
         Pg6WlIKM+J8lubH5FO8Z9lHoQ7loKs94T/tBdhPwlKDEmUExTZ9Aye4fHVHkRlSJ/Fif
         NFvW9CzpnL7tlQ2ObnGBgcMjys2N8+7JIy3Y27h1+fxeMjVBJUBGRnIjVDnfF7g4/PeW
         xl/iflyfX+LZ5GvCJuw5D5nLctlP5FMsIQ8TyuY1XcaVXwfeeNSrTrdpP+A3e1bF2hfC
         P5BA==
X-Forwarded-Encrypted: i=1; AJvYcCWInjQCOCX+pmGt4PX6JDPoTGg4Y7o9ZtawSVWQdpnazsdm+mdpiIWswlBPVQ0RiCKTNFDzhxRb8l+P7fk1m7HJwMeOZ59ox7i42pZCYbz5iVgPmcgU4LOdALt0dKX34GrSJwTxVtYubw==
X-Gm-Message-State: AOJu0YzFxxG9PSk7Ajp7ySVgvsxlsklkqVNhP7PYoqEbTetkEGu4LNMs
	NA5Gq2vPTyWWPOta7bN4eeER/vnE5pKmAoIvDF95GdpE0U1MtS0H
X-Google-Smtp-Source: AGHT+IFSBrrd5bENDym21X2++Kx6HrKqft+MBzzKTQDyMCT6563HGywGcXH7uIIz05mlCG9p0X/iuQ==
X-Received: by 2002:a17:906:2557:b0:a62:49ba:8242 with SMTP id a640c23a62f3a-a69a001762emr92692466b.77.1717572116618;
        Wed, 05 Jun 2024 00:21:56 -0700 (PDT)
Received: from [192.168.50.244] (83.8.128.191.ipv4.supernova.orange.pl. [83.8.128.191])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f02d501csm486320166b.160.2024.06.05.00.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:21:56 -0700 (PDT)
Message-ID: <ed3c4512-ff07-4d90-94af-823104852624@gmail.com>
Date: Wed, 5 Jun 2024 09:21:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: dts: bcm-mobile: Split out nodes used by both
 BCM21664 and BCM23550
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>,
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20240605-bcm21664-common-v1-0-6386e9141eb6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5.06.2024 08:40, Artur Weber wrote:
> The BCM21664 and BCM23550 are nearly identical to each other in terms
> of register layout. This was verified against a downstream kernel[1] -

Let me rephrase this a bit, since upon reading it again it kind of
sounds like this means "subdevices are in the same place". I mean that
literally many of the components are the exact same, 1:1, and the same
drivers with the same configuration will work for both of them. (And
if they turn out to not work, it's as easy as switching the
compatibles/tweaking the SoC-specific DTS.)

If you check the RDB files I linked, they contain the exact layout of
not just the system in general, but each of the individual components
(see for example [1]). These RDB files are called back to multiple times
through the kernel (for example [2]).

Clocks are a notable example of this; if you were to diff the clock
drivers in the kernel I linked in the replied-to message:

   diff arch/arm/mach-{hawaii,java}/clock.c

The only differences are some clocks in the KPROC CCU, and the addition
of a MM2 CCU on the BCM23550. (Note that neither of these two CCUs are
supported in mainline at the moment; I have some WIP series to start
adding the KPROC CCU, but it's still an early work-in-progress.)

Most other drivers (sdio, serial, i2c, and so on) have no differences,
as far as I can tell. And they already use the same drivers in mainline.

Best regards
Artur

[1] https://github.com/knuxdroid/android_kernel_samsung_baffinlite/blob/cm-12.1/arch/arm/mach-hawaii/include/mach/rdb/brcm_rdb_kpm_clk_mgr_reg.h
[2] https://github.com/knuxdroid/android_kernel_samsung_baffinlite/blob/cm-12.1/arch/arm/mach-hawaii/clock.c#L4009-L4055

