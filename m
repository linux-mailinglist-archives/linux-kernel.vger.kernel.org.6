Return-Path: <linux-kernel+bounces-448873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916DE9F46A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92CD164BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6D1DE2AC;
	Tue, 17 Dec 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFCw6vNY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D61D63DB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734425841; cv=none; b=uYeGcb3AsKPvQjJVyvCQ7pEPjUqlCshwtkIrudAP4/XUDrCoZUHRHbO4ymQJFtl6NEhYudPDSBmRn1dnaAuzKfYY9lZkFH++mauCV260fu8C5k9xbTqFKulIHEK949qP6QZ6fFp++8b08pOxxqKSy7Vv6vH1rP3eX/DisdSV7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734425841; c=relaxed/simple;
	bh=my89gapazaRXABx0ds8EDdV5LyYYL2x4cidIM74wTVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBC1brqDFL/oUPaxAtll8ORaa9tuNUvaIqkY0sLdMYseuH/33h6Yq2m7tGRDLYNMUjeODlbQv/E2hrZq4TNFMVY3Oc2+IqqQqh110l5oUW1Td0mhgeThJkfg19BlwtU/vBLgh8mfhSyiXqh5HO8weOqqmNQe/n5esFYSFKUziN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFCw6vNY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734425838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e36MqRAUUxdsVobCeHh3rEjTnXYHMB/28HuSecqnBzU=;
	b=jFCw6vNYan504jBB4wZB9SbjOBHITFDAg51rRIikZ7zjte6SXLjM/ETav1Ygwe83k4CPOC
	oD+jYi+rXshEBZItmoOMRk4oY0ow1pIsK2lMWH8W+CYbdYhA9O5XM+VKvZigpYKLYtaT9d
	lzo7CeluNgWScLqOV8HwGU5dB5zDbxA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-xt9GXcfvMkO0ikhMh30o3w-1; Tue, 17 Dec 2024 03:57:17 -0500
X-MC-Unique: xt9GXcfvMkO0ikhMh30o3w-1
X-Mimecast-MFC-AGG-ID: xt9GXcfvMkO0ikhMh30o3w
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d88d56beb7so51240406d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734425837; x=1735030637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e36MqRAUUxdsVobCeHh3rEjTnXYHMB/28HuSecqnBzU=;
        b=wZbxBlbcph0HUYH3kwn9XEhcjONVixb+0C1Zdo0DmtWcQCMWsKrPIe1M1ha4RchNMc
         RZ2mhU9rcEB1K75AyW/hHPX5QiOyuacfRuEku+jc7mv3YRK5Q06Fl2URqG8RD4obQlyk
         RAzaGTTmMZB6NNZ0mCdt/pzGbrBYK3Jv6tZTZmEPC6Xc18kaIzHR8rDJSpRY3isoqt/U
         wWVrkCKmfzAIa2NllcuugpdK/rgHdoPU8kNuYIwFLJ2LCNMPxNuelRZ377/QwVGRorgh
         VpGeq4klGp5XZEeBZgK2UlV/gHLX4ppYt87L8bLMqCWOEt3+b6ZpD26CZv1IdwfE4Zk8
         KhJA==
X-Forwarded-Encrypted: i=1; AJvYcCV55gUwbK6hyIdWGOAQ9SJg/ztz0oiGwpA7Ucinien40M/y7zSB1e5eX32nsdjqxg40bz61NRfOGpUzim4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZmHyVULuE8uOR0nQ+9JMoqYNxrXHu9wUM/zHXAbKLOrIOMc6
	4Ja2b/tNxTRuPiHoht1CUxls84cVRPfME3Sm2EZDihoF2xix3vJXxA7CzrROu/bEPFh7B4rCqtM
	p/SWBJcJk9I17k8FINZMhoNiHUiwlVfckJZXCSSQrj2TZ0nTRXpJ+ZdR1ZyeD3w==
X-Gm-Gg: ASbGncuRiqgYAaRtwbALa/unuqwwNdhNwN/ifhIuIVwGpy3nj48YsGfBhMArLQRe4T8
	TFNRlxWRmRF2KmkQwxuu6bla8Gd2Ze3APRaPkAzXG566DoUPnWhQo+Ou/2yQwlcEvkkX7Ac7zdN
	EaXiEI4i3hR6GGlNdwUPXcCKAbFggB8YjX4+su/zekyQ2hDYqXqh9H3F4ohBYRKVwVNtVspHWdu
	H54+bzWUeZFcAHrZVA33TYniZA8F6R4zkkeU90V+6Fk6cbGrkjay0iRqEKSLQicCzZBTS7NI60V
	0aIJ/6NVEceqwWdoRDSUFcWxhClxGm2QwV2eik/2CCQ=
X-Received: by 2002:ad4:5c6f:0:b0:6d8:a32e:8426 with SMTP id 6a1803df08f44-6dc86ad7976mr257129826d6.3.1734425837027;
        Tue, 17 Dec 2024 00:57:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7OHDlYB62X/RjbCS6tlztv/Jo/Zkez7NULudfz1M3aDsbY23BSx9G1w3C9AIZrsP6H+k8zA==
X-Received: by 2002:ad4:5c6f:0:b0:6d8:a32e:8426 with SMTP id 6a1803df08f44-6dc86ad7976mr257129666d6.3.1734425836698;
        Tue, 17 Dec 2024 00:57:16 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-40-237-196.as13285.net. [80.40.237.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd25a0c9sm36322796d6.33.2024.12.17.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 00:57:16 -0800 (PST)
Date: Tue, 17 Dec 2024 08:57:11 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Ranguvar <ranguvar@ranguvar.io>
Cc: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@gmail.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"regressions@leemhuis.info" <regressions@leemhuis.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] from bd9bbc96e835: cannot boot Win11 KVM
 guest
Message-ID: <Z2E858-8jA6_xWFd@jlelli-thinkpadt14gen4.remote.csb>
References: <jGQc86Npv2BVcA61A7EPFQYcclIuxb07m-UqU0w22FA8_o3-0_xc6OQPp_CHDBZhId9acH4hyiOqki9w7Q0-WmuoVqsCoQfefaHNdfcV2ww=@ranguvar.io>
 <20241214185248.GE10560@noisy.programming.kicks-ass.net>
 <gvam6amt25mlvpxlpcra2caesdfpr5a75cba3e4n373tzqld3k@ciutribtvmjj>
 <Z2BaZSKtaAPGSCqb@google.com>
 <b6d8WzC2p_tpdLs36QeL_oqtEKy_pRy-PdeOxa08JtTcPhHNNOCjN73b799C0gv8NnmIJKH9gD6J4W-Dv5JKEVdrbMoVUp3wSOrqEY_LrDg=@ranguvar.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d8WzC2p_tpdLs36QeL_oqtEKy_pRy-PdeOxa08JtTcPhHNNOCjN73b799C0gv8NnmIJKH9gD6J4W-Dv5JKEVdrbMoVUp3wSOrqEY_LrDg=@ranguvar.io>

On 16/12/24 20:40, Ranguvar wrote:
> On Monday, December 16th, 2024 at 16:50, Sean Christopherson <seanjc@google.com> wrote:
> > 
> > On Mon, Dec 16, 2024, Juri Lelli wrote:
> > 
> > > On 14/12/24 19:52, Peter Zijlstra wrote:
> > > 
> > > > On Sat, Dec 14, 2024 at 06:32:57AM +0000, Ranguvar wrote:
> > > > 
> > > > > I have in kernel cmdline `iommu=pt isolcpus=1-7,17-23 rcu_nocbs=1-7,17-23 nohz_full=1-7,17-23`. Removing iommu=pt does not produce a change, and
> > > > > dropping the core isolation freezes the host on VM startup.
> > 
> > As in, dropping all of isolcpus, rcu_nocbs, and nohz_full? Or just dropping
> > isolcpus?
> 
> Thanks for looking.
> I had dropped all three, but not altered the VM guest config, which is:
> 
> <cputune>
> <vcpupin vcpu='0' cpuset='2'/>
> <vcpupin vcpu='1' cpuset='18'/>
> ...
> <vcpupin vcpu='11' cpuset='23'/>
> <emulatorpin cpuset='1,17'/>
> <iothreadpin iothread='1' cpuset='1,17'/>
> <vcpusched vcpus='0' scheduler='fifo' priority='95'/>
> ...
> <iothreadsched iothreads='1' scheduler='fifo' priority='50'/>

Are you disabling/enabling/configuring RT throttling (sched_rt_{runtime,
period}_us) in your configuration?

> </cputune>
> 
> CPU mode is host-passthrough, cache mode is passthrough.
> 
> The 24GB VRAM did cause trouble when setting up resizeable BAR months ago as well. It necessitated a special qemu config:
> <qemu:commandline>
> <qemu:arg value='-fw_cfg'/>
> <qemu:arg value='opt/ovmf/PciMmio64Mb,string=65536'/>
> </qemu:commandline>
> 


