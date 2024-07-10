Return-Path: <linux-kernel+bounces-247967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4192D6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A141F210F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5BC194AF9;
	Wed, 10 Jul 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmszNPvx"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB518193445
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629593; cv=none; b=SEIYB7dqLGa3+6hTjhT7R2ZicHe1D0bjcBjRfWofedhowsXH5UOZuo93e60BJR3XLN99vsCXtUA/ryDrCS+t6CS1jP5/1LlnQ4L2ScgeXtiZ/0m3lVwdyiW1vENNOPL1chiegFoofqNVoulTQu1UfTNkijuYsNSE5jl4fNUlmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629593; c=relaxed/simple;
	bh=9ESXakrMjKEB4IRkZbd7Ub5SWwk0dkTsJs2mzSsvlos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHZAKdRkhg/OpMyKwfILfos3a10j3EyBcAWk4oFJQA+D2uJKw3e8qYZGT+Aznw8sBo8AwPtah86zof88YQxw4a37NYRnebz5Je03ATtocaaAEvzv6USU3Pndj+5WbQPliVZ39qbsu+mm3BhfDHQAW8W2DYPXQv4HKAOdmvMpZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmszNPvx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-767506e1136so9001a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720629591; x=1721234391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTVg5eu7VBZK+Ds6LpQFCkCmv0op6A+RgUobnIf2igE=;
        b=OmszNPvxC9zuAXw3yWosnaZRh+F7UXBCy+jIj9BU0MS3IVWHdd/TmUPDzCfMUOdIVD
         MXbDCV9wcyBi56GjOyWpqgm94cvS5ptMV2BUW8NOl5Qs7tX7qN7Nj1oPjc3C8x+ifGm6
         JYUrvogSgBur2GO5zkCuAL2ph6qb6s6mSLCLKoDGFhdZ9u+2vcCPzsW8hylNoB4PCct1
         NQPi/Y1FEDmbEZMzDupI2raEW7Mm4GPyxqJuIvxu/LzGgyXntWutX98xEaGSeyKdWwo7
         q8d7aiO+hWhYoXsPjS3hgLgn3yh5Zqwgr52jz0NPC0jnEUK69kGn0qf5UjiHUFyqDW5K
         NKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629591; x=1721234391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTVg5eu7VBZK+Ds6LpQFCkCmv0op6A+RgUobnIf2igE=;
        b=BTP3J/ysfm0fG9nMCDNG5KIvN724ntaCqxu6P9Ay5zXMp7IPfn2hWbw1GoQgdxgLbP
         fJeO5fla+/D0xk7uB7vr9XkGAUshLK9BPDxcGtAss7yT9mY9bltgQD2RsEEW0V/mvo3W
         d4AXiDXyrhOhPg2tzeD0Zx5zmAvoG9aIOatVIuJKUZXYKHb/DujGk/35j3UieEjI4f16
         /hkIRHI2xHCSDlH9pIkOmKktZNrTLv5QcudLRb/O2lVRArT6rPIhuKNiqBBYd3HMkn6L
         e+TB19Cg+iUo1r7Ph1lrzbLumnZkkfCLfobtju5L0rGYgdryDNssq57O1zJgaXsbEiCz
         kirA==
X-Forwarded-Encrypted: i=1; AJvYcCU1RhdxgjbFEfDn0FgDqHLZA2XcLzJOArl48DBaHdifkmdOjHTyCw5p/uSjb7Tyv/SaBbomBzgA7ZCClJx/vaLVGFs6sPZ2Rylk02uG
X-Gm-Message-State: AOJu0YzFY9b2BUpGAeEmzVojiAZY2VWdgjJKinW+ELaDPf01brFBnMkk
	C49PvediFTUXKQ6rvuXM7n5zF0qSLeHTS6VHarjdDeUrGKaMlmtIArpoMA==
X-Google-Smtp-Source: AGHT+IG1gPGQNdhYWFaJ5rR++FoU+xvN9x/eJmXGmdRGR6hYx6y3VgFzeGaZ+TeVjB59o84rlw/rUA==
X-Received: by 2002:a17:903:2411:b0:1f7:3a70:9e71 with SMTP id d9443c01a7336-1fbdba07743mr2243725ad.13.1720629590969;
        Wed, 10 Jul 2024 09:39:50 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6e40sm35688045ad.169.2024.07.10.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:39:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 10 Jul 2024 06:39:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <righi.andrea@gmail.com>, void@manifault.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, changwoo@igalia.com
Subject: Re: [PATCH 3/6] sched_ext: Make @rf optional for
 dispatch_to_local_dsq()
Message-ID: <Zo65VR_ASpkq2N9m@slm.duckdns.org>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-4-tj@kernel.org>
 <Zo5Ncd8DxGSVztoH@gpd>
 <20240710114142.GY27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710114142.GY27299@noisy.programming.kicks-ass.net>

Hello,

On Wed, Jul 10, 2024 at 01:41:42PM +0200, Peter Zijlstra wrote:
...
> > Not a blocker, but would it make sense to provide some wrappers for
> > rq_unpin_lock() / rq_repin_lock() to simply return if rf == NULL?

Will address this part later.

> There are very limited contexts where unpin is sound. I have no idea if
> this is one of them or not.

This is called from balance to migrate tasks across rq's, which is where the
@rf for the unpin/repin is coming from. This patchset makes the same code
path called from other places, e.g. ->task_woken(), where the rq lock is
already unpinned. It could be that the better thing to do here is just
unpinning from the balance()'s context so that the inner functions don't
have to worry about lock pinning. They're always called in a context where
the rq lock can be dropped after all.

Thanks.

-- 
tejun

