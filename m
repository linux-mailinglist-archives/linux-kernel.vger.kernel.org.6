Return-Path: <linux-kernel+bounces-523900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35483A3DCA1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D001886C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B41FBC8A;
	Thu, 20 Feb 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UvnsksJo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKQVbQh8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBB1EF0AD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061436; cv=none; b=A1a630KKNVv9a7Rz4saYcObaagTjC6+ZjyQefJMeWXdML+SsoYiLulshstaKtMJNhU9pJBQB+C2UQkqyseH/ytVS1lZhtY37+xw1sGF0kNd8fCNIkPSgLV1TYxtzHXZrq5lkpbrX8Bgky64AaRB7FiNcAHQ4hw+aipNrcChrhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061436; c=relaxed/simple;
	bh=IHpc8BhNMYbBZ5QlEaSz5EEhUpja+WNT+3USyZNpVZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fyh4JMjNimFThlbLk1MO9Q7U91cPkFHif21hATwZZ1hdmKWnufTJcXf20LWby0jBD80cg9Xs24Yg7ekQq1COZLExJ0aABcYIQVYc40Jax20UXDsfdzdz4uyklX3abDGJD4iWYpNszR6Hl4rSkggPC+5hJsXTrRShA6DrmrC+vbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UvnsksJo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKQVbQh8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740061433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHcTChppjqvuNzS7vFiu5kshNkViGqBVbLVaVldcc+o=;
	b=UvnsksJoB4TjGpY3z5g40o2vjDoF1ZtNWhqskzpuMdwZEW2lb2Rtbdh2qcqMp+VJNY+qgy
	R9LeS5iooE4u4qVhgINEYRkdqGkCtFT4MdAyZq8WahPbrye25qZ7NSQE6mtYEsP5WPuPYn
	GLx3e0uNDzUAKgxbJd27P6T7ed6bc64OvHYIbl4VMACBRgWw4kQiSlQcX1V8ZhbAEXq2QP
	NN2Tuqw0BlMF9ccCRmCrFS36/Ldumea/FZZS99C0vNBMiiU3l5dKAmdnic7IgY5uyW5oWI
	Wn2CFW4gY7YEZCI3DWg9M34H2ate105CCnH9ARnpRl7SwuYpz7u1xAU0w0FAMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740061433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHcTChppjqvuNzS7vFiu5kshNkViGqBVbLVaVldcc+o=;
	b=XKQVbQh8MsSiDU0tsEcVdVj8pWPto7NoxHoFB6Z612cxCFwO7Gr5KTvsUvxO6FpZn/nQ7W
	8Aahx0qp8dAotyBQ==
To: Jiri Slaby <jirislaby@kernel.org>
Cc: maz@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/18] irqdomain: Rename _add functions to _add_*_of_node
In-Reply-To: <14544066-73b8-42a0-a29a-2d21ef0aa459@kernel.org>
References: <20250115085409.1629787-1-jirislaby@kernel.org>
 <20250115085409.1629787-10-jirislaby@kernel.org> <87wme3m4a9.ffs@tglx>
 <14544066-73b8-42a0-a29a-2d21ef0aa459@kernel.org>
Date: Thu, 20 Feb 2025 15:23:52 +0100
Message-ID: <875xl4itjb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiri!

On Thu, Feb 20 2025 at 09:17, Jiri Slaby wrote:
> sorry for the delay, I drowned in tty.

I'm sorry for you :)

> On 06. 02. 25, 17:22, tglx wrote:
>> I'm not convinced that this _of_node() _fwnode() churn is actually
>> valuable. I rather go and consolidate the code so that the core
>> functions take a fwnode argument, i.e.
>> 
>>     - irq_domain_add_xxx(node, ...)
>>     + irq_domain_add_xxx(of_fwnode_handle(node), ....)
>> 
>> It's not asked too much from the developer to use of_fwnode_handle() at
>> the call site and the resulting treewide churn is pretty much the same
>> as in any case all call sites need to be touched.
>
> OK, NP. I am only confused by your "I rather go". Does it mean you are 
> already on it? Or should I translate that as "I'd rather go", ie. /me 
> doing the work -- I expect this case and can indeed do the job. I just 
> don't want to duplicate the work.

I meant to write "I'd" and was obviously expecting you doing this :)

Thanks,

        tglx

