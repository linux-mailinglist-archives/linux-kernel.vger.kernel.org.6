Return-Path: <linux-kernel+bounces-360311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C48A9998F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CEF1F2356D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FED15227;
	Fri, 11 Oct 2024 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp1N9iFM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5F38F5B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609485; cv=none; b=BfOpw/MbniO3gVmHRa7P1ENTak2GyEEb+XoKKeFpKc5Wj4RyLvsXqhEsQo7AB9/fo/LQl68EWFQrk8Ylu2UEksWO8rP4ioYvAVRmOcVtdz/mptcGYcNwc/jWuTjYNkHSK8nBAVUhsgx6yXgDE8EO6NcYH/RmpRyC5qvmqxfOsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609485; c=relaxed/simple;
	bh=TavyVQ5+XzJ0ErkvAo0VTJYkFbyizACRMVf9hV1Eny4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFowPEYV89+3Hy6Hs9FkSAQPBqDpBW1hthemiFyhqCXmsodP62TzCa3aZEOYEgTNc0QTJnD2IL9CydBlIpwpjBjSAeqF+RykjK3Kmd2XMM5+oINkyTpPw2PbLqUkz3AjOBOVfZmP49kpzmruInf78zgA/079WHT/NeqpOq0SOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp1N9iFM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9952ea05c5so243584866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728609482; x=1729214282; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIMYwQ/00GQeXDl91h5GpdGthiy7TyZ0ro4fruqMIHw=;
        b=fp1N9iFMroYQnvn0TtuG3qBj6p0cpkf+PMcn2oodI0ObBDOwBOPFZuYGf4+rrXxLH8
         +rg+nHoXHgkiBFKHPUJrbKJsjFbBg7ZebsTCzOBuF834i+S0CprYuSH6YllLbdDHJu3z
         5IhttlE6CwyQCfA3eKHfPFHUTU4gjhkOFduh3d93bQ3w0QaPXNCIdQIh+lRGy8HwPSYf
         fsIil5WCQD18mWG1rWyfNrh4bUT/DSAarha8vsQaWRrSfP6/x9QpmTGKyXn39DUSREK5
         Dw/E6S4EuOfxOhIvlWWmkBuJaNSl2rhsTVfjAsC9Jxms5wTLacfWTHmysKK+SPZibrQ8
         iEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609482; x=1729214282;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xIMYwQ/00GQeXDl91h5GpdGthiy7TyZ0ro4fruqMIHw=;
        b=NL6NeKPLgUCn9xvd17an4AY/J1rfOEr2kCxyrZchnb9Azh6MliVXn+vyU57EkIypuC
         Q7kiaoWbFiwePGo2J8eAvSr3l9/+XGbWm6SScI1G/u0PBsKcX000gJs9bfwYTinPlkQ3
         SHBMaX9hBsOPJJku+l/8CLkoWf8+HA57pDvQmLGtc2gwLceyOKjJoY0ZxjPPTwKRgkz1
         dlqrQJENfG6Z1DLqI3I9P1tHQH3CtGp6rTvNCivwrYyk5tYxBwTDJgtFkNhifOw9Rr/g
         YG77IsmpHMdIMggT9ngiM1w/QYbetgZoqVJdcDt2hY4BkyJVYP3PCG8qFmpVURrr9mJb
         ZZAg==
X-Forwarded-Encrypted: i=1; AJvYcCXfEHMgvwyZSrZpgNUFWQfnzrZEVZF+6At69SGyRsWTgrnBPiSwPIc84rG4ECccbQgO0yZZAh7Cr2zlTFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycwhEaWoHymmG3/mPXLsf1QV5h/q2ymhBaroqgpTBm9fppVPqW
	pELhrTEvN/hGLbFIAG+lFYKRfimp8XPmoSGnsOjmzemyD+KwmfR/
X-Google-Smtp-Source: AGHT+IFxEbeV8ZR6clYaw5V7xA6JZxSn70qI6icNrFbHpM9Wg97WWgdGJMNj1YK7P8EFe9zyFBN8eQ==
X-Received: by 2002:a17:906:c10f:b0:a86:a41c:29b with SMTP id a640c23a62f3a-a99b9415b08mr52498066b.8.1728609482146;
        Thu, 10 Oct 2024 18:18:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f6655sm152111566b.225.2024.10.10.18.18.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Oct 2024 18:18:00 -0700 (PDT)
Date: Fri, 11 Oct 2024 01:17:59 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/2] maple_tree: Add some alloc node test case
Message-ID: <20241011011759.wbw56sqgmhzjwo4k@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
 <20240626160631.3636515-2-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626160631.3636515-2-Liam.Howlett@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Jun 26, 2024 at 12:06:31PM -0400, Liam R. Howlett wrote:
>From: Jiazi Li <jqqlijiazi@gmail.com>
>
>Add some maple_tree alloc node tese case.
>
>Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
>Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>---
> tools/testing/radix-tree/maple.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>
>diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>index 11f1efdf83f9..b4b5fd9f294d 100644
>--- a/tools/testing/radix-tree/maple.c
>+++ b/tools/testing/radix-tree/maple.c
>@@ -462,6 +462,28 @@ static noinline void __init check_new_node(struct maple_tree *mt)
> 	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
> 	mas_destroy(&mas);
> 
>+	mas.node = MA_ERROR(-ENOMEM);
>+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
>+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */

I am not sure why mas_nomem() is here.

Without this one, we still can trigger the original bug.

>+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
>+	mas.node = MA_ERROR(-ENOMEM);
>+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 2); /* Request */
>+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
>+	mas.status = ma_start;
>+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 2);
>+	mas_destroy(&mas);
>+
>+	mas.node = MA_ERROR(-ENOMEM);
>+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 1); /* Request */
>+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
>+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 1);
>+	mas.node = MA_ERROR(-ENOMEM);
>+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 3 + 2); /* Request */
>+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
>+	mas.status = ma_start;
>+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 3 + 2);
>+	mas_destroy(&mas);
>+
> 	mtree_unlock(mt);
> }
> 
>-- 
>2.43.0
>

-- 
Wei Yang
Help you, Help me

