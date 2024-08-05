Return-Path: <linux-kernel+bounces-275040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52E6947FE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD7D1C21B9D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A4015DBBA;
	Mon,  5 Aug 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pKdeVlY3"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7F13A3F7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877487; cv=none; b=qGsNA2e+EdioWEbdTFlgNr7H7SkLTIFG1HASuGqQAfzTSI51nnvnwzffg7bJyhB+WTPxdmQCDWle16OCwf38W1GJGDup+XwYoadcDhkL4zf3dTdJRqrD8915bkbsrd3nI8l887G3qHOg/bwR5JUEuIe+XbfJYJfG8Fwy9uj3zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877487; c=relaxed/simple;
	bh=eXrzg6SBh5dOLe6d3BKaM9o3uJoyT/iNO0wCQCbtP+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujU1u38pvZE2FsHOSJ3A+WOB1/qUtIltoljKBaBMahwHGLKBRdWvWxlbqhqAXBpvq4c1orP3+VLGvac/HeBxRWhSp3J9iLB3/g3euMMpgjeusWKjHIB5LABeYdscdJF30H+8EX0R3oJuGByavEHuuYIraO4kcHsOXIcJ9NyKwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pKdeVlY3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1dcc7bc05so663598185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1722877484; x=1723482284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyylVLBLPTwfV/sKaNTlMYx4e/swb+vLff1PWQeZAN8=;
        b=pKdeVlY3nmoIDq5biPFqRP2QBk7taDPh7dXy2ddswjbxhcsg4oXhlvddL9F1282Xb4
         sBbTYGG9uuxw+4EAncUHWshnFPzAcs0v/X4z9ElfkjsqQUnq64byX9lSd6dXMy6luI81
         yscB/n5hkKqCtWM58HBH5E5d6ckyu4TzkFPF63FsF6aqY0tdb2UW/1Et3Q8/Umdstvv9
         EbQ2Hli8eM6iTob/XevVV8NOtf+QliBE+Rp6CtD3DeISkIhtDadI+4f9gjXtSs3VyLq9
         L5jp+/vD5EqAb5x0fHzbUnXA8BwtySscHD3nzzetROY8NE4PWU7SrZivjMlAYQpuY5OI
         99nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877484; x=1723482284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyylVLBLPTwfV/sKaNTlMYx4e/swb+vLff1PWQeZAN8=;
        b=jympawZpkpyw16pb4xMvRZtxN0Gznr/jpD3tLdiQc8Qo3vTJyooliq9VJZEODxXwiH
         uJ8LPBOIcN8gXaWLSRC0qZYG6ntSUSzCfiPPl7SUr5g9FAzcNOvxnUx0LgfpNqJtBSeZ
         Eqyru2ztjoRRcMxWDB1f4X76SLDBlkZS2YAWD7KbAOLh27kW57OnTVNwfgcz2R2UeRtv
         dVRDV6R8CUPb8lYxa6rsEzJDV/Mp+GO9TeAU0B7BAlOmews+VZ8hCSXA0SLxsxQBNZhN
         +WG10+LQNopRPCenA7T/DFA+l2xXLqEVf5r9hE9fUR0OVTxB/LTWFC7NrceG3vBlmimd
         HDtw==
X-Forwarded-Encrypted: i=1; AJvYcCXiU0HW6KgErp5vVQJnPuUFBcPlpNU76CFcwUY8J3tiimtieMCswQuG0U4RKkKv1xDHygop178l+kzPI+uzSlEmj/d4qctA+yf6BdUx
X-Gm-Message-State: AOJu0Yx0o4jp22ImRd6Hb+LRFQUkDsG7old44fvkr6tERdoIApjiiJnC
	9W3NQBessbGtbLPQx5qtoZLgMkJPUVRD2A2xWZIcKmG0ARn4cXHpaQ1fQCCkt+s=
X-Google-Smtp-Source: AGHT+IHAqSRxshXEgEXLY/ZrxLeh74qBnkfjs61TliUkpZgC+uXpeSPuQCeo+zpK43I+L+H9IMOnGQ==
X-Received: by 2002:a05:620a:3913:b0:79f:17cb:7052 with SMTP id af79cd13be357-7a34ef40387mr1605716185a.30.1722877483878;
        Mon, 05 Aug 2024 10:04:43 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f79843fsm366032485a.128.2024.08.05.10.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:04:43 -0700 (PDT)
Date: Mon, 5 Aug 2024 13:04:42 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] mm: Introduce promo_wmark_pages()
Message-ID: <20240805170442.GB322282@cmpxchg.org>
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-8-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805145940.2911011-8-kirill.shutemov@linux.intel.com>

Hello Kirill,

On Mon, Aug 05, 2024 at 05:59:39PM +0300, Kirill A. Shutemov wrote:
> Add promo_wmark_pages() helper to complement other zone watermark
> accessors.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Andrew picked up a change that does this a few days ago:

https://lore.kernel.org/all/20240801232548.36604-2-kaiyang2@cs.cmu.edu/T/#u

