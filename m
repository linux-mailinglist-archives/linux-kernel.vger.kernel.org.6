Return-Path: <linux-kernel+bounces-218580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA1C90C235
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFDE1C21702
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990621DFEB;
	Tue, 18 Jun 2024 03:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svnjFOU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F041D9503
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679860; cv=none; b=mfDXhZNyZHJJk6h1z3TRPuuJOeRac1c/4ezuU/6H9bxyzy3/hrpeO11/Z2oo5dwjKHbgaMcjjbdPzHiESWO615k5O73sLAEUQU4E3WNWmzIAQKIc+QJXHiNCLtTOrmVvSZF5zYen8BxmHy0B2H4L8Gb0gr+ZoQKZ8NRVfbQMmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679860; c=relaxed/simple;
	bh=6zex10JdKWI5HrbQOQXxplme+gazghXqPQBVPelLR6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4IqJWGR/KNDDX9NkJBPMVpLEas/amLCDzsVn36MUup/OmKjHrSPmTd2jl2zrbCmOHSEe7azMVXdMTQ1x2sLOg6etjfMiYvaa25SNmpbzhS7GtaGwRKym3N9GLnmKfeo1C8vO2DV6PWmqfEZq3ldftkPTjNx/ZVFiDSp9SnOqW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svnjFOU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F0FC2BD10;
	Tue, 18 Jun 2024 03:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718679860;
	bh=6zex10JdKWI5HrbQOQXxplme+gazghXqPQBVPelLR6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=svnjFOU38R19vv3gxeJw12auHkOaxS1O6gLaA9aYS5h9VQgGKhqRSCHhVaOa6yXJv
	 gJOlSo5wDHtAVt1MXkDODjSS5KcVfQdAts6IXlXmwEmLUhDXtIyuDwbL3IMGcuVf/6
	 DQaI51JP23y6Uxm+Z5tUfbpR+C4qBTBK28aTzAhMgN1/2y50VKhcjX34ehyo8VJPD7
	 I4d9u3ZZmw+qCxT4r7njBrAkkZi4iFykeLDTBz59Hb2Phy3fDgWvYaB8kiglJZoZdK
	 PduNOTEboLt4yi0rs7TQhRBWgwbicoaTnxtnjwlkCsTsdZ1jmQXT5GrYpBNlmZGA8H
	 631SZlbGUfoDw==
Message-ID: <04825e07-04d4-4eef-8b06-1e2329880612@kernel.org>
Date: Tue, 18 Jun 2024 11:04:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs-tools: fix do_set_verity ioctl fail issue
To: Xiuhong Wang <xiuhong.wang@unisoc.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com,
 hao_hao.wang@unisoc.com
References: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240617071114.150721-1-xiuhong.wang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/17 15:11, Xiuhong Wang wrote:
> When using the f2fs_io tool to set_verity, it will fail as follows:
> unisc:/data # ./f2fs_io set_verity file
> FS_IOC_ENABLE_VERITY: Inappropriate ioctl for device
> this is because commit: 95ae251fe828 ("f2fs: add fs-verity support"),
> the passed parameters do not match the latest kernel version.
> 
> After patch:
> unisoc:/data # ./f2fs_io set_verity file
> Set fsverity bit to file
> unisoc:/data # ./f2fs_io getflags file
> get a flag on file ret=0, flags=verity
> 
> Fixes: 95ae251fe828 ("f2fs: add fs-verity support")
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   include/android_config.h |  1 +
>   tools/f2fs_io/f2fs_io.c  |  9 ++++++---
>   tools/f2fs_io/f2fs_io.h  | 20 ++++++++++++++++++--
>   3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/include/android_config.h b/include/android_config.h
> index 05b686e..9c8b163 100644
> --- a/include/android_config.h
> +++ b/include/android_config.h
> @@ -13,6 +13,7 @@
>   #define HAVE_LINUX_XATTR_H 1
>   #define HAVE_LINUX_FS_H 1
>   #define HAVE_LINUX_FIEMAP_H 1
> +#define HAVE_LINUX_VERITY_H 1
>   #define HAVE_MNTENT_H 1
>   #define HAVE_STDLIB_H 1
>   #define HAVE_STRING_H 1
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index a7b593a..2447490 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -182,16 +182,19 @@ static void do_fsync(int argc, char **argv, const struct cmd_desc *cmd)
>   static void do_set_verity(int argc, char **argv, const struct cmd_desc *cmd)
>   {
>   	int ret, fd;
> +	struct fsverity_enable_arg args = {.version = 1};
> +
> +	args.hash_algorithm = FS_VERITY_HASH_ALG_SHA256;
> +	args.block_size = 4096;
>   
>   	if (argc != 2) {
>   		fputs("Excess arguments\n\n", stderr);
>   		fputs(cmd->cmd_help, stderr);
>   		exit(1);
>   	}
> +	fd = open(argv[1], O_RDONLY);
>   
> -	fd = open(argv[1], O_RDWR);

It needs write permission?

Thanks,

> -
> -	ret = ioctl(fd, FS_IOC_ENABLE_VERITY);
> +	ret = ioctl(fd, FS_IOC_ENABLE_VERITY, &args);
>   	if (ret < 0) {
>   		perror("FS_IOC_ENABLE_VERITY");
>   		exit(1);
> diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
> index b5c82f5..e55db5f 100644
> --- a/tools/f2fs_io/f2fs_io.h
> +++ b/tools/f2fs_io/f2fs_io.h
> @@ -16,6 +16,9 @@
>   #ifdef HAVE_LINUX_FS_H
>   #include <linux/fs.h>
>   #endif
> +#ifdef HAVE_LINUX_VERITY_H
> +#include <linux/fsverity.h>
> +#endif
>   
>   #include <sys/types.h>
>   
> @@ -136,8 +139,21 @@ struct fscrypt_get_policy_ex_arg {
>   #define F2FS_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
>   #define F2FS_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
>   
> -#define FS_IOC_ENABLE_VERITY		_IO('f', 133)
> -
> +#ifndef FS_IOC_ENABLE_VERITY
> +#define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
> +#define FS_VERITY_HASH_ALG_SHA256       1
> +struct fsverity_enable_arg {
> +	__u32 version;
> +	__u32 hash_algorithm;
> +	__u32 block_size;
> +	__u32 salt_size;
> +	__u64 salt_ptr;
> +	__u32 sig_size;
> +	__u32 __reserved1;
> +	__u64 sig_ptr;
> +	__u64 __reserved2[11];
> +};
> +#endif
>   /*
>    * Inode flags
>    */

