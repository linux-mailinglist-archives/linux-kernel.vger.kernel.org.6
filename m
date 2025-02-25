Return-Path: <linux-kernel+bounces-530494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F3CA43423
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B2817A97D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8D318BC2F;
	Tue, 25 Feb 2025 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYKoM9Zj"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE2156677
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457797; cv=none; b=r6EBfDY8bPK8YIHEKAM39pTaDKSsll1diu56okJ/hvQ2uz0ZtlngGrF8jgKVxGW3vbf2+MjeQrT3zF9UsS5PBfhSJ54hMcwjZUU6CAtYZeIDJugXR+sXXLv13ittsVuRLnTx54cvEsxhsQNmrAh5bmu6PwCF6iV2fw7cSFU8pmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457797; c=relaxed/simple;
	bh=3MLJGP6GqWlRWzJ+lkwGmXXGqCvfjR7N+JVGex0eR+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8+2aI+BNeFfqTVZ//AJBGuNRGBYMnUILgETcFyleZp+ganLbf/59rnoIBMoPn/USoQvwwc0ronWXhZBNpVWasqtqlzUFuCXDTGXCpwUgbiGxV09HviMJIP3IwbbofyD4kUWxCjRrsKjghBhnds4qabrj6JhtDdWL/XN22iNdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TYKoM9Zj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d39a5627so78975585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740457795; x=1741062595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zXXlNPUUBPiKZkubtIkuAxkw7YXjV7aLOsj4Haw9B1U=;
        b=TYKoM9ZjvRWlSJjXOiucz+T0n/qelIixOfEuidFIyzDZPtIFaZnLIabUmXxrjA4w+b
         FFYro/ptCrShWksRvZ60pargKQzClDBImb+BmCaF09D2nOu8Hrsjb+JLAOSYyV2SDbHu
         KdFHooXWjRDKEnPL8ApVKbALrXoE3BoL7uu0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740457795; x=1741062595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXXlNPUUBPiKZkubtIkuAxkw7YXjV7aLOsj4Haw9B1U=;
        b=qnEgg2AX6Wg6H6EIODhHYVA3xGtWNKgi5kVDpuFlNrzEXNqcuFc4/PV1MFbjOPcsM6
         UgJlUK/rugDLJPp5PKdk31Vou5IkD7SPxHTN0M5k1VQG0uM1geI0nkNXANQBxiQ+1fc8
         7PsrAAHXkm8WDdt2byRNowcpuLdBWLg0N+dhQekQR2kUseacMQnWZf6q2rByTCXb3aWS
         N9fEHoFRkSFTjrtaCJPRQdCcm4ta+DqvGo9BbhbGxwDVcegYWTlYKWrpeXGQsF8VaZvM
         +rGlN2FtfjGl48CC2C8NozAd1lTb7Rf7NSFI5BWUAmLftSo1ei8dmDKECKj7bCltNG5P
         l+AA==
X-Forwarded-Encrypted: i=1; AJvYcCWTASgnwwnZzLX2PsZxk2Zi61ncD/GAazQb6mBPXFB3dx/8kzEB2m2yLLpAzvadZTvgfQjbqn3XqyBqByI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuRoE6fJbwjyRyDT6AX0vH3YutPyk+q1GzI63ICnsRL206+wG
	faD64j/XMKxiiRTiF8xD0zYQDgGtyeCp3YqgIQBuYIHjK+jF+lSSrCkuMEIJaA==
X-Gm-Gg: ASbGncu1CeFbhMrT4wer8RrViG0pyE9ijdFEiA4bLbWFZf+sOI4tK6T8E/7kDQ+nLAq
	e+WDapbp+z5I9QMrw9vbOig37placisHonEYLWamh08sMkB0T9Y/whZImf8CZ1Tr5Lafr7fsCl1
	l2NfIOyrqwLtbIFnEJZr5fDqN4k6NPi1ujNrsCdHZFu2zcyK6ZnTBRLZyBC6N9QoeEjr2z2XEdj
	6JgPT7XLdpl9uVKUiABw1tfiOFlHrAyB+YEmcRO8q+eB15XsZFHEciaY1VgjZK0xEG+lvgmLq1n
	zZL9/jOvB//M33CRiSdMZ71JUOIXhA==
X-Google-Smtp-Source: AGHT+IHUMtzZMx8wOAQvNxvT5VlJCxbnuMeKFBQKuzIVUYr4CRGvYpaLooVV7rMLU8mEiyK7DpOnPQ==
X-Received: by 2002:a05:6a00:14c1:b0:730:8e97:bd76 with SMTP id d2e1a72fcca58-73426cb143cmr21793645b3a.9.1740457795473;
        Mon, 24 Feb 2025 20:29:55 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e27d:842a:e0d1:29c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f761fsm488585b3a.47.2025.02.24.20.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 20:29:55 -0800 (PST)
Date: Tue, 25 Feb 2025 13:29:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/17] zsmalloc: introduce new object mapping API
Message-ID: <k3sjohhgao4zlu7nqjrwrbajctz65dtzg2aip42vjygpaiyg7r@hjwsb54qbjm2>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-13-senozhatsky@chromium.org>
 <20250224090154.7Xlsipmu@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224090154.7Xlsipmu@linutronix.de>

On (25/02/24 10:01), Sebastian Andrzej Siewior wrote:
> Date: Mon, 24 Feb 2025 10:01:54 +0100
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>,  Yosry Ahmed
>  <yosry.ahmed@linux.dev>, Hillf Danton <hdanton@sina.com>, Kairui Song
>  <ryncsn@gmail.com>,  Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
>  linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 12/17] zsmalloc: introduce new object mapping API
> Message-ID: <20250224090154.7Xlsipmu@linutronix.de>
> 
> On 2025-02-22 07:25:43 [+0900], Sergey Senozhatsky wrote:
> > index 03710d71d022..1288a4120855 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -1377,6 +1377,135 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
> >  }
> >  EXPORT_SYMBOL_GPL(zs_unmap_object);
> >  
> > +void *zs_obj_read_begin(struct zs_pool *pool, unsigned long handle,
> > +			void *local_copy)
> > +{
> > +	struct zspage *zspage;
> > +	struct zpdesc *zpdesc;
> > +	unsigned long obj, off;
> > +	unsigned int obj_idx;
> > +	struct size_class *class;
> > +	void *addr;
> > +
> > +	WARN_ON(in_interrupt());
> 
> This macro is deprecated. Could you come up with something else like
> !in_task() if needed?

This was derived from the current zsmalloc object mapping API

	BUG_ON(in_interrupt());

but converted from BUG_ON() to WARN_ON().  I guess I can drop
entirely tho.

