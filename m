Return-Path: <linux-kernel+bounces-202916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49A8FD2EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13F31F24503
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29086154BEF;
	Wed,  5 Jun 2024 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/W7OJSq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6015351A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604872; cv=none; b=ahTaqAKQlcrGiCY13AnM7GuZfBkueCo+TwKTTbzQAqb/eCxyuXDAy/HIZgETSNFxzSILL497FHCl7+BzDANkm6ZQfiQd31iktZSK09bQiCMB2tdwPpcQJaRJpcnJXp71dHWjzvLd2VhXB4LOGaI6TPbnPmNvNRTXxdDLof/t/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604872; c=relaxed/simple;
	bh=WDicw8rzDSRTNRCMmdH3Lin6iM8oFn63Wzr/O2sLyt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrSDbJ4wDSpMGgaqgzyXH4mZVBGWnyzx51wnptLp3d51U3390UQA7BlOGteKSBPOn/D20lznCD71hk8bNgYDwdr8dRJoUFztpyl43B6fQfzl0xWKdfUpO/y8HvaHOn/qcRoH/Z5E8WUzmpcUNJGMw0bw9VJ4ZnMzD0K7fHGHcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/W7OJSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717604870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDicw8rzDSRTNRCMmdH3Lin6iM8oFn63Wzr/O2sLyt0=;
	b=Z/W7OJSqXnuoiMxjKt/3wo39YoFulM9UoqAdwrpssXjiIy5LFo0gSxQa6GivYtXWEvh2c3
	ah1bbmCivbEK1qi5w4zWA0sEoVMNMuO+r7nTE678Ofe3CadTpSGcSQ2L+70tA/zls0OTNH
	RUch8tjTBzMs2h6C5bW2PN04DXg2NoQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-k_m2iCmHN9OQCeUFZNm0ew-1; Wed,
 05 Jun 2024 12:27:48 -0400
X-MC-Unique: k_m2iCmHN9OQCeUFZNm0ew-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D71931954236;
	Wed,  5 Jun 2024 16:27:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6DF2119560A2;
	Wed,  5 Jun 2024 16:27:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  5 Jun 2024 18:26:16 +0200 (CEST)
Date: Wed, 5 Jun 2024 18:26:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/3] x86/fpu: Remove init_task FPU state dependencies,
 add debugging warning
Message-ID: <20240605162610.GF25006@redhat.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
 <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/05, Linus Torvalds wrote:
>
> On Wed, 5 Jun 2024 at 07:19, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 06/05, Ingo Molnar wrote:
> > >
> > > But the init task isn't supposed to be using the FPU in any case,
> >
> > Afaics, the same is true for any PF_KTHREAD/USER_WORKER thread?
>
> I don't think so. We have various users of kernel_fpu_begin()/end()
> that are very much about things like crypto and RAID xor memory copies
> etc that will be used by kernel worker threads.

Yes, but kernel_fpu_begin() never does save_fpregs_to_fpstate() if
current->flags & PF_KTHREAD ?

Oleg.


