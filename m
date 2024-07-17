Return-Path: <linux-kernel+bounces-255093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D868F933BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC1E1F23D70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D117F387;
	Wed, 17 Jul 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MV/1IOpf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75EF14A61B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214387; cv=none; b=J31JG8P0s7VB7O1tqBRohKndsNUuK+rZEH+lZJZjaqBtQVThmwMDvUmgyBMID45JGsRWlAFBC0hyKFCc0lrcm8GJB82nGkRi4JUbfOOQnRce1QfCIeza6K1wyVwzu/uc3nypKNtOUcJqqw14ZQ+H3uNQv4wKkoQ0/rPJNej/IDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214387; c=relaxed/simple;
	bh=Rgnc14t1XaU9RoAetWesEyPyRCyAFeeWF8j4uv8d1fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxDXUO2kez1qmx0pFnLpNAC+W5PAYKUUzEJTFXJXYGvQPjE/q2ILpdVH3zSso9w+DLQ4k2RONG3/d47W5L96pMgtBSBccObW7y7QRyAXip4WweHjkKx4WZ4ZPe7QeSvfWKLI2PzEJkeg91nKcJkttDK3XsuZ5xaVuPD5EJTcL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MV/1IOpf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721214383;
	bh=Rgnc14t1XaU9RoAetWesEyPyRCyAFeeWF8j4uv8d1fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MV/1IOpfOP/6LuqhAi1dpyZdnbK5+fm5NqNBzbyTDVYDvGqfth96D7u40SwjZENPS
	 0+VEQIFfSPTlI96hvCTFWbE9VYqYiKDDBECLmV1DYULR2y6VY8achyIJyZgKUJaBhE
	 IpPxXCNzaNHGIm/yX4opi9YhZYNzPaLQxOdQzg/D3scB8rBBWKNIDgJdwbkedhZfO1
	 JiNUZqoS2CGPqGgphENT88MjKFjfm9+Lh1ngTD97LliWjHjWM3MzYwomahqq7k55C8
	 6TVUw4LQZypH0xB/DrBB1a6d41xj/qHm2G27Es61v0jcy02QIjYr5hkHxbv5eKD3SB
	 JXf7ISY2RfthA==
Received: from [100.95.196.25] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: koike)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A9F133780BC9;
	Wed, 17 Jul 2024 11:06:20 +0000 (UTC)
Message-ID: <f9ed4aba-9a28-4620-be5f-9060556efd93@collabora.com>
Date: Wed, 17 Jul 2024 08:06:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ci: Upgrade setuptools requirement to 70.0.0
To: WangYuli <wangyuli@uniontech.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 david.heidelberg@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 vignesh.raman@collabora.com, torvalds@linux-foundation.org,
 guanwentao@uniontech.com
References: <0237854884D6DB3C+20240716083743.33415-1-wangyuli@uniontech.com>
Content-Language: en-US
From: Helen Koike <helen.koike@collabora.com>
In-Reply-To: <0237854884D6DB3C+20240716083743.33415-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/2024 05:37, WangYuli wrote:
> GitHub Dependabot has issued the following alert:
> 
> "Upgrade setuptools to version 70.0.0 or later.
> 
>   A vulnerability in the package_index module of pypa/setuptools
>   versions up to 69.1.1 allows for remote code execution via its
>   download functions. These functions, which are used to download
>   packages from URLs provided by users or retrieved from package
>   index servers, are susceptible to code injection. If these
>   functions are exposed to user-controlled inputs, such as package
>   URLs, they can execute arbitrary commands on the system. The
>   issue is fixed in version 70.0.
> 
>   Severity: 8.8 / 10 (High)
>   Attack vector:        Network
>   Attack complexity:        Low
>   Privileges required:     None
>   User interaction:    Required
>   Scope:              Unchanged
>   Confidentiality:         High
>   Integrity:               High
>   Availability:            High
>   CVE ID:         CVE-2024-6345"
> 
> To avoid disturbing everyone with the kernel repo hosted on GitHub,
> I suggest we upgrade our python dependencies once again to appease
> GitHub Dependabot.
> 
> Link: https://github.com/dependabot
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Acked-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
>   drivers/gpu/drm/ci/xfails/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ci/xfails/requirements.txt b/drivers/gpu/drm/ci/xfails/requirements.txt
> index e9994c9db799..5e6d48d98e4e 100644
> --- a/drivers/gpu/drm/ci/xfails/requirements.txt
> +++ b/drivers/gpu/drm/ci/xfails/requirements.txt
> @@ -11,7 +11,7 @@ requests==2.31.0
>   requests-toolbelt==1.0.0
>   ruamel.yaml==0.17.32
>   ruamel.yaml.clib==0.2.7
> -setuptools==68.0.0
> +setuptools==70.0.0
>   tenacity==8.2.3
>   urllib3==2.0.7
>   wheel==0.41.1


