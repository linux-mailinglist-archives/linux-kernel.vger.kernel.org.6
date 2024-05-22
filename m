Return-Path: <linux-kernel+bounces-185755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DD88CBA37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE31F21E41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A9A6026A;
	Wed, 22 May 2024 04:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PNEXbRle"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE7529CA;
	Wed, 22 May 2024 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351012; cv=none; b=tn5CHwltDchdwNhmaj73VTL6V9p8uHr7bzA6s6/Dvl2sFEOlsRouRCd9K0xO3Ttp18i20GFHxUZRgDeQNtM+CnbttAO7DJ+o4oA0xXHNlp0eHWIjw3CG0ADA4KXE7RWLZZCoVVxNh3jqtThme61CbcwCM6wXARuyq4l3GVFSop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351012; c=relaxed/simple;
	bh=cJhYFMnB5TSGX6JKW79V6GTSgqLPCROk9zU1RYmQlwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8kTQEsQp1cF89hhtg5DFDrDBX/mXMqv6b9VFAeFq5WbOvpU//YCOK7wY83oizfE9XzrW2x8k87xnLktoL0qF1QTH6H+/2YRYboEKy2NIYU3TJoC5cbGbEAfAGs2gUrw6uQou3bAwEB8vw7uVUfEyTEIny0g3cmgJAG82glKpRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PNEXbRle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE612C2BD11;
	Wed, 22 May 2024 04:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716351011;
	bh=cJhYFMnB5TSGX6JKW79V6GTSgqLPCROk9zU1RYmQlwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNEXbRle4Uj35lOXLaPnRFCFVPgImUiQFDGpM40gcXe65Y7QUZIVkw3k7iQntWppc
	 uuFn1vmB3KL+ePWc2CGk758NQEg06u0zQf3IoUuAFP439M0FAVTE7v6nnSBSX6tDbU
	 ugzYxVb4/JOFozzCL8ltCkr8q2/VTwFKr2m0695s=
Date: Wed, 22 May 2024 06:10:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: CVE-2024-26650: platform/x86: p2sb: Allow p2sb_bar() calls
 during PCI device probe
Message-ID: <2024052216-detest-whiff-15e3@gregkh>
References: <20240326175007.1388794-18-lee@kernel.org>
 <Zkz2qpUP-HVROO1I@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkz2qpUP-HVROO1I@tiehlicka>

On Tue, May 21, 2024 at 09:31:54PM +0200, Michal Hocko wrote:
> This patch has been reverted in upstream by 03c6284df179 ("Revert
> "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
> amdgpu_device_init()"") and based on the changelog the CVE should be
> rejected.

Ok, the original commit here happened in these releases:
	6.1.76 6.6.15 6.7.3 6.8
while the revert is only in these releases:
	6.1.86 6.6.27 6.8.6 6.9
but there are also commits in these releases that reference the original
commit and also say they fix it:
	6.1.84 6.6.23 6.7.11
i.e. commit aec7d25b497c ("platform/x86: p2sb: On Goldmont only cache
P2SB and SPI devfn BAR") so that commit is also needed in order to make
this commit work properly, in other words, the original isn't totally
invalid on it's own.

So the revert is a fix for the original patch, and needs to keep being a
CVE, but you think that the original should not be because it was
reverted, right?

That kind of makes sense, but at the time, the original was a valid CVE,
so we were correct to assign that, what do we do about the "middle" one
here, ignore it?  Without both of them, you might have a problem still
but I guess that's up to the systems that cherry-pick to work out,
right?

Should we be searching the database for assigned CVEs to the commits
that new ones are marked as "Fixes:" for and think about how to revoke
those original ones at the same time?

thanks,

greg k-h

