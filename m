Return-Path: <linux-kernel+bounces-415301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABA39D3412
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6529B22F04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C1156F39;
	Wed, 20 Nov 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpSElneh"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86328200CB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732087393; cv=none; b=tnxv0x/W8OPooMnZfmqZ7ybpgG8GX4KOLD0mHpXcoHLjUwTuLwscpaUYwCR3hx9EUwaNVsQq5PWBkKvQOT0KUmS2c3tYphHnQqTLq0Jmr0OejAF39kL30q6/V2FSYB+qT285W1xyMrqAeTEelsbNhifscod8eJ1L5S9X2zVLQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732087393; c=relaxed/simple;
	bh=9TUH4fBzcOFFv2mVquyak0awmCdSSw1x1C2GwnTi8IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UT1n64I/nBakVhWkwzCHzA44LpaiWYL5/bu2zWQ20/0fcI1FO8L/7d4eMdUB3RGyZ+Gdx4okIFzOFue4EgFxQk1Ir8YCWMrjC0a9qJ6bzbemKtIkQX17/XUkSBzeHm5N/powEXLVXUHF8bKOSk01mqwJcT+IJ24rwRqs5srEf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpSElneh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso242303366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732087390; x=1732692190; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TUH4fBzcOFFv2mVquyak0awmCdSSw1x1C2GwnTi8IY=;
        b=SpSElnehtmxt/BU8wAfW1ziX4Sec0Q+jCy/DAynb754bn6sOUDe8vnr158jNmNG3em
         5SqkiPMD3qEy2EmIl6BDl3RwM4HqlFJWp4Exc6hdFlWrtzaWDw2vOnVrH4NvTuFRWH8c
         nTIa1kr0rCG8Jfqg6FniQkKOu9c9tspU4b6iN32fPK6KsqSyWIISUT7zfyioXWYQZde3
         Q6zA1ltJOHUsE+5RNa36wfGdppT61fFnoYqAHcdWiJ5G2YK3sOWYOPCO9gVCZZsDU0qB
         kNaDxIU1nit8dnhqMb2UmvYGc2hMaoGFRUxfDxm9zLM8iqSlD/xqshmF/wsGe06XyqB+
         3gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732087390; x=1732692190;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TUH4fBzcOFFv2mVquyak0awmCdSSw1x1C2GwnTi8IY=;
        b=EHpFS4l6pIMw7Uy6FGnA8VYjERkFDo1V0r7az7HMG3oYnJaaEccqrNEDklTReUy119
         W+iLcqjwJfO/UTyVd2RfTDJdAYGPhAFpsSMejGP2jzm8zIZ1Afa1GtnFsJOTtMMca5ZZ
         QhFNdm4xZhL4tP8gVESZZTBPMJia5sZVYbvw8qalP8nFYTwv+Rjr+YULz9PPaVyj0gdh
         9tnhMlFmgnqyTQa3MkOG+8ql8fqIZyVll2lRlv84nbATgzGLQBGHTMYf78QOWusFEOOC
         96clFaqy0SvC8JauPztThOJ84Eszy55ceMetvBQeVOXwe8cvBokJb8focVzBzfaO1+Wj
         YK1w==
X-Forwarded-Encrypted: i=1; AJvYcCWxD1YDkw3fa6alXHpz2VP3IRZlE95RD6NltjCos0ebRT6sQ3M0XLHyMhOWwh743WillZOrBtB4nuFBjLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpjkSuYf9eWGeNCY9Im+3kAjn5lcVfWWqVwtbA2RidZ/pqJhU
	iPooWk+4x1RfA6Qri8hs9vV4wyXUv2E+QbpF5TOn/Xbi+YBbGQSMi7X58+RC+yIs7+FQjnCayRU
	s0wShiPuFODHdtwxhtdEpzpsupaI=
X-Google-Smtp-Source: AGHT+IFJLaQBiwiWiQwPPj21kY4gRHUQRpwhGpQ3ocHcoYF5cTnC9mIFUs/iW5OYYbNRN5ehA+LKxz+IPQmL9rmyI/g=
X-Received: by 2002:a17:907:2da2:b0:a9f:450:48eb with SMTP id
 a640c23a62f3a-aa4dd71a2c0mr141394266b.45.1732087389628; Tue, 19 Nov 2024
 23:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLhxBBihr38p_XMQEgkiLFc+DPxkQf4oewF8U1+ihaFn-Q@mail.gmail.com>
In-Reply-To: <CAOuPNLhxBBihr38p_XMQEgkiLFc+DPxkQf4oewF8U1+ihaFn-Q@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 20 Nov 2024 12:52:57 +0530
Message-ID: <CAOuPNLhhWzoBQH85zEd95LbONtrknq+b7tfcze50VPa9bEnXzw@mail.gmail.com>
Subject: Re: Block based OTA update needs mtdblock
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd <linux-mtd@lists.infradead.org>, chengzhihao1@huawei.com, 
	open list <linux-kernel@vger.kernel.org>, kernelnewbies@nl.linux.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 4 Nov 2024 at 21:31, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi All,
>
> For one of our automotive products we have the following configuration:
> QC chipset, arm64, Kernel-5.15, NAND Flash 1GB, A/B system, UBI
> volumes (squashfs, ubifs), DM-verity for rootfs (squashfs), simple
> busybox platform.
>
> For OTA updates we have a strong dependency with MTD_BLOCK.
>
> Till now, we were using ubiblock for mounting squashfs volumes and
> completely got rid of mtd_block by configuring it as a loadable
> module.
> But, we also need to support OTA updates (Full, Incremental) on A/B
> volumes using the same Android OTA framework.
> https://source.android.com/docs/core/ota/nonab/block
>
> OTA update will be applied to the B (inactive) partition.
> OTA updates prefer block based update over file based especially for
> dm-verity enabled devices.
>
> Now, the problem is, on MTD we only have 2 options for block based
> updates; ubi_block or mtd_block.
> We cannot use ubiblock for OTA updates as it is read only.
> For full update volume, we can use "ubiupdatevol" interface to
> completely replace the volume content, but for partial or incremental
> update we need to update only specific blocks and not entire
> partitions.
> Thus, we have to use the MTD_BLOCK (/dev/mtdblock) interface to
> support block based OTA updates on UBI volumes.
> Thus, during ota updates (only) we need to install the mtdblock
> module, perform the update and then uninstall the module.
>
> That means, we cannot completely get rid of MTD_BLOCK from our product
> especially for OTA use cases.
>
> Is this the only way, or do we have any other option to support OTA
> updates over UBI volumes ?
>
Restarting this thread again...
Any further comment on this ?

Did anybody used block based OTA update NAND A/B system without using
mtd_block ?
Since ubiblock is read-only, it seems there is no other way to perform
OTA update, if mtd_block is disabled.
Or, we need to make ubiblock also as read/write.


Thanks,
Pintu

