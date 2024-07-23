Return-Path: <linux-kernel+bounces-259852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80183939E39
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275241F218B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB214D435;
	Tue, 23 Jul 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL7wkTfV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B014C5BD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728181; cv=none; b=LC4MEbWaSUkp8ymblV09tmUTXvcg9xbRLBREjZWkrkHYc6zS/hvNr3AcnJCwL6+49VgyP+a5IGrZHWkiyY2+dfz4SvVMMMjO96xLBqwiHmP90/3AxjeF5Qxqsj8fWwNZDiSqAR54m8GoZQHA5S2GcQS/5DFSh9nYJPg5Y99Mg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728181; c=relaxed/simple;
	bh=JDGXIr+0gl3av57yXr72yYr1CLkdmerO6ZKmva4pkYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s17VJLQbhVLxNVA3tH4y0SKQVzL1z+xVPtZb9s1Nc0EkCAsZNf5JFMeI5S55IEfHqqXWo7CBbXQdHlJFW8q8lfUgobXUlLJwDeC6B3Dpn2tWA06Mhi3FL6NaOh4F5WCXlQV/XPi3Z19T1bmk5JR9/CFxLAzQtVO4EYerAGz92pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iL7wkTfV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721728178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTUKsuAlDi0iSYRC+we38+DtQsnQSdSQdS20sVQC7cY=;
	b=iL7wkTfVNGFNgnYAGyf4wToaQC0FL7Fq3eW8ylMTf+sqCbvnolthnEZ62cyUwzEf0xHA88
	9av3EQMlk5rdPtd56EQWsJk3p+qVXEWg8VPoEatEGWt6txJT03Z/g1b/bVFKOL8M0a8USp
	3p8lHAUKFbVoASIvYaCW+1E+GfwM6mg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-AHDCPxD0NmOPvv7KtSXNbg-1; Tue, 23 Jul 2024 05:49:36 -0400
X-MC-Unique: AHDCPxD0NmOPvv7KtSXNbg-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5ce5595efcdso4325759eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721728175; x=1722332975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTUKsuAlDi0iSYRC+we38+DtQsnQSdSQdS20sVQC7cY=;
        b=YARy569DFiJcl5IPMWyDsSzbCvV6aQMH9X6H3dYq4unOrbNCGzhGQFAcIn7JUyl40h
         N2ShFelePiLbAK3y3LL0iN2LIylg6yXsKEuiNY38rOONVw+MUsf5gV/Z4r9ksnyDYRKG
         eSApPkcXXH1MPPDe6mnRMaS6SgeCRbVvkrXFPC81YJgunrHqmjdlCG3dvw5hc3mydQZp
         HfFhi6qKvA52alp+gMV9VnsIDenFWHbRuMs6O5VHsXUcKIwFPdlXOC+DgBy2ZP9fbelL
         ey5K5F6p827Nyo5JVB7/YD+l3cuRn2bcb1a/ds9zbudlhucWGhJtKlD7KFXnBSVUoCrO
         8Ayw==
X-Forwarded-Encrypted: i=1; AJvYcCVIqvG1dVYCL5PTwPEfUi2SBENvDtV/5WbLTYUIXYDOLr7HeCFHOCcvAyxUfJG+/uW6DqVcOSlPcYS9zKKzqakrDuFbhmIFUaoYfg77
X-Gm-Message-State: AOJu0Yx8a1TJHKfD9fjlNUr0C1wNahE1gR+Ezf9Wm2ztepAMKpvw85Fx
	Vyx/asebkJj8ONZwLsjxpEbn7160j9zwVFAeh4+oU2xgRxkRsY2+ZuaOh98+0wkI9+Kl20IH2Pf
	h4s2e/HZ3A6ZGfSKUoTDLBd3CzywK4V7E4HPD14yn2zraP6JMtkGShCPRCR7Vtru1z+q8w64QOo
	hFp5go+MGHVgPCBds/qxb3g+4m0pevflgISOZj
X-Received: by 2002:a05:6820:1f0f:b0:5d5:6699:2c9b with SMTP id 006d021491bc7-5d5669930eemr13369703eaf.7.1721728175677;
        Tue, 23 Jul 2024 02:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJeYmoto4XfYkVaB8eVl5Rfnz6Zc7Zo5wuLRY713Uc0WXbr7Z9z8IthtfHXxldZAL02rgTLcuhfhVDsnxcrU=
X-Received: by 2002:a05:6820:1f0f:b0:5d5:6699:2c9b with SMTP id
 006d021491bc7-5d5669930eemr13369695eaf.7.1721728175401; Tue, 23 Jul 2024
 02:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230725110622.129361-1-ptyadav@amazon.de>
In-Reply-To: <20230725110622.129361-1-ptyadav@amazon.de>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 23 Jul 2024 11:49:24 +0200
Message-ID: <CAFL455=O23ci6GCzdnJr8DmyVSXAD=ctmj4AEk=XfSSLjbUQYA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has none
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 7. 2023 v 13:07 odes=C3=ADlatel Pratyush Yadav <ptyadav@amazon.=
de> napsal:
>
> If a device has no NUMA node information associated with it, the driver
> puts the device in node first_memory_node (say node 0). As a side
> effect, this gives an indication to userspace IRQ balancing programs
> that the device is in node 0 so they prefer CPUs in node 0 to handle the
> IRQs associated with the queues. For example, irqbalance will only let
> CPUs in node 0 handle the interrupts. This reduces random access
> performance on CPUs in node 1 since the interrupt for command completion
> will fire on node 0.
>
> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
> information for the NVMe devices. This means all NVMe devices have
> NUMA_NO_NODE by default. Without this patch, random 4k read performance
> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
> both nodes get similar performance (around 315k IOPS).
>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> ---
>  drivers/nvme/host/pci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index baf69af7ea78e..f5ba2d7102eae 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2916,9 +2916,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct p=
ci_dev *pdev,
>         struct nvme_dev *dev;
>         int ret =3D -ENOMEM;
>
> -       if (node =3D=3D NUMA_NO_NODE)
> -               set_dev_node(&pdev->dev, first_memory_node);
> -
>         dev =3D kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
>         if (!dev)
>                 return ERR_PTR(-ENOMEM);
> --

FYI, we have received bug reports because of this patch.
All single numa nodes like a VMware guest or a system set to interleaved mo=
de
will now see -1 as the numa_node attribute.

Apparently, some applications like Lightbits do not expect to see -1.

Maurizio


