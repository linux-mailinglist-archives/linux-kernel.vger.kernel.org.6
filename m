Return-Path: <linux-kernel+bounces-247141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4649D92CBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5508E2830CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E982C63;
	Wed, 10 Jul 2024 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBtiC2LM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35DD535
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595896; cv=none; b=BhL5LnSbmj/DqBQnyULHkucrOKHfEZvSsKsK+tuC8i/o9N9qyGYMFZoIBaW/EIB7k/i97X9rw2e5dSCO0yfCE1L9WEjZNF0A7UBT3YXqeaEaLyYuBUH+4LO0u1tm7TCEIR3+qxXjk0vDAwyHjQ9NyT0ldUh2IEt/rOApzA1V5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595896; c=relaxed/simple;
	bh=y/2Uwf84AKVLMAatdGxP40dKI8PxpoAEQkovgd2zjXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofEyVCOGwhBgVI9CREgK2Q+jy5tACWr/OVaPt9elnaJtvhTOIqmca1dYUolEBPQPYt3is8vjFECGrjRfuPZ0nc4b/aCVkFMV8rVYW66YyR6TZbE7vbTXuR5/Cdj4CIwZ1nyIqN5LJDp/dDHI+sW/tLjmHQvllb6xWEZfpJZ6uVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBtiC2LM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720595893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dr5XCf0gY+osLWRevdHMR9c5fdKc3782+BL3hUmPAxs=;
	b=JBtiC2LM/w41BDx7S8eyZ9lNILoPKOhe5B2B6lsuiA9d3rThbxvnXYbM1qkQhliTehnyNu
	TMm5UHaiE+m5TCV4mcoAljeRKcMfZmo9kXtW7kzTMOqjUXNboIV+wbSlNlLjIdj+8nPEE4
	sUVWbmz3VYgjp6kXvlY/coHaC56ehu4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-DvAfUMUPNk6mP1NpdKmxqg-1; Wed, 10 Jul 2024 03:18:08 -0400
X-MC-Unique: DvAfUMUPNk6mP1NpdKmxqg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70af548db1eso468777b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595887; x=1721200687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr5XCf0gY+osLWRevdHMR9c5fdKc3782+BL3hUmPAxs=;
        b=r+M5L68JOCKeQrWnwmqM5c98DpE9hAUpK7aHvCGrZrVYnSP8ko5igo+AlhITvI5PQl
         5yRcym6t81WMmfeqiLUTukQHHIkAKtkzvNoRyLs/kkX3ldqR4GD/shTxCsWlnBVtQdqd
         yuiciGar8J6pfIaUCZHZVqchL2RMjLfUsDLPfhMGdWq21PMgyOUCtALkSHFWPrGhtLVp
         Y1tWi5apie7+0i+C+chHujjkCu9eca3byk0dFeRpfV8byMvgOa9Prx//e4X+MebUiH6J
         QrczKqeSAlde6LqTPzkMoNK78UGHsYDU/WNsZwcN9ZeQsA0DJQXEP4kw4hv8Huuo2/V+
         bsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWekbycJ4W+uIyjJwzg1gxBGdWjTdTb/0CAd2DG9ME8Wx6LEh2clj3tt3JhPydTtKhZmni7bg1dWAMQIASbY7h3aOoyk9463VpBUzqq
X-Gm-Message-State: AOJu0YysIl0kTcwyb1B2FlX5elpS/XDBGF3GTwjDUFMo9Fz7ikVG7n35
	zQ5K6Po5ewbRBNpAXMAWwXFOpNrggqBnT5yC/SK0QCzloKk/dlv8IpMbp65XmQT3gAA5EPEEykd
	S9u/eKJurWEd11W3nj834QtzYLtpR+pBe30cOCw0aPJsNP2h1aCQPqGv/lmTwow==
X-Received: by 2002:a05:6a00:2d0b:b0:6f6:76c8:122c with SMTP id d2e1a72fcca58-70b44dd31bemr6568586b3a.16.1720595887542;
        Wed, 10 Jul 2024 00:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtKQKWIntnO93T2N5/0HkX4mUK4StkTYBoYwJlFsG21sb0V6OHhpb0kgUFy/S8AFfw69nf4Q==
X-Received: by 2002:a05:6a00:2d0b:b0:6f6:76c8:122c with SMTP id d2e1a72fcca58-70b44dd31bemr6568559b3a.16.1720595887130;
        Wed, 10 Jul 2024 00:18:07 -0700 (PDT)
Received: from [10.72.116.145] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4396752esm3020696b3a.125.2024.07.10.00.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 00:18:06 -0700 (PDT)
Message-ID: <0c9db292-7b13-4d95-bc5f-f96800ea91b7@redhat.com>
Date: Wed, 10 Jul 2024 15:18:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240709064400.869619-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <20240709064400.869619-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/9/24 14:44, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   fs/ceph/dir.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 5aadc56e0cc0..18c72b305858 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1589,7 +1589,7 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
>   	}
>   
>   	spin_lock(&mdsc->dentry_list_lock);
> -	__dentry_dir_lease_touch(mdsc, di),
> +	__dentry_dir_lease_touch(mdsc, di);
>   	spin_unlock(&mdsc->dentry_list_lock);
>   }
>   
Reviewed-by: Xiubo Li <xiubli@redhat.com>


