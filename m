Return-Path: <linux-kernel+bounces-546267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C62A4F88D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868B93A0575
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3C1E5B9E;
	Wed,  5 Mar 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMcjlekW"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328091EEA4E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162700; cv=none; b=gPNV1E3RiVVwbqY9bcscMrN+TItufn9qpheULu4n8RkjRpIlznutiYOjOjdBmB3fmIgEhEdiz6CLfddr5DVMYm5QTrP6FUo+DOf3cPATpwArRltFpcf0BAoH+M+iXkScG2yuDLPfsdGcZ0gqmbZleX8XpgJJkAzu1N38q2unEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162700; c=relaxed/simple;
	bh=prW4yK9dU5e9fujxy/Vv+3OWUNr+IDhYq+KjKGev3zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgUY6VW7gicJfMWxhnPEMQG+iNml/bKrzwUHsqN67Zhn4hL3dpt4uzjgwpkG/balQGJXR0Vtu2Lr48XWANQQiYKEl/2phnfwCAaSYQfoeaf5pM+sRuSK4tUfGgGhGzOhz79AifLFbIlib9XK6bv8nDZHicoRUxP+tsEdwwc4QGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMcjlekW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feae794508so9459619a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741162697; x=1741767497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYXSTZfU8jvWfwROI6VDUWkSch8pirw8SYysFkzl71Y=;
        b=EMcjlekWYj8y1s0JXapO/8NboqpjBMAk//QASsEt6Dsd0XdHoMEWNw2eTOLosuQrxh
         rFVG/ssFdU0LQuB/9QCuGHx4uLrkmxCt+9QssYFtw2y6rKQNdUrRvBF5L4ww2jZVNO6N
         4CDnqJzdniSMm7jrv1Xix4AAczJdeuO7B5iQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162697; x=1741767497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYXSTZfU8jvWfwROI6VDUWkSch8pirw8SYysFkzl71Y=;
        b=eUyRE14KQ1K9mckRdwfmmA4wNIL1zB+e/9ecUUZ3VLuqNyERUDXDh29ZAlmJ3DZGI1
         CfpN6mWcg8c4S+n1TG9z8C7JRn+4N2Aa7w1ja9IswJt4+NTUCVHGt1Ps7YMR2P4FVlxe
         qPg9p2Py2qPF3NafglhgBS7FfXu+/T23wmMvd5Ud/njNRSf5mUoZtRieWZV7sKc6nbkk
         v7/WCXC6AHb1GXkvfKyX21HCpk+6oir2KZEWZRSKSQDxPzgibAAFwK44OY1V65oGeiat
         JXwSqwhKwTVcJpMnUxYjKT3NFYVLkLsOIJV6ANICnRYx/fipSjlcQNHRTmzhm+pkljnD
         zAdA==
X-Forwarded-Encrypted: i=1; AJvYcCUy1659wvOuwGqzHzCrjq78nx8WvLnabGq92FH/PGtKYPTv6/eTuWBp2qwnlulJL+ei/NoXne5jFm9gnyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSobAKMnYvrYZnDsRDmoMOi825X+VrAYGT0qnjM18SMF+7R4K
	5tvaD7nD+b7O2x2oHurHg5Ictv3E2NvrXwDH9urF0N4VIXkPXPJp0HcX64EEMQ==
X-Gm-Gg: ASbGncsBRogL4HOtCVMm5zWBmt9G4qSQrYbJxYMGnlkojRKlX955eS9uTjx2tO0LXXj
	XKCgvc8JikR9tj7m3yIExoz7SxZi2M8Qo923M+354GZdTzeQ1vlfW6c9rJXGv+FfNVpkWIbkgNo
	zqSNs5//6h5m+vE9Z9gtjp4uknh9J8PWXCDPrTtBhIdgyoJmG+BiTZEumL2dNe4/GDv4W2uEK9a
	+BKtK54K2uoXoB7uJvadBTiFJ7Vw6K0pg98Yb0sLa+jmMG2WyCRKby2GtFmD+onCPCd6jWmwoBj
	/Zl7J30btMZcGSJNfP3i21L+qSjVqVSYbuy2hfEn7nRgP/o=
X-Google-Smtp-Source: AGHT+IED2NT/goKWKJHxIaufdCqG12N6ysMMMAj3MMY974Ty3BkD/tjsWdsiukocFdDOhMwMjTQ0gA==
X-Received: by 2002:a17:90a:d644:b0:2f6:d266:f467 with SMTP id 98e67ed59e1d1-2ff49856dccmr3306672a91.34.1741162697515;
        Wed, 05 Mar 2025 00:18:17 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5a4:b795:7bd9:7ab7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e773c7csm749395a91.15.2025.03.05.00.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:18:17 -0800 (PST)
Date: Wed, 5 Mar 2025 17:18:11 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 1/5] mm: zpool: Add interfaces for object
 read/write APIs
Message-ID: <zt5ebs5co7pyjh4sxqjdl47moorpvz2gkm4zo7yhnokdrrwk3p@hedthqhux77n>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-2-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-2-yosry.ahmed@linux.dev>

On (25/03/05 06:11), Yosry Ahmed wrote:
> Zsmalloc introduce new APIs to read/write objects besides mapping them.
> Add the necessary zpool interfaces.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

