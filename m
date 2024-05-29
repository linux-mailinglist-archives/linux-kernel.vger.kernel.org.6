Return-Path: <linux-kernel+bounces-193954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 895AF8D3482
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196441F22645
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB017B411;
	Wed, 29 May 2024 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zELE13gd"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD817A91B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978386; cv=none; b=VKARCnVc3iW0KGIMGmJ7Fkx25SeJ3cM5j4ixMKWjEOBrMA8dXM6hcgSIYcKMukjyk1r9Xp9GNh0gWb0hFCbV+mv4Vkm6D79ejDusWy9y3bw3cV5HOt+E8ugHfO/BMOZm7QboaP2CdfnnH3X9JW6w5Jqv1XFPRhlgVJK2rQ6ts1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978386; c=relaxed/simple;
	bh=lnRddKFcAoYT+tdiO+T64N/X4UwtldTOoym7fVYnzRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLI8nse171e3TB8AwdC4Rl3DGoQaBebGlOU/jLMt4aYhT4BFNnOX6uo7rHyR/L6B6ryOq+l8D80vgOgsYXaLzzWOpJZFFbaYcY0X7GKkylZJmQva21jHCMdNI1ToSRUIwLKQ1sjTlvoEm5q+yMh5NoPyrWots0kQTZOobycKMPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zELE13gd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so3622885e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716978383; x=1717583183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LG4i7mbUzkEJRUAZg6ZfpW9p6gCCgVIHlxO5mLVFmZE=;
        b=zELE13gdHD2dG804Dlvjij5M/QsVkBUbcR8MueYEh8oVJ4kTjlKvfa7a27MNqdSPIR
         TJnI6M3l+7nfuOyI7Fb6oE+NLIdSaQ6XioY+kErtL/lIXkKtP5NbUpGZqNFdBSEsajJh
         sQ6G2TzkuS2LkBWsioRCjpQV9Ssik5ny6c5F8HtCWRknMTk0t9CYX3+MwFV43zIyoLmH
         KGdDk1zkbGvyeJMJt6aeLuS4VkLZh4DbgPc/mXMiJ4SEn98KvdGW6R8WfmogjLm8fjUj
         qPDhWyCOxP/rFNWRILTCPo9xFQ+jZMDzUGzKvAIhRWqYKpI4APGJLN7DeWzbzW4jIszQ
         VmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716978383; x=1717583183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LG4i7mbUzkEJRUAZg6ZfpW9p6gCCgVIHlxO5mLVFmZE=;
        b=maPlt6v6SRRr8PRBJPyRYkZ2+DcdfNMJdhx212UrCMVvIZvsg2zitqLtM/IEvbO6kM
         eoFl9GAtCZo+7n9QBhKaurhlXjIx7FRzgVNTYrb+pcz7fGRIlQTMbM9+sv1DRmbEMZRD
         ml9yDSvVzyWl8k05S4CrxgK1wCUoXiJKkbMJD0pnqg6k3TB13PF+6ut9LTpv0ZoadfOn
         /nffw34ox7RLmDOvGR2fOaIoiv9ry3len61CAL/D9NUEXNokCkbyE3eLJXGv29lKa2Hg
         Kw10SrKXbAYG1E5bRsA0KNs3b8/sHA9y/AHIa8DXa6Mrt+ksVJojV0jZLlZAtAoGj2Tk
         kU/w==
X-Forwarded-Encrypted: i=1; AJvYcCXIZFV26aursbZDCIiIgJGwMbIum6hq1F3VkAx61CojAbHbN1qBZRfyQMyrOq/q5gcorkt0dAnwHL/Jn0O3vJG/KIKyqt4K5GtEOlNx
X-Gm-Message-State: AOJu0Yz6iFa+t8qsVQ3TkObImCe6fE578CF9COIhsgAEsZlmBK3/tbaZ
	LjylICEIRY0puN81DAbV3BPZqNxlGMkuCEUe2DTrsdrtAF4/J2kQ1o/XnuD9TtU=
X-Google-Smtp-Source: AGHT+IFL2rVV6ZbLHtKwQ0pcVenJyjGhOLmyWzjE6L3t1oMaAdsd+Kz4zXnPAVzfGK1vk+ACrvUJSQ==
X-Received: by 2002:a05:600c:21c2:b0:41c:a9:26b3 with SMTP id 5b1f17b1804b1-42122b0d580mr13483695e9.19.1716978382753;
        Wed, 29 May 2024 03:26:22 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212348aa22sm19748435e9.36.2024.05.29.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:26:22 -0700 (PDT)
Date: Wed, 29 May 2024 11:26:21 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] sched/rt, dl: Convert functions to return bool
Message-ID: <20240529102621.km5ajaeyzzpqke4g@airbuntu>
References: <20240527234508.1062360-1-qyousef@layalina.io>
 <20240527234508.1062360-4-qyousef@layalina.io>
 <20240529073451.IIA7HXMj@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529073451.IIA7HXMj@linutronix.de>

On 05/29/24 09:34, Sebastian Andrzej Siewior wrote:
> On 2024-05-28 00:45:08 [+0100], Qais Yousef wrote:
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index 5cb88b748ad6..87d2370dd3db 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -10,7 +10,7 @@
> >  
> >  #include <linux/sched.h>
> >  
> > -static inline int dl_prio(int prio)
> > +static inline bool dl_prio(int prio)
> >  {
> >  	if (unlikely(prio < MAX_DL_PRIO))
> >  		return 1;
> 
> if we return a bool we should return true/ false.

Right. Fixed.

Thanks!

--
Qais Yousef

