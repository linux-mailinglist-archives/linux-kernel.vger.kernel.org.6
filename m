Return-Path: <linux-kernel+bounces-285032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D05950874
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C700F1C2244F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2D619F495;
	Tue, 13 Aug 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L6NliuEE"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED319EEA4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561542; cv=none; b=oqeCwp5FQ3snOxNfUIWzfVeytks+yvELYjZlmBxYpmgkNdeMhfZlrWw6NN4GR9vkVvCHyyChWiYydf2HRvVNPAJnKcl+esFVEF3yPQrmGw5bvMtsmpblZ7xaMacwGZ7iCVhrz53aPno7b7x4gVDDcBTGNEmlRtyTZeAQNzRMjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561542; c=relaxed/simple;
	bh=kL1QFrRFip9DZI7tatoi1n2H7ueHD8tNjOc1GJqCzX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4rtnZkFAyryke8B8C/c7M9lRsImyUSSU+s9fCkSR++uQRjZnBwh70JJm8NJXffxbxSPBkvLwOdDPsTESBB/chCeUboUO/qinR6UGzKLKeiDR+Zt6HNGhf7AVBPrhCE3sFbwhGYGxCySfdqOdYN9aWry2Jcgzd4IgOS3U0n/vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L6NliuEE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1e4c75488so336424185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723561539; x=1724166339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pYs7Ta4Zm2a3hPTeSnJ0k+jDcgZQaPBsRaL7CGQPOBQ=;
        b=L6NliuEEWafYNVuQfVDjfDQsI2MWx8CJ4otOQkL8qS1uRYuGjUdWJUiEk1DEQUIZs/
         kBl+KkWwvpzVODdDHVdk748b8UOyt1YgvJNB3EtGuCgRAhBM8GNcVgSX6TioZtdvQBNl
         qGqsiBe6U3YE4bf56SyNhk4hK9K30JGrPm3x9d1uzH00NEFb+qPmNCw2DHcFXSqHqa29
         MnLTguP6rUvmR8lyR1SrRbXwpVCTXfAYkEq1hzIgXnnGFc/dC47rNqoM21s4QVz4f80m
         9CewdWoBlYSZIDRUtU/m5deMgGAfsjJA3ccyTuWH93sCJNHe2uLUnFHo+jNHmWgvYWeU
         KFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561539; x=1724166339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYs7Ta4Zm2a3hPTeSnJ0k+jDcgZQaPBsRaL7CGQPOBQ=;
        b=iGBgBqYC9c+2BE9BylHPNeBQjhtze3N1Ks3vQss+1Uw2CZYJptdu1CJtTjfDAY+Skh
         ma4Ek9v7nwzbqDgTziZFKrla8KaBBWZd4zD96V/urnPueGvPrwx/jGwSLTcq67vBKf0e
         CxyjFj511a5ifCLBv2byXSRTQ6I13bEiwE3H9Ap8yRkya2SKryZMxlGBKKXT9XbL192Q
         9MoiQ2jjjJQAw7YJ/AtqZgbb+stejdf3eDDVvD3o0P+NWYJXKHH2ZTt9F9ceiPPHY9ES
         DisNo2LkYuyZRKB1uucNMB/a2LbK378nIGMx5opLSExFeRwERxFtB2zwrmlcFzfDluh9
         mglw==
X-Forwarded-Encrypted: i=1; AJvYcCWaLjyWv0t1p/pxlSaF2FI0mKyKciUAbhTVfIps5ioKWU1d+KVPigcpxMBUTUSvmKCxw3IdCIwP6GzfC8sSt3OHP1FsJ8cMQyEGf+Fm
X-Gm-Message-State: AOJu0YxjLHj4wVpWC9IXMMrQMPv8DiKlmfb+qInuorgq36mdWHkguAqv
	gp8zUCFqrLYKUc6fdB79QamJaZ7mth5k4I4crWqI88+mvFyHe+0hd3YI+FgV12A=
X-Google-Smtp-Source: AGHT+IFH+gLddjFM066hijJSO2Z2gYXco+N0rUMiyHbjSDAltpgxWELBKXwJv0zTm+vcE/lafXohNw==
X-Received: by 2002:a05:620a:2a14:b0:79f:776:a9f2 with SMTP id af79cd13be357-7a4e15d7405mr439024885a.56.1723561539322;
        Tue, 13 Aug 2024 08:05:39 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e05595sm346423885a.122.2024.08.13.08.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:05:38 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:04:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
	ying.huang@intel.com, nphamcs@gmail.com, nehagholkar@meta.com,
	abhishekd@meta.com
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <Zrt2GxQioCYiZ2fg@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <20240808162011.0492099266ac47e7b84eacd0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808162011.0492099266ac47e7b84eacd0@linux-foundation.org>

On Thu, Aug 08, 2024 at 04:20:11PM -0700, Andrew Morton wrote:
> On Sat,  3 Aug 2024 05:47:12 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > Unmapped pagecache pages can be demoted to low-tier memory, but 
> > they can only be promoted if a process maps the pages into the
> > memory space (so that NUMA hint faults can be caught).  This can
> > cause significant performance degradation as the pagecache ages
> > and unmapped, cached files are accessed.
> 
> It would be helpful to share some testing results so the magnitude of
> this degradation can be understood.

Apologies, this should have been an RFC - testing results forthcoming.

> 
> What is the potential downside to this change?  The local node now gets
> stuffed full of pagecache and other things get evicted?
> 

That is one possible degenerate case if there exists a large amount of
free memory in the local node.  We're testing it now against TPP demotion
logic, but the expectation should be that if the local node is already
pressured the pagecache would be trapped on CXL until TPP frees up local
node pages.

> > This patch series enables the pagecache to request a promotion of
> > a folio when it is accessed via the pagecache.
> > 
> > We add a new `numa_hint_page_cache` counter in vmstat to capture
> > information on when these migrations occur.

