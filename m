Return-Path: <linux-kernel+bounces-549250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13846A54FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8880616C64B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9581624C8;
	Thu,  6 Mar 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DSb2ehzX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71D20F062
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276335; cv=none; b=BoUsg2Xcmago0vIIpe9Yr0lWEh90PjZJaJJiEE7snEnjCo/YtJ6saq87qRsO5pILmi62WP5z7KBdBFmjizyEI4NvKiaGyKNE71uPKvMY+B1ndQtW+ZR0eQhaeqqKO+l9SSQahamI9hubm8+TsKBQd6Bc+M+0jlMbL731XXeSksI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276335; c=relaxed/simple;
	bh=1mrQA3uTO5h6ZiINd3iS+tcdz2BagICZLJWut1QbQmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIGg9ibAInMNitcyd2c5ZcveOIDqz/qD91ke7WTK8r+mfwid4yRCG2Qrqu7vDca29w7NSDiA11/HQWq7su2ShuoHsI+ADjfBpTrYBIkk8YC2bGS20lMWPyGwHrETDYpNzwyibLT42knTW3Llr+BdvUsxdlcDACMLf9/6aMBZDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=DSb2ehzX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bc638686eso14003015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1741276332; x=1741881132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65Y7a4qK+Y/6ES6G6BlQKGj/GPIU9m2PJUgZAs9+KOM=;
        b=DSb2ehzXuBDZ/lrh9QR+MPuYF3Uz5TO4qHiJW6jD8ZcKjtuDXMXbyrQu5gFB4iWLzu
         ANjMy9CWC5UdNjTm0MpIH+gHZLanmjj630VBqwuDVotWLuftLEvpjiHjjpmQuX3KH0U1
         Qxt7YL1aYks+6Td+onIcZoxCDu7in9JGb9BfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276332; x=1741881132;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65Y7a4qK+Y/6ES6G6BlQKGj/GPIU9m2PJUgZAs9+KOM=;
        b=DXkuZpUYMz3VXTWcB0tQmujFoNP2bMrQRc9C/Q5k7svXSIFQ6qMLZFDpY3BQfswPoV
         dlcHbOjVfLSlusE93q+DG0lju3L813ErPWWv/vBXoa7qU9DzyRIAPfUPG/AGC1+8/zoB
         R7pl2mVsnLLWQD8CCDoB1DWOfokDn8roPrw02GUib99tC4Zd171c6q48YJz9vwPa53ZD
         5iLfwu/MPxRYCStC/LMc5ihqM3I8YbQJ2cZbrloVTetcEeYMn4QI5ipWOUPGQZsVG/X6
         n2pL6doRaGm/cIYa03NINIIBkGxy1v88UUIzP+Z7h4cccpLOM3c6ob1AKZ4arLcahjUB
         UHrw==
X-Forwarded-Encrypted: i=1; AJvYcCX7c1cBQF1hPUv2sCXeecSAJ14lIRA4kf4yzfsllJc++qiUGTlIlB3lQK5PrElDNqn9O92vOhPlDLadjOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFzcT7YNf+bogVcHDylcR3waN3rtCv9Bqgu+VibE0SFDFoc/3
	TsY4JJjm+lyzchAvM63VD4vJDTYm5q0NDnAdOCiFH2yuDssBpuRASGU+t3m7Mb8=
X-Gm-Gg: ASbGncv1SqmKTS2gFJYGDLXfuMx87Ef1VKYz/HTrgi073lqwXMpjwqJMtnWgMIVvKHk
	C7v+/7iHTZYsvz1V1rjVmgFHMdRiKRFf6KlbFvVdmKtAghbU0og6gUMmKf6lylH/Qu3aAnV7NdB
	I3dW+DOeIpZTYaikvUJOgJemf64gMz/cRdwT+qsUb9GekShyxBSrWdW/jjeh+dhSmwzfm16kKwi
	lHZe2SnwfcUuvjG2hc7XGzirPzImdHMB6hLmtnq08Gg47Pd23m+DDOddsYYXaER99WeZsOIegBI
	76RNnwYdLjH4bMaIYGXwcmkmvzqC6xxTUHI2G8FSpMcO2c6GyH6jhhSp
X-Google-Smtp-Source: AGHT+IHeuGIWVWKb5j99SUKnlkK36tGpar1+KKK0aAa1IuGT6GpOgqR53OExqVvUKbkpEbvf2dKyFQ==
X-Received: by 2002:a05:600c:3b17:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43c5a6014b5mr36395e9.5.1741276332172;
        Thu, 06 Mar 2025 07:52:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc135676sm65178565e9.1.2025.03.06.07.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:52:10 -0800 (PST)
Date: Thu, 6 Mar 2025 16:52:08 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH drm-next 1/2] vmalloc: Add atomic_vmap
Message-ID: <Z8nEqDQhjU-Ly8Js@phenom.ffwll.local>
Mail-Followup-To: Jocelyn Falempe <jfalempe@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-mm@kvack.org
References: <20250305152555.318159-1-ryasuoka@redhat.com>
 <20250305152555.318159-2-ryasuoka@redhat.com>
 <Z8kp9Z9VgTpQmV9d@casper.infradead.org>
 <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bfd4238-6954-41a3-a5a3-8515a3ac9dce@redhat.com>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Thu, Mar 06, 2025 at 02:24:51PM +0100, Jocelyn Falempe wrote:
> On 06/03/2025 05:52, Matthew Wilcox wrote:
> > On Thu, Mar 06, 2025 at 12:25:53AM +0900, Ryosuke Yasuoka wrote:
> > > Some drivers can use vmap in drm_panic, however, vmap is sleepable and
> > > takes locks. Since drm_panic will vmap in panic handler, atomic_vmap
> > > requests pages with GFP_ATOMIC and maps KVA without locks and sleep.
> > 
> > In addition to the implicit GFP_KERNEL allocations Vlad mentioned, how
> > is this supposed to work?
> > 
> > > +	vn = addr_to_node(va->va_start);
> > > +
> > > +	insert_vmap_area(va, &vn->busy.root, &vn->busy.head);
> > 
> > If someone else is holding the vn->busy.lock because they're modifying the
> > busy tree, you'll corrupt the tree.  You can't just say "I can't take a
> > lock here, so I won't bother".  You need to figure out how to do something
> > safe without taking the lock.  For example, you could preallocate the
> > page tables and reserve a vmap area when the driver loads that would
> > then be usable for the panic situation.  I don't know that we have APIs
> > to let you do that today, but it's something that could be added.
> > 
> Regarding the lock, it should be possible to use the trylock() variant, and
> fail if the lock is already taken. (In the panic handler, only 1 CPU remain
> active, so it's unlikely the lock would be released anyway).
> 
> If we need to pre-allocate the page table and reserve the vmap area, maybe
> it would be easier to just always vmap() the primary framebuffer, so it can
> be used in the panic handler?

Yeah I really don't like the idea of creating some really brittle one-off
core mm code just so we don't have to vmap a buffer unconditionally. I
think even better would be if drm_panic can cope with non-linear buffers,
it's entirely fine if the drawing function absolutely crawls and sets each
individual byte ...

The only thing you're allowed to do in panic is try_lock on a raw spinlock
(plus some really scare lockless tricks), imposing that on core mm sounds
like a non-starter to me.

Cheers, Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

