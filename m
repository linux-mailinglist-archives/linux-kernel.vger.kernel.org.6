Return-Path: <linux-kernel+bounces-326719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3ED976C25
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E1D1F2325D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DDF1A76C3;
	Thu, 12 Sep 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdbztSQ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970741AAE0A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151443; cv=none; b=fihqc+apM63p+FQNyuUr8UE7VROTphlQcjhB0JYA8Em6W9i1HtZclJcw3Y55fJdLTR8PaCKEb2zsPJWYPR8gtF2XRgQy6z3CbEuU2Q61hTTJfs7nDE5QVVulSZ+2BE5HtatKxmt0IdwUImwbusZfoUZ5mecwqhnIHSOZW8BPQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151443; c=relaxed/simple;
	bh=wvkjHwU6VB0mY7Omi2CVeXTzMbkbTdHLFiIfkNgBpC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUHfMeyjftpDfigVHitS6qqpsmq3p08ctZfJg5QgBaDoFBoNXdTYFoKqMTIiEPHxrDTynVG8l3Pkpw2UGx9pPokvuVf5n4DML6wHy5vOdhFtm0BJHezG5k0HcyLFn+e42kwpIVZLme/N2Nhxrp5xpwRJVf2G89UHaILgkTHHNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdbztSQ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726151440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYwbxEfzgjP484q7GbXtyYhGMfu3fb71XeJefeAuTQU=;
	b=hdbztSQ1doVooGS59R9RM18E8vnLWleqOrE0B5Jbm87avN2WYEHhinHDPPsR0HnkJwVp7S
	gxXwf0jTkJD3K1ARiez4ULMW9v0LYaNazjSMQLUiD9zZGSpkvhufn45GShPtNWZEYMC1Zc
	opQXC2QfMPBPEKRklyop6a/Zju5IH+8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-MJ2cdXznNH6C01rolW5f_Q-1; Thu, 12 Sep 2024 10:30:39 -0400
X-MC-Unique: MJ2cdXznNH6C01rolW5f_Q-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f5086e692cso9188001fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151437; x=1726756237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYwbxEfzgjP484q7GbXtyYhGMfu3fb71XeJefeAuTQU=;
        b=uV35dmDnRoRKwctIdJWp/c2Bt/EEBxuzECvrxUoK3XvwP1QUSZqYz7uN4WjLQCbGIW
         nfYlSmjYNJYci/VTTBgt/qc+520LDyaVc0Qq1bJoPNy6AW1ofc98kA28BZBszO3dCNib
         ZJsv7cg3Lcoi08WvL/WyoYylzHsj7tpBghFH1pLmQ/Yyk1r3gdRZqYGaJzYv+TP6mf49
         lXYap+j/9bhvWQdK5EXRlTiaDDh2fQmEZWu+qBmT1uVR6WzllD3E8JlGrhl8/aLMULE8
         jInrtxsDAM3rZRPWOM0URhJ78I7NIJEcx4GumJMTSe9CUjyDG1uaZS5cwzmGl0z4ox30
         lAAA==
X-Forwarded-Encrypted: i=1; AJvYcCV8icCstS68vYEN6vgGdgsEcQChXk/VlSYXpaP61/JOS7D7Fz6vRoSvk10ZlMKTQXk1VMNRNWbEgox4ors=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7aanT3wmPo25yxQGgcdrXnYdpTWv5TgOWNP3Nru/uPO0mvNx
	gsDFgIfRe0z/S9HlR59xMylDERGw5NsseYaDymBFIPpfRESP/ziCvVe+uy/cFMGOqjPv2cExTzv
	4f/ZXid9VakurmNMQH/wHBwPHkesRbUelaSJTXUHxGz3roRU+Qs2ovoBow6jjrO9VZyTNHIYhls
	yYvLMgEgwMkA/3Qq+AL+lK4NJ9Wrq47d3WSYkj
X-Received: by 2002:a2e:b889:0:b0:2f7:8d3f:11fc with SMTP id 38308e7fff4ca-2f78d3f12efmr10488841fa.31.1726151436924;
        Thu, 12 Sep 2024 07:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbg6QnIMTU4ODqKcSnlXW0968zPimhFSBfAuTm7uncIIqVoFMKCU+SvrhTex8/e0gr3QExhr8Cf7ntxBLUD8Q=
X-Received: by 2002:a2e:b889:0:b0:2f7:8d3f:11fc with SMTP id
 38308e7fff4ca-2f78d3f12efmr10488301fa.31.1726151435583; Thu, 12 Sep 2024
 07:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com> <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
 <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
In-Reply-To: <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 12 Sep 2024 10:30:23 -0400
Message-ID: <CA+-xHTEMM09PXgWyKX4h48diUxxGnSSrDowh5Gt=Y+EVhHL-_Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Martin Belanger <Martin.Belanger@dell.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:14=E2=80=AFPM stuart hayes <stuart.w.hayes@gmail.=
com> wrote:
>
...
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b69b82da8837..52d64b419c01 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4832,6 +4832,13 @@ static void shutdown_one_device_async(void *data, =
async_cookie_t cookie)
>   {
>         struct device *dev =3D data;
>
> +       /*
> +        * Sanity check to prevent shutdown hang in case a parent or supp=
lier
> +        * is in devices_kset list in the wrong order
> +        */
> +       if (dev->p->shutdown_after > cookie)
> +               dev->p->shutdown_after =3D cookie - 1;
> +
>         async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_d=
omain);
>
>         shutdown_one_device(dev);

While the race window is really small, there is a potential race with
this fixup. It's possible for the shutdown operation to write a new
value to shutdown_after in the time between the if check and
shutdown_after being re-read and used in the
async_synchronize_cookie_domain call. Such a race would allow a too
high value to be used.

Instead, could do something like:

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4833,8 +4833,12 @@ static void shutdown_one_device(struct device *dev)
 static void shutdown_one_device_async(void *data, async_cookie_t cookie)
 {
        struct device *dev =3D data;
+       async_cookie_t wait =3D dev->p->shutdown_after + 1;

-       async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_dom=
ain);
+       if (wait > cookie)
+               wait =3D cookie;
+
+       async_synchronize_cookie_domain(wait, &sd_domain);

        shutdown_one_device(dev);
 }

This reads the shutdown_after value once and avoids the race window
where its value being changed on another CPU could still cause a
potential deadlock.


