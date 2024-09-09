Return-Path: <linux-kernel+bounces-320594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E244970C68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F041A2821B3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD900178376;
	Mon,  9 Sep 2024 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xaf2Aqi1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F74BA42
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725853290; cv=none; b=gnte7pgvJGKLz9IWOcrfEb2ZZkqqIkv7bArWZLJSjKJ76VE/IOXEY0aftd/F2RpOx4ZQJCNskb52oQQXvKnLlb+ohBhetLFcZ8vxLh0G2bR4NOmKPhspWiFHFIETeR4saJNpEBqvSRx8KDv0e3NmDe25t9/pbqjQB2l3VkDIEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725853290; c=relaxed/simple;
	bh=IeEym+QIEFtWQkTwYNKOXbQP/NW/wGRryDpC8XnK1KY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sHnSI5biUoQSServGVL8Ye8/vrNca/d91khyG25wxd6kxwDc+IxS5T/sfimTe3PLMza+kikh+VVlJUQvewEl27Y2Pux1fiNjP02DmFYzdyMIZS0z28/HeMGUF7eSl6hk+zTtrep/OqpnvuvrAgkfIQS5HyC//nsh2K+Osy3f4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xaf2Aqi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D70C4CEC3;
	Mon,  9 Sep 2024 03:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853289;
	bh=IeEym+QIEFtWQkTwYNKOXbQP/NW/wGRryDpC8XnK1KY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Xaf2Aqi1zbEYcRGx/y0/6TgrAB7pvx667F9XxoKJmnkbaEMqJ2dC8BpskUPHxppOX
	 aQZAeYeRgh7ffH455mti5/MLXRTj6grTZDMN9ka9DnvsnGOH5Zf9xSD3JXFly6FazE
	 kNA1vKjcqm21x21o/24FQbaOurJ0RDbPMcki0G7vHaOIwpcGl7Qp4Ut10RR6J6IQHr
	 xRD4Y2mU7Q2RD9Y48PVs676wHeVOfzAdyNtvcigUFN7uLDD4b0HqGATokPJnDiYnCg
	 TD3B8htNrFLZwmkwIhW7yV8xlosDjwXkHaSqxhhBpo7dnDnuMaA1kSxVXJI1pGk3xB
	 o3IPAwtksvuVA==
Message-ID: <0d351b53-7433-4522-af19-395576842543@kernel.org>
Date: Mon, 9 Sep 2024 11:41:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
To: Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
 <20240902093412.509083-1-toolmanp@tlmp.cc>
 <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>
 <ZtZ2gygmwGSAuPgS@debian>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZtZ2gygmwGSAuPgS@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/3 10:37, Gao Xiang via Linux-erofs wrote:
> On Mon, Sep 02, 2024 at 05:54:22PM +0800, Gao Xiang wrote:
>>
>>
>> On 2024/9/2 17:34, Yiyang Wu wrote:
>>> Refactor out the iop binding behavior out of the erofs_fill_symlink
>>> and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
>>> can only deal with inode operation bindings and can be decoupled from
>>> metabuf operations. This results in better calling conventions.
>>>
>>> Note that after this patch, we do not need erofs_buf and ofs as
>>> parameters any more when calling erofs_read_inode as
>>> all the data operations are now included in itself.
>>>
>>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>>> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
>>> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Thanks,
>> Gao Xiang
> 
> Applied with the following minor cleanups:
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 726a93a0413c..31d811b50291 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -16,9 +16,8 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>   
>   	/* if it cannot be handled with fast symlink scheme */
>   	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= bsz || inode->i_size < 0) {
> +	    inode->i_size >= bsz || inode->i_size < 0)
>   		return 0;
> -	}
>   
>   	m_pofs += vi->xattr_isize;
>   	/* inline symlink data shouldn't cross block boundary */
> @@ -204,7 +203,7 @@ static int erofs_read_inode(struct inode *inode)
>   static int erofs_fill_inode(struct inode *inode)
>   {
>   	struct erofs_inode *vi = EROFS_I(inode);
> -	int err = 0;
> +	int err;
>   
>   	trace_erofs_fill_inode(inode);

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>   
> 


