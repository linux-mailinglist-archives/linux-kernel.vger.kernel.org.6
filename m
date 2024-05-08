Return-Path: <linux-kernel+bounces-173683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 798E08C03F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B141F235C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F3612C466;
	Wed,  8 May 2024 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQY20pF9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50920309
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191207; cv=none; b=u7VvTcHK6AqGcvz+bu1f+AM8SiKHHaNRBbmQ4PJj2xVvaKX1bFUGCy3wGuf/gmWNABa00Va3l3j9qcE4wxuLByZI5wcc6LLDsmxmOwHR12pmteIVLTXDgylqJASKs1f8bBPWpaLhQ4c/h2DC9OCc95tx7qSzMXN2MMiMZ3GBsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191207; c=relaxed/simple;
	bh=xKd/JpOZD9BXaNk6je0WQzsYpCg7KNabWmTkWrqEL5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4Bw+mAhF8DJiiZYwqIK0Yd5WJ0ApANQp9JFvPgrkEUyOScENTPtvPpL5VAIkp6EIAz6NA9+AoRaKxdg9SPwaSELKHz7AuvbxZvUrHDPR9yGb1ACAam/D+ve8+Eass4C+gzk4agTdWIVbco0RMYE3ihWsfCE9wB2PmbR7//Oh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQY20pF9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715191202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXHeP1fxReFkb3vlF8uR86FPrcsGToM3TdgcQK2RQNU=;
	b=gQY20pF9oLms6oP6JV0v3nMNnq4rucrC0SY/IBkU6J9+VJaEd68BzrloHhS7ISWxiz1UOz
	7XJdKHHhLBs+YpT2aoLQpIzDsUiImq9WOLiH9wRqNXkAURs3m977ERntELXfwFOVyYp4lu
	j1QZnGtqrpuVupP7nP35LX5plu9fGsg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-LDqpkW30Mgi1opPj9SejaQ-1; Wed, 08 May 2024 14:00:01 -0400
X-MC-Unique: LDqpkW30Mgi1opPj9SejaQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dea5889eb7so471338539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 11:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715191200; x=1715796000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXHeP1fxReFkb3vlF8uR86FPrcsGToM3TdgcQK2RQNU=;
        b=ljezYkv4It1uww/jaM3zbyIuDhpkCP6ebwka4dQzjGYonM2y1BqrEmws3hghGhiW5Z
         zlUTtUtX51Mzih3nTo/W15SGu4lTi+2pKOAJBCy1NmcmvQV8SewPIN6n4qWsaoXX1DOq
         IkQwiSEqONz/RBInO6C4/Y/9QRlz1ScOl4G4q43YUTyKVFqVbNwXLNu11PLc+1IiOu9I
         q3++j5+CFcUS5zuqGefJzC95W1J2QZWyx6ATA4H6NjQlONa/8biLqdFFWYvifqFeOGI0
         aoBqwrYucUqVUupU3AsI4M9o5vUvl+3hZk9iUO31TK7+QwmwRz5K3yDvWHwmDjaCHCWZ
         8s7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVp+28QJGeYIJEd5VLF8NdCukUwOevCHdLlMpCIja61Vcn1ztQHVzMavtcXjGZV9fL9LpmtzqpE5hsHEt5Wgmyfa3HfatvCO8jB4tMd
X-Gm-Message-State: AOJu0YyTNAWd8nFnMIlXrzA5+xbUQW76zx8uVuSd6mwrboPHx53dS4bi
	eQTQ8BvIM2AJtEoaxOQYWkjbA8BoX49a48tXh9nOnXdysQnI582bZJY6uaeTyDRa970sGMv9EBl
	wVRunP109ZMGMmv0a4mV4ZCjMI66iie7tlvTfukkLmShxUgd20OJ8lo5pvpIdSw==
X-Received: by 2002:a6b:6b08:0:b0:7de:ca65:35b8 with SMTP id ca18e2360f4ac-7e18fdb65bfmr351286239f.19.1715191200449;
        Wed, 08 May 2024 11:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhOuEABofsJkR0NAvIggMb7kZ1ROrNVq+UeRIufOurky168HE2D00Us8McIBTeYaXwIA4RLA==
X-Received: by 2002:a6b:6b08:0:b0:7de:ca65:35b8 with SMTP id ca18e2360f4ac-7e18fdb65bfmr351284639f.19.1715191200047;
        Wed, 08 May 2024 11:00:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id t32-20020a05663834a000b0048892084e73sm1854432jal.155.2024.05.08.10.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:59:59 -0700 (PDT)
Date: Wed, 8 May 2024 11:59:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: liulongfang <liulongfang@huawei.com>
Cc: <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
 <jonathan.cameron@huawei.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v6 2/5] hisi_acc_vfio_pci: modify the register location
 of the XQC address
Message-ID: <20240508115957.1c13dd12.alex.williamson@redhat.com>
In-Reply-To: <3911fd96-a872-c352-b0ab-0eb2ae982037@huawei.com>
References: <20240425132322.12041-1-liulongfang@huawei.com>
	<20240425132322.12041-3-liulongfang@huawei.com>
	<20240503101138.7921401f.alex.williamson@redhat.com>
	<bc4fd179-265a-cbd8-afcb-358748ece897@huawei.com>
	<20240507063552.705cb1b6.alex.williamson@redhat.com>
	<3911fd96-a872-c352-b0ab-0eb2ae982037@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 15:18:55 +0800
liulongfang <liulongfang@huawei.com> wrote:

> On 2024/5/7 20:35, Alex Williamson wrote:
> > On Tue, 7 May 2024 16:29:05 +0800
> > liulongfang <liulongfang@huawei.com> wrote:
> >   
> >> On 2024/5/4 0:11, Alex Williamson wrote:  
> >>> On Thu, 25 Apr 2024 21:23:19 +0800
> >>> Longfang Liu <liulongfang@huawei.com> wrote:
> >>>     
> >>>> According to the latest hardware register specification. The DMA
> >>>> addresses of EQE and AEQE are not at the front of their respective
> >>>> register groups, but start from the second.
> >>>> So, previously fetching the value starting from the first register
> >>>> would result in an incorrect address.
> >>>>
> >>>> Therefore, the register location from which the address is obtained
> >>>> needs to be modified.    
> >>>
> >>> How does this affect migration?  Has it ever worked?  Does this make    
> >>
> >> The general HiSilicon accelerator task will only use SQE and CQE.
> >> EQE is only used when user running kernel mode task and uses interrupt mode.
> >> AEQE is only used when user running task exceptions occur and software reset
> >> is required.
> >>
> >> The DMA addresses of these four queues are written to the device by the device
> >> driver through the mailbox command during driver initialization.
> >> The DMA addresses of EQE and AEQE are migrated through the device register.
> >>
> >> EQE and AEQE are not used in general task, after the live migration is completed,
> >> this DMA address error will not be found. until we added a new kernel-mode test case
> >> that we discovered that this address was abnormal.
> >>  
> >>> the migration data incompatible?
> >>>    
> >>
> >> This address only affects the kernel mode interrupt mode task function and device
> >> exception recovery function.
> >> They do not affect live migration functionality  
> > 
> > Then why are we migrating them?  Especially EQE, if it is only used by
> > kernel mode drivers then why does the migration protocol have any
> > business transferring the value from the source device?  It seems the
> > fix should be not to apply the value from the source and mark these as
> > reserved fields in the migration data stream.  Thanks,
> >  
> 
> HiSilicon accelerator equipment can perform general services after completing live migration.
> This kind of business is executed through the user mode driver and only needs to use SQE and CQE.
> 
> At the same time, this device can also perform kernel-mode services in the VM through the crypto
> subsystem. This kind of service requires the use of EQE.
> 
> Finally, if the device is abnormal, the driver needs to perform a device reset, and AEQE needs to
> be used in this case.
> 
> Therefore, a complete device live migration function needs to ensure that device functions are
> normal in all these scenarios.
> Therefore, this data still needs to be migrated.

Ok, I had jumped to an in-kernel host driver in reference to "kernel
mode" rather than a guest kernel.  Migrating with bad data only affects
the current configuration of the device, reloading a guest driver to
update these registers or a reset of the device would allow proper
operation of the device, correct?

But I think this still isn't really a complete solution, we know
there's a bug in the migration data stream, so not only would we fix
the data stream, but I think we should also take measures to prevent
loading a known bad data stream.  AIUI migration of this device while
running in kernel mode (ie. a kernel driver within a guest VM) is
broken.  Therefore, the least we can do in a new kernel, knowing that
there was previously a bug in the migration data stream, is to fail to
load that migration data because it risks this scenario where the
device is broken after migration.  Shouldn't we then also increment a
migration version field in the data stream to block migrations that
risk this breakage, or barring that, change the magic data field to
prevent the migration?  Thanks,

Alex


