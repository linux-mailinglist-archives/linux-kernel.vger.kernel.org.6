Return-Path: <linux-kernel+bounces-301472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D4795F167
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C067B215E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16551714BC;
	Mon, 26 Aug 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJJeg+7F"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3B1714A8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675782; cv=none; b=U5xb71gafo/0EbQ8hp1dykqZRgQol6QGRZ7tIh9rGYvncNurhNflVGqIXsh/8ZswKApTNytGi8dXQWvPrm+MPYK7Z/V/Sr49pkqVa0Iyp5bZwFcmYelgquQDWK02GtyuLiw9G63WI0nzQlMgJaIUgSL2OKqvyhroMBG4heVf0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675782; c=relaxed/simple;
	bh=m5u0IcAWdKx8hVb/V0BzHt9oAthDFFYZLNAiWLrrlAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhLQ0KWTUW9aqeuNbBlW05XytzaDLYF9m5LkfiKRWDXjXBxZLdYJTHcLP6I+tcwC4wrkvYAM/bliWKaqpF+w5niudur5k4QWmLJu9q3l7QoXZxtmf7+6y0SaEqjrVOsXIOo5Py2vKDYNKeZOkg7BvJKkMEjQlVVdwO+zbBEfD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJJeg+7F; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86c476f679so159841666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724675779; x=1725280579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AvcnZxCYKbbgBxM1hp568Q4PFo11xk7FRTLAQWiodk=;
        b=uJJeg+7F52LqCx6TzlC2wIITzs6oOQBjYILWyOCGEZVdxZvpSXjAmbulNlSkUDLrcA
         KfUHAcgYfUN3ClFhvkaqU/R87q65Xv1juHGlSUHbduCj1pyALFDLF62kb7JGgskj0ppL
         +OPFm6lNgA4SxEv6o44ISKz9nLLtqgJtNC+LiCPzMYrUqcMHKpFPi+XwDTiVicIdMjDQ
         5Rauv7nMuopx3lPSpQyOgJCvnjVxQCpB38calw7Et66uGUi/ji19W0wjJvyIa1E+4+4h
         t66iYOc+2yd0b6UL1d3EYO/cF+vxG3zrx7BPVmZn7IHvK8kUjTofvS6j0j6EtfinHmi2
         X9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675779; x=1725280579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AvcnZxCYKbbgBxM1hp568Q4PFo11xk7FRTLAQWiodk=;
        b=GAcMLUyuhDYk7uOWQfuiSv3bWh1oG2Q8QWblzJx58ewXBq3ycTGzyrrx1GbB2avTFH
         RQgCsLAAk2LljMErfBw/pJKphSjyyVCcCDadeY/O+Fltxvna4LK0bDGf9krTyAU6jv+b
         k2r+mUUm+q5Tt/CVzhiEax0trMT4qh5LctZiqEPz+hFxXScRBDFIDCUGn/6rRGYtiLGY
         F4TDi5hzBFu4cj1vlbJ5tCZvdrxjuy420OmalY0KCEBK/boV+8tICPwUNKqJimvlNiRT
         zVOLTuv5d8udk6EI3UAmCP4a2VYdzad16XIJO77TpsbksrQT8Vh4vDvezr2m1f9LR0h/
         gXlA==
X-Forwarded-Encrypted: i=1; AJvYcCXZIN3A/gb7S4koZ+F5sitqd5HqmMgbLblcnLbNVeqQyGY6S1WQ68oilouowEx2xxrGL+DHEC8Tgnn2XfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZsyjMWtS8ew+JoXrBVEAmWJ4C8EnegYoUjMoGuOxxbiM5CuBe
	uX+A9BKq6ZAPRvGILqOs/qdOJUc1ZaZfTS4fu9cbTEx/Xdbiz+nljRUjQGdMKVA=
X-Google-Smtp-Source: AGHT+IEE434rCq1S+EXj/6yMfR8MXyDOkg3EGd1S4Q3BopexMzuNDob8Ant3j5ZoiRS32d0H0gnMig==
X-Received: by 2002:a17:907:f18e:b0:a86:851e:3a23 with SMTP id a640c23a62f3a-a86a51af30emr723539466b.27.1724675779333;
        Mon, 26 Aug 2024 05:36:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f43367fsm657906866b.115.2024.08.26.05.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:36:19 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:36:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Change slot number type from int to
 u32
Message-ID: <98a8d85e-9967-40df-8327-2fc03790b18e@stanley.mountain>
References: <20240825072955.120884-1-riyandhiman14@gmail.com>
 <0289149f-3880-4e20-a22b-8540f212f1b0@stanley.mountain>
 <CAAjz0QbrrPL73qz7OjZMi4banzZ+xE+WgOFHitRKtrsytQzD+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAjz0QbrrPL73qz7OjZMi4banzZ+xE+WgOFHitRKtrsytQzD+Q@mail.gmail.com>

On Mon, Aug 26, 2024 at 05:18:57PM +0530, Riyan Dhiman wrote:
> >
> > Of course, there is a place for unsigned types in C but it's so subtle and
> > complicated to explain.  I think people wish that there was a way to make C
> > safer when there really isn't.  There is no easy answer like just declare
> > everything as u32.  It's a false hope.
> >
> 
> There is a function in the vme_user driver (vme.c:L715)
> 
> unsigned int vme_master_rmw(struct vme_resource *resource, unsigned int
> mask,
>    unsigned int compare, unsigned int swap, loff_t offset)
> {
> struct vme_bridge *bridge = find_bridge(resource);
> struct vme_master_resource *image;
> 
> if (!bridge->master_rmw) {
> dev_warn(bridge->parent, "Writing to resource not supported\n");
> return -EINVAL;
> }
> 
> if (resource->type != VME_MASTER) {
> dev_err(bridge->parent, "Not a master resource\n");
> return -EINVAL;
> }
> 
> image = list_entry(resource->entry, struct vme_master_resource, list);
> 
> return bridge->master_rmw(image, mask, compare, swap, offset);
> }
> EXPORT_SYMBOL(vme_master_rmw);
> 
> It is declared as unsigned everywhere but returns negative error codes.
> This is an issue,
>  right? How should it be fixed? Do we need to change all the function
> declarations to int,
> or just in this function, since bridge->master_rmw returns an unsigned int?

Easy answer: Just delete vme_master_rmw() because nothing uses it.

Complicated answer: So long as the caller is saving it to int then it will work
okay.  If it saves it to any other type then it will cause problems.

regards,
dan carpenter


