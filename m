Return-Path: <linux-kernel+bounces-237769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3502923DE7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E984B26BDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391FD16DC2C;
	Tue,  2 Jul 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MJQNXths"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A715D5AB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923489; cv=none; b=D8+fbLAni/Z9YXI2f3OGRtsf9H5AeDDO7jwbQehqIHBHrNfROZ/JFkIAFhaZhrXEOvp0FGHJ8s8Ia4c1Nf/0olAbQ7zf7jkjYbx/tlBVfYRcu/89CgKVu36owQEbyZVZGrWWrxjWF9p16GooIhXhgIfv70u7SxZM/gQwpu/+zSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923489; c=relaxed/simple;
	bh=OMjHScwuQiZI5JvirqGlQaaKEsUp8flpn2XkS8V236E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0pSEhXj1PmW6IhETnlykaDrfb0bopszSQz55Nf5Wsiuzqdvx9n+IepKfKl+ihWR2j5kdiKJNocMbPVMGaEtgsr9F3YApK3uG/k6AqnjNT5UXcZ0j1/h21IBRaHJpCx0FiMgBIaZpyVp/CunXCvGOmnUHt/ql0VDDq9KZaIfSsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MJQNXths; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c86e3fb6e7so2598085a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719923487; x=1720528287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3bJl13ZaEh9srzSiGBUxKF7FnUSAqn8fdJDDL2oxlc=;
        b=MJQNXthsxgDmKMBtJTubpu7OUeaaKDX3J779sB9u0g1WaOSfJ45wzGwsIOwGBQ2GCS
         UnEYBun8dlZqOf2r+epUYiPFRUeyXmhM094HiQHry22462JPQ3aHPVaX6Vhp2hUIWc12
         tEjRKhHKERXtRJlotOSCfBB9E1l0vbyVyV6gjL0n5CeNSoIgpgd7ljk/MscAM/dFdOzB
         otlVdUEOOv5HeIwZZkVRHwgX+5nNSn/H+1QdYulNLBheyOLN7XBK8rehspd6C5wdszst
         iTbkcraEyDHKpnuH7NRTN1PftkXCwLP7H7mWP0/T2zDabJBDUrvGG6IcgbXdKFgQIJa8
         y1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923487; x=1720528287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3bJl13ZaEh9srzSiGBUxKF7FnUSAqn8fdJDDL2oxlc=;
        b=bIUpzRzIdXmH0ewzf4AwNfrKZ+2YO4C8BOp/FAjl1bBw1cGFZWAtgb8YAZZVLGvFiM
         o5QAU7P/RuCOw4ESe2XSyxZzq3kyzFRQ2BcZDKMuvZuE0QDuEpp5KIhFMEqdASTynA+0
         iQBOlv73OgTGvys2FGrppUEsbEHecSCZSJjvRWBxh9A/uPGfMY/RW63Fy6OZtxO+1M49
         lp1HseMwO9U+VEcuOsLrgMkP9xExboINVryOWUfhcNN1wSxugxYUWS8vNw+4vyPEi/xy
         Sm+4iKl8teIuE6Jo0ISNZGcftp2zzhy3X1V8gMwaQQcJiGZoM7WiQdrvLZUPOO9HVwBP
         Blkg==
X-Forwarded-Encrypted: i=1; AJvYcCXe4EMnFdUO5mOgmV3moJ4j+DzJu0he09G8GsnZvQFjf6hp7HC905eVYc+VWAGhxepiGOQBMkakTloH9OOzAjFr/mOeCFslclo5nVCl
X-Gm-Message-State: AOJu0YxqBz2lJLnkPbnWRTcMNn1n3oONUAQCQQ0ZZdJohEkFb8hfBseI
	mwWg3YHPRESeogP7MvEmQn9yvb7g4LKaFirnlz4EmvA0lJTVePX/yKQdVXDdSgI=
X-Google-Smtp-Source: AGHT+IEQmgs/v36TUzW9XWoPCZpKUIq41uJJFgwIz5VYPSN0CR6cvSwMrpKZEhWHqcEZfDk9htY4FA==
X-Received: by 2002:a17:90b:2dca:b0:2c9:57a4:a8c4 with SMTP id 98e67ed59e1d1-2c957a4baa0mr1358052a91.42.1719923487273;
        Tue, 02 Jul 2024 05:31:27 -0700 (PDT)
Received: from [10.3.154.188] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce432dasm8743605a91.17.2024.07.02.05.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 05:31:26 -0700 (PDT)
Message-ID: <a5c8edce-a314-4321-b2fb-4ed2dfeea481@bytedance.com>
Date: Tue, 2 Jul 2024 20:31:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v3 6/9] cachefiles: cancel all requests for the
 object that is being dropped
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com, jefflexu@linux.alibaba.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>, zhujia.zj@bytedance.com
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-7-libaokun@huaweicloud.com>
From: Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20240628062930.2467993-7-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/6/28 14:29, libaokun@huaweicloud.com 写道:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Because after an object is dropped, requests for that object are useless,
> cancel them to avoid causing other problems.
> 
> This prepares for the later addition of cancel_work_sync(). After the
> reopen requests is generated, cancel it to avoid cancel_work_sync()
> blocking by waiting for daemon to complete the reopen requests.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>

> ---
>   fs/cachefiles/ondemand.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 8a3b52c3ebba..36b97ded16b4 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -669,12 +669,31 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
>   
>   void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
>   {
> +	unsigned long index;
> +	struct cachefiles_req *req;
> +	struct cachefiles_cache *cache;
> +
>   	if (!object->ondemand)
>   		return;
>   
>   	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
>   			cachefiles_ondemand_init_close_req, NULL);
> +
> +	if (!object->ondemand->ondemand_id)
> +		return;
> +
> +	/* Cancel all requests for the object that is being dropped. */
> +	cache = object->volume->cache;
> +	xa_lock(&cache->reqs);
>   	cachefiles_ondemand_set_object_dropping(object);
> +	xa_for_each(&cache->reqs, index, req) {
> +		if (req->object == object) {
> +			req->error = -EIO;
> +			complete(&req->done);
> +			__xa_erase(&cache->reqs, index);
> +		}
> +	}
> +	xa_unlock(&cache->reqs);
>   }
>   
>   int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,

