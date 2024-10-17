Return-Path: <linux-kernel+bounces-369322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D89A1BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559BC1C21D63
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFABF1925B2;
	Thu, 17 Oct 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmDW5gtJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8F39FE5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150611; cv=none; b=RamWmT/JjE86IjLvUbXlG1NkyQXjwpcm1UvegwuvZBHKiNphb8TGKJcbBkzhznPF/trClRhE7kWptvFHTqD//l3EzFSs+pZwnLK6J5pcXQIXZ9pxpyRr5xXkAhjxQfGkWuVTFvEbSXaUDOjtIGeWfGSAfdYhHNtCCnB8qtgbkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150611; c=relaxed/simple;
	bh=DZW8tP1ExDwXOCc9NFCPeno7zioU/xqa4Gnd6frTMAY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HHUstpoSBqWcLhY1sn8D+28M+R9emajZU7F8T6OXDWBGdX3YGikmO8z3Z8iLxZgKC3nxZ/qCqapGNOknIrRx7J+G2EfunPud5EmuaR4qVO799b7gGxPyNRyZopF4HmRXgmLTTjrNpSrERJmDY8+P9H8XDYKyK0ga+RB1PmG+Nvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmDW5gtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F4AC4CEC3;
	Thu, 17 Oct 2024 07:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729150610;
	bh=DZW8tP1ExDwXOCc9NFCPeno7zioU/xqa4Gnd6frTMAY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CmDW5gtJs+QfR20iowIOMP8F+FXpQPYhNjdNz3mA5QiwP/ysIXyxxViYBsRkGivEX
	 Sxb/HRaVgFUeBkkXnkt3MTEEmrX1Lc76U2pOraohHb76hldUJ0rcEcCnSettmWtdbu
	 CLKhOKcpYQHai9neCzmZMqfrmf7bH0/dg7eWdbN57EmVFX3cRC0e4xBjSFGLsoiAKw
	 TK1/vxIvb05ygk4Ef3tGR5O/GIBbWpqilRe8uvZ712U8u52Flk3RE0dEqylp50nIen
	 L+z2Rjj80ZS2P5hJYyo6Ta14GUQ/eiEfp+ORuy7UgP7Zqu8Fc8R15A9gtDN4R8PyYa
	 sBmI6qwsTuFlg==
Message-ID: <40d285ce-d2c5-4cb0-9040-fd35f9e14159@kernel.org>
Date: Thu, 17 Oct 2024 15:36:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: decrease spare area for pinned files for
 zoned devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20241015165427.1158782-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241015165427.1158782-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/16 0:54, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now we reclaim too much space before allocating pinned space for zoned
> devices.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

