Return-Path: <linux-kernel+bounces-401380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331059C197C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D7D1C24E04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFE1E0B74;
	Fri,  8 Nov 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKXPLmlB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025E1171C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059220; cv=none; b=k6df7iNgZo7SLMT5tQIJH3LEBY6qwE1lZljw55EJeEK/tt0I1dR+GA/kusVjSABSKFBdTJ54HftRZ5qLZqOOOMUXSbY8i6Eck2MfbKYEpaD6nvl37f4j8ZZII1Pex2wmg3j+6Pz3CY3taSoofX4SHQjFKzm2DKzaaT597/dlN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059220; c=relaxed/simple;
	bh=gftxDemJKqLJb4mPXXdNi/TfrkvP+Tbn9Ob+u48LGdg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nlHaNJRzOEP77p6oCtV4H2qY6FtuZmdFHR3pIKaXDfGHnhLlA99elVbXFTfKO8HEm4XpRKiHusk7z9QYpZlZB2moKHfVpBnSCs0YpYdpLztkS9UVw1eoADB4PRDQmBSExEX5Lb3MKW90sdcUOkWH3y/J1FM6Vg1bFMFPzQJKGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKXPLmlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C13C4CECD;
	Fri,  8 Nov 2024 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731059219;
	bh=gftxDemJKqLJb4mPXXdNi/TfrkvP+Tbn9Ob+u48LGdg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KKXPLmlBGCfy1R0l/7mT7SkOr71BSLUeo7+zKNEUxKi8NkXAFa5KpOdZYZFvPOLml
	 PQ3/cFBFJ5ZllbyLnHzk0lb9YueYLDkKyO0lO0WoP3wirO1hj1qIEfq49OaQvVSxfm
	 L6FMmrsEPB4nzBLwS9IDgGoVDn+0GR/yssRro1NELONKB82oN0KrxHKwBQwC1kIKA1
	 DboLEOeUE6egG5QljdrXnsCtRTrd/OiTXPYA56+2VGo5Uk84DQ6lrWvi6W6oCdjlRr
	 5Lh+7TOm6r9yXJUso1CVWpU8fsqlCCrg38oTKXS3LeKMHCetR90LOgkO+BBlV186vL
	 az2Oir+syI2hg==
Message-ID: <a1471ca1-e119-4106-8965-cd954c373a62@kernel.org>
Date: Fri, 8 Nov 2024 17:46:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] parse_options(): replace deprecated strcpy with strscpy
To: Daniel Yang <danielyangkang@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20241106025858.495458-1-danielyangkang@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241106025858.495458-1-danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/6 10:58, Daniel Yang wrote:
> strcpy is deprecated. Kernel docs recommend replacing strcpy with
> strscpy. The function strcpy() return value isn't used so there
> shouldn't be an issue replacing with the safer alternative strscpy.

It's better to add "f2fs: " prefix for commit title.

> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>   fs/f2fs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 87ab5696b..ee8861b95 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1158,7 +1158,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				break;
>   			}
>   
> -			strcpy(ext[ext_cnt], name);
> +			strscpy(ext[ext_cnt], name);

Needs to handle return value of strscpy()?

>   			F2FS_OPTION(sbi).compress_ext_cnt++;
>   			kfree(name);
>   			break;
> @@ -1187,7 +1187,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				break;
>   			}
>   
> -			strcpy(noext[noext_cnt], name);
> +			strscpy(noext[noext_cnt], name);

Ditto,

Thanks,

>   			F2FS_OPTION(sbi).nocompress_ext_cnt++;
>   			kfree(name);
>   			break;


