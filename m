Return-Path: <linux-kernel+bounces-421439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB99D8B53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3E928276B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCF91B4F15;
	Mon, 25 Nov 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFJJR2aK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04518C322
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555881; cv=none; b=ufvDux+innM3g5XcnuOVHTwQtitQ7BYtU0fz0EpeMwmU/1ot11nK08lrzijHkOlFcf+y0TQ8rUl2/5EGOnECBc/dWQoh5rRq6KoLx1VFyYa++nr5875ncuHzCOJJohJXger8wH/QBkk5LwgqIfOXZDhkIlXgelzUa1i/SbBBB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555881; c=relaxed/simple;
	bh=VMK4fjARbUe5ibv5TqQ0Vem9Tq64YnTSJ7BEWN8i25Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+YOTWIYzv3ko1i5tcl3zBS2papOFs5Za214SRKOTQxBd7PIxZRcXpXQX4LkRwcaqDpwSId4K2CnrdBkfN5/eHbtJH4Ccmm0s3HkPFZ+H1YCbapi2eHwkhAnRQS+sCkRk097TUyGTLSCED9Db0CdcYYbr1HHGr3DgOzZCuDxBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFJJR2aK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de652f242so892452e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732555877; x=1733160677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rILC2BxBgO2Rtw5hTimKlVPBC9bz9nfbq7eLfeQG+no=;
        b=TFJJR2aKOYOPVZA8DzfP1npG/4ysvtYFpK5xYLb7VtoszUkYp03J/yEDMhQC+MUaTI
         GbBTwn/H9iko3zyNwr9elZ8CUUDYeVqMVdirBvU8dnZDEAyAsXw7jyzcTicunNhfti3H
         UrGDFtRfnuMSqNzxqDAYOoGwfmt3VR/dVy2qhYkhWwXo9e2+uEjA5i3oNRMoCnJcje0W
         Y0ycGOtSpvvE4MZadk2ED+xXIAtKm67KrMBuI5tltqXGudiNxKFbv0GQbG8JTn4K90cj
         vRR3r34NQwGZCroHUd0MGTCc+4j64GJLpWDck54y77ndDjguBIg31zlvPdCvjvoeB4rX
         TaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555877; x=1733160677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rILC2BxBgO2Rtw5hTimKlVPBC9bz9nfbq7eLfeQG+no=;
        b=baDTPoLoImx7IfAWW6y5xcCpIpVV6v4Vy8nluM3EhH/ooqe1I2O06T+IGo4Br9qA8j
         4aoREFSRbvQ+71BFrzMeb2gNpPVYXHi5xsblgQ2jrcX/eEyu3OttKuuPo/f9kwHlBRX9
         W5OSyNcYiKxzad1epkxZk+1H0mnQUtgBPMHEOw+vN5uLnIbSjCzyJteWb9j2Gk2QfbqS
         v/Pvo327tF8I6cc34ZRFG7hZSa4F5GDU08GLcrpPOQ2MXK65Gxs7cQl3W/fLp/QQUxaV
         kQWAflYiStPd760+S6mXfQeZDGs6jRqDSv6YUSUP67VubmOCimU7+eW9FZGx3vOiTo1S
         n8sw==
X-Forwarded-Encrypted: i=1; AJvYcCXvlP+dM3nV5G1sj2T9btzvMtnBz1KHYpd0AcKbvJQgygRPYIf9EyHA3CVIdlngkDlbdmQZCl9GlBK8eh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk6L6SUqdXzqHpoVNFHN6h6ZI3tt7zaxoQGSV5OugqazvT1wF1
	giH24Lq/0tuniUir5ydlJaK/zom+gDYe+SQIL6T5hxMIaDdfOYQh1rqBJv6U6uzRkdcxVjULw12
	3kwD5g/UFzeUhyH/Kmzk8jyzcz0Xu
X-Gm-Gg: ASbGnct8hfPAojXPbaL3UQNAVayDWgrC7DXwFf1ROCjITYuUk2+OxncmVOfUZ9Fo4nv
	hqhjzBUSEFhDaEHFraaQfa9KTqMguZqT73SEOaCA0fThj6A==
X-Google-Smtp-Source: AGHT+IF/Hbrb4GRi5y/7WmIm8q51cXLBDI+7dPYh6r69XJ9sv/d6gokZqewfe2klSI91UU6BZjhhk3E8QCKdInVhlyM=
X-Received: by 2002:a05:6512:2f2:b0:53d:d405:6e5 with SMTP id
 2adb3069b0e04-53dd4050706mr5390957e87.47.1732555877092; Mon, 25 Nov 2024
 09:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
 <Z0C3mDCngAf7ErM2@gmail.com> <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>
 <Z0Q0PJzTMg_Or22I@gmail.com> <20241125102223.GBZ0RP375DufF0QQds@fat_crate.local>
 <CAMzpN2gysxoKsjGhdSwykxQ1a_F0pZG=j6Y76QDgSmNG3V7SPg@mail.gmail.com> <20241125170922.GDZ0SvQj8FgK0ej8F3@fat_crate.local>
In-Reply-To: <20241125170922.GDZ0SvQj8FgK0ej8F3@fat_crate.local>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 25 Nov 2024 12:31:05 -0500
Message-ID: <CAMzpN2gB1WKruX0UGiO72Si1KHjcC_KcbAOK=-9TAO+cmSpFQA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 12:09=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Mon, Nov 25, 2024 at 11:57:37AM -0500, Brian Gerst wrote:
> > How about removing the kernel headers that you don't want from the
> > include path?  This is a part of a broader issue where different parts
> > of the kernel need different compiler flags (main kernel, VDSO, boot,
> > etc.) and the current makefile structure doesn't handle that very
> > well.
>
> Right, the idea is to remove *all* include/linux/ headers from the
> decompressor and have the build break if someone includes new ones, forci=
ng
> her/him to properly split such header and use asm/shared for the common s=
tuff.
>
> There are examples in asm/shared/ for that already.

To clarify, what I meant was to remove the -Iinclude/linux flag from
the compiler command line, instead of messing around with ifdefs.


Brian Gerst

