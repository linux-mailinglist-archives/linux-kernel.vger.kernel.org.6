Return-Path: <linux-kernel+bounces-444574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC349F08F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480BB169865
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119B1B86F7;
	Fri, 13 Dec 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VIaV25qI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2391DF74C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083868; cv=none; b=Y6uhsCqxfb5ogbyy5DI+EvOSoi6kj1+xlKyMM6MVwpPSGLCDjwFw4r1xjgk9McDwDhRFZTXeZfl5ff4ZWbnjSf3GnMrrJjvMAwNO7vfT17qhiENq9SOsC9qUh6S70Y4uGvOENZTLSsuZ9mZT7ln6OQGgBUebouVXGbe7FKl0F7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083868; c=relaxed/simple;
	bh=9r6MUTvbeCVOP+fFFvMnfa3/2ntX9KHbrOLCq9WuBdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TazCPkcqkdNr2Vz6hmBf0OlKtAItZvqTc/3DrDSGTbRcmMRdpYaPmsicQxY9nM7Vs5vFKw3258PFRonIwU1fgID3e5PZY/BMWvw5DA/XVL4WNU4XTBxQCdXDKkoMQwkvX13jpl1IZJglhdQDVp5idTd59guKpUYZtO2pq7eGg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VIaV25qI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IKB16nwXnndSPN5V09g/4Cj7n9/Vu7tXt/HHKYJ74/w=; b=VIaV25qIJkuNeZU+avLzCBIhhZ
	zQ/ialzox4iSoBMzJuHmFicGSM5ya0ahP43v181jm9BEllIcULQVcCHkotTna6zQ88ap+UP81aJNA
	/OurAk7GbUhjM2wOPA8z0oDcRN6dCfG+1zv3oIDZIWKWaD61B+1yY7slg82rPy8raDg1zGpb5Tbqg
	cfk0vt8GyRrqfk4VygBHdZMRgy2d73hYpOEUihSjPFYRGJtjYJbbyXz4CdS+N9sVXSJHO3xk4IWdV
	htRplg+W0Ddf8sP/QP3XYEkBL3LR5d/1946ztVr5bH23zvolWJkY3VSApxQpEXJ0tGSnNe1Z/8oYT
	tL4vkEIw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM2QM-00000004FUL-1Fnr;
	Fri, 13 Dec 2024 09:57:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5E91E30049D; Fri, 13 Dec 2024 10:57:29 +0100 (CET)
Date: Fri, 13 Dec 2024 10:57:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <20241213095729.GC2484@noisy.programming.kicks-ass.net>
References: <CAJuCfpHpGSpix8+mB76Virb+HAMrOqB3wG8E4EXPrRCnBoBGeA@mail.gmail.com>
 <20241210223850.GA2484@noisy.programming.kicks-ass.net>
 <CAJuCfpETJZVFYwf+P=6FnY_6n8E7fQsKH6HrOV1Q_q9cFizEKw@mail.gmail.com>
 <20241211082541.GQ21636@noisy.programming.kicks-ass.net>
 <CAJuCfpEMYhAmOPwjGO+j1t+069MJZxUs1O1co-zJ4+vEeXCtng@mail.gmail.com>
 <CAJuCfpGOOcRAJ46sbPRoCUNuuhi2fnkM97F=CfZ1=_N5ZFUcLw@mail.gmail.com>
 <20241212091659.GU21636@noisy.programming.kicks-ass.net>
 <CAJuCfpHKFZ2Q1R1Knh-LFLUYcTX6CJuEsqNM5AwxRyDUAzdcVw@mail.gmail.com>
 <CAJuCfpGKEthmc2JkbOcfEJqsM_cBcm0cAvv0VFe-acMi169fcQ@mail.gmail.com>
 <CAJuCfpGJcrCkzOtaZDH98_oQK01+HNxHzzsf7SS95cXVRyXUPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGJcrCkzOtaZDH98_oQK01+HNxHzzsf7SS95cXVRyXUPg@mail.gmail.com>

On Thu, Dec 12, 2024 at 08:48:52PM -0800, Suren Baghdasaryan wrote:

> I'm not sure if this is the best way to deal with this circular
> dependency. Any other ideas?

Move the waiting into an out-of-line slow-path?

  if (atomic_read(&vma->refcnt) != 2)
    __vma_write_start_wait(mm, vma);

or somesuch..

