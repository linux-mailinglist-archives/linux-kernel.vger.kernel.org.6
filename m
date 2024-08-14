Return-Path: <linux-kernel+bounces-286828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CA951F80
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6618C285D10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5521B86D2;
	Wed, 14 Aug 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VDgwIHPE"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA891B3F0E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651786; cv=none; b=ij4KTb0/V17Qlqy15om3GbLzNHIxl+Y1YME8oD4lBxUEojT76GaLRZFKtM6L9JekDXPx31E4iG8Kz3W0rkPx3fRhq8Z06aR1zsNk6fOAesl+9v9qbnL4NtlI35KZWQvktm2ckrLY2VbnGrXqLHlZIRC5O+QZzbBH6PwDpMliaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651786; c=relaxed/simple;
	bh=PZ4m0n/MByBhl5NPaFvAkEPbdVfY+NUhvFRXXirjq34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ7uPG/yQEvQTwcEbDrbl6NwRTQ/4CSKrLT6g0oinuD1JSbM1uZT1+TYEczcC0EXFVZSSlgMj83xEgVA4rHWUS4VxKquhfLg/MbczZobJEPsPNoJoRI9YxIgMD2zFjGr4FNTetc055JfVpMsXCO63nl/FdhubFA3bRXf8olBwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VDgwIHPE; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bbc1cee9b7so40581176d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723651783; x=1724256583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UTMAfZwm52SQ0m/pN9TkblWdNOlu11wMpD/MjyARKoU=;
        b=VDgwIHPELv57Mp5FRQOJxNuktKrgbUCwtyBb3r8ClM3g0+IxQZ7CkeWrMtFB8Jtlmm
         Q9JnNftZB/eHsMEdknijp27UHvLY9V5bKH8hp/+Us32tgKLklof0JxGfojow/qldg+Uo
         CfQioMOHfYVu6T5FrjptzN73fg4hAxg2iG6xwJ5Jfu3a5g/I47oLeY6/4huLY9Bm9x4L
         gNdvcwmnyUpGwspzAfonZ5rN63olQtKgU7LudG3PAEoz3IhuLsUTsuNfQn279bIxf+ws
         X3qHGgkdg7volVhvdCXkjWBlhQLNRMA9UWU0QdH0sIP0djB9uo/8MF0OzptFVunC+7vH
         piSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651783; x=1724256583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTMAfZwm52SQ0m/pN9TkblWdNOlu11wMpD/MjyARKoU=;
        b=sww81wYbjaG1TIrtViA+nOuFc4c6y9/K0sdlcsEZDjWTJ67meizXAj+ngiuvgcXHTW
         0rA5Wtgj426zmOWvj+mAWc1yhaDfkZTgT+Z8CBsuT1AdJUNYOcueMpO5kDDBWAUitGZy
         gmwcg5e7+XsnqkXy6sCd4rQFsVAlMbpWD/M6z516yj3GSdaEglDPVMS9DQWnCGgZhje4
         nJayOZ6Cz4soOJbyTmoCX1xTXrBEI+e0gw1l1H/sNRfP+UzAyB2M6FjhxGNm16GhzzEB
         kFE7HL0Ip7OTlXcKcjL343thvgAqrkf1WPH+4PceBwdqfMSMhmZ+xpxMwLidv7E3QtIi
         n1CA==
X-Forwarded-Encrypted: i=1; AJvYcCWuDjUWllVg6jWL9VkR0RItjZz6FX4i4TgxQTq2IcVkPDDvplUz03hy5+PcOVv9/fxPkOsz5D0m6vIBVBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccaOQP1NdNAymqkDnzKH4AbyjPa1MMp9QWVBZpzgIVm4ln/oN
	s07rm0c4koLKLdsVUuqV1gZi4dL50sa+zGl1Myuif/6tplU5T9E6+IyIBEpLM94=
X-Google-Smtp-Source: AGHT+IE7AlYD/pYIIDdg/E83v8kL4zBTJBowCqme1T2/5fVYs0E/hfviepietgGJNo2cAKRMQTu2yw==
X-Received: by 2002:a05:6214:4303:b0:6bb:b478:a614 with SMTP id 6a1803df08f44-6bf5d165b59mr43701136d6.10.1723651783190;
        Wed, 14 Aug 2024 09:09:43 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca73c5sm44900366d6.69.2024.08.14.09.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:09:42 -0700 (PDT)
Date: Wed, 14 Aug 2024 12:09:01 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
	ying.huang@intel.com, nphamcs@gmail.com, nehagholkar@meta.com,
	abhishekd@meta.com
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-ID: <ZrzWnY9a7BFxw8Gc@PC2K9PVX.TheFacebook.com>
References: <20240803094715.23900-1-gourry@gourry.net>
 <20240808162011.0492099266ac47e7b84eacd0@linux-foundation.org>
 <Zrt2GxQioCYiZ2fg@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrt2GxQioCYiZ2fg@PC2K9PVX.TheFacebook.com>

On Tue, Aug 13, 2024 at 11:04:59AM -0400, Gregory Price wrote:
> On Thu, Aug 08, 2024 at 04:20:11PM -0700, Andrew Morton wrote:
> > On Sat,  3 Aug 2024 05:47:12 -0400 Gregory Price <gourry@gourry.net> wrote:
> > 
> > > Unmapped pagecache pages can be demoted to low-tier memory, but 
> > > they can only be promoted if a process maps the pages into the
> > > memory space (so that NUMA hint faults can be caught).  This can
> > > cause significant performance degradation as the pagecache ages
> > > and unmapped, cached files are accessed.
> > 
> > It would be helpful to share some testing results so the magnitude of
> > this degradation can be understood.
> 
> Apologies, this should have been an RFC - testing results forthcoming.
> 
> > 
> > What is the potential downside to this change?  The local node now gets
> > stuffed full of pagecache and other things get evicted?
> > 
> 
> That is one possible degenerate case if there exists a large amount of
> free memory in the local node.  We're testing it now against TPP demotion
> logic, but the expectation should be that if the local node is already
> pressured the pagecache would be trapped on CXL until TPP frees up local
> node pages.
> 
> > > This patch series enables the pagecache to request a promotion of
> > > a folio when it is accessed via the pagecache.
> > > 
> > > We add a new `numa_hint_page_cache` counter in vmstat to capture
> > > information on when these migrations occur.

Worth noting for interested parties: This patch is not stable.  After some
extended testing, we find some soft locks.  So please disregard until v2+.

~Gregory

