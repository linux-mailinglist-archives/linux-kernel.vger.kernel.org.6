Return-Path: <linux-kernel+bounces-205805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18121900089
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EB8B22360
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB315A4B0;
	Fri,  7 Jun 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9hMoU0q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0708433C7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755586; cv=none; b=OwxCkPGoV9oFa9N43NsboqQlx00Nkhlm6QvZ2BxzMapYPOP4onqVwQfg/qesRC0zMLrYKUMFFz1J2meVxJHe1px9ygfJxXrN3m0sRBbnKJOTblwgnKitPPtB4OJWnt1SvhktdkmOcCr1/BX2T5Vsvu5CtUR1KkUPq31OI07DTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755586; c=relaxed/simple;
	bh=UDRdVHfoeHw5GgESiTH5mQcIZFVsyDUAxraCIbMR2oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzlZfTcHDwkQkp09D/XP0QCyg+beo+YzBa7kaUWdqW8nnlLInsX1nSSnL4peg5BqiuXepEU9/lUuD4m32r648OveHUIPIWK+128DaHUUmHY7ZM2zRrvtUlRhrd0N5l2XFDfqYIfZ8dNmzIHEBewbznAoAJkDo49dRTPvj67HJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9hMoU0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809D7C2BBFC;
	Fri,  7 Jun 2024 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717755586;
	bh=UDRdVHfoeHw5GgESiTH5mQcIZFVsyDUAxraCIbMR2oA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U9hMoU0qNRHOQN2vMmeLVwX8p2pufe+zrcuKIWL9+lJw0Pis0791dIqdpjeStjeZQ
	 RIoCHCZ1IfgYyV1OUqfbP9HXZIXBkU3+QFLsJ1f4+ci7taYUdu4xjo24Txl+dy+sxi
	 r7hXR1o/PKRB+ao4caQDvOjuHFJF2O04b1UD760+dB8JvW8YAVEqUrlk1SV47zMXDz
	 XvmFWRgNdQ5bQ18mTdD+PPcbdurqYSjiMFy3djsLv5niCKBQtfjhufpkgL19sld3DD
	 diKavsWdsXsaOIrPi9I8CWncGP0DyEKFpQBfknCd0wRPt7apdwClLLs6AE/oAPKD1N
	 t6WKWBOLEndJA==
Message-ID: <d9869426-a1ac-48b9-8d47-3f68375ff98b@kernel.org>
Date: Fri, 7 Jun 2024 18:19:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] f2fs: enable atgc dynamically if conditions are met
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1717750830-15423-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/7 17:00, Zhiguo Niu wrote:
> Now atgc can only be enabled when umounted->mounted device
> even related conditions have reached. If the device has not
> be umounted->mounted for a long time, atgc can not work.
> 
> So enable atgc dynamically when atgc_age_threshold is less than
> elapsed_time and ATGC mount option is on.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

