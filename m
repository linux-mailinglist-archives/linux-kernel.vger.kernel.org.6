Return-Path: <linux-kernel+bounces-169080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4E8BC2D1
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C22281713
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CF53E16;
	Sun,  5 May 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGCO7PSN"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4F1E861
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714930047; cv=none; b=QoYYvoxxzW6RlRGDCCy7p/8U6bJ7kjP6nziwvYJqP7GTdl7ADMkyQyrRVNrpSHehQ8KyoQtCK5drTxfj2oiXN1oPZxr1ydnJhzYRutrLM1eH13FFbh1XOqEG8/Zw+7XWcZIhZadxW4BKwHP+Tz794Qkueomeew3EP/Fcog8Xj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714930047; c=relaxed/simple;
	bh=dau9y0NxcImlQYnNlJVgmgdQp9YqjXL457fmpX9xKLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbcRXU03K+Yn4m+PQYgSTG+wZI5Y6xjVRmlpndYAhEylYOxlEmnh3vYw5P1aWIIRjItMLcmb2BAyewvdZY5Tumum175flZUMN1lW4faeeXohKFiap1taIu4joqMtLmtfFotdj2FiafuSvMYdhcNh3NtVKx+u5t7j0hB7WLVyXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGCO7PSN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b370e63d96so353569a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714930045; x=1715534845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUFy8KmArOem9j8tg8LfXSa1N8Y3Bv3LgwKxOUphvbs=;
        b=nGCO7PSN7Ik2wqCKoPGTSpMtRT1jMyt7gwwLUUsHWPor2OhABvxbKLVz0Cu4agCl5t
         OLxbtJg4UNRy1SSlWjHHqyt9c4KkPfRMYHEGfhqdH1Gv1PdCHEWc/ux3CghUGI/WgWWk
         29OENeD5LIpBzYNUtlkCI9H22SJNv0lpJnXHF4ldBfCE+Us6P6V9rzzvHe2sotgZwEq5
         ojeQInnO6J3Kis4BZQrks4y3GSr4tLMAseefCMQRz+AVoDoFjdbyxSJmzoCp+5r5rqWK
         sh8Hyn1+vDqDfl9inaJnH8dzI9vmye8jLkXnLbgIHGUNROcJyBLEXn4NUCpwYoDkqQb8
         oziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714930045; x=1715534845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUFy8KmArOem9j8tg8LfXSa1N8Y3Bv3LgwKxOUphvbs=;
        b=AOur/J+cpOzczMnP/cFZIskXrp+52Qvzuy7BGT0y4cawXsqpwnd4mOyU1LpjgjpyaC
         jdYas6LVDWp8BPmd67jtzus2ERfYJ1HAOTUO5mCVLEm3XLR2zzr5WZmPWC8Tiw8T+Rj8
         ALRXVB8vjYXRkrSoMb4Rxx8QSldDZ6al/+VnyBzETs2NO6ohCGKoG1MBoysYsFiZaIfX
         q7KkUvrjWpradVOpSpSTPxkX0m19FTBFWz4meAmB5xC9XBrAmULDYXsAB6gMNQO9hesu
         Sd+sLrVO6fWt9LcEoUKWLh7FVbm84RvRTzmA1qXZDXXeCdxpD1B7JilovPNMn7p8xzQm
         bXqA==
X-Forwarded-Encrypted: i=1; AJvYcCUfPdJUW19570d9vnD9ICvNKRIFXObCmgP6GA3J9aB3C8g4kgvLiGSe47ZKHqXtRz2hO2IXfgvansr7SWtKVwQmQ0mwCAogx1tCK3B/
X-Gm-Message-State: AOJu0Yx6WUWsIjgxUFELMo096GbWnJNoL344HC6yfLM+oOUBms/ACYf0
	NJvbxMXwH0iHAwoNyQ6yp+JnLxkyFct+M9+/tGOLOgghqTEfHYMyKzHihGq8
X-Google-Smtp-Source: AGHT+IFmYAZ7Ro+Ii8Xm6+BR0O3Ky5URprpT4/tJ5PvFeQlUnPCOrb5RSgsnMrHqtRxt++xmHcinNg==
X-Received: by 2002:a17:902:ce85:b0:1dd:de68:46cf with SMTP id f5-20020a170902ce8500b001ddde6846cfmr10717876plg.6.1714930045067;
        Sun, 05 May 2024 10:27:25 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id kj3-20020a17090306c300b001eccf946a58sm6684318plb.72.2024.05.05.10.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 10:27:24 -0700 (PDT)
Date: Mon, 6 May 2024 01:27:21 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"n26122115@gs.ncku.edu.tw" <n26122115@gs.ncku.edu.tw>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <ZjfBeUJDRMHJKQMX@visitorckw-System-Product-Name>
References: <20240501071647.10228-1-visitorckw@gmail.com>
 <20240501071647.10228-2-visitorckw@gmail.com>
 <44e9ab62e0f543439eb7566a9f134af6@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e9ab62e0f543439eb7566a9f134af6@AcuMS.aculab.com>

Hi David,

On Sun, May 05, 2024 at 01:03:23PM +0000, David Laight wrote:
> From: Kuan-Wei Chiu
> > Sent: 01 May 2024 08:17
> > 
> > Introduce a benchmark test for the fns(). It measures the total time
> > taken by fns() to process 1,000,000 test data generated using
> > get_random_long() for each n in the range [0, BITS_PER_LONG).
> > 
> > example:
> > test_bitops: fns:          5876762553 ns, 64000000 iterations
> 
> Great benchmark....
> 
> The compiler almost certainly optimises it all away.
> 
> Assigning the result of fns() to a file scope (global) volatile int
> should stop that happening.
> 
Thank you for your review. There is an updated v5 of this patch [1],
which has already been accepted and included in Yury's bitmap-for-next
branch of the bitmap tree. In the v5 patch, we have addressed the issue
you mentioned regarding the use of volatile variables to avoid compiler
optimizations.

> And a real test would actually check the result - just in case
> someone does something silly.
>
The fns() function is mainly a helper for find_nth_bit(), so its
accuracy should have been checked in find_nth_bit()'s tests. If you
want unit tests for fns() here too, that sounds good to me, but it
would likely be a separate patch. I'm happy to do it if you'd like.

Regards,
Kuan-Wei

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

