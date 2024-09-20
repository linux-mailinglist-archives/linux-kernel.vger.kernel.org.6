Return-Path: <linux-kernel+bounces-334080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165F97D25E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2211B21F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F048D13D897;
	Fri, 20 Sep 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PLD/WHdM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DA13D601
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820184; cv=none; b=lS6win653zRS12C0T2avBIkNXdkpcLhAktkQwk3shuuk+2W0JscHfiqWuL9gyqIVEIy7lQXWGlL+rPLbzDBNO4R3vqCcFmy8QxIz679RuJMr5LtyKLa0scqL26b/JgKJn0vnmJJIkMsmHJGeWmtmS7PJCH88+SJdpYLFAfTEk+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820184; c=relaxed/simple;
	bh=uhJLBaqf7fQu1vn91VTmlfzpROXdkhOI/stXfC48vxo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hfDb8fU66iifBW3UqvzyoeNA1xI6+c962vE8jrBMU2usn0CM1qS4XMc8GfWkbGMpuqKJrLKcqPhvd94m3JLSPDDEju9BpWc/kgq37zVANG6YiDxqlUwlVvAEJHiHtlDobII3aBRAHe7Ir1BhvvHDuzaNr2kNZEXJt8z685ZpWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PLD/WHdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7475AC4CEC3;
	Fri, 20 Sep 2024 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1726820184;
	bh=uhJLBaqf7fQu1vn91VTmlfzpROXdkhOI/stXfC48vxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PLD/WHdMCgrGov5wiwAu+d2Hsli6z/5DkcL3xV2Ww3v8qtzN0YYvKwY5W9jayFW1n
	 6E8WkT/XPPfxvtG+1aNUjyT9vlokTXHd7OxT75SdGJzIrZNVYEBQrbRfNM96IO+7us
	 xcm0JZi4G8eUe4xZCMFzSSu1y86kkyKmIT2jr1us=
Date: Fri, 20 Sep 2024 01:16:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Saurabh Singh Sengar <ssengar@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
 "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "cl@linux.com"
 <cl@linux.com>
Subject: Re: [PATCH v2] mm/vmstat: Defer the refresh_zone_stat_thresholds
 after all CPUs bringup
Message-Id: <20240920011618.bb2d2a247ae59810aee6c39c@linux-foundation.org>
In-Reply-To: <SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM>
References: <1723443220-20623-1-git-send-email-ssengar@linux.microsoft.com>
	<TYZP153MB07963DDE4B7E01C575B143E2BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
	<TYZP153MB0796B44322EAE4C712883201BE882@TYZP153MB0796.APCP153.PROD.OUTLOOK.COM>
	<SEZP153MB0791CB961FF0D1512DC47164BE632@SEZP153MB0791.APCP153.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 19:52:45 +0000 Saurabh Singh Sengar <ssengar@microsoft.com> wrote:

> > > >
> > 
> > Adding cl@linux.com instead of clameter@sgi.com for Christoph Lameter
> > 
> > - Saurabh
> 
> Hi Andrew,
> 
> Can we get this merge in for next kernel release.
> Please let me know if there is any concern with this patch.
> 

Anshuman's review comment remains unaddressed:
https://lkml.kernel.org/r/b1dc2aa1-cd38-4f1f-89e9-6d009a619541@arm.com

Also, Christoph's observations from the v1 patch review haven't really
been addressed.

So it sounds to me that an alternative implementation should be
investigated?

