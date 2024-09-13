Return-Path: <linux-kernel+bounces-327479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74878977685
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71A81C24265
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99DC6FB0;
	Fri, 13 Sep 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQ/rdY2j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475EA1FC8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192220; cv=none; b=cCGziBJiC0WJzqpC1fsMuPDO/1tou2f+WemyqYXu4KkO52ze5j3XcWrgWMLoZidDQ4US4yP3rado5W9GD7Wm/00g96c8iN9VLU/xmIeMxx5jmliFoqzrBET5NUk7HZCM38fQcQ+f9YWZdavvEJW15O9K7RRMkM+hwjPXhymf73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192220; c=relaxed/simple;
	bh=HgzJPitcmNSo3TO5D0K1yFbTLYRnejMdLnksGZ3n1zI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pNNJ/WZMxCoY5kS/OJkVevj1O50ZZsDVSW9CNt8loqTOFRFyDgdPcX3tF9+IVwVifvGYiZXI/VE0P8gAif5cbao1TGPLGDHXtVN923wDa9VbSADFSqrP2ghklsCYzjV1ZXJjJHDzsADjqsw2ZSJhtRFbleWKZjLsKvitNMibs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQ/rdY2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74093C4CEC3;
	Fri, 13 Sep 2024 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726192219;
	bh=HgzJPitcmNSo3TO5D0K1yFbTLYRnejMdLnksGZ3n1zI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gQ/rdY2ji0uinK9jnzpe/2UebLxey5glnmYyVZiYQZsbXEbSiBAC5jjvzmP8OdP5Q
	 uC4UnGwMmey8Rlz9loGXD36Pf7pGLCg8T+AsK4nvn5mT/casPU+/jPtmHlxotvCtvy
	 k4FJSAawCDxSuaegON5eWR3P5v1/pY91ryOkIM00eK4PsmBvEr4esJaxT38hMs9Iwk
	 hpMHJPuKWtJYnm7PLD5+1EbKb0dXq5NkG4uKw0sfXMBObkUyZEnHyLeRf+73S4Oo+O
	 32la3qwr5Td0qzMWY1640Zqm1Vaz25VNj5U8VDmDKqW8Qnx2ECNKp17JE9ciNVbq81
	 Pc28nF/R9C/jQ==
Message-ID: <500c3c3a-5332-4c86-ba7c-dacb3061e17b@kernel.org>
Date: Fri, 13 Sep 2024 09:50:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: forcibly migrate to secure space for
 zoned device file pinning
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240912165958.386947-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240912165958.386947-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/13 0:59, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to migrate data blocks even though it is full to secure space
> for zoned device file pinning.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

