Return-Path: <linux-kernel+bounces-316438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12A96CF97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63D62887B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FE191F7D;
	Thu,  5 Sep 2024 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVzkC0yW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8D1917E3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518618; cv=none; b=RGLTuEqfY+VE+Z0rCDjeJ1a+h84TWNi8CxpZ39Hf9h3y/wb5KSdZCe717ksrU0Mo6TXg6SFUAs5vghIFfkqvVd0ShYL+QUemMp36k/ack0ipD+MB5M5bYeiUd9IaB56lZazUv/MqOz+JSDgio2rMMH4QxJd62PaykOzZ+EYtl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518618; c=relaxed/simple;
	bh=qHz/VIWavBZ9/VrT8Dz11HQ70MwXkOtE2Y+4hjEG/+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5PA9SJv3rqmdkOf62ZZPt9Ju4ud6VEMdJz9nGkc3VHB47MgMHMsRh+TNDWjmW1QU1ZKsq5fyBg3Ar4VOfg4FXakBNTU8HPTK9bfutMEqn98hlc66UjpW3tU6eObPAcoFpPx9vbwfYqQVgNVWqgfWdy/3nzeRgnEGLnq6jQ0VoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVzkC0yW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07EFC4CEC4;
	Thu,  5 Sep 2024 06:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518617;
	bh=qHz/VIWavBZ9/VrT8Dz11HQ70MwXkOtE2Y+4hjEG/+o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZVzkC0yWhSk8rCvxLC/hmGKnQNqTyWMAh4UFiGeCnGhykKYU9ft4ydmBGNcDYjZtA
	 ugsJfXeRR5iodXYIMzVo0jJuAdDyh4mfByD3k9dI/9sRDC9jd5qZBjUekuwf4oZV8u
	 aFPAXoGjtWG6vPhuDoNjL5WYPwsY+Obiyj5zd+DJJ1O139dQFLhviPG9n6wMxTiHvN
	 UGo4XmcaOrj44yU5+o5vfhppsFrLTc4bYpKLSoGG0M8GGylngfc3Us4a/2YdP+oQfK
	 bpVy3rVJvQiwlbj99QnETQWVCUgtPWKgsFat/rmFyGSxvs1RfFMCbrLZESF2h5gG9t
	 fj75io0N5JJOQ==
Message-ID: <f26f25bf-145b-4e76-b7c1-1ad00cbfb4ab@kernel.org>
Date: Thu, 5 Sep 2024 14:43:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: avoid unused block when dio write in LFS mode
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon Kim
 <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
References: <CGME20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
 <20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240905052433epcms2p1dac78dff43776cc158bac5ae9d118160@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/5 13:24, Daejun Park wrote:
> This patch addresses the problem that when using LFS mode, unused blocks
> may occur in f2fs_map_blocks() during block allocation for dio writes.
> 
> If a new section is allocated during block allocation, it will not be
> included in the map struct by map_is_mergeable() if the LBA of the
> allocated block is not contiguous. However, the block already allocated
> in this process will remain unused due to the LFS mode.
> 
> This patch avoids the possibility of unused blocks by escaping
> f2fs_map_blocks() when allocating the last block in a section.
> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

