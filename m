Return-Path: <linux-kernel+bounces-530505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB75A4345D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6C73B4F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A870254867;
	Tue, 25 Feb 2025 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfFMj6XQ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3AF38DE0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458885; cv=none; b=dfdj/YhZuYjWi3T7WhHfx5LuTgdMHAK0jxFbnn7LI5gBVsiSISpKHZb1vk24MRO7mgedTwH191QeNUC5E5kNUQ4dlkKs7+9bVLl6uCCvdqt+RQ3F6/CVCKxj4Dp51Pwj2kcCzqslZ3wCDyeGaKYKODc/SpjdlHFKI1MYWAeyFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458885; c=relaxed/simple;
	bh=RZSsLCa6zJUfcKLMtIK0Yu0CDVXsB8DA45M0c+ufubA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiS1EZcfNlCg0ueCKpCgMHp/HiJKv+vnNYE/LEqVkkeVm5sN1rlz6OrOlabCtoQCxhZKh2GRvxX/WCHfMVDrgHhK34y9xtPDv3fZg78Vj+7KWgKDCyNTX8p7RM+2fwY5iLeVt5hKHRA0tI8olYS74j5bJUoejd1Wv7kxlUMg9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfFMj6XQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2230c74c8b6so5693235ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740458883; x=1741063683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZFgfWVq3JrlH4OafkiYcHz4ovfUUtYZmFSfUfUeiJI=;
        b=VfFMj6XQXfWyKkfbtCI5CxNOwgdTMiDQLnG2fNETAgL30vm/n1Ow65t8PRgQa01HqO
         stisFU38J1wlvqt07jCO/xH07ZOmJUKiZXisNGXgHRkHe8iWm82q3gKbxodOy2uz7ndy
         IDRm6TeXe+HhzDHym4QtdgzfaNgPx+qLZLFp5naFZ+xkpjpXrCGq3xGyq4x1iBJLNatg
         PcppRznsympuuL9nYLPxO6lznPAoYukyFhKZ9MdC6r0QCyVgMn4WhHPW9/ZN4agxt6/e
         zGyGw/pHRHdT0EdQKGxUi+6aoiU5sPKHAVa2639k0H6EdNTmPdDJNqRrQ24krzePhhB0
         j4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740458883; x=1741063683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZFgfWVq3JrlH4OafkiYcHz4ovfUUtYZmFSfUfUeiJI=;
        b=o0e9usmbO7BQi7eYqkF6OFUEjMRk+6mhb4T7miurfcvyJEbMRg1kV+KtuKPw8ecJAX
         sZxNXsIXOOTXq3GvWyxeGvITubSX7RLrY8sBwGNEvQY2D4JceAcxYMjAvaPVpz4QjQ/2
         aDnInRizedli/9eJJSNaWqqJNi/3YZO8sniwr27lDtReO91xLXFaR1ewROUmoGMArDXr
         pI+ru4hhfkvGUbekYaVenctIaW65uGqfmrXZagodIccryzM6vOLx5xsJ4RNAtAgNFlwk
         kDgUWftpkCrhN3D/HSd/4RTZLB7rINZuRi+mPouAdH6Arn9yI+oBbDaHm7oPe1Rw+MtD
         LV3w==
X-Forwarded-Encrypted: i=1; AJvYcCVFq/WYKIDNR3oorfp4RvZZt81mfpf4+01ZPr4W8scggvVcLi4ENrKIh3uVTXvbN+MTGdkCMg6iunluxBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjthdiEAxcMVdBUh2caRJ2wCHQQKe6etjd3AcF7By1DW1rXLfX
	EB9BIJkSCOhy1CnjZnim2F2dcsTmhd/chEz6rUca0DxNGxuu1O4clcsv6+JUEsADO1ufBWtaRZQ
	1aU5I5gm9f/7NlaU7htuWoprZdHM=
X-Gm-Gg: ASbGncv0P05+dWr4/n6uQ5jH2lJGVvLbk9xi25BlaUJqhNBrajrN1mPnVWqSDRPBftn
	ohJP4qVQywUrBAfmDNwbR7YZvHE5MaIn7NSx5WOWDmOxcMC5o7MtG7fhTsXRU6mHmZkNgi/upQ/
	6bYHHRngk=
X-Google-Smtp-Source: AGHT+IGtKRsvMjcl3Jhu2UIJCTw0zZchMAxmZVjqkNQRuFwmh5kGabwMC7qluebfFQT4Cl0trp5EgzVHOC8K2rw5HSQ=
X-Received: by 2002:a17:902:e742:b0:21f:dc3:8901 with SMTP id
 d9443c01a7336-22307e65ab2mr31758665ad.34.1740458882716; Mon, 24 Feb 2025
 20:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224062111.66528-1-kpark3469@gmail.com>
In-Reply-To: <20250224062111.66528-1-kpark3469@gmail.com>
From: Keun-O Park <kpark3469@gmail.com>
Date: Tue, 25 Feb 2025 08:47:51 +0400
X-Gm-Features: AWEUYZkEj-Hgod8sidfdA4vrlUHr9QszMINTXEX7_AJcKmskwZM8_U-h9Ec0W5k
Message-ID: <CA+KhAHYujgeC2kAd-vs0N0zwprpeqtD8G-8DpJ0w2RSxzZ5SQw@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: consider parange is bigger than linear_region_size
To: ardb@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, 
	Keuno Park <keun-o.park@katim.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:21=E2=80=AFAM Keun-O Park <kpark3469@gmail.com> =
wrote:
>
> From: Keuno Park <keun-o.park@katim.com>
>
> On systems using 4KB pages and having 39 VA_BITS, linear_region_size
> gets 256GiB space. It was observed that some SoCs such as Qualcomm
> QCM8550 returns 40bits of PA range from MMFR0_EL1. This leads range
> value to have minus as the variable range is s64, so that all the
> calculations for randomizing linear address space are skpped.
> As a result of this, the kernel's linear region is not randomized.
> For this case, this patch sets the range by calculating memblock
> DRAM range to randomize the linear region of kernel.
>
> Change-Id: Ib29e45f44928937881d514fb87b4cac828b5a3f5
> Fixes: 97d6786e0669 ("arm64: mm: account for hotplug memory when randomiz=
ing the linear region")
> Signed-off-by: Keuno Park <keun-o.park@katim.com>
> ---
>  arch/arm64/mm/init.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9c0b8d9558fc..2ee657e2d60f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -290,6 +290,11 @@ void __init arm64_memblock_init(void)
>                 s64 range =3D linear_region_size -
>                             BIT(id_aa64mmfr0_parange_to_phys_shift(parang=
e));
>
> +               if (range < 0) {
> +                       range =3D linear_region_size -
> +                               (memblock_end_of_DRAM() - memblock_start_=
of_DRAM());
> +               }
> +
>                 /*
>                  * If the size of the linear region exceeds, by a suffici=
ent
>                  * margin, the size of the region that the physical memor=
y can
> --
> 2.34.1
>

36bit: linear_region_size=3D0x800000000 32 GB
39bit: linear_region_size=3D0x4000000000 256 GB
42bit: linear_region_size=3D0x20000000000 2048 GB, 2 TB
47bit: linear_region_size=3D0x400000000000 65536 GB, 64 TB
48bit: linear_region_size=3D0x800000000000 131072 GB, 128 TB
52bit: linear_region_size=3D0xf800000000000 4063232 GB, 3968 TB

The problem happens only when linear_region_size is smaller than
BIT(id_aa64mmfr0_parange_to_phys_shift(parange)).
In my case, SoC returns 2 as parange value. (va_bits is 39bit, so the
linear_region_size gets 0x4000000000, 256GB.)
#define ID_AA64MMFR0_PARANGE_40         0x2
BIT(id_aa64mmfr0_parange_to_phys_shift(parange)) =3D=3D 0x10000000000, 1TB

                s64 range =3D linear_region_size -
                            BIT(id_aa64mmfr0_parange_to_phys_shift(parange)=
);
As a result, range gets a negative value. 0xffffff4000000000 in here.
So this makes randomization code bypass as range is smaller than
ARM64_MEMSTART_ALIGN.

                if (memstart_offset_seed > 0 && range >=3D
(s64)ARM64_MEMSTART_ALIGN) {

In most cases, the hotplug memory code will be working the same as before.

