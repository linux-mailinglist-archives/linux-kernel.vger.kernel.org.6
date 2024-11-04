Return-Path: <linux-kernel+bounces-395577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EFB9BC005
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CBD2825B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA701FCF43;
	Mon,  4 Nov 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR6ZZckc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF561FCC7D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755600; cv=none; b=KUEF8x70W8RByEJuwc6aL++4GNCxrm/E2odbR34iysaqE3cVj0P8OXWYBlTvnLZMG2Hflfo1ZPNndm2kM3+t2ja2oDrobQau8LWSrzyXsYcRJjaOhtVoDQEXvA8WWEJq22pqRMwEGJwU9o3kPZIeDQy2Miar4iU/gCMurfwK6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755600; c=relaxed/simple;
	bh=czF5iClM5SFSIks/goyQRZImaFZN55WN+NlJffmJj8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsyvEOXKpPeqBsOHp+2TGqIGuMBWLrQG9gptsvR//+q0v4j9sww3GyIGl0DuARvxNTvPulFspjzvI+Ml4Dqy1SL+7YpBhQDu2HUHrKEqqQ5PX8RfjqtG4yVElKQuLN0DLoUEb/sQC+e+tuc2AuZjDz8r5SHDQoyO9ylyt69R6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR6ZZckc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B92C4CECE;
	Mon,  4 Nov 2024 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730755600;
	bh=czF5iClM5SFSIks/goyQRZImaFZN55WN+NlJffmJj8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SR6ZZckcJbFTiiKfZU6pXnIlfC509ywE2TYQWPvT9mVReWxVagqamOGysjvsivG5A
	 qQ12c2uLVhanKhGjtGCelNLbVrHqPuR/G/2JL65umd1yXZWj+jkJTQmx4YSkf5f2OJ
	 mtLfHreDMbecRVpfW4slq/lgaDltipH/qptqSJ4mwE4nQKxYULge/NI8dJXLm+ypGo
	 WpE1uRaTtCO5pAqR84coQnHg/hEYb4lBtaZ7eUEMLwZp9FL9Z89sio0XQ965kjU7qx
	 O3OYNumH4l6rCmyToO1tV+aX/vet3c2b8YGBp/sedR5WpUgWqwfqnqLjMPLdrfkBq4
	 +TJC8onVOa3TQ==
Date: Mon, 4 Nov 2024 14:26:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] nvme/host: Fix RCU list traversal to use SRCU primitive
Message-ID: <Zyk8DTLbDP2LFdDJ@kbusch-mbp.dhcp.thefacebook.com>
References: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
 <20241104131652.GB14373@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104131652.GB14373@lst.de>

On Mon, Nov 04, 2024 at 02:16:52PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 04, 2024 at 04:24:40AM -0800, Breno Leitao wrote:
> > The code currently uses list_for_each_entry_rcu() while holding an SRCU
> > lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
> > enabled:
> > 
> >   drivers/nvme/host/core.c:3770 RCU-list traversed in non-reader section!!
> > 
> > While the list is properly protected by SRCU lock, the code uses the wrong
> > list traversal primitive. Replace list_for_each_entry_rcu() with
> > list_for_each_entry_srcu() to correctly indicate SRCU-based protection
> > and eliminate the false warning.
> 
> I didn't even know there was such as thing as list_for_each_entry_srcu,
> but apparently it's been there for a while.  Looks good:

Neither did I! Thanks Breno, applied to nvme-6.12

