Return-Path: <linux-kernel+bounces-566387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6F7A67732
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7576C3A5F92
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EAF20E6E4;
	Tue, 18 Mar 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR88Sif0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36720C026
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310131; cv=none; b=iLBOwPMmU4G6OJZ/AULh0+Xb9HwECctr/K2MyndJi45qKl5lj5v4G1zFCOafaVbFKAV5eOwoN+5X3a2w42zu3atfROv1zZjqfHL6VxzWDo2vEL4EFsgMkfWSZQyWF+Pw9cx+AnqG1G+Gv+/4ESiVUsK+8jByOsLMK3qH8THsp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310131; c=relaxed/simple;
	bh=NeRQV6sfvbTorj7f26S+KJdYMGp4UY/s/qd3Ja4u+tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ms9L5kvzoEES7Nj9KFzy6yYb2bF/63yme1gAexpyMcJskOb0cmEt8PVX/PSxgjdcokh216tOAgmv8KJLkw+6eccWPXlMJWfpsx4SuCp86iMhqrtigF+Bn6CDgXmS0/SVIfISBeMb7qQpNuRKeYDKWV/6tfn5i2mb6PknVm1JIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fR88Sif0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742310124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4YD2sf+w7TG9LkPdewhHv9XVtamWwqRcBK8ja6UyyY=;
	b=fR88Sif0zRjFafuQWpU/IFQ/JEepqGrU09on8fZRu88uk0pWjU70O9iHiVnDp92bsnA8t3
	Jf2wM1n6y46qMymO7fP1hrVXz4EpBDb91XZKNWNl+3vMz7Da+bWYGx8nGp/k7hBeXReRGD
	XK2eWIBA92VLlx35cSc96vfIfbAZITA=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-baTfV4exNSa48w6SYvJGvQ-1; Tue, 18 Mar 2025 11:02:03 -0400
X-MC-Unique: baTfV4exNSa48w6SYvJGvQ-1
X-Mimecast-MFC-AGG-ID: baTfV4exNSa48w6SYvJGvQ_1742310121
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce7aa85930so8537715ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742310121; x=1742914921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4YD2sf+w7TG9LkPdewhHv9XVtamWwqRcBK8ja6UyyY=;
        b=AMwJJ1ADQStNX1zLa4yOlDQrqwxnyRqD9tdctHNZ3/kQCtq4dYxeRl1ctmI6R9JBKP
         w+G8tQ1kQ1mQd5fbfaBH9r6zNqzEjCrQgHBUcbG2mQh9U7Q9yBN/OYCef/oPkQ1+Sbe/
         zuElglJIJuMZpV2aHYNaNN+jkhEAf+Uc9ELYTG2As2QNpcbKPPfR9WEh0IcViQuQeKqZ
         uGyYI6NMd+rrPU4jqdl17QM5ff7T94Je2KCVBzCjvRpNByZCogpZ+xZa2gAJW1Xk7brI
         s/ZqLw1bDjPe3XqYThdBvJhbFN+NtZW5+SHe15B+ACu6ni/R5ZKiGexe15VBcE2NBwPx
         5z4A==
X-Forwarded-Encrypted: i=1; AJvYcCWi8ltqiiGEX3zZxEj9ue2HrpOKiAxZXalW7l443M3sLYsiqCqMB7dgnNA38TA4o8Joeqw/7Ad2rPeYi8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFKPju5VyeXmHUs2pvjrklW14OQ71J/gKsUaxjw99npbrcksX
	/MQMAYxJMa0+D4rEF29rjK/jwM21cH1VaYJcj7p02AkBf/fDSdg3mO/lRLPxpRwVzFFSGY3TvQf
	as9GtWidodBZEHA2qVxTuXjtzDU03WzUYxwo9KCM+s6SWypJ3gjGYuMES8EIJ1A==
X-Gm-Gg: ASbGncsED9yylZyQkFB5XFCjhitjPjfN9SMHkUEG60JyQxeJ9zrTypbtfrC3vMR3Rzz
	MyMjQVgND3hVHyqguRF4AGnWV6d1LUJqaTMc5Yb3IWhqFxqV0CZy3AhAL4mWOkwKvYNNRhHUW5Q
	8x5RQnbR3knFwpGBhaG7nk0HlITFfNWtSixiZk6PP2FdhLOE1D3JEtE448qy2A/csL5TE9cIGp9
	SqZeAg1TO/4L58u+Ck+pfkGuLxNVk4DH60g4m3o5CNST1QlA+lqJh65I65B6nNf5JtAe7ZX/VnO
	WvzYlmrlIFOidhxLhPs=
X-Received: by 2002:a92:cd8f:0:b0:3d2:b3ad:8491 with SMTP id e9e14a558f8ab-3d4839f5b51mr45017935ab.2.1742310121228;
        Tue, 18 Mar 2025 08:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgEcLIWZMtQ3F020b/3FknCQq+tiAONkCx2hpltju6JhikxxWuBUauM9d3Fq+6ZXXyItoDnA==
X-Received: by 2002:a92:cd8f:0:b0:3d2:b3ad:8491 with SMTP id e9e14a558f8ab-3d4839f5b51mr45017785ab.2.1742310120858;
        Tue, 18 Mar 2025 08:02:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f263816ae0sm2795939173.119.2025.03.18.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:01:59 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:01:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, =?UTF-8?B?TWljaGHFgg==?= Winiarski
 <michal.winiarski@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250318090157.525949f9.alex.williamson@redhat.com>
In-Reply-To: <ea24cc36-36c7-1b28-f9ba-78f7161430ca@linux.intel.com>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
	<20250314085649.4aefc1b5.alex.williamson@redhat.com>
	<kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
	<20250317163859.671a618f.alex.williamson@redhat.com>
	<ea24cc36-36c7-1b28-f9ba-78f7161430ca@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 13:42:57 +0200 (EET)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> + Jakub
> + Alexander
>=20
> On Mon, 17 Mar 2025, Alex Williamson wrote:
> > On Mon, 17 Mar 2025 19:18:03 +0100
> > Micha=C5=82 Winiarski <michal.winiarski@intel.com> wrote: =20
> > > On Fri, Mar 14, 2025 at 08:56:49AM -0600, Alex Williamson wrote: =20
> > > > On Fri,  7 Mar 2025 16:03:49 +0200
> > > > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > > >    =20
> > > > > __resource_resize_store() attempts to release all resources of the
> > > > > device before attempting the resize. The loop, however, only cove=
rs
> > > > > standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that =
are
> > > > > assigned, pci_reassign_bridge_resources() finds the bridge window=
 still
> > > > > has some assigned child resources and returns -NOENT which makes
> > > > > pci_resize_resource() to detect an error and abort the resize.
> > > > >=20
> > > > > Change the release loop to cover all resources up to VF BARs which
> > > > > allows the resize operation to release the bridge windows and att=
empt
> > > > > to assigned them again with the different size.
> > > > >=20
> > > > > As __resource_resize_store() checks first that no driver is bound=
 to
> > > > > the PCI device before resizing is allowed, SR-IOV cannot be enabl=
ed
> > > > > during resize so it is safe to release also the IOV resources.   =
=20
> > > >=20
> > > > Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, whic=
h I
> > > > understand is done intentionally.  Thanks,   =20
>=20
> Thanks for reviewing. I'm sorry I just took Micha=C5=82's word on this fo=
r=20
> granted so I didn't check it myself.
>=20
> I could amend __resource_resize_store() to return -EBUSY if SR-IOV is=20
> there despite no driver being present

I probably never really considered resizing BARs for an SR-IOV capable
device when adding this support originally, but it seems valid to me
that if we extend releasing resources to the SR-IOV BARs that we simply
need to assert that SR-IOV is disabled and fail otherwise.  Thanks,

Alex


