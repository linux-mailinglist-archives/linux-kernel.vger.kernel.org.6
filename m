Return-Path: <linux-kernel+bounces-218832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DEE90C6D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73873281B76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A413F00A;
	Tue, 18 Jun 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOojlXcE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2018E1D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698129; cv=none; b=IMz4RZGTvHoFj7IWV2D9L9jYznuwQfXW7WahaVmZQPTHh2JYAt/m/OIQUkZxXNahtnb9zZ30Bck2XnUoqOcb6ay7pC4+GBS2isaUN9FHXqlMXqzVPR3H9RgmO+7Xy8LIsZWB8E41rP2ebT26mOQffaXxef6h7cFOzXVHPOHhGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698129; c=relaxed/simple;
	bh=IA25PUjhhbNndj00EGYem/FCIIrIH//UWKcRPQbSt/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxJXI6F2wFSnjNefu1IcVJcrg2si69kTiBH5I6TeY+mBWGBLxSrfXSfKDG4JKpw+QF7yjtKxI3l2kKHO0o1QH5bLfxOt11Nsswf5/ggs/FrOpyn38GtjQOzE/oLb1wZRoFCB4tAbQl1SCreX1pxmAKDD8lcABAn3N7Vh7nZmgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOojlXcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC87FC3277B;
	Tue, 18 Jun 2024 08:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718698129;
	bh=IA25PUjhhbNndj00EGYem/FCIIrIH//UWKcRPQbSt/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dOojlXcEUDCTnA/p7nYDyAoQZDwBscfDTe8WAb6kNADvHJqHkOhCBjYBRhE7C6McF
	 sZWJjpVv63jb0EO9Vanyp6aHXI769yPlWUjogOfoyXonYlGPzNg2MOeJVmdoU1Tp/R
	 3zKg8ZBATxBrG2zm+vRjszG6FBfsfoOQdmKmXOUc0Nl+6+wXuKj5z0UGo6MDuZfvFp
	 O6m7HVfrcmIfSZrnhjOvuJ5WfhoNzg47wm87LGfS1545KpmUm2IO/NizU3jT502hnp
	 zV53WXR9rePUCnrIuc6Xgj2ZPMHvUribCW4BwsdIpsJa7KTyIU/9LmJOtL0h9WjQjf
	 I1wGyY9krV2vQ==
Message-ID: <5516ecdc-7966-4be3-880c-836e51e2557d@kernel.org>
Date: Tue, 18 Jun 2024 16:08:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs-tools: fix do_set_verity ioctl fail issue
To: Xiuhong Wang <xiuhong.wang.cn@gmail.com>
Cc: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hao_hao.wang@unisoc.com
References: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
 <04825e07-04d4-4eef-8b06-1e2329880612@kernel.org>
 <CAOsHCa0bUg3Kam_4G=aiWzQpisn7rAS3nQWMQEPWB04==Sftbw@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAOsHCa0bUg3Kam_4G=aiWzQpisn7rAS3nQWMQEPWB04==Sftbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/18 13:35, Xiuhong Wang wrote:
> Chao Yu <chao@kernel.org> 于2024年6月18日周二 11:04写道：
> 
>>
>> On 2024/6/17 15:11, Xiuhong Wang wrote:
>>> When using the f2fs_io tool to set_verity, it will fail as follows:
>>> unisc:/data # ./f2fs_io set_verity file
>>> FS_IOC_ENABLE_VERITY: Inappropriate ioctl for device
>>> this is because commit: 95ae251fe828 ("f2fs: add fs-verity support"),
>>> the passed parameters do not match the latest kernel version.
>>>
>>> After patch:
>>> unisoc:/data # ./f2fs_io set_verity file
>>> Set fsverity bit to file
>>> unisoc:/data # ./f2fs_io getflags file
>>> get a flag on file ret=0, flags=verity
>>>
>>> Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
>>> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>>> ---
>>>    include/android_config.h |  1 +
>>>    tools/f2fs_io/f2fs_io.c  |  9 ++++++---
>>>    tools/f2fs_io/f2fs_io.h  | 20 ++++++++++++++++++--
>>>    3 files changed, 25 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/android_config.h b/include/android_config.h
>>> index 05b686e..9c8b163 100644
>>> --- a/include/android_config.h
>>> +++ b/include/android_config.h
>>> @@ -13,6 +13,7 @@
>>>    #define HAVE_LINUX_XATTR_H 1
>>>    #define HAVE_LINUX_FS_H 1
>>>    #define HAVE_LINUX_FIEMAP_H 1
>>> +#define HAVE_LINUX_VERITY_H 1
>>>    #define HAVE_MNTENT_H 1
>>>    #define HAVE_STDLIB_H 1
>>>    #define HAVE_STRING_H 1
>>> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
>>> index a7b593a..2447490 100644
>>> --- a/tools/f2fs_io/f2fs_io.c
>>> +++ b/tools/f2fs_io/f2fs_io.c
>>> @@ -182,16 +182,19 @@ static void do_fsync(int argc, char **argv, const struct cmd_desc *cmd)
>>>    static void do_set_verity(int argc, char **argv, const struct cmd_desc *cmd)
>>>    {
>>>        int ret, fd;
>>> +     struct fsverity_enable_arg args = {.version = 1};
>>> +
>>> +     args.hash_algorithm = FS_VERITY_HASH_ALG_SHA256;
>>> +     args.block_size = 4096;
>>>
>>>        if (argc != 2) {
>>>                fputs("Excess arguments\n\n", stderr);
>>>                fputs(cmd->cmd_help, stderr);
>>>                exit(1);
>>>        }
>>> +     fd = open(argv[1], O_RDONLY);
>>>
>>> -     fd = open(argv[1], O_RDWR);
>>
>> It needs write permission?
>>
>> Thanks,
>>
> If you open the file with O_RDWR, the following error will be returned:
> unisoc:/data # ./f2fs_io set_verity file
> FS_IOC_ENABLE_VERITY: Text file busy
> 
> /Documentation/filesystems/fsverity.rst has the following description:
> FS_IOC_ENABLE_VERITY checks for write access to the inode. However, it
> must be executed on an O_RDONLY file descriptor and no processes can
> have the file open for writing. Attempts to open the file for writing
> while this ioctl is executing will fail with ETXTBSY. (This is
> necessary to guarantee that no writable file descriptors will exist
> after verity is enabled, and to guarantee that the file's contents are
> stable while the Merkle tree is being built over it.)

Got it, thanks for the explanation. :)

Thanks,

> 
>>> -
>>> -     ret = ioctl(fd, FS_IOC_ENABLE_VERITY);
>>> +     ret = ioctl(fd, FS_IOC_ENABLE_VERITY, &args);
>>>        if (ret < 0) {
>>>                perror("FS_IOC_ENABLE_VERITY");
>>>                exit(1);
>>> diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
>>> index b5c82f5..e55db5f 100644
>>> --- a/tools/f2fs_io/f2fs_io.h
>>> +++ b/tools/f2fs_io/f2fs_io.h
>>> @@ -16,6 +16,9 @@
>>>    #ifdef HAVE_LINUX_FS_H
>>>    #include <linux/fs.h>
>>>    #endif
>>> +#ifdef HAVE_LINUX_VERITY_H
>>> +#include <linux/fsverity.h>
>>> +#endif
>>>
>>>    #include <sys/types.h>
>>>
>>> @@ -136,8 +139,21 @@ struct fscrypt_get_policy_ex_arg {
>>>    #define F2FS_IOC_GET_ENCRYPTION_POLICY      FS_IOC_GET_ENCRYPTION_POLICY
>>>    #define F2FS_IOC_GET_ENCRYPTION_PWSALT      FS_IOC_GET_ENCRYPTION_PWSALT
>>>
>>> -#define FS_IOC_ENABLE_VERITY         _IO('f', 133)
>>> -
>>> +#ifndef FS_IOC_ENABLE_VERITY
>>> +#define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
>>> +#define FS_VERITY_HASH_ALG_SHA256       1
>>> +struct fsverity_enable_arg {
>>> +     __u32 version;
>>> +     __u32 hash_algorithm;
>>> +     __u32 block_size;
>>> +     __u32 salt_size;
>>> +     __u64 salt_ptr;
>>> +     __u32 sig_size;
>>> +     __u32 __reserved1;
>>> +     __u64 sig_ptr;
>>> +     __u64 __reserved2[11];
>>> +};
>>> +#endif
>>>    /*
>>>     * Inode flags
>>>     */

