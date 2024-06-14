Return-Path: <linux-kernel+bounces-214410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5C09083FE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE351C22173
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894561487EC;
	Fri, 14 Jun 2024 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LqO4aDAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFD142658;
	Fri, 14 Jun 2024 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347893; cv=none; b=H1Ul+pAR1HI0Vx/W3zp04hYW+vwn37FywGMixsKjtjMx9ikA/kUIrPJzUFR4EWNC414NTJ8zIw4vW9ewXdYuNKgHVmgylbFYL6CX59809OYnKWRcpuXZvZ8mYNL9Ua8Uwp1O6OAC8qLPM98RnlaciERr7DtPoLh79YjbqU51NEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347893; c=relaxed/simple;
	bh=/+1eONkvO8JIY6Rq6EFqoF9/NIO8BCLXFebfthtEbz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpOeH/mn5HhEAelPr14Ib8f68N6l6VTJdADxFLiXyXknNj4zW2Hk5yTj8P/c4hvIgZmrQM2GjRaGwvx/aDoHVJ70Y0tvSj3n/kROoH8SkzCy5Pj/08O2PcGpsaZcdRDbn9lu0Ws4lTy44l4S5YkJoARgHH0CG5fECqNyKXCXmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LqO4aDAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5345C2BD10;
	Fri, 14 Jun 2024 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718347893;
	bh=/+1eONkvO8JIY6Rq6EFqoF9/NIO8BCLXFebfthtEbz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LqO4aDAc5EJeBru60s3VDteNr8FP8TcHSBS+YrgCalnJneAKc5gQFohUptGp7gr4x
	 SSvmuPn2+uAsqWL8PnEGI/C4filgCCH+z5ZPNeKBVr+NR35hT9XfcpdIU1OFSGQlI6
	 3X0tW8PQOYIFTHH74dnrZgt2tGwyqb83wwiYQVJA=
Date: Fri, 14 Jun 2024 08:51:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Teddy Engel <engel.teddy@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: rtl8192e: Cleanup multiple issues
Message-ID: <2024061403-obedient-decoy-d3eb@gregkh>
References: <cover.1718291024.git.engel.teddy@gmail.com>
 <ee01dbd2-fe83-46cf-9ceb-279a06ce9aad@gmail.com>
 <c0f2bca8-a7e6-4874-b5fc-98911a7c09d8@moroto.mountain>
 <CACP1t+uF6R6zDNDsL-ZZOnvWM-t2w097P0tMpxuSsj7=AXvJGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACP1t+uF6R6zDNDsL-ZZOnvWM-t2w097P0tMpxuSsj7=AXvJGA@mail.gmail.com>

On Thu, Jun 13, 2024 at 08:34:37PM +0100, Teddy Engel wrote:
> On Thu, 13 Jun 2024 at 20:22, Dan Carpenter <dan.carpenter@linaro.org>
> wrote:
> 
> > On Thu, Jun 13, 2024 at 09:05:03PM +0200, Philipp Hortmann wrote:
> > > On 6/13/24 17:16, Teddy Engel wrote:
> > > > Remove some unused constants, macros, and structs.
> > > > Capitalize a constant.
> > > >
> > > > No specific patch order required.
> > > >
> > > > Teddy Engel (6):
> > > >    staging: rtl8192e: Remove unused constant IC_VersionCut_E
> > > >    staging: rtl8192e: Remove unused struct phy_ofdm_rx_status_rxsc
> > > >    staging: rtl8192e: Remove unused constant WA_IOT_TH_VAL
> > > >    staging: rtl8192e: Capitalize constant RegC38_TH
> > > >    staging: rtl8192e: Remove unused macro dm_tx_bb_gain_idx_to_amplify
> > > >    staging: rtl8192e: Remove unnecessary pre-declaration of struct
> > > >      net_device
> > > >
> > > >   drivers/staging/rtl8192e/rtl8192e/r8190P_def.h | 8 --------
> > > >   drivers/staging/rtl8192e/rtl8192e/rtl_cam.h    | 1 -
> > > >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
> > > >   drivers/staging/rtl8192e/rtl8192e/rtl_dm.h     | 6 +-----
> > > >   drivers/staging/rtl8192e/rtl8192e/rtl_pci.h    | 1 -
> > > >   5 files changed, 3 insertions(+), 17 deletions(-)
> > > >
> > >
> > >
> > > Hi Teddy,
> > >
> > > please combine patch 1 and 3 (Remove unused constant ...) . You can
> > change
> > > more than one item in a patch. But it has to be of the same kind.
> > >
> >
> > Could you combine that with the earlier patch that deleted
> > IC_VersionCut_C as well?  (Unless that has already been merged).
> >
> > regards,
> > dan carpenter
> >
> > Hey Dan,
> 
> I registered to the mailing list (very) recently so unfortunately I don't
> have that change showing in my mail history...

lore.kernel.org has the history of the list since it was started, no
need to be subscribed to see everything that has happened :)

thanks

greg k-h

