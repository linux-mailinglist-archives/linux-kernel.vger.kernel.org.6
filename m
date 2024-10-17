Return-Path: <linux-kernel+bounces-368935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7BF9A16B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FBE71C220A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B421E49E;
	Thu, 17 Oct 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZALTsV6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D842168BE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124125; cv=none; b=kSiTgKQEFUYbGTBswY7sBtPyQFEjxhy7CRRGxzsWmpbQ6QcWjxWpq0p66Xh67R69p/D68LbEi+Dw3BIl6OgeE8H3ZL30KnDMn0EoXiKkWbZSaYcyYyf/KSj559v+IJRUwwTSAYBYN59je5U8di3l4JXiLd3/uilI0kA4+XHSPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124125; c=relaxed/simple;
	bh=FTkCwpCp/85EYo5SWqJaCWTup9Zd3Q50GpEe4JI0guY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbSVArlCUzTx+UhgFbtlK9cOl1zmIt4v0KD1knQTHU/Tg/rA7fCBckHVKPnXAINNsZpJoCCpkDuAPGNCQorBs5+RUcIJwPh1jW2A/F/ORp0LMH61AfYvY8BwWYGLq7b5JuwyBkqKAz1X6ZKAA0MxJwVNypKQWvfrA1aqP61hFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZALTsV6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729124122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3IvdWoUm5mT+46GBWorpSOFyy5vanUssXIrq1EZYnM=;
	b=OZALTsV6NzbcuhlXyTXRmW1uY9cFW4wiDvN/F8NqLDbH+xRb9pxQ9W1rBsAjqxP8AC85ro
	Jrg76cXAKuvZkKAGJbpL1MU6PIezcFZJkBfQB/Fi5WyqdphAYjMJxLisK4UMcsOm6x2qUC
	2+dWMrhxjiNGHl2dxrPASK9eHte24yE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-6cpvDtSJNcaNc2oBaJWdPA-1; Wed,
 16 Oct 2024 20:15:19 -0400
X-MC-Unique: 6cpvDtSJNcaNc2oBaJWdPA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1EA019560B5;
	Thu, 17 Oct 2024 00:15:16 +0000 (UTC)
Received: from f39 (unknown [10.39.192.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DD9B300018D;
	Thu, 17 Oct 2024 00:15:13 +0000 (UTC)
Date: Thu, 17 Oct 2024 02:15:10 +0200
From: Eder Zulian <ezulian@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Subject: Re: [PATCH] rust: Fix build error
Message-ID: <ZxBXDhZXNgCwAHzN@f39>
References: <20241014195253.1704625-1-ezulian@redhat.com>
 <CANiq72n5cPxDORQad2_fJPHXaE2YDHW3enavjWyz1MZBU3oasQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n5cPxDORQad2_fJPHXaE2YDHW3enavjWyz1MZBU3oasQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Miguel,
On Mon, Oct 14, 2024 at 10:38:45PM +0200, Miguel Ojeda wrote:
> On Mon, Oct 14, 2024 at 9:54 PM Eder Zulian <ezulian@redhat.com> wrote:
> >
> > Error observed while building a rt-debug kernel for aarch64.
> 
> Thanks for testing with Rust enabled!
Sure, it's been fun!
> 
> > Suggested-by: Clark Williams <williams@redhat.com>
> 
> Do you mean `Reported-by`?
Yes, my mistake.
> 
> Also, I am not sure which `Fixes:` tag would fit best here, since
> `PREEMPT_RT` has been around for quite a while, but only enabled very
> recently. Thomas: do you have a preference?
> 
I can try to find a culprit and add a 'Fixes:' tag. In my opnion, at first
glance, it would be the patch that introduced the Rust helper for spinlocks.
Not sure.
> In addition (sorry, it was in my backlog):
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
> 
I can fix it and send a v2 if that's ok. Is it valid to add two 'Reported-by'
tags (Clark and kernel test robot)?
> Finally, I think we should perhaps put a helper in `spinlock{_,rt}.h`
> that takes the `key` (instead of having this `#ifdef` here) and then
> just use that from the Rust helpers, because we don't want to
> duplicate such logic (conditionals) in helpers. And with the RT init
Agreed. We don't want code replicated. In my reply to Boqun I added some
notes. If that makes sense, we could avoid even the helper in
'spinlock{_,rt}.h'?
> open coding that Boqun mentioned, even more. After all, helpers are
> meant to be as straightforward as possible, and if we have this sort
> of thing in helpers, it is harder for everyone to keep them in sync.
Please correct me if I misunderstood. It seems that Rust doesn't have a
pre-processor step to replace macros in the code and the Rust compiler works
with 'objects/entities' created for functions and variables, but macros would
be ignored (since they are string substitution.) Do you have pointers for good
docs on this?
> 
> In other words, I see helpers as following the same "avoid `#ifdef`s"
> rule that we prefer in C source files vs. headers.
> 
> What do you think, Thomas?
> 
> >
> 
> Spurious newline.
Thanks, I'll fix the spurious new line.
> 
Thank you.
> Cheers,
> Miguel
> 


