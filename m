Return-Path: <linux-kernel+bounces-343000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0E79895B9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5FB1C20AC1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221E17AE1C;
	Sun, 29 Sep 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V837Ri/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E725166F3D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727617200; cv=none; b=uL3UnbjakWv0jCcPSdFJyJ9MJczBLYHm1XXSvnySpV2lnottwKGFwN74ZdgqOUrZ6YEBoXD4QHldEFQij++Yl7F4BvMliXEfxVL3NIwP9pmgqsSrTvzyVxiNLfH36OdjjwNPHaW9x+A/dDo08cHBeYmL1FCaKa27gWo4wJRjWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727617200; c=relaxed/simple;
	bh=WZNlbBQbwlLCr4ZEDPqAAsWk/TPoLqG4RZo9BD5jahg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IUyXd4Xk0njkJ2/PtzN02C6O7QHSe6fs4FL9A5dKXPPS0VjNa5KXX4ijjwtVzo7Pap9um5W0m/eOn4HSf95ARTaDouWyPKsLAKwmnZR5E1s3a0AxdVaXmmkU9VvzEeBTXfOlohlgHlnn4RYmqWL3KS5I5gk1H8KrrtY9R/W5d+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V837Ri/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D52C4CEC5;
	Sun, 29 Sep 2024 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727617200;
	bh=WZNlbBQbwlLCr4ZEDPqAAsWk/TPoLqG4RZo9BD5jahg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V837Ri/RAGmZUnf0jM1Ruxel1IvLtoDo928JL6b3Lio1PBU6pWgZF2oqGq9Yqf/xo
	 VtJubZeLa/Yxq9tcmvVSdZAw3ZG51SmwxizZJ2b/8dYXeSnxzMB/jXM6VasQueAMVI
	 NXKIOvYtPtAV25gN3MXd/DYYxKG0UNbpzh46ErCmZ3gftZi5XdZj/8afaX5/OxU/v8
	 E1VWTsGn4GqlxLgaONrBQVeso3lmTVhejjaxEXC9yEwXzhoompZWKhKIpYnHpEMFeh
	 ARcZXAdDe49G8wXGKQBr8inMaaaaEe5LKTJgwncjmM4B1Op4nrRb8fUM4WXqEEJ8qG
	 zW6I87hVBaXAA==
Date: Sun, 29 Sep 2024 22:39:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas
 <catalin.marinas@arm.com>, "Liao, Chang" <liaochang1@huawei.com>, Will
 Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uprobes: fix kernel info leak via "[uprobes]" vma
Message-Id: <20240929223956.5043f74bc781a124e761f013@kernel.org>
In-Reply-To: <20240926162901.GA9716@redhat.com>
References: <20240926162901.GA9716@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 18:29:01 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> xol_add_vma() maps the uninitialized page allocated by __create_xol_area()
> into userspace. On some architectures (x86) this memory is readable even
> without VM_READ, VM_EXEC results in the same pgprot_t as VM_EXEC|VM_READ.

Good catch!
I think we push this urgently and send it to stable tree too, right?

Fixes: d4b3b6384f98 ("uprobes/core: Allocate XOL slots for uprobes use")
Cc: stable@vger.kernel.org

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 2ec796e2f055..4b52cb2ae6d6 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1545,7 +1545,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
>  	if (!area->bitmap)
>  		goto free_area;
>  
> -	area->page = alloc_page(GFP_HIGHUSER);
> +	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
>  	if (!area->page)
>  		goto free_bitmap;
>  
> -- 
> 2.25.1.362.g51ebf55
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

