Return-Path: <linux-kernel+bounces-170174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BDA8BD2D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D644C1C2102A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB83D984;
	Mon,  6 May 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q0T9dbxe"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F341C77
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013039; cv=none; b=rKQSzucvbVVIHfjTy5DGcototQh6VRS5Cdz9vi0UeYRx5VyrlxWZaAc9ez+Wlw8aLe6pEJopZ4XRGNyiwDB1wNdsSqkf4mZhNQ3MLX57ZpO5duouLeZP0/lNkW1iPYgQFvankUgBHqTkOOadGaMrZJBFVI9ZywfvEe11aj/0CSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013039; c=relaxed/simple;
	bh=yjPZgSjII1f7LAiUGTCRYweQcTK4hGtwF8kzc8UNAkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvusRNimpqK/4/p8YOdW3dSaMWACxO89gMlcU1wdiU7JkDxe2YZJ5LNfwgT0udDJIJbD1Madw3jXgXRsmdjTVCEC9zigtqtf+c1axbEckdlBzF3Aj0aF5uWHjr/6uUwBw7m13OdHe6jkvpkDdlWJvBgygdyMoqd2QVwPf8lVLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q0T9dbxe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed012c1afbso16113345ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715013037; x=1715617837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5nO/jBC7SnINVskvlvpi2Kyipwpsb5dE+lwh2d00uCo=;
        b=Q0T9dbxe/YYU3cdQgjucnt4nvqyWqprRb8+yu8sSuQ+yhwadfB9Tr27TVfwgaBymSb
         LPRVH39eZU6gq5gLwAB/oItqQg06zzPtdkb+Mm89NBTRZOcYX0nh81EHitYU0oSeH0ri
         MfQKjtVyhVal8LglHWyurg8UC7hn2FUJCxe38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715013037; x=1715617837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nO/jBC7SnINVskvlvpi2Kyipwpsb5dE+lwh2d00uCo=;
        b=jBe2oKcSc5UagvKeAAITeEMZYfxHNYsGP6cXaRm3Z4n6MyEQYIEsn4wHQ3k10tSf8S
         LZO6LEMgU7rWVmtm3iDugV5i10yA2msP0vUgERuXeDpgIxVxpwqNvSPaaOfpPSTq8V+q
         HHuOV6WQ956F52NSqqb+viskrp8Lu8Cx1Jc34lylhvqL7G1SRFfVZjcn+Oyc6E76C5/n
         G4bIisOBMeyLY12oOref43C8vnILKENoUpmmywC2O065ZJ8ly58uDJVPStr2OuGUmtW/
         UisOUKCj2ZUSScMvn4mqGCGefgZnczpdvobeAohHElPZIKzwNwHMdrVNHUL0OKFdSZ93
         Cq0g==
X-Forwarded-Encrypted: i=1; AJvYcCXvIdn0IGTDLPOVTfy0GzMiKl+iobqdwqsqxm4t1cUfbr5gIhI6O2BCRBJ5+rsXMaT/3ftKTcZ0MrkH2MXzeBCDcBFRsfeSCo69c4jm
X-Gm-Message-State: AOJu0YwWP09TXxKv5/EVEYq7yElCarbZJ+QS0/wkdxXG6A2XihPFf0wi
	HGgCfecrTe4wEw1VDcJr6fk/Ob5Y08XdJNKCwfb3pxZTEi6vrPrXVYBGnDqwhA==
X-Google-Smtp-Source: AGHT+IFcP+Jvqd/2a6pLKHSMXDBGF+KAP9XwchiHK23udF18xnHUuv2vvHD/KwYZxvsIqAr/6p7pIw==
X-Received: by 2002:a17:903:1c3:b0:1e0:b60f:5de3 with SMTP id e3-20020a17090301c300b001e0b60f5de3mr244611plh.7.1715013037261;
        Mon, 06 May 2024 09:30:37 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b001e41e968a61sm8414660plh.223.2024.05.06.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:30:36 -0700 (PDT)
Date: Mon, 6 May 2024 09:30:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	syzbot+41bbfdb8d41003d12c0f@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 2/4] mm,page_owner: Fix refcount imbalance
Message-ID: <202405060930.67CDA64@keescook>
References: <20240404070702.2744-1-osalvador@suse.de>
 <20240404070702.2744-3-osalvador@suse.de>
 <202405060754.4405F8402F@keescook>
 <Zjj6KN0GhXbv3VYY@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjj6KN0GhXbv3VYY@localhost.localdomain>

On Mon, May 06, 2024 at 05:41:28PM +0200, Oscar Salvador wrote:
> Yes, but I wanted to get the handle so I can match it with the
> backtrace.

Ah! Yes, that makes sense. Thanks!

-- 
Kees Cook

