Return-Path: <linux-kernel+bounces-399271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB19BFCE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2226BB22525
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478613635F;
	Thu,  7 Nov 2024 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT9wTfya"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB622071
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949291; cv=none; b=YqVFqbRQZxYysoyItCr21x3khlj2KwcNQgewBQEOVqo+1NPOUJoSG6299a/rU3MTT3mGav/s5ETDllGiVfv+DMSWAai7Gy7dRHC9n4WVAZeWFtsAyuVCuzgMoNJdzQcf9mULPMWlWLpqx7koB4PuY39XtIuvLSFNt3Uy1UH9VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949291; c=relaxed/simple;
	bh=h0jFYPz6CEDXwqDNktCDvd0yTqHMMXs8qp/E77CUE2E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mIzjkO2B2SNYaTCu/6MveVnkJ6bYKMmyi7bHai4XkYgUgDNP92i9Z+b2PqClmsrYDDNO+gMEd17Jg+dQ/6CdJgn5/5iM/+nX1IsiQN1b+0sk0zbhSJsU7drdkADn+f1//VWgSeFIHSb8n5qp5o7Gp6dn7PDZxJhJ6mO4IS1GAo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT9wTfya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B482AC4CED2;
	Thu,  7 Nov 2024 03:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730949290;
	bh=h0jFYPz6CEDXwqDNktCDvd0yTqHMMXs8qp/E77CUE2E=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sT9wTfya+f08N+Ouj4jqm0BTMhXUFQrPlw7wDeonqbPdMOJSUjb3VjCnqfG4KcgcE
	 QLBk+kYqkY8EtogjCBPyvRdm2E/9MM9k/X16QoKIA/UKpu2R6ibQ9TGee+5TikovKm
	 F19wVahVeGOFQzc/L2GldPvPIMt/panDrHIA/48haPr6dqPDQNMSkS1Q2s8ncTEvXo
	 5SgyPwyUyFTkUg5QwUDtXQMbzB/4/6UgPfvcJ544z0M8EaFVq9YFF47UZjp5TXJiO1
	 GDapqm7Dcm3JmyP9EEwB3KXGaxLQmcaJRbO9HSkdMyJJAnMz0MJit2VUXeAtYjTcEp
	 6Xt/OOWhUaQyQ==
Message-ID: <c2fb74bb-99f9-40cb-91a2-08ef862a1d5b@kernel.org>
Date: Thu, 7 Nov 2024 11:14:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Chunhai Guo <guochunhai@vivo.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] erofs: move erofs_workgroup operations into
 zdata.c
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20241021035323.3280682-1-hsiangkao@linux.alibaba.com>
 <20241021035323.3280682-2-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241021035323.3280682-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/21 11:53, Gao Xiang wrote:
> Move related helpers into zdata.c as an intermediate step of getting
> rid of `struct erofs_workgroup`, and rename:
> 
>   erofs_workgroup_put => z_erofs_put_pcluster
>   erofs_workgroup_get => z_erofs_get_pcluster
>   erofs_try_to_release_workgroup => erofs_try_to_release_pcluster
>   erofs_shrink_workstation => z_erofs_shrink_scan
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

