Return-Path: <linux-kernel+bounces-226721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBA9142B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67F3B22157
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB22556F;
	Mon, 24 Jun 2024 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="zr6wTQt6"
Received: from out0-211.mail.aliyun.com (out0-211.mail.aliyun.com [140.205.0.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441D1CFBC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210427; cv=none; b=l5eNhQj7JDhZvNM6uFKucjmwhVvjsjMVw1gzfgBGpIlLAFC3+rn56WMt0agGopTpdD2bpYbVQM6f4InXMoMgQ/0kM+Gx9TB4PPg6naHCGVCdEX8WzpRBFFw/Ln8pvBGycHPO5IcLyzPsFZObDeQzk9cFzlRn7fc3icBaf9P0cxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210427; c=relaxed/simple;
	bh=Oo/MWR4hJBZvfqs0+Nu/N/FMHtdYAJZ9Pq2w+gK3M7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKuRpZWSzut9gvdnYjIn8rXLE9AzXyUy/3BaYFamMJIUKUFXr9QVJbLLp9dXokbSg5chvAst6KcegMD6tq6Hd+wZRMqlgmltuLWuHkgGwfOEOWuPA9TZXP7zpBOmEsPNFn9nmyNwXwzT/OHLLU/Fl4f60wCEH6xib23482+1fkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=zr6wTQt6; arc=none smtp.client-ip=140.205.0.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1719210421; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=h/V8QVAudwza7f0isPDmo7GxhiP7s8C90UwEDo6Oyic=;
	b=zr6wTQt662GiOfPp/J5gknUhm5M6ZfwrYFGGDJ606a9vShzBh8Sf5wV7qcf87c+UstK22011OqEa9ZpNei7tX2MaZOqPP+B+BoG5OhO+WWp0YvRuxNNFFc531ttVkPdvUYPug8Oge0OhcgKXzVVVmA6uCU+bTESx0i8aNlWSVAI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070043001;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---.Y8cwwnz_1719210103;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.Y8cwwnz_1719210103)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 14:21:44 +0800
Date: Mon, 24 Jun 2024 14:21:43 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: Xin Li <xin@zytor.com>
Cc:  <linux-kernel@vger.kernel.org>,
  "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
  "Thomas Gleixner" <tglx@linutronix.de>,
  "Ingo Molnar" <mingo@redhat.com>,
  "Borislav Petkov" <bp@alien8.de>,
  "Dave Hansen" <dave.hansen@linux.intel.com>,
   <x86@kernel.org>,
  "H. Peter Anvin" <hpa@zytor.com>,
  "Xin Li" <xin3.li@intel.com>,
  "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
  "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
  "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] x86/fred: Fix two problems during the FRED
 initialization
Message-ID: <20240624062143.GA59245@k08j02272.eu95sqa>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <58ec98bf-b66c-4249-8a10-ff254cd405c2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ec98bf-b66c-4249-8a10-ff254cd405c2@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Jun 22, 2024 at 08:31:26AM +0800, Xin Li wrote:
> On 6/21/2024 6:12 AM, Hou Wenlong wrote:
> >When I reviewed the FRED code and attempted to implement a FRED-like
> >event delivery for my PV guest, I encountered two problems which I may
> >have misunderstood.
> 
> Hi Wenlong,
> 
> Thanks for bringing the issues up.
> 
Thanks for your kind reply.
 
> >
> >One issue is that FRED can be disabled in trap_init(), but
> >sysvec_install() can be called before trap_init(), thus the system
> >interrupt handler is not installed into the IDT if FRED is disabled
> >later. Initially, I attempted to parse the cmdline and decide whether to
> >enable or disable FRED after parse_early_param(). However, I ultimately
> >chose to always install the system handler into the IDT in
> >sysvec_install(), which is simple and should be sufficient.
> 
> Which module with a system vector gets initialized before trap_init() is
> called?
>
Sorry, I didn't mention the case here. I see sysvec_install() is used
only in the guest part (KVM, HYPERV) currently. For example, the KVM
guest will register the HYPERVISOR_CALLBACK_VECTOR APF handler in
kvm_guest_init(), which is called before trap_init(). So if only the FRED
handler is registered and FRED is disabled in trap_init() later, then the
IDT handler of the APF handler is missing.

> >Another problem is that the page fault handler (exc_page_fault()) is
> >installed into the IDT before FRED is enabled. Consequently, if a #PF is
> >triggered in this gap, the handler would receive the wrong CR2 from the
> >stack if FRED feature is present. To address this, I added a page fault
> >entry stub for FRED similar to the debug entry. However, I'm uncertain
> >whether this is enough reason to add a new entry. Perhaps a static key
> >may suffice to indicate whether FRED setup is completed and the handler
> >can use it.
> 
> How could a #PF get triggered during that gap?
> 
> Initialization time funnies are really unpleasant.
>
I'm not sure if there will be a #PF during that gap; I just received the
wrong fault address when I made a mistake in that gap and a #PF
occurred. Before idt_setup_early_pf(), the registered page fault handler
is do_early_exception(), which uses native_read_cr2(). However, after
that, the page fault handler had been changed to exc_page_fault(), so if
something bad happened and an unexpected #PF occurred, the fault address
in the error output will be wrong, although the CR2 in __show_regs() is
correct. I'm not sure if this matters or not since the kernel will panic
at that time.

Thanks!
> Thanks!
>     Xin

