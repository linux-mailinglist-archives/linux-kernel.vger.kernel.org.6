Return-Path: <linux-kernel+bounces-378637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81129AD37D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB2DB21F24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5F1D0420;
	Wed, 23 Oct 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UTGilpNa"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5909611E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706609; cv=none; b=pVD7BabQe6VBqJGG9grFPC3uP8k3yydgZopGB4fpbT5znza3iTEuOKkf9b86zd2fXKlUlActvCko6qa1gCaamI/xp2o1CCKVJKwo6eqKRg+eLLqxZz0ILJs6UItaSX1CTKqG94immhCYTxmCnJ2hOyUMpo2jeAkXtPHBeyX5X2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706609; c=relaxed/simple;
	bh=Lvndw97y3qUSVqR8jukg08C+I7m47Q3noDs1XEfCWSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrUvOMWv1ATh5jggUPG0ueMefeJbkbz38Bye77qPP9lv2a7GHiVfnl4TvOIku1va9B+XFmW+0AI9WOTRGQdRSZo/i6XVEewiB5JcuT2le+E4UcmsEiJRZF41MIc3zhEfrH3PfsftLGXXdliE+0MxvIKPpZ6AlJQifJRnOb5/7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UTGilpNa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so440995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729706606; x=1730311406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ2K5h9sf623nMcnfJkpK8VOcZpKYnq7H0gJWmgP7CY=;
        b=UTGilpNa/6jC8q2JkwwPtp43fsX2zpjRcio2uq4WkCveyK/PSLdeQ69eqYlZzr0FRP
         IZetZvKLYiPbPc2AC8fJacmuxU7ZMaDT6G0/lOSSpz1acn8/wC+Cpvz+LF4AifoBAR2s
         ar60gIauLFn70WUz6D6tCysB2/qt3Q52bhKupvN+mTsVHAwYW0pI82meg2CXiBAourgL
         dFK5apO5hcO6bZC5mdU/S69Ky2EyqPC9OjwKevBmt4GTOAxQmw9cDiWwQkXCL35wKG2O
         39b2abDm6jNFChtaTkikFC2RIdiwq6g3D5ZC6pC+mD2AZSLJUpGeNsMYwBSeCisSNpam
         bfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729706606; x=1730311406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ2K5h9sf623nMcnfJkpK8VOcZpKYnq7H0gJWmgP7CY=;
        b=PJDrTDHNsft1DbQ7wIhmGRLSUD1k8EWUhTGTL//8fZaBXowPQ9ky9fRybG49UVPkWt
         0J2FnJrxh33LXc2x4k9O4rt2ZXav7U4J9SRAWqbKFkYcOXOELafsRpupFbrvjNSNTcpk
         Esf/lkHnYc4i4p6Zi8jwXPykKpdO6NXNS1O1BQE+TQIIhiE04SUuRgmiqoJrQnhzoyHV
         R2Q9aC06HCJyUUX8y6juEymChwn499ULITt8MWvB2tTsdwkXQFcSIwW+SDY25T557FUy
         vUnBOGG+R4Xpbbwsa1OeK2Trnioy3U/R3oRnSC8JOtwY0ssxHSc5KXYCh2+IFTgQyfx/
         p75g==
X-Forwarded-Encrypted: i=1; AJvYcCXtvJZ1QDfX3sfjemmDwIgP9nzseKmfibKim4ZxNlj/mLkK/jP73ysgiv4uC5n+bvfBAs90fha25APL0+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76JAwSiHCOY9UwqXbVI10d4DUTPo5GML0xucbb8x5R4q7qGhk
	/A2QhjPEVZlmj/emh0u1w+JxTi644Wa2g5FJQ922Bv7EMOisy1hWJ57llXGL0MM=
X-Google-Smtp-Source: AGHT+IGFh3ZGJm7sWN+e00L/czl0fWnCNypPtMJq2r/wChfK+5fdpkwk9CaOfqtcQP8kGNprEslKMg==
X-Received: by 2002:a05:6000:502:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-37efcf93218mr2252253f8f.56.1729706605889;
        Wed, 23 Oct 2024 11:03:25 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b630sm9425382f8f.60.2024.10.23.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:03:25 -0700 (PDT)
Date: Wed, 23 Oct 2024 20:03:24 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	dan.j.williams@intel.com, nifan@outlook.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-ID: <Zxk6bHlrP5S_0LBK@tiehlicka>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>

On Wed 23-10-24 10:50:37, Dongjoo Seo wrote:
> This patch corrects this issue by:

What is this issue? Please describe the problem first, ideally describe
the NUMA topology, workload and what kind of misaccounting happens
(expected values vs. really reported values).

-- 
Michal Hocko
SUSE Labs

