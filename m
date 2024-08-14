Return-Path: <linux-kernel+bounces-285763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9860195124D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54071284D31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E82E633;
	Wed, 14 Aug 2024 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD/hBeC/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C362943F;
	Wed, 14 Aug 2024 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601932; cv=none; b=vCt68/IUhtrgokCrozd4cFjdy7JIV9oO9q5YkZZkaTLFZAbVEasjLymoqHURvm7bgHTdJAzEUwWmfwWGffiDEr7lbdBx0MViPFN97k98aYqsMqEt/8MmHr/dXS2agj4LGUG/EIqBIMhvGfug6bR0JvlJkCEUdkg2bTJTmDLw6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601932; c=relaxed/simple;
	bh=SYXpdKKAIUAaMVyIUQOLGHSUglp33AepZ89w18ifSmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRjDwnLxPjryD0kkMyIXunmdsswLc9Loh7qOJk6AZoHhi7sOgGq/sU7twUrFAYfqaDczFQnsJbqAVs6x+dfuQ0sWOJXNv5DiqEj3tfjMjbc1Kkxh96154k3QPl64Dvb7MkAlNhyXHE8zfdq8/M+wIX14nWAfkPkQUEa6WjY+/m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD/hBeC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE16C32782;
	Wed, 14 Aug 2024 02:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601932;
	bh=SYXpdKKAIUAaMVyIUQOLGHSUglp33AepZ89w18ifSmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vD/hBeC/kQYwGGdgwg2F1siBMH5FbFMAmwb0EfwSIAEcMQdWalSE1LVApkJABpQjT
	 N+jdTQNNs41B/zxCzu0axloV0m+o3N/vtrNg8cSo6xapJu4xAJ+A5zE9xrZupZ3amE
	 woHpZKWblgCFgQ+DG5r85KaskKbqptgwXHMB6ZC140DPEWqKiaQHSSZulKjthmvUsy
	 Gxi7o/sGvczwtu8KD2tsLU0lj6O/p4xB0oMmpsLoJV6lSFlZKgEe9R8qFxC+v1VxIc
	 4tiBoW1TJbS/vYiJEuCRXxJlELk3sTdCZZvhBN2eHM2NJkypx14CymvGSW9+GjdBPy
	 p8guwfOB7Vm7g==
Date: Tue, 13 Aug 2024 22:18:50 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	=?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Vitaly Chikunov <vt@altlinux.org>, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 17/40] ASoC: topology: Fix route memory
 corruption
Message-ID: <ZrwUCnrtKQ61LWFS@sashalap>
References: <czx7na7qfoacihuxcalowdosncubkqatf7gkd3snrb63wvpsdb@mncryvo4iiep>
 <14e54a89-5c62-41b2-8205-d69ddf75e7c7@linux.intel.com>
 <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e95a876a-b4b4-4a9d-9608-ec27a9db3e0c@leemhuis.info>

On Mon, Aug 12, 2024 at 11:53:17AM +0200, Thorsten Leemhuis wrote:
>Hi, top-posting for once, to make this easily accessible to everyone.
>
>Greg, Sasha, to me it looks like something fell through the cracks.
>Pierre-Louis afaics about a week ago asked (see the quote below) to
>revert 97ab304ecd95c0 ("ASoC: topology: Fix references to freed memory")
>[v6.10-rc6, v6.9.11, v6.6.42, v6.1.101] from the stable branches *or*
>pick up b9dd212b14d27a ("ASoC: topology: Fix route memory corruption").
>But nothing like that has happened yet and I can't see any of those
>resolutions in the 6.6 queue.
>
>Side note: I have a very strong feeling that I'm missing or
>misunderstood something, but I decided to send this mail despite this...
>If something like that was the case: apologies in advance.

For AUTOSEL mails, I only end up looking at the threads when I'm about
to actually queue those commits up into the stable-queue, which is what
happened here.

-- 
Thanks,
Sasha

