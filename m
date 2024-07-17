Return-Path: <linux-kernel+bounces-255349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6735E933F84
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FC31C23239
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F5181BA2;
	Wed, 17 Jul 2024 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cu3u8rT/"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15D17F362
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229811; cv=none; b=SBS2eVh32T+U58xjtKqOUsTPEbJAFpNyN+T/f/FtQH34DZJGpFxmpC6kh5svibaMoKlw/Mv6oats00mdlROuNzCeXzdwlIr8P7FFtr1hieLGC+fntE03AKg1/XKRKzWqfUYyApDhdO0hByliVf5lxxGAbLufbpZ5ra6D1I60UPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229811; c=relaxed/simple;
	bh=j0UOPSoEGVml3pfFuqrKfqqXKZFHJ56igMC9TwjP/hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsg7/yR4Ivi0zd8nkXp6Pc3+4/AYkwmCT0bVXW+zxWzlLgNoH5DeYcylF7X+Ocp7PmKqlJlGra242vDQtfBARel5s5LoFA9S5ctpzvG438NXdNqs3nYM1uqw9bBe6I3Jrj6UeUzLGvr64eP2S47WfQt/whr/dqGp1oUZYKcyPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=cu3u8rT/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee94169e66so7830621fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1721229804; x=1721834604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8FiZ3Q3HqoLocenTRjlmRJv2b/Y73q4whh/GunuTuQ=;
        b=cu3u8rT/BMDyt7pNU/je1GbJxKa+5HF26qn+P3eMHJb4dhYI6/kDWWqe1EAjKUULNc
         FEaj8gsk7dxkb8Hdl50Ri38rhA4J5ZklEUxm1wj1EujyaUWJI8FnnCBtI9KbjNHU1O2Z
         7iMdm4td7e84xiOuUn6WfJbXerWVBfC0E7x0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721229804; x=1721834604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8FiZ3Q3HqoLocenTRjlmRJv2b/Y73q4whh/GunuTuQ=;
        b=l4LH6c62qXaRdq4S6yx0ZunKOB8NB8+1P6ocF8dkpm8j4tqLPKH4fwNhIIczWt9JdH
         q1D2Nlp+E42Oc5VfJJvB2mp7J7u5WYTBilpXu8X1txHYipsv/tZNYmhfLlPZvI3HcdFb
         Kd0v/JR6T1UEP9OUZTKxU73XczsMiOwf0KhbGnSvqv74lZu5VA751sX/H0Gkix8Ylu84
         EhPCh9ihj1ZvXm3RXIlvrIE2cgUhUdWYfXHF0jSQRFWsG8NvrqqeWjkyf5jiwJLbIz1M
         cCb1Ch+RB5Xa06r4lFLDpsVGCvvt2O6cAnDzYa9iZD061hEQjFmNI/eCIbOnuCoPq7ue
         BA1A==
X-Forwarded-Encrypted: i=1; AJvYcCXSJ42cJbNYArgag743tOFUQz0wyc10WigDA+HByOWHUzRtmf+7RoUlA9nmImGbSksEBJhd1c2zIkDbuG/KQuNg2KKRFzassynkFvt4
X-Gm-Message-State: AOJu0Yxy+z1cRcvA/sesxKmlRiiFDlJZ7Wp8hUYoFt+I+2eElyS4+1OQ
	wnAA/ER4LNPBbh4HZ7FmYDPFjH0RVNICj88KXHIYOkLmugDPBWq94aOU4RqqC98=
X-Google-Smtp-Source: AGHT+IFlciore1y+UQYW9Y0jJvuXHRLOrrsV/Ezh+JQR+RR7GejszYwFg+tRXO6qV2PyKO3GaAOQcA==
X-Received: by 2002:a2e:a552:0:b0:2ee:e196:1486 with SMTP id 38308e7fff4ca-2eefd139261mr10209451fa.4.1721229803749;
        Wed, 17 Jul 2024 08:23:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf539sm12004669f8f.47.2024.07.17.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:23:23 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:23:21 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Huan Yang <link@vivo.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH 1/2] dma-buf: heaps: DMA_HEAP_IOCTL_ALLOC_READ_FILE
 framework
Message-ID: <Zpfh6VoBWwjteRUR@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Huan Yang <link@vivo.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240711074221.459589-1-link@vivo.com>
 <20240711074221.459589-2-link@vivo.com>
 <5ccbe705-883c-4651-9e66-6b452c414c74@amd.com>
 <ZpTnzkdolpEwFbtu@phenom.ffwll.local>
 <99364176-a7f0-4a17-8889-75ff92d5694e@amd.com>
 <06713006-c5ce-4773-a1b3-ca3bea56ee45@vivo.com>
 <ZpY-CfcDdEhzWpxN@phenom.ffwll.local>
 <d3ad46ea-df7f-4402-b48a-349e957f198b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3ad46ea-df7f-4402-b48a-349e957f198b@amd.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Tue, Jul 16, 2024 at 02:07:20PM +0200, Christian König wrote:
> Am 16.07.24 um 11:31 schrieb Daniel Vetter:
> > On Tue, Jul 16, 2024 at 10:48:40AM +0800, Huan Yang wrote:
> > > I just research the udmabuf, Please correct me if I'm wrong.
> > > 
> > > 在 2024/7/15 20:32, Christian König 写道:
> > > > Am 15.07.24 um 11:11 schrieb Daniel Vetter:
> > > > > On Thu, Jul 11, 2024 at 11:00:02AM +0200, Christian König wrote:
> > > > > > Am 11.07.24 um 09:42 schrieb Huan Yang:
> > > > > > > Some user may need load file into dma-buf, current
> > > > > > > way is:
> > > > > > >      1. allocate a dma-buf, get dma-buf fd
> > > > > > >      2. mmap dma-buf fd into vaddr
> > > > > > >      3. read(file_fd, vaddr, fsz)
> > > > > > > This is too heavy if fsz reached to GB.
> > > > > > You need to describe a bit more why that is to heavy. I can only
> > > > > > assume you
> > > > > > need to save memory bandwidth and avoid the extra copy with the CPU.
> > > > > > 
> > > > > > > This patch implement a feature called DMA_HEAP_IOCTL_ALLOC_READ_FILE.
> > > > > > > User need to offer a file_fd which you want to load into
> > > > > > > dma-buf, then,
> > > > > > > it promise if you got a dma-buf fd, it will contains the file content.
> > > > > > Interesting idea, that has at least more potential than trying
> > > > > > to enable
> > > > > > direct I/O on mmap()ed DMA-bufs.
> > > > > > 
> > > > > > The approach with the new IOCTL might not work because it is a very
> > > > > > specialized use case.
> > > > > > 
> > > > > > But IIRC there was a copy_file_range callback in the file_operations
> > > > > > structure you could use for that. I'm just not sure when and how
> > > > > > that's used
> > > > > > with the copy_file_range() system call.
> > > > > I'm not sure any of those help, because internally they're all still
> > > > > based
> > > > > on struct page (or maybe in the future on folios). And that's the thing
> > > > > dma-buf can't give you, at least without peaking behind the curtain.
> > > > > 
> > > > > I think an entirely different option would be malloc+udmabuf. That
> > > > > essentially handles the impendence-mismatch between direct I/O and
> > > > > dma-buf
> > > > > on the dma-buf side. The downside is that it'll make the permanently
> > > > > pinned memory accounting and tracking issues even more apparent, but I
> > > > > guess eventually we do need to sort that one out.
> > > > Oh, very good idea!
> > > > Just one minor correction: it's not malloc+udmabuf, but rather
> > > > create_memfd()+udmabuf.
> > Hm right, it's create_memfd() + mmap(memfd) + udmabuf
> > 
> > > > And you need to complete your direct I/O before creating the udmabuf
> > > > since that reference will prevent direct I/O from working.
> > > udmabuf will pin all pages, so, if returned fd, can't trigger direct I/O
> > > (same as dmabuf). So, must complete read before pin it.
> > Why does pinning prevent direct I/O? I haven't tested, but I'd expect the
> > rdma folks would be really annoyed if that's the case ...
> 
> Pinning (or rather taking another page reference) prevents writes from using
> direct I/O because writes try to find all references and make them read only
> so that nobody modifies the content while the write is done.

Where do you see that happen? That's counter to my understading of what
pin_user_page() does, which is what direct I/O uses ...

> As far as I know the same approach is used for NUMA migration and replacing
> small pages with big ones in THP. But for the read case here it should still
> work.

Yeah elevated refcount breaks migration, but that's entirely different
from the direct I/O use-case. Count me somewhat confused.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

