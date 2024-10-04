Return-Path: <linux-kernel+bounces-351045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62451990CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDF31F20C92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE481DD9A9;
	Fri,  4 Oct 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMcLvXm6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C41FBC97;
	Fri,  4 Oct 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066230; cv=none; b=ubKI3Uhv9HbKDgypjIjdCOVc7CtfBUKMTraQ/5olYdi05XsPigkrdfD37mrUoDbs7FL1aoWYZ2/rKmJF8zVUH1iBAiJ1Gx+7N6zHj+AwKXHl7wE473YJk8+m9cmf6msqMkXOE6DBHZCHcj9JfEEKDQEbz4UJkHNYPJFRpgJy1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066230; c=relaxed/simple;
	bh=m5ip9qkR4OCyBx6ujgsy1Y70Ip1OiNgXtt9qUe/hBqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1bjEjTCJ9DRLZGQCi5EkiOtTMeJnJeScHgoMpbQnYi0nrlsrB7j3DFa1mUM+F88YdlW0HTP3VvOoh462fG/FGnmzz6w9DDBWFJRg1zARdLdheATvdb2gyJDwxh+Slzxh2k3eRsDKXmsrlcc3KdyrexmKzsXHLclnwSxekiAlCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMcLvXm6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso428268366b.0;
        Fri, 04 Oct 2024 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728066226; x=1728671026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5ip9qkR4OCyBx6ujgsy1Y70Ip1OiNgXtt9qUe/hBqw=;
        b=SMcLvXm6bvJB9riHBXWEzXNXKVa90zqrPuQ5TI3XamFAJecnpMPC1Tnnto8Az15pVt
         Pa+0kTlvz3hUf3B/Eq152oDbf5ilQgUxjv7t0vs1Nht8A4KKl8QngT4PrLeoezVVOyZb
         dTzfIQYWUWq+V8T0Ph/Kh258XWtBLlsV9pByIuLFGSZBfAQSnRIFv+4DuxQVtOlwDcdf
         DNdAlSHsC81QB3Wz0taCZSJpBqQ4IxurFoFjsz5bnJwagZTyDn1YRI6EIWYTuSkG6uNg
         Qi5fnuA8ruaOJF2FAhG1pWTwRMNGjBfmuGV7zgxrTNPqhdnhxyAqKfJjxyUEAFQJsc7S
         qtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728066226; x=1728671026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5ip9qkR4OCyBx6ujgsy1Y70Ip1OiNgXtt9qUe/hBqw=;
        b=k2T3SfQcnwQVIHjSJKr11BoQVmowz0MwRJc+LaVDeRtewsnYEhoa/TshNCI6iOhyaP
         MhJa5j4PwfLZxVZ1Led8z8lXj3hfGcj70GWjq1e9cpPQn5Tadd7uozE+OFzXnnz1PvA+
         O0iwVu+eBspkRNPHHcSKgegIL0I9B31yoCtRojMhs5PDO5XOE8uQSGXsroFjVx3Q8xSN
         bHrvaRcfTb/p4pS/6Vk1wbXu2I2nljKoCGF0RnrViJR2Emdl63mBdZKhCf+31bxV5v1i
         2OBI0NGoP347tdAh2FvZxESoVfn2AXwI6Ytt0gPo2Hj+fh/uvgN5PqXOBQng0xMviOvW
         eL+w==
X-Forwarded-Encrypted: i=1; AJvYcCVUH1Z2XD0SBVhyLlkj46qFSGWwZN3k42d2cKOoYUbL7bZpSIUmKfNsf0vff81Z/yf+XVIzN7rmJ00Y@vger.kernel.org, AJvYcCXiRZ5dDkUN9zKxh5IOj2BnOAMlOqiw+Q9IZtzwngx8TCUsz4BSdy9Kii/uP9OH6w8geJwZcCVDJh33Pb+X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95Gaebl0PFdQOi/cktItGqkYG4mPjb7soPZByLPnQXyOFyj8A
	52Z1SwX1SB0CIRAAra5AytQ5lxS+VrgbvaEQLi8qZogNjMKwxxuNKdYFkuaMcRFiX8VmcGSoz8z
	bOz1kpCrm4CNg2q2yksqhjTQ+EJC2/oU1Y+0kXw==
X-Google-Smtp-Source: AGHT+IGsyxIgvwACI1dK1qktkBruDAShcqvJduzumzcF8nTZhjScUkkiD8bGLozSIsi+SlH2V80S+E7QogVP4m7pbAY=
X-Received: by 2002:a17:906:6a03:b0:a8d:63b5:e795 with SMTP id
 a640c23a62f3a-a990a034eaemr729068066b.3.1728066225882; Fri, 04 Oct 2024
 11:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003213007.1339811-1-CFSworks@gmail.com> <78f25b22-f35b-4183-baec-7ddc0c5e3fda@broadcom.com>
In-Reply-To: <78f25b22-f35b-4183-baec-7ddc0c5e3fda@broadcom.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 4 Oct 2024 11:23:34 -0700
Message-ID: <CAH5Ym4gUfhh3ZkPY8i8eVNzWOpfk+ibqAgdPuT3i0H0FsF5t8Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE stub area
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	William Zhang <william.zhang@broadcom.com>, Anand Gore <anand.gore@broadcom.com>, 
	Kursad Oney <kursad.oney@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:41=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 10/3/24 14:30, Sam Edwards wrote:
> > The CFE bootloader places a stub program at 0x0000-0xFFFF to hold the
> > secondary CPUs until the boot CPU writes the release address. If Linux
> > overwrites this program before execution reaches smp_prepare_cpus(), th=
e
> > secondary CPUs may become inaccessible.
> >
> > This is only a problem with CFE, and then only until the secondary CPUs
> > are brought online. However, since it is such a small amount of memory,
> > it is easiest to reserve it unconditionally.
> >
> > Therefore, add a /reserved-memory node to bcm4908.dtsi to protect this
> > critical memory region.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>
> Not objecting to the solution, but should not this be moved to a
> per-board DTS given that there are boards using CFE, and some using
> u-boot + ARM TF that are unlikely to suffer from that problem?

Hi Florian,

I think I share your same gut feeling: this is bootloader-reserved
memory, not something claimed by a driver or belonging to a device. If
the bootloader is going to leave some code or structures resident in
memory after handing off control to Linux, it's the responsibility of
the bootloader to claim that memory by splicing in a reserved-memory
DT node, and CFE isn't doing that. So I think we're very much in
"Linux-side workaround for a proprietary-blob bug" territory.

I don't know if it makes much more sense to put this in the
board-specific .dts files; as I understand it, the architecture of CFE
is somewhat unique in that CFERAM (containing the actual "bootloader"
part) is included in the firmware image. That means that whether CFE
or CFEROM-loaded-U-Boot is the thing kicking off Linux is up to the
creator of the firmware image, rather than the device manufacturer.

My reasoning for including this in the SoC-level .dtsi is threefold:
- The .dtsi is specifying enable-method and cpu-release-addr for the
CPUs, which also concern the Linux-to-bootloader protocol and should
customarily be synthesized by the bootloader. U-Boot picks "psci,"
overriding the FDT-specified default: so the .dtsi is already assuming
CFE.
- The .dtsi is also picking 0xfff8 as the fixed location to put the
secondary-core entry point. I've noticed that CFE walks the FDT to
learn cpu-release-addr (rather than writing the property): so the
.dtsi is also already assuming that this region of memory is reserved;
this patch just makes that explicit.
- 64K of reserved memory is so tiny compared to the hundreds of MBs
typically available on these boards, so I felt that the unconditional
memory cost was an acceptable trade-off to save affected users the
troubleshooting.

If you happen to know of a DT property that tells Linux to unreserve
the memory once fully booted, I'd gladly use that, but I didn't find
such a thing when I looked.

Since CFE's stub program appears to be very small, would you be more
amenable to a patch that moves the address at 0xfff8 to 0xff8 and
reserves only 4K (one page) instead? I hadn't thought to try it before
now but it should work.

Best,
Sam

>
> --
> Florian

