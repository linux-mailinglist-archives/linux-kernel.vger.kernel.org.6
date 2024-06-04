Return-Path: <linux-kernel+bounces-200974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D288FB7A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7351C22D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF11448DE;
	Tue,  4 Jun 2024 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WMVOXQ5w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775A1420C9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515712; cv=none; b=dAbK75ydT4jYvMAYTg0fKYFvPVLKfZXDXA1tjvwzoExaNfdypSkS3nsmDdCw0stZonR7tjV0ROo6cUMNq8IMqhUor78majM1nrwnUIsBjeO0H8vP7wKgkflEuWSRu6iRUnr22QAmt19oOsSbNl81DQAj38gYduIoG2Uwqt9BtwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515712; c=relaxed/simple;
	bh=oGxkaCgbS2IqbLETXH8WRTH3RcDVcBRWmTNg4lWSmQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiTgQkap1+00lPNoPva/er2WAdFtFlDTRc9F3O+Il3tD3tnOlBweyEg/kMJtCy/qFdE8dQ9QCBpl5bl6tPwddrZm//OITKoFad9XpI5oR6I5OB9FTvPzie4k0oOFLjWJYDj1Sm9vM+BDKNL2k4fWyNvXFxcDJALksYtO8YE5REo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WMVOXQ5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC62BC2BBFC;
	Tue,  4 Jun 2024 15:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717515712;
	bh=oGxkaCgbS2IqbLETXH8WRTH3RcDVcBRWmTNg4lWSmQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMVOXQ5w9RfX7ALuuXqlBvV4njc42ArlGrRypZinPClhAqRlFbNEHev7AtNjZwy2T
	 h5SrfsoEIbC3F/D2BsCUDndu43cYb3sNduLE0jGcW/q8K5SjNIML3M6EoqnWNAvi2u
	 9Acl/ssXSgbWwAaQNeekvZHt959i4w7B8SjOJ8hw=
Date: Tue, 4 Jun 2024 17:33:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] kernel/panic: return early from print_tainted() when
 not tainted
Message-ID: <2024060443-improve-undermost-0cf7@gregkh>
References: <cover.1717146197.git.jani.nikula@intel.com>
 <01d6c03de1c9d1b52b59c652a3704a0a9886ed63.1717146197.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d6c03de1c9d1b52b59c652a3704a0a9886ed63.1717146197.git.jani.nikula@intel.com>

On Fri, May 31, 2024 at 12:04:54PM +0300, Jani Nikula wrote:
> Reduce indent to make follow-up changes slightly easier on the eyes.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  kernel/panic.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

