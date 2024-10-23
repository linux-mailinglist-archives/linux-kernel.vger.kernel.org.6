Return-Path: <linux-kernel+bounces-378942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BED9AD781
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580DB282F69
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C401FE100;
	Wed, 23 Oct 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BF9ZWzg3"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6413B7BE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729722242; cv=none; b=sR4JR3QLVU2/DPkwiMTWcV9eFylyOj5BplauF9pX00AGd+QMX/8hXKqX1O+5dSn9WKPgws1sKkpOfOOtzfaRck05aAy+ifAcvtROdAUcJGRtRM163HSoEdcrsnxCllrba6679WDHOvrD8YzaravhY22nlCyMGEGxKUUcJBTZvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729722242; c=relaxed/simple;
	bh=YAdjhVVUfYQSylSlsN6RQN5JjIVeBeXphZoBMCeYiJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPjLN+J8JBtSj4VQ42GLmT/F7XPly+ikBbQK2nwdIBwGORStAMu2CPxbuehAJlm1YwMQ+YtmhuNdpJTmaYrc9C+yy+YH7GKE/8ToRwQGESo43E/RQy/OBpEVvPRHJq5Kxlk/YafeHtPLCWsWMd75p4XVomCPYgqXuNzHCvaCmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BF9ZWzg3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43159c9f617so2427135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729722238; x=1730327038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Af6qCHxnbOnQOn6gVkA7A18lj8phPdTBA+Y4XWjyTfg=;
        b=BF9ZWzg3WDwUrE6FZ/pQ/pHBQzesmbmb/BjZwfSLx4ogBlta14ljZQxPILl930wGn4
         tcP19UMJrlNbbnluOewuIjKuI3QU3hip5Ebh5iNl21H5WQbXOSna1kCoVqzo95sFQHLd
         TYaQVCxRQ/TrgED8EQ8RFMFQypWRq/4d/OfSs7LyWaPazEyl0gHGxTqnOmj+1hTj37zF
         lRp1MDGXtHyntl1vnikcHJxWbGjCUr89BJxjOXW4txQrtJCsn/ne+OC1lvwnYfVhVLDZ
         OryVe0USf+mGzv5yqXAmyWdLMZW0Re2LB758GItFcrC/RKM3T5vLUpGKISEPV2B8xTCs
         6lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729722238; x=1730327038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af6qCHxnbOnQOn6gVkA7A18lj8phPdTBA+Y4XWjyTfg=;
        b=KTVkvQKGtbFlfdyt/SyHdNJjaqSgijnbvlyTcj+Chhtw7Xv1Lg2QTfhNBxyR1EVIbc
         ZU4SPgtrDzUukPLpxe4/puoQRhAV+Heo65pOX+ljwMt/fZepQ//OsqoY+KmKLxxLsXeg
         tHoEtcr2XJz5NrV8bUiDPiiaXcg3EPyNnXPNppP3lSo6803auaWO6m18V8JGFO5LyCZK
         FQ79TaHzLWqU8KVZ7rDiEEPU8VcaTf/opo5roUcNEfZdmciznfNrIzRjofsOpwpBoalo
         Ah7SWrp5umDthwhCUJUilPMgyvolW8OYnkhqPtVXRDojxd1AsHrZeEBEz8EG2yftT2tf
         De4w==
X-Forwarded-Encrypted: i=1; AJvYcCVpn/VHZw/6x7xlirA/PVytWqpRZ655OmKcaRUtFrKsdBrCAEGbGV1qhyEnVYLBuO/iiMdaBdDR1IBrun4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIW+H6LpH26e5sV1TuPidPcsW4US9650s2qp1CNp/gsZW3eZV
	SN9bWvZ5pLh2saCNvrpIbUz5GaztznxNegH2jV3ol94jfHUNYLgeumYWIvi8b8A=
X-Google-Smtp-Source: AGHT+IFWGGq6xOZkxdbVnpuoBguuE24zDjRO8+fSKst1oxYGTx8Vh022VMgoCs/98O4h3LAUg8mW7w==
X-Received: by 2002:a05:600c:1d06:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-4318412acb5mr31194905e9.4.1729722238100;
        Wed, 23 Oct 2024 15:23:58 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d03ee7asm47105805e9.0.2024.10.23.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 15:23:57 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:23:56 +0200
From: Michal Hocko <mhocko@suse.com>
To: Dongjoo Seo <dongjoo.linux.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, dave@stgolabs.net,
	dan.j.williams@intel.com, nifan@outlook.com,
	a.manzanares@samsung.com
Subject: Re: [PATCH] mm/page_alloc: fix NUMA stats update for cpu-less nodes
Message-ID: <Zxl3fB9FVz5i1huh@tiehlicka>
References: <20241023175037.9125-1-dongjoo.linux.dev@gmail.com>
 <Zxk6bHlrP5S_0LBK@tiehlicka>
 <20241023134121.68d4af59e2d9cc3e78a34cc8@linux-foundation.org>
 <Zxls4HqdkV_yBYxZ@tiehlicka>
 <Zxl1eOooy5lwJwSo@eqbm-smc020.dtc.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxl1eOooy5lwJwSo@eqbm-smc020.dtc.local>

On Wed 23-10-24 15:15:20, Dongjoo Seo wrote:
> Hi Andrew, Michal,
> 
> Thanks for the feedback.
> 
> The issue is that CPU-less nodes can lead to incorrect NUMA stats.
> For example, NUMA_HIT may incorrectly increase for CPU-less nodes
> because the current logic doesn't account for whether a node has CPUs.

Define incorrect

Current semantic doesn't really care about cpu less NUMA nodes because
current means whatever is required AFIU. This is certainly a long term
semantic. Why does this need to change and why it makes sense to 
pre-existing users?

-- 
Michal Hocko
SUSE Labs

