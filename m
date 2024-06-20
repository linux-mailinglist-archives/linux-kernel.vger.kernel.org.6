Return-Path: <linux-kernel+bounces-222382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E566910094
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE9B214E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC681A4F10;
	Thu, 20 Jun 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wAgoNhGR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19FC47772
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876501; cv=none; b=t7vHfDkif4ZX3GafyvkR0OtS8dcC2IM6wLU/0gy8ijE5mUBzAfQhyH5OmR1hwcHHbjx5UOG7meiwl28f2EwpmSp6c9wQX5D0CKYD+jGZ3GGVmdS7QZVT8W71hVPTkFTQsG08/ite2JOMTFsIu0DDvJkKy4d5qvlg+U16fPbLrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876501; c=relaxed/simple;
	bh=1eugF1z4Brh/DZEVuJw15S50aNzF1e1G6Bt2ePznUJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9AQ3J5umNrAKyFnkupQ/mRjHvMaZ/WCCH0T3eKbRDcB3pYUqYkcqqlVBRGb7gPVOBImcRmijDoTbVXJ4m+70W6bHVxK+9pnviolV0WuHlqMKLRfSl0k5mVst8gx3mxO5wnv6ipwfg+aqQf94/xZ/1gaqrHru4mQJEJbBXQcnO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wAgoNhGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FB3C32781;
	Thu, 20 Jun 2024 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718876500;
	bh=1eugF1z4Brh/DZEVuJw15S50aNzF1e1G6Bt2ePznUJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wAgoNhGRNk11hcX31Bo3yZPN040ZRSMCRyIB5ZqauXNb/f0S3n7Rnpkb2aFUhIg6w
	 6g7yItcVm0mdICpyrcP55ETOAXhdOVHBl5qrOv2GoBYIuc40TU5PHF9HjKZVTypU1z
	 RwgzkEQaHVO8zC+0yrbrZ8cPf3spoYyN8l6EcAjE=
Date: Thu, 20 Jun 2024 11:41:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Beulich <jbeulich@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	"security@xenproject.org" <security@xenproject.org>,
	Juergen Gross <jgross@suse.com>
Subject: Re: CVE-2021-47573: xen/blkfront: harden blkfront against event
 channel storms
Message-ID: <2024062001-jab-eliminate-5198@gregkh>
References: <2024061911-CVE-2021-47573-5c43@gregkh>
 <769040d1-fc9c-47a7-a4b5-93c693472624@suse.com>
 <2024062034-pork-limes-2c4c@gregkh>
 <ac40bf5e-6537-4ef5-bac9-afbe512a9d70@suse.com>
 <2024062025-uncivil-sterile-03f7@gregkh>
 <92819ebe-8895-4c61-825d-4bd56aac38ad@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92819ebe-8895-4c61-825d-4bd56aac38ad@suse.com>

On Thu, Jun 20, 2024 at 11:32:49AM +0200, Jan Beulich wrote:
> On 20.06.2024 11:20, Greg Kroah-Hartman wrote:
> > On Thu, Jun 20, 2024 at 10:46:10AM +0200, Jan Beulich wrote:
> >> On 20.06.2024 10:18, Greg Kroah-Hartman wrote:
> >>> Also, the XSA-391 announcement doesn't say anything about them either,
> >>> is that intentional?
> >>
> >> If by announcement you mean the email sent out to xen-security-issues@lists.xen.org,
> >> then the copy I'm looking at (v3, the only one having gone public afaict) clearly
> >> lists the three CVEs.
> > 
> > I'm looking at:
> > 	https://xenbits.xen.org/xsa/advisory-391.html
> > and I don't see a git id anywhere, where do you see the v3 announcement
> > saying that?
> 
> Hmm, okay, I then misunderstood your earlier reply: I was assuming you
> were looking for the CVE numbers associated with the XSA, as I thought
> that's what you need to know when deciding whether to issue one
> yourself. No, we didn't ever mention commit IDs anywhere, except when
> issuing XSAs after-the-fact (i.e. changes already having gone in earlier
> on). I guess we need to see whether that's feasible to do for Linux XSAs
> going forward. Yet then it may not be needed there, as we'd now ask you
> for CVE numbers in such cases anyway?

Yes, going forward it's not going to matter, I was just trying to verify
that when I assign ids for older stuff like this that I'm not messing up
in an obvious way :)

thanks,

greg k-h

