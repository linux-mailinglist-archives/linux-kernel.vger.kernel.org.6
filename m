Return-Path: <linux-kernel+bounces-422884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AC9D9F49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B98285935
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657F1DFE1D;
	Tue, 26 Nov 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tl7s4hcK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF01B6D0E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660912; cv=none; b=OGLSRwOb3eYSZlBYphQtiabe+TzLShY1Ifh5LTdThT30qcL/xlarlzq3QITqtr2zcsXOZWoVubwTf5IDth8gZw42dI/ndDEEIGSQanTTnb0LfwJawn94wws5JB/7Eea3KhppYXPQbMkc3v+IfQmiAmmnPM6DspPAsYWg3GAeCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660912; c=relaxed/simple;
	bh=b7lCrDz13ILNM08LfCgzVYD9C9TH4sUkUGJSvBRHy9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RihdHG12ljPelB/ayVE8p4tL6LBEELzrd5As2DbIQW05scnr7NbIC3xdBjSRpzncZF8rhGDCuLO+YLj5BjWLFGgTAasefs4uGlLddTesfxjK6z7SRrd6djz8KtZ4aAczcWLit9LxHWcRp05PGNFZ13E9x072nrR5M5spqPa2IO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tl7s4hcK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732660909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjzLuFCAYERs3f8o3lK5yADWmxgixrnHXJ2IfNHbUqo=;
	b=Tl7s4hcKTCscNVwswKqdsKukeJ09sxMa6PI/mrj64TUVqlkeHz673QgAnREtcBoQITYvn+
	NgYMGtIfAu/iK3N9a+mbzC2YcqYr8IAeNxLAdHMQwuixuLvT3LGR+6I2tj3I29VievNg/C
	P2flu0V7iZxcgX3Fqr3K/286TxlFA3g=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-_5k17yStMYC1ZVu4LY1xnQ-1; Tue, 26 Nov 2024 17:41:47 -0500
X-MC-Unique: _5k17yStMYC1ZVu4LY1xnQ-1
X-Mimecast-MFC-AGG-ID: _5k17yStMYC1ZVu4LY1xnQ
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841a54afac0so31396739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660907; x=1733265707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjzLuFCAYERs3f8o3lK5yADWmxgixrnHXJ2IfNHbUqo=;
        b=gwUBC+ui3B+zDV6kDt0BIVmkQzxNqFWBi/++u7JCGfkOtzAO7H1NvmMZNRmQ7g2ORk
         2TO8ywP6hSYXXVXQ0C787Z5fmOFnP3fE5bR3HEwfsj9mw/JgkW14aliJDbccHf3g/CZm
         my70ll1Ypx9HQ1Sy80oe4qpH3dUzW76ebIsP1jdE7KRLOe9WmUQlKusGcB5msmUcyrvc
         6ZGIfm9UKINSFRxmkhR8tVCurYGN9yXYDUtBrN06UewqWNVLLpcstM/uV+xapyKN1U5w
         78Kd5Tkb8SkOYAEBEqAAJ+usJYEo9DtAt19it+2dxdyY40FtnjL7LcENvlEMxrKVj2z7
         TaOg==
X-Forwarded-Encrypted: i=1; AJvYcCXCd05pkmraQU+PhkLS279tiYp3CT05tTn5PtLqTfHgRpJLgc/HwGLV8bgEIsiDtgbePRUH2CsTNC1vJWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVPZizLBflCDC9hUfUiOJGd62+eebJclvUSz7Ni0i2MpaKZnx
	2Nfjz9NVrLGceupkV041or0LxKHA975Gv2V5HxAggEpUoprPzp7xvr49OSTbECUKR7VNvhOhhHC
	xcrgFTAWEJK/cXpu7sFN6lsuw8K8KWenF0CiPamD4RZUdVcvsPTtLR+C81vC09A==
X-Gm-Gg: ASbGnctzN8IeYjgquIAoP2C4QmFetUdDM46QWf3zRQEdRBB5j/SgBPljZwO+HZlfePk
	p+SAmioRn9YRMQ4vZ0o1XjJfhxqUc6HfhxmRKaMqsya6k+bKUhE4o3iqQjhNtbxQ6VxC5RBRfSb
	qD8vpIoipX5jmyHA5LbyEZzykG6Q369sXH2AoHyALiqb//AsoOZgYlNJx+etP5Uz/12sgCsRwkH
	GgnyzipIIrDOySP93g4G5eJlf48U+jfxfD2XiRiR0GskcbErqPHBQ==
X-Received: by 2002:a05:6602:150b:b0:82a:a4f0:5084 with SMTP id ca18e2360f4ac-843ed0d8d35mr38815639f.4.1732660907263;
        Tue, 26 Nov 2024 14:41:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ7nxJJRG17OVR38I1h6QIFaT5CqYN0QEozIVMyIIuB4frEnlsLeSFJmypcdPsDIcw6V5jhg==
X-Received: by 2002:a05:6602:150b:b0:82a:a4f0:5084 with SMTP id ca18e2360f4ac-843ed0d8d35mr38815139f.4.1732660906981;
        Tue, 26 Nov 2024 14:41:46 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1fcb97e1fsm1518271173.102.2024.11.26.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:41:46 -0800 (PST)
Date: Tue, 26 Nov 2024 15:41:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Mitchell Augustin <mitchell.augustin@canonical.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci: (and/or KVM): Slow PCI initialization during VM
 boot with passthrough of large BAR Nvidia GPUs on DGX H100
Message-ID: <20241126154145.638dba46.alex.williamson@redhat.com>
In-Reply-To: <CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
References: <CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com>
	<20241126103427.42d21193.alex.williamson@redhat.com>
	<CAHTA-ubXiDePmfgTdPbg144tHmRZR8=2cNshcL5tMkoMXdyn_Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 16:18:26 -0600
Mitchell Augustin <mitchell.augustin@canonical.com> wrote:
> > The BAR space is walked, faulted, and mapped.  I'm sure you're at
> > least experiencing scaling issues of that with 128GB BARs.  
> 
> The part that is strange to me is that I don't see the initialization
> slowdown at all when the GPUs are hotplugged after boot completes.
> Isn't what you describe here also happening during the hotplugging
> process, or is it different in some way?

The only thing that comes to mind would be if you're using a vIOMMU and
it's configured in non-passthrough mode so the BARs aren't added to the
DMA address space after the vIOMMU is enabled during boot.  But your
virt-install command doesn't show a vIOMMU configuration for the VM.

If the slowness is confined to the guest kernel boot, can you share the
log of that boot with timestamps?  Thanks,

Alex


