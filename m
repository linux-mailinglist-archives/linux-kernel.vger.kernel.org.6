Return-Path: <linux-kernel+bounces-324970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC40975344
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFD5B27657
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9918A6A0;
	Wed, 11 Sep 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iMMTqnRB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B114F104;
	Wed, 11 Sep 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060165; cv=none; b=RmyO+s99nLaPF/GUw6fpxOfWuCBuPR2iQxcg/OjKQWzbMhq9uuycMRIlHuuVFCydad9OxikGY0yHQDqj1DT2iWy5na7ZvGORWT2VGqifMJhQkMD3ygifZ4TDKj69kwNexoxY02qFg/O+u+1XTXGc5EnuWniuCthTmOceW/1ZZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060165; c=relaxed/simple;
	bh=pqqUGk1D8djsYTib86Sls8LSpZd+MZ1QOyXOw5DqIJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa0yLYppWInHvWZNO0XL72nAl7QvQvhbSRQWfli5Dkx+SqmY9uMsFrZhdENV5oEZCjS3IKln87EGfUgkhlCgPp+ZL8rXZqHzUiWb/0dUfFljYr22Ag+KohwX5obH4VFdF2nkHuQZ2lEjMoS6GTrJXZ3yliHtfFLbNxHp1FJdadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iMMTqnRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C924C4CEC5;
	Wed, 11 Sep 2024 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726060165;
	bh=pqqUGk1D8djsYTib86Sls8LSpZd+MZ1QOyXOw5DqIJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMMTqnRBBfmwKRtkYYMLYqi/eP13lsajhVtNVTYNOEWvb6/gnh8n5cSYOIA2yOStP
	 Fr3KrYGfUmnitNZOdzl+gZu40k1PR7hWxnvmKVejrH3LiSBmsFY2Zb8kKYqJSZBCYR
	 cEnSvAHHt7mGak51EkuM1Bxtm/lB0lmIxFNX8ATc=
Date: Wed, 11 Sep 2024 15:09:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ruihai Zhou <zhou.ruihai@qq.com>, kernel-janitors@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmem: core: Fix memleak in nvmem_add_cells_from_dt
 error path
Message-ID: <2024091112-emotion-unspoken-1d48@gregkh>
References: <tencent_C3AF1A5AA6C84EC8AFBC9434383912612209@qq.com>
 <aca066e5-8f8c-4c08-8c8c-8743e98ff7f7@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aca066e5-8f8c-4c08-8c8c-8743e98ff7f7@web.de>

On Wed, Sep 11, 2024 at 03:05:20PM +0200, Markus Elfring wrote:
> …
> > is outside of the valid range, the info.name alloc by kasprintf will
> 
>                                                allocated by kasprintf()?
> 
> 
> > cause memleak. Just free before return from nvmem_add_cells_from_dt
> …
> 
>         a memory leak?                                               ()?
> 
> 
> How do you think about to increase the application of scope-based resource management?
> 
> Regards,
> Markus


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

