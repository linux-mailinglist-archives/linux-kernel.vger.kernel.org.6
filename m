Return-Path: <linux-kernel+bounces-254083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86DB932E87
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654E5B22D77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278819FA87;
	Tue, 16 Jul 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Al0o8nL8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C308B19F49C;
	Tue, 16 Jul 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721148336; cv=none; b=ZO1Jct7iblJ2sfvm+YDZw+q9DmdWq/bUugMJ2/fMT9+XpE5oPGygaYBJ5/F8GEKAWu0nkOafFZXrvtcR3xD27dJCEAVuqdZSkaskRnlvqZkxtcwVzM5cw4hROEJeIPClbXMI7L8FvREbYvpe2qlPvz6Zr5qObqwWGEbU4OAjRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721148336; c=relaxed/simple;
	bh=FKUsu+3CKEUXpHXilZ/2Z0b8ge/ugqa2l8It3GPJ8ng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNOJKxWxPNZ2YDResWeQYmAYmdhhxqHc0sjvLKsCKsrcShsuUBDddAhP2IlFllGLyvFIYsoE53jXS0eJSJqD2INR3ordoYGfI6fbjhgoRb050/w0GdG1OaQ/QJOALiB2rAEJ7+1xT7Os0oo/GGQP6eaJA6BIF2MHrb4TDonAW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Al0o8nL8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D594418B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1721148328; bh=pcKV/gMf23Q9CE+QbxcJ6EXmSGrAkAg7klHAdJAUUd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Al0o8nL88+TRzl0xyySronruD3sucRh5/QQvfxHXr3er9yviYRaUpITXVRvZaHmeU
	 bG8VTeYHXBVlxL8AxV8D3A0YLXYOjT2rRXfVZb2BBCx21mwZc+4aO0E5D4kdp9tsRj
	 4sjgrAH5bCQxdojb30SlbL8emuShYC12TcyMxBE9sQRsYwT/Wi5osxXeoWLjOUNTpS
	 P2r3QXoXQ84TItoKnIV0zFPwW4gT5JNc0RK1sR5n7MecpvFYbXzpV8R3NmzQtAaaRy
	 bANtdSZlAZrPg4V49XigZ29mgmkN40/rtTDbwJqfmTd7ZoBhfqgj8ULXVQyqnL50E7
	 zGInt+wY78yeA==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6D594418B2;
	Tue, 16 Jul 2024 16:45:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, sergio.collado@gmail.com,
 peterz@infradead.org, rdunlap@infradead.org
Cc: bilbao@vt.edu, jembid@ucm.es, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH v2 1/1] docs: scheduler: Start documenting the EEVDF
 scheduler
In-Reply-To: <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
References: <20240713140455.4072847-1-carlos.bilbao.osdev@gmail.com>
 <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
Date: Tue, 16 Jul 2024 10:45:27 -0600
Message-ID: <878qy1uvyw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:

> Add some documentation regarding the newly introduced scheduler EEVDF.

A nit, but one I wish more people would make note of...

[...]

> --- a/Documentation/scheduler/sched-design-CFS.rst
> +++ b/Documentation/scheduler/sched-design-CFS.rst
> @@ -8,10 +8,12 @@ CFS Scheduler
>  1.  OVERVIEW
>  ============
>  
> -CFS stands for "Completely Fair Scheduler," and is the new "desktop" process
> -scheduler implemented by Ingo Molnar and merged in Linux 2.6.23.  It is the
> -replacement for the previous vanilla scheduler's SCHED_OTHER interactivity
> -code.
> +CFS stands for "Completely Fair Scheduler," and is the "desktop" process
> +scheduler implemented by Ingo Molnar and merged in Linux 2.6.23. When
> +originally merged, it was the replacement for the previous vanilla
> +scheduler's SCHED_OTHER interactivity code. Nowadays, CFS is making room
> +for EEVDF, for which documentation can be found in
> +:ref:`sched_design_EEVDF`.

If, here, you just say "can be found in
Documentation/scheduler/sched-eevdf.rst", the right cross-reference will
be created and ...

>  80% of CFS's design can be summed up in a single sentence: CFS basically models
>  an "ideal, precise multi-tasking CPU" on real hardware.
> diff --git a/Documentation/scheduler/sched-eevdf.rst b/Documentation/scheduler/sched-eevdf.rst
> new file mode 100644
> index 000000000000..019327da333a
> --- /dev/null
> +++ b/Documentation/scheduler/sched-eevdf.rst
> @@ -0,0 +1,44 @@
> +.. _sched_design_EEVDF:

...you can take out this unnecessary label.

Thanks,

jon

