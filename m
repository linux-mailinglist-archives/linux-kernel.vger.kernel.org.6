Return-Path: <linux-kernel+bounces-239615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0874E926318
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F61B2D216
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95AE180A9C;
	Wed,  3 Jul 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNTkKUNW"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EEE142625
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015820; cv=none; b=AYLrd/lJe7lNN3fZyPvmL66Gdqi+X+i2ihMw5o9UDHYj9+/IqpJYZwuxDNIDS5AEt/wq7P1r9hUHzqsp7VJo5OaEaPRkVOqrJTWrAgmpGYwolZyXe1cRRhsxJe2nk7dZrbFk588vth30gdgeEcMrruJThxOs5bs+qs2GIau2D7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015820; c=relaxed/simple;
	bh=hl7Y63B5+y5wRKIA2cDpPsaRmH60dD52yWG5xjOAUjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TsE+55FeAaMO5HhvoauBbf1quTwSVhIJ+ico0CdXc8Le6mZa8XSZf9EAVLVlUSnOjvvS0xnuACaB1IoSo7TBy6iCmCmnPGeq8b2QwBN/B5YKQKATyX9WWPqI5dXIaWSkiEXqHfU8z87dgKljfR4zpT3savZqYebGHwrJh1za3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNTkKUNW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so8313900e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015816; x=1720620616; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3+IZ6MEYqHtLXIKSclKr/Zjo4oBpkHEBuunrbWne6k=;
        b=nNTkKUNW4+EfYSvQhALrOCFOJD9Mnt/FmWHv2LcjhIr2YkZPhbeld4GdQ6rnCwbTTM
         RAsn9igoavOso5XAXHATROxHDyHvU3Hj8NaQOK+bftKcwP+5ybfcGl7fd6KqHwLt2ZjX
         Bo/OKwUUTt0ZwsxwC1lpjFBEpE0m6gmtcQIVEjYeZJPMroZlKvWUmagY0AwTcGO6LSKj
         bS5L2Ozfh5fetfLZnC00OVrxi5PTE8CfAv/wIa1rBMx8ESr+ycTeuVlX75E0F2sJHqss
         Rv/UPqIydSGKKrQWs3CXTAZuQ5tQ9W+PcjBeWmWt2O0hAQnZZQVLHkG4DmaLKYrrVMFt
         ZXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015816; x=1720620616;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3+IZ6MEYqHtLXIKSclKr/Zjo4oBpkHEBuunrbWne6k=;
        b=FqgM8M9LS05OmAFYlJsY3q1MQvhqgH1p2nMN5lhdjHjkdqWHRlUabfdYxP9whLReIa
         ETLtPhEcDc2bLiWVPM9SfILKM9Nyux8o7MRJ8k2WIWMAePtPWx3r8Z63FyACj1FNVpMM
         8R2KhauX88LW+wR7MDZWIKYLnoyGo34XVPjegQP0OKHHih8VO3ChXbI3LmR5en6WBOAK
         KvVF5WyzIsHdrX0ExNbeVz5D8VvGkK/5x/m/SfwEuVwtZJlHNJVrhh8dwvuiplWsbs5P
         vmIzWoON3ZSGTxip2TzDgdCrGk+lEjdgTtx1lraUzuM+6uZrV0QwtGaUAwmQVR9KZtdG
         jjdg==
X-Forwarded-Encrypted: i=1; AJvYcCXUFIjt8+41Pzv5TqXiNIM8xC8MUCklFvHQVOariu929euE0BLsJNluaMTZmYD0n08R17C7E389dHOBBRQe0qSPh0d9yc35/FSryKlZ
X-Gm-Message-State: AOJu0Yz/s0/ytA+XSicxn4W8Dpd9zjxib6mQsYSFIyD2a2XYXj+2m5re
	n9QVNud6xBHrtUQ6Ndp6RSGilGs/D5GertRTugSdCZk9pZKUrOcVS2DkZb+ney0OEFu4/d0Y4JN
	1+LtPOFpT9BmoOkruwkQXXP/rCOtNKQ==
X-Google-Smtp-Source: AGHT+IHXG+BKKUznMb2fVqrHLf1BYwVelTKIdedgzisvJaYnivzuDJ9FhKiHemx2/6jY4VdfJVoYx8oBuP46ayBMH24=
X-Received: by 2002:a05:6512:2213:b0:52c:e084:bb1e with SMTP id
 2adb3069b0e04-52e82644181mr10030434e87.13.1720015815994; Wed, 03 Jul 2024
 07:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLjpMaa1hC-VOzN_aQCuLt=T6PkgC3NBBDp8BBE5xhHTew@mail.gmail.com>
 <CAOuPNLibPQEUxHMdaoSNMh6hs-HSwHKnGzjuWOPr-tEqxi+W7A@mail.gmail.com>
In-Reply-To: <CAOuPNLibPQEUxHMdaoSNMh6hs-HSwHKnGzjuWOPr-tEqxi+W7A@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 3 Jul 2024 19:40:03 +0530
Message-ID: <CAOuPNLhmZ5mT2qY_iD9g5v3taSVuZ6OnReiW1usFhEH8mkw1Kw@mail.gmail.com>
Subject: Re: device-mapper: verity: 251:0: metadata block 18398 is corrupted
To: dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, snitzer@redhat.com, 
	agk@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,
Any comments on the issue below ?

On Sat, 29 Jun 2024 at 00:16, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
> In one of our NAND products (arm64) we are having Kernel 5.15 along
> with squashfs + ubiblock + dm-verity on rootfs along with ramdisk.
>
> Recently we have enabled "NAND Page Cache" in our nand driver to
> improve nand read performance.
> But after enabling this feature, the dm-verity detects metadata
> corruption during boot-up and the device is crashing.
> If we disable dm-verity (from ramdisk) then we don't see this problem
> and the device boots fine.
>
> Are there any dm-verity specific changes (in higher Kernel version)
> that we are missing here ?
>
> This is the failure log.
> What does the below metadata corruption indicate ?
> Does this mean, the root_hash is corrupted ?
>
> {{{
> [    7.731295][  T136] device-mapper: verity: 251:0: metadata block
> 18398 is corrupted
> [    7.742723][  T136] ------------[ cut here ]------------
> [    7.748206][  T136] workqueue: WQ_MEM_RECLAIM kverityd:verity_work
> is flushing !WQ_MEM_RECLAIM k_sm_usb:0x0
> [    7.754840][  T136] WARNING: CPU: 3 PID: 136 at
> kernel/workqueue.c:2660 check_flush_dependency+0x12c/0x134
> [...]
> [    7.809215][  T136] pc : check_flush_dependency+0x12c/0x134
> [    7.814933][  T136] lr : check_flush_dependency+0x12c/0x134
> [...]
> [    7.905120][  T136] Call trace:
> [    7.908345][  T136]  check_flush_dependency+0x12c/0x134
> [    7.913710][  T136]  flush_workqueue+0x1cc/0x4dc
> [    7.918452][  T136]  dwc3_msm_shutdown+0x48/0x58
> [    7.923195][  T136]  platform_shutdown+0x24/0x30
> [    7.927937][  T136]  device_shutdown+0x170/0x220
> [    7.932680][  T136]  kernel_restart+0x40/0xfc
> [    7.937152][  T136]  verity_handle_err+0x11c/0x1b0
> [    7.942071][  T136]  verity_hash_for_block+0x260/0x2d8
> [    7.947343][  T136]  verity_verify_io+0xe8/0x568
> [    7.952085][  T136]  verity_work+0x24/0x74
> [    7.956297][  T136]  process_one_work+0x1a8/0x3a0
> [    7.961133][  T136]  worker_thread+0x22c/0x490
> [    7.965700][  T136]  kthread+0x154/0x218
> [    7.969725][  T136]  ret_from_fork+0x10/0x20
> [    7.974116][  T136] ---[ end trace 166e4069e91d0a01 ]---
> }}}

Note, this issue occurs only some times during boot (1/6 reboots).
We applied all patches from 6.9 Kernel and still the issue exists.
Is it possible that the root_hash got corrupted after the image loaded
into RAM ?

