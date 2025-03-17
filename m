Return-Path: <linux-kernel+bounces-564713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2F6A65999
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E9F3B3329
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D91AF0D0;
	Mon, 17 Mar 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dk9u3bw9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B41ACEDA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230616; cv=none; b=XaI3y7ZR6jqatvjVVhxTjM0eV80DDJ5WwU+MJw0OVlfujobrx4jZ6+yJKZQ6Zl+RBLcsz8ucEd18wfMSttEviYFw7nGp38TdpF4penObZygb39oxi/KgMWt0IXQNRvNliQmZzgz6J7tv9plMQtVelKV74d/ISnl03dRIyGE7os0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230616; c=relaxed/simple;
	bh=UdmHp0x7Q+PEra47aZVNnBrTe8NrJz3zaOmmjmyVkXA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NDqXXrNrFTLWr3KGlfOgfk05iCxZsMasMN/awEfhdQMdvXsW6wcPRrwIUbe17lE0SH7nkVsz1b0fAcjps+VaREIqCdhtZQzZDiHy2m2mvWww6UwA6c2zXlyIgvo8lqRTGbczTQwF79e+OexAOBauJ95wahEDZhBjehMKqrjgxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dk9u3bw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79302C4CEE3;
	Mon, 17 Mar 2025 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742230615;
	bh=UdmHp0x7Q+PEra47aZVNnBrTe8NrJz3zaOmmjmyVkXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dk9u3bw9QGnsqhjtsO/5/kdE3in4E4KT7wbCY0jAlQHHQgC1KK209Gc61hQduQtGc
	 jdzOg2RwFDoawC9TL4mSpFnyxaJUh/wRFsq7ZtkQEFcU0AyaBQKEI69888MpZPUoeP
	 fw1t54QWKhZiyD4rH42qoUInulbrLBTrp5YHB1/I=
Date: Mon, 17 Mar 2025 09:56:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] resource: Split DEFINE_RES_NAMED_DESC() out of
 DEFINE_RES_NAMED()
Message-Id: <20250317095654.28fee435e7e29712006682d6@linux-foundation.org>
In-Reply-To: <20250313160940.414931-1-andriy.shevchenko@linux.intel.com>
References: <20250313160940.414931-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 18:09:40 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In some cases it would be useful to supply predefined descriptor
> of the resource. For this, introduce DEFINE_RES_NAMED_DESC() macro.
> 
> While at it, provide DEFINE_RES() that takes only start, size,
> and flags.
> 
> ...
>
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -157,15 +157,20 @@ enum {
>  };
>  
>  /* helpers to define resources */
> -#define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
> +#define DEFINE_RES_NAMED_DESC(_start, _size, _name, _flags, _desc)	\
>  (struct resource) {							\
>  		.start = (_start),					\
>  		.end = (_start) + (_size) - 1,				\
>  		.name = (_name),					\
>  		.flags = (_flags),					\
> -		.desc = IORES_DESC_NONE,				\
> +		.desc = (_desc),					\
>  	}
>  
> +#define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
> +	DEFINE_RES_NAMED_DESC(_start, _size, _name, _flags, IORES_DESC_NONE)
> +#define DEFINE_RES(_start, _size, _flags)				\
> +	DEFINE_RES_NAMED(_start, _size, NULL, _flags)
> +
>  #define DEFINE_RES_IO_NAMED(_start, _size, _name)			\
>  	DEFINE_RES_NAMED((_start), (_size), (_name), IORESOURCE_IO)
>  #define DEFINE_RES_IO(_start, _size)					\

But the new DEFINE_RES_NAMED_DESC() has no users.  Can we add some?  To
demonstrate the usefulness of the new macro and to test it.


