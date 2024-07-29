Return-Path: <linux-kernel+bounces-265196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47093EDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35112282A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F1128812;
	Mon, 29 Jul 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BSwQEp+y"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3186277
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236524; cv=none; b=Wr0j/HfwKootrruhfWm8Y5Xo6brXIzMcqUl6gomX5f9gCnCOmDmxSXwLEadupkGFURPoOydIu1bFgrGeIJ5gD9WdpgUaYcqpqnwnvXayoHzNTX2XL35KeEByIvg3ejoil0HXhoAqKMSDfsEqvyl6uMjKGoTZsFAmPqi75r8Ckxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236524; c=relaxed/simple;
	bh=OfOwg30Kz1gJciOmBHTSSNW3kho05OpZx0+UKqjPXek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAjXWszXa3OSvGv6y5vLu+moHid/4bh/PfQxJsYj7+wrxbgkIJNvcEjvrPBTejmoKSeFJnKBOf9g5fMAlXpPo6o+sXdjivG2PBmpnRSUIfC3GrFASsafzfwJC+7+/jmc22rnUkJDEJHMZ8pH4XNdN1uzkM9OncgLck5ynfBHcSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=BSwQEp+y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42803adb420so2452245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722236520; x=1722841320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jiq86OgV8aN77ZK3gSdcC84nDSEMhthS0/eJkO/i+l0=;
        b=BSwQEp+ySpncpgp63OameFPhiH6ErcJioouSgYkOB6drGXlemsvgB71njPs50gSOZK
         S69kyESkhmfal7dOmYV+iHrPGaAM16liGAqeKR6XH69h8i94HPv2/LRHjkuucbrucdUH
         Jyc8nHam4I7ZqzDlfSFB5tbETd0ooeMq931/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722236520; x=1722841320;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jiq86OgV8aN77ZK3gSdcC84nDSEMhthS0/eJkO/i+l0=;
        b=f09ZNZXiInWtlJ3izeaIgde8vz+eSm7Nq+mJW33MkOQMy5fmfTwSaqRkP1leDenidE
         TpOTAJFLGvH4c5suyEP3ELR7RhdvyLDCRIQAPRpe4mB2ydrYeagn0ZlQ93vOq4JZJ8ur
         somRylxAyo5LIfwb9DscxJVxvOrDpUi//HW8e0dYumC64NyA9f3YXdLpcuZUW3Hwq7cH
         /JxmSGyr9N6Hvwg3hmi/RS4OJmFcLYuVqhZn5iBwZs0Ccje1EqwsfHR3LLgBrnwkk1ti
         FaNlTsKOVOPSoxSSlqogybg1RMOJQXKAIFBI0TpNSp1TYMI5vH/jqHpCS2Vj1HtsCuZT
         6+dg==
X-Forwarded-Encrypted: i=1; AJvYcCWN5bm7EDWlnpRBxC3P7HgjlscLk5dUa8zvb1tlp9JntDh3jla+I2hjVahCRBuWQ926iiLQ0jvKJ71GNoVfrxGSTPtdMSDct0zKwt6C
X-Gm-Message-State: AOJu0YyZfKcLR1X8Yw13K6sWs3MQFp4JfZV0O0B+WE5TnAh37x93j9zs
	099opWgKvlJbpDs5vxnhrw3sVbA4AZAmRXSw8B+ysEc7QxUBhb0kMMj4A6RvT5w=
X-Google-Smtp-Source: AGHT+IEiT+O8ufmV6ZCYKgzAur7uD7ABX1l7m8G+4knDu8SiWra9FtLVycZ8kwh2N41DGIzudaMzfQ==
X-Received: by 2002:a05:600c:4511:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-428053beee0mr56974615e9.0.1722236519848;
        Mon, 29 Jul 2024 00:01:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281225141dsm83180525e9.45.2024.07.29.00.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:01:59 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:01:57 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, shuah@kernel.org,
	wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2] kselftests: dmabuf-heaps: Ensure the driver name is
 null-terminated
Message-ID: <Zqc-ZWlTYwnKHoQK@phenom.ffwll.local>
Mail-Followup-To: Zenghui Yu <yuzenghui@huawei.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, shuah@kernel.org,
	wanghaibin.wang@huawei.com
References: <20240729024604.2046-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729024604.2046-1-yuzenghui@huawei.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Mon, Jul 29, 2024 at 10:46:04AM +0800, Zenghui Yu wrote:
> Even if a vgem device is configured in, we will skip the import_vgem_fd()
> test almost every time.
> 
>   TAP version 13
>   1..11
>   # Testing heap: system
>   # =======================================
>   # Testing allocation and importing:
>   ok 1 # SKIP Could not open vgem -1
> 
> The problem is that we use the DRM_IOCTL_VERSION ioctl to query the driver
> version information but leave the name field a non-null-terminated string.
> Terminate it properly to actually test against the vgem device.
> 
> While at it, let's check the length of the driver name is exactly 4 bytes
> and return early otherwise (in case there is a name like "vgemfoo" that
> gets converted to "vgem\0" unexpectedly).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> * From v1 [1]:
>   - Check version.name_len is exactly 4 bytes and return early otherwise
> 
> [1] https://lore.kernel.org/r/20240708134654.1725-1-yuzenghui@huawei.com

Thanks for your patch, I'll push it to drm-misc-next-fixes.

> P.S., Maybe worth including the kselftests file into "DMA-BUF HEAPS
> FRAMEWORK" MAINTAINERS entry?

Good idea, want to do the patch for that too?

Cheers, Sima


> 
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index 5f541522364f..5d0a809dc2df 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -29,9 +29,11 @@ static int check_vgem(int fd)
>  	version.name = name;
>  
>  	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
> -	if (ret)
> +	if (ret || version.name_len != 4)
>  		return 0;
>  
> +	name[4] = '\0';
> +
>  	return !strcmp(name, "vgem");
>  }
>  
> -- 
> 2.33.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

