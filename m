Return-Path: <linux-kernel+bounces-440751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C49EC3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94882285BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B2E21C166;
	Wed, 11 Dec 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nGJg517l"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5420C026
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888634; cv=none; b=blmoqmcllN90FUbOsJ57mMeDcxqJS5JsJL7ZV4mcZGIoX3uO+CguRHjRD+FzLf71me/hmruzJCgGDcZqma6SbAR0Sc12WAVNLVOWNlUGZqWHQmcb19eUdglLF4JBIjx3JwbEISdE6BndnkZcbKUSfZyc8hpkPhaC78qgvw2TQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888634; c=relaxed/simple;
	bh=3qmb6n2k5jyQxy/EaKqykA7/FzwxzB6BLnxQE1aCQSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVY2CjXgY8EClD2kGa4jKjOmyJ9SKROvoewpuayEfuRNOGuNvfYta9Q+K4fswiZWwEefgyzYrJX18WCm7x6lTxqyU2DswYzWOB6CPffdUSc7ouZeztL9eBxja4QkPiKPUIDbEBjqf7zDSD9wOZ7j9Wasd9sQU4E/IN71+VpsKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nGJg517l; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2165cb60719so21953095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733888632; x=1734493432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ay9jjGFrKSAl3bI/vTKsN5E9jw7DK63y+NCGY7vvAw=;
        b=nGJg517l6V4UWgTEodc72v8VfS3oS/FjYTWt2aVCEIGe8HGcMUTpha8hBw4I0oDTa0
         DwajsHuF9qquFnp+MMRmVxPfbm1mWmFRIeMyGyDq81oYYrjvtQxm8XfkPj/VjVjag0T+
         USr0sLv74EC/S3kd3dlaiLqT6nJnQC7S4VL9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733888632; x=1734493432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ay9jjGFrKSAl3bI/vTKsN5E9jw7DK63y+NCGY7vvAw=;
        b=MfviVkl5+vG/DimOI6X5I1eXurLTMdGn5FKeLEMk6QCayZPRsInPIy0QHRyNK0lcmG
         W/y8Gblq8XtWZCrNzqow0UlZUMmekILE16/aqsu/sdQ2qjaTPY5k3/FaUG+b7BA1Xv8m
         h7HmpSg6uf3ZfXgjVLvDAoAfbUdNh+cJD9TVQ5KnnLDvvs3hqCBKTHrEmXyfAf9lMu8Z
         +NRntxIdCJ0D5ZQeHAj0W5dwLrs3+2Qtwn/gL2TW/Pc6lF+2O7ZKrwbL2uvv5OwFnFzx
         eVQyx6xftyR/Rh5Bc0jBykyIYXYHNxvHvEjogat1uHOFUUz//wb81bM9A0b0RmBPOvWt
         cqnA==
X-Forwarded-Encrypted: i=1; AJvYcCXpM7irJSI7/kuUzO4KeFEdKR4Rp8U9B270Y1k8m3WPL9+BcTeR0zDv0Tk0sGE4xIHRXVX9SpS+1F8WWGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwByyEXdrH9PlxSRw65ON7WkSO33+ri7RyVFjE7B002h5CD7/
	M+S53m7w8nlzlwmRTV21jCTNvXYxqou+shtwHUn0dZzAwitt3Uvy/FBYTxmCR63HWLBZd1mH7a4
	=
X-Gm-Gg: ASbGnctR+opkhz+hEV/PVdsE1vteXIa80JxXb9QIL61Z5N29PHC7c37oLcuTKoovzBs
	G5Om5AjptmkTSc47+l7H0GlBPSHpK1VIOdTK1gv76SOZdEhPx8XmLnnq3auTXrijogdfG2YAv7w
	7bBCURoU/ZUT8PU5HGjtSnrRc8X87W/PZn+one3adbot/TCxmWhSstW2cKZFKGXzdAKquh3td1N
	1abHzdQIgisgqOlkrxSfFFwczItVh8vn7MM4qRv32Y7Bm0P5ioa8cby3A==
X-Google-Smtp-Source: AGHT+IG7fmSiS1eRU5dgXKaz1kWycM3+vaUeoUL62BZ1R6/arQU36zJoWoargKVw37KjdCddDfFz3Q==
X-Received: by 2002:a17:902:f60e:b0:216:2bd7:1c49 with SMTP id d9443c01a7336-21778535677mr27648725ad.29.1733888632547;
        Tue, 10 Dec 2024 19:43:52 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4d97:9dbf:1a3d:bc59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f26c6csm97547695ad.233.2024.12.10.19.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 19:43:52 -0800 (PST)
Date: Wed, 11 Dec 2024 12:43:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] zram: cond_resched() in writeback loop
Message-ID: <20241211034348.GA2091455@google.com>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
 <20241210105420.1888790-2-senozhatsky@chromium.org>
 <20241210165456.288ed82b8a66a08ac36a4d15@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210165456.288ed82b8a66a08ac36a4d15@linux-foundation.org>

On (24/12/10 16:54), Andrew Morton wrote:
> > Writeback loop can run for quite a while (depending on
> > wb device performance, compression algorithm and the
> > number of entries we writeback), so we need to do
> > cond_resched() there, similarly to what we do in
> > recompress loop.
> > 
> > ...
> >
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -889,6 +889,8 @@ static ssize_t writeback_store(struct device *dev,
> >  next:
> >  		zram_slot_unlock(zram, index);
> >  		release_pp_slot(zram, pps);
> > +
> > +		cond_resched();
> >  	}
> >  
> >  	if (blk_idx)
> 
> Should this be treated as a hotfix?  With a -stable backport?
> 
> If so, we'd need to explain our reasoning in the changelog.  "Fixes a
> watchdog lockup splat when running <workload>".  And a Fixes: would be
> nice if appropriate.

Good point.  This fixes commit from 2018, I guess no one runs writebacks
on preempt-none systems, but I don't see why this should be in -stable.
I'll send updated patch in a bit.

