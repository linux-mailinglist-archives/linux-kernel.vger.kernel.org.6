Return-Path: <linux-kernel+bounces-431611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433719E408A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1ED7B2EA00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332151FA152;
	Wed,  4 Dec 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzZLtHOG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9A2941C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328795; cv=none; b=hKACRdh62hMUMtjTU161N8kIsvpTIP9svvXrCgOLP5NFpV4v4vKqR6kVdrrcP6ZwjqYlvojFaDiA6NoWXHdqfymv9a/MHNgwJlOCC3EPaLU4yXtFbWPBHedCr0YsQ6/qunrmzcSv19qduabH8bsW9CAHEB4X+fNMS5Vy8PeDD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328795; c=relaxed/simple;
	bh=V8DlRQpvYOgYA8qfdzum4JVIJVyrvUO51za816DFZuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2ReOxyKtnGLZ4elpYHzVUXbyVyN2YcPQnKuWjjw/fSGdPiyz7E6MwC2488Wq0xYWuhLgiAOVPeLGfrGntzvZijeGSOkkoa/KMZPB0XcCOHCpPSWzHjQmkRtzo/YlhEkxCarmqkYUMo1iq9WMZdXv/z+wN2HF+edFNdspd8ijtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzZLtHOG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733328792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aymwo885HL6oqc+6vmjTcSJBRT0pbBrnlLoXnLYcnw=;
	b=AzZLtHOGAJs9XCCq6YpWPYfaWAXwVZo93YdaR1/am/DOres7kOFaSKNmWfKCLEyAaBfyzG
	KXsEu8dJwXgtJ4S4b2fThshWa6EZY7ZHdiLn07pOLUI2bIoHOc7X3Th2b8xPP9Qi3jeiA8
	h1+BGomdMvQ7nBBOyf6AuatmodJ2iOw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-TBcXtubzOaSZgTKfJu7KWw-1; Wed, 04 Dec 2024 11:13:10 -0500
X-MC-Unique: TBcXtubzOaSZgTKfJu7KWw-1
X-Mimecast-MFC-AGG-ID: TBcXtubzOaSZgTKfJu7KWw
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d883c2024dso18215826d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733328789; x=1733933589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aymwo885HL6oqc+6vmjTcSJBRT0pbBrnlLoXnLYcnw=;
        b=s0Vadp6GLN6Sc/FesupCinc2tTAuJM4pgWrzk19XI1LS2cC68p3Rtm2Cp24YrVhRgI
         mivqPpbHRIJyDZhLbRZrkHLx7xT1I2eL44FW0w1OS09p/bKDDKuv2vrnZmwCC4otKxlr
         2F5G6VYcMYZ6PqTIK7Fz7iENraJ62KFwACth6ijcZ4nj1qIZcIKvm/EDF/+Qeg7N+0dl
         eP4wBkUgGNsc9gsuHBh86oF/zIPY1331v3fA1fbZQLU1547rN+FDFPNWBgwLvIw+xLvE
         /QjFvTC/M7EY3ZD5ao4L8ikdMoMy+EBpBLh5RLNKlwMb//+eCkyBkbIb0k2dN1Mjp07k
         XH0w==
X-Gm-Message-State: AOJu0Yyo9K2DYCLN0ubflQukUwrSQCHNMEFs790/9xfdeoaajs44BXAK
	aoQoW03BghFwdB38kq1X18ScSdJuoON/3ENnVOw6y3UPKmeSYz8g3Yq9H0IyXvPdke8tD3d47n+
	NnH+ZJfxIvqd/wkUuZ45EfnWl6xrUjJtwZApNWQX21Z9AWMRfoJ3OXDOyuyq6XQ==
X-Gm-Gg: ASbGncuLBNzshpBFl3f6ZXpxxcbUyiTrWOK2R91s1EpwW4/UeaCC1BCmDCccM/BBBdG
	iAscu+6/zn4Kse9WD5n8+y9KkutYR5FrVTzNx7s3L6corU4X679pGWs3A8UKD8/oClpeBB6clrZ
	xj0xBo4pcERbff/3ALfA606yrxdN9UHvSZ7Ig4dd4akDK9R+8iPO7vBBGrCQvFShpbK+UpTKV2J
	xRhHjI9qj8ZOUUfzUpZ5tERazrQNQgeRNxGO0covezEJtanZdAbDT9I0mOcOY0VufteyLbSTzSw
	FAqumujbObM=
X-Received: by 2002:a05:6214:626:b0:6d8:a1b4:b58f with SMTP id 6a1803df08f44-6d8a1b4bb2amr229066796d6.11.1733328789456;
        Wed, 04 Dec 2024 08:13:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM7QuUDISSZm0G+5R1UkhK7fnX+M0p5d0SaPYyDmUhvma5KIpSJ9qCR+cwErdiNM9+7TV5LA==
X-Received: by 2002:a05:6214:626:b0:6d8:a1b4:b58f with SMTP id 6a1803df08f44-6d8a1b4bb2amr229066446d6.11.1733328789155;
        Wed, 04 Dec 2024 08:13:09 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d88125a191sm67790396d6.114.2024.12.04.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:13:08 -0800 (PST)
Date: Wed, 4 Dec 2024 11:13:06 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guillaume Morin <guillaume@morinfr.org>
Subject: Re: [PATCH v1] mm/hugetlb: don't map folios writable without
 VM_WRITE when copying during fork()
Message-ID: <Z1B_kl7YZ4DBX7yP@x1n>
References: <20241204153100.1967364-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204153100.1967364-1-david@redhat.com>

On Wed, Dec 04, 2024 at 04:31:00PM +0100, David Hildenbrand wrote:
> If we have to trigger a hugetlb folio copy during fork() because the anon
> folio might be pinned, we currently unconditionally create a writable
> PTE.
> 
> However, the VMA might not have write permissions (VM_WRITE) at that
> point.
> 
> Fix it by checking the VMA for VM_WRITE. Make the code less error prone
> by moving checking for VM_WRITE into make_huge_pte(), and letting
> callers only specify whether we should try making it writable.
> 
> A simple reproducer that longter-pins the folios using liburing to then
> mprotect(PROT_READ) the folios befor fork() [1] results in:
> 
> Before:
> [FAIL] access should not have worked
> 
> After:
> [PASS] access did not work as expected
> 
> [1] https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/reproducers/hugetlb-mkwrite-fork.c
> 
> This is rather a corner case, so stable might not be warranted.
> 
> Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Guillaume Morin <guillaume@morinfr.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


