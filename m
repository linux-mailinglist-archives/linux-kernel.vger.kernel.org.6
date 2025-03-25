Return-Path: <linux-kernel+bounces-574645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04FA6E803
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A597189453B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAEB14B959;
	Tue, 25 Mar 2025 01:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AIV5qnxW"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5414293
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742866673; cv=none; b=PKYlqPncXllOsO+0AaRPQEcXlwoEp4B1icov+A34yRKasFCeNzfMXEi8YtSNHwkElnOeXNlp7cA7ZzI8uQIhHpYKrVhkcnuf1d72zuc42P/ESQPjfNRZJbZQ2gJfuZonMmgogT11W4xbwDRS9Et4IQYRVTa9pYqdxavXpfLpZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742866673; c=relaxed/simple;
	bh=uGNdSWg1MQGLQFN1wHoJ0q/BCMFc7eJ9Pb5ZoEgNuKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUN+i3wIeBpzFPKW1WCApASf2+qlNFzvJK9QUYP8ft7gjQuKkQCa4fL2fiKj7dvD7SD2zCjiI+/hzpitvoopMucwgiBZwtENIQqProAEMYGsa+bxJaQui6PIjGZxohTlUSFd4IWrHivlHLZ4KLMoGiyBJSklC7wae8TacenoRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AIV5qnxW; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742866661; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7aZMCkZ+HE4An/i1C0+Ohtb/3lMZesSY8n0GYQcLRTo=;
	b=AIV5qnxW9sW8CMvu3g9SQUpXg0mzANxE45Nhldku1HeGUOkPR4ge+4FWjcbv5TtjMd4RRlKCLhToYncED7DwhXaFaDuLv7buF5W0OVWsf/JEehh97erq3ELTVhSdDRKfZs850yMIt5QiV46PyfwK44b7zy1xBMW/beOlz2Qb5g0=
Received: from 30.74.129.51(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WStBDvD_1742866660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Mar 2025 09:37:40 +0800
Message-ID: <1b0ce59a-30a7-46e3-9c63-72c3f8d44b77@linux.alibaba.com>
Date: Tue, 25 Mar 2025 09:37:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] erofs: add start offset for file-backed mount
To: Sheng Yong <shengyong2021@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sheng Yong <shengyong1@xiaomi.com>,
 Wang Shuai <wangshuai12@xiaomi.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale
 <dhavale@google.com>, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <20250324022849.2715578-1-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250324022849.2715578-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yong!

On 2025/3/24 10:28, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> When attempting to use an archive file, such as APEX on android,
> as a file-backed mount source, it fails because EROFS image within
> the archive file does not start at offset 0. As a result, a loop
> device is still needed to attach the image file at an appropriate
> offset first.
> 
> To address this issue, this patch parses the `source' parameter in
> EROFS to accept a start offset for the file-backed mount. The format
> is `/path/to/archive_file:offs', where `offs' represents the start
> offset. EROFS will add this offset before performing read requests.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>

Sorry for late reply. Yeah, that is a great feature.

> ---

...

> @@ -411,6 +412,31 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
>   #endif
>   }
>   
> +static loff_t erofs_fc_parse_source(struct fs_context *fc,
> +				    struct fs_parameter *param)
> +{
> +	const char *devname = param->string;
> +	const char *fofs_start __maybe_unused;
> +	loff_t fofs = 0;
> +
> +	if (!devname || !*devname)
> +		return invalfc(fc, "Empty source");
> +
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +	fofs_start = strchr(devname, ':');
> +	if (!fofs_start)
> +		goto out;
> +	if (kstrtoll(fofs_start + 1, 0, &fofs) < 0)
> +		return invalfc(fc, "Invalid filebacked offset %s", fofs_start);
> +	fc->source = kstrndup(devname, fofs_start - devname, GFP_KERNEL);
> +	return fofs;
> +out:
> +#endif
> +	fc->source = devname;
> +	param->string = NULL;
> +	return fofs;
> +}

Could we just add a new mount option for this, and apply this feature
for both file-backed mounts and bdev-based mounts?

Twist source option is not quite clean on my side.



> +
>   static int erofs_fc_parse_param(struct fs_context *fc,
>   				struct fs_parameter *param)
>   {
> @@ -507,6 +533,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
>   		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
>   #endif
>   		break;
> +	case Opt_source:
> +		sbi->dif0.fofs = erofs_fc_parse_source(fc, param);
> +		if (sbi->dif0.fofs < 0)
> +			return -EINVAL;
> +		break;
>   	}
>   	return 0;
>   }
> @@ -697,6 +728,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>   		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
>   		if (IS_ERR(file))
>   			return PTR_ERR(file);
> +		if (sbi->dif0.fofs + PAGE_SIZE >= i_size_read(file_inode(file))) {
> +			fput(file);
> +			return invalf(fc, "Start offset too large");
> +		}

I guess we need to verify the offset is block-aligned too.

Thanks,
Gao Xiang

