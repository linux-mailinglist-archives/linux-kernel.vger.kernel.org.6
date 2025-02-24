Return-Path: <linux-kernel+bounces-528600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32423A4198E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0804E188DDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E24324BBF5;
	Mon, 24 Feb 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bvmrm/Rd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCF24BC0E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740390660; cv=none; b=Zh6mYR90mjx1B7Pvmlg5+lakow5Jo0zaBU2nQ7BiNJvZSx4bEahldsfSu72AfUiW/oIW3pM27pJDvZ/YNiKwmJ621/Fb1pRgoce6Ra+p+WKAGchN+0HtyGDBEOvs3DXjXj46Cg9cpIr5GjCwy5F/LNKuwUeMgOxH7pisVAO/TII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740390660; c=relaxed/simple;
	bh=kOip+9a74eUiw2GtE1DNpepkjAxlDJiUPnd1Z/7h674=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFf6udepBSp3RbxGnFjIVg6WphlNZ+GIEf09lp8HGDExbmtDV29kVrDtmdOu9hJ1kz3JjfSxiHs2SIeIHEfTq9Fn1eGdYUuOQsDi2cSVsfe+hVPOa5au+nBTlfd6xoYCdxu8EjKVkdOYJmB8HYE5NKuNE8P5ffrINQ4g+wp7xdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bvmrm/Rd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740390657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZqHm/9cDgAOWUdU6io4A3jzHsAy/X8He33+MZcDyN8=;
	b=Bvmrm/RddWlRMxk3VLkLva7ZTAJleHuuY5DrxOh5uD9b6H84VSFo/VfK392xlsYj20RQEx
	EBHhQp8kyaZw+PDnOJZt938BRqBwkxIjn1K44BnbGYxTDSIkxzcUFSkUUlyKsJf1DycqXM
	mS0poRQK52/b5hx1Wo0BTx4axrTQ6BY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-q7SpfhcvM1q7BpypVumEWQ-1; Mon, 24 Feb 2025 04:50:53 -0500
X-MC-Unique: q7SpfhcvM1q7BpypVumEWQ-1
X-Mimecast-MFC-AGG-ID: q7SpfhcvM1q7BpypVumEWQ_1740390653
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f42f21f54so1587096f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740390652; x=1740995452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZqHm/9cDgAOWUdU6io4A3jzHsAy/X8He33+MZcDyN8=;
        b=nbvYjh1ekQyaUlIihpZiHx/rk+Du8/LfjtSpH18CdcyIhJGHlvxt0cY/cCCvkRqlQC
         PSzfSQmrMSCu2JF7rjJi607yv7PJdkncISlIT5/szReltZBqg1+gV19BwJOKB4LhlhTr
         pso6nhfc0XQpCr2S9XFZu84eOCuNM5U/zJeuOfAwcDSc9O50qyyP0Xi9Gnl6Le4OMa3C
         +mm+1mxe4l0AfxgV1ME4Yw5ljMRtgoHk+KRaQb1aXU27DN1tUFdpYVz8GnmTGjrZytgY
         iKHs9PDg3PD1r2BEVDMAQnHl+idukDHUwPLhmqZSgvtCINatnCk/s/Zq/P4DnhoJM3Qh
         1siQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGWAkfCGW9Km/5q/ZH6t9jlhGZ333dNHM6O2sjckneIBZwx2A7UwC4koOTaCdSUvAacrJN6ylfGy4pzx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaCtvcFwXwTNT+cFJ0wGUftn1B5EVZNw4q9D8XoJ/xbc5JmB6
	nmCPKzEezcLhb00WZhuarH+skazqpOHcEQkVKUIhsTOavTqSp89fbaBt4xeYFoLD5DP3FU20WB4
	xWDNCYXD10JcPtKpJOBM4l2N2+huFBBik5GcoaQ44Ba1Mxrqit0Y5oGjH7g9qOw==
X-Gm-Gg: ASbGncvFaXO8dYZIbSlyFBdwjJvzWD7oiGDrbR3w7RADODakNnIQ/QPyBvUv8BKzYJS
	UKmmRE2VZBfY9p1KlWb1GCdHgySQjmzHKiJaaY6lx8i76hap8VvMvmhQkOunf3qq/pzk1hLSyna
	CaIOlmu0/K5ll7xPQ+CZYPe8OMI6ZN1LDXkBJ8Q+SDgGLUN/3wMITxjJBVenEom6bg3YEdbrSiA
	MaFMkDBIoHcLg8VzZcR4clW5OUBKWDTKqbp1CKjbNjztWLMEImC5PC2VhYg6myaB+QaYpWTxLM8
	vTStnyzG4W6bdRmB9k8AtCWvRMqY7k8VzJC0FIzmRe+2
X-Received: by 2002:a05:6000:1842:b0:38d:c2d7:b5a1 with SMTP id ffacd0b85a97d-38f7078b9f2mr10169992f8f.19.1740390652602;
        Mon, 24 Feb 2025 01:50:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAwza1hcgdxrJ8BwraVFQwVo7B5sCH/ekjF9MElryXwIHjucBtqc/nrNIBAZsErtsZwpeQ/w==
X-Received: by 2002:a05:6000:1842:b0:38d:c2d7:b5a1 with SMTP id ffacd0b85a97d-38f7078b9f2mr10169974f8f.19.1740390652290;
        Mon, 24 Feb 2025 01:50:52 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d8859sm99806715e9.16.2025.02.24.01.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 01:50:51 -0800 (PST)
Date: Mon, 24 Feb 2025 10:50:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux warns `sched: DL replenish lagged too much`
Message-ID: <Z7xA-ZRw6J-68M35@jlelli-thinkpadt14gen4.remote.csb>
References: <6ebe1130-0143-4388-9d69-ead0bf1fddf9@molgen.mpg.de>
 <Z7cvifR-y0CWK1e6@jlelli-thinkpadt14gen4.remote.csb>
 <47903c9d-3949-43b3-8f27-d59db20acb1e@molgen.mpg.de>
 <51e0d018-f4c5-4a2d-93bd-265b4c13415f@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51e0d018-f4c5-4a2d-93bd-265b4c13415f@molgen.mpg.de>

On 21/02/25 23:13, Paul Menzel wrote:
> Dear Juri,
> 
> Am 20.02.25 um 21:18 schrieb Paul Menzel:

...

> I was able to reproduce this today. The same behavior after resuming from
> ACPI S3.
> 
>     Feb 21 17:20:19 abreu gnome-shell[1775]:
> meta_wayland_buffer_process_damage: assertion 'buffer->resource' failed
>     Feb 21 17:20:19 abreu gnome-shell[1775]:
> (../src/wayland/meta-wayland-buffer.c:709):meta_wayland_buffer_inc_use_count:
> runtime check failed: (buffer->resource)
>     Feb 21 17:20:21 abreu rtkit-daemon[1017]: Supervising 7 threads of 5
> processes of 1 users.
>     Feb 21 17:20:21 abreu rtkit-daemon[1017]: Supervising 7 threads of 5
> processes of 1 users.
>     Feb 21 17:20:59 abreu kernel: sched: DL replenish lagged too much
>     Feb 21 17:21:01 abreu systemd[1588]: Started
> app-gnome-ptyxis-26577.scope - Application launched by gsd-media-keys.
>     […]
>     Feb 21 17:23:43 abreu gnome-shell[1775]: libinput error: event11 -
> DLL075B:01 06CB:76AF Touchpad: client bug: event processing lagging behind
> by 31ms, your system is too slow
> 
> Move lags sometimes, and also switching GNOME virtual desktops, or just
> opening a new window takes several seconds.
> 
> Can I set an option so more stuff is logged, once the scheduler warning is
> logged?

Could you please first try to reproduce after having disabled the fair
deadline server with something like the following?

# for ((i=0; i<$(nproc); i++)); do echo 0 > /sys/kernel/debug/sched/fair_server/cpu$i/runtime; done


