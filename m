Return-Path: <linux-kernel+bounces-171455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5714D8BE482
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53F41F294B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC17D15FA71;
	Tue,  7 May 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jdduwpQ+"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE115ECDB
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089174; cv=none; b=WFhS1GWQFL3sjKO4eC26M2i92sPP+/D5rjYeIkTYLRf4Kr+gD3d0Q2bVW+U1C5r0ndMOInIrS7GDM6RZP07GIMfbZyyRp+PNSZb2N+HVnF1UuYvP/+W4ZDgC6fy6Pd1Bh4lYFSIyX5jurgoT/2cfAe41sN4eGLEEMzR1O/ZL6Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089174; c=relaxed/simple;
	bh=wtfbGydj7hoFOdn1oKPiMmXA1U1DIaBi6ccHNQcK9Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuhWXh1XkIZKArFU39SMyLWpFFTtUyaqHhgxsNDnaUi+Bryr+ekEVAJkiYPcujgOgnb3r6WSzRz99Gwq8GPPG2cYoavApBAvbhz0pT0R65D9SqUjto/1bHVeW5Dl3iODHrUt1iNWd4MuDsRPYBjd3g4Z9ZVLHA+iRqokM7U7grc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=jdduwpQ+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-346407b8c9aso943354f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715089170; x=1715693970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/ueNO6VgphQOXA5uS4/0Wfhc/WsOURk1MmZZT9vU18=;
        b=jdduwpQ+GlEAIKH6qKFRFaWkStoC37BzPkJjkOo8yrOKJgBlw+/vmuS+llpPPI+r5K
         IWh/Bi0AZqGvXC2dGcxJqCdME1VG2ffqaDHrZmBj2uzx7eGQkQHImo+l4IaNsVx/O5q+
         3+uwuZFuJXVbJK7nmLl8CsaAQeT/SZ97VP5j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089170; x=1715693970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/ueNO6VgphQOXA5uS4/0Wfhc/WsOURk1MmZZT9vU18=;
        b=IpZsKpmcyNk+ONUT3R98AKVgimPp/cSz4pdN+M0dW5Kyh5ojxf8FdmAslyZdXk6/j2
         7fIPWuIzV/Ko1TZrSuQG9Caf0SNNx6M6FpAl0mLyFsN7jRKA0KZANvS5V2xjKxzex66W
         biUeCIuG4/l/rTwCu/pnHH6wiM9xElg1khs99tuxeOBxtEXeUvzqI2cKOSHkkZ/bQY7O
         yOOgu2ythVPfYZwGICYvHRecK56Acf9/C5puePZ7ZsA9el4FdZKcgbYFZb7zqje7YjHE
         PHVhXuUz826e8m/hwqIe7+kXYZ5Zv9POPSDV+zvxkWEhf3PPxPGRSobeZLGTmPADtgh7
         MlFw==
X-Forwarded-Encrypted: i=1; AJvYcCXeUa8dzaRscXJqMXwAB56NXCz7qUIXARDl7QBCkUYkcYBQzWVT1scThpzPPxayUX6W83bUemUBXhXsfejyXUkX2T356BnBM3cNRYrH
X-Gm-Message-State: AOJu0Ywo25rvCnumdjL44H22GzlOal9C/xIH7YL5AWLAvvI/URGqRKPO
	H45Zkez5Py8Zr9FYEn2csTVWvVmPQRiuOuAt62zgGPJBoZ90P3p0d6uuAMCWRO8=
X-Google-Smtp-Source: AGHT+IFFkAJxLxOoCG8nFFCsSuXqv/YiZ7tcMHz5O7ctQR4tHzkmXOo+SmkFGR5DkNaIUKepBhk//Q==
X-Received: by 2002:a05:600c:5118:b0:418:9941:ca28 with SMTP id o24-20020a05600c511800b004189941ca28mr9213068wms.2.1715089170283;
        Tue, 07 May 2024 06:39:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h18-20020a056000001200b0034c78001f6asm12974839wrx.109.2024.05.07.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:39:29 -0700 (PDT)
Date: Tue, 7 May 2024 15:39:27 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	zhiguojiang <justinjiang@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] dmabuf: fix dmabuf file poll uaf issue
Message-ID: <ZjovD5WaWjknd-qv@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	zhiguojiang <justinjiang@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <4fedd80c-d5b6-4478-bfd3-02d1ee1a26e5@vivo.com>
 <aab5ec51-fcff-44f2-a4f5-2979bd776a03@amd.com>
 <2ebca2fd-9465-4e64-b3cc-ffb88ef87800@vivo.com>
 <d4209754-5f26-422d-aca0-45cccbc44ad0@amd.com>
 <289b9ad6-58a3-aa39-48ae-a244fe108354@quicinc.com>
 <CABdmKX3Zu8LihAFjMuUHx4xzZoqgmY7OKdyVz-D26gM-LECn6A@mail.gmail.com>
 <8ca45837-cbed-28da-4a6f-0dcec8294f51@quicinc.com>
 <83605228-92ee-b666-d894-1c145af2e5ab@quicinc.com>
 <CABdmKX2MWU9-9YN46PXx-Jy-O9CHMv8hCkvArd7BbWUBs=GPnw@mail.gmail.com>
 <8915fcc1-d8f1-48c2-9e51-65159aaa5a3b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8915fcc1-d8f1-48c2-9e51-65159aaa5a3b@amd.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, May 07, 2024 at 12:10:07PM +0200, Christian König wrote:
> Am 06.05.24 um 21:04 schrieb T.J. Mercier:
> > On Mon, May 6, 2024 at 2:30 AM Charan Teja Kalla
> > <quic_charante@quicinc.com> wrote:
> > > Hi TJ,
> > > 
> > > Seems I have got answers from [1], where it is agreed upon epoll() is
> > > the source of issue.
> > > 
> > > Thanks a lot for the discussion.
> > > 
> > > [1] https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/
> > > 
> > > Thanks
> > > Charan
> > Oh man, quite a set of threads on this over the weekend. Thanks for the link.
> 
> Yeah and it also has some interesting side conclusion: We should probably
> tell people to stop using DMA-buf with epoll.
> 
> The background is that the mutex approach epoll uses to make files disappear
> from the interest list on close results in the fact that each file can only
> be part of a single epoll at a time.
> 
> Now since DMA-buf is build around the idea that we share the buffer
> representation as file between processes it means that only one process at a
> time can use epoll with each DMA-buf.
> 
> So for example if a window manager uses epoll everything is fine. If a
> client is using epoll everything is fine as well. But if *both* use epoll at
> the same time it won't work.
> 
> This can lead to rather funny and hard to debug combinations of failures and
> I think we need to document this limitation and explicitly point it out.

Ok, I tested this with a small C program, and you're mixing things up.
Here's what I got

- You cannot add a file twice to the same epoll file/fd. So that part is
  correct, and also my understanding from reading the kernel code.

- You can add the same file to two different epoll file instaces. Which
  means it's totally fine to use epoll on a dma_buf in different processes
  like both in the compositor and in clients.

- Substantially more entertaining, you can nest epoll instances, and e.g.
  add a 2nd epoll file as an event to the first one. That way you can add
  the same file to both epoll fds, and so end up with the same file
  essentially being added twice to the top-level epoll file. So even
  within one application there's no real issue when e.g. different
  userspace drivers all want to use epoll on the same fd, because you can
  just throw in another level of epoll and it's fine again and you won't
  get an EEXISTS on EPOLL_CTL_ADD.

  But I also don't think we have this issue right now anywhere, since it's
  kinda a general epoll issue that happens with any duplicated file.

So I don't think there's any reasons to recommend against using epoll on
dma-buf fd (or sync_file or drm_syncobj or any of the sharing primitives
we have really).

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

