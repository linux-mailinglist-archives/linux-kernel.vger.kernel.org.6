Return-Path: <linux-kernel+bounces-275459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F16948604
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86613283C10
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7716FF48;
	Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmu3QSVQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28A155742
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900652; cv=none; b=o3AuNRVAJjyQbLvwP9kUUDZpE4ChqsmOyWIVPNQT1degsC7wnAexowi2P0CvJX3zH9osMDcQjqqfVMhWNC6cd5telKasZ+DVZyZbVJuKk9ENiscZaFz14LbJVHLn++73SbqaDfMzHexLSEJRANW9ZRzEVLCZSttbW+Hfvs0GcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900652; c=relaxed/simple;
	bh=xzNGl89zVvIazdPP5LBpjcHh0SLwpBHsnybbnibfu74=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ut8UMCzloDztj1CF7UrOyhK2apmx4yByyVOTvTenI6DSs3m1CMBT/xkjuB34Dl4HmNaMJPuoyZAFU7H3E3oc1efyemcvKea4AHsiN20GqimfJPixbYJhWCeT51NA6qsuRvJ33fT5uXH04+BmUGNV6wnH1CUX5DcKNkoBn38+vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmu3QSVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F033CC4AF16;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900652;
	bh=xzNGl89zVvIazdPP5LBpjcHh0SLwpBHsnybbnibfu74=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rmu3QSVQnu7Vp0NYxILPTbOw1JPAkVnDXFY2R35Y2pF/7B4JhTz3N84CaUzGK2D02
	 0f26cWdQzkHFGxPa44wEZ9YSd+fQG6kXt4G97h/KsQXsODn9KqY7S6mB911VTzXMqI
	 9FA+6l5gCdNmKpQrlV11uWTFQaA1E6sHHUPMFJ9AlteiZ4vCJFcL++lc3DwxZEZ5Xu
	 VA3K3kBS/hDT2vDTdqvx+1HNHENl+mPEFEsEETXO9OCMklMU8XJD7SA8IqFv6iP/9l
	 uIniQlrccXMl/MyOHLnDQ5pXsqA6Pym9HzXewE2t8HBkJqL8fx4VZerg4Kqv+BDySc
	 SrRprRFyIlODQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D789AC3274C;
	Mon,  5 Aug 2024 23:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs: clean up data_blkaddr() and
 get_dnode_addr()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <172290065187.2803.6622795747544995557.git-patchwork-notify@kernel.org>
Date: Mon, 05 Aug 2024 23:30:51 +0000
References: <20240711014632.3927676-1-chao@kernel.org>
In-Reply-To: <20240711014632.3927676-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 11 Jul 2024 09:46:32 +0800 you wrote:
> Introudce a new help get_dnode_base() to wrap common code from
> get_dnode_addr() and data_blkaddr() for cleanup.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - clean up get_dnode_base() and remove redundant declaration suggested
> by Jaegeuk.
>  fs/f2fs/f2fs.h | 46 +++++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 29 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2,3/3] f2fs: clean up data_blkaddr() and get_dnode_addr()
    https://git.kernel.org/jaegeuk/f2fs/c/2cf66b9de406

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



