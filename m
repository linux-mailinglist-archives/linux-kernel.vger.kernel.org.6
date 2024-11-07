Return-Path: <linux-kernel+bounces-400770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1D69C1211
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9987B22CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B82218D74;
	Thu,  7 Nov 2024 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2uMyFGos"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747C19580F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020263; cv=none; b=Lx6Lq1S+WNKdyTmKDUcAnqi8mEsYwPRjNbiMPOJ5nVWI8kZVHAtWiACFw+eIitLYXlugtUH4IcjcQhsYCrt6tH1QPV4fqwwLWjS5y67gFaUj3vp8mYX+mjps22Vr8IfDAPozTtC0uXo+qvUCH3olzbIV4n2O4KMnXVryI6avXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020263; c=relaxed/simple;
	bh=m52yUTLXSN7mqJyraOt9PomUqCPWj+ee9kNEquEdAmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFZcUeXgrvuTzq/MFxByGXBeaGP4vhVWYMtZ/c/JpMk+AYbDMNIMUT5LlrnGIh8dWa7xyy7y9tCq1RPxwhAkLy2REvXeew1YoiKQSiiv1HAGv9UuTF+3tSkBXJ7YmEHdDLzsbQEx0iwB7NztssI98htrONQgD9t1DWFT3mLAPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2uMyFGos; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1173475a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 14:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1731020261; x=1731625061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26o/4cvY0wiI0+1drLX89Lk/xaFY8ZXJumNp6aN23Gc=;
        b=2uMyFGoskrePX1SMdiklRh7yeHqNdPiwjeQC4j/k1hv3ySknsFfj3YiYOkaOMDA4Ud
         tkTNp6R/eWYlTmn1pGttsG4SdVUZONj0hToe0MibNPeuygX4lr+ZUx9bRldi2q/I3ElP
         Ky3pXOVMmxsu1miU/jOQ2VmfXCE5/IseH5/pWF9Sgiym7H0vXraBCarYoE4k8hL10KlB
         aISIJjvDxwO9I6vtVGXGCGkKz/SwAQN4nN70Js+i1NImyz2+T51e+J/J0AiXhh9OYz7s
         XmTMdAN6Hdu3Xa2SZaMAOd0XEG6kXhKEnd3U8JvoLxJ4YLN+eK7bek6yET/4dvXr0KUy
         8MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731020261; x=1731625061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26o/4cvY0wiI0+1drLX89Lk/xaFY8ZXJumNp6aN23Gc=;
        b=Rh4S7th9Pol47p9gjkgCjx2rfPXCwBar2/zOIOqxpoCSbnVgInPl/SLAYEPj/uphyQ
         CX3Fg6ZTcrkSvRPIasyNfYlbtJL7yIrJve3lewh54TrmIjhfRXMBYxIjYMkZqPXhJHlT
         ILDRyfn38pl4BULw62cnTDMVZK3qVp/XPDtgF9g080bvE5XrhLtrVPYvWZwhpTnQEvJy
         KTMfpgPEctY9fFBP8R1a8RyL0nPxvE7j9ua0w37m4ZGXFHT11M4QXtmsFGoNFc1gw6cJ
         L1cQQo7rFeIFBUNaMgktbeNAgtJQ6C9qMLYCDUy8LomJJXURkR1cttrdjZOvIUV/hhf7
         h1PA==
X-Forwarded-Encrypted: i=1; AJvYcCUn6jQgSvzZq7yir/lEK9DIm6ETRvVL1TSe4YBlglKA6AKYgT3QfCfjxbNEXkBpMvKcCZW5pD5E+EvII6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLT9Q5FOU1ZUk8pCfHslO2azI9v+yZgauE3PeFlVcGVh4oMD/
	P4lxPnDtGITpQB7cMkRNv4TIe3x0POzITgWKIMjCxuYA1jF58fje5fmIlQ4Y92E=
X-Google-Smtp-Source: AGHT+IH/MI8RKGKO9GoLqS7Sf4/ssMjk1wFFHxWcECDqENvF5I+waceGuptAQk/16n0V94A6yBPXZA==
X-Received: by 2002:a17:90a:d405:b0:2e2:d3a0:4716 with SMTP id 98e67ed59e1d1-2e9b173c50fmr1446878a91.18.1731020261648;
        Thu, 07 Nov 2024 14:57:41 -0800 (PST)
Received: from dread.disaster.area (pa49-186-86-168.pa.vic.optusnet.com.au. [49.186.86.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541d06sm4207468a91.14.2024.11.07.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 14:57:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1t9BRa-00Bagg-0G;
	Fri, 08 Nov 2024 09:57:38 +1100
Date: Fri, 8 Nov 2024 09:57:38 +1100
From: Dave Chinner <david@fromorbit.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: John Garry <john.g.garry@oracle.com>, tj@kernel.org,
	jiangshanlai@gmail.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, jack@suse.cz, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: workqueue lockup debug
Message-ID: <Zy1F4n9KoNybBmoD@dread.disaster.area>
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
 <4e58d34a-ce45-437a-95a2-3ba21f35bbb5@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e58d34a-ce45-437a-95a2-3ba21f35bbb5@leemhuis.info>

On Thu, Nov 07, 2024 at 01:39:39PM +0100, Thorsten Leemhuis wrote:
> On 24.10.24 17:49, John Garry wrote:
> > Hi workqueue and scheduler maintainers,
> > 
> > As reported in https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-
> > ab6d-7ed9a4f1f9c0@oracle.com/T/
> > #m506b9edb1340cdddd87c6d14d20222ca8d7e8796, I am experiencing a
> > workqueue lockup for v6.12-rcX.
> 
> John, what this resolved in between? This and the other thread[1] look
> stalled, but I might be missing something. Asking, because I have this
> on my list of tracked regressions and wonder if this is something that
> better should be solved one way or another before 6.12.
> 
> [1]
> https://lore.kernel.org/lkml/63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com/

I'm still seeing the scheduler bug in -rc6.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

