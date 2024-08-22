Return-Path: <linux-kernel+bounces-296629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367295ACFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BC01F23394
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480C5674E;
	Thu, 22 Aug 2024 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnGR8xCo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF78405E6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305350; cv=none; b=qpawo2J6uv1MwpNatKW+DXI7OgWC4nCY91wSbxvHlYYpWXTZegcvHcsPSpf9Hxzh28WrJ539n0JyixvLxqrb0gVS4iM+IADTd0c8FYGCyaggVZ+i2qJlnm689xSgGVoBt3uCcIiVhya7mwaxwX525cl5Rs4iWO8XUfTxWEHMG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305350; c=relaxed/simple;
	bh=F1vzZdH4Kt43rchY2omF6Rwx1ceg2XOFfMB0oV8w5es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGAmZ2fqPGp60YbtpaYICnPTfqRv7quEL2YM5TdkMYaAcJupUE1Uaqk0lWYeUkkawrbC6quzRZ9O3bk2ecoKyvmpvNh2GlUE3DlDH9GNF69oFUrVsuBCxBH0dOwO/Yg/wkD3I6DrlVUFJ2jlaHmNWeU+Bwr6kSl/Sm8uim76Ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnGR8xCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724305347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POmJdiV0VSWZbzyF9DzR22AxZLSfVLCRRZmOGu8DXAE=;
	b=SnGR8xCoV2H79HsGta+Ul1dPdlXZppfwKhCCXjRtQPUCjHH5x6wxQuNTbHWxaspTL49CJC
	TB9nL1jXqL0vU5UgJYR/0v2cT4BM18rM3ru5GNkjCR1Dyr9qXjSio6rGazwfM7C41ZiGee
	3nkbI++tU3WtDFV8n7ELAmeM9ZTWLrA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-enStgC5qNgCan8f8hM7QFA-1; Thu, 22 Aug 2024 01:42:25 -0400
X-MC-Unique: enStgC5qNgCan8f8hM7QFA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44ffe348e70so5693331cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 22:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724305345; x=1724910145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POmJdiV0VSWZbzyF9DzR22AxZLSfVLCRRZmOGu8DXAE=;
        b=dLcY6owsCZZTbW/ah4IumvDqn0kcQt5ZEDxq5ZbalqehBazgjQbrtJ0AptsoA8DMm6
         pImLqL2C4DoB5YRazcTH+oLkSgYtveb9spHWN2BNXje2hokngCdJ8EG1um4uludpQgvu
         0XyZEmxc4J4wOBaFqJ4ZvDu1HaJGeHU8VxX476cf4Acj8jvnJMNjqnCTAHYoG2J5bDY7
         jm7Na762Kfz4X6l0L+YZzExpPOGJqrcm6qzchw/u1t/H4hvOvjHVHAKFIa0CZC4E3zSf
         +Zt2vfPScw+rqTHrORz77yXleV5MeUgk7u+gn0wQao+Pa5MYAm3O5/DJbrp+DWiZUDJL
         ip0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXv6vgYj4kx5DpRJab0mTd0J+Syse8+JaOgb5ZExhivABiWhqcU3Pxp/9PHjfwwt48iPd7mgSIFP22ZQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYk9mgDo+bBcv6W4L6u3NeZQDwFkGXuZupyf7+TigMs6yZu2d
	72C0YR96FzpKO/Da76hmONhvL95TtG46kC3Evv184Z44ACmNQHIPvqqnCufATCuOfREzOvmHnCh
	k5rrEcJswZtphGofsW6ajPYnppBrvqzu4QP+KgQVuWiiSXiR9acV1LVTyjw6A/pJWJUJ3H8Lil7
	8mzmZX4PJAGrJnCdcmeDdbW996NiotIOPQ8yRW
X-Received: by 2002:a05:6214:590a:b0:6bf:6a1d:bd32 with SMTP id 6a1803df08f44-6c155e32b6amr52213456d6.54.1724305345107;
        Wed, 21 Aug 2024 22:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElvJrntPKuDfwVGetI/C58C3ESzxqLa/dqLxQVN4fUwqqoca5WN3EJ+ZSDJ797qfFuc/4TtSX998fGB+XueXM=
X-Received: by 2002:a05:6214:590a:b0:6bf:6a1d:bd32 with SMTP id
 6a1803df08f44-6c155e32b6amr52213366d6.54.1724305344763; Wed, 21 Aug 2024
 22:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
In-Reply-To: <ZsX5QNie3pzocSfT@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 22 Aug 2024 13:42:14 +0800
Message-ID: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:27=E2=80=AFPM Lennart Poettering
<mzxreary@0pointer.de> wrote:
>
> On Mo, 19.08.24 22:53, Pingfan Liu (piliu@redhat.com) wrote:
>
> > *** Background ***
> >
> > As more PE format kernel images are introduced, it post challenge to ke=
xec to
> > cope with the new format.
> >
> > In my attempt to add support for arm64 zboot image in the kernel [1],
> > Ard suggested using an emulator to tackle this issue.  Last year, when
> > Jan tried to introduce UKI support in the kernel [2], Ard mentioned the
> > emulator approach again [3]
>
> Hmm, systemd's systemd-stub code tries to load certain "side-car"
> files placed next to the UKI, via the UEFI file system APIs. What's
> your intention with the UEFI emulator regarding that? The sidecars are
> somewhat important, because that's how we parameterize otherwise
> strictly sealed, immutable UKIs.
>
IIUC, you are referring to UKI addons.

> Hence, what's the story there? implement some form of fs driver (for
> what fs precisely?) in the emulator too?
>
As for addon, that is a missing part in this series. I have overlooked
this issue. Originally, I thought that there was no need to implement
a disk driver and vfat file system, just preload them into memory, and
finally present them through the uefi API. I will take a closer look
at it and chew on it.

> And regarding tpm? tpms require drivers and i guess at the moment uefi
> emulator would run those aren't available anymore? but we really
> should do a separator measurement then. (also there needs to be some
> way to pass over measurement log of that measurement?)
>

It is a pity that it is a common issue persistent with kexec-reboot
kernel nowadays.
I am not familiar with TPM and have no clear idea for the time being.
(emulating Platform Configuration Registers ?).  But since this
emulator is held inside a linux kernel image, and the UKI's signature
is checked during kexec_file_load. All of them are safe from
modification, this security is not an urgent issue.

Thanks for sharing your thoughts and insights.

Best Regards,

Pingfan

> Lennart
>
> --
> Lennart Poettering, Berlin
>


