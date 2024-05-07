Return-Path: <linux-kernel+bounces-171923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0048BEAAB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1226F2843C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D473D16C85D;
	Tue,  7 May 2024 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aJD7SYZD"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEC9476
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103425; cv=none; b=dgvwHt2SpujOaydSVGvOyP3FDkP5FjopYu98y9Ifyu4mFLYJr/BNk4g1GPB1APFBITDbLzB+imM0UcGjnnPXbdrcb/Gw1tI7svNH7qdHEUxyI8ecpFNWM81yKFX14a5xo19RsX/GoCc5ziHagE24kvDUdRVZEOI1SyeDAOD6ZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103425; c=relaxed/simple;
	bh=uVDKdBV7CMD/DwoL6q95kSDJhAu9461183gRjZ1cxoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xztj/bMXgwkX5Oi5ub2qBaB2rhKIDVB7wDb8c6MFpJmbL0yAn+Dcmge2NihTyZfJhwkT9nRqu+M71rbBIgodyuANVLh1Kgwf9PqQTPr/eqY1r+60/ogDfuaB5vaQcPqK74jLa5hxC9aQjqsUqJ8EYge9uhMtUJVlqR/9fyIZ6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=aJD7SYZD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1006661f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715103422; x=1715708222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTbXjnapj66x1QFUTkR6VfpWY54bOGDZ0bq0kLD6kt4=;
        b=aJD7SYZDKSGX0j1Sm4ELR9n5V0K9/EqXDE4MP6hBqVroBaAHfRNYdHzHpwaGeRjycw
         QZio6tqGlDtOfVEwEyBgVTn2caVywd1J/Z23nEMbuz7aga0Q3gzpr8PtzcBjHSo17MXg
         sz/kW+bdfAPR3xyVRWNag6cfkjjCwnyaviT6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715103422; x=1715708222;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTbXjnapj66x1QFUTkR6VfpWY54bOGDZ0bq0kLD6kt4=;
        b=OsKdJndxbeX3sD4fEihQ0oy0SzFihE+3MdMt/ELrVXN/pHA7R3lnq9IDv9FOvseG2t
         +2jbWDHG/oaGb2gI5chlt32P1fL/kchoxmPf9Eb7VSUZUIXQ8UYHTJLoaCtTNlTtfwG/
         fCsJHbqdjxzkm7Zdz6+yEve04tiohJPDLOJTncVUpKXNaz7G/h2jNY3nF7NwHX9/KPOZ
         DIrJE80rWPPmOkNgFN8EjtMTtE03/z0/t61lRHBJenFVT0xW11JPGYDhASxU88Dj7lht
         GESEU+spOPAkyYTk+eenUBqotLWUWlhmhASTYeNT2ZwZHTROq36F4BR9tIJ9s/rAl/jx
         dHvw==
X-Forwarded-Encrypted: i=1; AJvYcCVX0hsQJnL/9j2Bk582xnfEvApl2SkpDF1wjuh5k9cCwzjKoP+U0bVfn5/yHUOfQML5OTJ3xNLUkqiAi1LRk1YMWzKgC7koA8mqIHgC
X-Gm-Message-State: AOJu0YyEOYjeFygIHPzsiGTExXagD+dbtxYLGmZ8KiuNug7pMjk2v7ip
	CelDvxxSuR0ZDGhGzSgaLIvyt5hNfaIJnKmF3tZ7z/SHrrw8C6BcCItHhYN+Qq0=
X-Google-Smtp-Source: AGHT+IGDlaVKfJNlzeSLiq8Rc1yJgYXIv7DO05/xB2F2BNXuulKK2r3ec8s1fdMs15n2a3dYFj8NMg==
X-Received: by 2002:a05:600c:3c89:b0:419:f241:6336 with SMTP id 5b1f17b1804b1-41f71302f62mr3477335e9.1.1715103422111;
        Tue, 07 May 2024 10:37:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c1c0d00b0041be58cdf83sm20294246wms.4.2024.05.07.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:37:01 -0700 (PDT)
Date: Tue, 7 May 2024 19:36:59 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Robert Mader <robert.mader@collabora.com>,
	Sebastien Bacher <sebastien.bacher@canonical.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linaro-mm-sig@lists.linaro.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Milan Zamazal <mzamazal@redhat.com>,
	Maxime Ripard <mripard@redhat.com>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
Message-ID: <Zjpmu_Xj6BPdkDPa@phenom.ffwll.local>
Mail-Followup-To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Robert Mader <robert.mader@collabora.com>,
	Sebastien Bacher <sebastien.bacher@canonical.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linaro-mm-sig@lists.linaro.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Milan Zamazal <mzamazal@redhat.com>,
	Maxime Ripard <mripard@redhat.com>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
 <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>
 <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
 <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, May 07, 2024 at 04:15:05PM +0100, Bryan O'Donoghue wrote:
> On 07/05/2024 16:09, Dmitry Baryshkov wrote:
> > Ah, I see. Then why do you require the DMA-ble buffer at all? If you are
> > providing data to VPU or DRM, then you should be able to get the buffer
> > from the data-consuming device.
> 
> Because we don't necessarily know what the consuming device is, if any.

Well ... that's an entirely different issue. And it's unsolved.

Currently the approach is to allocate where the constraints are usually
most severe (like display, if you need that, or the camera module for
input) and then just pray the stack works out without too much copying.
All userspace (whether the generic glue or the userspace driver depends a
bit upon the exact api) does need to have a copy fallback for these
sharing cases, ideally with the copying accelerated by hw.

If you try to solve this by just preemptive allocating everything as cma
buffers, then you'll make the situation substantially worse (because now
you're wasting tons of cma memory where you might not even need it).
And without really solving the problem, since for some gpus that memory
might be unusable (because you cannot scan that out on any discrete gpu,
and sometimes not even on an integrated one).
-Sima

> Could be VPU, could be Zoom/Hangouts via pipewire, could for argument sake
> be GPU or DSP.
> 
> Also if we introduce a dependency on another device to allocate the output
> buffers - say always taking the output buffer from the GPU, then we've added
> another dependency which is more difficult to guarantee across different
> arches.
> 
> ---
> bod

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

