Return-Path: <linux-kernel+bounces-432691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C499E4ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553CA282D08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408D1B3946;
	Thu,  5 Dec 2024 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GViihccW"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65219FA7C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384603; cv=none; b=PPx+Fb9nJTR0v40lBE0hTwK2RLwCYm38xWwUHox/Ly7P7ydviDVmCcBrH3Hri720QuXSlWqnWpgmiZSjeFdr8ZRO5v2z6gixxC4dKlCwTkE99+iImwEbSVDP++7oJxUdTUeYRC8OiPHyj7TK6Rshz4O6oc3wAEKi+reLUQCvOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384603; c=relaxed/simple;
	bh=WcJDGkzIE8cOwYQsGl6/aQP4JrSJKoqEYIyD3TpUQhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjuOJPzs5/5hFbZ/s79tLcaW6xJb1xGVUFE6VmPobW0jopN2S3vcONLH83ron7qEC9AHRYNeB3xZs0A0UjOyjQnsY+Yb9/2yKC/RTSQBuADxBaOGQnBFDy6vSP95IiUyUW+4QHg32aGOkpDTiwU/imWQUenvgTNEU7mSUfCzCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GViihccW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa520699becso116584166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733384600; x=1733989400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTVpIEjfEvrYe8NCl/nn5jhUf4ZiohgnxnUSqyfH4WA=;
        b=GViihccWgbdmw2zXTv9Sl+5/uu+aV+qxEUm8EhM1un41puRvOYsV+bvfIEfPRiN08E
         J0lmKVh9Vc7RsuApxdXcIoHsn3/rxd8bTFkiVvHzwdCFOSqHg8F/Huhdv0dUa15HjgxC
         wDJb1IkcBuoEHpnOowdDX3aoKAz9bS+hPvWNT9iV11O8TKwGWbTbEKv/Td2I9fnBo1nc
         4Dociupy5OV6rq1tLGXnONaI4pXT1krrKfw8PBcxNZfsilG5X+nJb9SgtX4fGTfBuWOd
         5GoCBe4rwILhKRuPPCU3Y6Dkbp01vRgGqaKmMfMKHleALD5fUxLARwypE53inzMkvC2E
         R9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733384600; x=1733989400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTVpIEjfEvrYe8NCl/nn5jhUf4ZiohgnxnUSqyfH4WA=;
        b=B9eAi/hq6/QWcOu+OCu2jD9yJ/TPtC+7MUrA1FKbdFOXmBfHC6njztyD8V4A+hc5nK
         6eqIsv2wkXd/FwI5gXq26IUXf+FRMSmJ5FWghkP/+0QB7V2k2VTKObZRNoGLhZve/jLw
         zY2edJcKfqOdFnnpAhdy2bBJV0tmIBxXznLkVsqtqybDx+ptR4oHNiIabHSbJgFgz03I
         LXxsLEGRDo5qP2E6bdiufA5q/IPD71WrcfzrHcZJ9RcUshSnsFlgXqquczLAXe+hBx+n
         6XcPss+QwqGkhC0WcD6vpuIi6WMPwJVhR8nsUUqM3uXOZmeISFIgIvRl8cNqpHeK1OXU
         OZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCWGHNzYWNTywEUwBnOp1zUMOhIsZrqoKN66ygqSDnzb8wxk+u56DNeOr9Y9TMkrUj68qCSHMTLJmjBznFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbMeaGHQePD5Ij9cqspzMeHobGnWi0wpPX34VHNLF/kVVplKZ
	SWiFozY6B4LoEKzM4Omu7YDPeDj5lA971NkUU0LhgpKxqiUmWQdeYVFSWLMftAtL30e5eHHAoby
	IbWyhIDAoiHkN0Ntl8yYW92P/dHhqIzC5
X-Gm-Gg: ASbGncv3Jc6mf13PSJlxvj0ndfUZNig/oVebs4VcxiB3qNtWHgiAVJZuWMNuhKIBXrz
	9I5quflyjTjKc3iRQDbv15tnZ5aGGqYWP
X-Google-Smtp-Source: AGHT+IFAlmjsEZSabPF2WglD5s+LvXZy8Pi/vD1bEetFg/0EHFHd5OED5Qok5xCz+iCKALLTaXE1YY7eaFMm6uNonHI=
X-Received: by 2002:a17:906:30c7:b0:aa5:29ef:3aa6 with SMTP id
 a640c23a62f3a-aa5f7d4da78mr737107466b.23.1733384599610; Wed, 04 Dec 2024
 23:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLhxBBihr38p_XMQEgkiLFc+DPxkQf4oewF8U1+ihaFn-Q@mail.gmail.com>
 <CAOuPNLhhWzoBQH85zEd95LbONtrknq+b7tfcze50VPa9bEnXzw@mail.gmail.com>
 <87ldww4zrx.fsf@bootlin.com> <342000380.28770675.1733242094522.JavaMail.zimbra@nod.at>
 <CAOuPNLhZZ1rs3Hhuwh2b3HLaqrAVUY7YwviQVUXgVi6XTZxnMw@mail.gmail.com> <1562063374.32195797.1733307383533.JavaMail.zimbra@nod.at>
In-Reply-To: <1562063374.32195797.1733307383533.JavaMail.zimbra@nod.at>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 5 Dec 2024 13:13:06 +0530
Message-ID: <CAOuPNLg-EE=BMq+61h3N7=-59oFg0=cBdGG1tryXZRwhq=4MTA@mail.gmail.com>
Subject: Re: Block based OTA update needs mtdblock
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, chengzhihao1 <chengzhihao1@huawei.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Wed, 4 Dec 2024 at 15:46, Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> >> >> Did anybody used block based OTA update NAND A/B system without usi=
ng
> >> >> mtd_block ?
> >> >
> >> > Not on my side, it is actually a good question. Richard, any ideas?
> >>
> >> What about using ubiupdatevol?
> >>
> > As I explained above, ubiupdatevol actually performs a full volume
> > update, right ?
> > I think the partial/incremental update is not possible with this. Once
> > the update is triggered it should finish fully.
> > But for OTA updates (Delta/Incremental), only the delta changes can
> > also be applied.
> > Please refer to this [1] about updates mechanism.
> > [1] https://medium.com/@yigitpirildak/android-ota-update-mechanism-ecc8=
f6f69f71
> > [2]
> > https://source.android.com/docs/core/ota/tools#:~:text=3DAn%20increment=
al%20update%20is%20an,need%20to%20include%20unchanged%20files.
> >
> > On our NAND target we support OTA updates, including incremental ota up=
dates.
> > But without mtdblock the incremental OTA update (on A/B system) will no=
t work.
> > This is the main issue.
> > For full updates on ubi volumes we are already using the
> > "ubiupdatevol" mechanism.
>
> Well, for dynamic volumes you can use the UBI_IOCEBCH ioctl to replace LE=
Bs.
> So, incremental updates are doable too.
>
Oh I see. This seems useful. I will try it and confirm if it works for us.
Thank you so much for this.

Even the header file (/usr/include/mtd/ubi-user.h) mentions these details.
{{{
 * Atomic logical eraseblock change
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 * Atomic logical eraseblock change operation is called using the %UBI_IOCE=
BCH
 * ioctl command of the corresponding UBI volume character device. A pointe=
r to
 * a &struct ubi_leb_change_req object has to be passed to the ioctl. Then =
the
 * user is expected to write the requested amount of bytes (similarly to wh=
at
 * should be done in case of the "volume update" ioctl).
...
/* Atomic LEB change command */
#define UBI_IOCEBCH _IOW(UBI_VOL_IOC_MAGIC, 2, __s32)

* @lnum: logical eraseblock number to change
struct ubi_leb_change_req {
        __s32 lnum;
        __s32 bytes;
        __s8  dtype; /* obsolete, do not use! */
        __s8  padding[7];
} __attribute__((packed));

}}}
This requires the logical erase-block number to be known.
I am wondering how to get the LEB number from user space.
I need to explore further..

Thank you so much...

Regards,
Pintu

