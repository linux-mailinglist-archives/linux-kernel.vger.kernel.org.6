Return-Path: <linux-kernel+bounces-546264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2BA4F887
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86F416D878
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CE41F4282;
	Wed,  5 Mar 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fK28Dh7m"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8021F4611
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162645; cv=none; b=d9TBVGSCGXnwo2ZHNBeqnzjJZ8gX4pjnLEB5Sl9qoL39eoX8j9FHcBxtZbeEykJeBd0RzTAG5udH9rDlcp4pGKjMymnWnFH/TIn7fjyJ4mGzCTAdcjj11uXGr1RGWQJtxvOn2I4gzNuU7aO4+zATBz63gtVAc8c1n6iMxDvu54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162645; c=relaxed/simple;
	bh=JJnrVQoYcy2Vl913UQWwg7PIxnpoJlbPZncOQybp9Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLWWVwUv6pfqEPy21ob+h3qy30hR/v7kJX6DxbVGYEM7HfxSYG4/OHZjh4CP1RUNTOMhXWTUSOXzTCtVnAfYjkJxGVtD0sJV0Txv6CdDGQahCWpU9YU3Lu9zF+A+p6I8omCX8CXBzau6w+jnzbyjSexjJSOioG+AEuMHeo+68PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fK28Dh7m; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2235c5818a3so663725ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741162643; x=1741767443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBrYGYkG3/uOX+m8XZikomKIbRAg1AjaPVwOGP9HNdk=;
        b=fK28Dh7mi0P3kEXhfzPErJMqinKb/IDNyTFVqr8HvSoTiy289BlOK/jo0c4BsPOb9O
         LqnFLz9IFE1JByhiK5W33WrgrJX0xYxYxJQT0W8Ju3CaRpIKHPAl9MSc5fcyC1X3x0IP
         rM6SrJnpMWNnfCkw7W3TozjKeP6EHNhLkMWzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162643; x=1741767443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBrYGYkG3/uOX+m8XZikomKIbRAg1AjaPVwOGP9HNdk=;
        b=UGQ0LMtxofLzpWg+u6GwVVDIuu3hlUSyHGUQLlFEGn0UCpjr+2Vg0i9SEiS3VW1r1/
         rCrcxTeHqj3cVCM0GbFPCTSgD5L/yFYkmd8m1vqb8FtDoiA/rv6i/cN0m8LK9nuiq0Sn
         glx6kRww4jzo+x6KRdoB7LmsAXze40du+NWU8l+b0Uv5vntXYv+Ubw9+HVBomZUgo3KG
         3zZhqkJ9vUxS9gOa8pJEzAZ4DqYWYVq6CPvu+kw4FJSyLy5Mt4tsKPqh9f27BgLgAV00
         0v7jVH6ncNSF2a0gV+yHDdRWl2yWdVOqkmHonMgWKAgBYnqkreSlDsFsyGBnhW8701kA
         94aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa242Ikv06nXhZsBFqXlSiLRfuQRRh94kKIUyOUKkY/bbkCTI9Z6Iiyg10gi0Cese1/GLzVHLs8Hg/3FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHA1CsChA4MsCxTqBW7Pb/spwJJVSijwOIwA+BjCR1cuaATp7
	8xzZL9BIL2sAmVr3RCuEc9ZBdcD1wzKEINeQH8KpI3xGAM95Da103+Z1Ass4sg==
X-Gm-Gg: ASbGncs1a+bSjOPnRfDIevW/gmkIcAb/PM2XyQufc/K9It88Hx1CYwsk+Uw802ZDVM4
	s1fFLAvP16wtaesImaOP4dPyiG5eOGwNn5J6vbTGcrIcoszBAONMFip8RVxMvjZ+6gz4jKg0g5N
	DjtyavLXiCbTP9xFLGCD9IplFl2S6dB5Qdt6TmBjiGFHMrT4HmvNTGFtMFiIz5L6aazCTdBUJp/
	XhQ2xaebHPNW2ttEK3U6CtFOyfTIlT+f0/o22h/uM7O9VO1baD/Gr8mVaW7ZRmry3EXmCa0t5bF
	diXydpJ8xL51Xz3XiUjQbDn4CPtX0QPTWkb7jH05wH0Jgj4=
X-Google-Smtp-Source: AGHT+IEZb+ikZ3wZQgwK7eoIYZ9zMOrbk8mbq9FH8fEgmGeKCMEKE+qkETYiZPwF80GgQYRjig0TQA==
X-Received: by 2002:a05:6a00:460e:b0:736:46b4:bef2 with SMTP id d2e1a72fcca58-73682b7d47cmr3390892b3a.6.1741162642739;
        Wed, 05 Mar 2025 00:17:22 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5a4:b795:7bd9:7ab7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003dd31sm12292993b3a.152.2025.03.05.00.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:17:22 -0800 (PST)
Date: Wed, 5 Mar 2025 17:17:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 3/5] mm: zpool: Remove object mapping APIs
Message-ID: <wiboon2ho2vkxsbipc2e4ehhihhhkun7dcyfyycbmfinfxcwg2@n6jbtakq3ncd>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-4-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-4-yosry.ahmed@linux.dev>

On (25/03/05 06:11), Yosry Ahmed wrote:
> zpool_map_handle(), zpool_unmap_handle(), and zpool_can_sleep_mapped()
> are no longer used. Remove them with the underlying driver callbacks.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

