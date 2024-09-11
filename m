Return-Path: <linux-kernel+bounces-324112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C8974803
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99BE81C2515F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297424A08;
	Wed, 11 Sep 2024 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B07cAy3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CAB8488
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020199; cv=none; b=XcexVlECRC9aQBwVI5ujrBUrngIPkra8dyW0hS/kbm82hgdySqUsmiO0SDL2dA9bnF6wT23nhFUf6CVqJxgEseqBmDf7mzlsjRvsnbMl0ciL9kAiqVkVmyCD9GDtcFbhjKB8Ypv/SbGUiqrVr2sTTy1jZkD19FqOZc7WoSuyIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020199; c=relaxed/simple;
	bh=jEG7713sqb5Gi1BH++FRmvAljhsg6dp6U1sIkfuhhtA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDtZAp7AYUav47IPTMxCT1zOdcHko/b3fdvoVZZFijLb0FeZzuLVHSKHx1TootIGvbUD/BS8J65pqu+xoMBXzuowIJXclQFuUdetz9dZ0DAqvnlFScvXYWGaCsUEurFx7S5B6kTVCYYJ6uLEoYwfNsCQaDzAiGX7FZTzON2f5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B07cAy3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6045C4CEC3;
	Wed, 11 Sep 2024 02:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020199;
	bh=jEG7713sqb5Gi1BH++FRmvAljhsg6dp6U1sIkfuhhtA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=B07cAy3mJ/BVCJURSXgmGhvypgkzrz+rdtup6KUPVnPraI25wAshQ8sevtEWEUdXb
	 3PBnkOwmYmWUcE3YJ68zAqdqVX8RReIoEkC3wh0StYYW/mJMsmMzrtKNzw9tn9bRsZ
	 muWlF12OxhLOe35KyJESxG6KJDM/JKrInpxjyykjJStwnOVxg3I9jgjSx3jAkSvoYc
	 sfytQbVvmfeCNBrkH/hEurfVCPkd8Ct58ba/VvdcWXlyrpTknuHyYOlantWV8VJbXH
	 Qgd72zLQNQAGcU0U3erH4fH9LHbM9wdpEFfPR4SCsdO26ovZxqOy3+e6YX9vlVTfAz
	 V45D0fsUUbBSA==
Message-ID: <b98143c0-fec4-4d58-a230-05317dab577e@kernel.org>
Date: Wed, 11 Sep 2024 10:03:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/7] f2fs: make BG GC more aggressive for
 zoned devices
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240909221946.2004046-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Since we don't have any GC on device side for zoned devices, need more
> aggressive BG GC. So, tune the parameters for that.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Daeho,

What about collecting all last reviewed-by tags for each patch of this
patchset? if there is no change when version updates.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

