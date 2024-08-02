Return-Path: <linux-kernel+bounces-272332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B6945A5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAB21F23261
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A65B1D0DFD;
	Fri,  2 Aug 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM+vH0bd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467014B06C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589260; cv=none; b=iS8lFhzfYZYB1JnZmpuofXnTkCodEzg7P/XUQKnlSlpDPK4dpofvfsWODnu6Zy6SMjVjIc9z9OuNntR2UWAF6kGuH+756/6jRExwvscGo36JrYjsc6l4gemafZXMPzSypzozOH4WUCpTY+DsF3fuH2fukg98ga49BqF55qr/CBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589260; c=relaxed/simple;
	bh=mI6XNam89D6wed+57dXwm5WjNkhxyQ10KenEUrjaDjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeLSFNzK37nDE515i27kuHiiKQpzFzxFIN2Y+GjeA86zgA7qHJPEJUSTr5xy7YsPcEI2TFuVIk3qYl1t2Lk80siPQN53mdVzGH64WyPb7CgnXjiC2yaQFuPiYRP2pZaSwKcgWoeS0mKTZ6lDs2sp8geyvsmZldIGr3t0uLtWdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VM+vH0bd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722589257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d/jketK09aRbk1keqpEqJcKxt9b20wEYZYCZkMAMQBc=;
	b=VM+vH0bdVbjjUnCkGgzqy2HTF+1XPma/H67B3sqU/9VJJN7YWQg8cuk5w2gB7FRisa5nuU
	0lv4gvLGKdHsS/eyHPASy59h6u4uF4oJPFk1baZdqdXQp/xr4054CArQCYD6p6dlCVI70E
	R+CICyd4CCak5zXLf5zxBBtauwX7S0o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-tUJNXAURO1C0Dgf6zo9KhA-1; Fri,
 02 Aug 2024 05:00:52 -0400
X-MC-Unique: tUJNXAURO1C0Dgf6zo9KhA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 475011955D4C;
	Fri,  2 Aug 2024 09:00:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.207])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0A4C51955D44;
	Fri,  2 Aug 2024 09:00:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  2 Aug 2024 11:00:47 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:00:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <keescook@chromium.org>, srikar@linux.vnet.ibm.com,
	Ryan Roberts <ryan.roberts@arm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"glider@google.com" <glider@google.com>,
	Matthew Wilcox <willy@infradead.org>, zokeefe@google.com,
	hughd@google.com, luto@amacapital.net,
	"jmarchan@redhat.com" <jmarchan@redhat.com>,
	"rientjes@google.com" <rientjes@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: question on [uprobes] special vma
Message-ID: <20240802090040.GB12343@redhat.com>
References: <CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Jeff,

On 08/01, Jeff Xu wrote:
>
> __create_xol_area() calls  _install_special_mapping() to create a vma
> named [uprobes].
>
> I'm trying to find out the lifetime of this uprobes vma, e.g. when it
> is created, will it ever be unmapped/remapped/changed during the
> lifetime of the process.
>
> If  the uprobes vma remains the same during the lifetime of the
> process,

Yes,

> I can call mseal on it so user space can't change it, i.e.
> blocking munmap/mremap/mprotect/mmap, etc.

I didn't even know about mm/mseal.c...

at first glance do_mseal() just adds VM_SEALED for can_modify_vma().

So it seems that xol_add_vma() can just pass the additional VM_SEALED
flag to _install_special_mapping(), no?

But why it depends on CONFIG_64_BIT?

Oleg.


