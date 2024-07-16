Return-Path: <linux-kernel+bounces-253797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00091932722
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9632836B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA919A87E;
	Tue, 16 Jul 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdzDU6Ym"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0701448ED
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135426; cv=none; b=e0xRSwRDG0roW6P1F6yefVmtCT8cLgxDSNYG+B9YrqAG+L9KBumQ+zHzS3bIz3O7icdpghLw/S5jUfGr6epgQI0rVpRY3yyYStPfyoAbbMctCJYqqG2zG164raolS9xsGjByZIRNxj4MIuMFO5Ppa61COfZQA7fSGkodAhfpgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135426; c=relaxed/simple;
	bh=GpzScpedIteht8jhFd7VYb19IPxE1c/uuH6Qu+Gk9Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5Qr9hoaB27nWGDb12IdeX46zh5lQpbdFY3ll1J2BAh+owNTXzJAlV0riAra/Whxteb/Knp7s4+beTXWwiR/B/99OdMzcZYbfJwBbdmQBBZx/qmJsdxSGjbw1uPj7ipgA5l1jNDELCAnUYu0utXGpB9dTjNhxibwlcRUHyGl290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdzDU6Ym; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721135424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpzScpedIteht8jhFd7VYb19IPxE1c/uuH6Qu+Gk9Fc=;
	b=MdzDU6YmnjxA/BPqN4A2tzroMnRW/HfclIMamTDJePpi0CLfSAY0ktuam55nXCexxXUeDq
	5gMxqk3N+UESaSe0AfSrws2iw/Aq/ZjZ20JPicSvUPPxjGLKEhQfwkr9FjtLEZodDipz7b
	eD8AkDprwf2fVKKxBbjea08cvy7TT2c=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-oqeZXyfQNIWa6AiLYqsFyA-1; Tue, 16 Jul 2024 09:10:22 -0400
X-MC-Unique: oqeZXyfQNIWa6AiLYqsFyA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee8e0dab26so49897581fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135421; x=1721740221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpzScpedIteht8jhFd7VYb19IPxE1c/uuH6Qu+Gk9Fc=;
        b=Tn7dnQIbvuAKys03m300/PdXSi04mEt2Do1vWD5sysf4+JaMYPvvOBZas+VGHsuP3T
         3CL5InhbX+mfFwLq4Aq80xk2O+rARA22DayBu+qo5pbpIMXrKzDs8+zH5g0lKayyyMEl
         j7DIw3edN38zwM//HxVzBQWo43uDvfzq3KOVUvvISYQAhwR9RHDtPbBHFzu4kwyhKtua
         tOkhNuClbvFgtfhhtvuEdI0V/Q1AFqYmt87bN4qvbjbPM31U+j/JQDQWI7Hy8gzryVa4
         MWw2LSgQu33X1Nhr4EYHHhROHLNpxfAHL6TVy9lRUxqZMKfZpnFQf8E+XBzD3jknzHcb
         nA+g==
X-Forwarded-Encrypted: i=1; AJvYcCXT8BvKeeibliKIzsUPRCXSlhRJ35nNj2J+LBa1K/EnosckNYrH/wcRdxZEjiganBrAeqt2rTSBPoUvXIRfGVBMx0S7dyVGjs76TYVQ
X-Gm-Message-State: AOJu0Yy/T1mEuu3zjsPVFSFtGyfmx+MmyxRDdV0CCiIN1ROQZnU/pzRy
	GwVd+C3R2e8n8T3JAXRaXFQ17ov8lWnLWBra6z8K5BiWIRvo5zrEzLixvPOVETi5eQrV7e25U53
	S4UfDPuC6VQp5rVxASoA2vW/OLwMOTTUyAVcaNzqbGjJPDQkJ+r/QJARAZ3Sr64+EDe3pUhe/Q8
	QZN31FsW0aSznzW2txtDa8GJSHf0Ysm+qWmvy7
X-Received: by 2002:a2e:be05:0:b0:2ee:8b92:952f with SMTP id 38308e7fff4ca-2eef40b2fcemr15945921fa.0.1721135420990;
        Tue, 16 Jul 2024 06:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0+2ysOJp9MP5ZxmZgy3Wn0oI5vGQOyK2l9FcQNTEYAB8b/kz09NzAswEUe82pE7C4WMswef/74L9f5BSYjlo=
X-Received: by 2002:a2e:be05:0:b0:2ee:8b92:952f with SMTP id
 38308e7fff4ca-2eef40b2fcemr15945781fa.0.1721135420605; Tue, 16 Jul 2024
 06:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK-6q+jSBjuFaFqGLQcfVLMUwRcJJMHk2oUnSgMObwz+OAih6g@mail.gmail.com>
 <3353d6c1-54ce-46c0-8b65-a0383c8da324@163.com>
In-Reply-To: <3353d6c1-54ce-46c0-8b65-a0383c8da324@163.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 16 Jul 2024 09:10:09 -0400
Message-ID: <CAK-6q+gvhDSrzUyHB=KAw=hMco5BAHxbXuhVYLdzHm12JEJG1g@mail.gmail.com>
Subject: Re: udev kset_create_and_add() with own struct kobj_type?
To: Lk Sii <lk_sii@163.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gfs2 <gfs2@lists.linux.dev>, 
	David Teigland <teigland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 16, 2024 at 8:15=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
>
> On 2024/7/15 23:27, Alexander Aring wrote:
> > Hi,
> >
> > I am currently implementing namespace support into the fs/dlm
> > subsystem. The DLM subsystem uses kset_create_and_add("dlm",
> > &dlm_uevent_ops, kernel_kobj); to create the "dlm" sysfs directory.
> > Underneath it creates for each lockspace a subdirectory using
> > kobject_init_and_add() with a non-static name and being known during
> > runtime.
> >
> > Now I want to add namespace support and need to change the "default"
> > kset->kobj.ktype =3D &kset_ktype; that is set by
> > kset_create_and_add()->kset_create() to my own kobj_type because I
> > need to implement a different ".child_ns_type" callback before
> > kset_register() is called.
> >
> you maybe use kset_register() instead of kset_create_and_add().
> you maybe find example codes from below kernel files:
> fs/nfs/sysfs.c
> fs/f2fs/sysfs.c
> fs/ubifs/sysfs.c

looked into the first one, it looks like potential new users for such
a new helper. This is what I am currently doing and it works, but I
mostly copy&paste the code of kset_create_and_add() just to set a
different "kobj.ktype" in the kset and feeling bad about it.

Thanks.

- Alex


