Return-Path: <linux-kernel+bounces-190123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD368CF9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2896B2172E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A017BA7;
	Mon, 27 May 2024 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmARSZdH"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D5208D1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794146; cv=none; b=cq5L3Pq8iXf7jRYQwT1C58vaFUuqn5aHrtmYTiZWme0RJhj1/5XFn643/AlaZprp3rW8lNkQlaKrzCkn3QUmWHHCS6tQ1pQmUEQZRY7AOaKUMJp9gsY+jIBBOCfLphDM2S02lMqPTJjHlSSvfpv4k1gZ8aQhoUnBjgCqB7Mrrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794146; c=relaxed/simple;
	bh=mwe8kOgRaHJINAiRajKjPR7tR6S5Am3qELO6PW9hBaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdFWzgh4qf2f4kv/MuKo5X++aDBVpYqFfsSKyDKav6Pv83uwDXV/17in84SOKMN8OoMl87yDBQvdkjSawFsyC/i1Y7oFnxbQ2amWFA6L6tvwfnRgKpgaVrDL7ShT22c3YZ6f/DEXkoXzQvWEE3D8+EYzF+PIf1wGccu6ZLxB51I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PmARSZdH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57863a8f4b2so2399044a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 00:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716794144; x=1717398944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzFPdlZqVo5PKSyt9wOZE+bRSKE7VsgsZElEVWfoDy0=;
        b=PmARSZdHHlQMvECKV26e+UmYNHQONltn8Dkq5DVhpEYv53a8kDt20lVB0XyNJQN0T2
         cki62njd7gKPX8sEJ8h6cmTgQgNKU3GxOHf2Z11kRda6t1DV64ujDjgIVhKoAf2zziOW
         k57qYTEIeRlstInk6PzPP661e7/GTYhoLv4064rnZpJdr5BHz/ee27Xq2CXuRqGlGgcR
         6wZ33rSZn+YhYljSzcX/OUgRn2Cs9OM40MOVHMWOf10DMqLecmblB4if0jSqK7rpjecy
         c4sKP+1Qc4M7UZ4o5YKki2jw2rU+p6Feg7wtI+TlRLWuHikGxRU91Q+9oyzvfA2KnPws
         Zc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716794144; x=1717398944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzFPdlZqVo5PKSyt9wOZE+bRSKE7VsgsZElEVWfoDy0=;
        b=ijABBvaUHyS5s4Vd+bR5jYiEubqU4uNxrhDa49/hs7/Osbc9A3xKLDS8m6Xm6X0wG0
         VIUrTAbw+9bLSys3afu02dUBuHVy20IGR7ymcjne4DPp+//nqceXgYkQPVx2wz02DMwj
         UXNf2HOUXXixvR5RExmSQ3lcIPWRjxndzHA04oA9OIk6TnGViNdX5Dfrn+RSSLvohYwD
         VW9Ci392nUr5oLJhkNhMGH+V9x3hO/xTGSJ5zQ59TBBsA96UbC3xKuSebfZD68aEH6Xs
         TaN3fiC5RstaADx/ucuvieOa4jKZicr25DQ6zitrJaxHqcJQ0rs8CUF08AhlfsiUH+R+
         v7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWu/DL7uRqYwD4oQRS7J3fQkKXNL1k6dx/Y2yEQneg8h1Fp2ecKsI5VgUJ1KRW4sZpvfY3Vjr2ZcrZl/1GnSHU5btPSTpbIqzhT/glj
X-Gm-Message-State: AOJu0Yxro68T6T/vyxhn6nq0XYvFVKOyUZ1V4I8yzPdfJYjkTZ3QaPVC
	SqiJCrJ2HbpiDt6a9HMWmnuYLGLyGPOf3B/f+X6Wax7KD+kmDyP6DIHUKqNXk72zaR2ZH7nL97S
	0
X-Google-Smtp-Source: AGHT+IGwZC7pS7Leyu+wJb6TKMTnokaMP1y0HwF8cJ3djE8qqANhHC/c/DSGNi9ozYoKaXx0eDOQBA==
X-Received: by 2002:a50:d6d9:0:b0:578:e1f5:47e1 with SMTP id 4fb4d7f45d1cf-578e1f54b50mr3546015a12.34.1716794143546;
        Mon, 27 May 2024 00:15:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c73c771esm2141548a12.65.2024.05.27.00.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:15:43 -0700 (PDT)
Date: Mon, 27 May 2024 10:15:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com
Subject: Re: [PATCH] staging: rtl8712: remove unnecessary alignment of
 pxmitpriv->pxmitbuf
Message-ID: <839d7d29-84ee-4da3-8024-67b79d581780@moroto.mountain>
References: <20240525073229.4144612-1-namcao@linutronix.de>
 <92412c38-8fb0-4a81-9205-7735ae21459c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92412c38-8fb0-4a81-9205-7735ae21459c@moroto.mountain>

On Mon, May 27, 2024 at 10:06:22AM +0300, Dan Carpenter wrote:
> On Sat, May 25, 2024 at 09:32:29AM +0200, Nam Cao wrote:
> > This driver wants pxmitpriv->pxmitbuf to be 4-byte aligned. This is ensured
> > by allocating 4 more bytes than required with kmalloc(), then do the
> > p = p + 4 - (p & 3) trick to make sure the pointer is 4-byte aligned.
> > 
> > This is unnecessary. Pointers from kmalloc() are already at least
> > 8-byte-aligned.
> > 
> > Remove this alignment trick to simplify the code, and also to stop wasting
> > 4 extra bytes of dynamic memory allocator.
> > 
> > This also gets rid of a (false) warning from kmemleak. This 4-byte-aligned
> > buffer is used to store pointers from kmalloc(). For 64-bit platforms,
> > pointer size is 8 bytes and kmemleak only scans for pointers in 8-byte
> > blocks, thus it misses the pointers stored in this 4-byte-aligned buffer
> > and thinks that these pointers have been leaked. This is just a false
> > warning, not a real problem. But still, it would be nice to get rid of
> > these warnings.
> 
> Are you sure it's a false positive?  I've always wondered what happens
> when you do:
> 
> 	p = kmalloc();
> 	kfree((char *)p + 4);

Ah, never mind, it actually frees p.

It took me a while to figure out that it's actually pointers stored in
the buffer which are reported as leaks and not the buffer itself.  This
was explained quite well in the commit message but I just misunderstood.

regards,
dan carpenter


