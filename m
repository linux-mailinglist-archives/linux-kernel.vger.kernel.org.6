Return-Path: <linux-kernel+bounces-354438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8009993D76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4481F24C18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E933986;
	Tue,  8 Oct 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I60R905Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0421E49E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728357950; cv=none; b=BruTePTTr4jv/cIpp0zMFhMpydE5jaQ9nTv6+BsEu55/ZaaUQcA/xQPcK+bKiz+3gBAp5Sjlqp52TnifCDs8EwErNQP46OW+AEmPicU/IKAIQvvRoGKHlzT06Wn5s2whi8aM4RAFIZkOYjTp4ymZbx+wjfdAoc0HRzQThrbeAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728357950; c=relaxed/simple;
	bh=ahYiF+5APi3SyfJETyVj7UcmuY9R573psv9Nj//7cpg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nwoNqKxVRzt4kGQ1JVYY3HMIsfpULwsh/Lbkjk9ZkhdThpSlspS3WEzzE+L70jkFL8BsS5zuRp+9MOyGeAWH7gZy52KYNUMrFVDzwQj84x9ELNhSq0Yv5K8Ing+m6AarKYSQFYlxl4cyRKK51PuVt/uChhhd512dhBTDueL1rMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I60R905Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C59AC4CEC6;
	Tue,  8 Oct 2024 03:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728357949;
	bh=ahYiF+5APi3SyfJETyVj7UcmuY9R573psv9Nj//7cpg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=I60R905ZGbEdvaKVec2zNhGQqAFZ1zZiATGeKBF+xYncc/TlKWxomAIh+Mv8lnrQu
	 /frRPrONjsRz8UGyXgE4AKAyv8MCQ5eOJfjOsjS7TyeV9vFv8WkfZMacQh7Hweol0w
	 PXzTrHdpQ7EfoMUUVANfN2T2OtoibjXXuEy2SogUSiqCNQ8tcJYqnQIcIj3lzQRYoT
	 G7vnREQ6yLf4f332c1yE2rMdisrL8oydVCzNKTOaaIG/oJOd6JD/cA7XTO21H6Dq88
	 d+UPU6+iSDJxvOro2Crpk3elbhIin87Uz1ehMxdeBx/SfKgT50otkgsNI+OakB9cMy
	 Ie90/h8S1Nxbg==
Message-ID: <82e4a8bb-29d4-4ce8-bc04-985b08801aeb@kernel.org>
Date: Tue, 8 Oct 2024 11:25:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix f2fs_bug_on when uninstalling filesystem call
 f2fs_evict_inode.
To: Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
References: <20240918084400.1821317-1-hanqi@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240918084400.1821317-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/18 16:44, Qi Han wrote:
> creating a large files during checkpoint disable until it runs out of
> space and then delete it, then remount to enable checkpoint again, and
> then unmount the filesystem triggers the f2fs_bug_on as below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/inode.c:896!
> CPU: 2 UID: 0 PID: 1286 Comm: umount Not tainted 6.11.0-rc7-dirty #360
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:f2fs_evict_inode+0x58c/0x610
> Call Trace:
>   __die_body+0x15/0x60
>   die+0x33/0x50
>   do_trap+0x10a/0x120
>   f2fs_evict_inode+0x58c/0x610
>   do_error_trap+0x60/0x80
>   f2fs_evict_inode+0x58c/0x610
>   exc_invalid_op+0x53/0x60
>   f2fs_evict_inode+0x58c/0x610
>   asm_exc_invalid_op+0x16/0x20
>   f2fs_evict_inode+0x58c/0x610
>   evict+0x101/0x260
>   dispose_list+0x30/0x50
>   evict_inodes+0x140/0x190
>   generic_shutdown_super+0x2f/0x150
>   kill_block_super+0x11/0x40
>   kill_f2fs_super+0x7d/0x140
>   deactivate_locked_super+0x2a/0x70
>   cleanup_mnt+0xb3/0x140
>   task_work_run+0x61/0x90
> 
> The root cause is: creating large files during disable checkpoint
> period results in not enough free segments, so when writing back root
> inode will failed in f2fs_enable_checkpoint. When umount the file
> system after enabling checkpoint, the root inode is dirty in
> f2fs_evict_inode function, which triggers BUG_ON. The steps to
> reproduce are as follows:
> 
> dd if=/dev/zero of=f2fs.img bs=1M count=55
> mount f2fs.img f2fs_dir -o checkpoint=disable:10%
> dd if=/dev/zero of=big bs=1M count=50
> sync
> rm big
> mount -o remount,checkpoint=enable f2fs_dir
> umount f2fs_dir
> 
> Let's redirty inode when there is not free segments during checkpoint
> is disable.
> 
> Signed-off-by: Qi Han <hanqi@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

