Return-Path: <linux-kernel+bounces-416700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D8A9D48F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21419B20C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754811CACF2;
	Thu, 21 Nov 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyrmhKAY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437A1B0109
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178268; cv=none; b=oXSTKvwsMpre7rQscXFalZSVjhtm/qmDv38ntAl3tFnz1IUt3ATcq9s6qncqgcGDuG9m7/LvBL/0fR9GrJEdi+Yn7hQfkwfYVlTkiqeyGtXVDgCKOTtkRjYEoOrMsqzS/ykNamQHq9GVfu37VN3Hvh3Sl5JOjT8RLwSr1FoB6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178268; c=relaxed/simple;
	bh=cD4Fu3KbyxCyUuGjzEa4IuToSXO0RyJkQJKRw80eINU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvJVavX4wsJu+v488DSSHAF3b1HB5kqVx7gz401mEjnU6IYGBPG1RCnTsovEHSSCR/GRox3xqfUJ+8hjGUthIN7DbSp9MT/kA1VrwLpyI3AeY/G4jXMIRNSUGUrCEO1tIu8P+2PAodAGgPhqDJvglrySeNeOx7A97Cdhureqw0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NyrmhKAY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732178265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/bxOafOSRqeGDMIei40eQfZmBrNqEM9xnfr1EgoXyM=;
	b=NyrmhKAYuLH8lTsHBZUtueyclZB60iQAvebYbNAqU12bTE6KH4ToJB6f0Ck/bbUgR12SNO
	McO9wGrDVIzb80ab2QKiabkTYFt4iqJ2KjMhfcmuVTy3EV5b3KErI53g2cQqKtC2agi5nb
	B2MOf1tH87lakMOBnzM1jhbhPjkr7RQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-KvyMVTZTPjCQ5Q8RYuPPng-1; Thu, 21 Nov 2024 03:37:44 -0500
X-MC-Unique: KvyMVTZTPjCQ5Q8RYuPPng-1
X-Mimecast-MFC-AGG-ID: KvyMVTZTPjCQ5Q8RYuPPng
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-431604a3b47so4283085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178263; x=1732783063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/bxOafOSRqeGDMIei40eQfZmBrNqEM9xnfr1EgoXyM=;
        b=E/wXALwhn+5CeJCdkvj778QXiYDc8J+WHMHiAESQ7NXKwS9jMAeoIcx0oHwUyz93/H
         FN4J90bgKO9esmMFPqHukr0b1qYhRMb5ZG+zzc3h6WYFxv9Bxr2nnL7R4BjTo4OSQ+8b
         pLWBVmjV+SCVfEx2dV7zt1EYsvfgSEWOjwrQ/+6VbpjHONfXonuet3BKMtiMNb9f9tkY
         qFwstpXcGLpuTiMkYKKbPeGv/MJLE/v7CHti3HDtzh9tHQwVhde5eX+U8DKE4PQNMHzt
         IV10SNhnIE2yZX+dSotAnYhH0jDOSPzB7laaZZEs9rpdamUG9yFGOpmrwHCdeuvxygnk
         Kaug==
X-Gm-Message-State: AOJu0YwOc89Fy8MN3CFBPqPrwqt3T2XvE7i+12oPs52giJdkvhFSjyiJ
	Dj/yCKv0fbU278nuKv4+3TFEeCbg2CYlC2SvUBAidZw9Yz6XzuXge/R/enylOMbma0SWOCPmdRd
	NHQLTtUzfeYoHAdw6jvNcWWPNO1jwIkd3W7gXe3eFMuB4D5x+EzwtRxRYEoJVRQ==
X-Gm-Gg: ASbGncs1syB8vjvL0xjV6aTTUaHVGkLjT/GMYyiOQLOM7adSviPLp0Qm9qeiRKvQ53m
	Ur9XKKlr4b3ODU2gTipckNOXHxRIfTjsjatheJ+t97bjqO4XB2QYFXjmtY35Zi2oMwn7M9/5UfE
	btM8v9e3tbqqDVaaX/jzY/+2wsiguUQcq6TBK6DUrVeMxdrR5rBVJuaVz7biLqeqBgs3kXguHFx
	pJ0igJoRxLPKeilq26zu1KcmWVR5DFT+cEPwH/iiOcu9tXBOigfDnAUxhqX7sQfbE/xJdwD+Q==
X-Received: by 2002:a5d:598f:0:b0:382:415e:a144 with SMTP id ffacd0b85a97d-38254a83376mr4518903f8f.0.1732178262780;
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwhkitcAujwGpzsyn2UlIRtZ04mvp+DvbIZs8ciCgtCb6aWVOCkAcYbsRMTziLn3rq2vc0jg==
X-Received: by 2002:a5d:598f:0:b0:382:415e:a144 with SMTP id ffacd0b85a97d-38254a83376mr4518886f8f.0.1732178262430;
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493f3ebsm4208546f8f.105.2024.11.21.00.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:37:42 -0800 (PST)
Message-ID: <3646cb4f-4eb5-406d-9ea1-a407c3e03d45@redhat.com>
Date: Thu, 21 Nov 2024 09:37:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: openvswitch: convert
 call_rcu(dp_meter_instance_free_rcu) to kvfree_rcu()
To: Ran Xiaokai <ranxiaokai627@163.com>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mingo@redhat.com, peterz@infradead.org,
 pshelar@ovn.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
 linux-perf-users@vger.kernel.org, netdev@vger.kernel.org, dev@openvswitch.org
References: <20241120064716.3361211-1-ranxiaokai627@163.com>
 <20241120064716.3361211-4-ranxiaokai627@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120064716.3361211-4-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 07:47, Ran Xiaokai wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> The rcu callback dp_meter_instance_free_rcu() simply calls kvfree().
> It's better to directly call kvfree_rcu().
> 
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since the patches in this series are independent one from each other,
please break the series on a per subsystem basis. The patch 3 & 4 should
target the net-next tree. It will simplify maintainers life (and yours).

Also please note:

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle









