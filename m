Return-Path: <linux-kernel+bounces-293088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0A9957AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5246D1C2347B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFDDDA1;
	Tue, 20 Aug 2024 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr0DbFsa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63A2F52
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115499; cv=none; b=c5HDvfNsT7CQVMZTB6vXLY+0NYxxOzoZcFw1RFQ5BBHGjhOHtAfQ3iZhN+SqWXTdxM8JlmdXB6JkKnxpPzBtTFuLSLzdHPmsHVZXrKiz++RGyc2YHpEF3YAfD4yD3iXbHZ8xGFNoc3kaGXVMZ1yBll4oN6cRTSYR5smot4bWd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115499; c=relaxed/simple;
	bh=0VoB3F+f1M56dPnDJTyh/ZvXxKagqoILbksn7eR9ay8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhCPIrHAXbvtzS+iv6p/+SDnrRzIOZu7BEFOsXhxTc4gVSKtaGyCQhOWFvPR07RdoFb7KhKMehuLGZ2jWpPVDSYalNfCgYUzuiNpkWkra15Vl+R9AvMsJov5vnRsuDOcvMgLDV+jMDaBg/ccLexHHkLmgfp34b8UC2zbOPSEdgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xr0DbFsa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724115495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Op+U6UEfg5C/ACRy0vig7Q1iaemd/rbZGUWcAuZTPyw=;
	b=Xr0DbFsaE6/87prB1GRpKt6aWRjRwZEaV+X45Oneeqk7uFXqQpQVNnMasa/y3m8TGQmKEe
	h9Tm+ycLuzj0C8w+nvR+Rm6XmE7Gog3R8GOdhQE7uhYkGrXyRdCqgstlnv9nT+cMLkKKqx
	8GOvDIMVAzXZ/Rfud5PAOVgxyyZNgU0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ZJPhP0g6MXqmQoecNAitzQ-1; Mon, 19 Aug 2024 20:58:13 -0400
X-MC-Unique: ZJPhP0g6MXqmQoecNAitzQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6bf7c72871bso46810426d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724115493; x=1724720293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op+U6UEfg5C/ACRy0vig7Q1iaemd/rbZGUWcAuZTPyw=;
        b=xErbqpfg9zSho1g8mq5g0BfLbnjkhfqd80XNlFNfoQTzRQn4O71Eokp/J0T/kp7Q5O
         +zlkuom90Auxa3gQjXvbuGu338cFb02lODAQsEWEXwU4cdgc7ttmtd+UQHHRykI8Wv+T
         9loif8wuuayAD9Wlx32RQR4Kx0bFJp3zN0Gh85/Lm9rzyxHpqd83ne5l+2NmaQSO9eVF
         9zfEuFlRomIafHCqcr3I2Rs8WD/s2bWX5i62XgmpFKeDqhVHNtXVJWESBn9Fu8J/t+7q
         AvPjo7GUYCfGWxWPqjBJTU+ErbjtG++Vi4Q01xlIyeECPw4yKWkUCHVAK8a3zrvOlfQ3
         edlw==
X-Forwarded-Encrypted: i=1; AJvYcCXO7DMe8KPKu8mnI3YWC9GfKP/knlKrpdn89lYHYSU11IsbnQ9UqFVQy6R86/1ptsPORde6FJS1UF6l6hOYIANo64pE3FAptCWcu3s7
X-Gm-Message-State: AOJu0Ywo72DtO9mTxgUQ++gNmZFhNRRPiV6UHl4MY+3YQp7eKOtHT8L5
	mZ37EZhhCMKfAjbdZHcC9c+GzJi1WyDJSo4MJ4KpwB0Ydd5CZ8jZ4hH9HwM/oILOK7iurGjUa5P
	jVxwb+X+0+utztSWCW/VqWe48CS6RbxeBoEbr1rFRcl9OcIcebOb6+c63U8lbQFAjjVAnZeaDTL
	CED6tK1iCmMArD4RkD3Nw7KBJmOZ1/y0nNotb8
X-Received: by 2002:a05:6214:3d98:b0:6b7:980b:e0ac with SMTP id 6a1803df08f44-6bf7ce06a55mr152731036d6.32.1724115493019;
        Mon, 19 Aug 2024 17:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0xEAdTPZqQ0R37bhm+bI8tZ08r0K84Li3rZ/xKsFzl+U1c+/gTnEWiG6hFEZE3WA3cmHWfdPmI8H8H/7457I=
X-Received: by 2002:a05:6214:3d98:b0:6b7:980b:e0ac with SMTP id
 6a1803df08f44-6bf7ce06a55mr152730866d6.32.1724115492656; Mon, 19 Aug 2024
 17:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <20240819145417.23367-2-piliu@redhat.com>
 <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
In-Reply-To: <D3K31JJ5PZQG.2XW6Y6OR1CTLG@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 20 Aug 2024 08:58:01 +0800
Message-ID: <CAF+s44TK1RZ6m=b3RX_KTsptRQ06XZO_knn3=39eWXLv64AxoA@mail.gmail.com>
Subject: Re: [RFCv2 1/9] efi/libstub: Ask efi_random_alloc() to skip unusable memory
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Eric Biederman <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:00=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon Aug 19, 2024 at 5:53 PM EEST, Pingfan Liu wrote:
> > efi_random_alloc() demands EFI_ALLOCATE_ADDRESS when allocate_pages(),
> > but the current implement can not ensure the selected target locates
> > inside free area, that is to exclude EFI_BOOT_SERVICES_*,
> > EFI_RUNTIME_SERVICES_* etc.
> >
> > Fix the issue by checking md->type.
>
> If it is a fix shouldn't this have a fixes tag?
>
Yes, I will supplement the following in the next version
Fixes: 2ddbfc81eac8 ("efi: stub: add implementation of efi_random_alloc()")

> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > To: linux-efi@vger.kernel.org
> > ---
> >  drivers/firmware/efi/libstub/randomalloc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmw=
are/efi/libstub/randomalloc.c
> > index c41e7b2091cdd..7304e767688f2 100644
> > --- a/drivers/firmware/efi/libstub/randomalloc.c
> > +++ b/drivers/firmware/efi/libstub/randomalloc.c
> > @@ -79,6 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
> >               efi_memory_desc_t *md =3D (void *)map->map + map_offset;
> >               unsigned long slots;
> >
>
> I'd add this inline comment:
>
> /* Skip "unconventional" memory: */
>

Adopt.

Thanks for your kind review.

Best Regards,

Pingfan

> > +             if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTE=
NT_MEMORY)))
> > +                     continue;
> >               slots =3D get_entry_num_slots(md, size, ilog2(align), all=
oc_min,
> >                                           alloc_max);
> >               MD_NUM_SLOTS(md) =3D slots;
> > @@ -111,6 +113,9 @@ efi_status_t efi_random_alloc(unsigned long size,
> >               efi_physical_addr_t target;
> >               unsigned long pages;
> >
> > +             if (!(md->type & (EFI_CONVENTIONAL_MEMORY || EFI_PERSISTE=
NT_MEMORY)))
> > +                     continue;
> > +
> >               if (total_mirrored_slots > 0 &&
> >                   !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
> >                       continue;
>
> BR, Jarkko
>


