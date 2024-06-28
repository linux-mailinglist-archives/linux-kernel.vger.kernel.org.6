Return-Path: <linux-kernel+bounces-234389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB591C608
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CFC1C23B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA657CBE;
	Fri, 28 Jun 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6POVY5I"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18FE57CA2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600393; cv=none; b=exkEx1ku/S8mpfZqc9FwetqbL/BCu+mTndbF+5zHmJud4sSF9hKeR0uIGsdR2AN0srq/o4wciNjTwpv/3ACL0amQo937OLTNTHbn0VXFJQvRcX+7f63B7d62dDQSuQSoMvzhNJ2WUbVsQOltv+M9jbpZLKfQr8spBZc8H7icgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600393; c=relaxed/simple;
	bh=CjeOPx08KHZCMpZar8Zw4g3simp6ijuR/rUR6FpMdU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YI7a5mLzDwm8PsQtMl5iasXMhH8bIP6jdmnRRpDvZ9N3VIqSgxqC63qhT2W4ARJgsgWEfH0Sg5XW65VxufUVt8vRO/F2A4MMB3EOu8TeccFelLeF3mZUin+FYcfcugGYvUx2TL3Geq6PpzeDeKZHRvP/Lp9Fdjck8SmBK+FZO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6POVY5I; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a72459d8d6aso98337866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719600389; x=1720205189; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyDuHHLcDpZV6xvkvgsuMWxJVbSxBe6+9nLQ49p2W/Y=;
        b=A6POVY5ISr4XBRT3Jn8HqQJ4VHObvtWNGMYVH60+bJJD+W2Blwjg8ccAunrj+/iJSi
         fInTjTtndgBQswGwd0UhDTZ90YYcy9XoruHmj4f0YPtFa7LUFVZUsCCaF2H8AQ+IDUpW
         ZkhXe2rf9EzZBQZ39vfKb6M3EskHOnO3L43aWXKY9LFHpYrqqfzJEDqWJZktkeQpjH4c
         FqpjMSUiYIpzq/W0WPPyXRd3OiJ2N5oNwYxrlw9VLH4TV4lZi7ov7Oy65EBkN6sljGoY
         5wsSlLuMlscuOcfiaL63XEkokBaHS5BdDfiOg+2X+te3AGnskCgpwkYUjtNsVEw6qXvo
         sBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719600389; x=1720205189;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyDuHHLcDpZV6xvkvgsuMWxJVbSxBe6+9nLQ49p2W/Y=;
        b=HHskioPaLViB5bvskjf7JqFFDI/OXkwFw5eoRy4oFiXXqbUe64ABbvh6apK77fKflI
         qS7G/MNTZI/X5z/LlC2CzGGLqfUXB6c59bLwDlLXTCOlQzLRqjxWV0KnFMbT5WgudjiC
         gY3kbKO4wP1Mje0G99dRZTxL5ZW9joZvQdlbHUGZ2S0QhsNTjC4JBokOCzpoQTD4Uoma
         oemhFXLs89wBPrY5o1nsEt21quoUfqghevYHFrUzB32MXsyKCfUdN3JROSRRLPJFLVTh
         r5Yank35tem/TjTRkMCQTZ9YRErAYOq9I5jjll/c5YXhFMN1ymzHwMKbKM6s6NsL+pGO
         Kn3w==
X-Forwarded-Encrypted: i=1; AJvYcCXXjV2TO5dTej30DBUsK8Av3nFXDvdUrT457OKaXgU2CMffDSeciWATl8rorvQGopjCteEDBtemUf7A9OY3NqsMUzVcjJmiIKONCyTI
X-Gm-Message-State: AOJu0Yyip5BpdHIPKaiARkkKsSFwtA0mU1sgIg5abMxd0TiayAB9nSID
	hL8dN+g0WkjJKOSXrWDG01u/+YHgIaqCFwV7M/A8SERMI/r4p9YGGWmRKFEqNBf4V2jfobpn9Xy
	j/Y0sEY8XeaHjaoS5zQrjTptOXBwyMg==
X-Google-Smtp-Source: AGHT+IH9gYldvzlsy9M4qmvNn8yEPs6T9Ky4rIQWBnAgittL8rkeYbvlbjg4x0hAoedA+dLGC5fmlKL2l35Uv7hOjNw=
X-Received: by 2002:a17:907:7782:b0:a6f:af4f:ff82 with SMTP id
 a640c23a62f3a-a7245b56c49mr1195733366b.25.1719600388863; Fri, 28 Jun 2024
 11:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLjpMaa1hC-VOzN_aQCuLt=T6PkgC3NBBDp8BBE5xhHTew@mail.gmail.com>
In-Reply-To: <CAOuPNLjpMaa1hC-VOzN_aQCuLt=T6PkgC3NBBDp8BBE5xhHTew@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Sat, 29 Jun 2024 00:16:16 +0530
Message-ID: <CAOuPNLibPQEUxHMdaoSNMh6hs-HSwHKnGzjuWOPr-tEqxi+W7A@mail.gmail.com>
Subject: device-mapper: verity: 251:0: metadata block 18398 is corrupted
To: dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, snitzer@redhat.com, 
	agk@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,
In one of our NAND products (arm64) we are having Kernel 5.15 along
with squashfs + ubiblock + dm-verity on rootfs along with ramdisk.

Recently we have enabled "NAND Page Cache" in our nand driver to
improve nand read performance.
But after enabling this feature, the dm-verity detects metadata
corruption during boot-up and the device is crashing.
If we disable dm-verity (from ramdisk) then we don't see this problem
and the device boots fine.

Are there any dm-verity specific changes (in higher Kernel version)
that we are missing here ?

This is the failure log.
What does the below metadata corruption indicate ?
Does this mean, the root_hash is corrupted ?

{{{
[    7.731295][  T136] device-mapper: verity: 251:0: metadata block
18398 is corrupted
[    7.742723][  T136] ------------[ cut here ]------------
[    7.748206][  T136] workqueue: WQ_MEM_RECLAIM kverityd:verity_work
is flushing !WQ_MEM_RECLAIM k_sm_usb:0x0
[    7.754840][  T136] WARNING: CPU: 3 PID: 136 at
kernel/workqueue.c:2660 check_flush_dependency+0x12c/0x134
[...]
[    7.809215][  T136] pc : check_flush_dependency+0x12c/0x134
[    7.814933][  T136] lr : check_flush_dependency+0x12c/0x134
[...]
[    7.905120][  T136] Call trace:
[    7.908345][  T136]  check_flush_dependency+0x12c/0x134
[    7.913710][  T136]  flush_workqueue+0x1cc/0x4dc
[    7.918452][  T136]  dwc3_msm_shutdown+0x48/0x58
[    7.923195][  T136]  platform_shutdown+0x24/0x30
[    7.927937][  T136]  device_shutdown+0x170/0x220
[    7.932680][  T136]  kernel_restart+0x40/0xfc
[    7.937152][  T136]  verity_handle_err+0x11c/0x1b0
[    7.942071][  T136]  verity_hash_for_block+0x260/0x2d8
[    7.947343][  T136]  verity_verify_io+0xe8/0x568
[    7.952085][  T136]  verity_work+0x24/0x74
[    7.956297][  T136]  process_one_work+0x1a8/0x3a0
[    7.961133][  T136]  worker_thread+0x22c/0x490
[    7.965700][  T136]  kthread+0x154/0x218
[    7.969725][  T136]  ret_from_fork+0x10/0x20
[    7.974116][  T136] ---[ end trace 166e4069e91d0a01 ]---
}}}

Thanks,
Pintu

