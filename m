Return-Path: <linux-kernel+bounces-229786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB6C917427
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB147282AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29117E919;
	Tue, 25 Jun 2024 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JFxNUaeQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A00149DF8;
	Tue, 25 Jun 2024 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719353786; cv=none; b=Ok5RnIF5TKkeFKa7fz0zq4NeRPA/Ka6VlxD+K3PPzoNArDHe8YjjQkt2r5vSp6Y/JdGctD2PKxXovLy4uK1r7gYSPILyOvRZTPRgLPM4dSLlF4yKxVZceltsDDWdZKzJidQnLDU9M81HxcWGNpqLuIqx1aVXg/DrRz+JVgk0SnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719353786; c=relaxed/simple;
	bh=CDu7orZ2Z5HI13L8wDK31mN2bZTmFIfMGBFl4CQnTFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlCoUVcYt3LJ5GB3wYX7XECde7a2NxVoFdOpMpDuqtwsHSOTtkVzZyhRwbTpzbh5YGvKDcNZ19X49MJXBPkk6lpUheEunsUYS9wq9xEUDkBYdywR4UUPp1bf3agM53IDQiFt8nv5+ZHwDoXQyTlyFf6UrknA03x0Zg+aO9jJ7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JFxNUaeQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=yTBEcrAX7tIupXoEAf0f2ow9K88qNl2Ai+dmeT98M9Y=; b=JFxNUaeQpr4chQaSowvqUgf15p
	NqCM8ye5NmM2BZWBeqxdCmVRaoXGLv83cLJlYrMuWMEBJ4G8RsSKbWLSM0PLAr+/uaBfGkv30RQhq
	2Sc0okVT7ORPi/orkgBwNq6MlJsOHuL1nOQcQzBxWXmK2Z66zaYgrvlKjxUKwL+4Ca1MsghtdL0eX
	UjBR0VvzgR3iHh4YT0YpMxC8h7ElfPLEdLohTaLodmX+RYjZa2Resp4x9OO4ehnUeoiKNbjz4nYmL
	4f7kjqD/flUd5ibR9bryUFipBNbPons01skfdkKV/hRBqsnj3kENBjqkMuwTRWeBo+JUDqoh/FDz3
	MoxiccBw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMESd-00000004fbA-1rUX;
	Tue, 25 Jun 2024 22:16:23 +0000
Message-ID: <61deba2b-3791-4ceb-a02c-de3bbca2426b@infradead.org>
Date: Tue, 25 Jun 2024 15:16:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] Docs/process/email-clients: Document HacKerMaiL
To: SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240624185312.94537-1-sj@kernel.org>
 <20240624185312.94537-8-sj@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240624185312.94537-8-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/24 11:53 AM, SeongJae Park wrote:
> HacKerMaiL (hkml) [1] is a simple tool for mailing lists-based
> development workflows such as that for most Linux kernel subsystems.  It
> is actively being maintained by DAMON maintainer, and recommended for
> DAMON community[2].  Add a simple introduction of the tool on the
> email-clients document, too.
> 
> [1] https://github.com/sjp38/hackermail
> [2] https://lore.kernel.org/20240621170353.BFB83C2BBFC@smtp.kernel.org
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/process/email-clients.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
> index fc2c46f3f82d..dd22c46d1d02 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
> @@ -350,3 +350,12 @@ although tab2space problem can be solved with external editor.
>  
>  Another problem is that Gmail will base64-encode any message that has a
>  non-ASCII character. That includes things like European names.
> +
> +HacKerMaiL (TUI)
> +****************
> +
> +HacKerMaiL (hkml) is a public-inbox based simple mails management tool that
> +doesn't require subscription of mailing lists.  It is developed and maintained
> +by the DAMON maintainer and aims to support simple development workflows for
> +DAMON and general kernel subsystems.  Refer to the README
> +(https://github.com/sjp38/hackermail/blob/master/README.md) for details.

-- 
~Randy

