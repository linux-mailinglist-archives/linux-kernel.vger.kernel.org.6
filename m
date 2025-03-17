Return-Path: <linux-kernel+bounces-563658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CDA6463B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820E53A8D39
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642A2206AA;
	Mon, 17 Mar 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toj8Xlc3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335038B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201454; cv=none; b=DRDAf90nh0cQl6sTDcWAQPhMOLsqJb3S8gt8UC+mwRp7E7AVcrJkduxLp2b2N/0Pf11QBF5ZmQTqmSk76scrmgx6rONBJF73Vf6/M2Fyd5e+dySX9Iu65iSSqyMB6UZqEN1w1BTclrgPe5BUvBXD6TtedDIHDasWlAAFBgRnjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201454; c=relaxed/simple;
	bh=VHECRl2IlCN2X1A9iaO/EubBXIx8uJARjFhkbegqTbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8FsG15ATUKjdC3xA6wUFohBlk5GsPVhqN8jORlg2xeZzI6i6FJksh/idNLE+zBTxRalFAncH0Gu5U37GxZUpdopD1M/ASR3zXExVEYqWWTVbDkM+ipQJPg2VMAmpB2nOTept1bD/693tnd4fM+vaK8w15zzPyb8kFpV26g4y84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Toj8Xlc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7BEC4CEE3;
	Mon, 17 Mar 2025 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742201451;
	bh=VHECRl2IlCN2X1A9iaO/EubBXIx8uJARjFhkbegqTbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Toj8Xlc3B+lpeJ0cMKX/lJh6zMc7AxNRoI/VBi9LvUJ5WgKnN4HCfIlX22IFWpY9D
	 efuqk7QOYu0TkXk7js3E9UBvHiRGNYhIlnOhvIe4/tlLdFR4GULsDjfh/mRof3Ysi1
	 bK75usT+xVXM2ajJncHR7JFPdT3bHHGtFiU5vqPaeCZoWaVcLiJkNl1dF27NMBpkAo
	 xifrWrgFre4Fq8F+tDNlM10ry9cr+DupcCilyKZvsK32FMjxOnPZje/6nrUw1g7psM
	 Ry71q2hACD7E8ydmFVfJAL2LKppv9G9p4FmyertQD7sCCgLgvctlnmjfPfYUp7NPYA
	 7w+heJf2gT6zg==
Message-ID: <23781043-901b-422c-8199-10aa4a31459e@kernel.org>
Date: Mon, 17 Mar 2025 09:50:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/pciback: use sysfs_emit_at() instead of scnprintf()
To: tang.dongxing@zte.com.cn, jgross@suse.com
Cc: sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 jiqian.chen@amd.com, ray.huang@amd.com, jeff.johnson@oss.qualcomm.com,
 minhuadotchen@gmail.com, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, ye.xingchen@zte.com.cn,
 yang.guang5@zte.com.cn, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
References: <20250317151648132Sj7qhbVfKcPYvqCievFUf@zte.com.cn>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250317151648132Sj7qhbVfKcPYvqCievFUf@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17. 03. 25, 8:16, tang.dongxing@zte.com.cn wrote:
> From: TangDongxing <tang.dongxing@zte.com.cn>
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: TangDongxing <tang.dongxing@zte.com.cn>
> ---
>   drivers/xen/xen-pciback/pci_stub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
> index b616b7768c3b..a0782a74ed34 100644
> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -1281,7 +1281,7 @@ static ssize_t slots_show(struct device_driver *drv, char *buf)
>   		if (count >= PAGE_SIZE)
>   			break;
> 
> -		count += scnprintf(buf + count, PAGE_SIZE - count,
> +		count += sysfs_emit_at(buf, count,

This is wrong too [1].

[1] 
https://lore.kernel.org/all/9c552d9a-2d46-4069-a9c4-35fab857bfc3@kernel.org/

regards,
-- 
js
suse labs


