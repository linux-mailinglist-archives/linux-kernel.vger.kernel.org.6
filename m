Return-Path: <linux-kernel+bounces-263075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585793D0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8AD1F21210
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B4176AAC;
	Fri, 26 Jul 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjoHjQId"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAB1EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987356; cv=none; b=MmNvEehogkgImlz0walo/vfYethB6qOoETvz8XswndUz4BZZBbMF32hf6/cJJ1kyFMBwW/qFgzRPco6tlDFW8TT1N3Uhvyit8cQc1Hi/yMhh3Y5QZ/vI4GwQsMiqB1IDpEynRQdf9uJMAMMDELw3FM9u0Vcsw3ShGP5q08OH70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987356; c=relaxed/simple;
	bh=AAUbx8TeBWYEP6Ic4mOlnbercYp2YYgawpoonj8ove4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD+RPvms9YSav4UDnZmpno9ZnFc6u2QCVeK6Bjz6PPo1bVS0OOlFmUi6KJiPcFuZ4glJ0jZ/zPvChezzAL0HzOQjNXHyzkxFszfcmwDClTGedGgeiHSolzD/+gMuLGxIN1At9O6/Okq2QGH6AddjQwbCFfhfA4Y3a/n0rNeU9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjoHjQId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1153C4AF07;
	Fri, 26 Jul 2024 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721987356;
	bh=AAUbx8TeBWYEP6Ic4mOlnbercYp2YYgawpoonj8ove4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kjoHjQIdBTBZEAtG/lyrrvZLqmM5byKGZsbI6Zd7uTRJ0UYwni2GTBI/WxoMCmTcD
	 BtM5ypdXPlednu6G3uBePlKYUBcN7nlkG1AD4xVIRHXPoslwQBUr11Lb7PU2WwI2U5
	 fLB9YWbDuaHgpn3AJkJJZ1qYpXZTeCwGuf8NxfIFBgtUR7A7U1IvIGftfeB5+H9e54
	 0o3yOKHWXDkxkcZOirZTcRf3B79f9mqT1WZGeL+n9u6U/zArydBfmXnJ/vbwFG2ec5
	 AkrucdiC15BW8HGM9utv57JMo8xuaGzDwdn+RVJmSmgS26Y1DxNeDxRNlbM5NCRBEu
	 9d3u5nxhJXz5w==
Message-ID: <a2138acd-9478-4706-85e8-761438382474@kernel.org>
Date: Fri, 26 Jul 2024 17:49:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] f2fs: fix to use per-inode maxbytes and cleanup
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1721975246-32345-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1721975246-32345-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/26 14:27, Zhiguo Niu wrote:
> This is a supplement to commit 6d1451bf7f84 ("f2fs: fix to use per-inode maxbytes")
> for some missed cases, also cleanup redundant code in f2fs_llseek.
> 
> Cc: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

