Return-Path: <linux-kernel+bounces-326224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A4976528
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D79FB22862
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52294192B78;
	Thu, 12 Sep 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6v50LaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B6191F69
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131999; cv=none; b=hCDq/E//7RGhpKKDaRtIV+0sjJhu4lVQ2iit7yvnDxbOSN7+tqI4y0+W4nm19tzeHcgJLL156xSlDnviQ7CjcxtXW8a6HMdfkNVCHKGGt9oO2pYhajKJGyZBB9HkTGKq+3KwuHZSWInSHOchJUxwZOWfGmPJlKMRBrgnIrlSdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131999; c=relaxed/simple;
	bh=ujsBFOcNrFBUxWWFDaYYBKGgdo4OV7buD0Yn7UNY6lI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eZJ0VKYQ13giON7xXNdOvBj/+UFp3vUnQV+GOmDR/B/n3mdwtrKNjocyjx5PPK8zu+QPr0aaUzZfIA0yhddL7FnycVL0HnX6KmSj1TtKSLmIyp2/TFwgnFhA93ahMxu1BVWNhJDWShh/VESbBvSEoXPTVnF4veDWG9rzBBQXwdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6v50LaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67942C4CEC3;
	Thu, 12 Sep 2024 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726131999;
	bh=ujsBFOcNrFBUxWWFDaYYBKGgdo4OV7buD0Yn7UNY6lI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Z6v50LaWqPTUjB2LLOjFKUK0gWnyefy87PcgJ1pKARj/7+6b2xR/ds+cgk4IKmK8t
	 TvHwED88ST4gze0oNXa+4FeItqyiq/meMgnXcFiwTxXhm7eWEsLRO4llr4fPtdI4F4
	 BEfoiTDAejASYTZAKSZVrsnFoVCU9MdfOaL1tMR/d7ND7nN766XWwZKyZj633Lpwqo
	 yEbgOldjx2wNVDmb4PQqLs9epviRTr/HW2DiTSW+LdPmpxS1OBA2rA1LZh0uiGs6RL
	 nQU7Iiurg0/cOM8O6DwEzscJdQR4GKjAZt7Xq5Zv86cqGnvRV2pgxGxbXWlKDfUurL
	 AffhiWde/D1Ow==
Message-ID: <e5a4dd90-3fbb-413d-94cb-41ce67d6824f@kernel.org>
Date: Thu, 12 Sep 2024 17:06:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: restrict pcluster size limitations
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240912074156.2925394-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240912074156.2925394-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/12 15:41, Gao Xiang wrote:
> Error out if {en,de}encoded size of a pcluster is unsupported:
>    Maximum supported encoded size (of a pcluster):  1 MiB
>    Maximum supported decoded size (of a pcluster): 12 MiB
> 
> Users can still choose to use supported large configurations (e.g.,
> for archival purposes), but there may be performance penalties in
> low-memory scenarios compared to smaller pclusters.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

