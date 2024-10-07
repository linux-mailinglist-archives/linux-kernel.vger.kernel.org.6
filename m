Return-Path: <linux-kernel+bounces-353132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC49992938
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9D31C2310F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2661C0DF0;
	Mon,  7 Oct 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0gNPDHi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F721BFE18
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296974; cv=none; b=tqDUphSeVBaQDmvex2TtYA7bDU0Kpw2fsetvcwm8NSxMMuLV2DT7wfYEyUv+04GAGE65Bu5hDBggjjXCDaTnxNJqpJwuJrKqTVtqw5UALM9IkHvtRGy2qfmHrrsdKuT2clKZJ7dx4jXMf5PU/dJUDBNd/oC2C6b0obGSiuyEkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296974; c=relaxed/simple;
	bh=j+9Acn5g80rnuNquoPdyftVcOMofnW6vI9n0nIM4bY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ1zI4lFs1zI7UuFP6M1z+dVkcSACL9v3eSh7ON9XklCht3tNDJdjitCQVKApdUTB9PIgE3xCZPzImEtrPGTfB2+7CVKQvlejGRcSgNDh+sOL3oPArWpqKYA8DYgk8J/etvz/rZQGB33TLtV9vrZMf9ZksKbPcBwSqXu+JtEOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0gNPDHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42664C4CEC6;
	Mon,  7 Oct 2024 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728296973;
	bh=j+9Acn5g80rnuNquoPdyftVcOMofnW6vI9n0nIM4bY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0gNPDHi/svdjRjAwplMy1YjZlWPTqXJnGwvRTzKeJ03qwmSl0UEAP27fbuZngDEh
	 q6boMSRpZYmJAj7YJjrMCsndpdNAbHUKArNV9cdbQ3ojPZKkEQKklXn6X5xmi+bfwx
	 zOq+ADmnKHyU/2iRp2u3d0ZVCXjHFfW4n1JMBNdabBvVeo0xlielBgtSSmHVwzSHXE
	 d67/2nJ5bmiPqxx8MlaS7SrPPvdjtnFhKikYtmMZ2WoO22UoddQDf0EIIvyT8EKXjk
	 Wjdls6d4Kx6cLtjq7ahHVHcWHnUTKPMM58LELY2h9cY2Sng+2uILTYPX5+G8zBokuG
	 IKLTn6vR6Jrpg==
Date: Mon, 7 Oct 2024 12:29:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH] ice: Unbind the workqueue
Message-ID: <ZwO4CrZ_c92ZUseg@localhost.localdomain>
References: <20240922222420.18009-1-frederic@kernel.org>
 <db2c96f3-c35d-42ee-a4e6-5233ccbac7bb@intel.com>
 <3ad7ab07-d91f-a3fe-4d0f-5305ae05e65a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ad7ab07-d91f-a3fe-4d0f-5305ae05e65a@intel.com>

Le Mon, Sep 23, 2024 at 11:28:20AM -0700, Tony Nguyen a écrit :
> 
> 
> On 9/23/2024 1:57 AM, Przemek Kitszel wrote:
> > On 9/23/24 00:24, Frederic Weisbecker wrote:
> > > The ice workqueue doesn't seem to rely on any CPU locality and should
> > > therefore be able to run on any CPU. In practice this is already
> > > happening through the unbound ice_service_timer that may fire anywhere
> > > and queue the workqueue accordingly to any CPU.
> > > 
> > > Make this official so that the ice workqueue is only ever queued to
> > > housekeeping CPUs on nohz_full.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> > > b/drivers/net/ethernet/intel/ice/ice_main.c
> > > index ea780d468579..70990f42ac05 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -5924,7 +5924,7 @@ static int __init ice_module_init(void)
> > >       ice_adv_lnk_speed_maps_init();
> > > -    ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
> > > +    ice_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, KBUILD_MODNAME);
> > >       if (!ice_wq) {
> > >           pr_err("Failed to create workqueue\n");
> > >           return status;
> > 
> > Thank you for the patch, it would make sense for our iwl-next tree,
> > with such assumption:
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > 
> > @Tony, do you want it resent with target tree in the subject?
> 
> No, I can apply this as-is but please remember to designate a tree for
> future patches.

Sorry I didn't know about any tree. I can't even find where iwl-next is
hosted.

Thanks.

> Thanks,
> Tony

