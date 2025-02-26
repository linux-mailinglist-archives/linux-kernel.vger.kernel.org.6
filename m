Return-Path: <linux-kernel+bounces-532805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F14A4526A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE54169704
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B5219994F;
	Wed, 26 Feb 2025 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA+MtdzC"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748451422AB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534779; cv=none; b=LT0qJHUEWAWjFUHUauBafna+dhKMpL4FbcWpRt4Ybq8hetQ418WHw1hNqRdZZ2Cb/x8sgVRIVM4Nxysrc/w5J/zeHvak9sPQldT6Fd2bNZD3ttsofnOOhuSFyoytdiyqgWvRljFsEzN5N+GCKGN7ifYfORmWSS+AIGHrlBVnF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534779; c=relaxed/simple;
	bh=r5NSBer8BAXnGkHxNUrmY29W3sTWpEiaHk2Q1VNlrts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hxux5GDZonaZbGCiH72IrFLfxI9agUPEtFmXfaeGqu4aoGLA1mr5LyK9JFYqiR0MXmryj8wkbiMDY+W93ExOjC1py9OI+HmxhVSf/oiHGC2Xvp7jAyVQqvX9glNtvxlAElGzH4cOSve8bykdICKNo4wuIpQw+EkryySEPABU78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eA+MtdzC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbd96bef64so1029600466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740534776; x=1741139576; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPjFR2DKnblIU6ZH5nzJo7osq9EQWLT3W2QPuv68pT4=;
        b=eA+MtdzCQag/J0h+xOb2gnwmsZXR5Voxd2VtxmoHwcSr9yBSUjpE8+AzbOR7pOSxak
         Ej3l85s5ropp01Ak7P7OpPYz2tAczgn3WUNsD0T4Xi2FouGGYmp5bVac13sgZyO0Hjgn
         xn17x99kpfeQK3+j1Tf6ifyHgCAOzuHL9IBIJ2PnXor4EGQ1b9PIHeYoqsAT1gkH2jSj
         3fu7GFTexT5mWvgkiog0BD7B+tMv2RPjkCaDGOYoqViu5un3ORkubkeepLqCCiiYIw+D
         64dNhTAgRgPPEBk55EPg6YSZHaobDPYaWnFPLvxDJ1Uy5zsS9ACpkbCz5XTgPTwyEBkZ
         uuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740534776; x=1741139576;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPjFR2DKnblIU6ZH5nzJo7osq9EQWLT3W2QPuv68pT4=;
        b=gypNllu5XT5kVUj3LYMSMId0JsQBgltenWPoG/kQcLjurVZyWMB6vsXm3wRkkNVrp2
         918ZNr+4L7QU0YM78m1wISZXrsLwXgAr2qNtbgfuJ/7M9hbOVmV/UgXfp5H1+Y63FfcB
         rv6vNDG8Afg0VPRnqGN3BKh0TutCXr9ok97V3X4uPNNNWge0dIKDWaEOi1ICazvBgNpz
         mVt4y89FGx0weqB4KSUIsx7fhGRBp5oY8sdSPzHfSyRsIU3B8FBLzShNew3dk3Tk8rlR
         ZiEiluquWyX2LzmI11OWeDzhIQ8TJu1WvBKCUf3k+GwhvHLs+Ag0aPUXmd9We8wIUdgV
         mB1A==
X-Forwarded-Encrypted: i=1; AJvYcCVI6VnHZmUDWvHiGaMFZygGqjqvTDuvAjejtKTUskliuG63IRGu6W7ruQk7fXjS3n2/eTjR9S7G7Cd5mXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27j7lERZ9YvibJMikO8UDpCTa3tu6Rcj3zat4twW6epE5Qku3
	H+r7yrJapyw6+aMILlsIkuVN29aGdKYPaiz79ahgFZcfayFJ/THC
X-Gm-Gg: ASbGnct9LuULB3nhVCWTlODysQw9M6e/7wfBkuk3nTC8lqrQkRa5/G0xMOnJg1DJe0d
	FfeY5YcGae297IOr6reHK53vpQ81B/2+QvJ6R7IgDf8bFi7iimXCegSPTa6Fe7trW4S1S2mm6sy
	JRL1dpUPyNseUPx8hZ9JvcSChBONk/p0cMbdHvPus4aC7ni3kB0/OheDmqDHmgbRh+s2Eeba0r1
	B8jyGPu9w2anycfsYrR5oYvqOLstoPI6l99Ui6PqpVHGMe+BPTBZEzV/+K+TWeo9j2/cIdkAsGy
	Q7MYHxr0OWLUIhvCkphfWNj63g==
X-Google-Smtp-Source: AGHT+IFHjXyUV/dXjvsgceDHUNreMbv4Rpxz5DHl+65cRelfKsIs5RWzFx+BTeKeaeNiEeFT4T31NA==
X-Received: by 2002:a17:907:6d27:b0:ab7:e567:4fe8 with SMTP id a640c23a62f3a-abed0d60b6fmr608303266b.25.1740534775456;
        Tue, 25 Feb 2025 17:52:55 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2013355sm236359066b.113.2025.02.25.17.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2025 17:52:54 -0800 (PST)
Date: Wed, 26 Feb 2025 01:52:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Frank van der Linden <fvdl@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/2] mm/mm_init: rename
 __init_reserved_page_zone to __init_page_from_nid
Message-ID: <20250226015253.bmyq6bdxhru3srlo@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250225083017.567649-1-rppt@kernel.org>
 <20250225083017.567649-2-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225083017.567649-2-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Feb 25, 2025 at 10:30:16AM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>__init_reserved_page_zone() function finds the zone for pfn and nid and
>performs initialization of a struct page with that zone and nid.
>There is nothing in that function about reserved pages and it is
>misnamed.
>
>Rename it to __init_page_from_nid() to better reflect what the function
>does.
>
>Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

