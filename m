Return-Path: <linux-kernel+bounces-525452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B1BA3F02D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223527ABAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA8204F76;
	Fri, 21 Feb 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OT4/XvES"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45C2046AD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129882; cv=none; b=cVCdPH+cKqu5a9ZTdNlimu7T2Mj+vqslZcZrBmwne5z+jeYDiUVMQx4HWukH0uzKJG4429aisY1hvicRrz4crHzas0Mu+G/sXBD4aVgLRucevSyJvt76RrafdlkBjJO1sPM/Z9inI+xZ1g2MXkntGKxH7fBnraSRGar0LKW3hPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129882; c=relaxed/simple;
	bh=DTv9IgDCFSHkLIkM5pR4+LbykpRtGpw2Nod8ujiYIk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYLUxs40pGX8FjmB53vepEd8VTate6PWkR81/3MKAhf3nbCq4OC16TjJ2LvEOr1jWBXLa3x/Kvjg9e0pjsfWJOsdvi3DGuh26R6YrG1xMTIHqWQfQzNJL1FsIMog7zRPa1h/exmAo/lqEmyM7uyRSUSgpBBKFtrOQCVWW9CUQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OT4/XvES; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so2999415a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740129879; x=1740734679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t2OCFr3FvjMVutt67tzLs3oJXOFjcIvzlo6FuwE7EGw=;
        b=OT4/XvES+hEgYj4dIzyglPtmN/WmZJpGgjuAu3tUkvsXN8bwYG9FagrVkxuuyici4i
         gjg/Xa9jj2JDfNKOfKa81N4eshPyeAa7xcByVG/vPueWH/HF0ANqg6pwEC/an02Okah0
         lvztQLA6zlLU7jRniAfOgxYZjtHfhwOqOMftPe0cl9qwKrwIcFW7VMS3sbWtxN7Cqr05
         VPk5FAUghIvuVpiEXNxDU5pDsLtVu3V00+Yhr3JJjGFkPWmy/vf9/ZzgdmVIpkxesYBc
         IyLz/wNyQhzEuAz/pjx6KijGNQ4YSs+Fw/yqIAbyocZ19xLsdKLaaTXz/CKpC4zPCxh1
         Kp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129879; x=1740734679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2OCFr3FvjMVutt67tzLs3oJXOFjcIvzlo6FuwE7EGw=;
        b=gJbC71V4Hl7okw/iOy+d/VY4sWNi+lW4aNT9cmqGaN+U7ydSzAigFIve724lGQpJwt
         FWeJOruBog3rRAIe4tRHttLTvMfT8fTCL6u5PLjDNQbWGrIz7ncLgAFvSYq3oQIe/KLf
         XyuipNRGSt+J8/eNYgvF+uwJ49QF/F4xOaXokPB+Oyv6NDFdFf4Sqi3VC1qjotiCh3I8
         SC6lkvYBhU/zWJ32UjifZLjxbmF6kt7twNR0418GtWh05Vf1A50MFJNsDtEt4ERkA9rA
         cMEl/kDyWHRSLJBqlnRkyJzqztOtSXv2oNJ4iUfOUbmhP02gHAbf15TKLtEtJe1/X/C5
         /p2g==
X-Forwarded-Encrypted: i=1; AJvYcCXMXO8jRNzQJXLsamwYZplRrTADfghytWKz/PoPW5vH/MKZK3cZT+49PSjZjqFP4NbKtt2ENxJ9/59feqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9q6EBhJUUoyjk4bqFnCkIklvDNsFb9HP5tuzZ+7ckcLGqkoU
	JuypPhYNmcOSYraMClXIkZVDGMNhOWGOeKZ94xAOXLPuIz2QHuZAJsmZU33Op20=
X-Gm-Gg: ASbGncvk5aqnkUfNn4GiNr0VfOWLyIQCzR58aRzURC8sCPngzmvD5e6IIMSCcuHhuZu
	VijDv/BT0CwGXhtZ0YOD8Q/BPbvjY/2eAx1z42MvxrmC5HTOxsSGmNOzWjabTJNbMiIwf3FgWoY
	2vwmnsbQe35u1bT7+mKjqAXKqR9pXHRiNzbpicXsUfubGZONzmLfROZszUBMRe+4c6ZK2H3Yi4e
	qyiT69+9ZkJq1/xy9iifB5ngBIsgxjH9CEnEYdmGSoAqw3MeruKhofYMt5E/tx7pJldXYGVTu7X
	4B9kuzL0UDuQd+j+gLSg6UUztgaSUKo=
X-Google-Smtp-Source: AGHT+IGvsUKhSRAqepH1KbmQmRBn3Qp0tkLa9c2jo3XvRvzmw9oedXS1XvDKOvUW+mdkWwGyXUvSYg==
X-Received: by 2002:a05:6402:430c:b0:5da:d76:7b2e with SMTP id 4fb4d7f45d1cf-5e0b6fec4b4mr2071323a12.0.1740129879032;
        Fri, 21 Feb 2025 01:24:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dece1c58e2sm13551475a12.20.2025.02.21.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:24:38 -0800 (PST)
Date: Fri, 21 Feb 2025 12:24:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] sched: fix potential use-after-free with cfs bandwidth
Message-ID: <14f3ae5c-bf74-4a1a-aaf6-b113f7821d4d@stanley.mountain>
References: <20250221012335.233404-1-joshdon@google.com>
 <05f3fc66-f11d-4cda-8ea3-91aac650ec20@web.de>
 <9f1f3ff7-b4dc-43b0-993f-1f062f85d0a5@stanley.mountain>
 <7be6a786-18eb-464c-a47a-298208a343cc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7be6a786-18eb-464c-a47a-298208a343cc@web.de>

On Fri, Feb 21, 2025 at 09:33:24AM +0100, Markus Elfring wrote:
> > Markus, it was good to ask for a Fixes tag but now you're just distracting
> > people who are doing actual work.
> 
> Will any contributors add also a “stable tag”?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v6.14-rc3#n3
> 

Sure, it wouldn't hurt to add a stable tag.  In real life terms the
stable scripts are going to pick this one up automatically because
it has "use-after-free" in the subject.

regards,
dan carpenter


