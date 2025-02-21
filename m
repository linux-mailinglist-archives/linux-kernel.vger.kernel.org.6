Return-Path: <linux-kernel+bounces-526741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB78A402A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D70189B3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916EE250BED;
	Fri, 21 Feb 2025 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bqRMps9A"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CC718DB0B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176989; cv=none; b=kFvGDWiQ+EFBzFkZ7IwjHok8QF+8/z2RV3N5x4K9NWqpbXxXvf+cwQNGh51FsY4VIFx12Kpt5s8O1907pI0in5X9jzyK/yJH7JtlaLrmC+fUY8ljrcVbgmhXJuqGR4/bIuAWHOoa6gUGWW04wJqS+DhWSwk8arLeBFheKdqBR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176989; c=relaxed/simple;
	bh=fOS+8reKv8WI1mXYZ2A4zSfYLJvIxt5DoTE4HMxL7eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP5PJPMOo7Dz/+vh+3/iob/Z3Z/CatadvfINpzDD21RbbGERu2mKNPAlKt9dPgR46/YjCrReoFnIyp1LHFKNIbXTEGYMLgQ5dvufo21LXAOVsKpATwQMi2DyaZ250eHP9lsiFBgiAS5G5SkNIBuAyZgvDxaXIkZb7vhYedTRFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bqRMps9A; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-221206dbd7eso55717565ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740176983; x=1740781783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGBXu4U29a6azAmCs2zO/ixtci51PmTK7x8U4xsF3D4=;
        b=bqRMps9AGl2k2/1YkyhWeM4TDYzKmSun6rD/BH483vPb1+qXYHwYjnFg7W8Yk6YYlr
         nb9PL38KvRxIjyEveuko1NkRB3YgPuMsysC/4vp4R7oto+Qrr+rQciZRsoGlLEMvl53H
         DRdkYop7a2rno1vT8WKmF3kaqNTYn1g4EWJnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740176983; x=1740781783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGBXu4U29a6azAmCs2zO/ixtci51PmTK7x8U4xsF3D4=;
        b=MaHXOMtFQHFhCObaOyoR0jJHvnjI9FaLhH+IQdBRZiagaXPIvMNq5+Jgdvp01Wblk2
         Kvbrb7j9uoF8Q71eoMFM5Kx8aFLTjPtGmMq6eGSmF+1DkR0jIz3HjWaqiygQzmN1al/R
         24V2t7Hru/eT5ATiv1oEqqEscZkPgeaOoF7dXyqtyYCcoTPjE2g+HpHF8uq2fZ6p6Crs
         qRd0He6DXSlAI2aZJNo1Kf+WY64B1a2nf41VOrX7sQadqxnLa45kVOJPD3wq4aqZT0UO
         DW0XK2VdG3pn2W9XJTkVh4q4Nv2F0pEvHXDWnU3ssqp4IkU0+7C12TZ+zmjnm0UX2THd
         rI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVV/vEDo8SndIIrQH8zfdYDPi/6yenh8tKk1RyZ6ICn7ZY15PKT4aTxZKCBUM2r/47B8HzpNgWACkDWyqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEsbFB3oHP3WlsGz/LG2azFto3wY13UrjpvUq1MXAtADk8mXpK
	2Esb/vBYUm9coHttQeR3Xe7ICsfNpB3DHatOLAcL7FMUI3rtrDBIrXtcytX2zw==
X-Gm-Gg: ASbGncuy98yV/QY+znoWHOX8TwqE0PCh93BUyoMhpOZOf2z5e4Te5pdbGikJoo7v+gv
	HuC7KA0vlw7QyLPNHl1hPWiCPoNUSPfoNur2bu3oKeKaTcAckjz5xOPSJRiYCRnQL2jeDJqMWgo
	85ePbXGRQHvZKbzOOMjFd3SdI4RErQVc+PxgDFZNOXKKyHN2YOskGAsjDsSF4zgpdosvzqvvqmG
	RZTxq9uyxdPNreTnouWqjhMCZZDWQ5sclSryLbX9IpmMqLbsGDeea1rHVn/dRUP1v0ZhsbC6PGB
	P0bdFC9Uf5bwaeEe6lME9eDMiMY/
X-Google-Smtp-Source: AGHT+IGPiSSVKKMNHdWyLRDcbbVFWNsxuM2v+W0QIy4BnVbABFMPbCzp35uRYILItDPjFLUndT/VUA==
X-Received: by 2002:a17:902:d54d:b0:220:fb23:48e0 with SMTP id d9443c01a7336-2219ffa7caamr91236545ad.38.1740176983573;
        Fri, 21 Feb 2025 14:29:43 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348e68sm142410025ad.28.2025.02.21.14.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 14:29:42 -0800 (PST)
Date: Sat, 22 Feb 2025 07:29:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <vtb3tv7bgliyvhu4waovse774gtjm7iw47bjnmz7elxd3hpi5s@zdosair757qz>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
 <20250221093832.1949691-12-senozhatsky@chromium.org>
 <Z7jZfIaqMRTLYp23@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7jZfIaqMRTLYp23@google.com>

On (25/02/21 19:52), Yosry Ahmed wrote:
> On Fri, Feb 21, 2025 at 06:38:04PM +0900, Sergey Senozhatsky wrote:
> > In order to implement preemptible object mapping we need a zspage lock
> > that satisfies several preconditions:
> > - it should be reader-write type of a lock
> > - it should be possible to hold it from any context, but also being
> >   preemptible if the context allows it
> > - we never sleep while acquiring but can sleep while holding in read
> >   mode
> > 
> > An rwsemaphore doesn't suffice, due to atomicity requirements, rwlock
> > doesn't satisfy due to reader-preemptability requirement.  It's also
> > worth to mention, that per-zspage rwsem is a little too memory heavy
> > (we can easily have double digits megabytes used only on rwsemaphores).
> > 
> > Switch over from rwlock_t to a atomic_t-based implementation of a
> > reader-writer semaphore that satisfies all of the preconditions.
> > 
> > The spin-lock based zspage_lock is suggested by Hillf Danton.
> > 
> > Suggested-by: Hillf Danton <hdanton@sina.com>
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> FWIW the code looks correct to me, but I don't trust my locking
> knowledge enough to give a Reviewed-by :)

YOLO-by: :)


Thanks for all your help!

