Return-Path: <linux-kernel+bounces-323639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89B9740F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217AB1F2343C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB7A19F464;
	Tue, 10 Sep 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lYal/x8C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvzHYHlP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42C18DF8C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990367; cv=none; b=A5J6ZW2NDDLNxIG+iVlo8btMCuiV+RI6nGNohMvWDcSfpceznzCsSwVCuTW4AEGEc1Um1jDoIoN31IE+kNfwyYliJI2iNFKV+NVbqjbweFdBDPczAFGiAH2Y89XqEsr0iOALdLO4qf2sYmgMxacF1GTppceIG+aVoCnxNoZXjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990367; c=relaxed/simple;
	bh=qlRmzICNJn2EjmIrG2h3lQlBOE6HXfRlgXHtJAEt4vY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qOt5htmrV9ym1wsNsNeSM/jiyza0+/FbxaJIsqRcfUQV+Vmnh7fKDj+Jdx8wz8bYetwwrMOVgV5kRGJiGUmKQqTu0DiWeAdr8cKHzlRldqInexCO+XO5fiSD8hsBu0JLMu+qjLZr8tDavRDpZhBNaalNbZv2u5h8quC+4t2F58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lYal/x8C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvzHYHlP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725990363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suMidz+hPf+5Di+es4OAypfRE6qDoYRbIm9lX5MWSsg=;
	b=lYal/x8CJANH6ZI2sjNHj7UoVP591Tz73vNIIDlDQdMfpINuOZJaImeCZfom1A3JqmF/AH
	yoyp/L+TB4pR+uV7V5BVsgcZbLbiqiVmdmzLzKcrGQO/VBEqFK/kj+cGdn5BaCrdjCyYg5
	LYXR0x+WRFRtH3ZQkWcZWjbNtSY7RUGqifmwSz1MYwMFCYItfQcbjNI8gYHJQXXItM53+O
	FtxGY4E0H0KyjjTi30wezeFyqWlC5F3upk7CNj1WC0CvybSMumLCsCSomyGeRDEI/Bo13n
	sTYi6eZOlJqh31GoU7EMkV7rw0iWPZd2QcEP3XnQrnhRb2nrr3MbO1E0qsepZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725990363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=suMidz+hPf+5Di+es4OAypfRE6qDoYRbIm9lX5MWSsg=;
	b=YvzHYHlP+Am1F3gMR4UUM3PwtfpWq8BE6yvyUb+OtxuDDk60X/zxUbv/6Xh9VKW1Ea6uLt
	naD+OTdUGiJpRzCw==
To: Jeff Layton <jlayton@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2] timekeeping: don't use seqcount loop in
 ktime_mono_to_any on 64-bit systems
In-Reply-To: <20240910-mgtime-v2-1-e96826ac56f0@kernel.org>
References: <20240910-mgtime-v2-1-e96826ac56f0@kernel.org>
Date: Tue, 10 Sep 2024 19:46:02 +0200
Message-ID: <87jzfj9zc5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 10 2024 at 08:55, Jeff Layton wrote:
> ktime_mono_to_any only fetches the offset inside the loop. This is a
> single word on 64-bit hosts, and seqcount_read_begin implies a full SMP
> barrier.
>
> When BITS_PER_LONG == 64, just do a simple ktime_add instead as there
> is no possibility of getting a torn offset value.
>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Thanks for the review so far, Thomas! Hopefully this looks better.
> Disregard my earlier question about making this a static inline too.
> That would require making offsets[] a global symbol, which I don't think
> we want to do.

This still fails to address these:

> Please describe functions with foo() and not foo.

>  Which will make KCSAN complain ...
>
>  So yes, READ_ONCE() is the correct thing todo, but then we want to have
>  the counterpart at the write sides.

KCSAN requires this to be annotated and it's also a good documentation
that this is a intentional unprotected access.

Thanks,

        tglx

