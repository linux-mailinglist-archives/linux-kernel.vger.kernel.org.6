Return-Path: <linux-kernel+bounces-194620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672518D3F04
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170A6283973
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3218E1C232B;
	Wed, 29 May 2024 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MnYs/3Ob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FC7167288
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012081; cv=none; b=XfN5JaGmza0w7vCCj1QnJspgaLNX4MzoyY/wx/b/I+ZsjmEV5lsTzP1MnMcC1wFY4dlsJcYi9lEDC2hA5APQksCoYIzIED/+JF2a/a/e4waE4wjFj1RbFz5FhXqHbn2ga3qBG1y0D6s9omshvPgP27wmDHscCSshNIqSLJVuuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012081; c=relaxed/simple;
	bh=AtpbuT9ocfyuCImB7FopcXXI7a9HUm1xc1vYTywkOQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgrcODcTMgirnbnWPdY8b+ysu9+NKFZsiqW9aTfzz2BmJAAi3EHTf+VUf/pQMRnhmZ1Gxwv2WUdczaxDHRYzQCJE6EGvvwkIV/q5p7Dh3ToA/yM4i8ifDmPWcMdz+42/25V2W9riuMZfVzu2YdrRotZmTKgDvJz8pF02sVTGTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MnYs/3Ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B90C113CC;
	Wed, 29 May 2024 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717012080;
	bh=AtpbuT9ocfyuCImB7FopcXXI7a9HUm1xc1vYTywkOQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnYs/3Ob/A0wKPM6dYRhnBelFPdHZW6ShY1zWopmG0iOSxXMEiG4+9KDD1YZocUdA
	 KR3vjc4Z1VBgcLALDQzs+r8F8pEkQ6vpEe8OvgZndO1x9oXwUw7gcl8DSugFLInksQ
	 lzmQ4mfckmcFuyvNXa9rMtbSfqxnRssDqsRmkMp0=
Date: Wed, 29 May 2024 21:48:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Suzuki Poulouse <suzuki.poulose@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: Fix ref leak when
 of_coresight_parse_endpoint() fails
Message-ID: <2024052957-overload-darkroom-8c4d@gregkh>
References: <20240529133626.90080-1-james.clark@arm.com>
 <ce2530fd-d91b-4629-944f-9d7c6826aaa9@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce2530fd-d91b-4629-944f-9d7c6826aaa9@web.de>

On Wed, May 29, 2024 at 09:30:11PM +0200, Markus Elfring wrote:
> …
> > Fix it by dropping the refcount in the exit condition.
> 
>                          reference counter?
> 
> How do you think about to use the summary phrase
> “Fix reference counting leak in of_get_coresight_platform_data()”?
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

