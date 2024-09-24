Return-Path: <linux-kernel+bounces-336696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C933983F68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3061C227F0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9714D290;
	Tue, 24 Sep 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q7qLQLlK"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE051494A6
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163629; cv=none; b=PitvGU3ahQrZlueg6MQIHP6RCmQiSgDiis1rRSVFAp5gywPpnFEbiwEMy+KBPdbczBsQioKPDwBmEDIPj6pEhwebKvK7RZ4NA6gjGPd3O36qt/jnCXKs3sV0jRJfuYNh+jPc3gYuQGF14Om/MoCR6RjPHFz0XhVIbIQ51qT6DNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163629; c=relaxed/simple;
	bh=2qQQxBbciGtWxdWMpPmrZdihNyJXEerOSDHIC2hNjdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwRvliPTk4RvEm1/gjKvTyZEU/6FGly3bDw4ePPSav1S1SWyQ6uOMZmLBrJF5A2b9CmjIj8asNrqJ3ghJaudlWa+Uad+xmxeGHVTyEyW8fGy82UkWK1aUS0HAga0IhsDYoRvervXCoGu6d5861CG6F9n7FVsoWr0WSV/wZ2yfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q7qLQLlK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id BAB0F20C648A; Tue, 24 Sep 2024 00:40:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BAB0F20C648A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727163627;
	bh=PSt5LBUMhrB6wXEJi546tDg9ubjit9ih3txNKXtkuQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7qLQLlKDc3spENDcfqIw+lpTn1FTHULs98IV3MOz6BJLXDzdaynA3/OORlcag7Ft
	 HhFlQub+8fqMvWDIijviCqK4hAeyFq8cYpwFmb3rhs2QKBygrqVxGoP1VGeL/FRnnX
	 /ielbHAAdG/r/WL5M9xY2aIEt+xUw6wff8qv/LLE=
Date: Tue, 24 Sep 2024 00:40:27 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Message-ID: <20240924074027.GB22582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
 <TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
 <SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM>
 <20240920011618.bb2d2a247ae59810aee6c39c@linux-foundation.org>
 <Zu0/nKB5oRF8Yvdk@csail.mit.edu>
 <529015dc-403c-7cc0-5b66-95739e1c78d2@gentwo.org>
 <8ca7bf74-c6c7-405f-baff-adebd8957620@csail.mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca7bf74-c6c7-405f-baff-adebd8957620@csail.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Sep 24, 2024 at 08:26:12AM +0530, Srivatsa S. Bhat wrote:
> On 24-09-2024 01:47, Christoph Lameter (Ampere) wrote:
> > On Fri, 20 Sep 2024, Srivatsa S. Bhat wrote:
> > 
> >> @Christoph, would you mind giving your Ack if this patch v2 looks good
> >> to you, or kindly point out if there are any lingering concerns?
> > 
> > V2 looks good to me (unitialized pcp values result in slow operation but
> > no negative other effects) and the late_initcall() is always executed.
> > 
> > Acked-by: Christoph Lameter <cl@linux.com>
> 
> Thanks a lot Christoph!
> 
> Andrew, could you please consider picking up the patch for the next release,
> now that all the review comments have been addressed? Thank you very much!
> 
> Also, I'd like to add to this patch v2:
> 
> Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

Thanks Srivatsa !

- Saurabh

