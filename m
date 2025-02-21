Return-Path: <linux-kernel+bounces-524991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFBBA3E97A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB307A6080
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948EC1CF96;
	Fri, 21 Feb 2025 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2oHnFWjd"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC3AD5A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099307; cv=none; b=hDaUjp/4iAGNcub+C4Dl4DduVIUbQ8d1ODW59WFFhr9H6H7sU9UNowCHoqkArs/ezNyP2ESP9AqbaW2I376DhirZDQ/3KXqDAUrYqtQmVVEDpfiY+7ZlSJ/lVDVKYfjBWqIZSU7w99BRUobRZ6XcK/28Ten4Ig6NuoGPj4OEsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099307; c=relaxed/simple;
	bh=UzkvUUdgVIFy2qodyvDLcPZKdwb+CmoOWG16rppDGqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdp6xZRbzslSFF/NPXTV7j9wCZmvUJzcB/iX4Z7ByWb+6N4HtfOF+L7rwH/RrjO/XuTeaRjyh9y1fdrwu7qx+UCs7gXWVsnOxVYm1WHh9v2TT5SbVqePEoa5jN3/gTqJZD2sUvAPQNVqHr4SVdi6Br6dKC48Pyk+u+QmKbZ0sQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2oHnFWjd; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8559020a76aso42914539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740099304; x=1740704104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2QATB96FgepA0rjENrkG3iJn8Amj5leXDUOJcZKkX4=;
        b=2oHnFWjdTAYRf0+0qRzo7M10t4QXgXCRxz+/mlqisX2EIGZmEVsSxavqNKsNaWJrHe
         goJ/ybagUNivO0ZZQHkMf/9p9zAEWuQIoIcw0BYWr3atrYWusDKFlIePakUs18RxS2CD
         zoF8GNAm5d9mCONBu/Qk4rTMNcONqDXxbwMtxLqr6HKZjl+uRHpPd0UvbAersDiXyerY
         Ik+Oj/JoaNCCxSvqJQn7WGAjRYRHPy4hahgCLFxqWylyI3dS4lW4CXRpPOcJGX8C0rTw
         hCZVUt6f0ty/X1Zm8NPz/pvly+Ko/j/tXDnIRDqlONr81yqh/ZUGkln44dEK6Ae5imJF
         0DLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740099304; x=1740704104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2QATB96FgepA0rjENrkG3iJn8Amj5leXDUOJcZKkX4=;
        b=fUC0k5BJaRgDLv6sKknhMXhuSTSkPQkafcKXjw1c2bf4Hc7pOggesJqKbgUZUWCrz4
         Uk7Vgl1JTChQc4gVOmoKfaKbGeKlxPmIFkMtGuttguytKmmiOz6UxMCLHZCWkx5BlclO
         Ca6uz6NGk2vlMA1nHo8wP8IOWwopbFqDBXqw7B/ywe7uibBE4Wowp9kuZ63Vt3AdVQwE
         47X4Lu4t1l8wR4/Ai7imYhpYKG2pJtdps85UbOkHeiYQY64ozLwhqymMYQxYBShaI68k
         +DXngyd+6UMkJXwiMGWm8VVIE870Ttb6UeOB94HGlgz/1jH2nODQisuWjkIMtbM3dw8m
         PCzA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Te/2Z4/U04EqpXOp904ZYQjt5Q+mZ4O+G90POJ+2XTxJLsf7NfXOH8BlSzeBtCKSuyHxgG4O/+0nib4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFF8eI25Biwi4lBkmEkSJTs+AHLGy/s6Hrgg4Lh6cIpxzqNvo
	cCWFh7b8nZGG49GCDbQ/GHF3/9FKB1nyX720/TmAw4J+FkGLwDKZbH7JIFQMa+Y=
X-Gm-Gg: ASbGncsdWzKR5Wuznv0Zv1zsGGsiY85oOGKv4P2zP/GX1XudnBztlvI8XHRXEzbKUzP
	JStd05n7fB7n3kmQkKrSdS9m8Nwi4AOmUWaGZfiehsbUv2ugtdcYBolQo2jlxo7PT/67GNZKt6k
	qKnnxEK0of2ipkQ0VD3g48pwrDTbHak7w5YskwBh7J2GuY6EGD4OYwWMLg1L9AwJsMeAxc2j8wz
	o1Ek0mkPisYLa8HqHqvytQ8rQ5FLCPwV3os1HYXE3xJnhaKpVE8D7aV1sM+xnfxDVDUoEVTUduN
	igU1K+//GBYE
X-Google-Smtp-Source: AGHT+IEhwogP4yqzKlQCfCn6+V0oLpiZEIwarJ9K61JUTvJMx8CWnF/dcOiMl/AbHQVu7yQM6cO39Q==
X-Received: by 2002:a05:6e02:2413:b0:3d0:ca2:156d with SMTP id e9e14a558f8ab-3d2caf04813mr12139375ab.14.1740099304667;
        Thu, 20 Feb 2025 16:55:04 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d2a9fc622esm16071025ab.67.2025.02.20.16.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 16:55:02 -0800 (PST)
Message-ID: <0a11a42f-3476-46bd-b87a-a72d68344802@kernel.dk>
Date: Thu, 20 Feb 2025 17:55:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: map uring_cmd data even if address is 0
To: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Caleb Sander Mateos <csander@purestorage.com>
References: <20250220235101.119852-1-xizhang@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250220235101.119852-1-xizhang@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/25 4:51 PM, Xinyu Zhang wrote:
> When using kernel registered bvec fixed buffers, the "address" is
> actually the offset into the bvec rather than userspace address.
> Therefore it can be 0.
> We can skip checking whether the address is NULL before mapping
> uring_cmd data. Bad userspace address will be handled properly later when
> the user buffer is imported.
> With this patch, we will be able to use the kernel registered bvec fixed
> buffers in io_uring NVMe passthru with ublk zero-copy support in
> https://lore.kernel.org/io-uring/20250218224229.837848-1-kbusch@meta.com/T/#u.
> 
> Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/nvme/host/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 60383da86feda..724ab542b4c33 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -500,7 +500,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return PTR_ERR(req);
>  	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
>  
> -	if (d.addr && d.data_len) {
> +	if (d.data_len) {
>  		ret = nvme_map_user_request(req, d.addr,
>  			d.data_len, nvme_to_user_ptr(d.metadata),
>  			d.metadata_len, 0, ioucmd, vec);

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


