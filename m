Return-Path: <linux-kernel+bounces-187466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72CA8CD23C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F611C21356
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D671411F5;
	Thu, 23 May 2024 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOWmuiWA"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0013B5B3;
	Thu, 23 May 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467051; cv=none; b=A3c6c3zE1SaDxgT6/YDssbseoGSmD48exVIubUdzC+N4oJLLdlsXAXVHbtk0E51LdJXceXOo50GEykKjis6T63332tc/2j4s7wq0S/McCTOQ6OZgHQ8AcL0j8FNhgH1sohEWwNwDv5K04BTlWl9ueK8LgJOBAiVvgnwVsYbaTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467051; c=relaxed/simple;
	bh=nMyW6qilbUVDIw0ZZRVu1L3/IxlbetTsYTWk2xoJ1Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJRFX5cQGHKJC1LqKPR6MRxcZrDWe0Er2jNqjUUij/aoMvXntslFruyOo6Ku2qBb0wZWTU2z9En79h899j74LVx3OcMwPz+E2425NCTHv3iPnWwxhLmLyVrlISSPvkBthS3CXABUZXsa2xn55MrFf49H28paBCVWez5YtLDBCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOWmuiWA; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4e160984c30so1136738e0c.0;
        Thu, 23 May 2024 05:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716467049; x=1717071849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGInZ8XJKUbjr8yafmcP//JVQaWFhcuQkEdM0iAp5Tw=;
        b=KOWmuiWANpf+f0ToegJmCJQBh7af+xgxDzwCM2YuJeBknhNn8Nzgi8sf2puV9dnSc+
         0TNpTQmDX2tvc4mk96Oh7iVwq2tuzwFtlNvmMHP621F14ImN4u4ezeBTJe0de2Td7fTz
         n/GdygdKz3aNDlsgBOZpeA8x4RVwOhJfgbiSvEaknIvJTkYJbOfOQOYHuD1MGT/zaqTq
         JoxdwovtvnozKei7xXn8SSx7lUnzhvLl1S5Lc7Aw+qG24DWun1L3RHpdYSpDdlWZg1DP
         xi19NDft4rvh8HfBxb7UCUkCgd0EUnveIni1L1Vy/v7UMDcnJ22qRfnGqjty8J/JFiKG
         RuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716467049; x=1717071849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGInZ8XJKUbjr8yafmcP//JVQaWFhcuQkEdM0iAp5Tw=;
        b=QLp+nTMOOcRw5E/d8yOJ9HIdSSjs92VU+xuSm/B+5n5pjbXfMHKYYqRK67VAplTsvZ
         xUnd+D7xFnnS8Q+e5Cx3UU9C+8mnkgGSfMc02cWwxZekhDZiE0N4yxwgjRxBHRxcZVLx
         yihaMc83I51SMIYakmRAOCfdI55aovaMoHtYcdykDKoP5dyqO9ZCRglTZwwg5Q5UKD0h
         ge2E6BwgLBzX29/fzZwRyb3kXhjWNp8ohBD11QsLZGO62Z+ppSIdt5IJtjgeU9SuzwTE
         Z17SAIMpbuprfdAjDL6l+MSn5iwProwY7n57JEzqiu75O3MdY3C78VxwwKNRKGBzmcdI
         of4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoTw1CB2fZ8JecZJX5ptc1DHT8J4ZE0CsrrcE2uZnUaaYB1hRVn3vr6lA+AUYS47mJpizLXBAlIzobnaX7C9n3kRNuzd0lJeg463u03tLtAhYbgUMLNWguC34Zb6uTwabxWCa0Ce9U
X-Gm-Message-State: AOJu0YxdcfU02iXVkmJseEFwIb8AfgAHE86Ih1VM+hiRiqXlmAKLUIyG
	XDhgRN4zkRyZQxxoQOEYorX5v+zkDiKpABneohrgUx+5so51fTnqO1HthitsdqPnnnXM8+fLGOn
	6+QRkDXINCfCRThJLFBoj97VlK1M=
X-Google-Smtp-Source: AGHT+IElrfcItijCEePsCGzO2XStERDXwXp8+ZZ2vY9L1TDW/53QGq23TR7ewNqRE3uPRGLBodVfQuBNOACKxmh8MBw=
X-Received: by 2002:a05:6122:a01:b0:4ce:96b7:c2f6 with SMTP id
 71dfb90a1353d-4e4e4d15e1dmr1647042e0c.5.1716467048796; Thu, 23 May 2024
 05:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523113410.983875-1-shichaorai@gmail.com> <2024052351-demote-gangly-74b0@gregkh>
In-Reply-To: <2024052351-demote-gangly-74b0@gregkh>
From: shichao lai <shichaorai@gmail.com>
Date: Thu, 23 May 2024 20:23:57 +0800
Message-ID: <CACjpba7k2+GS3c+NGgOeP=9=DU8Mh1DFEGUB_WAkX_VFKBBtrA@mail.gmail.com>
Subject: Re: [PATCH v2] usb-storage: Check whether divisor is non-zero before division
To: Greg KH <gregkh@linuxfoundation.org>
Cc: oneukum@suse.com, stern@rowland.harvard.edu, linux-usb@vger.kernel.org, 
	usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org, 
	xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 7:47=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, May 23, 2024 at 07:34:10PM +0800, Shichao Lai wrote:
> > Since uzonesize may be zero, so judgements for non-zero
> > are necessary in both place.
> >
> > Changes since v1:
> > - Add one more check in alauda_write_lba().
> > - Move check ahead of loop in alauda_read_data().
>
> Nit, this changes list should go below the --- line, as the
> documentation asks for.

Sorry for my inexperience. I have read the document and found some
examples but I am still a little confused about this.
I guess this is what you mean?

Since uzonesize may be zero ... (context)

Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Signed-off-by: Shichao Lai <shichaorai@gmail.com>
---
Changes since v1:
- Add one more check in alauda_write_lba().
- Move check ahead of loop in alauda_read_data().

 drivers/usb/storage/alauda.c | 4 ++++
 1 file changed, 4 insertions(+)
..



> Check after the list of variables please, not in the middle of them.  I
> think checkpatch will complain about this, right?

In fact this script doesn't warn about these problems, but I will
adjust my code style later.
But the check in alauda_write_lba() is due to some variable like
lba_offset and zone will perform modulo and divide operations,
which may throw divide errors when uzonesize is 0.
So I think I prefer to adjust the order of the variable list later.
Changes like this.
```c
unsigned int uzonesize =3D MEDIA_INFO(us).uzonesize;
unsigned int zonesize =3D MEDIA_INFO(us).zonesize;
unsigned int pagesize =3D MEDIA_INFO(us).pagesize;
unsigned int blocksize =3D MEDIA_INFO(us).blocksize;
unsigned int new_pba_offset;
if (!uzonesize)
    return USB_STOR_TRANSPORT_ERROR;
unsigned int lba_offset =3D lba % uzonesize;
unsigned int zone =3D lba / uzonesize;
```
If it's ok, I will post the patch v3 soon.

