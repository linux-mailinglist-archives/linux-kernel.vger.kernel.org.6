Return-Path: <linux-kernel+bounces-357172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D9B996CE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E301F23DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6BB199920;
	Wed,  9 Oct 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f5/KPgYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FF1946AA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482204; cv=none; b=CMoQKgRGIE88sauTTSvr2yKhvOawZINjTOgvufgGpqvMO4uYSvXN7YjiHdjBddFZ+lE6AG4auvZ1Zs++Aoo2myVnIKtniIvA8QQksk2Ssb6+tf02YsNXJFlwGGSDBbE5+VwA7MDQzf5wfgxTIcZzyzndCIcEdzDbgvaqZGV16R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482204; c=relaxed/simple;
	bh=f1WNeDQy81Nf04b9aTKMhVeGeJr6Ew198lgSZ1UNL6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL0qvE0Sf/QEnUaNnzUJ6/xsAvhkMrZekKeLbMFy/Ybu9qCh5DuX5a/gd2TjeHF6nLjui8S/GHtcwqU+0Kag9aKUpzqbrRrJ00XQVeElr2wNYhr3r0v0Uk6XvP6M0kPsIB4gPiwOVR4Uen3xTxcxy7ga6t6DbWjtFbRA+Q8C4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f5/KPgYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F22C4CEC3;
	Wed,  9 Oct 2024 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728482203;
	bh=f1WNeDQy81Nf04b9aTKMhVeGeJr6Ew198lgSZ1UNL6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5/KPgYw2Yw6U2tUPnniHoYkaNHeHG7JXquqyK8Jl+3CC90uOYyVJrbuns7J3yYIh
	 ZyQKltfNH4wGIhaNYYU3ZhjkjLjff0i+kdzf03po79SB+xdDIFnfL84G9Mymj9fffK
	 PxOfPeSjUmQ3RADYCp7YZvHTUUi8zPwMUcxgzBxk=
Date: Wed, 9 Oct 2024 15:56:40 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-42308: drm/amd/display: Check for NULL pointer
Message-ID: <2024100917-launder-hamper-723b@gregkh>
References: <2024081751-CVE-2024-42308-562d@gregkh>
 <2fc2ba4addfbe40f7de3a5dfb146a3bdd3fc3edf.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc2ba4addfbe40f7de3a5dfb146a3bdd3fc3edf.camel@oracle.com>

On Mon, Oct 07, 2024 at 11:01:59AM +0000, Siddh Raman Pant wrote:
> On Sat, 17 Aug 2024 11:10:13 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > drm/amd/display: Check for NULL pointer
> > 
> > [why & how]
> > Need to make sure plane_state is initialized
> > before accessing its members.
> > 
> > (cherry picked from commit 295d91cbc700651782a60572f83c24861607b648)
> > 
> > The Linux kernel CVE team has assigned CVE-2024-42308 to this issue.
> 
> This commit is no-op / doesn't make any difference, as there is an
> implicit NULL check rigth above it, as plane_state cannot be NULL
> (checked at the start of function).
> 
> So this CVE should be invalid.

Yeah, tricky code, I see why the static tools got this wrong.  I'll go
invalidate this now, thanks for the report!

greg k-h

