Return-Path: <linux-kernel+bounces-394697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE99BB2F2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CC8284D09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D11C232D;
	Mon,  4 Nov 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N68Mcw40"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE11C3314
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718560; cv=none; b=kwtabBPCjBVLG8qQ6qHqtZ5CZX1HS/vsSlJR45LvwJ1P31K88qgEvdglGFqYGNyL5J19Hctw2N7llfgAlFRi1goDxzZHLKX0lREU7heV6CdsKHAASldFkDSMIk4SbVTPMQuwiWLECqRdBdySYFfr7s5FAlPyklRkuIimc2G6ZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718560; c=relaxed/simple;
	bh=+laLeFzUJ/5mjzCzevIlsqRx+X7kkxRYhLJixrUkzew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ0g7/mwmS24KgtJDEE16g3AzCpNDxzgwyzYRZ4M4dtmIDpCFeWq+4Y1mEO28cF0uTAm2cZ6ayDpk2WCCT01Gg8RuFMp3JB4jbJYZ7YjF/0lwbx8VIZ9TnTV3XQcv/UF1SF4aU179EvtwSIOkRp1YFJkcRJtz73cO/oJYJXYa94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N68Mcw40; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730718557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHfiYyGhwO85yfX2nMQtJYDaSaYp/kcb4Um/3beuNnA=;
	b=N68Mcw40RFYK3Jw7MyqVQ+BXemZKDHsszGfnLSHxVO5RP3HMgyOHpcnUtr4zYraQujPkPt
	28J9EGVR7458d55qlU9LcoFOyU90jG3PX3sV8C2GKanRF866DPmJZifV6LBkCoaMz+wcHb
	WpVE6MU15HlegWk8/e56+UCkK/Ur+oY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-cwirs87oPGmyff5eBckLkw-1; Mon,
 04 Nov 2024 06:09:13 -0500
X-MC-Unique: cwirs87oPGmyff5eBckLkw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 448D21955D55;
	Mon,  4 Nov 2024 11:09:11 +0000 (UTC)
Received: from f39 (unknown [10.39.194.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB6C300018D;
	Mon,  4 Nov 2024 11:09:07 +0000 (UTC)
Date: Mon, 4 Nov 2024 12:09:04 +0100
From: Eder Zulian <ezulian@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, williams@redhat.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Subject: Re: [PATCH] rust: Fix build error
Message-ID: <ZyirUGVxvyAjERpP@f39>
References: <20241014195253.1704625-1-ezulian@redhat.com>
 <CANiq72n5cPxDORQad2_fJPHXaE2YDHW3enavjWyz1MZBU3oasQ@mail.gmail.com>
 <ZxBXDhZXNgCwAHzN@f39>
 <CANiq72nqPN64KQat2VhC5EcVBxvNF18Hi19FPz24fqjpaj2LJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nqPN64KQat2VhC5EcVBxvNF18Hi19FPz24fqjpaj2LJA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi,
Really sorry for the long pause, I was OOO for some days...

On Thu, Oct 17, 2024 at 03:24:06PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 17, 2024 at 2:15 AM Eder Zulian <ezulian@redhat.com> wrote:
> >
> > I can fix it and send a v2 if that's ok. Is it valid to add two 'Reported-by'
> > tags (Clark and kernel test robot)?
> 
> Yeah, I think so, at least if they were independently reported. Please
> add a `Closes` if you have it for Clark's report.
> 
> > Agreed. We don't want code replicated. In my reply to Boqun I added some
> > notes. If that makes sense, we could avoid even the helper in
> > 'spinlock{_,rt}.h'?
> 
> Hmm... I am not sure I follow your reply to Boqun. In your version,
> under `DEBUG_SPINLOCK && PREEMPT_RT`, you call `spin_lock_init`, but
> that means we are not passing the given key but creating a new
> static/single one, no? That is why Boqun mentioned that.
> 

I shall send v2 based on Boqun's suggestion soon.

> > Please correct me if I misunderstood. It seems that Rust doesn't have a
> > pre-processor step to replace macros in the code and the Rust compiler works
> > with 'objects/entities' created for functions and variables, but macros would
> > be ignored (since they are string substitution.) Do you have pointers for good
> > docs on this?
> 
> I am not sure what exactly you are referring to, so perhaps this quick
> summary helps (apologies if you already know all this!).
> 
> Rust does not understand C, at all. So we use `bindgen`, which is a
> tool that internally uses `libclang` to parse C headers and emit Rust
> code to use them from Rust. Clang (of course) knows about macros and
> can parse them and expand them etc., but those macros (typically)
> expand into C code, not Rust code. So (typically) we can't simply use
> the macro because it does not generate valid Rust code. Thus we use a
> C source file to declare helpers that call the C macros (which is fine
> because it is a C file compiled by a C compiler), and then we can call
> the C helper function from Rust.
> 
> The problem Boqun pointed out is that, now, since you introduced an
> extra condition in the same `#ifdef`, then `spin_lock_init` is also
> called in a case when `DEBUG_SPINLOCK=y`, which means the key that was
> passed as a parameter is not used but the macro will provide a new
> one.
> 
> Does that help?

Yes, thank you!

> 
> As for docs, I am happy to point to some -- do you mean on the Rust
> side of things?
> 
> Thanks for the patch!
> 
> Cheers,
> Miguel
> 

Cheeers,
Eder


