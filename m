Return-Path: <linux-kernel+bounces-524527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A7A3E422
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E3B16A4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5B24BD03;
	Thu, 20 Feb 2025 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QDattucv"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A332147F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076993; cv=none; b=CuJGyAcqGu4io6XTC5hrdd+n3skx1goHVfZIrFH4E8TFxPLekMK79eGpfpcqp+5hOO/T4HD4DdAu3MwPRP87nWEdlx2caveaM97KTKoF2W8H2cfZ8N1+yShycQB/TxfdisEwYE/hd57hULP53obsiCsGwiJSJqk28xWeaC3mBps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076993; c=relaxed/simple;
	bh=NGgRHDDGedIkLCbRWOHyqQOCNZ+JrdBTernCwcw6jCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVxpJHEdWltbnTkjfwSan0jQVLiDtioX/rwqvHpbbKeUJBXq1f5WmEUrnNhR6Yw6A6Ypby6qsAPXhHmvzU5vf6pvKMxKv8Tfi/t5+eCL9z6dwoW7hJUDdwC1YSuUMRZ+G2l5oR6H5AoKnD989vOVjbQ/hRuFgrxHMy0CQ5qXJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QDattucv; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so10548786d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740076991; x=1740681791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d3ocJQTmmz808+gv+xcTfLZcwjDZn2/TIc1rnG0DoJg=;
        b=QDattucvNS6moBrMSgaG5SsfkFzwVXed8XaI/41d5kZzUN4F7IQNv9DXw/fWu+oTmu
         sKGJAhO0+hDbCay1Bhjhd7tadu5RBj30v8G8Ns58nUBgj5FZP2c+5s3nFW+bBVsEGZ0G
         QRNtLyEqpL29QJVVKs4hz3/DIocUz9Kq7Wkb4h7AXcGR+mu9X5wxEapdPojpmpBO690T
         sZtloEG4y8k//BzeqZ+mvjkuQ4u0rtDE9pMWFv34PwDpKBRNm62qumAx69G2j43u4XwR
         avsfAIKx/EI9jpIs+tU//hlRE+f3PfRUYWUt4NcIJKdk+J1VnV7xeWwxSrmWZyYgPVjf
         +l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740076991; x=1740681791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3ocJQTmmz808+gv+xcTfLZcwjDZn2/TIc1rnG0DoJg=;
        b=kAL3kbtu8QVoMNTWFX6RzFyCLZqJzGE0IPcmcCGAiAq8GCH/qBUgiAyJ/nVJb+yfxC
         dBQ7KJEIDpU5jEwgfXnWG1NhGaCldP9kYedxNf4NOYxSNcfKN+BWvlxnaky31KGWwwBN
         M06WfL9EaZGW1fTLfoTJwSWVhauVpeXhmwjjley82hKy+zKbbx5DIP/rpKIQtFhc9uqc
         1tNC8E6rpjRJ+8tdfUe1WqDo0vXEVdwAoIxhwqALpWZKIPIUc8jityReG+8GAliC+cmj
         Ds+zZSJD1XzPap7mDeUz9L8JZM6D8nOBcfQecl6OqsLv1eTyTCFksq9CflqoPvL52Fxw
         0bZw==
X-Forwarded-Encrypted: i=1; AJvYcCXafm7qbXV77JO7yVJeyqG9jtsByuQWKVVhJ2RFhzu3RwgzeNWavRqRPs+rsimYapBC4895Hr0y39Wuy6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YziogiM0ciaaoMXLy14DVxyUJKCCo9Cviu96BFOB+jlGjAonMLK
	eKtxhkFj9DycGNUTo5hSw1T+xj29K96rTm+3papy96Gxv+4QpyLr5bheoGUCyT8=
X-Gm-Gg: ASbGncvNYkUN4Nvc3GX+J/ya7ZASajbJw/LUQMlxMzn3Dz3mWFRIL3eeGmPF8+hzonG
	mmapF+jKjhlmfVvkyf8icUYVDXBKfoZmfjM+rPLbT31i9dmhfb7Rq3jRnjJsq79XPfNvSk1SKuE
	beqvGKKRw9M6vqePSHZ9W8VzQCFRI07N8PgVfIKyi2UsOmPIf/pXNl/zHDebyBeELYrZ/7WHIcA
	AP/mox2omDq9uRUYqs6UzUrMfknmT7UxNSBRe2HdT/dQyXmyJOmJGI+wfGTA2g4z9g94S+ePExM
	4qxE+ENE1hzaSaDE3kwS7KIcQ/+XgnZ4hk4gYN5yb0hQMu8J6D/1rCakx2Gngq3luqFrp+vcIw=
	=
X-Google-Smtp-Source: AGHT+IE6IpITASnEll2pNxcvCEXqhyJQ61kCnsAXUIqsUkMLSxo6fEasrPnRH6TZnjk08cEAdB+JcA==
X-Received: by 2002:a05:6214:d8a:b0:6e6:64a5:e18d with SMTP id 6a1803df08f44-6e6ae7f8290mr2793666d6.17.1740076991097;
        Thu, 20 Feb 2025 10:43:11 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77a2bdsm88435726d6.11.2025.02.20.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:43:10 -0800 (PST)
Date: Thu, 20 Feb 2025 13:43:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>

On Thu, Feb 20, 2025 at 09:50:07AM -0800, Yang Shi wrote:
> > > I will double check that this isn't working as expected, and i'll double
> > > check for a build option as well.
> > >
> > > stupid question - it sorta seems like you'd want this as the default
> > > setting for driver-managed hotplug memory blocks, but I suppose for
> > > very small blocks there's problems (as described in the docs).
> >
> > The issue is that it is per-memblock. So you'll never have 1 GiB ranges
> > of consecutive usable memory (e.g., 1 GiB hugetlb page).
> 
> Regardless of ZONE_MOVABLE or ZONE_NORMAL, right?
> 
> Thanks,
> Yang

From my testing, yes.

~Gregory

