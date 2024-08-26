Return-Path: <linux-kernel+bounces-302256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0DE95FBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D3C1F22CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5C19B3C3;
	Mon, 26 Aug 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDYP5E7b"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6C199FA7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708138; cv=none; b=ANdmsZP7Sfy275wV3yT87KIPU477OwRwIbF0SUmg7txxmUPk3N2kJoId0k+bE9wB+j6u39cQz/XDFdWZgPNjVY/qA8F0GGtL3/AZmD53gvKmTX4IQjwAzxD9Xy10V/hwFX4WDONlEBAHrLQV6/6tSDBZJHfJc5EXhIxBkAx6MEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708138; c=relaxed/simple;
	bh=y3bTwWiAvBcr8xpfUU+F1eoqSM/33mMGjdhkV+RrYk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4j53a/Pu+o19wCdGzsSXTeGUDwyZIRPtgQHr9PUgd/3cUE3j9aAgb4w4sWvupzGdc17n2VzoZP9e0j/SVAwijGkpIdKP8KhQkJ0YshYdT8Ward6xZrtMXpj76U3kkPgOaWfKoh/nEpBUi+85xq7orw9pDBqqq0poybbRQAy/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDYP5E7b; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-842f91f2545so1293358241.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724708135; x=1725312935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XeMKiOOWPXVPZaxetALQ00I6J7fyRUHujLp8LvoZwXg=;
        b=eDYP5E7b9uHjPl9WPg4kvWYsXffcLOG0UtNOBgn8KrzRYwX3OuDlp76nyVL4jt9MHK
         9XKJ+tDRXfvIyfBoLT8q7uBgtJqfZncLXL3fllTS/9S2d9UBGOrO12IFW0jhmaXSAv+B
         8jrYfIePw8FbqBcEnifhIW8+1pnU3AUv+vICsdOAre1o+QgjKTQYFXdD/gFoquwCqpla
         yrEzcOLjSpsj0Q4dpa6immvi2QZenH95nsROwbPBn7mVGXr0vDkEUFszgtjd4ud5O5di
         QuezaNAJLx0aI34lkBQsabGircPOXPuGgsFi41BFzBkjrCCnuu9le6OuPUURVhkWhWOp
         gRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724708135; x=1725312935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeMKiOOWPXVPZaxetALQ00I6J7fyRUHujLp8LvoZwXg=;
        b=cbO83gZLZ4Dwrb3TbqE1Mu4//iXe838SufBx3iIVEcNPGPvwZnHXUKZaRtFQ8oMu98
         nF871BgI1ky781phWTWTS7b6t8QCikSNuaNnhomqzFX3KO4a+PbvZG1fJgq4UKTbnBQs
         v434xoWldYlM2q1gCc379x1LMdYL2PRE9GDqwQm5f5RF0i7NjznvCc3mnvudWLpyCEa2
         CYhqX9G3jZqW5cPZ8NM6ra+zh1+6CQyNFNw8sWAxrreMMIpbyZaiNY2JPy15uXDuJDPG
         hOPW0mZYv/+C21khgY9OOKtc9g8T8RJvvzJOcsHSWyXMYbpXzbpx8jss1fx95akwp/R1
         Uxsw==
X-Forwarded-Encrypted: i=1; AJvYcCU2HuwYDiLay6SeKPlF6G0ORdnMeu1W/tabKxPGwcArlZ9Kn4SympvnxOHDODAx2FIgv6NAlY1QatJxgZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxhEBiMEJt+9gOCHQsA3YCqX7U0bvacpl4skav06B4VyFqlYl
	ZbGmPbTFJKj4ysNMDfHznszqhpDNTieigW6FFWSnfx9ko3mIBbmroz9OAajPNpfBEKypHFYspaa
	qTW9W2IW5Q1EkBkHZBXMoRrXMC8R9KioNCKVG
X-Google-Smtp-Source: AGHT+IFahHCeuJlDlaa5/eCHItPH4qVMJYdtrrT4au2DWbduZ36ZOWkktQQxYZjPExV2o/UzTy6gpYMEXZF8JXmpOv4=
X-Received: by 2002:a05:6102:4427:b0:498:e22a:433f with SMTP id
 ada2fe7eead31-498f451fb7bmr15509004137.3.1724708135341; Mon, 26 Aug 2024
 14:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814205303.2619373-1-kevinloughlin@google.com> <0bae453d-b4a8-3132-9fd0-bca0eece6a74@amd.com>
In-Reply-To: <0bae453d-b4a8-3132-9fd0-bca0eece6a74@amd.com>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Mon, 26 Aug 2024 14:35:24 -0700
Message-ID: <CAGdbjmLVFZJq7OJv2OwM3knmwfb-j8nZP7G_ownFA3kd3fYbVA@mail.gmail.com>
Subject: Re: [PATCH] device-dax: map dax memory as decrypted in CoCo guests
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, changyuanl@google.com, pgonda@google.com, 
	sidtelang@google.com, tytso@mit.edu, pasha.tatashin@soleen.com, 
	thomas.lendacky@amd.com
Content-Type: text/plain; charset="UTF-8"

> How can I test this? Can I test it with virtio-pmem device?

Correct. Assuming the CoCo guest accesses some virtio-pmem device in
devdax mode, mmapping() this virtio-pmem device's memory region
results in the guest and host reading the same (plaintext) values from
the region.



>
> Thanks,
> Pankaj
> >
> > Signed-off-by: Kevin Loughlin <kevinloughlin@google.co > ---
> >   drivers/dax/device.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> > index 2051e4f73c8a..a284442d7ecc 100644
> > --- a/drivers/dax/device.c
> > +++ b/drivers/dax/device.c
> > @@ -11,6 +11,7 @@
> >   #include <linux/fs.h>
> >   #include <linux/mm.h>
> >   #include <linux/mman.h>
> > +#include <linux/cc_platform.h>
> >   #include "dax-private.h"
> >   #include "bus.h"
> >
> > @@ -303,6 +304,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
> >
> >       vma->vm_ops = &dax_vm_ops;
> >       vm_flags_set(vma, VM_HUGEPAGE);
> > +     if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> > +             vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> >       return 0;
> >   }
> >
>

