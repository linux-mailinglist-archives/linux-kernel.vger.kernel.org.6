Return-Path: <linux-kernel+bounces-437665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEF19E96C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13B7188C51F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5AF233144;
	Mon,  9 Dec 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLCtpUaA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51223315B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750494; cv=none; b=SwXY7ihrF1n2QHervcUnzwQYDwDkYO6yXppR5fZgvBL+JtSzqvdIrmXtMGAvL0TUlHp0aDQsPKU7gZHtjdxVXGOKQSX6kTWAm4+330NuM18iSnW0QTGoGmnasN5DeuWAWTWhQQdD6P9pMvg40tEBtnWjBQdI9Q5SXn0Yz+xXeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750494; c=relaxed/simple;
	bh=kBFYXrgjneGgOPHo6biVrlmMJPHQgqBGqcH6KYCDcpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHacWOyQj5upnHs7w+7y9VRlFYBYcya4KV4WPRzii/XaNbGfbWRTSErjnpQO1N/mWfHK1Ntod6UgpmyoN5wGN+mWThgRpTByc822p3/sqB/NydMa5WN6LqxqEmW5wEeod2B1lEsBf3S/MzUSMAXjUnPHkHPkLlb1poT2i2m1Zs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLCtpUaA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733750491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrC64vfuasWzI50Ac1WvO0UeovJ22x37jEt9PiFRSDo=;
	b=HLCtpUaA7IrHfxkt4UAm9VdXX4dArEgUaR7Cvs5F2kgDgrLoDjyRrp8PaCWbJWiaPMBWOR
	dbWkKOa433GU7/esrfnxzNE7d2Rm2GvAClk0O2Fq3MPw1i0AHE4Nb/DwA2cfnBp65RfYgJ
	r8N/iih3hpyGeFPxZoe6l0rRh9SdtzE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-TJwfX3MmP4-qUp920JKe7g-1; Mon, 09 Dec 2024 08:21:30 -0500
X-MC-Unique: TJwfX3MmP4-qUp920JKe7g-1
X-Mimecast-MFC-AGG-ID: TJwfX3MmP4-qUp920JKe7g
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434c214c05aso36708755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733750488; x=1734355288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrC64vfuasWzI50Ac1WvO0UeovJ22x37jEt9PiFRSDo=;
        b=Vg1TLVv8QXGIACNEnupi5CzWdYSygNMWq5Gl+3yQYf1MFKiaQ8gVaGTCZ7Aeb+9PcX
         kyM3dIht4mAFtQcZ9f5zPM8RX8nvf06LY7zrBpq6V/psychcToXlJYmhbZzraa6Uatjl
         nL+Fg/e6D2um+JukEca4wHavz8DzDP6u367AiQT8xyweGlTeaBUwLs1+h4MzcE4/qxQh
         4JIhb86TBXntRrhol9qQTD91dKW4oWODfA6sk3wzd+QhEhlUpn00SGsSCrjLuw7lPglx
         h/g4opctjGKXY0DiwCSO99FiHwgDmoyD65814z65Z7+u/GsUYkmFshqnsBtvSIvtpIUK
         22Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWRQF4tAEvTpk1hnkHr3/kZNOoztxkSJ1vPipsLb33X4NeAs+ikutzeOVT/9SL2N8W+TZi9sPmXypRfu/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9ckWHinnc26W3U8Zm8b83s8Yh19VWxpT2mm5GnxRb9R9VlB/
	A831PoqrTYYkeFEWbUiJMthytASvNUK2ywiMC5oBl/3yuRWqL2+5jnsc6O/iAYsDKp4aCcsHZsS
	g15rb5A/idBni8muirRwZiGLZFyiq96g//p7cEEtQrBdk5FYGB+KWsv3d6+XfdWY4XsNZpA==
X-Gm-Gg: ASbGnctgwO8I3OO+pBVJD3Bqx+T5RxUMOZfRhdeJJtdgf1OOfhGIm7S741snO5PyYg7
	L9G0DTVcyooLBMEt+mn4+E55R6amt6S1XuBxGihPPfOlZCGEikIQYsByXv/IoU97UECzhsMbU8k
	jNEMdHVKLZGHRA/AH5fdRlkVi/vTiKSCMHQVRdGxWK5u+mmC8jUQBqE74oNkf2lLItomJ+p3m+b
	Avv3XXx7kfLlh1haZHnSIKpTtiMpSeknc8nJcJjElw2wWnXuFbovL+3/uRRxA+Q0MJdZyFGcbUM
	oph0Pv7Wz/wzzNDbzNSU7A==
X-Received: by 2002:a05:6000:78d:b0:386:1cd3:89fa with SMTP id ffacd0b85a97d-3862b37da8emr10855298f8f.33.1733750488195;
        Mon, 09 Dec 2024 05:21:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpPQnRIZu16wT5CDEHDmRuSGupx1hhP8ovzt9nmMxrBf32a0xvYsQS0Wr8vg8lU37w1zZ4rQ==
X-Received: by 2002:a05:6000:78d:b0:386:1cd3:89fa with SMTP id ffacd0b85a97d-3862b37da8emr10855275f8f.33.1733750487886;
        Mon, 09 Dec 2024 05:21:27 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621909644sm13377648f8f.76.2024.12.09.05.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:21:27 -0800 (PST)
Date: Mon, 9 Dec 2024 14:21:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 08/16] acpi/ghes: don't check if physical_address is
 not zero
Message-ID: <20241209142125.74aa8be4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241209113640.000055ab@huawei.com>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
	<95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733561462.git.mchehab+huawei@kernel.org>
	<20241209113640.000055ab@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Dec 2024 11:36:40 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Sat,  7 Dec 2024 09:54:14 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The 'physical_address' value is a faulty page. As such, 0 is
> > as valid as any other value.  
> Still not sure on what faulty pages are :)

s/page/address/ probably would make it a bit more clear

> 
> Given I tagged previous (after you'd sent this)
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index edc74c38bf8a..a3dffd78b012 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> >  
> >      start_addr = le64_to_cpu(ags->ghes_addr_le);
> >  
> > -    if (!physical_address) {
> > -        return -1;
> > -    }
> > -
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> >      cpu_physical_memory_read(start_addr, &error_block_addr,  
> 


