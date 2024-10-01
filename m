Return-Path: <linux-kernel+bounces-345615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D598B817
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D808B22CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9219B5A9;
	Tue,  1 Oct 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s66ntw5U"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3331C693
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774204; cv=none; b=t+2teYdl+G8TQ7Ss2e+s6Wm4Z1kYXCeVsVcERDgjp5Bkq2uatLIPaWpVUEA6j+qGfFsjSdhHeOF3gQo4OgKYtRDsV6Ri+0izCKBtoll3QZ8PRybSpTAoEeuKTuXZR0g+Qlwm4wcklRb0t0tVkHp53jASdydfZApHQ0lvYTOh2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774204; c=relaxed/simple;
	bh=+hkC+wHx8USju2CUYRuP4aQHSjF+YBLptMXet3kaOQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NixOfPta10RdCJswo3ynFIgFMJw86JJfKt8yElXZgo9B1yI1JCaRpo2s2SmYWm7qHuYl5ziVGPvYQBqYqidCKk0UYUZ+BstS2cFnjhgMIDIU7dQtP/BqmutxPH88jySkH0+dh32l0WacmqqefBeVkXeOUqXj2cKQWC4YTpryYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s66ntw5U; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aa086b077so772894166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727774201; x=1728379001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYVW+fZoYsNQwUNb1nbhEAa7O8DUr2KsIfU8oTGbuE0=;
        b=s66ntw5UJ5N+6KxLsehhwXK45lAC7mCCkkhvU8qP+AbTvloNCVCl7ZF+LxLrZWPna9
         623L1ide4zsggmZ+uzlQ2kWpHWansrj+HlnZYFwjhEBfT5CKKXgwKomnGGeUdQbOSstQ
         lKHu+2n1tWUTK72LBzspouzpzmlKAsp3xbm1wYnhNMigud4UW7W+i/Hk1dPyPAMGOaLV
         pytWsNEdTn4xioeDViF2lxGUyyPAkhRbAfVosfzqROVRYFWqKHKpDUjOS45CzoaFs/N3
         CJM4E3zRcIpBbwvPyxZjCeYxVULXGi3qbeTi5PcQmg5WvVsgqEi4MWIIO+xdJAs8ZMj/
         1aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727774201; x=1728379001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYVW+fZoYsNQwUNb1nbhEAa7O8DUr2KsIfU8oTGbuE0=;
        b=GyRH6fxXirrd72xszHLWHIgxfVT5h9GBFQenUsW41cOCNtzk9dW4Wcj1CJIVxgCK8j
         QIWZnZcYjQtgk9rCItKmVDH2hH7jzNu84nEf2DzvxQ4BpyKWe4Cq7hoBFbUBEBMUI6fd
         kHARbynu8UOMtaBO66fjGXHAE7td3miRDZjJxUKPJ4u/Qm8g/p+Xewfj+E/HksCGch2s
         lk16+jdWDevz0COnP4Z6JgAlRAJEjVseM69qbpfqf0HiwApI1IzxvdhXZEJlY9VZ1u8H
         gvquHkyvydGg/va8SnBg8y2R+k0cMGSXdRsI5am0/ywFYi5aNSU8WE+uOMJx2kfyHGKp
         aD5w==
X-Forwarded-Encrypted: i=1; AJvYcCUP4kr6urZ3fOsV+gMaJ5eFsvyH9PfWzhbV5IzL0btIljBKMMaMtrh8GAH57xhAJZW5FZZ++cOxIgDHLL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5wadi+IfbGR6gU9jjRY8a2mHcuR8Z95rq78ezm5S2j6KBuFC
	DI1DXB+zAOLNbUyIbhsav+O7+H/ikp/qojqjkZFsREfNGwgkaAWPvOcYEBLx+H0=
X-Google-Smtp-Source: AGHT+IFvpQHLt6etIQH16/hXCwvxPr53hdozbGlIc6/+kuDS2x8+pdm78zmkeMMv2WnoPJJNgvQ2Jw==
X-Received: by 2002:a17:907:7da7:b0:a8d:3338:a497 with SMTP id a640c23a62f3a-a93c48f54f7mr1615759766b.4.1727774201018;
        Tue, 01 Oct 2024 02:16:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af26sm6032667a12.63.2024.10.01.02.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:16:31 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:16:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 3/7] zram: rework recompress target selection strategy
Message-ID: <efa6d198-c6f5-4585-8b2d-fe8d2f3b7006@stanley.mountain>
References: <20240917021020.883356-1-senozhatsky@chromium.org>
 <20240917021020.883356-4-senozhatsky@chromium.org>
 <61e752c5-ed1b-4b9b-8bdc-0562d2fbc828@stanley.mountain>
 <20241001084057.GG11458@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001084057.GG11458@google.com>

On Tue, Oct 01, 2024 at 05:40:57PM +0900, Sergey Senozhatsky wrote:
> On (24/10/01 10:42), Dan Carpenter wrote:
> > On Tue, Sep 17, 2024 at 11:09:08AM +0900, Sergey Senozhatsky wrote:
> > > +static struct zram_pp_slot *select_pp_slot(struct zram_pp_ctl *ctl)
> > > +{
> > > +	struct zram_pp_slot *pps = NULL;
> > > +	s32 idx = NUM_PP_BUCKETS - 1;
> > > +
> > > +	/* The higher the bucket id the more optimal slot post-processing is */
> > > +	while (idx > 0) {
> > 
> > Why is this not idx >= 0?  Why skip the first bucket?
> 
> That's a typo, thanks for spotting this.  Mind if I send a quick
> fixup.patch online liner to Andrew?

Please do.  :)

regards,
dan carpenter


