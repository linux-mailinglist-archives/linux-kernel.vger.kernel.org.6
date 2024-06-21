Return-Path: <linux-kernel+bounces-225127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C343912C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7CD28D6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E16160884;
	Fri, 21 Jun 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EACaPrYR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264386AE9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989673; cv=none; b=uBnNYdDgRhq66oG3KiP5Qsr2L0QhVTIHd84gIxYMRsgOQ+nmJp6vq/MD5mwnSxUUAgxYQXPHkD0Q+P19HpdJohWNRMaP+luBEWDzKsLIvDT8gfioIIwumcsvorEcSDByj01DLO0bHs+OASh9Jh0SMJnYwZv/4mTCo8WDH7TGJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989673; c=relaxed/simple;
	bh=qvYtGkrsY+mQpVkGknrTP5ArBhrNwDGfP5aSwcxIDmE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gL3d1YYscsnyW0X82/ASgmqF54l66NQaTZufY5lmPA/rVOMH3Mme1O/0IkFnkqJCkw0GSL7HoEEqml+yRnAyBff0yHg94LmE3X3y313iIKBGQnFSo+D+N8zlbqieEolvA8nUtSyOdPbpPcn3Qn615ZOTauEIFBiat6nA6RXP/UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EACaPrYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F9EC2BBFC;
	Fri, 21 Jun 2024 17:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718989673;
	bh=qvYtGkrsY+mQpVkGknrTP5ArBhrNwDGfP5aSwcxIDmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EACaPrYRMjbTk+42Ct3PMgkEmv7l1SsfZEQsYJPb3w3MJyD9+mBIw4ETXeY2Kl3w2
	 E4yOcacq/cU/IvTmbMywlOz1QkyJTsD2alHhQX5hcL0jckUmVCUcoVRHZxro74kX95
	 lm6lTzU7ITUxZI6YbTWRFE4Q34hnH52I2A91RkfQ=
Date: Fri, 21 Jun 2024 10:07:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] build-id: require program headers to be right after ELF
 header
Message-Id: <20240621100752.ea87e0868591dd3f49bbd271@linux-foundation.org>
In-Reply-To: <0e13fa2e-2d1c-4dac-968e-b1a0c7a05229@p183>
References: <0e13fa2e-2d1c-4dac-968e-b1a0c7a05229@p183>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 18:05:50 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> ELF spec doesn't require program header to be placed right after
> ELF header, but build-id code very much assumes such placement:
> 
> 	find_get_page(vma->vm_file->f_mapping, 0);
> 
> and later check against PAGE_SIZE.
> 
> Returns errors for now until someone rewrites build-id parser
> to be more correct.
>
> ...
>
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -73,6 +73,9 @@ static int get_build_id_32(const void *page_addr, unsigned char *build_id,
>  	Elf32_Phdr *phdr;
>  	int i;
>  
> +	if (ehdr->e_phoff != sizeof(Elf32_Ehdr)) {
> +		return -EINVAL;
> +	}
>  	/* only supports phdr that fits in one page */
>  	if (ehdr->e_phnum >
>  	    (PAGE_SIZE - sizeof(Elf32_Ehdr)) / sizeof(Elf32_Phdr))
> @@ -98,6 +101,9 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
>  	Elf64_Phdr *phdr;
>  	int i;
>  
> +	if (ehdr->e_phoff != sizeof(Elf64_Ehdr)) {
> +		return -EINVAL;
> +	}
>  	/* only supports phdr that fits in one page */
>  	if (ehdr->e_phnum >
>  	    (PAGE_SIZE - sizeof(Elf64_Ehdr)) / sizeof(Elf64_Phdr))

Well can we get comments in here eplaining the shortcoming?  That way
we're more likely to get a volunteer.

And please drop the braces?


