Return-Path: <linux-kernel+bounces-394181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D19BAB86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4596E28143C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF001632F5;
	Mon,  4 Nov 2024 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYGrmBBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6C6FC5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691778; cv=none; b=uWWJBhKDr+DE60o7d5QhZevj5cbQ9jk/4GB0e4qvNKaNaf3FjOWGA0hkUI7i7gRACRAsHkZ8KyT+5br2lTVxvWPo2wnHfIyc9fe01mr0EyDAmXhV1xjV0r9Z4I1zlCQ++n/WfOQSikNRX11QbnCG+85wyRkwZDM6tof1yJKXcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691778; c=relaxed/simple;
	bh=fA9BibhTIvtfZ7hQv6x0ESZlNxG0NIUbGVMlHwehJ7M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lLKybCsVkpN78q7mFgT+sf489cIzuQ46Pvjox3IlqiheqJv6/Kc2lG9tHfrrXA36cYWIkfSnA8qlInijl+N0BKKLFTeOaiJR33tPaAXzZHACcmt5NPry4NqeZ86VOh0q2BG2U203dv7Hdlxho+A8qlrSBo4iGCD3Em6KXhok/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYGrmBBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80936C4CED1;
	Mon,  4 Nov 2024 03:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730691777;
	bh=fA9BibhTIvtfZ7hQv6x0ESZlNxG0NIUbGVMlHwehJ7M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=tYGrmBBgfd/mWUV0TO1MAGHeYj8rXv1OGG+3cCf5Ps8KVJeFIW9o4e6DbMRwGfKfj
	 XfPyJqUX3RWi1LeyUYpWRQnZQzAPH1f5fVQhtLaloTIzv5Bowxn0iCRxqqkT4WzoNK
	 1YAFehSe++0JPviHAR/WI4lXS0TXq2fQ+36TNA5fMtJ/C11JehOJ4mcRM07bownGRy
	 R2ODeyPiK9Qh5UYbkFixG4NFJCsd1r/IbOqTP4Cpa9t0XOECx7aDYZPApFoLqri6ql
	 3tGWIThRjHE9wW2zkk8qdblE7x/rKoEIovhWTkjRqJfxzuUYKhiFtvKIwhI/u/MFcE
	 s6h0XXeP8zsxQ==
Message-ID: <26f4a60a-31ef-4af2-af57-0a0ec679cfab@kernel.org>
Date: Mon, 4 Nov 2024 11:42:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 hao_hao.wang@unisoc.com, xiuhong.wang.cn@gmail.com
Subject: Re: [PATCH] f2fs: fix fiemap failure issue when page size is 16KB
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241029061535.2676673-1-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 14:15, Xiuhong Wang wrote:
> After enable 16K page size, an infinite loop may occur in
> fiemap (fm_length=UINT64_MAX) on a file, such as the 16KB
> scratch.img during the remount operation in Android.
> 
> The condition for whether fiemap continues to map is to check
> whether the number of bytes corresponding to the next map.m_lblk
> exceeds blks_to_bytes(inode,max_inode_blocks(inode)) if there are HOLE.
> The latter does not take into account the maximum size of a file with 16KB
> page size, so the loop cannot be jumped out.
> 
> The following is the fail trace:
> When f2fs_map_blocks reaches map.m_lblk=3936, it needs to go to the
> first direct node block, so the map is 3936 + 4090 = 8026,
> The next map is the second direct node block, that is,
> 8026 + 4090 = 12116,
> The next map is the first indirect node block, that is,
> 12116 + 4090 * 4090 = 16740216,
> The next map is the second indirect node block, that is,
> 16740216 + 4090 * 4090 = 33468316,
> The next map is the first double indirect node block, that is,
> 33468316 + 4090 * 4090 * 4090 = 68451397316
> Since map.m_lblk represents the address of a block, which is 32
> bits, truncation will occur, that is, 68451397316 becomes
> 4026887876, and the number of bytes corresponding to the block
> number does not exceed blks_to_bytes(inode,max_inode_blocks(inode)),
> so the loop will not be jumped out.
> The next time, it will be considered that it should still be a
> double indirect node block, that is,
> 4026887876 + 4090 * 4090 * 4090 = 72444816876, which will be
> truncated to 3725340140, and the loop will not be jumped out.
> 
> 156.374871: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 0, start blkaddr = 0x8e00, len = 0x200, flags = 2,seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.374916: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 512, start blkaddr = 0x0, len = 0x0, flags = 0 , seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.374920: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 513, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> ......
> 156.385747: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3935, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385752: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3936, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385755: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 8026, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385758: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 12116, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385761: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 16740216, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385764: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 33468316, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385767: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 4026887876, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385770: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3725340140, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385772: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 4026887876, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 156.385775: f2fs_map_blocks: dev = (254,57), ino = 7449, file offset = 3725340140, start blkaddr = 0x0, len = 0x0, flags = 0, seg_type = 8, may_create = 0, multidevice = 0, flag = 1, err = 0
> 
> Commit a6a010f5def5 ("f2fs: Restrict max filesize for 16K f2fs")
> has set the maximum allowed file size to (U32_MAX + 1) * F2FS_BLKSIZE,
> so max_file_blocks should be used here to limit it, that is,
> maxbytes defined above. And the max_inode_blocks function is not
> called by other functions except here, so cleanup it.
> 
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

