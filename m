Return-Path: <linux-kernel+bounces-532807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E84A45274
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA93171186
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737C017E45B;
	Wed, 26 Feb 2025 01:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbmoBrey"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F6EBE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534902; cv=none; b=SLetegOjZ4XyHhgussv4TfRRbMmW4vbH9EnfAsVS0hsfZJlJhhFs8Ijz5NEP2EozhaPe1Y5GccnSfa8ld0NAXk3EriJR1N07rVFebp/ivvF4F4BIzHTJRbuFm8IHWjxuPeu9KR/irpJ50BuJwkjBB9pRBN7ktsjkPux15ULJAxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534902; c=relaxed/simple;
	bh=qKfesCctE/K12QuygJLzdrcIJInJArYzz755rZy62bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtiydaSSeAugXisHL6x1noDPjLaw+bfNsKj99Hd2BJHgqk2zSQXUve2ak9BiNP7d5RrD+wMd4/7QWfVqepcc7VwwdGvVh2l0l9E84I3cGMY7+FKcsvoXr1q4gi3RS/K+wstHPbx4ez46TN+w/Du/0CuSsJSwQ4E/st1mn23yU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbmoBrey; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so11302974a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740534899; x=1741139699; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H9GBuQxb7tmxrvUu+zqJxWqL0txTdzcC55QK9WokbI=;
        b=TbmoBreyriCZrV66q8H0pHK2zSD2YLVimWdA3VeQpedAbB/7LQ1xgrJLjkplJMkl07
         0/MaK07zUTdNN569ppgaHlAzC+MxXSgIsli6zuCO3g1c8AISO/CaC8NDjh+SKTyMnL47
         y94w2RZ2bv0q/O69xrqn8GsGS6JfWpmsZJNayUzPleNcXo4+5grSJyN5p3hDa+t9X2i2
         OvHo4zbUcLSwaFrJuhujG2/OjqecHxLb59+bAu8tvpkAtqBJ/dHUcKdUvZeKTEDmXO2V
         BQmQyh8g4I5CER3H9A4BRVTH8r6n/N8T36Ty2rN/S/2x3dFX5y6w8/AcvnBqpdoBnP8d
         6tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740534899; x=1741139699;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9H9GBuQxb7tmxrvUu+zqJxWqL0txTdzcC55QK9WokbI=;
        b=w96jZJrgQNjQRcwr6brV3R9NDLYSB03FHZMBGNyVONaOlnX44WpoTCAaZ2HloA8kFj
         4oDjyBmBbq88QYmt2JFKJbHqTL8BDXc3F09PT5sLB2zchlnJuz7aoae1DARAyAOhZVe7
         UoxRtttfkOT5HpYitiV3H/6OweOdgvdaK9zBROBD7fodHALF+HV4oSCQGREnb+ew5Cv+
         /2xdHhkzgjFRrioaKnDhgjg/27iuBoz+ESMzvqNlhGELXWWy9tDIipoR0nsIsHcCKQzu
         932E5ImzU3fVRfnEFsP/D4lDNm+dRpgPY7u0KZfL4BVnPBCoQnIi6vpmZDx2wjlaTI44
         wrTw==
X-Forwarded-Encrypted: i=1; AJvYcCUb5feIgcHZkUpW72xHBRV8zKADtbSZySZMk2LI6C/qinDmiTGskwrmXJ11O3eXR6nn92xsRb/xJFNaQfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlb2fm8xyfSi5FM4+l+Cd8Fq9LgD9cqzxTfQNtgwAIkiZDlTfk
	NP/uOLbyMfciSnF9SERKaEXt9hNgcrB5tBydZbO9M5MRTCCM6SNE
X-Gm-Gg: ASbGncv/E6xzvmfRyfuIztWai6uQWZgg11UCpAFVI4VAob99Mtvtb0xhHnMWvphXgdo
	dGcLIKF3eY0gucwiYgCxbbslcDNt6KOmQ4z4/QPGdlsd3DdJgrZ7dhzP1Yn/rJqDypadXLG5shM
	p5gp6NHB/oi3I5aJEbz8COjQaL7xbBrEjsVGg0FzbyW2NaCjTateklQ82foi7nF7fBqPgu5msOb
	W+grLkVDBoZPvFpe22cMbNf2zHHh4g4zh59kyoifaReWpucB9C93NrelwF6VOTNT2Ltga4gIWTg
	ea8ZGuOVpYv+SLLFSRqDRQeKxA==
X-Google-Smtp-Source: AGHT+IFwNd4cxnMZQflLC+24HaBcAUcg+8DA7JR1rZIOh4jqFoPNGORJVT/6HXYJ6ygRGy/f3IYDvg==
X-Received: by 2002:a17:907:724f:b0:ab7:bf87:d9de with SMTP id a640c23a62f3a-abc0de146b4mr1817661766b.37.1740534899395;
        Tue, 25 Feb 2025 17:54:59 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d89sm235268066b.151.2025.02.25.17.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2025 17:54:58 -0800 (PST)
Date: Wed, 26 Feb 2025 01:54:58 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Frank van der Linden <fvdl@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 2/2] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <20250226015458.5xo5qlvvyijyuutm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250225083017.567649-1-rppt@kernel.org>
 <20250225083017.567649-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225083017.567649-3-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Feb 25, 2025 at 10:30:17AM +0200, Mike Rapoport wrote:
>From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
>When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
>function performs initialization of a struct page that would have been
>deferred normally.
>
>Rename it to init_deferred_page() to better reflect what the function does.
>
>Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

