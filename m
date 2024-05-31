Return-Path: <linux-kernel+bounces-197059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8870C8D6596
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029DA1F23E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D976EEA;
	Fri, 31 May 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QYmjaZ6Y"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D76CDA3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168671; cv=none; b=XkooxlLgc58ZRqa5XZFxvaSd4ir2uxvgYLlT5aiklzXwMQKkawGNS44zB3J6FTVubg3HCG77xzKbAPK9mpWuB+10ZSxA/tanJs5MajqjkP6NE+yCCMjKwng9TEydQTTe3mrT/4qJGTAkcB85AeIRJ7fWAKh+2Ufuayq4X/GrLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168671; c=relaxed/simple;
	bh=2FbQqlVM8oqZ+0S3oyHvew+8sHHSKI9UUtypYdVKFeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imV9t9RaH/ybw5KLQlYs2eapGuCSvu3vhruAoL14p8bpz5yZsrMl5CC/S7jsjRtNDfzFhnWqI0PsN4ZN1lcLkJBUfReu94NcUcuq8uEVHmoABtocyEfrVU9Gs0rRd8NeDGH0aTotewb6rnSgcHjQKqhbkLd+8RhzJhCV/bLa5+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QYmjaZ6Y; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-627ea4e0becso20979367b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717168668; x=1717773468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqvRq7yENLDnnpdEq2cw3Le9KvoZpYlA6wAP6e79glQ=;
        b=QYmjaZ6Yg0mFfGbb7js5zrKK1mF2xybYHbBaIW/NM/5lmicmtWPtnoGZzeQXpV5GHN
         ERlxz0E0mxuPruAccJskiag+BE9YC0fFQa5jeq6zHZAJ9p4sPBX+WB8MCa7wSiSuWnT/
         7Bh9P82EaRgy7VoF2nINxTNV/XQKJcKphJJZM6bVSC32yJvUMYK4q9OqmZ0twVLWOZlp
         PAptdxaQ35qPL7Rw/c+tsNUT/R0n/ZvWm33x6pybbinc5i3RtugI9qXxR4EO2UcvGp23
         ao2OCA6OLSCzqXXMZF6dVcuQDdKG4Ti35AXIQL0Ua0IEdZdjRe8pyXi4Ec+AMMd5sNUU
         aAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717168668; x=1717773468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqvRq7yENLDnnpdEq2cw3Le9KvoZpYlA6wAP6e79glQ=;
        b=Gh70b8+lOHuTWy9W3W0+ZPsYkv73qRDjm2m6r7i8fIUWZ9QlZjhZSkLEUL7ZQW6nZg
         eHQKhE9oFDe9Zbl1vLyX+N1qzR34QOuq2WuefOEu9nGbnx5cSc97D/x515VzPP0Gmh4c
         Hv86m1nR8U6DGGd41+KrfUPux+OvBzqMoHHne8/GxG1otXlrYxPIT2YPBxUgY1tN/lZR
         UJn6Nkcyewj6Hxevcqv/kCqeVXp69cVPsB68P50ZiG/Cw8wcgjF2sUpegRFPVC9G0X81
         BWe8C/if3BGOR+Ra4iRFaEwQh6//AdkBxncbAzdcbH1CrRknbKle0h45hzKHMecCN1jD
         27iA==
X-Forwarded-Encrypted: i=1; AJvYcCX76OaoREQzrFwrGTdAKjopjLsj/PvCl3u6eKR0oAiWj6U99sqW/aFWEg/vZ+6Gfr0FIGIDkWyJRTEpcAAp34pp4x+9I1rvtW8rZrXT
X-Gm-Message-State: AOJu0Yz8SHta1iJTKfHlkcbUx5/S4ozGC9IdbxSlZTicu/kTUL3cSCbP
	whg4L+wnOebAnOQSE93QRx3V1XobZEhC3vv58xLUOBDiDckFBfWLYshMKWsXe5ayt7C/KMDOBOU
	3PG136HZ3y+f/m6sojBf70n+UZazo1V44xotQUEB8sYoLHlt7a9A=
X-Google-Smtp-Source: AGHT+IGoBZVRTn8ZPER/V7J2reQJ1YQXw2ghQEo3AzlqRvr5HIsKCAfC+0w/WBOKqoJQt56aaKBXQrPQC8Zk6per3zM=
X-Received: by 2002:a81:f90f:0:b0:620:33dc:8357 with SMTP id
 00721157ae682-62c79708611mr20130947b3.18.1717168668126; Fri, 31 May 2024
 08:17:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6d33a50a-eea5-4a40-8976-fd6beff191ad@gmail.com> <5d188452-fe93-48b3-9eb7-e0fbcb5e3648@famille-lp.fr>
In-Reply-To: <5d188452-fe93-48b3-9eb7-e0fbcb5e3648@famille-lp.fr>
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 31 May 2024 11:17:37 -0400
Message-ID: <CAEzrpqfg6V5Pc-CcMqgceRapUWfb-HjAkFU9TUSEAoBNXbToFA@mail.gmail.com>
Subject: Re: [BUG REPORT][BLOCK/NBD] Error when accessing qcow2 image through NBD
To: Michel LAFON-PUYO <michel@famille-lp.fr>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:48=E2=80=AFAM Michel LAFON-PUYO <michel@famille-l=
p.fr> wrote:
>
> Hi!
>
>
> When switching from version 6.8.x to version 6.9.x, I've noticed errors w=
hen mounting NBD device:
>
> mount: /tmp/test: can't read superblock on /dev/nbd0.
>         dmesg(1) may have more information after failed mount system call=
.
>
> dmesg shows this kind of messages:
>
> [    5.138056] mount: attempt to access beyond end of device
>                 nbd0: rw=3D4096, sector=3D2, nr_sectors =3D 2 limit=3D0
> [    5.138062] EXT4-fs (nbd0): unable to read superblock
> [    5.140097] nbd0: detected capacity change from 0 to 1024000
>
> or
>
> [  144.431247] blk_print_req_error: 61 callbacks suppressed
> [  144.431250] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys=
_seg 4 prio class 0
> [  144.431254] buffer_io_error: 66 callbacks suppressed
> [  144.431255] Buffer I/O error on dev nbd0, logical block 0, async page =
read
> [  144.431258] Buffer I/O error on dev nbd0, logical block 1, async page =
read
> [  144.431259] Buffer I/O error on dev nbd0, logical block 2, async page =
read
> [  144.431260] Buffer I/O error on dev nbd0, logical block 3, async page =
read
> [  144.431273] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.431275] Buffer I/O error on dev nbd0, logical block 0, async page =
read
> [  144.431278] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.431279] Buffer I/O error on dev nbd0, logical block 1, async page =
read
> [  144.431282] I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.431283] Buffer I/O error on dev nbd0, logical block 2, async page =
read
> [  144.431286] I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.431287] Buffer I/O error on dev nbd0, logical block 3, async page =
read
> [  144.431289]  nbd0: unable to read partition table
> [  144.435144] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.435154] Buffer I/O error on dev nbd0, logical block 0, async page =
read
> [  144.435161] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.435166] Buffer I/O error on dev nbd0, logical block 1, async page =
read
> [  144.435170] I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.436007] I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.436023] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys=
_seg 1 prio class 0
> [  144.436034]  nbd0: unable to read partition table
> [  144.437036]  nbd0: unable to read partition table
> [  144.438712]  nbd0: unable to read partition table
>
> It can be reproduced on v6.10-rc1.
>
> I've bisected the commits between v6.8 tag and v6.9 tag on vanilla master=
 branch and found out that commit 242a49e5c8784e93a99e4dc4277b28a8ba85eac5 =
seems to introduce this regression. When reverting this commit, everything =
seems fine.
>
> There is only one change in this commit in drivers/block/nbd.c.
>
> -static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
> +static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>
> +static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
> +               loff_t blksize)
> +{
> +       int error;
> +
> +       blk_mq_freeze_queue(nbd->disk->queue);
> +       error =3D __nbd_set_size(nbd, bytesize, blksize);
> +       blk_mq_unfreeze_queue(nbd->disk->queue);
> +
> +       return error;
> +}
> +
>
> To reproduce the issue, you need qemu-img and qemu-nbd. Executing the fol=
lowing script (as root) triggers the issue. This is not systematic but runn=
ing the script once or twice is generally sufficient to get an error.
>
> qemu-img create -f qcow2 test.img 500M
> qemu-nbd -c /dev/nbd0 test.img
> mkfs.ext4 /dev/nbd0
> qemu-nbd -d /dev/nbd0
> mkdir /tmp/test
>
> for i in {1..20} ; do
>      qemu-nbd -c /dev/nbd0 test.img
>      mount /dev/nbd0 /tmp/test
>      umount /dev/nbd0
>      qemu-nbd -d /dev/nbd0
>      sleep 0.5
> done
>
> Output of the script is similar to:
>
> /dev/nbd0 disconnected
> /dev/nbd0 disconnected
> /dev/nbd0 disconnected
> /dev/nbd0 disconnected
> /dev/nbd0 disconnected
> /dev/nbd0 disconnected
> /dev/nbd0 disconnected
> mount: /tmp/test: can't read superblock on /dev/nbd0.
>         dmesg(1) may have more information after failed mount system call=
.
>
> Can you please have a look at this issue?
> I can help at testing patches.
>

This is just you racing with the connection being ready and the device
being ready and you trying to mount it.  The timing has changed, if
you look at this patch that I added for blk-tests you'll see the sort
of thing that needs to be done

https://github.com/osandov/blktests/commit/698f1a024cb4d69b4b6cd5500b72efa7=
58340d05

A better option for you is to load the module with devices=3D0, and use
the netlink thing so that the device doesn't show up until it's
actually connected.  This problem exists because historically we used
the device itself to get configured, instead of a control device that
would then add the device once it is ready.  We can't change the old
way, but going forward to avoid this style of problem you'll want to
use nbds_max=3D0 and then use the netlink interface for configuration,
that'll give you a much more "normal" experience.  Thanks,

Josef

