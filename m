Return-Path: <linux-kernel+bounces-349059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A798F03E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213B81F21E66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531B19C546;
	Thu,  3 Oct 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KuvmOa3x"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF47199936
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727961689; cv=none; b=POYSnowgBPzxB45n24G0DZ7GIIEWX/HdVBHA6l2LLASe1CizEpUxVm0NmV5AKPbsHUu0TlsKv24+Y4MAGmxSHxWqE39O3vZPyM+S0ASsPGGottnElEP2PQ++gxzMNR42JX7564cHxtzLwC+jPFDScmH4/76W9nxacvDebbJ0XYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727961689; c=relaxed/simple;
	bh=Z9XgoL99teLoFoNiHQ/T7CPkBXrpsvXcREZF6sRxZW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmQrKCD5BpkAsg5e4NkuYriO/KykKqDbGdBtC5G556pDU2ce2MiUL9mZv414OQSOPJ9E03Y5eMu6rMd0RFP54xi7ymJbKWCrIPW6Pw8TjS4cEadhsJThY+7P3BaV3Cf2PYaTnWoKTY8TC+Ts/QKvEFOmHu7z+sJWvXY0hwwUFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KuvmOa3x; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82ce1cd202cso46063739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727961687; x=1728566487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eULbr4TsoYa61/A8JOQXACnDP0XDqLP86c5gLY8rbmg=;
        b=KuvmOa3xE23DvQqNzwQdvTvE5UhT8Hy6VUFmYTpwJghzgzoaJrBwB/tYraSIFIHWyt
         mADm1kMG7XwSax9hL7oYBhGdYm1XoO6htVT2oKF38jyOEMrfp8RESfeIWwLbhRR7jF6+
         8Z6akxnNGCrQw0/uvENuU9yNjxQoJmkN2mojbt79L95DHTd28xtx51Y55pp1VMN4XvDu
         G5yyvDmbDiffzSu6bDnXIFaRb7G5lKsPbEmhZD1Vy3UqssnW6rHc0raptuxb2bD7TP2J
         GKAxMr4g34QbCk54YS0wYRgjcY8ay+LpIH2xOyFHGHAA/cEZfUTro9WEfLJcpA/ZzVd8
         Hx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727961687; x=1728566487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eULbr4TsoYa61/A8JOQXACnDP0XDqLP86c5gLY8rbmg=;
        b=kZEivlU5dPJbmKXErevbv/4U6bwcccbdmmBR44JOO3sphegwU64aUVXj/JgnYcqp4s
         QZkI5FYXQbORtErP+DKH8tEAgZtQoZfLn/ApvKW+Rod0fhR6Gu6jf9Brloof2+836ymj
         mmq1HO7BzD0S4jsTFG17IPFCvQtzhQHp7OwwaQKf4BAfpP616rZ4ZGmF1Dal6R8Sj/ZZ
         ZYMqaasDyK7P/PGzrHojcDBWp0dSnWuy+QKULMUeWQ6i/NHvLNj0cuXNJ9thwKO9FX3K
         ciHZiGl/tUsDdSHNLzeH+jXZiB/W75wbEKzt+bWu4GyfFfAqs3MQFt9OINGgGsPkKB8e
         HC4A==
X-Forwarded-Encrypted: i=1; AJvYcCXRwpWhn6+voSaGceq/GAzH22afj9jvJ3REkmV8j/Jo0MJ+3iyE1M4qyRG5M69A5dPCLLjpz1rbymGevCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNNnsly5YY1dI/V4S1ZzZFjt0qAHV3Ge+kUpfTp/iPhdPuSO5
	0TVAsdtX7SHAG0IoYuUM0FOrf6NQf0bdVEE0GXxTyCmRLtheaHqnQW0vTfsBFOE=
X-Google-Smtp-Source: AGHT+IFjlNg/Smwj4Ff8kYKTAbnsTGM3VJQtCnUDqYyE6RIcRzBsFaxmzd9qPRCnay5mniXJok6JvQ==
X-Received: by 2002:a05:6602:6409:b0:82b:42f:41d5 with SMTP id ca18e2360f4ac-834d84c3930mr696767539f.16.1727961686848;
        Thu, 03 Oct 2024 06:21:26 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55a63db7sm268802173.119.2024.10.03.06.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:21:26 -0700 (PDT)
Message-ID: <fe7ce685-f7e3-4963-a0d3-b992354ea1d8@kernel.dk>
Date: Thu, 3 Oct 2024 07:21:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Dan Carpenter <dan.carpenter@linaro.org>, Waiman Long <longman@redhat.com>
Cc: Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
 <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
 <925f3337-cf9b-4dc1-87ea-f1e63168fbc4@stanley.mountain>
 <df1cc7cb-bac6-4ec2-b148-0260654cc59a@redhat.com>
 <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3083c357-9684-45d3-a9c7-2cd2912275a1@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 6:03 AM, Dan Carpenter wrote:
>   3117                                  ioc_now(iocg->ioc, &now);
>   3118                                  weight_updated(iocg, &now);
>   3119                                  spin_unlock(&iocg->ioc->lock);
>   3120                          }
>   3121                  }
>   3122                  spin_unlock_irq(&blkcg->lock);
>   3123  
>   3124                  return nbytes;
>   3125          }
>   3126  
>   3127          blkg_conf_init(&ctx, buf);
>   3128  
>   3129          ret = blkg_conf_prep(blkcg, &blkcg_policy_iocost, &ctx);
>   3130          if (ret)
>   3131                  goto err;
>   3132  
>   3133          iocg = blkg_to_iocg(ctx.blkg);
>   3134  
>   3135          if (!strncmp(ctx.body, "default", 7)) {
>   3136                  v = 0;
>   3137          } else {
>   3138                  if (!sscanf(ctx.body, "%u", &v))
>   3139                          goto einval;
>   3140                  if (v < CGROUP_WEIGHT_MIN || v > CGROUP_WEIGHT_MAX)
>   3141                          goto einval;
>   3142          }
>   3143  
>   3144          spin_lock(&iocg->ioc->lock);
> 
> But why is this not spin_lock_irq()?  I haven't analyzed this so maybe it's
> fine.

That's a bug.

-- 
Jens Axboe

