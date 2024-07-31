Return-Path: <linux-kernel+bounces-269838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F16B943759
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964B02844E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A87C16CD2F;
	Wed, 31 Jul 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gUK3KgDr"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D9B16CD16
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458788; cv=none; b=RjBiJnwq7HSdctIkPbYqnbINyJKp63+PmqonkJ+njk3RfHrUcVtGtI3PMywlxXvYLH6ZI1wmvHx+gElNXk+lVZvIY7vKYh0L42n79UCVtkl+ZQxpJi5twGohV6KP4DqHFqTA2nQdL+LU6f88HVWtB/NSgjKzkFCk1YdzRN3PRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458788; c=relaxed/simple;
	bh=txmpJQycIV5QPKrTWpGC8PUo9tKcejxgqsvRbMC+V8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccpoFpPSg+hvdKtGUBD2FFE+JnfLsGDGYDlFqx411aV7OxW9M7WSjFw5a536UQLI2Ju+xxn4yBv3DIgqXyg9bh+RPjBtTMU6wJCK8/8FpO22cDLtCthHxB3smbk3/5A1z/hxhWTk51BDvpICbSmsMR9QSe3wLZK2rTZv5tDtrM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=gUK3KgDr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso5982265e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722458785; x=1723063585; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxpiuYMhfG8wroCEpsj+T0XsF8n6WcrGB7EkeYVEIFg=;
        b=gUK3KgDrIf3SDfrPly7lL/g4COmy1oDeJqy2LlzveAKKZ2lhHpArQwwY//wPF+Z4MH
         EWWUC2PECSxsdzGJAS/t4mD0HOm3ogStf7cHvddWiaL61YSCf4l+ukri3lcTU/IdZWiS
         i0CqkDeMpDe2e/yAfjZ86Qw7u3b0XimrmpWYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458785; x=1723063585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxpiuYMhfG8wroCEpsj+T0XsF8n6WcrGB7EkeYVEIFg=;
        b=YAu6SFjygzzuyZXa0miRwgQOR+lddpOtHQQYZpxv1Vw/jxjw99ZCkYm32e21lM0Ao9
         28Al3UnndPfxIaA3JCVa3yA/lyM3+VYHlS72gGs0xB9Hf06DfW2rDQLk0B5NrK8sr2qS
         KfiyDJ7oPJxnxsRKYIvawvADC0cXOdkwbp+MetBWy5pqvZl5AdPCBlLswzCYs53hcO48
         sQYbH8MJKNRuFQJVWhmaG5sxL8QxCdcuKfQFbdB9ZCioM3wk3tqxeGgbhYAaOcvJIIiL
         JEmvip4l4AAcrHO+ybBpxDUYqQSbhG6J8Aszw5hscCpAYvshRaFOqmOTmbakB1wznqo3
         dsag==
X-Forwarded-Encrypted: i=1; AJvYcCXT1r0dad7GxJc11JVOCJUVmyuu/r9exXAOSub22dx2m6tZOfY3Kf5/CPWu8o3X/6TOr8dcS12Ez80QE2Agvn0ftELkGgJygsFhu/5/
X-Gm-Message-State: AOJu0YycaIcyvmxrIaf9u7zcwv2V5c2JdXeBDpushi2w71/4tWPJPj7r
	mssrysMv3p5CtSgSjITiGHem/ShHDnqV9dL0xoOySRdv0LtuF5zmUsybWIZ4Iak=
X-Google-Smtp-Source: AGHT+IEOfnwTGBUJMCvgdzsVYm/9gkwgL+/zq/em2Ac2MZaEU7lsjUilDMlqzOjNzanNWiAy/HCT3A==
X-Received: by 2002:a05:600c:458e:b0:426:6358:7c5d with SMTP id 5b1f17b1804b1-428b4ae9a29mr2485615e9.4.1722458785050;
        Wed, 31 Jul 2024 13:46:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a246asm33360225e9.3.2024.07.31.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:46:24 -0700 (PDT)
Date: Wed, 31 Jul 2024 22:46:22 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Huan Yang <link@vivo.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v2 0/5] Introduce DMA_HEAP_ALLOC_AND_READ_FILE heap flag
Message-ID: <Zqqing7M2notp6Ou@phenom.ffwll.local>
Mail-Followup-To: Huan Yang <link@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
References: <20240730075755.10941-1-link@vivo.com>
 <Zqiqv7fomIp1IPS_@phenom.ffwll.local>
 <25cf34bd-b11f-4097-87b5-39e6b4a27d85@vivo.com>
 <37b07e69-df85-45fc-888d-54cb7c4be97a@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37b07e69-df85-45fc-888d-54cb7c4be97a@vivo.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Tue, Jul 30, 2024 at 08:04:04PM +0800, Huan Yang wrote:
> 
> 在 2024/7/30 17:05, Huan Yang 写道:
> > 
> > 在 2024/7/30 16:56, Daniel Vetter 写道:
> > > [????????? daniel.vetter@ffwll.ch ?????????
> > > https://aka.ms/LearnAboutSenderIdentification?????????????]
> > > 
> > > On Tue, Jul 30, 2024 at 03:57:44PM +0800, Huan Yang wrote:
> > > > UDMA-BUF step:
> > > >    1. memfd_create
> > > >    2. open file(buffer/direct)
> > > >    3. udmabuf create
> > > >    4. mmap memfd
> > > >    5. read file into memfd vaddr
> > > Yeah this is really slow and the worst way to do it. You absolutely want
> > > to start _all_ the io before you start creating the dma-buf, ideally
> > > with
> > > everything running in parallel. But just starting the direct I/O with
> > > async and then creating the umdabuf should be a lot faster and avoid
> > That's greate,  Let me rephrase that, and please correct me if I'm wrong.
> > 
> > UDMA-BUF step:
> >   1. memfd_create
> >   2. mmap memfd
> >   3. open file(buffer/direct)
> >   4. start thread to async read
> >   3. udmabuf create
> > 
> > With this, can improve
> 
> I just test with it. Step is:
> 
> UDMA-BUF step:
>   1. memfd_create
>   2. mmap memfd
>   3. open file(buffer/direct)
>   4. start thread to async read
>   5. udmabuf create
> 
>   6 . join wait
> 
> 3G file read all step cost 1,527,103,431ns, it's greate.

Ok that's almost the throughput of your patch set, which I think is close
enough. The remaining difference is probably just the mmap overhead, not
sure whether/how we can do direct i/o to an fd directly ... in principle
it's possible for any file that uses the standard pagecache.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

