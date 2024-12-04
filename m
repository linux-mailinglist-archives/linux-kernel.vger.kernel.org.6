Return-Path: <linux-kernel+bounces-430899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834339E36FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32C5B220C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343981AA7A5;
	Wed,  4 Dec 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM7iv8rk"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8718A6C4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306330; cv=none; b=kaIbiErOpUzCFj72J43+wQzZcm4A8hhx1D3hylmzy1WWFf2p4b7e9ZKStOiGIfF+LH+qbDYEkNb/cd3epnfhsARl91mL2ZLe8yt+eJ0nKRBs+OcfqlXQ6d5TutkLrUfo2Le/jt2m1Ksn/1EKrnvW0SBRNjj3oHh73OoXc11DlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306330; c=relaxed/simple;
	bh=MouHXQtNCaAsuF0SN6e6HpsGguY/Y4bmGgPG3F9d7Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcYVyWHCX9UjwbceomNubzOm0U/fPZZzgr3lyxAUz1f7XB2d/ltQfFVapMROlo5zQbGTB75iAQfLy6KplR4BYpbDs0J675APrwFzSfBdPI0zVIZMtoLSUIgF34AtgfYKTaZqBdSi1asvby5gkVUaILMqBz8Q6v8noM8HwRz7r0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM7iv8rk; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0bf80972dso3091692a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733306327; x=1733911127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MouHXQtNCaAsuF0SN6e6HpsGguY/Y4bmGgPG3F9d7Hw=;
        b=VM7iv8rkUNVWIEDNGawdXmKjh4Ijypb1qkiGuSzm7v2hZc5iQNAIEciVLori/Wjo6q
         CYPW2g2EFPpX/SL/lxSxXeeycrto6s1ELAxwyV/dtfZZP1+a2f9LCPAJgVMxWtlAStvM
         SUrNUIM4XdyrCTAHNMrY0oxnJBsF0DrhEAM8YrVhsUYJBw2XFjBcT8N7wCv1GGavuR10
         h5/zMZSF6pdpwj43WXaF0gNi0zlww1+YJ1/u7G5xkK75o1WKU8Xgtth8y6mxgB9efi17
         26ODgEWMhC/QT7AC7+PJEh+b/6gYHrc2gtILwpl8qBkr/1Tc1usUU2ssOVOFhn1GRp3Z
         0uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306327; x=1733911127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MouHXQtNCaAsuF0SN6e6HpsGguY/Y4bmGgPG3F9d7Hw=;
        b=ZEPAKF/ycXLLUkbYLU8W1QA5Bk3rw9lBrtwtQrbHZ66AMfooXAZo7P8Nis5LlArjl1
         sCS+vHYgZBhoRZkbauI024Br3PG75BYTxEU/T539Qg0X09hObtGf4XFWJEyJJ5Lw9nc9
         iJrBmCcBZQr9LivyNFMubqTb/NLdmOoXXiq/vZPrpAfEeGhfuPjpgXvdJRj9n+4cnP5y
         cQdAAARGgVZYH63TlOROzzfzX9ehA4v2cqEulbGHSa8ROz9VaQDh1pEQXPi/kjmq8QzW
         hq4MB6qMYsfvPn6WYo/bNCEXZ11q/irJad4yutODh5hwAXenWTl1rnqviN+PEvVdSIQK
         0WYw==
X-Forwarded-Encrypted: i=1; AJvYcCWPCy8/pCy6e32U2Ez3sWywzr23YU/zDmQ85/l1QX3Xthv8e6Aoz9gv1IYpNIvLn+VVEiSgi4rDWftIhng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ar9EyoQIhkAtN4wozTiVchaw4U2Z8DV6x01z5KoTLLYZbUmo
	iH7KtWZclComX2LQKlTzQMSbk+D/jsgsUYfJJhK+sLMi3o6RXTWf3RjKwq6BeP4v+YzzHb/jtQi
	MnMupt43vJnDcWwPCiSzx4RBoUuk=
X-Gm-Gg: ASbGnctO9hPlfpxtFhO/KT+BGXAIA6fofObIH+fDzAKDdT+9j0D6emmFx50rdM40j1A
	uCddYtZ5jk9OnPkPo9TFFwTzNFlGj3GO6qQ==
X-Google-Smtp-Source: AGHT+IF71UT/V7lY/zgb2nneDIgnWNe9aquIUB4pgtTNjsFfQsOeEBJ6i9HFgX2W+LlGyHQiF7wXnJ1F9OCyaqv199g=
X-Received: by 2002:a05:6402:34d4:b0:5cf:f361:1c11 with SMTP id
 4fb4d7f45d1cf-5d10cb5c7c7mr5552224a12.20.1733306326713; Wed, 04 Dec 2024
 01:58:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLhxBBihr38p_XMQEgkiLFc+DPxkQf4oewF8U1+ihaFn-Q@mail.gmail.com>
 <CAOuPNLhhWzoBQH85zEd95LbONtrknq+b7tfcze50VPa9bEnXzw@mail.gmail.com>
 <87ldww4zrx.fsf@bootlin.com> <342000380.28770675.1733242094522.JavaMail.zimbra@nod.at>
In-Reply-To: <342000380.28770675.1733242094522.JavaMail.zimbra@nod.at>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 4 Dec 2024 15:28:34 +0530
Message-ID: <CAOuPNLhZZ1rs3Hhuwh2b3HLaqrAVUY7YwviQVUXgVi6XTZxnMw@mail.gmail.com>
Subject: Re: Block based OTA update needs mtdblock
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, chengzhihao1 <chengzhihao1@huawei.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On Tue, 3 Dec 2024 at 21:38, Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> > An: "Pintu Agarwal" <pintu.ping@gmail.com>
> > CC: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>=
, "linux-mtd" <linux-mtd@lists.infradead.org>,
> > "chengzhihao1" <chengzhihao1@huawei.com>, "linux-kernel" <linux-kernel@=
vger.kernel.org>
> > Gesendet: Dienstag, 3. Dezember 2024 15:17:06
> > Betreff: Re: Block based OTA update needs mtdblock
>
> > Hello,
> >
> > On 20/11/2024 at 12:52:57 +0530, Pintu Agarwal <pintu.ping@gmail.com> w=
rote:
> >
> >> Hi,
> >>
> >> On Mon, 4 Nov 2024 at 21:31, Pintu Agarwal <pintu.ping@gmail.com> wrot=
e:
> >>>
> >>> Hi All,
> >>>
> >>> For one of our automotive products we have the following configuratio=
n:
> >>> QC chipset, arm64, Kernel-5.15, NAND Flash 1GB, A/B system, UBI
> >>> volumes (squashfs, ubifs), DM-verity for rootfs (squashfs), simple
> >>> busybox platform.
> >>>
> >>> For OTA updates we have a strong dependency with MTD_BLOCK.
> >>>
> >>> Till now, we were using ubiblock for mounting squashfs volumes and
> >>> completely got rid of mtd_block by configuring it as a loadable
> >>> module.
> >>> But, we also need to support OTA updates (Full, Incremental) on A/B
> >>> volumes using the same Android OTA framework.
> >>> https://source.android.com/docs/core/ota/nonab/block
> >>>
> >>> OTA update will be applied to the B (inactive) partition.
> >>> OTA updates prefer block based update over file based especially for
> >>> dm-verity enabled devices.
> >>>
> >>> Now, the problem is, on MTD we only have 2 options for block based
> >>> updates; ubi_block or mtd_block.
> >>> We cannot use ubiblock for OTA updates as it is read only.
> >>> For full update volume, we can use "ubiupdatevol" interface to
> >>> completely replace the volume content, but for partial or incremental
> >>> update we need to update only specific blocks and not entire
> >>> partitions.
> >>> Thus, we have to use the MTD_BLOCK (/dev/mtdblock) interface to
> >>> support block based OTA updates on UBI volumes.
> >>> Thus, during ota updates (only) we need to install the mtdblock
> >>> module, perform the update and then uninstall the module.
> >>>
> >>> That means, we cannot completely get rid of MTD_BLOCK from our produc=
t
> >>> especially for OTA use cases.
> >>>
> >>> Is this the only way, or do we have any other option to support OTA
> >>> updates over UBI volumes ?
> >>>
> >> Restarting this thread again...
> >> Any further comment on this ?
> >>
> >> Did anybody used block based OTA update NAND A/B system without using
> >> mtd_block ?
> >
> > Not on my side, it is actually a good question. Richard, any ideas?
>
> What about using ubiupdatevol?
>
As I explained above, ubiupdatevol actually performs a full volume
update, right ?
I think the partial/incremental update is not possible with this. Once
the update is triggered it should finish fully.
But for OTA updates (Delta/Incremental), only the delta changes can
also be applied.
Please refer to this [1] about updates mechanism.
[1] https://medium.com/@yigitpirildak/android-ota-update-mechanism-ecc8f6f6=
9f71
[2] https://source.android.com/docs/core/ota/tools#:~:text=3DAn%20increment=
al%20update%20is%20an,need%20to%20include%20unchanged%20files.

On our NAND target we support OTA updates, including incremental ota update=
s.
But without mtdblock the incremental OTA update (on A/B system) will not wo=
rk.
This is the main issue.
For full updates on ubi volumes we are already using the
"ubiupdatevol" mechanism.


Thanks,
Pintu

