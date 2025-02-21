Return-Path: <linux-kernel+bounces-526729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E70A4027F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13758600E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7338254AE1;
	Fri, 21 Feb 2025 22:14:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F61253F06;
	Fri, 21 Feb 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176069; cv=none; b=Ulg6S/G2zTfI2uKyoNP7qO4g3CKL+7W9WVJUex3thr7ChSo3roosdpiM1ZBUs+jyb8OMLzmviLqgJq6Ku4bOqUXSKFMIDj7Qp0nQtVqfIpSvGV6MnDOmkDe3rmAH0gITrW7DFRbp7E9PLiB27yCzqILPFXuxubhQ6CjyGVFQgdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176069; c=relaxed/simple;
	bh=yAwMXOjaJN6z1tn8eId8KeQM2ziqySE7/svPkNvVY1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHZYwsFSvCmc/X3Phk+f79dgebTyGuk5HKgVP/wkws9qKUUCvr4xw7MMYFCFbDMTeMzdUmR71c0yNKbMFZ3Duq3bvzmAesX6RfOY3gcb5CCeVhprqgPn/qYG81A+2jbQaCeoaBv1VuFBGvR+mLDCtNIXaOX2hCETvk8yDL8JK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF3FC4CED6;
	Fri, 21 Feb 2025 22:14:27 +0000 (UTC)
Date: Fri, 21 Feb 2025 17:14:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250221171455.19b5be06@gandalf.local.home>
In-Reply-To: <59a4f3f7641c47494b53f788684aa703a02acca1.camel@tugraz.at>
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	<CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	<a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	<Z7VKW3eul-kGaIT2@Mac.home>
	<2025021954-flaccid-pucker-f7d9@gregkh>
	<4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	<2025022024-blooper-rippling-2667@gregkh>
	<1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	<2025022042-jot-favored-e755@gregkh>
	<b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
	<caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
	<61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
	<20250221124304.5dec31b2@gandalf.local.home>
	<59a4f3f7641c47494b53f788684aa703a02acca1.camel@tugraz.at>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 19:23:38 +0100
Martin Uecker <uecker@tugraz.at> wrote:

> > where func is defined as:
> > 
> > 	void func(void) { return ; }  
> 
> Calling a function declared in this way with arguments
> would be rejected by the compiler, so I am not sure how
> this works now.
> 
> If you used 
> 
> void func();
> 
> to declare the function, this is not possible anymore in C23.

As the comment in the code states:

include/linux/static_call.h:

 *   This feature is strictly UB per the C standard (since it casts a function
 *   pointer to a different signature) and relies on the architecture ABI to
 *   make things work. In particular it relies on Caller Stack-cleanup and the
 *   whole return register being clobbered for short return values. All normal
 *   CDECL style ABIs conform.

Basically it's assigned via casts.

-- Steve

