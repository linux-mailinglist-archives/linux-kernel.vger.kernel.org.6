Return-Path: <linux-kernel+bounces-267068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1AD940C04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B651F2618F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0266192B75;
	Tue, 30 Jul 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tuISfPDk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB30A1922E4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328957; cv=none; b=BZqF43uee1/JFqC2Y60CQuawoNKwKH2xJd/bDwE3pBtw7E1hqlGrKOM+dnVeR4TeIYp54jDk/tMaVs7Nr9HrlW9RypvUz9E0tzmnel2Z/+HLvcS2dxs0/U6UsNp2WGaS5L72MNTNFK5qVQ8RWhHvkk+VI/SdeD2rFc55daJf3mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328957; c=relaxed/simple;
	bh=SOnVQtdB8WKDIZs8q6LUnGGmwU7vLAXr4hwgTL5+xhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOEAQ7LVb9xxE2CbLKMwnm5P/rkXNtdih4n6WBPcKsKmCaI8mr7KWDCb8Uqbv8faJo85Fus8aPqmXCyc2gW1Uv8KDgpQUxc/To28qg3n5ssVZeXx7l6j3kHc/n4lGHPZxaNhyytDvQXCGIYqAba17bcA+3NAWPF3QPZn+aViRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tuISfPDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BD4C32782;
	Tue, 30 Jul 2024 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722328957;
	bh=SOnVQtdB8WKDIZs8q6LUnGGmwU7vLAXr4hwgTL5+xhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tuISfPDkkezzS6xgPzFKKBubZzxQtDwb9Fh5DVS6OsluQkZtDzwXNAJUpzM3IOpW6
	 CUw3cJ0Q8be+raWNeEcA/qvCs2xLQN8rtEs00C5ahytVuYt/iY639Hp06yc3G708EG
	 c7vRogq5xbXxnhwBavCmqqshq+Kby4VssLwOsO3M=
Date: Tue, 30 Jul 2024 10:42:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH v2] char: misc: add missing #ifdef CONFIG_PROC_FS
Message-ID: <2024073042-observer-overflow-cd04@gregkh>
References: <bbb597df-5bd8-487a-8b5c-9118814632e8@app.fastmail.com>
 <20240730080312.3430-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730080312.3430-1-zhangjiao2@cmss.chinamobile.com>

On Tue, Jul 30, 2024 at 04:03:12PM +0800, zhangjiao2 wrote:
> From: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Since misc_seq_ops is defined under CONFIG_PROC_FS in this file,
> it also need under CONFIG_PROC_FS when use. 
> 
> v1->v2: not check proc_creat_seq returns

As per the documentation, this goes below the --- line.

> 
> Signed-off-by: Zhang Jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  drivers/char/misc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 541edc26ec89..e1e8cd09c34a 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -286,9 +286,11 @@ EXPORT_SYMBOL(misc_deregister);
>  static int __init misc_init(void)
>  {
>  	int err;
> +#ifdef CONFIG_PROC_FS

Again, why is a #ifdef ok in this .c file?  What changed to suddenly
require this?

thanks,

greg k-h

