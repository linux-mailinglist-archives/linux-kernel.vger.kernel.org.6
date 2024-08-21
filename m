Return-Path: <linux-kernel+bounces-294844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C195934D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81375285B70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05C158528;
	Wed, 21 Aug 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JhU4sxV9"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277B157467
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724210421; cv=none; b=NS4SHyTnoIOC+ak0s/B5D+XTpimanbm2tJQcRW2wpqgy/pEskjOyJENNUibunAp9rB1W2Z1wKPz8RLUaHE2pIcfPYduRvWIx9/Q0fLWlD+yiHzzfkm7/YhpFVPohIrHD1xB49LEo3xR7aHeWZ7M0thwAM2+D/TlWVg6Cbbpw1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724210421; c=relaxed/simple;
	bh=VsXRTEDQwNH8m6AaQpm31ch4vkuZRGtFm/T6sL41ip4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcejkK7mCifW83XtUCJcQ0clAS0ATqtUuHZ3+goeFExkQq+EBUCQDzomqacy1h24o9ps+lhaJRtcHK9LxAtxBPmQJ6HpgP2XtSuJXSjRcn1rKOn7soJbj2Srg+06vM6/V4PIYYM/PmtN97bpVutqqfFTslXOH+4SGSCBABE8Pwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JhU4sxV9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47L3JcjU024064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 23:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724210382; bh=f4PakQ5bnKjiLKXKzLV7pR83jIv0eJHYGpCo+y8ltbI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JhU4sxV9ziSVg3D/3pDrj1UVqfvWAcdnUxnPpfeu+BJ2+8NGz80VxZbSYjYHz5Yz0
	 xud4U0rddH3hDZMrMm2+SkPIRSCRxGe06w3EJzW0brocgl+ImAqN8/zg8+pC5r8iCs
	 rbzHdPqEw2+LVNTMuP5L3roiEryQEpCUKV844OFKyUofBtNMvzfrfRVCkHp784uMYq
	 Q+0lBOCcmwt5IHqk/zB6H9cVeZSfq+tWIS8aBF4C83coYZxGzol8gcJPXPC2aFXxGL
	 4vEdTDOzENBphXeklhfy9L5klP5OJa4Yi1/s8BdrDNZjMB8ujMwogpd26wpLFTopnc
	 B8ARU7Me6EIig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 73AF015C02C0; Tue, 20 Aug 2024 23:19:38 -0400 (EDT)
Date: Tue, 20 Aug 2024 23:19:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Baokun Li <libaokun@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 12/20] ext4: get rid of ppath in ext4_split_extent_at()
Message-ID: <20240821031938.GA277453@mit.edu>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-13-libaokun@huaweicloud.com>
 <20240725110756.fuyjfdvgbprma5ml@quack3>
 <84d1cae3-1939-463c-b1f9-344e02f87a9c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d1cae3-1939-463c-b1f9-344e02f87a9c@huaweicloud.com>

On Sat, Jul 27, 2024 at 02:42:50PM +0800, Baokun Li wrote:
 > 								Honza
> Ok, I'll put this in a separate patch in the next version.
> 
> Thank you very much for your review!
>

Hi Baokun,

Did you send out a newer version of this patch series?  I can't seem
to find it in patchwork.

Thanks,

					- Ted

