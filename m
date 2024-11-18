Return-Path: <linux-kernel+bounces-412505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9189D09D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D681F21D88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD2B14A4D1;
	Mon, 18 Nov 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/ObsHco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D2149C6F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912745; cv=none; b=YWpc3UNmQj26vxZwuJwt/MlPE7/PmrKX9m5KLfTs/oGqA/NoUMVwD4GRi911gVY5qweAGbMtMyZmg9Vc4TMR0qg06ILtPABdRRMzvzCA26jnHiknBAFsQkuEI5PKOjpGxeL/6P0Bc++UK8IJMOX2YnSmEhiI5uUgZ2/BZqx7I30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912745; c=relaxed/simple;
	bh=b0TRyEAlrSD429EVw9p268WP5nJU++Nk4CwNQ0Bf8hg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bI3vsNKMuNIfdZbUIn+Hj42eHnUGljGBCWLvugWjfidPprlUpUAMj6y+LA84p6Y4haUiBCjQreHgaBZFtEhgQ0V/j/0UOpGomUT6YxSISVjQLn8yOwlLI8TDlMmvik9Bc2At6BP4ohR5FFIXsrTl0junq5PaZ6gzvZp5dsVmJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/ObsHco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C59C4CECF;
	Mon, 18 Nov 2024 06:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731912744;
	bh=b0TRyEAlrSD429EVw9p268WP5nJU++Nk4CwNQ0Bf8hg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=t/ObsHcoSp4uIyE2yM2dconLAljqCB9Xy2KqhQO+TCF4q+2gRG3/XPew9wdLBkmoJ
	 KL+vQKeggZYJkI7uleMxSwhICSHJQAISD/VuErRUWchQxLcPRjQzqHPZ4z9TlH/0WL
	 T4UeauEeb3R6jhz3WhiyxYGbpI5z67A4bdXB00q3cSGr1ZQObKsSpwOrQLNbpiq1/X
	 4wJm40JORcrzXzkAHSwGxKGcZH7MFdYE9ZDnlKOp80fJtgsPIptkMkR12/tivYbfjp
	 vRxnibFVtec0HoFzCeF6ihW0lzvmtYdMV0hLYGRPSwJP6M3PQ+p0ybAYTMzXZnsA2m
	 oX8tzeXLvG8BQ==
Message-ID: <3760a0ac-1dc3-4069-8fe7-a6e4a9222683@kernel.org>
Date: Mon, 18 Nov 2024 14:52:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Song Feng <songfeng@oppo.com>,
 Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: Re: [PATCH 2/2] f2fs: clear SBI_POR_DOING before initing inmem curseg
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20241111085058.4136077-1-shengyong@oppo.com>
 <20241111085058.4136077-2-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241111085058.4136077-2-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/11 16:50, Sheng Yong wrote:
> SBI_POR_DOING can be cleared after recovery is completed, so that
> changes made before recovery can be persistent, and subsequent
> errors can be recorded into cp/sb.
> 
> Signed-off-by: Song Feng <songfeng@oppo.com>
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

