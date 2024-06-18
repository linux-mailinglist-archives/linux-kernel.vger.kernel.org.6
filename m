Return-Path: <linux-kernel+bounces-219821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BCE90D82B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C4A1C2453B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB64C630;
	Tue, 18 Jun 2024 16:06:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43784D8A2;
	Tue, 18 Jun 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726792; cv=none; b=IaDwYajwtdqaGqm0+ddky98T5TFwsyDErNcd3tv4Ay/ldf6jRN/WAJM7Dm/ErgiXZ7IZNRKa+LdMLkYFq/EdZqIkSVT+cdCtKdgec++IVH3JX2w7GsZdU08UddzYLIxaq4sbUw1StLm/TEFibw4WIT7REDsAPrrqlmXrGq++Y/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726792; c=relaxed/simple;
	bh=+bL6hWuShVJwspxBMTQ4ag+iS+eJGoJH7xMSqqIcfVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzd52urlepn8v4UZxAU+XWjYFNyG0CYKUu8421Rt8wE2a4u9h65oUNsiWSHbY4f12+i6hUuQXULdPP5Bu0eq9T8S1lEyqjqxbGBq2JdLzaTuvgro/aXmfUiOk1W3mc8/nBYz7IRAEzn7kcD/ZFL8mVAeijQTb6kZ7RS0vVBto4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77255C3277B;
	Tue, 18 Jun 2024 16:06:28 +0000 (UTC)
Date: Tue, 18 Jun 2024 12:06:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhengyejian <zhengyejian@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, suleiman@google.com, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>, "Guilherme
 G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v6 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240618120627.2002810a@rorschach.local.home>
In-Reply-To: <5ab67b75-4334-3678-40d2-8be98460d496@huaweicloud.com>
References: <20240613155506.811013916@goodmis.org>
	<20240613155527.437020271@goodmis.org>
	<5ab67b75-4334-3678-40d2-8be98460d496@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 20:55:17 +0800
Zhengyejian <zhengyejian@huaweicloud.com> wrote:

> > +	start = memblock_phys_alloc(size, align);
> > +	if (!start)
> > +		return -ENOMEM;
> > +
> > +	reserved_mem_add(start, size, name);
> > +
> > +	return 0;  
> 
> Hi, steve, should here return 1 ? Other __setup functions
> return 1 when it success.

Ug, you're correct.

Mike, want me to send a v7?

-- Steve

