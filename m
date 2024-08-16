Return-Path: <linux-kernel+bounces-289396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E09545CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A1528356F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACA1494D9;
	Fri, 16 Aug 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQrKBENF"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71A145B37
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800476; cv=none; b=JIB9FCLjUlVHyAL8sFTMgGcZF8VrMIg4aA5Iwjeb5OtJ73xX2aVDo19uHSE5K5QuTlHdbMuVNyFBOSSFcimjwGPnSD1uRP6l+4mhWfeWybmAjZAWf3Bn+A0L3AYiS+tCGcuaZprASe2jOmvN3wXfw2UMxfTdgqzTNtfQJdCxwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800476; c=relaxed/simple;
	bh=71Anzhd8qVhBEmGgR7riqlO8oM50F9GfELnryKuMfuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQIv/ZDQMjFBgcWET/IpDQ/ua4U3+WP0BWLYdX/MOWJ3o+Clw3QJ2vc4D0sak8kOLy6N6mp7q4p1nswxtdXJDQSxU8b2b7PY8dJ1cjjp5DxVlGLGyPXR9an2wTX/Q4FEg8FPJDxcTRAxGMN7MlHBRJKD93IaD1hmQGKPXuFH0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQrKBENF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53212e0aa92so1971659e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723800473; x=1724405273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ezHfPbQtKZ/Nw2mLq7nbBPF6a7L0xlFdhWHwqipVgg=;
        b=RQrKBENFIkvSmtohlQVC/6OrO1/2aCDIA0Hq9J8OxJN1a1fyFSFtnqhwUw21yS+SUA
         NqrCQH8YsLqq10siuh/sYZX2xYWV3dTmpt6UpFYGBWLV6+Xty7g8Ik8NA7OHJOl/d3mO
         5S7hy1O4MHf9hMEym54xv06w9To3hvVNRHpgVq2YZOIFwY+3yWWgG+hXimXARIyKMt80
         y75oKxOWrbGZuOxGqt4bcdqGFji43nQ/FhRHK6XHDRP2QOf4Dzy9fLSwk1DdeuYkCXP7
         dEZ95Oh/l2kliTacMTMaZn/5l5EbOImHyK8jhcXM40Yt1RbTZM5TqZvceCRTlvHC0Pfy
         9Z7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800473; x=1724405273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ezHfPbQtKZ/Nw2mLq7nbBPF6a7L0xlFdhWHwqipVgg=;
        b=ahILgAOHS5S3HP974+o2tlSToJp/eNmOzKs1C6CkinbTjwKByxT9u51uxMkQvX2rh8
         WAwJ3ymaK73UtIlswhgNj1mCevxsbG6mD3bdv0jJ857ll2oN4jK7JjZdfm7BuYhLUjz0
         NpBF3cp8NTS/ZXeOgtp+y4Cyh5DEE0l6dmBnZugr9Jo31Whn72EiN1oyXMH4QyaDMEPZ
         ACZfOrZQ0ckCGqvytyxxcIAG4MlLeSOBjSnBVTw7iFB1CAr2SXDts3smA/EYmrzF2vS0
         F8veYP9WT+X52VwIkOJPJXiEaKwYHZEZybSiZ757yyNHr3B7hccD88ofIQeVv/9LUUh9
         D+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJJAYABn2QMAFSM5r6z5NPmMn9RicGMrO1K5dnRvKqHfm3+Bg5Tzv5zEo44kcBap5iJwNyKJTZZ7tTF3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTN9mUOHNIN9bSaN67Bwm221ZHqtjMgsoKQSEZ1QnnNeKuc8z6
	XD2uPvzsd7NabB6jxwq/PVTdYI9650Peeoua1G2fSMw5DZOSSi09
X-Google-Smtp-Source: AGHT+IHtIobWpDyR/wNfIlTck6cEiVCePFpUoJf2/QSPMUvcyXdOt66tyYIYXM5IChI9qAvRRZJ/sw==
X-Received: by 2002:a05:6512:158b:b0:530:9d86:6322 with SMTP id 2adb3069b0e04-5331c6d9db4mr1616048e87.41.1723800472213;
        Fri, 16 Aug 2024 02:27:52 -0700 (PDT)
Received: from andrea ([151.76.20.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7dae0sm71435195e9.44.2024.08.16.02.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 02:27:51 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:27:47 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: Eagerly flush in flush_icache_deferred()
Message-ID: <Zr8bk4WR24XHt5jp@andrea>
References: <20240813-fix_fencei_optimization-v1-0-2aadc2cdde95@rivosinc.com>
 <20240813-fix_fencei_optimization-v1-2-2aadc2cdde95@rivosinc.com>
 <Zr1NC7GBQHfqqplf@andrea>
 <Zr6MjWLD5VQAQHAV@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr6MjWLD5VQAQHAV@ghost>

> I should have added some memory barriers. I want to have the stores to
> task->mm->context.force_icache_flush and
> task->mm->context.icache_stale_mask in riscv_set_icache_flush_ctx() from
> one hart to be visible by another hart that is observing the values in
> flush_icache_deferred() and switch_to_should_flush_icache(). Then also
> for the changes to those variables in flush_icache_deferred() and
> switch_to_should_flush_icache() to be visible in future invocations of
> those functions.

[...]


> Oh okay so we will need to do a memory barrier before the fence.i in the
> userspace program. I don't believe a memory barrier will be necessary in
> the kernel though while this prctl is active, will the kernel ensure
> memory coherence upon migration?

Yes, the kernel enforces coherence upon migration:(*) in the example
at stake, this means that T1 will have a coherent view of memory when
migrating from CPU1 to CPU3.

To leverage this property, we (or the user application) would need to
provide some synchronization between T2 (that modifies the code) and
T1.  This typically involves some form of barrier pairing.

Feel free to reach out, here on the list or in private chats, for any
related memory-barrier doubts I might be able to clarify.

  Andrea

(*) A malicious/buggy hypervisor could migrate (virtual)CPU X, and all
its threads, at any time and way allowed by Murphy's law.  :-) I take
it as that goes beyond the scope of this series...

