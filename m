Return-Path: <linux-kernel+bounces-527311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C000A40982
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3495B7AC675
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7D1AD3E1;
	Sat, 22 Feb 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XmixloNv"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2602D05E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740238252; cv=none; b=CkPomehS4rBNnUwty/MoehuUPaQcJ28ySo1mkzxEtKIkgCe1PjqO2pWvri9kDX2PHeTTTukZZQ1HVqSEwtO+D9n+bJvB7T+j0zH9LRxj/ClUS0w+V2hUTW2ZZxqXRcqmv40lFy4j6zIV7lzY67si7aCbri529vS1gQiyXfrs4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740238252; c=relaxed/simple;
	bh=r4tzzLkSDnrOdH/18W6LteR1pX1etKjfWltoHzgwLnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjv0JFuQfIcuNTuHt/JHBD9FAgjou3nuV9bQa0sCikEL3jnaiP+HzLcKMZNVzYLbgiksJrPt4D4O41oKeNtxQmhjeipiLJe6bFIUHUh5cYUlzwTZFB0C0wozhAmr1xRrAdPuT9RnyYADsybu3pXBXD2jSErn7HwUXCu1KplHirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XmixloNv; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 10:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740238238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2O6LlMiroyX8s3OR/vMtwOCtpXSsWXnlWltLALK/Npo=;
	b=XmixloNvYGi22sDde5+ivm+PQZYuJGWbvwGchK+dt0rDiPXOJedHUJ0u29AwsZ1C5O7gmq
	tkumgOF0EAu8WAXK1rXBQlpMTl84/ji4lm2K+Z2ZP55WiljBTMKwE4Qd2tdtu8Y/vKwiLp
	uJ5FJue7+kaGtoHP/jW+Ht1fMK8q8r0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Martin Uecker <uecker@tugraz.at>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, 
	ksummit@lists.linux.dev, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>
Subject: Re: Rust kernel policy
Message-ID: <4edgqqhbwn56jnz3fraowgyuwhjs33uw3545mnksxwrng42wa6@fbaqfqlhru7g>
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh>
 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <962fa158-5315-4d93-afb1-8a1c08787ad8@stanley.mountain>
 <1f31a16d3898e0e9b5d94f9bcc12a1b73ac97982.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f31a16d3898e0e9b5d94f9bcc12a1b73ac97982.camel@tugraz.at>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 20, 2025 at 03:09:21PM +0100, Martin Uecker wrote:
> We added checked arhithmetic to C23, we could add saturating
> math to C2Y if this is needed.  (although I admit I do not fully
> understand the use case of saturating math, a saturated value
> still seems to be an error? Statistics, where it does not matter?)

Saturating is mainly for refcounts. If the refcount overflows, you want
it to saturate and _stay there_, because you no longer know what the
value should be so never freeing the object is the safest option.

