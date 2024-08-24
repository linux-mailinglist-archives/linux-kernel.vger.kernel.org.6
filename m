Return-Path: <linux-kernel+bounces-300009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1DE95DD7E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A633C1F21F65
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744E15B0FE;
	Sat, 24 Aug 2024 11:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFIL/aJl"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F695154434
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498310; cv=none; b=MvoUS/Aqw6hfKWC2tLffq8UwbmPUVUVGwLmGEc7MZHDbTYYCbWijn0XG3tLfkxY1VOwa/iUmLGL/MUobFLSEFzETWI+MENK8GPPiS9UU5BWb19TF4gjyDnQJe64Cv9oqV7+vQczGRJMWxFoasaKmzfBQD4OUwAlgLCqO416PutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498310; c=relaxed/simple;
	bh=ArEqVk23aqUOcd1GpupV1li/luninoloc3UULGN4yrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0FoPQhEdasFCza/RD9E+YO017x66fVOPs/vzxlvJncy26Xx/i1+hrxz45V+tKcDISREkY1r2RN8KG0dKniNqFdKtx+IKmedzC06SrHgRBU3+Ea1vxOJXoE0+kO48KYKuSAqnAltIsRPv9jwOexvdR8WALHFcgYOyXCZ/YZ9Jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pFIL/aJl; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3f163e379so45871691fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724498307; x=1725103107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gYbbaRAr9Ic3qjqTHNZx0zH/my3OprgnkZd3LOPXAv0=;
        b=pFIL/aJlfzvUQyXUUpvAPjPYuDLu6LEl+ebqtrUscOffxNqPP45v/EJtLR2jan78Pl
         Y6HoABjmpJoo+IkryfUaYOzC/ES9HzZVYpD/CQWRlECzV+3k7UwNjhJwXrdXhXVwG1fv
         kFr7WGsD4jglUF/6uTSc8IyA0y0AL6AOqtJ05TEqGYXp2sp2Rnl5KTF406er1nlgeIej
         lWmz1ZAFLg/dhuejM+6QUjR2sXlVZRtjiaa+UFFvNb9tZdqMWEblyqrYHu5uB5hbkRto
         PwQq6gOKmZrw+oq3WlpRHQqGcEpBuHAK1KdMYENB6ECgF88Lokd7YABBH+c4X0H2vnqa
         gQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724498307; x=1725103107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYbbaRAr9Ic3qjqTHNZx0zH/my3OprgnkZd3LOPXAv0=;
        b=UxHv0c5RTg0UOaIBbnfZKHBtyuNZGkp6gUvnuZ7Av8QDSRxKxC9Ax+7qyMmkVH8jPy
         pifGSekRCAGlI/MjkUapOihJaoXXXK8bAGXi/EuxtHqCQRj9os5AMEB6LjsuDHFGWQuB
         2yRE5VpKZvHvEQ2S1e9twRcXBOmJ1cUWycgYPnRVQCAfxtmbX4srI9lgJWPEQsKDomfM
         2/a7MBFvINUKCr4tAKDmhgZ+GDY8xBLAaW6u0b76n8F4DHQKIBquF1FPVV+gU+pZ14Uk
         nre6ChLbj0XjjEHjGMm9El5hxmXCZQOA/F6sH+73vmN6ZzAA6NFHKjwp3/33/PD1nd7u
         xYvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR/+l4Dzd3UQ3EQSBApf6e4hv/NcIhQNv3azsu5NbUXZMXBXfQMpUCfImooQdQjh2Q4AnOTTUhh749qlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBynUbf76ZEgJLTpjmmbmvOsy3UYwnFB25aQ1fxbwf2p3WfnjG
	o/j7YjoGf1TUjQvbMcKgfUtPR8SkxOUrCCzzuYy6F78PyVdZ4jcBex/P0v+qujaQRWbKC0mXSNg
	i
X-Google-Smtp-Source: AGHT+IG88fGzP8xPqOhCEV3ZN8IhUmVcvCaclZzixTMUL4q23NOwvu12fStPyuQYpPZvkBVEIDbH2g==
X-Received: by 2002:a2e:b892:0:b0:2f3:cf43:c2a8 with SMTP id 38308e7fff4ca-2f4f579e8eamr37332881fa.42.1724498306972;
        Sat, 24 Aug 2024 04:18:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2adc84sm386803966b.81.2024.08.24.04.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:18:26 -0700 (PDT)
Date: Sat, 24 Aug 2024 14:18:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	gregkh@linuxfoundation.org, tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in
 rtl819x_translate_scan
Message-ID: <aa6c0c3e-43fc-4a50-a1ee-7afc20388ac6@stanley.mountain>
References: <20240820184216.45390-1-abhishektamboli9@gmail.com>
 <2348e646-e1da-4deb-ab55-c438a42e25b3@wanadoo.fr>
 <510b12b8-91d5-43ce-a191-9ee0a6c91460@stanley.mountain>
 <77e4dd0b-2c82-4f00-92a3-069526a5f795@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77e4dd0b-2c82-4f00-92a3-069526a5f795@wanadoo.fr>

On Sat, Aug 24, 2024 at 08:35:03AM +0200, Christophe JAILLET wrote:
> Le 21/08/2024 à 20:23, Dan Carpenter a écrit :
> > On Tue, Aug 20, 2024 at 09:38:22PM +0200, Christophe JAILLET wrote:
> > >     - if a "mode" matches, do we need to iterate the whole rtllib_modes
> > > array? (have a look at wireless_mode)
> > > 
> > 
> > Can only one mode be set at a time?
> > 
> > regards,
> > dan carpenter
> > 
> > 
> > 
> 
> Hmm, apparently several can be set (see [1])
> 
> Base on a few lines below, it looks that WIRELESS_MODE_N_24G is exclusive
> from the other ones.
> 
> So the 6 char array seems to be sized either for "N-24G", either for a
> concatenation of a few other modes that won't exceed the size of the buffer.
> 

Yeah.  I started to review this patch and found the same thing but I never hit
send on my review.  6 chars is enough.  If you look at the commit which changed
the buffer size to 6, anything larger would cause a GCC checker warning about
truncating strings.

Still, it's kind of ugly that we need to do this much research to verify that
the code isn't a memory corruption bug.  It doesn't feel future proof either.
It would be nicer if this were obviously safe from just reviewing the function.

regards,
dan carpenter


