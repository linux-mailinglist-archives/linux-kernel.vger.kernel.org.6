Return-Path: <linux-kernel+bounces-258673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A170D938B75
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E791C2117E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382BC167296;
	Mon, 22 Jul 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtkGWdje"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39635280
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637804; cv=none; b=WBceARS9vg6GSf049I7ONeuQWWps0QUs1EXBIU8d1hglH22o/9sAEkuVwWj19x+WRHjn/LiqJhAfE2JAobAR2yi/xhCVjfKF4E+jJlqTrtnhZl3BvCqBrp0zTcoUdzdnADfF4VO69dRv46l2WCBVX94ezTVo6oyBANu7E8X6yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637804; c=relaxed/simple;
	bh=QlcfM8FQqlembNaRN3eTe/m30wjIgQyhSNgdU9HSVn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oVorDIfMOhFLTZM4Zsmj/E958bdA2kW7weu3nUl/E/WIVZjYH36cABVd/0FLeN2zWS46be108d82kFi2bZvO+a95M95Z5d/YNkX9GfzYm0eFFxt6PQFqvoocYZWZeZb1vfST851aURn+/r4nzwTZcEPgZvxNfitkW0qL3638tjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtkGWdje; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so33834845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721637800; x=1722242600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g+PBfNzfyUUsqlo6xuJq2KzuHaAI09zpwcW3cyT8Tfo=;
        b=XtkGWdje2sjsiBHLzi5CdoL0dD/t2hPOv4OZHC+t+MwoJ9owlO1Iw/Gr8bCRYbOQ6n
         G4dH+8UkVnSyLfoWm7AFvBhpHq4m1DBF17n+CtU5+8sEMUSndgFIinG2QuDkOf34zsgC
         QvcXOQVBCrwjPz8vkMkvLLNB3/bZbySqgz+5ztd7Ut3/fy+LMzpy21nWvFm/dyg/N6m9
         myaZZckT1a472MTomwjrrt2kPwEhMfnw3RfkAoKvI3zfJZcDDDgehS+ReTNddjnnGpdT
         h/0tGFyzfC1vzXYeOK1R8rm/JeTgq+CfdNLpRppyJhYTUbMPYQpolrgekqpt/iHIfWBM
         tjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637800; x=1722242600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+PBfNzfyUUsqlo6xuJq2KzuHaAI09zpwcW3cyT8Tfo=;
        b=Aou56bCAKqRsR208hQc6r0XSzm/qR98XbhoZFTUrbQlYTd3qYdE/IjFHwiP43Q/iuP
         iaTLhPAoHOPDOyyGGafCyzUQ9ARJeInpTG3GOoTWLgIaHCE5PgpiFRHc6MXdrUKh3Kh6
         +JjIGq31pOVF6wJ/I8w0Dr6IhUWt8Z0f9GRV1EOeAMCKwRuoSi0wizZMPb3Kaxkm/ewT
         1NdEpzOBD5opvJQpsCQ3SoLZqiCwDws10KN2xnbS79kFOPKGS1559vXNJkPmOAK//bAs
         czryRwsytVhoyyFQtLNT5IgJvAgXDJINBZ7IM4Hd1ug+uHYKcUAHUGpi9CgziLrsMv6M
         KuYg==
X-Forwarded-Encrypted: i=1; AJvYcCUgZnU/fiSklFzejcumwjCZ601OtqlhAzIgAge8ktOADThkkDFIVjW91RDfsCBYlxArfY2GKT4i8s8PoxGkEv+ROlUzPb4O46+DLClw
X-Gm-Message-State: AOJu0Yy3s4gkO9Es68BYRNoTeWxha3BsNMM//LJDrQ5MmPqBvhfRDi7p
	+oqnTLLctc+P5ExMBzRvQ0aPchzD6kpshbUpf/vPjnoGlmH6iq6X
X-Google-Smtp-Source: AGHT+IG9TWmyekMunn7arqTs6wK7XiKa21iN8IJ94PIvH6V44kpdRLR4KO7UF6usEPYmOfmXAPPE0Q==
X-Received: by 2002:a05:600c:1d92:b0:426:5e1c:1ac2 with SMTP id 5b1f17b1804b1-427dcf67fe1mr52890585e9.8.1721637800042;
        Mon, 22 Jul 2024 01:43:20 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878695165sm7857306f8f.62.2024.07.22.01.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:43:19 -0700 (PDT)
Message-ID: <1266c4af-a000-48c0-bd0d-79c2e918aea9@gmail.com>
Date: Mon, 22 Jul 2024 10:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/bisected/regression - Since commit e356d321d024 in the
 kernel log appears the message "MES failed to respond to msg=MISC
 (WAIT_REG_MEM)" which were never seen before
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsMmtqzBfUykT-JgyhZn-7ZXtftHL35znDdYuTnUOpGnoQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsMmtqzBfUykT-JgyhZn-7ZXtftHL35znDdYuTnUOpGnoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

That's a known issue and we are already working on it.

Regards,
Christian.

Am 20.07.24 um 19:08 schrieb Mikhail Gavrilov:
> Hi,
> I spotted "MES failed to respond to msg=MISC (WAIT_REG_MEM)" messages
> in my kernel log since 6.10-rc5.
> After this message, usually follow "[drm:amdgpu_mes_reg_write_reg_wait
> [amdgpu]] *ERROR* failed to reg_write_reg_wait".
>
> [ 8972.590502] input: Noble FoKus Mystique (AVRCP) as
> /devices/virtual/input/input21
> [ 9964.748433] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748433] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748434] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9964.748493] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748494] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748493] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748493] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748476] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748478] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748479] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748478] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748477] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748478] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748661] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9964.748770] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9977.224893] Bluetooth: hci0: ACL packet for unknown connection handle 3837
> [ 9980.347061] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.347077] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349857] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349857] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349857] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349859] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349858] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349859] amdgpu 0000:03:00.0: amdgpu: MES failed to respond to
> msg=MISC (WAIT_REG_MEM)
> [ 9980.349870] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349868] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349870] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349890] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349866] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349865] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349865] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349866] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349866] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349867] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349867] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349869] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349871] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349871] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [ 9980.349871] [drm:amdgpu_mes_reg_write_reg_wait [amdgpu]] *ERROR*
> failed to reg_write_reg_wait
> [10037.250083] Bluetooth: hci0: ACL packet for unknown connection handle 3837
> [12054.238867] workqueue: gc_worker [nf_conntrack] hogged CPU for
>> 10000us 1027 times, consider switching to WQ_UNBOUND
> [12851.087896] fossilize_repla (45968) used greatest stack depth:
> 17440 bytes left
>
> Unfortunately, it is not easily reproducible.
> Usually it appears when I play several hours in the game "STAR WARS
> Jedi: Survivor".
> So it is why I bisected it so long.
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [f2661062f16b2de5d7b6a5c42a9a5c96326b8454] Linux 6.10-rc5
> git bisect bad f2661062f16b2de5d7b6a5c42a9a5c96326b8454
> # good: [50736169ecc8387247fe6a00932852ce7b057083] Merge tag
> 'for-6.10-rc4-tag' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect good 50736169ecc8387247fe6a00932852ce7b057083
> # bad: [d4ba3313e84dfcdeb92a13434a2d02aad5e973e1] Merge tag
> 'loongarch-fixes-6.10-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson
> git bisect bad d4ba3313e84dfcdeb92a13434a2d02aad5e973e1
> # good: [264efe488fd82cf3145a3dc625f394c61db99934] Merge tag
> 'ovl-fixes-6.10-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
> git bisect good 264efe488fd82cf3145a3dc625f394c61db99934
> # bad: [35bb670d65fc0f80c62383ab4f2544cec85ac57a] Merge tag
> 'scsi-fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect bad 35bb670d65fc0f80c62383ab4f2544cec85ac57a
> # good: [f0d576f840153392d04b2d52cf3adab8f62e8cb6] drm/amdgpu: fix
> UBSAN warning in kv_dpm.c
> git bisect good f0d576f840153392d04b2d52cf3adab8f62e8cb6
> # bad: [07e06189c5ea7ffe897d12b546c918380d3bffb1] Merge tag
> 'amd-drm-fixes-6.10-2024-06-19' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
> git bisect bad 07e06189c5ea7ffe897d12b546c918380d3bffb1
> # bad: [ed5a4484f074aa2bfb1dad99ff3628ea8da4acdc] drm/amdgpu: init TA
> fw for psp v14
> git bisect bad ed5a4484f074aa2bfb1dad99ff3628ea8da4acdc
> # bad: [e356d321d0240663a09b139fa3658ddbca163e27] drm/amdgpu: cleanup
> MES11 command submission
> git bisect bad e356d321d0240663a09b139fa3658ddbca163e27
> # first bad commit: [e356d321d0240663a09b139fa3658ddbca163e27]
> drm/amdgpu: cleanup MES11 command submission
>
> Author: Christian König <christian.koenig@amd.com>
> Date:   Fri May 31 10:56:00 2024 +0200
>
>      drm/amdgpu: cleanup MES11 command submission
>
>      The approach of having a separate WB slot for each submission doesn't
>      really work well and for example breaks GPU reset.
>
>      Use a status query packet for the fence update instead since those
>      should always succeed we can use the fence of the original packet to
>      signal the state of the operation.
>
>      While at it cleanup the coding style.
>
>      Fixes: eef016ba8986 ("drm/amdgpu/mes11: Use a separate fence per
> transaction")
>      Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
>      Signed-off-by: Christian König <christian.koenig@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> And I can confirm after reverting e356d321d024 I played the whole day,
> and the "MES failed to respond" error message does not appear anymore.
>
> My hardware specs are: https://linux-hardware.org/?probe=78d8c680db
>
> Christian, can you look into it, please?
>


