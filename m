Return-Path: <linux-kernel+bounces-416219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451C39D4229
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCAA1F23994
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789719DF4D;
	Wed, 20 Nov 2024 18:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wx+wAVwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF520B22
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128292; cv=none; b=cn5OJd7WvnlFUbFLVowqRGEuTKyHg5FjOBFLYJTkFDTynKNxwqUqHk9frv26SBPAV09zg/VjZm5l69D/BaddOJomNvIEi448VxNcCvYggiTnMlIqU552cBjtLf6OzbEP4gpk0lJ9jVxvI2HUkPQnuVt3UofQa7KvCcOEVRK/c4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128292; c=relaxed/simple;
	bh=B21EgymTmcGOhy1UvBRVGTv4bnnG/EQbIXgGJ4nsO10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9/P0tq2DWoMNTXFt2SnF5c7WamgTnmuy6K0Ydn0UEoygk4kGZPXsIfbq66NRWwxbWxpaWelVXZOAEv17pfJ+1oU/dLOF+0IDx44wYVrSBSK01BfA2/jcVgAF3EpYoVrpp2EUSepsk3kUW1hy0pP26SZmpkOW/mxQmuh52I+LQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wx+wAVwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC01C4CECD;
	Wed, 20 Nov 2024 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732128292;
	bh=B21EgymTmcGOhy1UvBRVGTv4bnnG/EQbIXgGJ4nsO10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wx+wAVwHGVZXt8ubFvTMZ+Lz66MNnfQkHKV6TBFd5iIPg13tdSeZ0/p8HaMdeIgq/
	 XVL5LEzS9X0Fik3g1APUNr3HGeaYMRXBZHo9pyyvWGDYy9L/SzrAGXTzmU0iaHVp4H
	 /bweM/UnSDAbjP+iLspKQHXc5oVmdOpj94LfE4xrcAMPyWO/xCmWj886HDF5BITaHC
	 QltaQmsub8E6hg0/yb3zIpAXWpIyYTkMG7WR/116c4b6OH8qgLfNxTwLHi9XWZbkWm
	 G4aKwYFJdah1C77Tusv9aRE5g66q8zA+vjMuyAlnJC4Ha5Nywnkxroiz1LXI9OJ+8o
	 Qk9qlJbWFmPYA==
Date: Wed, 20 Nov 2024 10:44:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Stephane Eranian <eranian@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf/arm-cmn: Fix arm_cmn_node_to_xp()
Message-ID: <Zz4uIoYS0fhJZTi3@google.com>
References: <20241120164110.266297-1-namhyung@kernel.org>
 <bb01b83a-32cb-4efe-b9d6-06a4cf138b3b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb01b83a-32cb-4efe-b9d6-06a4cf138b3b@arm.com>

Hello,

On Wed, Nov 20, 2024 at 04:55:04PM +0000, Robin Murphy wrote:
> On 20/11/2024 4:41 pm, Namhyung Kim wrote:
> > The portid_bits and deviceid_bits for XP type nodes are set in the
> > arm_cmn_discover() and it's copied to others in arm_cmn_init_dtcs().
> > But to get the XP from a node in the arm_cmn_init_dtcs(), it needs
> > the {port,device}id_bits.
> > 
> > This makes arm-cmn PMU failing to count events on my setup.  What we
> > need is the number of bits in total which is known by the cmn config.
> 
> Hmm, what about just moving the assignment to a point where it actually
> makes more sense anyway?

Yep, this looks good to me too.  Do you want to me to resend this?

Thanks,
Namhyung

> 
> ----->8-----
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 397a46410f7c..30506c43776f 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2178,8 +2178,6 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
>  			continue;
>  		xp = arm_cmn_node_to_xp(cmn, dn);
> -		dn->portid_bits = xp->portid_bits;
> -		dn->deviceid_bits = xp->deviceid_bits;
>  		dn->dtc = xp->dtc;
>  		dn->dtm = xp->dtm;
>  		if (cmn->multi_dtm)
> @@ -2420,6 +2418,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
>  			}
>  			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
> +			dn->portid_bits = xp->portid_bits;
> +			dn->deviceid_bits = xp->deviceid_bits;
>  			switch (dn->type) {
>  			case CMN_TYPE_DTC:

