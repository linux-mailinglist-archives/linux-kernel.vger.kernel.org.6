Return-Path: <linux-kernel+bounces-244736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874B92A8AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF001F21DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5731487C6;
	Mon,  8 Jul 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bStzFLFZ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB226AC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462104; cv=none; b=kMRyd8B65SjZ+xaIwWziDU+ibCsBoidiZAcSJApgnPwfg/NW0VmqZSAPf7hc8aLM9zAD9VbCyzlZI8qDgOGqy2aJCjYQk6vQkvOxS9JiITFHLkXbe40b0cGRTcd96IOQmFqzkJ2I5bZT2ZSnNWnVUEGXhmocFJgw7gORqzbmu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462104; c=relaxed/simple;
	bh=OZ2qvlhatjFKdYw6lPFWqkKX2kvvV8Xk7yWgvXMoNis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3DZ5GWhwKWsfh36MzrW0dhGoDV/5qOy3BXARVdRcv4j7x7x7oE8mBYQvPezZQ91t3vTwdeiqUKlClDfwAujyFDENdAzY5faUQ3v2n2AGFSoK7McCdGuEOsQ1Z9MUW+i+Qnm6/c5MMLTWYVo/foCaUV+eSjGwlTGbXfjv+knNe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bStzFLFZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-75fe9e62048so2135068a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720462102; x=1721066902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cRfJl0Bsu6ajq3qMMfxBmcE/2EUXS4oa9t+xYDFHhk=;
        b=bStzFLFZFWW9fRalaKb66RghdAsqu0IheENSgEvKaXMdImqYSJSfZuWVLxQ6OtEll1
         6HBVaquT3YLJsySXXzIijBfSoRDSc+frrzoMzsSw4F9GV7RQLio4aKzUPFXjxXIboB4y
         W6BkuxbgKQACEfr1PeWHpSKvQY7ZhQs7KVTSoxeMWCJoJwmQh2RBch7m8uN4u4eIp0Ag
         Ms34mZv7GKRgbNHI2uvnlP0i/iTOP0CtyiX2Rfo4vnKf3ouNgE5Pxw0lGMUQKj4faftG
         pij7vaQy/z+6gK6KRMbTU4d+2YL+PUv3uVpE6gWV3m2+h1C8BdbyRMjb2PMvk9p9JxLu
         Z0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462102; x=1721066902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cRfJl0Bsu6ajq3qMMfxBmcE/2EUXS4oa9t+xYDFHhk=;
        b=SnOLysn7cRtpd7vnwfXTW/hzTmvu/otrpVol9Vpn0F+nNI4juhKTdKltyana+LSrC8
         tnGStpvbICnbpx/uRAwYSA7tXnUIyvj+9PWt652dPGjuMUkD1jtbcqef9A9Pqws/DCjO
         InBDV5D0JlF1C1e77N2vHAQYzC8dW4s4SSKKNsn4TZ0jUQRRbMThxPLD6bThtQ8i0mlq
         zcH/WihLl+WSETCZxl8wfPxTAQ8r016fuVaPLTZzaxyJhoWnyPsA3VsjKqLWHEfZn0iL
         VpRhhYeob3tuE0JBzURFyzlh33t39tCBahMSwonsvtP1WNpTI3g0YZKONfojJV7cHL1/
         kh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvvG3kbvVQ3KkblHZKyQIbSrcFjG5RjcTcKLm48hTONODQ2G4JhX0O1bvERGHhlTEASbIgRr9PL76XkpxfZ+DclUnZiBgWuEBwcjWB
X-Gm-Message-State: AOJu0YxlPItto0pC4YJrQ/9O6TEasXxQFF0AU6Kqjj7j45U6/Nv4poIx
	RklXTkRD54WIVkL1l9gM4qF+Qozux7ClEaEaky9OytZe7t/0KMud
X-Google-Smtp-Source: AGHT+IFCv1NsC7pf1jmp5LRZ1WpG1YXmrcEp8QxYJPDsg3jsSioKEuJFyP32vEMCGtHcFZ7BHPwBqg==
X-Received: by 2002:a05:6a21:99a1:b0:1be:c2f7:275 with SMTP id adf61e73a8af0-1c2984c8768mr157828637.50.1720462102423;
        Mon, 08 Jul 2024 11:08:22 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab75ffsm1502885ad.175.2024.07.08.11.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:08:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:08:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Cheng Yu <serein.chengyu@huawei.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	changhuaixin@linux.alibaba.com, shanpeic@linux.alibaba.com,
	dtcccc@linux.alibaba.com, vishalc@linux.ibm.com,
	linux-kernel@vger.kernel.org, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	zhaowenhui8@huawei.com
Subject: Re: [PATCH v2] sched/fair: set burst to 0 when remove the
 restriction on cfs bandwidth
Message-ID: <ZowrFHHXNds36Nsb@slm.duckdns.org>
References: <20240708120053.861037-1-serein.chengyu@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708120053.861037-1-serein.chengyu@huawei.com>

Hello,

On Mon, Jul 08, 2024 at 08:00:53PM +0800, Cheng Yu wrote:
> From: Zhao Wenhui <zhaowenhui8@huawei.com>
> 
> In the cpu subsystem of cgroup v1 and v2, we set the restriction on cfs
> bandwidth by setting the quota and burst value. Later, when we remove
> the restriction by setting the quota to the default value, the burst
> value should also be forced to the its default value of zero.

Explaining a bit why burst value should become zero can be helpful - ie.
what happens when quota is not set but burst is limited?

...
> @@ -10840,6 +10840,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
>  				     burst + quota > max_cfs_runtime))
>  		return -EINVAL;
>  
> +	/*
> +	 * Ensure burst equals to zero when quota is -1.
> +	 */
> +	if (quota == RUNTIME_INF && burst)
> +		return -EINVAL;

This happening would be a bug, right? Would it make more sense to use
WARN_ON_ONCE()?

Thanks.

-- 
tejun

