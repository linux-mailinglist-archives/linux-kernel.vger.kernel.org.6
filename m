Return-Path: <linux-kernel+bounces-434468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854489E6744
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353231883CCB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620D1D5AC8;
	Fri,  6 Dec 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vPECzn5D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E917CA1D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733466127; cv=none; b=sIBqCyJLoAmwIhsi92bfTZLUjNUqMfLjE3keGsyZBFsOYprIQUepQoV1eeA2frBHqy6fI8TDm7UXwgE3atDot04PigbbKFNatg+41sjWawtWnsPFePq153wNNfhLwhVlhSe21O0BpIjLB7JNrwoJa2rVGsHOvxNFyRO/QCSleMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733466127; c=relaxed/simple;
	bh=gjN5dqkISywj5Q++n3F0NK385h8+NWDqFL+cKI/ZciU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIrPwGU98w22EudKm7u8tKVA9l/iZQrWNmh83zKiU0MOwdfLAW226xaWSIRGBrLjbOC3BWiwYcQ1zpOfXd/8GM5Q3sxEgzV3efezPLaYC1P7yxDoMpLDod0Yt6H53tq7ymZhA/TM/TiSR82vZrnRpuY2XzhUSj0U2ygS8e1umQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vPECzn5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED74C4CED1;
	Fri,  6 Dec 2024 06:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733466126;
	bh=gjN5dqkISywj5Q++n3F0NK385h8+NWDqFL+cKI/ZciU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPECzn5Dr4GgJ0p5b44yAgNF3T+e8tUOyMLuR83Za9h32dMq1OnRuZBMttDv9+Kee
	 XaHgjHq8ZrFPY3dqTvbsQ/Ja5cHtMmTabW72VEWZHdG5p+3MRrXKwiBNiQBDUBZRnU
	 lzHCkCI7wTgAFr4ioqlBYs4EFC9Oy6dhgfrk5AKo=
Date: Fri, 6 Dec 2024 07:22:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: liujing <liujing@cmss.chinamobile.com>
Cc: thorsten.blum@toblux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sample/acrn: Remove redundant assignment to itself
Message-ID: <2024120627-debtor-guise-2275@gregkh>
References: <20241206024127.2732-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206024127.2732-1-liujing@cmss.chinamobile.com>

On Fri, Dec 06, 2024 at 10:41:27AM +0800, liujing wrote:
> Delete the self-redundancy assignment for sig, argc, and argv.

But perhaps they are there for a reason?

> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
> index c61e0f91456e..f6d62d1659ef 100644
> --- a/samples/acrn/vm-sample.c
> +++ b/samples/acrn/vm-sample.c
> @@ -34,7 +34,6 @@ int is_running = 1;
>  
>  void vm_exit(int sig)
>  {
> -	sig = sig;
>  
>  	is_running = 0;
>  	ioctl(hsm_fd, ACRN_IOCTL_PAUSE_VM, vmid);
> @@ -50,8 +49,6 @@ int main(int argc, char **argv)
>  	struct acrn_io_request *io_req;
>  	struct acrn_ioreq_notify __attribute__((aligned(8))) notify;
>  
> -	argc = argc;
> -	argv = argv;

If you remove these, odds are now you will have build errors/warnings,
right?  That's why someone added these.

sorry,

greg k-h

