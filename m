Return-Path: <linux-kernel+bounces-314107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D081896AEEA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 05:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97671C214A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B350A80;
	Wed,  4 Sep 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OlOqiMpz"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182764EB51
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725419579; cv=none; b=QeEdLy7hxJVUW6sYCDeCHXQBnM6anyF1j2+WdT7FrcD3n/3KH+PUK4zvvDz113Ks/64wQtrru8o/XH9AxjCQki9rKMV3znacK91bWQomDoj24vWaD14FGeMPq+NvS3/tY6yeksLP7uFFOKZThpLbSX0xMNBngI5MjixkiaV6aJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725419579; c=relaxed/simple;
	bh=SPQo202uUuJG+JmR0EvjstYyCdAd9ZrJg8PJZ7Brx0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JptGvnrZRDGXHdEYmlEni6pG+TT2TYUTkP3BL3jp+rjJhmQk5Jxg6WLnO6kE2cDTKUWDK3cp7493UUabJ0naz+sXjM/NB0yhoLyKKCCASfGW8jTP8VLXHXFMCgfSCQWkzlmJ7WroGGbaAzeRL8QgNs4rqcP/5JjWke8Y6WCZ5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OlOqiMpz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7176645e440so197766b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 20:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725419577; x=1726024377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVPWu9sUqLbHT5iyV7ZfxkiCdl2In90sWFTTzj0LOBA=;
        b=OlOqiMpzxd1WAqIDSoQ50ufJu4GeAGcznGylOQMY/0m6OMOkMIU0TfWnPRHw1HQHc9
         nW2E6IKYox860MFDOFx773ytjwRM7JjzmMygizWm/8RIjpk1/VaVITJ/EMhSrtWyClP4
         UPhQIee32H/A4UeBj1L9S7uQNzTbXUp3/13BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725419577; x=1726024377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVPWu9sUqLbHT5iyV7ZfxkiCdl2In90sWFTTzj0LOBA=;
        b=F/Wjk4ZxfkPPUCLzmc68qcJUMb8lic0+7WINFm03N228bi3vlnaPCw8xHfGhsfx5md
         PK/D5+wGRq8zA5o2jsLrzuOAH2aHLEFJxSIwRq9cF7eoYPLn5S0pTBNXafXxOGLFZ5a+
         vWi0+XjIuLIPRNdBnctbnJPXhLO+4s810VRJlKxrfSU9QOE23nmjZ6inH29WCuwN37ST
         dIE8USlDv413n9xg8Y631XwlkFd6AimdJ2JgnaspZ8DeFogbumyCC8vO4vbWKJswhFhQ
         cwrZoLTQGBVXZH9QnsYgbzaXi5HAhHa6NOKlEs01LJGrPn0sOdJHcvLsBN7fPdDj02Wo
         N/ug==
X-Forwarded-Encrypted: i=1; AJvYcCXtVd+42ngg2BWJasncS4hHZSC9zNInlYeoLTNNyR1H0PyQLpfHjMiWzurvSOyEA+1WA8dPUXD+/MeKeAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXT3HPV4jyMujxxewW0Xn5YjCifEPqtMgEoLLTaKrQzT9YHmf/
	oeu5lRD0capKDvmc/sGp7UtquWL6yXyiIstl/hV28uidbjGMu+IVtb2po7mNag==
X-Google-Smtp-Source: AGHT+IFvkHAwDXcuJE+SuxW74G8xVLUNQ0a7z7IakAQfJsKRjR1RkSpDa5RGzx9oZKjbHyQbyUU4Zw==
X-Received: by 2002:a05:6a00:1895:b0:710:9d5e:1154 with SMTP id d2e1a72fcca58-7177a91f845mr1429191b3a.2.1725419577304;
        Tue, 03 Sep 2024 20:12:57 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:51ae:4bbd:c856:6cf0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b9609sm569140b3a.215.2024.09.03.20.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 20:12:56 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:12:52 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Kconfig: fixup zsmalloc configuration
Message-ID: <20240904031252.GB1602548@google.com>
References: <20240903040143.1580705-1-senozhatsky@chromium.org>
 <20240903175528.GA1190078@cmpxchg.org>
 <20240903142847.f03362654cac51bf4617fe18@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903142847.f03362654cac51bf4617fe18@linux-foundation.org>

On (24/09/03 14:28), Andrew Morton wrote:
> On Tue, 3 Sep 2024 13:55:28 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > On Tue, Sep 03, 2024 at 01:00:22PM +0900, Sergey Senozhatsky wrote:
> > > zsmalloc is not exclusive to zswap. Commit aa3ba6d72ce0
> > > ("mm: Kconfig: fixup zsmalloc configuration") made CONFIG_ZSMALLOC
> > > only visible when CONFIG_ZSWAP is selected, which makes it
> > > impossible to menuconfig zsmalloc-specific features (stats,
> > > chain-size, etc.) on systems that use ZRAM but don't have ZSWAP
> > > enabled.
> > > 
> > > Make zsmalloc depend on both ZRAM and ZSWAP.
> > > 
> > > Fixes: Fixes: aa3ba6d72ce0 ("mm: Kconfig: fixup zsmalloc configuration")
> > 
> > I can't find this commit upstream.
> > 
> > It looks like this was actually broken by
> > 
> > commit b3fbd58fcbb10725a1314688e03b1af6827c42f9
> > Author: Johannes Weiner <hannes@cmpxchg.org>
> > Date:   Thu May 19 14:08:53 2022 -0700
> > 
> >     mm: Kconfig: simplify zswap configuration
> > 
> > instead?
> 
> Agree, I edited that into the changelog.

My bad, I didn't pay attention to what checkpatch suggested as an edit.
Thanks for spotting this Johannes and thanks for fixing this up Andrew!

