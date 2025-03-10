Return-Path: <linux-kernel+bounces-554562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE0A599F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170A91887341
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64ED22A4C3;
	Mon, 10 Mar 2025 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEgXoxV5"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06933991;
	Mon, 10 Mar 2025 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620474; cv=none; b=AEGN4oXTux9f8AEqljuTKRvQPHQfj03pGo9xs2ExMAbUegm+nbGFqrw+Ruq0BSptWQD1VXFkqUZSgRWkfa2QqFRdpZBX1lBw3DNuI3w+ZU7rkGWiRAfXDs/qgKF+GahlexIaxGN8HY137i1ii6Z1wt9qjeWEH4ionYTMn3YVZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620474; c=relaxed/simple;
	bh=GHeCIejBa/8qy5r/VRqpKCRr3L5Bhtrr8ga8SUaRi/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6M4Sb5D+Wn5F9urmr5AkRceux5sRBB2Mq+hXYbsVk9Emsm4qfHwciSl3Pj2XvcPb9K/NgcGfEg8ozDg3QeDSPEBQKgsv+reW0Ild9CmEIyEOrq2XcQyD/UtbT0qk2ICFhN/+OnVMH1ZPZ2jBEtikm4RhBnZHNnD0jKT/XfnPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEgXoxV5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff64550991so6689662a91.0;
        Mon, 10 Mar 2025 08:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741620472; x=1742225272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90Pr0MLUGkbPrWS0RToq7eybxFstggF7+0XfcgNBeIA=;
        b=mEgXoxV5v4EsmjKqW4VihjRyDax5RmNlucp27kMP9aF1c8O9v6HlizMDZ2YaEHcHsN
         1QcSFCDglb//gU0ovvxGV0lZyqr5hpErifRI1Q98WXrW9Bt1A78tQQPjz5wKBPgEumUa
         xZvXVcDEpCA1sRSrz8MmDsqzT37tixq5AS0APP/lPlxtaoi4718gdK1B+JxQBb47wGjV
         Fjk81fWzjqf9DJ+OM9u5672jK8/G2I8xBbIY6nvs4oVr+fN7BgZKOwWwJHprhKUdflZ8
         xizs1vylQJi8UsQTCY5xk/aknSFRxwZqfSW4NWT8PmDW1hAGpiPuSS402CJYxTYKRDvn
         uCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741620472; x=1742225272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90Pr0MLUGkbPrWS0RToq7eybxFstggF7+0XfcgNBeIA=;
        b=h9oFchfraYPMem/1S/PdeUAUS8Lp6RIdgburOVylW7k7b+KHL1ADUoM9YRLLpwjnbX
         Ster/MoGGxhEN1y0BctZN49P0/bASu97ToUhvDqHB3sbzGzc0BgykHvcq7vku9JPvDDq
         Uw2N/YNuJs4rpMsy+D8qBesZ6WmbmTltwLNcqKGUgGRQvcVvyNVH83OD/AnN2oa0mjeZ
         JLbCkMimderwpwevQaS18cCB05IdvryGjB3xMGo9HY6/eiHXHItN0o1KC67sCYKW+wjL
         Ml3nZ4i6EZajFTrgvLaW/5IxXVeoZLOQqwrtPwyYCMwbNd1JAzfUxs+Ro3M597DxdCWs
         4Bzg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+C0mJj0a1uWwat1g68iisuq7w9whrOUsFQRnXjI7oPil6HTf02W1OM/niLJmyxi4RcDwMmF1RrC+9f2r@vger.kernel.org, AJvYcCWcjI/zlcbej6U0mg40xr0KxOGe/GQZeejFCJiIuUo5Fb0xPvE2twZu0RVgI2JAHqqZuwRHxgBUapY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwD+NXuwFr06bO90nB4HdAbTVjLee+xfaX5UeCMk+8rwmqHJY+
	X5/tvtXMRHWjSKbK5MF/HHRzbiuknHGkfD/bMWqH2gw0OswPCVbs52pGCw==
X-Gm-Gg: ASbGncvbHnkPC3lIsUUR48I9+UdBUmgpriQQYLuScp0JlLZQLRpvdl1LnmOBQbJ4Xz3
	n55T3NU1aFWYXjUsVtJYcY9/GC0blw1VLhgPbUxLqiZozL6Hm65vfk/yOahf282dDJ1olX3RO6w
	AE6vXZTXF4kGaUrTDM7Mj0Y1pqlFhnhPNzsV9N3bhqODm8KxDU7of9XwQWPdqHr7+yLjH2kbXW+
	hVtVjQItslz+boLszcJfQLrutpr9rkzZtr1Oaf1jNyaNdOwvplaP9Eda+1JiqyUrU3isErGYuJD
	ekgiZghsJ6lKTj4xaw1ucMsZZDHrg/QwAo7bYilu1bDBpHzz1XifrCEVlTJ6UB+KIDHeFS5SxMw
	s0RgzB3gGUqNEUK0=
X-Google-Smtp-Source: AGHT+IGA+KcU9d7S2wvRUSFjhmZkHNFVwGagUytgdzcLZ0PnDuYqInqLC+nzd6ZlLMmQ1zmAe19W8A==
X-Received: by 2002:a17:90b:2d82:b0:2ee:c2b5:97a0 with SMTP id 98e67ed59e1d1-2ff7cf0a651mr22485225a91.25.1741620470515;
        Mon, 10 Mar 2025 08:27:50 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4d457cd0sm10018080a91.0.2025.03.10.08.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 08:27:50 -0700 (PDT)
Message-ID: <bcce7d39-f142-4838-ba23-4fa2dda69fd0@gmail.com>
Date: Tue, 11 Mar 2025 00:27:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <20250310155301.6db5033c@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250310155301.6db5033c@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Mauro Carvalho Chehab wrote:
> Em Fri,  7 Mar 2025 13:04:51 +0530
[...]
>>  /**
>> - * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
>> + * cpumask_first_and - return the first cpu from *@srcp1 & *@srcp2
> 
> I don't think this would produce the right output. See my other comment.
> 
> See, if I add this there:
> 
> 	 * cpumask_first_and - return the first cpu from ``*srcp1`` & @srcp2 & *@srp3
> 
> The kernel-doc output is:
> 
> 	.. c:function:: unsigned int cpumask_first_and (const struct cpumask *srcp1, const struct cpumask *srcp2)
> 
> 	   return the first cpu from ``*srcp1`` & **srcp2** & ***srp3**
> 
> e.g.:
> 
> - srcp1: will not be bold, but it will use a monospaced font and will have 
> 	 an asterisk;
> 
> - srcp2: will be bold, without asterisk;
> 
> - srcp3: violates ReST spec: different versions may show it different
>          and warnings may be issued.

This third pattern is available since commit 69fc23efc7e5 ("kernel-doc:
Add unary operator * to $type_param_ref") and I haven't heard of any
regression report.

Sphinx parses ***srp3** in the following way:

  - It sees the first ** and start strong emphasis.
  - It continues that mode until it sees next **.

In the end, Sphinx will produce strongly emphasized "*srp3".

It would be much better to convert *@srp3 into "\*\ **srp3", which will
result in normal "*" followed by emphasized "srp3", but I didn't go that
far at that time.  This looked sufficient to me as a band-aid workaround.

Or you are aware of any Sphinx version who doesn't work in this way?

        Thanks, Akira


