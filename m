Return-Path: <linux-kernel+bounces-247817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 783F092D4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5ED1F21902
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1EF191494;
	Wed, 10 Jul 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CkqcZUIA"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8471946C2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625409; cv=none; b=tM5DqY0hXhy04di+vgf4h2kviTWj21iWaQzv9yf8MMBmDCu36x0YTV+gkZ18lT3hLdocqj5fGQgQQ0LwKre1BSoTWulSYRqQwHaw554G0HYXUMf9SvBWDapvUGenrZRRzJCh3SGwBC7l1bc5QU57VrpUAoZj/peN/JYdlckCMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625409; c=relaxed/simple;
	bh=8/gfPXWxxf7FOY8AgpmCewWXxXTZYt2IGleiv5CqE8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aohTL0akSTMncJoINJwI2LvhIxGEXL1HwQN8eyXgzL0ixvDBcFLz/t+CrSWjmHRfdzcatvjkxFudcEGNFah4WkqyqQaVY330GFlUmvfeuRvX49EFmOR1rQtNH8bd6iu1SQ4P/o8SFckSXR5raqpbclOiBZe/kveibmp4yypxhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CkqcZUIA; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7fb3529622dso12823539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720625406; x=1721230206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gh4KlpRRZVtRU7Y7a9D5NYIzadIHQ/XSQ7aTvmHJrcU=;
        b=CkqcZUIAEsLP7D+L1o6ycdoU+bQ3sEcRS7O1q+3JvY8FIziIPHNrnUVtIBk+Pe2nRz
         U1E0xNBjfw+iDCOhbSCSoA6FenmLSILVRTZ8wHm9ZyhTI/upboGAwoqN8JTK+hmXUBD5
         8kv55PVsfz60McK9T6XfCzB4Rd4DlKkCKs7Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625406; x=1721230206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh4KlpRRZVtRU7Y7a9D5NYIzadIHQ/XSQ7aTvmHJrcU=;
        b=qfeqlE8FqIiW3iLvq27EBQpnZ2ay35mAgLvGOSGeMOM+a6Hju77wRtZ4mbIOjaqxaM
         d1a0TCLHy2H0sAfrNe9+qqZjD/O/D0omQIZNRe1Yq43P4puRJYXLlV4cTTevYGy92x5U
         kWYsnTeDzEnki88k8mkk6l7wYx5sKs5z2e4ou+B8kCDwx1OZ1+YKRcdDz8NigkmNNUsg
         +/oq+9t7BOLsZynqElDC6mT49XsqqNVCSD/gvJX4j+u3uoM67uzb5mnocO8ZpIM2QnDB
         vhJeTUCFF80O+nQO8QTGa0UvbJ59LkSdLt+s+QTlUiDgpf2QludJMVAh8XxJpUW5dZHc
         f3dg==
X-Forwarded-Encrypted: i=1; AJvYcCVIkBStuxj0sDRM8/auy/eUPjzaFMuxna1sKspfbe1floZc2T3WO5YLZz8irnEIeu2u64PuZdCQALzX6SzwuWSjWUsxj2NOqN697np8
X-Gm-Message-State: AOJu0YyvPAkMlWACrzN24oRpdQElBYeHqZQnMWmjqIhtTOlBxUCbo4DS
	LF5h+VG/IExngE0D3Sa/a+U26Z+yjs54kA87qUdLzUwe3Fy3ge/ZmUNQpL4KgY49stGhwFU8CrC
	j
X-Google-Smtp-Source: AGHT+IEaNw0ouQ+VXx2iRgxdND1WLK34gMh/WUa7EyQuElws8C+1LmKST3HSfMbu0U5iEmjqwA1QWQ==
X-Received: by 2002:a05:6602:3413:b0:7f8:bfcd:db53 with SMTP id ca18e2360f4ac-8000269672bmr658618839f.1.1720625405978;
        Wed, 10 Jul 2024 08:30:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c13848sm1184863173.133.2024.07.10.08.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:30:05 -0700 (PDT)
Message-ID: <273183c9-101c-422b-9fcd-a9921c127cb1@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:30:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf:fix a resource leak
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, jolsa@kernel.org,
 shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710015913.2554-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710015913.2554-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 19:59, Zhu Jun wrote:
> The requested resources should be closed before return
> in main(), otherwise resource leak will occur
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

How did you find this problem? Please give more details
on the tool used including the output from the tool.
> ---
> Changes in v2:
>   - check for cg_fd >= 0 and have just one out label
> 
>   tools/testing/selftests/bpf/test_sockmap.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index a34e95040994..285a9a714666 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -2075,8 +2075,10 @@ int main(int argc, char **argv)
>   
>   	if (!cg_fd) {
>   		cg_fd = cgroup_setup_and_join(CG_PATH);
> -		if (cg_fd < 0)
> -			return cg_fd;
> +		if (cg_fd < 0) {
> +			err = cg_fd;
> +			goto out;
> +		}

I don't this this improves the code - it makes it more complex.
If you want to improve this - add the same error message that
gets printed out for

case 'c':

in argument parsing.

fprintf(stderr, "ERROR: (%i) open cg path failed: %s\n",
                  cg_fd, optarg);
>   		cg_created = 1;
>   	}
>   
> @@ -2092,7 +2094,7 @@ int main(int argc, char **argv)
>   	if (err) {
>   		fprintf(stderr, "populate program: (%s) %s\n",
>   			bpf_file, strerror(errno));
> -		return 1;
> +		goto out;

This looks good to me.

>   	}
>   	running = 1;
>   
> @@ -2109,7 +2111,8 @@ int main(int argc, char **argv)
>   		free(options.whitelist);
>   	if (options.blacklist)
>   		free(options.blacklist);
> -	close(cg_fd);
> +	if (cg_fd >= 0)

Why is this check necessary?
> +		close(cg_fd);


>   	if (cg_created)
>   		cleanup_cgroup_environment();
>   	return err;

thanks,
-- Shuah

