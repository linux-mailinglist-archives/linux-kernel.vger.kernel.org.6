Return-Path: <linux-kernel+bounces-312163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1F59692EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81121F231B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7841C62AF;
	Tue,  3 Sep 2024 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zar2ihSN"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF84195
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725338634; cv=none; b=ewbTxycl36KwCwtMdxwiGX8QNTzyADgprjd6ADQ5U7IwCYYoKYpW22FSs77oMOGkxO9rANGAfOtKMGtF5XaWuzw1D6PRwPHmiZsy/0XAQUrOOau+wAY8Pf3tcnQ8V2RCJogSWqXsqK0hOELE1Nlrr+llr8fIlNSL9hnU2Kp+Fpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725338634; c=relaxed/simple;
	bh=MHi/HN5BnrPslmHY/fs8mwRjQXU7/b36taEmXBOkUSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxR7FeSHohnmXdwe/g4DbFMVDJfgMOBawvovDR9WquoN8kPJsqkDOhp4FyzVyJ1Gp1GrWSJrZSwx9hCRp/AVLf5CldtZDIM+grEom9hp83+AkzzMVpytIkF5rdb+ELXJsx0z8JS7BKVc4WyiBbLwKos+ePrzq/3adNWzX4rkZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zar2ihSN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71456acebe8so3729567b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 21:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725338632; x=1725943432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elfWvUxgxU008GtexTVPDvPM5D4zpZXg1ZzCswFsHPM=;
        b=Zar2ihSN4du4KnMjaGBZGKYpowMb8JPVXnFVUO722ng1p1fvxOyP79jKRa6o1AWaEU
         FLOjJSRct0d9z64OkuRUNVmXF1lD9sEcZr2ClqX6A+CAKOZWJ3Wm5pcMyY3sYLFFtG42
         h+zHY/J6fa/iKPUfFPqkC4AXT3SOAkJhGHgI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725338632; x=1725943432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elfWvUxgxU008GtexTVPDvPM5D4zpZXg1ZzCswFsHPM=;
        b=FnAtoLDkg6bK51XCadVvvzRuDoTC7xXPevoSOF1k7nXw5xjLu7MqCU116L3mkq7z3e
         1wVJ/HQrPpRNdY/ZcFAsACCreLWO/EAC+R33MUcJp/4HMJ+1cqcjmzyPMDAlqisWKgdS
         EAN++9RWUcQcK/CnFtzXNaybokpBkMMdt/HvKXHoq5vUkLG1gL/mBmbrolTvRtArq8nA
         c6RAr1lNeUwAeP7lGHXYanRBPLG59Aqvjo42DH7T4xKWolSWWTmA/bX9Z/E1e3Quuxl3
         z4m0DhLRrck0KAyHcf8b2S6tFpZF7vwrm8OS2DmSSsCrDMrC49WXwPYZA/ZWI9xeSbLf
         iEEA==
X-Forwarded-Encrypted: i=1; AJvYcCVKeHPT1qJgotT92e7caf16jMC38hpIrjNjf6A+OJGNPc2LzHKC3/fLVPxI8D+PhWZKUWRdxfdjoBoShiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHS0tir5ZZ0N8uz+f8a+960xny8JCxE4O6GXJciyXFis2yT9CF
	voCDYdOVtDYLPazyz4GgHbrhc0KKjjJKnV52uJ1ORBEyygnvRY5X5iYFdo/7Ig==
X-Google-Smtp-Source: AGHT+IFLKoiPLErQqIwizmdB7eIQcYau9pPc/Sxw4HG+k5ReTw6P+/R7CsubSzTy9JCujzJGWDGkoQ==
X-Received: by 2002:a05:6a20:c6c8:b0:1ce:e725:1723 with SMTP id adf61e73a8af0-1cee7251842mr5626031637.45.1725338632011;
        Mon, 02 Sep 2024 21:43:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:43a1:71e3:7464:e91b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20542d5d1b2sm45598245ad.36.2024.09.02.21.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:43:51 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:43:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Kconfig: fixup zsmalloc configuration
Message-ID: <20240903044347.GE9738@google.com>
References: <20240903040143.1580705-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903040143.1580705-1-senozhatsky@chromium.org>

On (24/09/03 13:00), Sergey Senozhatsky wrote:
> 
> Fixes: Fixes: aa3ba6d72ce0 ...
> 

Developers, developers

