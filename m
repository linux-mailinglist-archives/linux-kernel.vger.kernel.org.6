Return-Path: <linux-kernel+bounces-284007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2394FBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A951C22314
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2812214A96;
	Tue, 13 Aug 2024 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmMpVOk/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE110A2A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723516370; cv=none; b=apQ2QWamBW/gHvPbVfcwJCD64OHpl0xrdZSh2Ot16VKJa0oP8OQxEPkvjxn8Sa6aWlxslarK9pW1tE7hlPAd8ogrGywHGE2JlqEhnhnqAeWR4LXRGzR4LhCS3yuglpkdvXI0QU7ZVVoQCxjjY/01CuTJNyPZ9sah1152y7tu+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723516370; c=relaxed/simple;
	bh=2fGhES2XDVikE0e3z7hR0aiJ7aDoQxNr65BpcdKpwzg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d++se0vEXU99loOBdRbzV60vPfmmyN5v9RFWOxYi8EByC5J1bU8Vf3GQ4B8BkdiGOy9pz/OliznBcDGfzbNGz/+/Sr/iUqGgD/MvsyglNzza9xwqbrG0WbFwQtmZpx6IXgxAo/Ez4xqAIi3hi3bh50KEYg4doTdP+c3PBFzh9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FmMpVOk/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fed726aefcso27315ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723516368; x=1724121168; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3aVTU6GrN/ua3kcnjeVYWRKEpbsWVFsVzNGy0iKcBv8=;
        b=FmMpVOk/i7v76JQ1GCgP6QxfcNQJEDgJqEIqIE1g4oUXkofyCkD5NR7YI2d+RBFwfO
         hUE6OTStVuINafEv2slpwdAYcKSa3hDqtZIWMkqGb8kBOr3IEJMVpDk/4Wd/Rd2jS5Ai
         5BYipWulk1aFVByXtQMM2VU2DI/FoyhdQ0kM6U0INZIhiqO7v8pvo7f8l/MWCFiO3BEF
         KPq2YRwVbyO16rB25zA151l2mR58Dq2ZU5H2NGIJkef2a9epv2sbpo4+Rh/Ee0K1wKJR
         GhQo4AKOJ1LocXT6+4KhCniMSVCkExGfO0J2O67e8GHZY0vvJh+v58S5LfugVEimrPaI
         dG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723516368; x=1724121168;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aVTU6GrN/ua3kcnjeVYWRKEpbsWVFsVzNGy0iKcBv8=;
        b=uzMjMkd7JII8sjy5jF2Xy2nkUMtaR5DtFFmYHR3Mtm/ZSW0AZwnnhDg5NGzwWv4cKG
         gjtKd6T8UoB/kW9KoeyTeAq7Y+r49vW4JQzi6GYp0n+AEjMpIUETZ7mSS+XQwlewDxAh
         j0UU8JXwvmNne/qUgRz3XnwtHI4g8zLvo5ZotGS3ihO/n7SmxIe/YdHbhPur/HsQz+B4
         WFslRTaruAjyPdUUWscFhr1A98gX55XBO5m8QslnV9K+d95+6QSFvysP3S/6hin0Unad
         vlVNbEaywLwId+aHuNZ01ADkmJoQRxWkSphQdu1gGEotUnf/cy+b+Sk/+DTXk3Y0b1no
         1D/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUg4a7l1lMfQ2022IyVurfXQ0CXDv90hb/DwFXWQlx3cyRf1KhXEWNrBHPTzhN1EQcmhvPeEfHdALVbtozNa/bYsu3h/AqjQnAete1+
X-Gm-Message-State: AOJu0YznOSZsty6GMpFwVay52G+XIttQzuxGHz452bL1e2mU5iRcynqy
	PlRBb+Ox+/oV7Tvm/OLsjf1Gd6ZjwljC8oeipLovhSXpmt3i2y5YX61i1EkSeJk7xyl5gNcc38k
	hbw==
X-Google-Smtp-Source: AGHT+IGbmsOcZ9336++yzzgfTCvS2AAZwxSEOLSWnK40IMew7mh4Ep9JrZkA4ZX4ttxi6rRe03pKcQ==
X-Received: by 2002:a17:902:ce90:b0:1f9:dc74:6c2b with SMTP id d9443c01a7336-201cdc7ad81mr468925ad.29.1723516368068;
        Mon, 12 Aug 2024 19:32:48 -0700 (PDT)
Received: from [2620:0:1008:15:da50:c231:9581:2fe4] ([2620:0:1008:15:da50:c231:9581:2fe4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14ca2fsm3360915ad.93.2024.08.12.19.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 19:32:47 -0700 (PDT)
Date: Mon, 12 Aug 2024 19:32:46 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Danilo Krummrich <dakr@kernel.org>
cc: akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org, 
    iamjoonsoo.kim@lge.com, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm: krealloc: clarify valid usage of __GFP_ZERO
In-Reply-To: <20240812223707.32049-2-dakr@kernel.org>
Message-ID: <c456ebdf-b75e-1f84-c097-f294b954c572@google.com>
References: <20240812223707.32049-1-dakr@kernel.org> <20240812223707.32049-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 13 Aug 2024, Danilo Krummrich wrote:

> Properly document that if __GFP_ZERO logic is requested, callers must
> ensure that, starting with the initial memory allocation, every
> subsequent call to this API for the same memory allocation is flagged
> with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
> honored by this API.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: David Rientjes <rientjes@google.com>

