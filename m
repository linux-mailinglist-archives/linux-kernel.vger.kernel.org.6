Return-Path: <linux-kernel+bounces-412321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4389D078D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8F11F21734
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DBB1946B;
	Mon, 18 Nov 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6rgAx+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5FC14263
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893042; cv=none; b=B+Hc3R6+Wq6BoBeTkMPcNIpd9HoT/tC83An83Gc5lOde1fHQnwWHewICv1TNDeL3WOCouUUYP58IxbZQzJeyLz0XGlZ0+AxxCfF05yDNmBt0LOrGPt4qBMN9J6WWVv2SC1EYzbDjNSKWZ8Vd0SbXVrOWHbObwdObshMtrME+384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893042; c=relaxed/simple;
	bh=n7HW7ffDUaOV4zb7zTAhMB+RX8C9iEP9O0qaQLZbQIM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iayYzlB5zOAlGU3sbkunK/fXXvWtf4QtOTUhpGSuGnPEl3dk2P1cS+QybU30w3tgjkzmPGOPF8IeVHGO2Lw1FDyo5kkkL1HHThhQvXW7U8yKLf/ZtvNarTym81AThtOeOP15GUJP350jZqnZyhmCk2YkbqWwFl8tQRUixNKzzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6rgAx+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02390C4CECD;
	Mon, 18 Nov 2024 01:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731893041;
	bh=n7HW7ffDUaOV4zb7zTAhMB+RX8C9iEP9O0qaQLZbQIM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=t6rgAx+H046q+RaOVZr0JNJaTXidHVIVHvMUd1PRQ1V2tTD1oyQQPQ9Gg0olyV2z6
	 TXsugy/WD8R7aCHBtvSe7oKwowFlJsp8IrLKqFysoovDOFiGaLijHprJnOvC15ak+9
	 2V9oKVgjj6KhmY/0I2zRUlfeVaJl2+9REQ/WR3n2zhz91uC0N7pROm8ZvRk/07fJXO
	 eun8a1gjCZr/NjZP3zJTsDdkGd/NCl2mD4ciPh8bVr5NKIwaFEqoYbvSBbUo50dxTj
	 rmFtz8RRBnYcK9NXa21K45fTOAYPSlMM7M6nFmw/9AeYVVfUNSpO+l8AlgnDbwj3IQ
	 0Clt6JbdzI4nA==
Message-ID: <065b2dea-0c0a-4961-ac18-2ddd62f0b808@kernel.org>
Date: Mon, 18 Nov 2024 09:23:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: replace deprecated strcpy with strscpy
To: Daniel Yang <danielyangkang@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20241109013819.5952-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241109013819.5952-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/9 9:38, Daniel Yang wrote:
> strcpy is deprecated. Kernel docs recommend replacing strcpy with
> strscpy. The function strcpy() return value isn't used so there
> shouldn't be an issue replacing with the safer alternative strscpy.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
> V1 -> V2: handle strscpy errors, changed prefix to f2fs
> 
>   fs/f2fs/super.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 87ab5696b..4721a8a8f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5,6 +5,7 @@
>    * Copyright (c) 2012 Samsung Electronics Co., Ltd.
>    *             http://www.samsung.com/
>    */
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/fs.h>
> @@ -1158,7 +1159,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				break;
>   			}
>   
> -			strcpy(ext[ext_cnt], name);
> +			if (strscpy(ext[ext_cnt], name) == -E2BIG) {
> +				kfree(name);
> +				return -EINVAL;

How about?

ret = strscpy(ext[ext_cnt], name);
if (ret < 0) {
	kfree(name);
	return ret;
}

> +			}
>   			F2FS_OPTION(sbi).compress_ext_cnt++;
>   			kfree(name);
>   			break;
> @@ -1187,7 +1191,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				break;
>   			}
>   
> -			strcpy(noext[noext_cnt], name);
> +			if (strscpy(noext[noext_cnt], name) == -E2BIG) {
> +				kfree(name);
> +				return -EINVAL;
> +			}

Ditto

Thanks,

>   			F2FS_OPTION(sbi).nocompress_ext_cnt++;
>   			kfree(name);
>   			break;


