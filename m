Return-Path: <linux-kernel+bounces-547077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F68A502CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F23D188849B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F2923ED52;
	Wed,  5 Mar 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2o77Y1cZ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F5233704
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186108; cv=none; b=ux8Nz2H6b9zpaim2XV8rJEBkahkjHRBgThmKtsIR5DWLMD7Tow/BtGUoLKzwdaX4aVB8SuC/HhY5NBbH2pFx1NkUI6/U3Gr2OxwMT4R5goXBKJeaV2Z9N/Elv/288vskeZodsFr79Lg6Lcq1ryhTQmORc8jCKRl04MfZaIIbAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186108; c=relaxed/simple;
	bh=/wOYm4BQbZwNYztkdoE6SVbVTCnW3Q8MUGgOG7wmEMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPhYRl4WhR3Rt0XqWvpKOL0sKKzvMlrrjJ5lTkCpK+bOMonftfJnezFNsgx6wgh2NB1RXvOxvZYuhfu+MvzZ7cX+KRXquKhZTgXXLb6C/y3jUr496tS39QEzH9XIE367qOMvfLzoMDvQQgXELnzpFjr94rV/u9aH3rvzp+wJ4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2o77Y1cZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471fe5e0a80so61756761cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741186105; x=1741790905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=24D6lXOQ+l56ePiaj5GY2KChhMLcLv5f1xh2j/ejLd0=;
        b=2o77Y1cZ15/w0QAyOdedookEPnBifhEfoSJfur5dvGAbef7yu+bZsSX0gEXeJWcWee
         4uyPh+MrDuaOaLllsdqvLSfq1wnuUd20w9o6VSq+nmz6+usWCsBZiK52MV/AHPD+JhXf
         cCimZsgzMQ/qwaDxVkbVMQozDaejKuobAQ4/YANsIWb9/jd+AP1To8dix1UlPWy2vbPZ
         JGMrRFLOaVFeOvcFPEq1FW1/URJ2R4VpeYJZnbLyJqe14hpkT41DZPRWJhO4N/Clqc2w
         xPSclEvlmzX5k+uczlt45kRLlF0rO3mfbklVK7RtvBJsdNuZGWQHdscGjMqL3SivP6Ev
         +jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186105; x=1741790905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24D6lXOQ+l56ePiaj5GY2KChhMLcLv5f1xh2j/ejLd0=;
        b=GxYnSbS2vhSRevLv2NfkO0GGwKdYLnRUWMe79HYRImUXT3hzP1y1LlGSpU0CMCVZgH
         KIzMD6pMD9waI6zTJ1f8pNEPsLbUd4lg3uRfJ8tQz9cOwvAKAZ4cjXO5DP+6doGoHrty
         rar5OKcSxxq8o+DJxSXpCzBRKRE8RHTOwPSdAqIQazwtrYn6bLwUO9SD23nH67PFDNs4
         XzNdR8cmFxq66yLvthSTEq6xKC/M6XrQ3i1VEP6VbiHPiw5ssP4Q8E/8QVCkT4FR3Nwj
         //N5DVo9SCUi1BCO06Qr4odrNTSjWBOC+50XrdzDFizzEsvxW9GBDd7PHJ8Oxk91eOlG
         +shQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIJiL/sf0cPB2ELx1xf0CZIowUUZflufoTYVY0xEcqfOoNfeyLt4E60iucmKnqh5gXNywwIeUDpx60czA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdo2Gva5f+Mq562Kbgj/+GRduYeYAOlf6dEUajUQyBaBjihkP
	5m5aRT49xJRwhU0902i9H1yfdks9yOiXTPVzq8j47wzFtGKf5b1d/Apg003sjDM=
X-Gm-Gg: ASbGncunEG92YtuF/oCwQzzWuBlH7w9Qni4YAFvtj5QLdeIk5UfV4befMJjDE0knrS7
	hlykbufh7+VL27o8vTUCz47fYFkYmhqcNqSdxL4EuiBbyxOGDnMUQ1jiyOVLA6DbvX3gtiBjsjX
	Q0iZL28OWR8O+7iHW0eZ8im903C3lkqRsTM7u6AnGxVu62ggj8pwukh8453CiNJfpsY+BkQGJFW
	/3kELgBGSq0xRrGoFF05EXwOAhL3i5028NEpZSzPy8E6gZdAvheHtelhljga5co43Ir4OFaXdJj
	k/OSCjIl2IxvwC+MsaVnCLj0Sa0lwRGhVu16d9m/5FU=
X-Google-Smtp-Source: AGHT+IHWvywE6Bow3A7Liu9GCH87L5pfv4FN3FUQ8NcLUcFsOL/tgYX1eDIq8dtWSOkW13iZRkbEGA==
X-Received: by 2002:a05:622a:52:b0:472:2021:b76a with SMTP id d75a77b69052e-4750b23c744mr53858061cf.11.1741186105155;
        Wed, 05 Mar 2025 06:48:25 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474ff3aa7d8sm22803941cf.30.2025.03.05.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:48:24 -0800 (PST)
Date: Wed, 5 Mar 2025 09:48:23 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 2/5] mm: zswap: Use object read/write APIs
 instead of object mapping APIs
Message-ID: <20250305144823.GB185622@cmpxchg.org>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-3-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-3-yosry.ahmed@linux.dev>

On Wed, Mar 05, 2025 at 06:11:30AM +0000, Yosry Ahmed wrote:
> Use the new object read/write APIs instead of mapping APIs.
> 
> On compress side, zpool_obj_write() is more concise and provides exactly
> what zswap needs to write the compressed object to the zpool, instead of
> map->copy->unmap.
> 
> On the decompress side, zpool_obj_read_begin() is sleepable, which
> allows avoiding the memcpy() for zsmalloc and slightly simplifying the
> code by:
> - Avoiding checking if the zpool driver is sleepable, reducing special
>   cases and shrinking the huge comment.
> - Having a single zpool_obj_read_end() call rather than multiple
>   conditional zpool_unmap_handle() calls.
> 
> The !virt_addr_valid() case can be removed in the future if the crypto
> API supports kmap addresses or by using kmap_to_page(), completely
> eliminating the memcpy() path in zswap_decompress(). This a step toward
> that. In that spirit, opportunistically make the comment more specific
> about the kmap case instead of generic non-linear addresses. This is the
> only case that needs to be handled in practice, and the generic comment
> makes it seem like a bigger problem that it actually is.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

