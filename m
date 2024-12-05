Return-Path: <linux-kernel+bounces-433911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133859E5EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6463F16B2C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0A22B8C2;
	Thu,  5 Dec 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jrs4d8nZ"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D1224B0F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426267; cv=none; b=KcG54oduU5ybBCsfcUeTJ/PNe11zu/7WkTnI6lYz3NPSK2mxRkAbnAoh7q6nFUsyu3WcSSRoZFqnmoc1EEgZsobB73Sbc3bn2yJNruSyudHtr5tABdIgW09VZBMC0YXGzkbYJhtW+vJWBsb5aoL44iRoNqDX/A4LkD7iBJ7VV3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426267; c=relaxed/simple;
	bh=TX/JlZfrL/TYWkfUP5eInfSv5rdZ8wdFX+5Y+RC/eck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgZyjrGqQgNAmg7nNX2ptNX0x2zohBHaSrNtDdg8m9rI8dKkB8uKePdMPy7e9LIjbrQfNG5T4t2/mDfrnJm3yd04xBF3QoD1HqMCseRFLa9p4Eb1lgOnlJUvievMpEh4wP/xljw/bWdcRQEm54sWuTGRX8Qh5RBCeJagYM1S/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jrs4d8nZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b65f2daae6so136418985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733426265; x=1734031065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNyLQM7B0k4Lbd3l2gK9H1AXJZOAbp8aqpkmqcy9IVc=;
        b=Jrs4d8nZaXzSEJA/G+twQcjsClabaOGGUQl9jA/edh6nfII83RhcHyVs+Ce1g54RZI
         i/KkjCSIviF66jcrgIfYleq7lkm/gpu6bHIAyAHB4U7dFPwfc8RornNJpWOZBw9Cq54J
         GP4ih75Z03+Sb7WusnzRtgJAXz9pLMvIrSl7cAVR4pjB3y6JEMANI+Rk3CGrQvGQ/GM7
         8k3pex3rZy6L+Yd6oTo4vv0zT2+3Lqq6EegLUGNCMx0i9VvQOqKGBOwe0OZ2glTlWr/D
         JcPsQGwp5oPJdtUfrI69gZnUfJEtoE+VxKl+D5Yb7f3DzGtqjzxGkwTHu2FtsutN/w9v
         UERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426265; x=1734031065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNyLQM7B0k4Lbd3l2gK9H1AXJZOAbp8aqpkmqcy9IVc=;
        b=cF/YSHo36hGUs+gskPojAQ9ipLsYNg5ZZjHDdDo1s5efcbcRUJuzJTcQDKgx4V4w3o
         ox0kMAI9lSOG5R9z3xLEM7FVyST4m6oX8r4XFGu8SYHK7JS+GZz/Kpt3+e+gxwL0ZXj6
         XZWwy8B3/uZ1+CZqg3ng4V9FQR0+e4LOQPZ+WhwH5Ewvh1NA0FSNfr5ZVm+DmzzYJNy7
         tGIKgDHRZwW+J3nrvBxnu2boHNIevhAbAHdA8hqfek8tEdpFAA7ofzpNnaHVBEuyRyJr
         qlvsKD443ucA5DCWbduuxCeG/yqhY5oxBr8+MTLbV+fbbiAF15nMd4QGCyxilHLHNa9G
         d/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMZIacPs4bo7TeHvqva5zkF36dQRvftbieBeOeou6OjQZirr9Mb8gU+7Tfzk9tXdfmyCl2nW4E6WUcYP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09lqFKNDMkyhGhtR47TlzSDakatAnADLGAHpYY7uMay47OZN0
	iAioDxQvR5PcWIBMZf8m+sCf+9uEEeUNIuCEeRuiRrl1FSKuZd3rCtKhBdYEPT73LdjHCT/buY2
	S7uYVLOOBl/0qOfsBULGf8TA7CjhVCfFfWJJ5
X-Gm-Gg: ASbGncuDPTU1lLpyqORfXeF/kEu74JJjPJnTgB7aBzyNWEEGi/ns7Buwij4DkXUUWpA
	BJ2pEpo774vRZcdzS/VwyQDPJ0r8K+EA7larbcq/W5L7tfaPrdft9XuCfcL6q4cmz
X-Google-Smtp-Source: AGHT+IF+jwtAYc2yVIPio7jJpqWyTV0s+Bv7ZNzarZYGemc0r8fGbxEyFL101b9eiltkWg0xuHMs4R/zhhHH3XcwEoE=
X-Received: by 2002:a05:620a:4889:b0:7b6:6a42:f0ea with SMTP id
 af79cd13be357-7b6bcaddc2bmr72630685a.19.1733426264897; Thu, 05 Dec 2024
 11:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815025226.8973-1-liuye@kylinos.cn> <20240823020443.7379-1-liuye@kylinos.cn>
 <d199d796-3c9b-cba5-e0c7-ce2b798362b1@kylinos.cn> <cc60dff6-7561-ed60-532a-8862bc4a9914@kylinos.cn>
In-Reply-To: <cc60dff6-7561-ed60-532a-8862bc4a9914@kylinos.cn>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 5 Dec 2024 12:17:07 -0700
Message-ID: <CAOUHufZ3AWY0xTowme_sDN+gbvMhi=KWQKah=Q9NprHvMtBHYA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: Fix hard LOCKUP in function isolate_lru_folios
To: liuye <liuye@kylinos.cn>, Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:19=E2=80=AFAM liuye <liuye@kylinos.cn> wrote:
>
>
> Friendly ping.
>
> Thanks.

Hugh has responded on your "v2 RESEND":

https://lore.kernel.org/linux-mm/dae8ea77-2bc1-8ee9-b94b-207e2c8e1b8d@googl=
e.com/

> On 2024/9/6 =E4=B8=8A=E5=8D=889:16, liuye wrote:
> >
> >
> > On 2024/8/23 =E4=B8=8A=E5=8D=8810:04, liuye wrote:
> >> I'm sorry to bother you about that, but it looks like the following em=
ail send 7 days ago,
> >> did not receive a response from you. Do you mind having a look at this
> >> when you have a bit of free time please?
> >>
> >>>>> Fixes: b2e18757f2c9 ("mm, vmscan: begin reclaiming pages on a per-n=
ode basis")
> >>>>
> >>>> Merged in 2016.
> >>>>
> >>>> Under what circumstances does it occur?
> >>>
> >>> User processe are requesting a large amount of memory and keep page a=
ctive.
> >>> Then a module continuously requests memory from ZONE_DMA32 area.
> >>> Memory reclaim will be triggered due to ZONE_DMA32 watermark alarm re=
ached.
> >>> However pages in the LRU(active_anon) list are mostly from
> >>> the ZONE_NORMAL area.
> >>>
> >>>> Can you please describe how to reproduce this?
> >>>
> >>> Terminal 1: Construct to continuously increase pages active(anon).
> >>> mkdir /tmp/memory
> >>> mount -t tmpfs -o size=3D1024000M tmpfs /tmp/memory
> >>> dd if=3D/dev/zero of=3D/tmp/memory/block bs=3D4M
> >>> tail /tmp/memory/block
> >>>
> >>> Terminal 2:
> >>> vmstat -a 1
> >>> active will increase.
> >>> procs -----------memory---------- ---swap-- -----io---- -system-- ---=
----cpu-------
> >>>  r  b   swpd   free  inact active   si   so    bi    bo   in   cs us =
sy id wa st gu
> >>>  1  0      0 1445623076 45898836 83646008    0    0     0     0 1807 =
1682  0  0 100  0  0  0
> >>>  1  0      0 1445623076 43450228 86094616    0    0     0     0 1677 =
1468  0  0 100  0  0  0
> >>>  1  0      0 1445623076 41003480 88541364    0    0     0     0 1985 =
2022  0  0 100  0  0  0
> >>>  1  0      0 1445623076 38557088 90987756    0    0     0     4 1731 =
1544  0  0 100  0  0  0
> >>>  1  0      0 1445623076 36109688 93435156    0    0     0     0 1755 =
1501  0  0 100  0  0  0
> >>>  1  0      0 1445619552 33663256 95881632    0    0     0     0 2015 =
1678  0  0 100  0  0  0
> >>>  1  0      0 1445619804 31217140 98327792    0    0     0     0 2058 =
2212  0  0 100  0  0  0
> >>>  1  0      0 1445619804 28769988 100774944    0    0     0     0 1729=
 1585  0  0 100  0  0  0
> >>>  1  0      0 1445619804 26322348 103222584    0    0     0     0 1774=
 1575  0  0 100  0  0  0
> >>>  1  0      0 1445619804 23875592 105669340    0    0     0     4 1738=
 1604  0  0 100  0  0  0
> >>>
> >>> cat /proc/meminfo | head
> >>> Active(anon) increase.
> >>> MemTotal:       1579941036 kB
> >>> MemFree:        1445618500 kB
> >>> MemAvailable:   1453013224 kB
> >>> Buffers:            6516 kB
> >>> Cached:         128653956 kB
> >>> SwapCached:            0 kB
> >>> Active:         118110812 kB
> >>> Inactive:       11436620 kB
> >>> Active(anon):   115345744 kB
> >>> Inactive(anon):   945292 kB
> >>>
> >>> When the Active(anon) is 115345744 kB, insmod module triggers the ZON=
E_DMA32 watermark.
> >>>
> >>> perf show nr_scanned=3D28835844.
> >>> 28835844 * 4k =3D 115343376KB approximately equal to 115345744 kB.
> >>>
> >>> perf record -e vmscan:mm_vmscan_lru_isolate -aR
> >>> perf script
> >>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D2 nr_skipped=3D2 nr_taken=3D0 lru=3Dactive_anon
> >>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D0 nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
> >>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D28835844 nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
> >>> isolate_mode=3D0 classzone=3D1 order=3D1 nr_requested=3D32 nr_scanned=
=3D28835844 nr_skipped=3D28835844 nr_taken=3D0 lru=3Dactive_anon
> >>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D29 nr_skipped=3D29 nr_taken=3D0 lru=3Dactive_anon
> >>> isolate_mode=3D0 classzone=3D1 order=3D0 nr_requested=3D32 nr_scanned=
=3D0 nr_skipped=3D0 nr_taken=3D0 lru=3Dactive_anon
> >>>
> >>> If increase Active(anon) to 1000G then insmod module triggers the ZON=
E_DMA32 watermark. hard lockup will occur.
> >>>
> >>> In my device nr_scanned =3D 0000000003e3e937 when hard lockup. Conver=
t to memory size 0x0000000003e3e937 * 4KB =3D 261072092 KB.
> >>>
> >>> #5 [ffffc90006fb7c28] isolate_lru_folios at ffffffffa597df53
> >>>     ffffc90006fb7c30: 0000000000000020 0000000000000000
> >>>     ffffc90006fb7c40: ffffc90006fb7d40 ffff88812cbd3000
> >>>     ffffc90006fb7c50: ffffc90006fb7d30 0000000106fb7de8
> >>>     ffffc90006fb7c60: ffffea04a2197008 ffffea0006ed4a48
> >>>     ffffc90006fb7c70: 0000000000000000 0000000000000000
> >>>     ffffc90006fb7c80: 0000000000000000 0000000000000000
> >>>     ffffc90006fb7c90: 0000000000000000 0000000000000000
> >>>     ffffc90006fb7ca0: 0000000000000000 0000000003e3e937
> >>>     ffffc90006fb7cb0: 0000000000000000 0000000000000000
> >>>     ffffc90006fb7cc0: 8d7c0b56b7874b00 ffff88812cbd3000
> >>>
> >>>> Why do you think it took eight years to be discovered?
> >>>
> >>> The problem requires the following conditions to occur:
> >>> 1. The device memory should be large enough.
> >>> 2. Pages in the LRU(active_anon) list are mostly from the ZONE_NORMAL=
 area.
> >>> 3. The memory in ZONE_DMA32 needs to reach the watermark.
> >>>
> >>> If the memory is not large enough, or if the usage design of ZONE_DMA=
32 area memory is reasonable, this problem is difficult to detect.
> >>>
> >>> notes:
> >>> The problem is most likely to occur in ZONE_DMA32 and ZONE_NORMAL, bu=
t other suitable scenarios may also trigger the problem.
> >>>
> >>>> It looks like that will fix, but perhaps something more fundamental
> >>>> needs to be done - we're doing a tremendous amount of pretty pointle=
ss
> >>>> work here.  Answers to my above questions will help us resolve this.
> >>>>
> >>>> Thanks.
> >>>
> >>> Please refer to the above explanation for details.
> >>>
> >>> Thanks.
> >>
> >> Thanks.
> >>
> > Friendly ping.
> >
>

