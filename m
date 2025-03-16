Return-Path: <linux-kernel+bounces-562811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5FA6333D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53803B1CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0071B808;
	Sun, 16 Mar 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fe0+MTYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E7290F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742090174; cv=none; b=eZEjWGztdVo9skOrolGg8oEGgQMD8LXGfzZ1LCxiQgRWhzzT6gNtiL5iilDClSiXsz2SYmHG3dgCGtlXumuG2g+GMwZXhAp2Z+lWUQDpBaDAXEfGYAhGfPnDqmJRCOA57gWaxMPyxAmaqcX91Pg9h/d6PccHGCUIK1tbM+h0P+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742090174; c=relaxed/simple;
	bh=TSApGeq561AKpnh0Qf+XWrQjdOoTxwaKJz/vBCl6scw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qmVmFUwtLupcSN1kVqBcdk9JdhM3MDBEpWSLNSV88YBa+D+LrtuAe3Pilo6vhZcrzohiyCRtpj771idRAPyMjO0vQaZS1aCm6JqnKe0yyywkEWHlvLTflopvx9uBAv3HyLDIEC1nXzmYyH/MkOADr1d64ZMuynXETXON+eTqul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fe0+MTYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72768C4CEE5;
	Sun, 16 Mar 2025 01:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742090174;
	bh=TSApGeq561AKpnh0Qf+XWrQjdOoTxwaKJz/vBCl6scw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fe0+MTYTctzs+5mldrlTR8Vc8OwHqtMst5vYqn0Nh+J3vSHWbtoqQPB8WMeBfx9kH
	 nBQOFIL5Tyl77NCadB3gcUD0pv0GfHmtcPTOMr7y3pFEuLT3EW7dW63+au6kZGsWTz
	 nGn7Ph0HtiVTFiccRYL3FCKSOY4fwk/JtKmkduRldIOuOtBqDr6u3jLjkALVwzA3mX
	 FMMf/IYHPeQ/SOgOmvTaeICFgAkLoVxgEKZPtPSmhUsG6FZcSGh2FbKyCI7kL/r85m
	 o/RnqtVRam5m7h6bx1RMAJTDXkSjBdogYD9gsyzDLjUV2fKu7R0VpNaGGUAxroNg8E
	 D3NGJ8xhER1+g==
Message-ID: <2e0ede6e-3cfc-45fd-b287-2d41e561939e@kernel.org>
Date: Sun, 16 Mar 2025 09:56:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] erofs: move {in,out}pages into struct
 z_erofs_decompress_req
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250305124007.1810731-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250305124007.1810731-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/3/5 20:40, Gao Xiang wrote:
> It seems that all compressors need those two values, so just move
> them into the common structure.
> 
> `struct z_erofs_lz4_decompress_ctx` can be dropped too.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

