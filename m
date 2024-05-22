Return-Path: <linux-kernel+bounces-185771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A036C8CBAA2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0BB1C21DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD14770F3;
	Wed, 22 May 2024 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0Ras6IL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55C71B48;
	Wed, 22 May 2024 05:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716354691; cv=none; b=r5FVrJmp3gfDQBwqJ05FqKdHqZscEUsbJzaJhYQkk4iQZiCtdCDvq4VWQun8I/7/YkTN0D0AelHlGj+TxoWMWS+NXaM4za5h78mwDsUN+Im5USCWIQb1wUiaOum5T+QWZKK1xCnFJkyMmrof2iiU17AXBkgMaar3LCTWUAM1HZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716354691; c=relaxed/simple;
	bh=JVZyIr1DcIhtNHmItJ41ELlDSeUv6IkItUGDpVhMZLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcDiLPhw/M8gtEbe7YUWfTW3g9VWQs2BvWtbdT5l9Qhcg8t2SsL30r5haxBLhou3iZcujtOA+9RERhHS/IvaYMNeEw7QAEDTdL8y4aM4D2l+IAK1TZxH2HDzeY6njNu0rZDIJJ2qcmE9touGzQGEYvsGesr/uwYKBEBu7fsF2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0Ras6IL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEA9C2BD11;
	Wed, 22 May 2024 05:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716354690;
	bh=JVZyIr1DcIhtNHmItJ41ELlDSeUv6IkItUGDpVhMZLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x0Ras6ILzs/OoiMScXEf9XexwwOp4iAIuGhJehlZxVQvnTlUDWZfW0TM7ENVVP5kL
	 3KjjbDYrzfhE9i9Iwk6/QuA51evJZ8Z8+m2j/rsxTXYHjdecp3u2RnFLRE57/r8bRI
	 b6QqbLeDXVCSTBlLVnQ8sEq4SKQ701ZWfacK8IEY=
Date: Wed, 22 May 2024 07:11:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-27429: netrom: Fix a data-race around
 sysctl_netrom_obsolescence_count_initialiser
Message-ID: <2024052219-storewide-arrogance-8d54@gregkh>
References: <2024051722-CVE-2024-27429-878c@gregkh>
 <ZkxdqOUek_MHqIMn@tiehlicka>
 <2024052105-pulsate-reborn-119a@gregkh>
 <ZkzGL_vXciG7ipm5@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkzGL_vXciG7ipm5@tiehlicka>

On Tue, May 21, 2024 at 06:05:03PM +0200, Michal Hocko wrote:
> On Tue 21-05-24 16:40:24, Greg KH wrote:
> > On Tue, May 21, 2024 at 10:39:04AM +0200, Michal Hocko wrote:
> > > This and couple of others are all having the same pattern. Adding
> > > READ_ONCE for an integer value with a claim that this might race with
> > > sysctl updates. While the claim about the race is correct I fail to see
> > > how this could have any security consequences. Even if a partial write
> > > was observed which sounds _more_ than theoretical these all are merely
> > > timeouts and delays.
> > > 
> > > Is there anything I am missing?
> > 
> > Nope, you are right, our fault, I'll go revoke this now.
> 
> please also revoke all others touching the same function.

I don't see any other CVEs that reference that function, but I do see
some that reference the same type of issue in the same file:
	CVE-2024-27420
	CVE-2024-27421
	CVE-2024-27430
are those what you are referring to?  If not, which ones do you think
also should be revoked?

thanks,

greg k-h

