Return-Path: <linux-kernel+bounces-333039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966EF97C27C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05A91C20A40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88E31DFF8;
	Thu, 19 Sep 2024 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPO+xZIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C471DA4C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709813; cv=none; b=covxs/pJT+Z2gGOCXC4iYckBdAs6VkPnL1DqBehkVnz+nTt8zOQoZgqwwmaxERxuWFosvFNA2dZQqmGwnlQcZc6HBTNuuEIv7Yj8n2BGZ3PDrkw4r1QHW3QyBVRgyzb/zsTHCTSiVrH5+gYkJGlDyBTQQUfq1UJTeCosS2Ks07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709813; c=relaxed/simple;
	bh=I0UJ2oNGmsWctM1cfjRK+ScHd9ScxRdCDClQVSqtoMg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AA8BIr1kobduKvJ6HRrZJ/zyZXqbR+TNG9Uv5j6weE0mR6dBmtbvlZ54EX9lyF1i7uCxFdlF8X7H6YBFMLXa+EjcrO2NiX81/y7KPcoW8DOsSdw90Dpk5pwGcT/rLPe/Tx7kcUZsQc+mMaf+8F9ppfUu7xM+TeKdz15G56TGXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPO+xZIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AE5C4CED0;
	Thu, 19 Sep 2024 01:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726709812;
	bh=I0UJ2oNGmsWctM1cfjRK+ScHd9ScxRdCDClQVSqtoMg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LPO+xZIonbTu7jEDd98AjIlc0Aei3jl5jX96TQv335DbzvZY8FJ2pcXasymj2/Hpm
	 LUlTIrFEbeP013Q7e1ikwSe3Vah6D6tboUMdjhhhEtgGjCG0K75jnGY0xx3PGaLvzU
	 GHy+SENTd+AS1GYOktdNjdLhYexWpveWtdYa05GYmJWahUUbxh+Qr0/oXwbfj7RUBN
	 JWU+taBcqkFQPybcZTdXdk4qLk9/jeHaTooXhDsSch6w57pECxkVp+Z8JsMZPCUvhR
	 iBZYR4/mdOqIYOAegewDhhYcVt2vnbZ15UI7uVGTLTjqn7waJmUcBXnMKwI2VTvdLn
	 Kuid3GERz9iYA==
Message-ID: <e97b0a37-bcfd-4d85-9d46-af3e82f6fffa@kernel.org>
Date: Thu, 19 Sep 2024 09:36:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] f2fs: introduce f2fs_get_section_mtime
To: liuderong@oppo.com, jaegeuk@kernel.org
References: <1726653980-590956-1-git-send-email-liuderong@oppo.com>
 <1726653980-590956-3-git-send-email-liuderong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1726653980-590956-3-git-send-email-liuderong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/18 18:06, liuderong@oppo.com wrote:
> From: liuderong <liuderong@oppo.com>
> 
> When segs_per_sec is larger than 1, section may contain invalid segments,
> mtime should be the average value of each valid blocks,
> so introduce f2fs_get_section_mtime to
> record the average mtime of all valid blocks in a section.
> 
> Signed-off-by: liuderong <liuderong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

