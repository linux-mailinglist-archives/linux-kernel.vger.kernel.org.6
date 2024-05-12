Return-Path: <linux-kernel+bounces-176793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E18C3513
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25451C2042F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 04:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D96CA40;
	Sun, 12 May 2024 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J814K1vY"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E60848A
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488520; cv=none; b=Ttr8xXdgLAmzeFbtwbCoEyqci/9uNrhj/8XOcGu8n8GQee2CnOdcI2LR6qELM/A3kOU0lJmOFgAB7Mhbvx6AXzmDWB2CZzd+60OtnVCf6Y57Z1AFG8EoD5VPrETpEkp3ZwSd1Bu2k6FP5XkZ24JwWVEqQn8ARHScYy7z8crDIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488520; c=relaxed/simple;
	bh=ulMCzBbIFdRhGWhfVJpOZJ5io1K4e7UnS9N5mBs9sng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSyC/jZwZTRNy49V8sPSV7Ig+a+hvVL31oesRe/qRlL6XsAVT506QAjz6sVQ5VOZAoDI/LFG3wLFSQceYjlEHHy2vpLZQ0Xs2DzIxF4fO8wmRLNz7Vrs5BJLF4SPFSmq1vX6MyC33pLp20RhgncRFg4Cck7sk/od/Ht6pVUA6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J814K1vY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fygat1FqOOoXhqh/tLDzQW+T9tWfbc3cUK44dAWYCEI=; b=J814K1vYc8ZifWfXAtAn8FQ0RD
	vJMbAJSaCt8jOC6njgtk2IoTXZj3Qf/OmgRxkPrPp8+fM3k4b4yAgMCg4w35/7BFvm9Pny2tMq6N8
	q1GltLWRC/XXUKOMcgcgL3nUBHXymBwXcPJ/Hlu3ZMetKYqpeJCFz7KY4B40k8g2CJxN6L/LCoPD8
	t+8mJENcRXcfHphaZvgThMOORkyA6XJa8p6wdzn3Dh/S9yQhOdDQ9zxRXhCnhcepQkHmzLOOfM963
	10kBv0g0UAz9vfgdM/yBtO4JVE34EliWAfiND67FmSdVeLEG8+V/vKSO1qAFSZEOsi23YzzZoz5pj
	4lNjrU8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s60vV-004Ant-2R;
	Sun, 12 May 2024 04:35:09 +0000
Date: Sun, 12 May 2024 05:35:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Joel Becker <jlbec@evilplan.org>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] configfs_{un,}register_group() semantics
Message-ID: <20240512043509.GH2118490@ZenIV>
References: <20240512043012.GG2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512043012.GG2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[now with hopefully correct address of Daniel Baluta]

On Sun, May 12, 2024 at 05:30:12AM +0100, Al Viro wrote:
> 	Folks, could you confirm if the following is correct?
> 
> 1. configfs_unregister_group() callers are supposed to prevent
> having it called when some items/groups had been created under it.
> The original one (in iio) *does* prevent that (the call chains come
> through the module_exit() of modules pinned by ->make_group() for
> the added subdirectory), but I don't see that documented anywhere and
> AFAICS at least in one case (drivers/pci/endpoint/pci-ep-cfs.c) that is
> not guaranteed.  The same goes for symlinks created in or to those.
> 
> 2. rmdir on directory added by configfs_register_group() is supposed to
> fail (is it even supposed to be used inside the stuff created by mkdir?
> Original use was inside a subsystem, AFAICS).
> 
> 3. rmdir that would've taken out the parent group is supposed to take
> the added one out (again, are they even supposed to be used inside the
> stuff created by mkdir?)
> 
> 4. one is *NOT* supposed to use have ->make_group() schedule creation of
> subdirectories via configfs_register_group(); configfs_add_default_group()
> ought to be used instead.
> 
> drivers/pci/endpoint/pci-ep-cfs.c:pci_epf_make() has this:
>         INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
>         queue_delayed_work(system_wq, &epf_group->cfs_work,
>                            msecs_to_jiffies(1));
> 
>         return &epf_group->group;
> 
> with pci_epf_cfs_work() allocating several config_group and calling
> configfs_register_group() to link those in.  I really doubt that this
> kind of "let's hope that configfs_mkdir() will get through directory
> creation in less than 1ms after ->make_group() returns" is the way it
> is supposed to be done; at a guess, configfs_add_default_group()
> should've been used (synchronously), but I might be missing something
> subtle here.
> 
> Comments?
> 

