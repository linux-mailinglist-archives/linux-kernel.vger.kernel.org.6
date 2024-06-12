Return-Path: <linux-kernel+bounces-212035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE15905A48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D131C21558
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88CF1822E4;
	Wed, 12 Jun 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYAEe1+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5E180A93
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214983; cv=none; b=UJKvf4a1BXf/c1qWmOODwqyScOfk/WdwuGFNNIeO0aMOf5Px4/ATR/PcphZKYGpghqotUz8DUXdb8MOOhfBnmal+OW5MjsMalHtrkYFhok2jc2MJMSp/cLLBsux67CHoaxrSDBOe+A5V9FovVsb5FdTEhBpJFVSXgmEBvapkSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214983; c=relaxed/simple;
	bh=r6sH1CEcOgctzwlUpR1qyRffnvsDcTs8ckkammOcoHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mq9UY+PfM/ZDfCm1XTw2U0IkW5NdD41Y9F993M9CkfNvqoCpa+UGq+7jDRsd8afzLYPzE7Y0jKVfRUtPbTiZTys+ZC5NJMKmam/W6iPhRWIL99n9fz7EwJcCA5pKyBgdf5PRJ8I9yG6iNTbrU72fYElioZNbMWoJFDOc8266TxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYAEe1+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B183C116B1;
	Wed, 12 Jun 2024 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718214982;
	bh=r6sH1CEcOgctzwlUpR1qyRffnvsDcTs8ckkammOcoHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYAEe1+w2PNk+GSiFk/dk0SzNsM1WX8vgODSk9jAi8Ll9c+M3bZ1JW2WWvl7ylkpG
	 oVcpRMojlg2pCREMdge2+a7BBY9t//Ru6dkjavwaQhc27Z2aVzYQ12oIY8l3KoYY5U
	 xj7Rc+rPlqcFpitiIbHfv8+CxcAhYGKknkP27e/f+2i0Ubi+wsh2Evl9InMpiLPN+T
	 gfYc/pY+qW9s+aQJZdPyeQxPKClYTwbSy7NfOAF2REbc8TTDQ5cjPcVPVrOiOYHhu8
	 i8EVlUKcUmn9pM+nr56WGoGG1okdgm3GC96oPfGmGT8OYweaNohcx2xyDK21AKYBMc
	 dc2TDG406MhKw==
Date: Wed, 12 Jun 2024 11:56:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-passthru: propagate status from id override
 functions
Message-ID: <ZmnhRL4q7QOCYejd@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-nvmet-passthru-fix-v1-1-f583f8affa2f@suse.de>

On Wed, Jun 12, 2024 at 04:02:40PM +0200, Daniel Wagner wrote:
> The id override functions return a status which is not propagated to the
> caller.

Thanks, applied to nvme-6.10.

