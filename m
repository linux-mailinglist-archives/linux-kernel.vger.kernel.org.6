Return-Path: <linux-kernel+bounces-446599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3319F9F26A1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D1118856E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809B81C3C06;
	Sun, 15 Dec 2024 22:40:50 +0000 (UTC)
Received: from sxb1plsmtpa01-02.prod.sxb1.secureserver.net (sxb1plsmtpa01-02.prod.sxb1.secureserver.net [188.121.53.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D141C1F20
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302450; cv=none; b=olb4qTQpT5J0IGk8fv+lBvIhOdgSMozC4JxyaslcatUX+pCp/ZmRQXiaNdUOjWmyfCweQ+6nqN/1kApn5UVB0bB2tWcwONQntw9mcLKO3JxTzrpLwEP7S3T7FMSJ0vvIOMbVeO06W9ohCIilgDc4qm/aDXZZVd8nVrgLNR2/kE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302450; c=relaxed/simple;
	bh=ADOHO1O9tI4q3PBTUOambB+v7LzZf4uS08mt4W7Qc24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoLKxsklivriu34qmtCEcgo7QrC124pJpXDO5N//Wm2tcQq/PdmHYHL6bBmJWxX5MY286Kv2XYOb3chn0JsElhsjshWlBeJst3MX//lxdPyJGT42b0maQLmzXCHhcpoV2PbA7FnVoUxHWqqHqMLq+RXA/of0X3OCQR2AZQ9ZSBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id MwzZtMOxpeMEGMwzatqWHd; Sun, 15 Dec 2024 15:21:39 -0700
X-CMAE-Analysis: v=2.4 cv=Mr2o63ae c=1 sm=1 tr=0 ts=675f5673
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=i0EeH86SAAAA:8 a=FXvPX3liAAAA:8 a=o5M-TyKBy0XTbSR6GjAA:9
 a=QEXdDO2ut3YA:10 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <e5611a93-12ee-4f34-bbca-c9ad7c12baa5@squashfs.org.uk>
Date: Sun, 15 Dec 2024 22:21:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Squashfs: Dont allocate fragment caches more than
 fragments
To: pangliyuan <pangliyuan1@huawei.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: wangfangpeng1@huawei.com
References: <20241210090842.160853-1-pangliyuan1@huawei.com>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20241210090842.160853-1-pangliyuan1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFAFXD7ZNSCvjeCUKkaSAW+aDY96yeKkLW9aytosWSGMNGLKotapJFnbsmefe+rT00txsujB0UtBCUzrNGxSSK2HGSg9tZp7T2hRO6P4HjByuVtNupZ+
 XmRTq7dudTCB/B0NbghzXQpwODdN/KIDUAzuc2f7A5o5okKN8dUMxMGCoVX4X0Uk/A76HDrc2uArwMNh/oA1Jmj7VR3hpQAWc0T46WNgFdu2fTwvZ3kva1XA
 Wdd8wbo5i4rA102UC86YRmOVIKl7eeA6U5uxeTgjVe5WXkreexzaybYfdkmzkEFLE/kXS9HkIjlttKnUabb8ZA==

On 10/12/2024 09:08, pangliyuan wrote:
> Sometimes the actual number of fragments in image is between
> 0 and SQUASHFS_CACHED_FRAGMENTS, which cause additional
> fragment caches to be allocated.
> 
> Sets the number of fragment caches to the minimum of fragments
> and SQUASHFS_CACHED_FRAGMENTS.
> 
> Signed-off-by: pangliyuan <pangliyuan1@huawei.com>

A small but useful optimisation.

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index 22e812808e5c..269c6d61bc29 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -405,7 +405,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
>   		goto check_directory_table;
>   
>   	msblk->fragment_cache = squashfs_cache_init("fragment",
> -		SQUASHFS_CACHED_FRAGMENTS, msblk->block_size);
> +		min(SQUASHFS_CACHED_FRAGMENTS, fragments), msblk->block_size);
>   	if (msblk->fragment_cache == NULL) {
>   		err = -ENOMEM;
>   		goto failed_mount;

