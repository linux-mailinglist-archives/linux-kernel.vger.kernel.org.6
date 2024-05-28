Return-Path: <linux-kernel+bounces-192741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E548D2180
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F223281E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906E172BA9;
	Tue, 28 May 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SxkxAFRw"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020A172786
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913266; cv=none; b=tXPb+mj4MivMrIzo/rLZEbZYHS7mpFcDmzZTsTQp/efZBl4aXdCP651ggpMommSxC1pub+X5yVa0O5HXfH2R/shAZLSyKg/xcH6elebYkBqVMcY8aa8S/W+7bWad96LP3UHHwZ7i/hzAEYzOCID0kyvHBhN87ba4Hb0OFVUJkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913266; c=relaxed/simple;
	bh=miDkAeIGeL8VtGuuCoBcxE9mF0TAA/w+xpazhCoV2j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lhv20YmM5mWgsooJ8ey7yphwwZ5XaGG/Mu88YBM+jtgUm3+VNTlFCV0tpJiaPw6eVLi34ZoL57A9Qqm3Q3gED7QuR62FAqn4u0M3ziRzC/7d06nhiJ6h/SJfhPkM1y2aoHwqXEebxGh6B8xqiSXJ6zZZTA7HJCZOj0+pymrsxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SxkxAFRw; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716913261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kE86HA2Pl0WMSgmbtH/SqDoMVET8ixgS0B8pGBr9o2Y=;
	b=SxkxAFRwvnEYce/S8woEfiSMwbGyG6lAcmE9c7Z6D8c18JY4ADn3/YM5h1L1Ij1S00/mkq
	D+D00IFcgn6vNp0+nM2jUOxqS/UQ1GEkAys9zesCfi/Clrx5rsC8yZowR8de1lrfqosZqv
	w8DlDj9bu4YZ1jjJc2KSMl3MHD3MgvE=
X-Envelope-To: vbabka@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tglx@linutronix.de
Date: Tue, 28 May 2024 09:20:56 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: Remove the lockdep assert from
 __mod_objcg_mlstate().
Message-ID: <nkgueigu3ybnzyj424ngxyb26jnyph2rbuyroxkgmrcj6ze36h@q6m7xfoiis4r>
References: <20240528121928.i-Gu7Jvg@linutronix.de>
 <09e085bb-f09e-4901-a2dd-a0b789bb8a4d@kernel.org>
 <20240528134027.OxDASsS3@linutronix.de>
 <c84d6962-34fa-42e5-899c-925579cbfb26@kernel.org>
 <20240528141341.rz_rytN_@linutronix.de>
 <dk4tgppzjy53qr6274cetbyhqjjvsvmjgtknzrsueagoomuchb@sxolann3nib6>
 <20240528150856.u4rArjaq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528150856.u4rArjaq@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 05:08:56PM GMT, Sebastian Andrzej Siewior wrote:
> On 2024-05-28 07:59:57 [-0700], Shakeel Butt wrote:
> > One question on VM_WARN_ON_IRQS_ENABLED() in __mod_memcg_lruvec_state().
> > On a PREEMPT_RT kernel with CONFIG_DEBUG_VM, will that
> > VM_WARN_ON_IRQS_ENABLED() cause a splat or VM_WARN_ON_IRQS_ENABLED is
> > special on PREEMPT_RT kernels?
> 
> we have the following in the header file:
> 
> | #ifdef CONFIG_DEBUG_VM_IRQSOFF
> | #define VM_WARN_ON_IRQS_ENABLED() WARN_ON_ONCE(!irqs_disabled())
> | #else
> | #define VM_WARN_ON_IRQS_ENABLED() do { } while (0)
> | #endif
> 
> and this in Kconfig:
> | config DEBUG_VM_IRQSOFF
> |         def_bool DEBUG_VM && !PREEMPT_RT
> |
> 
> which means on PREEMPT_RT we end up with "do {…"

Thanks for the explanation.

