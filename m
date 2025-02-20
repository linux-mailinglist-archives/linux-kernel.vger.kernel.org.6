Return-Path: <linux-kernel+bounces-523688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A55A3DA07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461D88613E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0D1F4632;
	Thu, 20 Feb 2025 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TKg8UAfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44EB1F461F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054280; cv=none; b=Y9Z853TRQvO0i/nr5fwYSF8jWQJg19QiIE4ym+sJJ3n0gbGgysw0esuynp+7BNccYqsDQyY5uMlI7d8GZ+VasL/rDU4TnhBrthGDzV+0ovUp+ZH6p0gOX6esfsW65aGXk+qUl1zU6rXIod7ssku7VqMNqe9Mf+1VxH0OXt9G9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054280; c=relaxed/simple;
	bh=jeZaGJ0Th9HIcqwjSlE9Tz8JFbXgM8gbdWDsiOz2LIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+Yo7YjVQpgmS7rqMu/x0FCk21vHPhnpqnW4Dy1nE4UryL0jjvVKTO4VfXndhkMDD4/xbu4hl8sRGpNie49BNa3GdpR5CCBW8bVn0ltH2+7HuLjn4L2E/uSjvflltKO2AjLjWijYqMbgcs6xkz55g6L3oYWLiwdZfw1hyTk/PzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TKg8UAfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05050C4CED6;
	Thu, 20 Feb 2025 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740054280;
	bh=jeZaGJ0Th9HIcqwjSlE9Tz8JFbXgM8gbdWDsiOz2LIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKg8UAfokxUuTUDEW4ilTmSII+RH2e+Lvdb3EuHMfMrLcCKUtns1+F+I4ELT6H+0X
	 IEAK9PiKQqZqZZkkGiNQIpYvu8hag6CdeOebEWQ5yUcXdd84kTdnMzYcBPOfhqTONj
	 kkO+ArhRSMWA58ZV9uVeGHzUOqN2X8ikqTAQPltg=
Date: Thu, 20 Feb 2025 13:24:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/6] drivers: base: devres: Fix find_group() documentation
Message-ID: <2025022033-struck-employee-1960@gregkh>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
 <20250212200542.515493-3-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212200542.515493-3-lucas.demarchi@intel.com>

On Wed, Feb 12, 2025 at 12:05:38PM -0800, Lucas De Marchi wrote:
> It returns the last open group, not the last group.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/base/devres.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index b955a2f9520bf..d8a733ea5e1ac 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -576,7 +576,10 @@ void *devres_open_group(struct device *dev, void *id, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(devres_open_group);
>  
> -/* Find devres group with ID @id.  If @id is NULL, look for the latest. */
> +/*
> + * Find devres group with ID @id.  If @id is NULL, look for the latest open
> + * group.
> + */
>  static struct devres_group *find_group(struct device *dev, void *id)
>  {
>  	struct devres_node *node;
> -- 
> 2.48.1
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


