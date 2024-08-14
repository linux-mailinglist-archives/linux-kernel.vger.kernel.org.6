Return-Path: <linux-kernel+bounces-285822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C794951335
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DF1284E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AA539AF4;
	Wed, 14 Aug 2024 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a03hsD1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B8394
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607195; cv=none; b=iKOs6NGHoLTcUo2mOQCTaWF4WnXOnUsFzHlp81mCFW2BxPp0YJOb3ZIbLuCK/T/ldGMok1Xk9Vqr2+6pujZeI/dK1Dl/smgW/pA5M1H+iStfs5wxUPoOkLSB/8kE6UFPSPzYSvdVjcfwTo9n0FHxAPyXIq4Wjk7EFt1WlGbl3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607195; c=relaxed/simple;
	bh=QKqipaCiujhLLpOhsTkVEy6yCbaQiIY6pdBvzPXLQiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwxYXho0a4GFuUCrDssU8nmoHf3KFsMUInRRb0fcdHL6EWuUktb3nC/f9Cx42mZcE9zJGff71CA9HmhhxirhhsHaiMwa/zeLxSrOPq7S/KXHHBp9iAx7ylHFGz5ynK5HPzq2+SHavxiSSxt1+q3edv49DgfmBLe/+J+X6jDWv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a03hsD1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1939C32782;
	Wed, 14 Aug 2024 03:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723607194;
	bh=QKqipaCiujhLLpOhsTkVEy6yCbaQiIY6pdBvzPXLQiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a03hsD1DeWZTfBF803fZF2XKKQgMWa1QTNW+Tp0G8KaTEbuQC+d/0hBatJ97JXbPX
	 /Eb1e9zD/YnC/ugLjcd2rh56khJMmrwbZNZ6keDGLsa7KwbvPDG1xgRNsim+sxLX5m
	 MUklPoLPI6oax+6/dqGFNYvxUguCXIrThqCvKnStlya57lG40/b8TaA4tZHY0rDZt1
	 3fRFnUfNv7qY+GROFYwD//7pL4E7c+O/i/DpkEfvsSm8x+PrjUGZ4IM3itn1g1IURU
	 tHtznCYLG8soJoEaLyizG53EqqTizkt5NUJcLViwnXTpBO74ks09MSRE5+cDxs3lnN
	 M2qByBfrzA38w==
Message-ID: <cb97d276-7b3b-46b1-8f36-1bbcb066a117@kernel.org>
Date: Wed, 14 Aug 2024 11:46:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: Create COW inode from parent dentry for atomic
 write
To: Yeongjin Gil <youngjin.gil@samsung.com>, jaegeuk@kernel.org,
 daehojeong@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Sunmin Jeong <s_min.jeong@samsung.com>
References: <CGME20240813073246epcas1p4085b32d2b008b77119b811dc328b964e@epcas1p4.samsung.com>
 <20240813073244.9052-1-youngjin.gil@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240813073244.9052-1-youngjin.gil@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/13 15:32, Yeongjin Gil wrote:
> The i_pino in f2fs_inode_info has the previous parent's i_ino when inode
> was renamed, which may cause f2fs_ioc_start_atomic_write to fail.
> If file_wrong_pino is true and i_nlink is 1, then to find a valid pino,
> we should refer to the dentry from inode.
> 
> To resolve this issue, let's get parent inode using parent dentry
> directly.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

