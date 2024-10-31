Return-Path: <linux-kernel+bounces-390105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D487B9B758B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52853B231E9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C114A4F3;
	Thu, 31 Oct 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvqf3fGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AC13B592
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360754; cv=none; b=EtzwELSc6d5HauHTadEAXuFZXFn4kcWWCgZiaJsTXwEjT1qecs9U3muXvkIXpsrczmjGaWBmh19hbZFsI83ZMdGsMfcYp4eEwsAiwi3UCU8U0zWLM0VRMOWFXLGLjqH92G9ruYCa0e4ihwWDgKYjxPuLWvbaCkAdqwl3Sc/XjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360754; c=relaxed/simple;
	bh=sho9nIIOCfABtPuJPyHva71sNksFEkJM2KuErtP/H/Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sDHCIkvfCRcUhFNlkFgKK6hhsAVp0ki7v6jriV2WK4bhQnTvZq/70LtENRkRt10vv3wDtCl39td6QjajEolo6GB1lUJrKg5XHmZXZujbmFo2S6xyjqYhvWK2UYSUDaEMny+mLX7GUYcevVXIcgWK/Bq0VQg/8fdI9dzcXkqN3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvqf3fGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327BDC4CEC3;
	Thu, 31 Oct 2024 07:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730360754;
	bh=sho9nIIOCfABtPuJPyHva71sNksFEkJM2KuErtP/H/Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=jvqf3fGZYhbd2KAae77vBahbLuIIzSF8WAyJjxPwQltTxYJYuuLXTfzlRq/X5IxF/
	 WdCACLS+xyhzS/0qT0Z6q/KCtjEY7kivT14izy7kUkeKJVnQqJ2rCWr3gYGm0DSx64
	 SITTi3PUMYAAvrwacEyz2MBy38mPM+52nBwSRhLyKDxUIi0vWLpHlXLaaV8y+qpk0G
	 UpOGxxLez5MrjEc+LO03Lglv3QR8epB5lNOWaBBJwYLaYrtxGKOKWCZMZYIcz7DmZP
	 cD4EOAjPxeKR5JjfPC5fPSqvBm2PRiq+qHb5FJrWVjgK4Pmw3+wQ0G1yvhJxZxApGk
	 ABziTBK/8bMOg==
Message-ID: <0c03d45e-d62e-4bd8-b9d9-68651dd4179f@kernel.org>
Date: Thu, 31 Oct 2024 15:45:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH V2] f2fs-io: unify default block size
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730190466-13015-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1730190466-13015-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 16:27, Zhiguo Niu wrote:
> F2FS_BLKSIZE and 4096 are both used in f2fs_io for
> IO/buffer size, but F2FS_BLKSIZE may confuse user becasue
> it may be 4KB, 16KB, so use macro F2FS_DEFAULT_BLKSIZE
> to unify F2FS_BLKSIZE and 4096 in f2fs_io, also adjust
> "-c" parameters in mkfs man, to be consistent with commit
> c35fa8cd75ac ("mkfs.f2fs: change -c option description").
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

