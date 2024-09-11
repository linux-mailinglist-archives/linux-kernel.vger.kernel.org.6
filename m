Return-Path: <linux-kernel+bounces-325007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8E39753D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674CD1F23E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0084C1A2C25;
	Wed, 11 Sep 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwzVRlPz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17B1A257F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060900; cv=none; b=q7MLS5X7RXOrv7gjGN/MesyK72OcmJl8sS5pS12JD0KRvyH2LfLoK4kRy2oVZDVVJO2RbOOY2z/D/sUpJDgUO7TRiFRiec1QXnc+anXPLGDZl3OxnNv/HKcEuXsRlxOzYiO4nDM19VrUJ05AvmhDwDEEWFuHsJ92zQBEFPSWs64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060900; c=relaxed/simple;
	bh=uzgBwk8fDv4vrbhQ6JMRScWSxp9E+Y7lOeqjN7i0Hmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpUx6shwyh9dU/Bv7lCT/5bOElNj7n5KHIRnYkRxP5mn+Nz+2Qdk2eAiRHyZZ9im/L8IlYphlFyt3osAb5pCnlR/42ModFqw5X0JqOaInHqwFgww8LLOzjHOwjEAADg/O2UlL9bbcE6y8XOAmMRQ22tVbHo580VVAR2xHvQ704A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwzVRlPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726060897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUp0+vKj46QzTJpymXewxcq+r1OcyQKVigOaH5OB8Rg=;
	b=FwzVRlPzClYWO9w9ZJvcY/R17Z/q4tk4g09CJVTkL9IvCuhLcyOcsGi9F3cuvA9Ox7baUJ
	T4+CRpRh74Qutsr5jMcxAtbSqs9ASGQBO5Ll9fhTgNunhNHEkFloE1nZNlcLxgMq4B2uai
	bkwkIVr1x+P/Mv7z+AkQ5oaRWVYg7S0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-8-6LycMsOU6R4iVC4IyqzA-1; Wed, 11 Sep 2024 09:21:36 -0400
X-MC-Unique: 8-6LycMsOU6R4iVC4IyqzA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so15632665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726060895; x=1726665695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUp0+vKj46QzTJpymXewxcq+r1OcyQKVigOaH5OB8Rg=;
        b=JILG12kGeCX5sjS6td+2cRTMKj5Yt2xX6Tu90FQ2KyS8J8psyEHtObim3xJ5AU21T8
         MJcMTzEnjPZ6cd9dAwDnEIv4rnv+C2OzdRY0jR5kujXhczAh/Paw++aWLw+0SxspWYFR
         7QIRYlSjogfH4Pm7vK9NRFH+T8oWbm0jMj8HBbUiX4nKtMKODifwhrh1YrcD5Zb/OymL
         E4ap7CwYt5rX6OG+sdfVCxIfQKINIw97oOb4RS8FH9iiUvbhatmiQNLRqCmUgmbDtne9
         S2jDLnNQP3EkBSl/J708cJzamfIUqhyDl7kNrXtA4zjhe+WAD/vI6/H8hJ2tVmFEN/FQ
         BJlg==
X-Forwarded-Encrypted: i=1; AJvYcCVQDmsbVIzlaYrKtCH/Xcw/LJABazPJNgZgy7T5ZP4pFyfK34b6CkG3rS2SusNs1DvlXZdMaDUFAJRGsuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9W1hTsoE+2pso8IYLOUnDKLCogEcTuMhsUWrPSp1axKah+ak
	5tqE3dGYUu385qVUAPfDyeEm1dxKaJ4o5R4i8MSrGuKi2UQ3CdNO6cfocS+ECFDaCQ+t1L8luKM
	ABm5KN2AoGFsLY11Rw2WFmKWGaN0afAUCcvPbsFG2W50af++czeLxOZRCsd4TAw==
X-Received: by 2002:a05:600c:1c06:b0:42b:a9d7:93 with SMTP id 5b1f17b1804b1-42ccd35ad4fmr23464795e9.28.1726060894865;
        Wed, 11 Sep 2024 06:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0mLr0qMg3MPTkdh+vXATBEx6fiAHYclLoKaceiQpiJ8kCVq4XaEUJhF96h2BsFFN80TIf8A==
X-Received: by 2002:a05:600c:1c06:b0:42b:a9d7:93 with SMTP id 5b1f17b1804b1-42ccd35ad4fmr23464235e9.28.1726060893936;
        Wed, 11 Sep 2024 06:21:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8644sm11551998f8f.114.2024.09.11.06.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 06:21:33 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:21:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240825052923.715f88bc@sal.lan>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
	<20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
	<20240825052923.715f88bc@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Aug 2024 05:29:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 19 Aug 2024 14:51:36 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
>=20
> > > +        read_ack =3D 1;
> > > +        cpu_physical_memory_write(read_ack_start_addr,
> > > +                                  &read_ack, (uint64_t));   =20
> > we don't do this for SEV so, why are you setting it to 1 here? =20
>=20
> According with:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic=
-hardware-error-source-version-2-ghesv2-type-10
>=20
>    "These are the steps the OS must take once detecting an error from a p=
articular GHESv2 error source:
>=20
>     OSPM detects error (via interrupt/exception or polling the block stat=
us)
>=20
>     OSPM copies the error status block
>=20
>     OSPM clears the block status field of the error status block
>=20
>     OSPM acknowledges the error via Read Ack register. For example:
>=20
>         OSPM reads the Read Ack register =E2=80=93> X
>=20
>         OSPM writes =E2=80=93> (( X & ReadAckPreserve) | ReadAckWrite)"
>=20
>=20
> So, basically the guest OS takes some time to detect that an error
> is raised. When it detects, it needs to mark that the error was
> handled.

what you are doing here by setting read_ack =3D 1,
is making ack on behalf of OSPM when OSPM haven't handled existing error ye=
t.

Essentially making HW/FW do the job of OSPM. That looks wrong to me.
=46rom HW/FW side read_ack register should be thought as read-only.

>=20
> IMO, this is needed, independently of the notification mechanism.
>=20
> Regards,
> Mauro
>=20


